From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] apply --unidiff-zero: loosen sanity checks for --unidiff=0 patches
Date: Sun, 17 Sep 2006 01:49:44 -0700
Message-ID: <7vac4y7u8n.fsf@assigned-by-dhcp.cox.net>
References: <20060915132225.12040.qmail@a0896f98af57b2.315fe32.mid.smarden.org>
	<7vzmcz6mrq.fsf@assigned-by-dhcp.cox.net>
	<7vsliq7vqr.fsf_-_@assigned-by-dhcp.cox.net>
	<eej12j$36t$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 10:50:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOsM4-0003N7-Es
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 10:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWIQItq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 17 Sep 2006 04:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWIQItq
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 04:49:46 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:52677 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932292AbWIQItp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Sep 2006 04:49:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060917084944.DBCU22977.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Sun, 17 Sep 2006 04:49:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PLpY1V0091kojtg0000000
	Sun, 17 Sep 2006 04:49:32 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eej12j$36t$2@sea.gmane.org> (Jakub Narebski's message of "Sun,
	17 Sep 2006 10:30:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27167>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> This adds a new flag, --unified-zero, to allow bypassing these
>> checks. =A0If you are in control of the patch generation process,
>> you should not use --unified=3D0 patch and fix it up with this
>> flag; rather you should try work with a patch with context. =A0But
>> if all you have to work with is a patch without context, this
>> flag may come handy as the last resort.
>
> Doesn't -C0 option to git-apply bypass those checks?

Only the head/tail anchor check, but not the creation/deletion
check.

Also -CNUM's meaning is "you are allowed to reduce context down
to only this many lines if you need to (but you do not have to
if you can find the right match with context recorded in the
patch)" not "what I am feeding you is a context-free patch so
loosen sanity checks", so it does not make much sense to
overload the flag with such a new meaning (if that is what you
are implying, that is).
