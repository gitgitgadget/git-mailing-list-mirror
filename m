From: Petr Baudis <pasky@suse.cz>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Thu, 17 May 2007 14:46:22 +0200
Message-ID: <20070517124622.GP4489@pasky.or.cz>
References: <11793556363795-git-send-email-junkio@cox.net> <11793556371774-git-send-email-junkio@cox.net> <200705170539.11402.andyparkins@gmail.com> <7v4pmcauu3.fsf@assigned-by-dhcp.cox.net> <20070517110225.GA3334@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 17 14:46:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HofNI-0005RE-S4
	for gcvg-git@gmane.org; Thu, 17 May 2007 14:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755744AbXEQMqZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 08:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755603AbXEQMqZ
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 08:46:25 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58351 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756979AbXEQMqY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 08:46:24 -0400
Received: (qmail 7247 invoked by uid 2001); 17 May 2007 14:46:22 +0200
Content-Disposition: inline
In-Reply-To: <20070517110225.GA3334@steel.home>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47517>

On Thu, May 17, 2007 at 01:02:25PM CEST, Alex Riesen wrote:
> why can't I just have _repo_ configuration:
> 
>  	[subproject "kernel/"]
>          	URL = http://www.kernel.org/pub/linux-2.6.git
> ?
> It can be first-time cloned from the upstream, but it stays after
> people change it to suit their systems. They can depend on it not to
> be broken by upstream.

Because kernel/ can get removed, moved around, or point at entirely
*different* projects over time and branches - kernel/ can switch from
linux-2.4 to linux-2.6, libc/ can switch between glibc and uClibc, ...

> Can I suggest a part of repo configuration to be clonable? So that
> there is a something in .git/config.dist, which is _cloned_ with
> git-clone. The obviuos thing to put there would be subproject
> configuration, and maybe there will be something else in the future
> (I'd think of description, which is a separate file now, and as for
> now, the only way to get this description is to use gitweb or ssh).
> git-ls-remote could be made to show this "remote-accessible"
> configuration, in case someone have to update/compare local copy of
> this config.

This is troublesome because then you will also need a way to update the
configuration in the future, otherwise you will run into some
embarassing situations, and since we don't even support any motds while
fetching, when something *needs* to be changed you don't even have a
good way to tell your users. (Actually, I've been thinking about adding
motd support to the fetchers. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
