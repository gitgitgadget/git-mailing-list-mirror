From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/4] Tweak diff output further to make it a bit less
 distracting.
Date: Mon, 16 May 2005 20:10:35 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505161955340.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0505161556260.18337@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 02:12:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXpgj-0000fS-6r
	for gcvg-git@gmane.org; Tue, 17 May 2005 02:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbVEQAL5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 May 2005 20:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVEQAL5
	(ORCPT <rfc822;git-outgoing>); Mon, 16 May 2005 20:11:57 -0400
Received: from iabervon.org ([66.92.72.58]:9988 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261320AbVEQALR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2005 20:11:17 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DXpfP-0001aR-00; Mon, 16 May 2005 20:10:35 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505161556260.18337@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 16 May 2005, Linus Torvalds wrote:

> One final note: I actually think that "rename patches" make a ton of 
> sense, even if git itself doesn't track renames. If we ever have a "smart 
> diff" thing that can generate inter-file diffs, I'd like to eventually see
> 
> 	diff -git a/kernel/sched.c b/kernel/sched.c.old
> 	rename kernel/sched.c kernel/sched.c.old
> 	old mode 100644
> 	new mode 100755

I'd like something like:

diff -git a/kernel/sched.c b/kernel/sched.c.old
filename -- kernel/sched.c
filename ++ kernel/sched.c.old
mode -- 100644
mode ++ 100755
--- a/kernel/sched.c
+++ b/kernel/sched.c.old
@@ -1,5 +1,5 @@
(etc.)

because I actually start thinking of the two sides as "-" and "+", and I'd
actually have to think about which is "old" and which is "new", and which
way the "rename" line goes, and so forth. I'd actually be happier with
just a "mode -- 100644" line for a deleted file, also. If I'm looking at a
patch, and I read Makefile with '-' and '+' versions of the lists of
objects, and then get to a "new file" line, I have to think about it to
associate the '+' side with having the file and the '-' side with not
having it.

	-Daniel
*This .sig left intentionally blank*

