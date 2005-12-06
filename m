From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [BUG] ProgramError: merge ... .merge_file_4CPoEQ: No such file
Date: Tue, 6 Dec 2005 17:33:14 +0100
Message-ID: <20051206163314.GA6112@c165.ib.student.liu.se>
References: <E1EjdPu-00034z-Hu@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 17:37:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjflB-0008DO-Qi
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 17:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbVLFQdY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 11:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbVLFQdX
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 11:33:23 -0500
Received: from [85.8.31.11] ([85.8.31.11]:33988 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S932292AbVLFQdW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2005 11:33:22 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 8AE9F4117; Tue,  6 Dec 2005 17:43:16 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1Ejfkg-0001ao-00; Tue, 06 Dec 2005 17:33:14 +0100
To: Jon Loeliger <jdl@freescale.com>
Content-Disposition: inline
In-Reply-To: <E1EjdPu-00034z-Hu@jdl.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13276>

On Tue, Dec 06, 2005 at 08:03:38AM -0600, Jon Loeliger wrote:
> 
> jdl@ubuntu:/usr/src/git-core$ git pull . origin
> Trying really trivial in-index merge...
> fatal: Merge requires file-level merging
> Nope.
> Merging HEAD with be61db922a230ae2638c27c071ee4b8c98f01f72
> Merging:
> 4baf91676c2462796137e93917c75f2e14ebb877 Added documentation for few missing options.
> be61db922a230ae2638c27c071ee4b8c98f01f72 git-merge-one-file: resurrect leading path creation.
> found 1 common ancestor(s):
> 23c99d84601316c1e51ebc1f0b9bec5cddd011fb git-mv to work with Perl 5.6
> Auto-merging Documentation/git-read-tree.txt
> Traceback (most recent call last):
>   File "/home/jdl/bin/git-merge-recursive", line 868, in ?
>     firstBranch, secondBranch, graph)
>   File "/home/jdl/bin/git-merge-recursive", line 87, in merge
>     branch1Name, branch2Name)
>   File "/home/jdl/bin/git-merge-recursive", line 160, in mergeTrees
>     if not processEntry(entry, branch1Name, branch2Name):
>   File "/home/jdl/bin/git-merge-recursive", line 821, in processEntry
>     branch1Name, branch2Name)
>   File "/home/jdl/bin/git-merge-recursive", line 212, in mergeFile
>     src1, orig, src2], returnCode=True)
>   File "/home/jdl/share/git-core/python/gitMergeCommon.py", line 72, in runProgram
>     raise ProgramError(progStr, e.strerror)
> ProgramError: merge -L HEAD/Documentation/git-read-tree.txt -L orig/Documentation/git-read-tree.txt -L be61db922a230ae2638c27c071ee4b8c98f01f72/Documentation/git-read-tree.txt .merge_file_DamWnQ .merge_file_U9K5YP .merge_file_4CPoEQ: No such file or directory
> No merge strategy handled the merge.
> 

It seems that changes has been committed to
Documentation/git-read-tree.txt in both the jdl branch and in
origin. This shouldn't cause any problems but git-merge-recursive
(which currently is the default merge strategy) uses merge(1) to do
the file-level merging and it seems like merge(1) can't be found on
your system.

Do you have merge(1) installed? More appropriately, is merge in your
path? If it isn't installed it can usually be found in the rcs package
in your distribution.


- Fredrik
