From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Mon, 11 Jul 2005 21:34:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507112132170.17536@g5.osdl.org>
References: <20050708230750.GA23847@buici.com> <Pine.LNX.4.58.0507081842550.17536@g5.osdl.org>
 <20050711222046.GA21376@buici.com> <7vll4dndwu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507111646000.17536@g5.osdl.org> <Pine.LNX.4.58.0507111833380.17536@g5.osdl.org>
 <20050712021004.GA27576@buici.com> <Pine.LNX.4.58.0507112005540.17536@g5.osdl.org>
 <Pine.LNX.4.58.0507112045420.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 06:37:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsCWP-0007qA-Ou
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 06:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262350AbVGLEgr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 00:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbVGLEgp
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 00:36:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60828 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262350AbVGLEel (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2005 00:34:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6C4YYjA021694
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 11 Jul 2005 21:34:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6C4YXa3021715;
	Mon, 11 Jul 2005 21:34:33 -0700
To: Marc Singer <elf@buici.com>
In-Reply-To: <Pine.LNX.4.58.0507112045420.17536@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 11 Jul 2005, Linus Torvalds wrote:
> 
>     Of course, if you want to create a new branch "my-branch" and _not_
>     check it out, you could have done so with just
> 
>         git-rev-parse v2.6.12^0 > .git/refs/heads/my-branch
> 
>     which I think I will codify as "git branch".

And now we have that "git branch". It's a trivial one-liner, except with
the setup and error checking it's actually more like six lines.

		Linus

---
commit 37f1a519f2ea0ce912ccd7c623aea992147c3900
Author: Linus Torvalds <torvalds@g5.osdl.org>
Date:   Mon Jul 11 21:30:23 2005 -0700

    Add "git branch" script

    You can use it as

        git branch <branchname> [start-point]

    and it creates a new branch of name <branchname>.  If a starting point
    is specified, that will be where the branch is created, otherwise it
    will be created at the current HEAD.

    The sequence

        git branch xyz abc
        git checkout xyz

    can also be written as

        git checkout -b xyz abc

    as per the previous commit.
