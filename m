From: Dave Kleikamp <shaggy@austin.ibm.com>
Subject: Re: How do I...
Date: Fri, 06 May 2005 12:58:51 -0500
Message-ID: <1115402331.10460.16.camel@localhost>
References: <427B3DB3.4000507@tuxrocks.com>
	 <1115390221.10459.4.camel@localhost>  <427B9DC5.9060905@tuxrocks.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 06 19:53:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU6zr-0001fW-Gd
	for gcvg-git@gmane.org; Fri, 06 May 2005 19:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVEFR7E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 13:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVEFR7E
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 13:59:04 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:3986 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261249AbVEFR6z (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 13:58:55 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j46Hwr4I558464
	for <git@vger.kernel.org>; Fri, 6 May 2005 13:58:54 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j46HwrTh256436
	for <git@vger.kernel.org>; Fri, 6 May 2005 11:58:53 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j46HwrwU004385
	for <git@vger.kernel.org>; Fri, 6 May 2005 11:58:53 -0600
Received: from kleikamp.austin.ibm.com (dyn95390155.austin.ibm.com [9.53.90.155])
	by d03av01.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j46Hwq1i004360;
	Fri, 6 May 2005 11:58:52 -0600
To: Frank Sorenson <frank@tuxrocks.com>
In-Reply-To: <427B9DC5.9060905@tuxrocks.com>
X-Mailer: Evolution 2.0.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-05-06 at 10:39 -0600, Frank Sorenson wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Dave Kleikamp wrote:
> > On Fri, 2005-05-06 at 03:49 -0600, Frank Sorenson wrote:
> > 
> > 
> >>After doing a cg-update, can I cg-log just the changes since the last
> >>update?  Alternatively, how can I tell cg-log I'm caught up, and don't
> >>need anything historical?
> > 
> > 
> > (Assuming pulling from "origin")
> > Instead of doing cg-update, do cg-pull.  Then "cg-log :origin" will give
> > you you the changesets you just pulled.

I'm not sure if I was clear.  cg-pull should be 'cg-pull origin".

> Super.  This works great.  Thanks.
> 
> > "cg-merge origin" will then
> > complete operation, thereby catching you up.
> 
> Okay, not quite so great.  Here's the ouput when I ran it to update my
> kernel this morning.  Note that I haven't made any local modifications.
>  I'm seeing this sort of thing often enough that I'm blowing away my
> whole git tree and regenerating it to get back to a stable state once or
> twice a week.  I'm sure there's another way, but without me making
> modifications on my end, I wouldn't expect this to happen.  Suggestions
> are welcome! :)

I take this to mean you're seeing problems with cg-update too. cg-update
simply runs cg-pull & cg-merge together, so running them separately
shouldn't make any difference.

