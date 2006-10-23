From: Petr Baudis <pasky@suse.cz>
Subject: Re: prune/prune-packed
Date: Mon, 23 Oct 2006 20:39:55 +0200
Message-ID: <20061023183955.GR20017@pasky.or.cz>
References: <20061022035919.GA4420@fieldses.org> <7vy7r954k7.fsf@assigned-by-dhcp.cox.net> <20061022231422.GA9375@fieldses.org> <20061023005336.GA12932@fieldses.org> <453C1A35.70504@gmail.com> <7vvembzp6y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitzilla@gmail.com, "J. Bruce Fields" <bfields@fieldses.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 20:40:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc4ih-00056X-8j
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 20:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbWJWSj6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 14:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbWJWSj6
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 14:39:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56002 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965011AbWJWSj5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 14:39:57 -0400
Received: (qmail 7117 invoked by uid 2001); 23 Oct 2006 20:39:55 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vvembzp6y.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29857>

Dear diary, on Mon, Oct 23, 2006 at 05:27:49AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> A Large Angry SCM <gitzilla@gmail.com> writes:
> 
> > J. Bruce Fields wrote:
> >> Junio C Hamano <junkio@cox.net> writes:
> >>> I am considering the following to address irritation some people
> >>> (including me, actually) are experiencing with this change when
> >>> viewing a small (or no) diff.  Any objections?
> >>
> >> So for me, if I run
> >>
> >> 	less -FRS file
> >>
> >> where "file" is less than a page, I see nothing happen whatsoever.
> >>
> >> At a guess, maybe it's clearing the screen, displaying the file, the
> >> restoring, all before I see anything happen?
> >
> > Junio,
> >
> > How about reverting this change? From the reports here, is causing
> > problems on a number of different distributions.
> 
> Hmmm.  I thought I was using gnome-terminal as well, but I
> always work in screen and did not see this problem.
> 
> Sorry, but you are right and Linus is more right.  How about
> doing FRSX.

I should like that solution more since I hate the alternate screen, but
I actually don't, since it should be left at the user's will whether to
use the alternate screen or not, and Git shouldn't change the default on
whim. Git is trying to be too smart here, and I think it's more annoying
to override what the user is used to than having to by default press q.

Yes, the user can always override Git by setting own $LESS, but that
means another explicit action at the user's side is required and they
don't receive any further cool flags we might stick in there later.
(BTW, I don't think this is right either. In Cogito, I do

	LESS="$myflags$LESS"

unless $CG_LESS is set, in which case I do

	LESS="$CG_LESS".

So people like Jens who have LESS set still get sensible behaviour from
Cogito _and_ they don't loose the ability to override Cogito's less
flags.)

BTW, I think not seeing output of paged commands is a major problem,
this should probably warrant another bugfix release.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
