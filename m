From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-mv is not able to handle big directories
Date: Wed, 23 Nov 2005 00:37:59 -0800
Message-ID: <7vu0e369p4.fsf@assigned-by-dhcp.cox.net>
References: <200511231141.57683.lan@ac-sw.com>
	<7voe4b7uw7.fsf@assigned-by-dhcp.cox.net>
	<7vk6ez7u1y.fsf@assigned-by-dhcp.cox.net>
	<867jazre78.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 09:40:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eeq8y-0005uF-AU
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 09:38:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030365AbVKWIiG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 03:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030366AbVKWIiG
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 03:38:06 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:3827 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1030365AbVKWIiC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 03:38:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051123083726.MKNQ20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 23 Nov 2005 03:37:26 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <867jazre78.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "22 Nov 2005 23:55:07 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12613>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
>
> Junio>             open my $oh, qw(|- git-update-index -z --stdin)
> Junio>                     or die "oops";
>
> This is Perl 5.6 or later.  Breaks on Perl 5.5, which is still in use
> in some places.

I should have known better than posting Perl code to the list
where a real guru is lurking and making afool of myself ;-).

Thanks for the advice.  How much do we care about 5.5?  IOW, is
"in some places" wide enough to matter?

git-cvsimport, git-svnimport and git-shortlog share the same
problem (svnimport declares that it wants 5.8).  perl58delta.pod
does say list form of open for pipes is new in that version.  So
what I wrote above requires 5.8 or better, perhaps?  cvsimport
uses that same structure.  That is doubly Ouch.
