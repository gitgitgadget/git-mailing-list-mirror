From: Paul Mackerras <paulus@samba.org>
Subject: Re: Version of dirdiff to display diffs between git trees
Date: Sat, 7 May 2005 10:01:18 +1000
Message-ID: <17020.1358.415173.230113@cargo.ozlabs.ibm.com>
References: <17019.28326.351036.268948@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0505060916320.2233@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 01:55:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUCfL-0006r9-Ur
	for gcvg-git@gmane.org; Sat, 07 May 2005 01:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVEGABr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 20:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVEGABr
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 20:01:47 -0400
Received: from ozlabs.org ([203.10.76.45]:23985 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261413AbVEGABH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 20:01:07 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 4EA8B679F3; Sat,  7 May 2005 10:01:02 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505060916320.2233@ppc970.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds writes:

> If you use git-pull-script, it does this for you (except it calls it

OK, cool

> ORIG_HEAD), and you can just do
> 
> 	git-diff-tree -p ORIG_HEAD HEAD
> 
> to see the changes. In fact git-pull-script will do that for you, and 
> output the diffstat of it.

Yes, girdiff with two trees is mostly equivalent to git-diff-tree,
except that I find the girdiff/dirdiff display much easier to nagivate
and parse than a patch viewed in an xterm with less.  (I say "mostly
equivalent" because if neither tree is the ancestor of the other,
girdiff looks at the common ancestor to get an idea of which tree has
the more recent version of each file that differs, and colors that one
green and the other red, which is extra information that git-diff-tree
doesn't give you.)

Similarly, girdiff with a tree and "." is equivalent to
git-diff-cache.

Girdiff also has the new dirdiff features of being able to expand the
displayed context for a hunk, to move changed lines up and down within
a hunk (provided the movement doesn't change the meaning of the diff),
and to split context lines into identical -/+ lines (which, together
with being able to move -/+ lines makes it possible to rearrange a
diff to make it more understandable).

If the working directory is one of the trees being diffed, you can
select parts of the diff for a file to be applied to the working
directory file.  (You can't apply changes to a git tree, of course,
because it's immutable.)  You can also select parts of the diff for a
file and generate a patch embodying just the selected changes.

Next I want to do a commit viewer with the ability to display the
differences between arbitrary points in the commit tree using girdiff.

Paul.
