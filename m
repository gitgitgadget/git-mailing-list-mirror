From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Corrupted (?) commit 6e6db85e confusing gitk
Date: Sun, 02 Dec 2007 14:36:10 -0800
Message-ID: <7vbq98u3l1.fsf@gitster.siamese.dyndns.org>
References: <5F1A20CC-7427-4E7A-AB95-E89C9FA17951@zib.de>
	<7vir3hx70y.fsf@gitster.siamese.dyndns.org>
	<20071202193918.GQ6212@lavos.net>
	<Pine.LNX.4.64.0712022132060.27959@racer.site>
	<alpine.LFD.0.9999.0712021348020.8458@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Brian Downing <bdowning@lavos.net>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Dec 02 23:36:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyxQV-0005tT-Ex
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 23:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbXLBWgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 17:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbXLBWgT
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 17:36:19 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:47338 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbXLBWgS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 17:36:18 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8C0AA2FA;
	Sun,  2 Dec 2007 17:36:39 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 089C59C346;
	Sun,  2 Dec 2007 17:36:33 -0500 (EST)
In-Reply-To: <alpine.LFD.0.9999.0712021348020.8458@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 2 Dec 2007 13:49:40 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66829>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 2 Dec 2007, Johannes Schindelin wrote:
>> 
>> Darn.  But when can "GIT_AUTHOR_DATE" be set to the empty string?  I mean, 
>> I understand unset'ing it.  But setting it to ""?
>
> Well, regardless, I think we should make sure that git-commit-tree never 
> writes out an invalid commit - no matter *how* insane input it gets. 
> Making it complain loudly (with a 'die("Oh, no, you don't!")') would be a 
> good idea.

FWIW, fmt_ident() records the current time (before the kh/commit series,
and after the fix I sent on top of kh/commit series), which may be a
reasonable alternative.
