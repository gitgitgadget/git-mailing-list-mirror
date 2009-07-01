From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Don't clean any untracked submodule's .git dir by default in git-clean
Date: Tue, 30 Jun 2009 19:13:22 -0700
Message-ID: <7vskhhxi9p.fsf@alter.siamese.dyndns.org>
References: <1246327845-22718-1-git-send-email-jason.k.holden@gmail.com>
	<1246327845-22718-2-git-send-email-jason.k.holden@gmail.com>
	<1246327845-22718-3-git-send-email-jason.k.holden@gmail.com>
	<4A49B36D.2080103@viscovery.net>
	<7vljna9nuz.fsf@alter.siamese.dyndns.org>
	<7vws6t490z.fsf@alter.siamese.dyndns.org> <4A4ABF61.7040009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jason Holden <jason.k.holden@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 04:13:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLpKG-0002Yz-Fd
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 04:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754016AbZGACNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 22:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752863AbZGACNV
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 22:13:21 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:54304 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754428AbZGACNU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 22:13:20 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090701021322.JUJC18948.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 30 Jun 2009 22:13:22 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id ASDN1c00C4aMwMQ03SDN9y; Tue, 30 Jun 2009 22:13:22 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=9cvXoET4qPUA:10 a=pGLkceISAAAA:8
 a=gCCe3iepReww4oEE4lEA:9 a=efbv_WRkwH8rTiW5RIYA:7
 a=KMQNTLXDU88uz0LJgaE4qZ_EhYIA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <4A4ABF61.7040009@gmail.com> (Jason Holden's message of "Tue\, 30 Jun 2009 21\:44\:01 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122562>

Jason Holden <jason.k.holden@gmail.com> writes:

> If this becomes the final fix, don't forget to update
> Documentation/git-clean.txt

That's a note to yourself and other people who are intereseted ;-).

My patch was, as with many other patches I send to this list, no more than
"if you wanted to do that, you would do it like this.".  It definitely
wasn't meant to be the final shape of the resolution of this issue.

This is not my itch with a particularly high priority, and I do not have
infinite amount of time right now to scratch it.

There shouldn't be any output from dir.[ch] recursive removal function
(unless it is reporting an error).  Instead, the caller should say "removed"
only after it actually removed it, and it needs some reorganizing of the
call sequence.

I think the loop in builtin_clean.c should first be refactored into
smaller helper functions before any of these changes happen.  It has got
unmanageably large and ugly over time (or perhaps it was large and ugly
from the beginning. I do not even remember who did it initially).  

Anyway, enjoy your vacation.
