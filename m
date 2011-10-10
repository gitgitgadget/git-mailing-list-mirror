From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] Teach merge the '[-e|--edit]' option
Date: Mon, 10 Oct 2011 09:50:25 +0200
Message-ID: <vpqty7h2sla.fsf@bauges.imag.fr>
References: <7vk48gwvyd.fsf@alter.siamese.dyndns.org>
	<1318023997-54810-1-git-send-email-jaysoffian@gmail.com>
	<7vfwj4tplw.fsf@alter.siamese.dyndns.org>
	<CAG+J_Dzrk5x0+JRC8EbrAxjZE+hD+-5mp+H=F=M8Su2WosPfmg@mail.gmail.com>
	<7v8votpx4n.fsf@alter.siamese.dyndns.org>
	<7vr52lo1m3.fsf@alter.siamese.dyndns.org>
	<m3ehyl1g5v.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jay Soffian <jaysoffian@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 10 09:50:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDAdD-0000nZ-AE
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 09:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307Ab1JJHue (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 03:50:34 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39075 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751027Ab1JJHue (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 03:50:34 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p9A7lmmQ018782
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 10 Oct 2011 09:47:48 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RDAd0-0006IE-77; Mon, 10 Oct 2011 09:50:26 +0200
In-Reply-To: <m3ehyl1g5v.fsf@localhost.localdomain> (Jakub Narebski's message
	of "Mon, 10 Oct 2011 00:05:02 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 10 Oct 2011 09:47:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p9A7lmmQ018782
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1318837671.98701@03q1n98+aU9cpDl3b9T04Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183230>

Jakub Narebski <jnareb@gmail.com> writes:

> Yet another issue is if we should blindly trust automatic merge resolution.
> It is considered a good practice by some to always check (e.g. by compiling
> and possibly also running tests) the result of merge, whether it required
> merge conflict resolution or not.

I agree that trusting merge blindly is bad, but still, if there are no
merge conflicts, and if the merge is broken, I'd prefer commiting a
fixup patch right after the merge than fixing it before committing.
Because if the merge needs a fix, it usually means something tricky that
deserves its own patch and commit message. At worse, one can still reset
--merge HEAD^.

One other issue with not committing automatically is for beginners. I
see that all the time when the merge has conflicts. newbies fix the
conflicts, and when they're done: "fine, conflicts solved, let's
continue hacking" without committing. The resulting history is totally
messy because it mixes merges and actual edits. For these users, not
committing automatically in the absence of conflict would make the
situation even worse.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
