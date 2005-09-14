From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: Another merge test case from the kernel tree.
Date: Wed, 14 Sep 2005 19:42:51 +0200
Message-ID: <20050914174251.GA21639@c165.ib.student.liu.se>
References: <20050907164734.GA20198@c165.ib.student.liu.se> <20050907165012.GA20392@c165.ib.student.liu.se> <7vzmqk2u1w.fsf_-_@assigned-by-dhcp.cox.net> <7vpsrcqjj6.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	Tony Luck <tony.luck@intel.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 19:45:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFbHw-0005K3-TI
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 19:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbVINRnO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 13:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbVINRnO
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 13:43:14 -0400
Received: from [85.8.31.11] ([85.8.31.11]:27273 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1030258AbVINRnN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 13:43:13 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 4648E4100; Wed, 14 Sep 2005 19:48:00 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EFbHX-0005oh-00; Wed, 14 Sep 2005 19:42:51 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpsrcqjj6.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8543>

On Tue, Sep 13, 2005 at 10:56:45PM -0700, Junio C Hamano wrote:
...

> BTW, Fredrik, the 'recursive' merge dies with this:
> 
> Trying merge strategy recursive...
> Merging 357d596bd552ad157a906289ab13ea6ba7e66e3d with aa2dca4563b0629ecd9d9994dfdf39f29ff1b43f
> Merging: 
> 357d596bd552ad157a906289ab13ea6ba7e66e3d Merge branch 'release' of master.kernel.org:/pub/scm/linux/kernel/git/aegl/linux-2.6  
> aa2dca4563b0629ecd9d9994dfdf39f29ff1b43f Manual merge of kernel/sched.c and arch/ia64/kernel/mca_asm.S 
> found 3 common ancestor(s): 
> a1cddb88920b915eaba10712ecfd0fc698b00a22 [IA64-SGI] Add new vendor-specific SAL calls for: 
> 6cf07a8cc86a0b471466c7fe45892f7ef434015b [IA64] Fix nasty VMLPT problem... 
> 49a28cc8fd26f5317c47a9aeb2bdd1c33e21738e [IA64] MCA/INIT: remove obsolete unwind code 
>   Merging: 
>   a1cddb88920b915eaba10712ecfd0fc698b00a22 [IA64-SGI] Add new vendor-specific SAL calls for: 
>   6cf07a8cc86a0b471466c7fe45892f7ef434015b [IA64] Fix nasty VMLPT problem... 
>   found 1 common ancestor(s): 
>   d8971fcb702e24d1e22c77fd1772f182ffee87e3 [INET]: compile errors when DEBUG is defined 
> Traceback (most recent call last):
>   File "/home/junio/bin/Linux/git-merge-recursive", line 429, in ?
>     firstBranch, secondBranch, graph)
>   File "/home/junio/bin/Linux/git-merge-recursive", line 54, in merge
>     graph, callDepth+1)
>   File "/home/junio/bin/Linux/git-merge-recursive", line 62, in merge
>     runProgram(['git-read-tree', h1.tree()])
>   File "/home/junio/share/git-core/python/gitMergeCommon.py", line 93, in runProgram
>     raise ProgramError(progStr, out)
> ProgramError: git-read-tree 1d20af805193ab9982a48cb4c828c0f6af034c6c: fatal: failed to unpack tree object 1d20af805193ab9982a48cb4c828c0f6af034c6c
> 

It works for me. The 'recursive' strategy cleanly merges this and
produces a result identical to the actual commit.

The tree object 1d20af805193ab9982a48cb4c828c0f6af034c6c is the tree
of the commit a1cddb88920b915eaba10712ecfd0fc698b00a22 which is one of
the common ancestors. Are you sure that you got the entire repository? 
It took some time for me to figure out that 'git clone
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/aegl/linux-2.6.git
aegl.git' will _not_ give you a usable repository. You have to change
aegl.git/.git/objects/objects/info/alternates before it becomes
usable.


- Fredrik
