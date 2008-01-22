From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use FIX_UTF8_MAC to enable conversion from UTF8-MAC to UTF8
Date: Mon, 21 Jan 2008 23:54:13 -0800
Message-ID: <7vmyqythwa.fsf@gitster.siamese.dyndns.org>
References: <fn1nl6$ek5$1@ger.gmane.org> <fn1pj9$kkg$1@ger.gmane.org>
	<fn1ptk$ljj$1@ger.gmane.org> <fn1q6b$ljj$2@ger.gmane.org>
	<7vve5nzdqx.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801212025050.2957@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801212304460.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Junker <mjscod@web.de>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 08:54:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHDy7-0007UV-Jv
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 08:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920AbYAVHyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 02:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753337AbYAVHyV
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 02:54:21 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59872 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920AbYAVHyV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 02:54:21 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BB0A4136C;
	Tue, 22 Jan 2008 02:54:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FFDE136B;
	Tue, 22 Jan 2008 02:54:16 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801212304460.2957@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 21 Jan 2008 23:16:54 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71427>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Again, as an OSX-only workaround it's probably acceptable, and perhaps 
> that's the only thing to look at right now. But it does strike me as a 
> design mistake to do it at that level.

Yes, we would need a reverse conversion when going from index to
work tree, including entry.c, in order to be able to emulate
this on filesystems that do not take "equivalent" but different
names on open(), creat() and lstat().
