From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH 1/2] Introduce git-run-with-user-path helper program.
Date: Thu, 19 May 2005 01:24:08 +0200
Message-ID: <20050518232408.GA18281@pasky.ji.cz>
References: <7voebbpuxs.fsf@assigned-by-dhcp.cox.net> <20050517190355.GA7136@pasky.ji.cz> <7vk6lxfybc.fsf@assigned-by-dhcp.cox.net> <20050517203500.GH7136@pasky.ji.cz> <7v4qd1tuud.fsf@assigned-by-dhcp.cox.net> <20050517213752.GO7136@pasky.ji.cz> <7vzmutqz5f.fsf@assigned-by-dhcp.cox.net> <20050518213309.GD10358@pasky.ji.cz> <7vekc4nom5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Thu May 19 01:24:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYXt8-0007pA-1I
	for gcvg-git@gmane.org; Thu, 19 May 2005 01:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbVERXYV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 19:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbVERXYV
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 19:24:21 -0400
Received: from w241.dkm.cz ([62.24.88.241]:33422 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262370AbVERXYP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2005 19:24:15 -0400
Received: (qmail 18730 invoked by uid 2001); 18 May 2005 23:24:09 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vekc4nom5.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, May 19, 2005 at 12:41:38AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> >>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:
> 
> >> $ pwd
> >> /usr/src/linux/fs
> >> $ git-run-with-user-path cg-commit -- ext?/Makefile
> >> 
> >> would work.
> 
> PB> Yes. But if you do just cg-commit in the subdirectory, it won't work.
> 
> The point of git-run-with-user-path is that it canonicalizes and
> filters the paths, chdir(2)'s to GIT_PROJECT_TOP before running
> cg-commit.  So when cg-commit starts in the above example,
> 
>     (1) its $cwd is /usr/src/linux and your .git subdirectory is
>         right there in ./.git/
>     (2) it gets fs/ext2/Makefile and fs/ext3/Makefile as arguments.

Yes. My point is that sometimes the Cogito commands have
directory-specific functionality even when called without any arguments.

$ pwd
/usr/src/linux
$ date >>README
$ cd fs
$ date >>Makefile
$ cg-commit

will commit only the fs/Makefile change.

> >> BTW, I am wondering if your choice of cg-commit as an example
> >> (as opposed to something else like diff or add) is a flamebait
> >> or just an innocent random example ;-)?
> 
> PB> It was completely innocent. :-) How would it be a flamebait?
> 
> <http://members.cox.net/junkio/per-file-commit.txt> ;-).

JIT's snapshotting makes up for it, I think. It has some beauty. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
