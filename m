From: Junio C Hamano <junkio@cox.net>
Subject: Re: SIGSEGV in merge recursive
Date: Fri, 29 Dec 2006 12:11:15 -0800
Message-ID: <7v7iwampi4.fsf@assigned-by-dhcp.cox.net>
References: <699806.13055.qm@web31803.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 29 21:11:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H0O4W-0005q7-L1
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 21:11:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965136AbWL2ULR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Dec 2006 15:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965138AbWL2ULR
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Dec 2006 15:11:17 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:41913 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965136AbWL2ULQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Dec 2006 15:11:16 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061229201115.PPVV18767.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Dec 2006 15:11:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 4kAW1W00L1kojtg0000000; Fri, 29 Dec 2006 15:10:30 -0500
To: ltuikov@yahoo.com
In-Reply-To: <699806.13055.qm@web31803.mail.mud.yahoo.com> (Luben Tuikov's
	message of "Fri, 29 Dec 2006 11:49:43 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35606>

Luben Tuikov <ltuikov@yahoo.com> writes:

> This time it happens when merging one of my git trees into another:
> ...
> And here is the backtrace:
>
> $gdb ~/bin/git-merge-recursive
> GNU gdb 6.5
> Copyright (C) 2006 Free Software Foundation, Inc.
> GDB is free software, covered by the GNU General Public License, and you are
> welcome to change it and/or distribute copies of it under certain conditions.
> Type "show copying" to see the conditions.
> There is absolutely no warranty for GDB.  Type "show warranty" for details.
> This GDB was configured as "i686-pc-linux-gnu"...Using host libthread_db library
> "/lib/libthread_db.so.1".
>
> (gdb) run 777f68432f1db967573e5722bf0fd08af05e748f -- HEAD
> d985fdaf7a4b8b1dde313c8fad12983dc4ce20f7
> Starting program: /home/luben/bin/git-merge-recursive 777f68432f1db967573e5722bf0fd08af05e748f --
> HEAD d985fdaf7a4b8b1dde313c8fad12983dc4ce20f7
> Failed to read a valid object file image from memory.

Who says this?

> Merging HEAD with d985fdaf7a4b8b1dde313c8fad12983dc4ce20f7
> Merging:
> 52d5052 Merge branch 'git-upstream' into git-lt-work
> d985fda Merge branch 'next' into git-upstream
> found 1 common ancestor(s):
> 777f684 Merge branch 'next' into git-upstream
> Auto-merging .gitignore
>
> Program received signal SIGSEGV, Segmentation fault.
> 0x08070469 in xdl_merge (orig=0xbff3aae0, mf1=0xbff3aad8, 
>     name1=0x80f5208 "HEAD:.gitignore", mf2=0xbff3aad0, 
>     name2=0x80f59a8 "d985fdaf7a4b8b1dde313c8fad12983dc4ce20f7:.gitignore", 
>     xpp=0xbff3aae8, level=2, result=0xbff3aac8) at xdiff/xmerge.c:200
> warning: Source file is more recent than executable.
> 200                      */

What local mods are you running with?
