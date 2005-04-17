From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Re-done kernel archive - real one?
Date: Sun, 17 Apr 2005 17:05:40 +0100
Message-ID: <20050417170539.B13233@flint.arm.linux.org.uk>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Peter Anvin <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 18:02:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNCDu-0007Eb-KG
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 18:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVDQQF7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 12:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVDQQF7
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 12:05:59 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34056 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261345AbVDQQFq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 12:05:46 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DNCHH-0008EW-PL; Sun, 17 Apr 2005 17:05:44 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DNCHE-0004VM-Pe; Sun, 17 Apr 2005 17:05:41 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org>; from torvalds@osdl.org on Sat, Apr 16, 2005 at 04:01:45PM -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 16, 2005 at 04:01:45PM -0700, Linus Torvalds wrote:
> So I re-created the dang thing (hey, it takes just a few minutes), and
> pushed it out, and there's now an archive on kernel.org in my public
> "personal" directory called "linux-2.6.git". I'll continue the tradition
> of naming git-archive directories as "*.git", since that really ends up
> being the ".git" directory for the checked-out thing.

BTW, there appears to be "errors" in the history committed thus far.
I'm not sure where this came from though.  Some of them could be
UTF8 vs ASCII issues, but there's a number which seem to have extra
random crap in them ("^M)" and lots of blank lines).

One thing which definitely needs to be considered is - what character
encoding are the comments to be stored as?  Currently, it's whatever
the committers character encoding is, which will be completely random.
For instance, dwmw2 will definitely be using UTF, whereas I'll definitely
be using ISO-8859-1  (UTF is far too much of a pain in the ass to use,
unless _all_ your systems are running UTF, which mine don't yet.)

ID: 75f86bac962b7609b0f3c21d25e10647ff8ed280
[PATCH] intel8x0: AC'97 audio patch for Intel ESB2
         
        This patch adds the Intel ESB2 DID's to the intel8x0.c file for AC'97 audio
        support.
         
        Signed-off-by: <A0>Jason Gaston <Jason.d.gaston@intel.com>
        Signed-off-by: Andrew Morton <akpm@osdl.org>
        Signed-off-by: Linus Torvalds <torvalds@osdl.org>

ID: baab5c52135dfa2a02c5dcc8422fc5d048acc682
[PATCH] ppc32: fix compilation error in arch/ppc/kernel/time.c
         
        make defconfig give the following error on ppc (gcc-4):
         
        arch/ppc/kernel/time.c:92: error: static declaration of <E2><80><98>time_offset<E2><80><99>
        follows non-static declaration
        include/linux/timex.h:236: error: previous declaration of <E2><80><98>time_offset<E2><80><99>
        was here
         
        The following patch solves it (time_offset is declared in timer.c).
         
        Signed-Off-By: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
        Signed-off-by: Andrew Morton <akpm@osdl.org>
        Signed-off-by: Linus Torvalds <torvalds@osdl.org>

ID: fa357627062fa6f4727638bc4f302b23f5a3acb8
[PATCH] vmscan: pageout(): remove unneeded test
         
        ^M)
         
         
         
        We only call pageout() for dirty pages, so this test is redundant.
         
        Signed-off-by: Andrew Morton <akpm@osdl.org>
        Signed-off-by: Linus Torvalds <torvalds@osdl.org>

ID: e5fc9026c6a372a67e652c6ba1648e5f8e543600
[PATCH] arm: fix SIGBUS handling
         
        ^M)
         
         
        From: Russell King <rmk+lkml@arm.linux.org.uk>
         
        ARM wasn't raising a SIGBUS with a siginfo structure.  Fix
        __do_user_fault() to allow us to use it for SIGBUS conditions, and arrange
        for the sigbus path to use this.
         
        We need to prevent the siginfo code being called if we do not have a user
        space context to call it, so consolidate the "user_mode()" tests.
         
        Thanks to Ian Campbell who spotted this oversight.
         
        Signed-off-by: Russell King <rmk@arm.linux.org.uk>
        Signed-off-by: Andrew Morton <akpm@osdl.org>
        Signed-off-by: Linus Torvalds <torvalds@osdl.org>


-- 
Russell King