> # cg-merge origin
> Fast-forwarding 6741f3a7f9922391cd02b3ca1329e669497dc22f ->
> 2512809255d018744fe6c2f5e996c83769846c07
>         on top of 6741f3a7f9922391cd02b3ca1329e669497dc22f...
> patching file fs/proc/Makefile
> patching file fs/proc/array.c
> patching file fs/proc/base.c
> patching file fs/proc/generic.c
> patching file fs/proc/inode-alloc.txt
> patching file fs/proc/inode.c
> patching file fs/proc/internal.h
> patching file fs/proc/kcore.c
> patching file fs/proc/kmsg.c
> patching file fs/proc/mmu.c
> patching file fs/proc/nommu.c
> patching file fs/proc/proc_devtree.c
> patching file fs/proc/proc_misc.c
> patching file fs/proc/proc_tty.c
> patching file fs/proc/root.c
> patching file fs/proc/task_mmu.c
> patching file fs/proc/task_nommu.c
> touch: cannot touch `fs/proc/Makefile': No such file or directory
> touch: cannot touch `fs/proc/array.c': No such file or directory
> touch: cannot touch `fs/proc/base.c': No such file or directory
> touch: cannot touch `fs/proc/generic.c': No such file or directory
> touch: cannot touch `fs/proc/inode-alloc.txt': No such file or directory
> touch: cannot touch `fs/proc/inode.c': No such file or directory
> touch: cannot touch `fs/proc/internal.h': No such file or directory
> touch: cannot touch `fs/proc/kcore.c': No such file or directory
> touch: cannot touch `fs/proc/kmsg.c': No such file or directory
> touch: cannot touch `fs/proc/mmu.c': No such file or directory
> touch: cannot touch `fs/proc/nommu.c': No such file or directory
> touch: cannot touch `fs/proc/proc_devtree.c': No such file or directory
> touch: cannot touch `fs/proc/proc_misc.c': No such file or directory
> touch: cannot touch `fs/proc/proc_tty.c': No such file or directory
> touch: cannot touch `fs/proc/root.c': No such file or directory
> touch: cannot touch `fs/proc/task_mmu.c': No such file or directory
> touch: cannot touch `fs/proc/task_nommu.c': No such file or directory
> rm: cannot remove `fs/proc/Makefile': No such file or directory
> rm: cannot remove `fs/proc/array.c': No such file or directory
> rm: cannot remove `fs/proc/base.c': No such file or directory
> rm: cannot remove `fs/proc/generic.c': No such file or directory
> rm: cannot remove `fs/proc/inode-alloc.txt': No such file or directory
> rm: cannot remove `fs/proc/inode.c': No such file or directory
> rm: cannot remove `fs/proc/internal.h': No such file or directory
> rm: cannot remove `fs/proc/kcore.c': No such file or directory
> rm: cannot remove `fs/proc/kmsg.c': No such file or directory
> rm: cannot remove `fs/proc/mmu.c': No such file or directory
> rm: cannot remove `fs/proc/nommu.c': No such file or directory
> rm: cannot remove `fs/proc/proc_devtree.c': No such file or directory
> rm: cannot remove `fs/proc/proc_misc.c': No such file or directory
> rm: cannot remove `fs/proc/proc_tty.c': No such file or directory
> rm: cannot remove `fs/proc/root.c': No such file or directory
> rm: cannot remove `fs/proc/task_mmu.c': No such file or directory
> rm: cannot remove `fs/proc/task_nommu.c': No such file or directory
> fs/proc/Makefile: needs update
> fs/proc/array.c: needs update
> fs/proc/base.c: needs update
> fs/proc/generic.c: needs update
> fs/proc/inode-alloc.txt: needs update
> fs/proc/inode.c: needs update
> fs/proc/internal.h: needs update
> fs/proc/kcore.c: needs update
> fs/proc/kmsg.c: needs update
> fs/proc/mmu.c: needs update
> fs/proc/nommu.c: needs update
> fs/proc/proc_devtree.c: needs update
> fs/proc/proc_misc.c: needs update
> fs/proc/proc_tty.c: needs update
> fs/proc/root.c: needs update
> fs/proc/task_mmu.c: needs update
> fs/proc/task_nommu.c: needs update

I've seen some isolated problems running cg-update/cg-merge to a clean
tree with files that have been deleted.

Saw this this morning:

shaggy@kleikamp linus-clean $ cg-merge origin
Fast-forwarding bfd4bda097f8758d28e632ff2035e25577f6b060 ->
2512809255d018744fe6c2f5e996c83769846c07
        on top of bfd4bda097f8758d28e632ff2035e25577f6b060...
patching file drivers/video/intelfb/intelfb.h
shaggy@kleikamp linus-clean $ cg-status
? drivers/video/intelfb/intelfbdrv.h

Removing the file manually appears to fix it.

> Thanks,
> Frank
> - --
> Frank Sorenson - KD7TZK
> Systems Manager, Computer Science Department
> Brigham Young University
> frank@tuxrocks.com

-- 
David Kleikamp
IBM Linux Technology Center

