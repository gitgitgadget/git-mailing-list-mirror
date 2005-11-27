From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Cogito documentation updates
Date: Sun, 27 Nov 2005 16:28:27 +0100
Message-ID: <20051127152827.GJ22159@pasky.or.cz>
References: <20051120101112.GA2302@diku.dk> <86veyn49gc.fsf@blue.stonehenge.com> <20051123121651.GB19302@diku.dk> <8664qjph7d.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0511230923131.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 16:29:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgOSc-0004yN-21
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 16:29:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbVK0P2M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 10:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbVK0P2M
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 10:28:12 -0500
Received: from w241.dkm.cz ([62.24.88.241]:11756 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751092AbVK0P2M (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2005 10:28:12 -0500
Received: (qmail 11794 invoked by uid 2001); 27 Nov 2005 16:28:27 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511230923131.13959@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12812>

Dear diary, on Wed, Nov 23, 2005 at 06:29:34PM CET, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> 
> 
> On Wed, 23 Nov 2005, Randal L. Schwartz wrote:
> > 
> > Delete the -d switch, or explain to me why it is there, and let's work
> > out a POSIX workaround.
> 
> It's
> 
>        -d:     same as --no-dereference --preserve=link
> 
>        --no-dereference
>               never follow symbolic links
> 
>        --preserve[=ATTR_LIST]
>               preserve   the   specified   attributes   (default:  mode,owner-
>               ship,timestamps) and security contexts, if  possible  additional
>               attributes: links, all
> 
> so it's basically making sure that the copy copies the _link_, not the 
> file it points to.
> 
> I think you may have to use "cpio -p" instead of "cp" to be portable. 
> Something like
> 
> 	cpio -plmu $src $dst
> 
> might do it.

Well, but -l links the files instead of copying them, right? That's
certainly not what I want, I want to really _copy_ the files. Also, does
cpio preserve the hardlinks between the copied files? If not, then what
you wrote is equivalent to

	cp -pRP

which should be even POSIX, hopefully. That's what I changed the -dpR to
now.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
