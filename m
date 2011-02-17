From: Miklos Szeredi <miklos-sUDqSbJrdHQHWmgEVkV9KA@public.gmane.org>
Subject: Re: [sshfs] inode problem when using git on a sshfs
	filesystem
Date: Thu, 17 Feb 2011 11:44:26 +0100
Message-ID: <E1Pq1LW-0005rc-Qy@pomaz-ex.szeredi.hu>
References: <1297893854.4097.43.camel@dworkin.quest-ce.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: fuse-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, fuse-sshfs-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yann Droneaud <yann-WYdEh2jsUj5Wj0EZb7rXcA@public.gmane.org>
X-From: fuse-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org Thu Feb 17 11:45:04 2011
Return-path: <fuse-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Envelope-to: gcffd-fuse-devel@m.gmane.org
Received: from lists.sourceforge.net ([216.34.181.88])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <fuse-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>)
	id 1Pq1M6-0007Dz-QT
	for gcffd-fuse-devel@m.gmane.org; Thu, 17 Feb 2011 11:45:03 +0100
Received: from localhost ([127.0.0.1] helo=sfs-ml-2.v29.ch3.sourceforge.com)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <fuse-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>)
	id 1Pq1Lk-0006Wp-5i; Thu, 17 Feb 2011 10:44:40 +0000
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <miklos-sUDqSbJrdHQHWmgEVkV9KA@public.gmane.org>)
	id 1Pq1Li-0006WV-Lx; Thu, 17 Feb 2011 10:44:38 +0000
Received-SPF: pass (sog-mx-2.v43.ch3.sourceforge.com: domain of szeredi.hu
	designates 88.209.222.127 as permitted sender)
	client-ip=88.209.222.127; envelope-from=miklos-sUDqSbJrdHQHWmgEVkV9KA@public.gmane.org;
	helo=pomaz-ex.szeredi.hu; 
Received: from fxip-0047f.externet.hu ([88.209.222.127]
	helo=pomaz-ex.szeredi.hu)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.74) id 1Pq1Lg-0003f0-Lb; Thu, 17 Feb 2011 10:44:38 +0000
Received: from miko by pomaz-ex.szeredi.hu with local (Exim 4.69)
	(envelope-from <miklos-sUDqSbJrdHQHWmgEVkV9KA@public.gmane.org>)
	id 1Pq1LW-0005rc-Qy; Thu, 17 Feb 2011 11:44:26 +0100
In-reply-to: <1297893854.4097.43.camel-vNW8ozRvgWupuGC+iAP0z+TW4wlIGRCZ@public.gmane.org> (message from
	Yann Droneaud on Wed, 16 Feb 2011 23:04:14 +0100)
X-Spam-Score: -1.5 (-)
X-Spam-Report: Spam Filtering performed by mx.sourceforge.net.
	See http://spamassassin.org/tag/ for more details.
	-1.5 SPF_CHECK_PASS SPF reports sender host as permitted sender for
	sender-domain
	-0.0 SPF_HELO_PASS          SPF: HELO matches SPF record
	-0.0 SPF_PASS               SPF: sender matches SPF record
X-Headers-End: 1Pq1Lg-0003f0-Lb
X-BeenThere: fuse-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: <fuse-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/fuse-devel>,
	<mailto:fuse-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=fuse-devel>
List-Post: <mailto:fuse-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:fuse-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/fuse-devel>,
	<mailto:fuse-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: fuse-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167065>

On Wed, 16 Feb 2011, Yann Droneaud wrote:
> Hi,
> 
> For some days, my usage of git is not as seamless as before.
> 
> I'm using git along sshfs/fuse (don't blame me for that), and 
> each time I try to rebase one of my branch, I have a conflict when applying
> the third commit. Doing the same operation on a local filesystem works without any problem.

Yann, thanks for looking into this.

Your findings are not surprising: unlike NFS, sshfs doesn't provide
inode numbers and the fuse library also doesn't guarantee stable inode
numbers by default.

Fuse version 2.8.x has a "noforget" option that should provide stable
inode numbers, at the cost of unbounded memory use.  Could you please
try if this option fixes these issues?

Thanks,
Miklos

