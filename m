From: Petr Baudis <pasky@suse.cz>
Subject: Re: http protocol, cloning git.git, fails (too many open files)
Date: Mon, 14 Nov 2005 02:09:40 +0100
Message-ID: <20051114010940.GQ30496@pasky.or.cz>
References: <86acg9ijwa.fsf@blue.stonehenge.com> <7vmzk9e9km.fsf@assigned-by-dhcp.cox.net> <1131926492.14637.5.camel@k9.localnet> <Pine.LNX.4.64.0511131625490.32662@x2.ybpnyarg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 02:10:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbSr0-0003f5-Lx
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 02:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbVKNBJr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 20:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVKNBJr
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 20:09:47 -0500
Received: from w241.dkm.cz ([62.24.88.241]:36777 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750815AbVKNBJr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Nov 2005 20:09:47 -0500
Received: (qmail 15567 invoked by uid 2001); 14 Nov 2005 02:09:40 +0100
To: wa1ter@myrealbox.com
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511131625490.32662@x2.ybpnyarg>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11760>

Dear diary, on Mon, Nov 14, 2005 at 01:42:33AM CET, I got a letter
where wa1ter@myrealbox.com said that...
> 
> 
> On Sun, 13 Nov 2005, walt wrote:
> 
> > On Sat, 2005-11-12 at 15:21 -0800, Junio C Hamano wrote:
> > [...]
> > > However, one thing puzzles me.  I just tried to reproduce it by
> > > doing this:
> > >
> > > 	$ rm -fr git-http
> > >         $ ulimit -n 16
> > >         $ git clone http://www.kernel.org/pub/scm/git/git.git git-http
> > >
> > > and it did not fail on my Linux box...
> 
> > I've never seen it on Linux...
> 
> Aha!  I do indeed see it on linux with ulimit -n 64 but *only* when I
> do the clone with cg-clone.  When I use 'git clone' it works just fine.
> 
> So, what does cogito do differently that accounts for more open files?

Cogito uses the same logic and underlying GIT fetching commands for
cloning as well as for fetching, while git-clone uses some custom logic
for cloning ("dumb http clone"). (In fact, is there a point in carrying
it further now that git-http-fetch got as smart as it got? You'll have
less code, and more importantly see bugs in the fetchers otherwise only
I see with Cogito. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
