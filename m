From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] whitespace: fix initial-indent checking
Date: Sun, 16 Dec 2007 12:40:59 -0800
Message-ID: <7vodcqjrtw.fsf@gitster.siamese.dyndns.org>
References: <7vodd4fb2f.fsf@gitster.siamese.dyndns.org>
	<1197776919-16121-1-git-send-email-bfields@citi.umich.edu>
	<1197776919-16121-2-git-send-email-bfields@citi.umich.edu>
	<1197776919-16121-3-git-send-email-bfields@citi.umich.edu>
	<1197776919-16121-4-git-send-email-bfields@citi.umich.edu>
	<1197776919-16121-5-git-send-email-bfields@citi.umich.edu>
	<20071216035440.GM14377@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sun Dec 16 21:41:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J40It-0007m1-PH
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 21:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755294AbXLPUlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 15:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755014AbXLPUlQ
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 15:41:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58270 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbXLPUlP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 15:41:15 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E90774A01;
	Sun, 16 Dec 2007 15:41:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F89C4A00;
	Sun, 16 Dec 2007 15:41:08 -0500 (EST)
In-Reply-To: <20071216035440.GM14377@fieldses.org> (J. Bruce Fields's message
	of "Sat, 15 Dec 2007 22:54:40 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68486>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> One slightly weird thing about this: I'd expect indent-with-non-tab to
> catch any sequence of 8 or more contiguous spaces, not just such
> sequences at the end of the indent.  This doesn't quite do that.

+-------+-------+-------+-------+-------+-------+-------+-------+-------+
Personally, I would hate that.  That would muck with two spaces I
deliberately typed after the full stop before this sentence).  Please
don't.

Emacs "M-x tabify" tends to do this and I found it unsuitable especially
for code (I am not complaining, it probably was invented for other
purposes and not reformatting code):

If you have original (the run of '>>..>>' is a single tab, '.' is a SP)

        dcba....123
        fedcba..123
        gfedcba.123

and "tabify" the region, you would get:

        dcba>>>>123
        fedcba>>123
        gfedcba.123

That is fine if you are shooting for minimum number of bytes, but often
it is not what you want in your code, especially when the part that
conains the whitespace "..cba 123.." is inside a string constant.
