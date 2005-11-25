From: Petr Baudis <pasky@suse.cz>
Subject: Re: files are disappearing in git
Date: Fri, 25 Nov 2005 23:57:49 +0100
Message-ID: <20051125225749.GB10680@pasky.or.cz>
References: <20051123142303.GJ22568@schottelius.org> <Pine.LNX.4.64.0511230917130.13959@g5.osdl.org> <20051124084633.GA3361@schottelius.org> <43866EDA.9050203@michonline.com> <20051125103048.GB30691@schottelius.org> <Pine.LNX.4.64.0511251022360.13959@g5.osdl.org> <20051125212846.GB5434@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Ryan Anderson <ryan@michonline.com>,
	Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 25 23:58:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfmVe-0000pN-JI
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 23:57:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932705AbVKYW5e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 17:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbVKYW5e
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 17:57:34 -0500
Received: from w241.dkm.cz ([62.24.88.241]:17110 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932705AbVKYW5d (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Nov 2005 17:57:33 -0500
Received: (qmail 26634 invoked by uid 2001); 25 Nov 2005 23:57:49 +0100
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Content-Disposition: inline
In-Reply-To: <20051125212846.GB5434@schottelius.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12756>

Dear diary, on Fri, Nov 25, 2005 at 10:28:46PM CET, I got a letter
where Nico -telmich- Schottelius <nico-linux-git@schottelius.org> said that...
> > Pasky - do you know of any historical cogito problems like this?
> 
> For information:
> 
> [22:07] srsyg03:packages% ls -l /usr/packages 
> insgesamt 28
> drwxr-xr-x  4 root root 4096 Nov 10 15:52 cogito-/
> drwxr-xr-x  4 root root 4096 Okt 14 15:15 cogito-0.15/
> drwxr-xr-x  4 root root 4096 Nov 23 13:31 cogito-73874dddeec2d0a8e5cd343eec762d98314def63/
> drwxr-xr-x  4 root root 4096 Okt 14 15:15 cvsps-2.1/
> drwxr-xr-x  4 root root 4096 Nov 10 15:52 git-/
> drwxr-xr-x  4 root root 4096 Okt 17 14:09 git-20051016.git/
> drwxr-xr-x  4 root root 4096 Nov 23 13:31 git-c61642185d411e5e3350566a68483e358ca392b9/
> 
> At the time of 2005-11-17 we'll have used a cogito and git version,
> which was from 2005-11-10.

That's really weird - I can't see anything since then that could
influence it. The only possibility is that you were working on those
files before, left them modified but uncommitted, then did a merge which
would touch them, the merge would fail because of local changes, then
you would delete your local instances of the files and try the merge
again.

That's something I fixed only very recently and the fix is not even in
any public release yet; I didn't realize that it could have such
dangerous consequences, but apparently it does. I guess I will release
0.16 final tomorrow.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