> 
> ===== Part one: git =====
> 
> When I try to rebase one specific branch, git rebase failed when applying the third commit,
> telling me about uncommited 
> 
> I've tried to do it from scratch, using git format-patch / git am
> but git am also abort on the third patch with the error message:
> 
> error: <path>/<filename>: does not match index
> 
> So I've tried to diagnose the problem using :
> 
>  - git diff / git status : doesn't return anything.
> 
>  - git ls-tree HEAD -l <path>/<filename> : returns the correct mode and file size.
> 
>  - git log --raw --all --full-history -- <path>/<filename> : 
>    returns valid information matching the one retrieved above.
> 
>  - git hash-object <path>/<filename> :
>    gives the correct sha1 for the file, as recorded in the patch extracted using git format-patch 
>    and reported by git ls-tree or git log (see before)
> 
>  - git diff-files : it shows a lot a file, all of them in same directory
> 
>    :100644 100644 <sha1> 0000000000000000000000000000000000000000 M <path>/<filename0>
>    :100644 100644 <sha1> 0000000000000000000000000000000000000000 M <path>/<filename1>
>    :100644 100644 <sha1> 0000000000000000000000000000000000000000 M <path>/<filename2>
>    :100644 100644 <sha1> 0000000000000000000000000000000000000000 M <path>/<filename3>
>    :100644 100644 <sha1> 0000000000000000000000000000000000000000 M <path>/<filename>
> 
> BTW, there's no conflict when applying the patch manually with patch: the patch itself is fine
> Using git apply --index also work, but only if it's applied alone:
> apply each patches in series and git apply fails in the same third patch.
> 
> After diving into git source code and some debugging session, I've found
> that the inode number recorded in the active_cache doesn't match the one
> on the filesystem for <pach>/<filename> : that's why git apply --index refuse to apply the patch.
> 
> Then I tried to monitor stat() information for the file in <path> during
> git operations.
> 1) After applying the first patch, files in <path> were affected different inode number
> 2) Using strace, I checked that git apply didn't make anything specials to thoses files.
> The only thing strange git did, was trying to unlink(<path>), but this failed since the <path>
> directory wasn't empty.
> 
> Note: the first patch remove, change and add some files in <path> directory, while 
> the third patch changes another file in <path> directory
> 
> As a workaround: running git diff / git diff --cached / git status between each
> git apply --index command seems to update the cache and allows me to apply all the patches
> without problem. But it's not an easy path to follow when rebasing branches.
> 
> Surprisingly, when looking at strace output, it seems that git apply, once work done, is calling lstat() 
> for all the files under <path>, and it sees the new inodes allocated to those files, but I don't know what 
> it is doing with those information, if it's not stored in the index.
> 
> To conclude, it was a bit hard to diagnose from git point of view.
> 
> ====== Part two: sshfs / fuse ======
> 
> At this time sshfs seems to be guilty of bad behavior, breaking somes POSIX rules.
> 
> So I tried the following testcase on another computer to reproduce the
> problem outside of git.
> 
> Here the results:
> 
> $ mkdir dir
> $ touch dir/a dir/b
> $ stat -t dir/*
> dir/a 0 0 81b4 500 500 15 3 1 0 0 1297882724 1297882724 1297882724 4096
> dir/b 0 0 81b4 500 500 15 4 1 0 0 1297882726 1297882726 1297882726 4096
> $ rmdir dir
> rmdir: failed to remove `dir1': Operation not permitted
> $ stat -t dir/*
> dir/a 0 0 81b4 500 500 15 6 1 0 0 1297882724 1297882724 1297882724 4096
> dir/b 0 0 81b4 500 500 15 7 1 0 0 1297882726 1297882726 1297882726 4096
> 
> One can see that inode 3 became inode 6 and inode 4 became inode 7 after the failed
> unlink operation on dir. Which seems to be a bit uncommon for me.
> 
> Note: on a local filesystem, rmdir failed with message rmdir: failed to remove `dir1': Directory not empty
> 
> I try to add some debug support to fuse / sshfs in order to locate more precisely the problem:
> (lines beginning by -/+ where added by me in libfuse, line beginning with --/++ in sshfs)
> 
> $ sshfs localhost:<export> <mount> -o sshfs_debug,debug,cache=no -d -f -s
> 
> unique: 22, opcode: FORGET (2), nodeid: 4, insize: 48, pid: 0
> - forget 4
> FORGET 4/1
> DELETE: 4
> + forget 4
> unique: 23, opcode: FORGET (2), nodeid: 3, insize: 48, pid: 0
> - forget 3
> FORGET 3/1
> DELETE: 3
> + forget 3
> unique: 24, opcode: RMDIR (11), nodeid: 1, insize: 44, pid: 9044
> - rmdir 1 dir
> rmdir /dir
> -- rmdir(/dir)
> [00020] RMDIR
>   [00020]         STATUS       28bytes (0ms)
> ++ rmdir(/dir) = -1
>    unique: 24, error: -1 (Operation not permitted), outsize: 16
> + rmdir 1 dir
> unique: 25, opcode: FORGET (2), nodeid: 2, insize: 48, pid: 0
> - forget 2
> FORGET 2/1
> DELETE: 2
> + forget 2
> 
> One can see that the reference to files under the directory are asked by
> the kernel to be forgotten, even if the directory is not yet removed.
> 
> This seems a bit illogical since a directory with files under it can't
> be removed (but FORGET could apply to file deleted but still referenced
> by a process).
> 
> Note: if the file is opened, the inode associated to the file name
> didn't change. Hopefully.
> 
> I've tried to reproduce the problem with other virtual filesystem like
> shm / tmpfs / devtmpfs / ramfs : no problem.
> 
> I've also tried with NFS (local), and there's no problem too (the inode
> numbers reported from NFS client side are the same than the server
> side).
> 
> So it seems this a FUSE only problem, and I haven't found exactly why.
> 
> Regards.
> 
> -- 
> Yann Droneaud

------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
