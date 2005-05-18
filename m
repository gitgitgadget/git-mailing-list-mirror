From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Introduce git-run-with-user-path helper program.
Date: Wed, 18 May 2005 15:41:38 -0700
Message-ID: <7vekc4nom5.fsf@assigned-by-dhcp.cox.net>
References: <7voebbpuxs.fsf@assigned-by-dhcp.cox.net>
	<20050517190355.GA7136@pasky.ji.cz>
	<7vk6lxfybc.fsf@assigned-by-dhcp.cox.net>
	<20050517203500.GH7136@pasky.ji.cz>
	<7v4qd1tuud.fsf@assigned-by-dhcp.cox.net>
	<20050517213752.GO7136@pasky.ji.cz>
	<7vzmutqz5f.fsf@assigned-by-dhcp.cox.net>
	<20050518213309.GD10358@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Thu May 19 00:42:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYXE2-0002nZ-4v
	for gcvg-git@gmane.org; Thu, 19 May 2005 00:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbVERWlt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 18:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbVERWlt
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 18:41:49 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:40424 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262326AbVERWlk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2005 18:41:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050518224137.CIKZ22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 18 May 2005 18:41:37 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050518213309.GD10358@pasky.ji.cz> (Petr Baudis's message of
 "Wed, 18 May 2005 23:33:09 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

>> $ pwd
>> /usr/src/linux/fs
>> $ git-run-with-user-path cg-commit -- ext?/Makefile
>> 
>> would work.

PB> Yes. But if you do just cg-commit in the subdirectory, it won't work.

The point of git-run-with-user-path is that it canonicalizes and
filters the paths, chdir(2)'s to GIT_PROJECT_TOP before running
cg-commit.  So when cg-commit starts in the above example,

    (1) its $cwd is /usr/src/linux and your .git subdirectory is
        right there in ./.git/
    (2) it gets fs/ext2/Makefile and fs/ext3/Makefile as arguments.

>> BTW, I am wondering if your choice of cg-commit as an example
>> (as opposed to something else like diff or add) is a flamebait
>> or just an innocent random example ;-)?

PB> It was completely innocent. :-) How would it be a flamebait?

<http://members.cox.net/junkio/per-file-commit.txt> ;-).

