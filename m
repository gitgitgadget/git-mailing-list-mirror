From: Johan Herland <johan@herland.net>
Subject: Re: git notes: notes
Date: Thu, 21 Jan 2010 03:54:22 +0100
Message-ID: <201001210354.22756.johan@herland.net>
References: <20100120050343.GA12860@gnu.kitenet.net>
 <alpine.DEB.1.00.1001202354070.4985@pacific.mpi-cbg.de>
 <7vljfsz7vx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Joey Hess <joey@kitenet.net>, johan@herland.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 21 03:55:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXnCF-0006zz-92
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 03:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903Ab0AUCy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 21:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752214Ab0AUCyZ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 21:54:25 -0500
Received: from smtp.getmail.no ([84.208.15.66]:45859 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751433Ab0AUCyZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2010 21:54:25 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWK00G90TEOMY90@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 21 Jan 2010 03:54:24 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWK00JSPTENCQ10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 21 Jan 2010 03:54:24 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.21.24530
User-Agent: KMail/1.12.4 (Linux/2.6.32-ARCH; KDE/4.3.4; x86_64; ; )
In-reply-to: <7vljfsz7vx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137621>

On Thursday 21 January 2010, Junio C Hamano wrote:
> [...]

I just want to note that I've read the whole thread (up to here), and I 
agree with pretty much everything that's been said so far:

- We should be more conservative about showing notes, especially in contexts 
that may be used by scripts. Disabling notes by default when --pretty/--
format is in use, sounds like a good idea. So does adding a --show-notes 
option for overriding the default.

- The format-patch bug is grave and unexcusable and must be fixed. Michael: 
Thanks for discovering.

- I'd still like to keep notes as part of the default output from git log 
and friends (when NOT using --pretty/--format). Only notes from a single 
notes ref (typically the default "refs/notes/commits") should be shown.

- Re. Peff's worry that "git log" will fill up with random bisection cruft: 
Any notes that are related to bisection (or any other special use case for 
notes) should live on its own notes ref (typically "refs/notes/bisect" for 
bisection cruft) that is not used by "git log" (unless you explicitly say so 
through $GIT_NOTES_REF or core.notesRef).

- Re. Junio's worry that he will become the janitor for these patches. 
Please don't. As long as the patch series is in 'pu', it is MY 
responsibility to address issues and organize any additional patches on top 
of the series. Feel free to ignore all additional patches, and wait for an 
updated series from my end.

- Yes, there should be more tests verifying that there is no negative impact 
on git log and friends. Docs must be updated as well, where needed.


Unfortunately I don't have the time to work on this right now, but I'll do 
my best to get around to it as soon as possible (at least by the end of the 
coming weekend).


Again, thanks for your involvement. It is really appreciated.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
