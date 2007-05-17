From: Petr Baudis <pasky@suse.cz>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Thu, 17 May 2007 18:10:02 +0200
Message-ID: <20070517161002.GR4489@pasky.or.cz>
References: <11793556363795-git-send-email-junkio@cox.net> <11793556371774-git-send-email-junkio@cox.net> <200705170539.11402.andyparkins@gmail.com> <7v4pmcauu3.fsf@assigned-by-dhcp.cox.net> <20070517110225.GA3334@steel.home> <20070517124622.GP4489@pasky.or.cz> <20070517134649.GA20853@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 17 18:10:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoiYO-0002fw-Ii
	for gcvg-git@gmane.org; Thu, 17 May 2007 18:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665AbXEQQKF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 12:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755370AbXEQQKF
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 12:10:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59573 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754665AbXEQQKE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 12:10:04 -0400
Received: (qmail 29139 invoked by uid 2001); 17 May 2007 18:10:02 +0200
Content-Disposition: inline
In-Reply-To: <20070517134649.GA20853@coredump.intra.peff.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47535>

On Thu, May 17, 2007 at 03:46:49PM CEST, Jeff King wrote:
> On Thu, May 17, 2007 at 02:46:22PM +0200, Petr Baudis wrote:
> 
> > > why can't I just have _repo_ configuration:
> > > 
> > >  	[subproject "kernel/"]
> > >          	URL = http://www.kernel.org/pub/linux-2.6.git
> > > ?
> > > It can be first-time cloned from the upstream, but it stays after
> > > people change it to suit their systems. They can depend on it not to
> > > be broken by upstream.
> > 
> > Because kernel/ can get removed, moved around, or point at entirely
> > *different* projects over time and branches - kernel/ can switch from
> > linux-2.4 to linux-2.6, libc/ can switch between glibc and uClibc, ...
> 
> I think we clearly need a 2-level system: a tracked pointer to the repo,
> with an optional local override.
> 
> However, I don't quite like Junio's idea of using the URL as a key,
> since it is intended to change. IOW, if I am overriding your URL via
> .git/config, if you change your URL then my config is now broken.
> 
> Instead, why not:
>   1. url location is supplied in configuration as
>      [subproject "kernel/"]
>        url = git://git.kernel.org/pub/linux-2.4.git
>   2. .gitmodules is simply read as a lower-priority version of
>      configuration

But, did you read what you actually quoted? Because I can only repeat my
argument in the face of (1), and you didn't seem to dispute any part of
it at all.

"kernel/" has _no_ meaning. Only a (treeid,"kernel/") pair has meaning,
nothing less - a particular tree contains a submodule in given subtree.
Different trees can have different submodules in different subtrees.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
