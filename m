From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] whitespace: fix initial-indent checking
Date: Sun, 16 Dec 2007 11:43:44 -0800
Message-ID: <7v3au2l91r.fsf@gitster.siamese.dyndns.org>
References: <7vodd4fb2f.fsf@gitster.siamese.dyndns.org>
	<1197776919-16121-1-git-send-email-bfields@citi.umich.edu>
	<1197776919-16121-2-git-send-email-bfields@citi.umich.edu>
	<1197776919-16121-3-git-send-email-bfields@citi.umich.edu>
	<1197776919-16121-4-git-send-email-bfields@citi.umich.edu>
	<1197776919-16121-5-git-send-email-bfields@citi.umich.edu>
	<fk2pua$b4p$1@ger.gmane.org>
	<25FDB05F-3E85-4E08-90BE-1BE468C07805@wincent.com>
	<20071216162637.GA3934@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Sun Dec 16 20:44:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3zPZ-00078u-Vu
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 20:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754728AbXLPTn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 14:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754701AbXLPTn5
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 14:43:57 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55443 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbXLPTn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 14:43:56 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2558F360B;
	Sun, 16 Dec 2007 14:43:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 97A3F3607;
	Sun, 16 Dec 2007 14:43:46 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68481>

"J. Bruce Fields" <bfields@fieldses.org> writes:

>>> I prefer to use tabs for indent, but _spaces_ for align. While previous,
>>> less strict version of check catches indent using spaces, this one also
>>> catches _align_ using spaces.
>
> No, the previous version didn't work for the align-with-spaces case
> either.

When indent-with-non-tab is in effect, it should tabify spaces in indent
as much as possible.  The error definition is deliberately incompatible
with "align with spaces" policy.

The reason I made indent-with-non-tab configurable was to cater to these
people.  They can turn it off if they do not want it.
