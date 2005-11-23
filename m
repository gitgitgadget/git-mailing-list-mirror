From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] git-mv is not able to handle big directories
Date: Wed, 23 Nov 2005 08:56:04 -0500
Message-ID: <20051123135604.GB16995@mythryan2.michonline.com>
References: <200511231141.57683.lan@ac-sw.com> <7voe4b7uw7.fsf@assigned-by-dhcp.cox.net> <7vk6ez7u1y.fsf@assigned-by-dhcp.cox.net> <867jazre78.fsf@blue.stonehenge.com> <7vu0e369p4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 14:58:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eev6k-0007kA-3S
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 14:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbVKWN4M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 08:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbVKWN4L
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 08:56:11 -0500
Received: from mail.autoweb.net ([198.172.237.26]:39296 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1750799AbVKWN4K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 08:56:10 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1Eev6T-0007SB-08; Wed, 23 Nov 2005 08:56:06 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1Eev6S-00025o-00; Wed, 23 Nov 2005 08:56:04 -0500
Received: from ryan by mythical with local (Exim 4.54)
	id 1Eev6S-0001Ra-Hm; Wed, 23 Nov 2005 08:56:04 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vu0e369p4.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12621>

On Wed, Nov 23, 2005 at 12:37:59AM -0800, Junio C Hamano wrote:
> merlyn@stonehenge.com (Randal L. Schwartz) writes:
> 
> >>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
> >
> > Junio>             open my $oh, qw(|- git-update-index -z --stdin)
> > Junio>                     or die "oops";
> >
> > This is Perl 5.6 or later.  Breaks on Perl 5.5, which is still in use
> > in some places.
> 
> I should have known better than posting Perl code to the list
> where a real guru is lurking and making afool of myself ;-).
> 
> Thanks for the advice.  How much do we care about 5.5?  IOW, is
> "in some places" wide enough to matter?
> 
> git-cvsimport, git-svnimport and git-shortlog share the same
> problem (svnimport declares that it wants 5.8).  perl58delta.pod
> does say list form of open for pipes is new in that version.  So
> what I wrote above requires 5.8 or better, perhaps?  cvsimport
> uses that same structure.  That is doubly Ouch.

No, you're not using the list form for pipes.  I use that in
git-graft-ripple:

	open(P,"-|","git-rev-list","--parents","--merge-order",$range)

For the kernel, requiring 5.8 shouldn't be a big issue. I suspect it's
really only the commercial Unixes where requiring 5.8 would be annoying.

Randal, is my guess even remotely accurate?

-- 

Ryan Anderson
  sometimes Pug Majere
