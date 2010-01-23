From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 7/7] Documentation: simplify How Merge Works
Date: Sat, 23 Jan 2010 03:48:42 -0600
Message-ID: <20100123094842.GH7571@progeny.tock>
References: <20100123092551.GA7571@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 10:48:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYcbn-00046q-Gy
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 10:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700Ab0AWJsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 04:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752506Ab0AWJsm
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 04:48:42 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:43981 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457Ab0AWJsl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 04:48:41 -0500
Received: by iwn16 with SMTP id 16so822357iwn.33
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 01:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=HmDTTq1L+UrNxFUz2zn3a8vtsZv7bC0nA108cityyFQ=;
        b=fc7UOtrOrfQaso7r1gDcb9KOXYZnUZYxYWG50gljWxz560167UUAtbjJ5ZSKkTk6I0
         rz2UxdFPT32Hdu1xltUbZAJi3a8goz5micXAbnYfDdb2ws/iemDLzb6KUWRpnCld7GhR
         6s1zKDsKNJoysvTFxLaHjurR8EedBYqKyMXT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Cj45CBN8vdIszVAkoDkohEWNYXVm63q+qteqAhpxLzWsdm384/6EZU2YgmJL0oQv+g
         ROTVH08eIr9JK/OT8GYPaBENhaGdOi4rOpm7A4YNWlR3QDCw1npK3QoFiH2ipQPGNCDi
         xnMj/W+mobN0kmg4guxbGDu4h4a/9Icgyuw28=
Received: by 10.231.170.14 with SMTP id b14mr52511ibz.26.1264240120812;
        Sat, 23 Jan 2010 01:48:40 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm2601328iwn.1.2010.01.23.01.48.40
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 01:48:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100123092551.GA7571@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137825>

The user most likely does not care about the exact order of
operations because he cannot see it happening anyway.  Instead,
try to explain what it means to merge two commits into a single
tree.

While at it:

 - Change the heading to TRUE MERGE.  The entire manual page is
   about how merges work.

 - Document MERGE_HEAD.  It is a useful feature, since it makes
   the parents of the intended merge commit easier to refer to.

 - Do not assume commits named on the 'git merge' command line come
   from another repository.  For simplicity, the discussion of
   conflicts still does assume that there is only one and it is a
   branch head.

 - Do not start list items with `code`.  Otherwise, a toolchain bug
   produces a line break in the generated nroff, resulting in odd
   extra space.

Suggested-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This is the end of series.  Thanks for reading.

Thomas Rast wrote: [1]

> So how about
[...]
> and then snip everything up to

Oh!  Much better, thanks.

[1] http://thread.gmane.org/gmane.comp.version-control.git/136356/focus=136629

 Documentation/git-merge.txt |   52 +++++++++++++-----------------------------
 1 files changed, 16 insertions(+), 36 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 0b86f2b..7aa3f3f 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -100,52 +100,32 @@ merge commit.
 
 This behavior can be suppressed with the `--no-ff` option.
 
-HOW MERGE WORKS
----------------
-
-A merge is always between the current `HEAD` and one or more
-commits (usually a branch head or tag).
+TRUE MERGE
+----------
 
 Except in a fast-forward merge (see above), the branches to be
 merged must be tied together by a merge commit that has both of them
 as its parents.
-The rest of this section describes this "True merge" case.
-
-The chosen merge strategy merges the two commits into a single
-new source tree.
-When things merge cleanly, this is what happens:
-
-1. The results are updated both in the index file and in your
-   working tree;
-2. Index file is written out as a tree;
-3. The tree gets committed; and
-4. The `HEAD` pointer gets advanced.
 
-Because of 2., we require that the original state of the index
-file matches exactly the current `HEAD` commit; otherwise we
-will write out your local changes already registered in your
-index file along with the merge result, which is not good.
-Because 1. involves only those paths differing between your
-branch and the branch you are merging
-(which is typically a fraction of the whole tree), you can
-have local modifications in your working tree as long as they do
-not overlap with what the merge updates.
+A merged version reconciling the changes from all branches to be
+merged is committed, and your `HEAD`, index, and working tree are
+updated to it.  It is possible to have modifications in the working
+tree as long as they do not overlap; the update will preserve them.
 
-When there are conflicts, the following happens:
+When it is not obvious how to reconcile the changes, the following
+happens:
 
-1. `HEAD` stays the same.
-
-2. Cleanly merged paths are updated both in the index file and
+1. The `HEAD` pointer stays the same.
+2. The `MERGE_HEAD` ref is set to point to the other branch head.
+3. Paths that merged cleanly are updated both in the index file and
    in your working tree.
-
-3. For conflicting paths, the index file records up to three
-   versions; stage1 stores the version from the common ancestor,
-   stage2 from `HEAD`, and stage3 from the other branch (you
+4. For conflicting paths, the index file records up to three
+   versions: stage 1 stores the version from the common ancestor,
+   stage 2 from `HEAD`, and stage 3 from `MERGE_HEAD` (you
    can inspect the stages with `git ls-files -u`).  The working
    tree files contain the result of the "merge" program; i.e. 3-way
-   merge results with familiar conflict markers `<<< === >>>`.
-
-4. No other changes are done.  In particular, the local
+   merge results with familiar conflict markers `<<<` `===` `>>>`.
+5. No other changes are made.  In particular, the local
    modifications you had before you started merge will stay the
    same and the index entries for them stay as they were,
    i.e. matching `HEAD`.
-- 
1.6.6
