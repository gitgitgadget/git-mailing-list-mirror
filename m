From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Re-done kernel archive - real one?
Date: Sun, 17 Apr 2005 16:24:48 +0100
Message-ID: <20050417162448.A13233@flint.arm.linux.org.uk>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Peter Anvin <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 17:21:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNBaL-0003EM-8K
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 17:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVDQPZG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 11:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVDQPZG
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 11:25:06 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3850 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261330AbVDQPYz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 11:24:55 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DNBdi-0008Cg-6U; Sun, 17 Apr 2005 16:24:50 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DNBdh-00045j-0L; Sun, 17 Apr 2005 16:24:49 +0100
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

We need to work out how we're going to manage to get our git changes to
you.  At the moment, I've very little idea how to do that.  Ideas?

At the bottom is the script itself.  There's probably some aspects of
it which aren't nice, maybe Petr can advise on this (and maybe increase
the functionality of the git shell script to fill in where necessary.)

However, I've made a start to generate the necessary emails.  How about
this format?

I'm not keen on the tree, parent, author and committer objects appearing
in this - they appear to clutter it up.  What're your thoughts?

I'd rather not have the FQDN of the machine where the commit happened
appearing in the logs.  (I've 'xxxx'd it out for the time being, because
I'd rather not have yet more email-address-like objects get into spammers
databases with which to hammer my 512kbps DSL line.)

Linus,

Please incorporate the latest ARM changes.

This will update the following files:

 arm/kernel/process.c                |   15 +++++++++++----
 arm/kernel/traps.c                  |    8 ++------
 arm/lib/changebit.S                 |   11 ++---------
 arm/lib/clearbit.S                  |   13 ++-----------
 arm/lib/setbit.S                    |   11 ++---------
 arm/lib/testchangebit.S             |   15 ++-------------
 arm/lib/testclearbit.S              |   15 ++-------------
 arm/lib/testsetbit.S                |   15 ++-------------
 arm/mach-footbridge/dc21285-timer.c |    4 ++--
 arm/mach-sa1100/h3600.c             |    2 +-
 asm-arm/ptrace.h                    |    5 +----
 asm-arm/system.h                    |    3 +++
 12 files changed, 32 insertions(+), 85 deletions(-)

through these ChangeSets:

	tree 7c4d75539c29ef7a9dde81acf84a072649f4f394
	parent d5922e9c35d21f0b6b82d1fd8b1444cfce57ca34
	author Russell King <rmk@xxxx.arm.linux.org.uk> 1113749462 +0100
	committer Russell King <rmk@xxxx.arm.linux.org.uk> 1113749462 +0100
	
	[PATCH] ARM: bitops
	
	Convert ARM bitop assembly to a macro.  All bitops follow the same
	format, so it's silly duplicating the code when only one or two
	instructions are different.
	
	Signed-off-by: Russell King <rmk@arm.linux.org.uk>
	tree fc10d3ffa6062cda10a10cb8262d8df238aea4fb
	parent 5d9a545981893629c8f95e2b8b50d15d18c6ddbc
	author Russell King <rmk@xxxx.arm.linux.org.uk> 1113749436 +0100
	committer Russell King <rmk@xxxx.arm.linux.org.uk> 1113749436 +0100
	
	[PATCH] ARM: showregs
	
	Fix show_regs() to provide a backtrace.  Provide a new __show_regs()
	function which implements the common subset of show_regs() and die().
	Add prototypes to asm-arm/system.h
	
	Signed-off-by: Russell King <rmk@arm.linux.org.uk>
	tree 5591fced9a2b5f84c6772dcbe2eb4b24e29161fc
	parent 488faba31f59c5960aabbb2a5877a0f2923937a3
	author Russell King <rmk@xxxx.arm.linux.org.uk> 1113748846 +0100
	committer Russell King <rmk@xxxx.arm.linux.org.uk> 1113748846 +0100
	
	[PATCH] ARM: h3600_irda_set_speed arguments
	
	h3600_irda_set_speed() had the wrong type for the "speed" argument.
	Fix this.
	
	Signed-off-by: Russell King <rmk@arm.linux.org.uk>
	tree 2493491da6e446e48d5443f0a549a10ed3d35b62
	parent e7905b2f22eb5d5308c9122b9c06c2d02473dd4f
	author Russell King <rmk@xxxx.arm.linux.org.uk> 1113748615 +0100
	committer Russell King <rmk@xxxx.arm.linux.org.uk> 1113748615 +0100
	
	[PATCH] ARM: footbridge rtc init
	
	The footbridge ISA RTC was being initialised before we had setup the
	kernel timer.  This caused a divide by zero error when the current
	time of day is set.  Resolve this by initialising the RTC after
	the kernel timer has been initialised.
	
	Signed-off-by: Russell King <rmk@arm.linux.org.uk>

---

#!/bin/sh
prev=$(cat .git/heads/origin)
to=$(cat .git/HEAD)
who=Linus
what=ARM
 
cat << EOT
${who},
 
Please incorporate the latest ${what} changes.
 
This will update the following files:
 
EOT
 
git diff $prev $to | diffstat -p1
 
cat << EOT
 
through these ChangeSets:
 
EOT
 
this=$to
while [ "$this" != "$prev" ]; do
  cat-file commit $this | sed 's,.*,\t&,'
  this=$(cat-file commit $this | grep ^parent | cut -d ' ' -f 2)
done


-- 
Russell King

