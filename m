From: Petr Baudis <pasky@suse.cz>
Subject: Re: cg-admin-setuprepo fails to make a cg-clone'able repo
Date: Sun, 13 Nov 2005 01:29:16 +0100
Message-ID: <20051113002916.GK30496@pasky.or.cz>
References: <86wtjg31lo.fsf@blue.stonehenge.com> <20051111001333.GH30496@pasky.or.cz> <8664qxn71k.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 13 01:30:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eb5kO-0007cy-P2
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 01:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbVKMA3T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 19:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbVKMA3T
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 19:29:19 -0500
Received: from w241.dkm.cz ([62.24.88.241]:20706 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964894AbVKMA3S (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 19:29:18 -0500
Received: (qmail 25630 invoked by uid 2001); 13 Nov 2005 01:29:16 +0100
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <8664qxn71k.fsf@blue.stonehenge.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11721>

Dear diary, on Sat, Nov 12, 2005 at 05:51:35PM CET, I got a letter
where "Randal L. Schwartz" <merlyn@stonehenge.com> said that...
> >>>>> "Petr" == Petr Baudis <pasky@suse.cz> writes:
> 
> Petr> But this is actually an entirely unrelated bug, it seems - pretty
> Petr> strange.  I revived another few months old thread because of this, since
> Petr> it seems the 'b' was actually a typo and we don't want to pass 'cp' this
> Petr> argument at all, but something different. Does cloning locally otherwise
> Petr> work?
> 
> When I tried "local cloning", I first tried to make an empty archive
> with cgi-init, but it dumped me into an editor.  I couldn't find a
> switch to turn that off.  Perhaps the manpage should say "you'll
> be dumped in to an editor",

Well, that's pretty obvious after the first try. ;-)

> and perhaps provide a way to pass that message with "-m".

Good idea. Added.

> So, on a whim, I realize that it's performing an initial commit,

It says that right in the editor, after all. :-)

> so I try cg-init -I.
> 
> And here's the result:
> 
>     localhost:~/Projects/Git % cg-init -I my_master
>     defaulting to local storage area
>     localhost:~/Projects/Git % cg-clone my_master my_slave
>     defaulting to local storage area
>     find: /Users/merlyn/Projects/Git/my_master: No such file or directory
>     Hard links don't work - using copy
>     Fetching head...
>     cp: illegal option -- b
>     usage: cp [-R [-H | -L | -P]] [-f | -i | -n] [-pv] src target
>            cp [-R [-H | -L | -P]] [-f | -i | -n] [-pv] src1 ... srcN directory
>     cg-fetch: unable to get the HEAD branch
>     cg-clone: fetch failed
> 
> So, I guess your answer is no.  What is "-b" for cp.  That's not
> on my manpage.

It's something totally weird "backup" thing. A bug in Cogito, what we
_want_ is to have cp dereferencing its symlink. I replaced it with -L
now. Could you try the latest version from git or -rc2 (coming out in
few minutes), please?

> And, after reading the manpage closer, I see my first "my_master"
> was created wrong.  But no error message. :(

Good catch. Fixed.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
