Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1A7429825
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 14:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816799; cv=none; b=JgagDBN/5/U3yLink8PClFUNcTfjoFILaWfnf+LSXMyOXgBLJPTmdewi2vgMJEkuhPazcqwjR2pPzSKA8VF9niLXsgNx9eXGvn935MKilMxuDQb9CuQ9zZSOxhhHZuuohKD2QY9+1qCwtLJrduEluZnrw4ltH8ZOHMI9jVdVsJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816799; c=relaxed/simple;
	bh=T+6iFsgT87SPEWgLzu3hCDr8kqGxlENioPeKnZxRMJI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=U8fdxtbulkbzcbhrN2nZaRzIG23pvfRKVHWoE6Ix4dqS5FxxAXnDWkg/wg2374tzErxtkgaPW/ki5KHZPKA1EA9w3Dkit4Sfy6+eJD34WSFq+ke/yZjJnpj1ana0d4KCRYoEowfox8GHRBQpjDkbDc8IATmSLoIYtReogpuyEyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qXxq/SvD; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXxq/SvD"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-836c8bde2dcso10808307b3.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 07:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791816797; x=1792421597; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FFVWDWczxozE/JKYpiuM/IceiGSggYogyM8+CceBuA4=;
        b=qXxq/SvDGqur/xUpMbUtK/1QeS1xWDPTnuG5CxuxX65W4dYdN1+xn9GLxXB+u7lVfL
         2jUBfkPIShLAIluc4iMynjfCTOsB3kxJw+nKBeiRBFnDjaFyj+8avI/nQp3cUVSxQ0QA
         cRt3d45riwe6T45NFlkJoA2KNPMKDtf7Nl+FyyMnt5wfI6Na9OkHV3SbAJCrgj1RA+Zt
         2upIjUzntJJbdBaxE7wZ0LRJYpfnIOmOzEgDR74/mnweKJS+icsCprHsDbnS3Nn4/bSR
         I3Vt06Uwty5GCYtuAMBZiW2Z+VLb8SvrIvwHPcKAZrZT/g+DGEtgIJ/0Kr372YYlLqWY
         6Q6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791816797; x=1792421597;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FFVWDWczxozE/JKYpiuM/IceiGSggYogyM8+CceBuA4=;
        b=aKvSUYTnLVK78esf7KF2hTZj16kBnIaaMGFPb0nywqQ7GSNnxl0YisALQMYz0X5dfE
         Bn/PlCty+FyYEpUntW46TML3yma2v5C/2Xfxgp933cYDWtgSqhb/yAvnU5EUFd8+QFfb
         3WvGPO19Ag5cNC8c1mbd4LtEFt2daIX/WZumMJhEE0u/xrISe8FxBJ+zgUX+b0oJKCZM
         7FyEwPQ+a9xOXUFqGt7G1FbGYGivPiJi8Kfcpek/h/TTfg215jPn32jiJsUa5vGmWPQY
         DoTWVTSJVCuXEZJsb7mDTHPNBOjLvmDsn9lJL2Gwq9eI2ysC/+8VLwBxWtCZmegXhsU0
         9exA==
X-Gm-Message-State: AFq9FYKK+Qo+SpPWx65P77E2ksTKMvZYKckys4A8xY6zYDEvv/mhMHpz
	RVR2T9zHzUbPb1DS3uG3rHhO8hzRYG4Hayqx2Fig92fR00O3ehde5bSPQ1WYFQ==
X-Gm-Gg: AYBFou08pV+/GDlb2Iu2OssCz7eeTEmopqK3rO5dXnHOX7M0gD6UdQSHhIXY96KjMBP
	xqQKIM4gu9Mv8xoRe5jUz2Motgjl45bTNLrZaabeG7G5aQvSJPn0nrLezciyojoyTZLtWHOI1bf
	PiloHeaPsrtcioJrPbYKGGxCgTv3WASTP3K69Z9ri89zCi/7m2QJJavVRXQABGt6xcWNHem18Eq
	LNKjaAHnF0TJ+yOTiH9lVw5D5riQINHdnDaFF6jgyHa5t1L62GBOQJ3T+4mid7waaTxEUJHIP4h
	jHCUs5CKNEx8UWCiSWj5qdHz+ZDU3h+xJso7A1HTAH6SfWSP+agqC8Yg50WLXFhUBInoiczNlaD
	/RtYKsVyH4IYOC96N33i8OqCXfSFfWRo3C21EJWUT3qHCOwlsvGeY7Eai1G/p4ydbIHGd5Ffktu
	PqZB6jRa7AAEcf+NdNmm8D4RvU1fenJIdnaQqiBcOzVqZtFGHFKU9RDXNocjDSeu25W5HRem+G
X-Received: by 2002:a05:690c:4006:b0:8a0:5ff3:7ef9 with SMTP id 00721157ae682-8b07edc87aamr28019027b3.50.1791816796327;
        Mon, 12 Oct 2026 07:53:16 -0700 (PDT)
Received: from [127.0.0.1] ([20.120.84.82])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07f21bdb2sm35014507b3.29.2026.10.12.07.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 07:53:15 -0700 (PDT)
Message-Id: <pull.2237.v3.git.1791816795.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 Oct 2026 14:53:09 +0000
Subject: [PATCH v3 0/6] [doc] Add new page on merge conflicts
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: ps@pks.im,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Julia Evans <julia@jvns.ca>

Handling merge conflicts is difficult, and currently Git's guidance on merge
conflicts isn't giving users the information they need to navigate the
process. As usual, the process I used to write this was to collect comments
from Git users on the existing documentation, and then address those issues.
I listed the specific issues we're aiming to solve in the first commit
message in the series.

This patch series introduces a new manual page, gitmergeconflicts, which
explains the process of explaining a merge conflict with examples. It also
links to that new page from the commands which can cause merge conflicts,
instead of trying to reexplain the process every time.

Changed in v2:

 * Explain what a merge conflict is (thanks to Junio & Ben)
 * rewrite the "ours" vs "theirs" section (thanks to Patrick for the
   comments)
 * add git log --merge (thanks to Ben)
 * Leave most of the content of git cherry-pick as-is, to make this patch
   set smaller (thanks to Junio)
 * remove the SYNOPSIS since hopefully that won't be required anymore by the
   time this is merged
 * Fix a typo in git revert (s/reverted conflict/reverted commit/)
 * 's/the the/the/' (thanks to Patrick)
 * s/[doc] Thing/doc: thing/ in commit messages (thanks to Tuomas)'
 * squash the commit fixing the linter error (thanks to Junio)
 * list reviewers in Reviewed-by

Changed in v3:

Thanks to all the comments from Junio.

 * Add signoff from Marie
 * In "For example, here's a merge conflict where both sides edited a list
   of", add a little more detail about how to interpret the merge conflict
 * When we introduce a merge mention "semantic merge conflicts"
 * Say "... and any other command that does a merge" when listing commands
   that can cause merge conflicts.
 * Reviewed-by is not the right thing, use Helped-by
 * Adjust phrasing in git revert and git cherry-pick man pages
 * Reference the "ours" section in "git show :2:filename shows the "ours""
 * "there's one file left with conflicts in it: fruits.py" isn't precise
   enough, instead say "the conflicts in fruits.py haven't been marked as
   resolved"
 * Delete the explanation of zdiff3 and add a brief warning instead. Don't
   be too prescriptive, we should tell people what the issue is (ambiguity)
   instead of trying to impose our opinion.
 * Explain ||||||| when we add diff3
 * Fix example in "EXAMPLE OF RESOLVING A MERGE CONFLICT" to make it
   consistent with the other examples
 * Replace "configuration option" with "configuration variable"
 * Mention --skip instead of saying "the most common ways", which is
   ambiguous
 * Add a pointer to the extended AUTO_MERGE sentence

some non-changes in v3:

 * didn't add any extra Reviewed-by
 * "return your branch to its original state": left the same because during
   a multistep cherry-pick the branch does need to be returned to its
   original state
 * leave the explanation of AUTO_MERGE the same since Marie says it's more
   clear this way
 * leave contractions alone for now
 * don't say semantic merge applies to all merges since I think that will be
   clear to readers
 * the wording of "When Git merges two commits together" is a bit weird but
   we don't have a better idea right now
 * don't explain --left-right. Can be very easily added in the future if we
   think it's important.

Thanks to Lobo, Adam Svahn, Louis Vanier, David Turner, Ben Zanin, Salih,
and about 12 others who gave feedback on both the original git merge man
page, as well as the proposed improvements.

Julia Evans (6):
  doc: add new gitmergeconflicts man page
  doc: git-merge: link to new merge conflicts guide
  doc: git-rebase: link to new merge conflicts guide
  doc: git-revert: link to new merge conflicts guide
  doc: git-cherry-pick: link to new merge conflicts guide
  doc: git-pull: link to new merge conflicts guide

 .gitattributes                       |   1 +
 Documentation/Makefile               |   1 +
 Documentation/git-cherry-pick.adoc   |   8 +-
 Documentation/git-merge.adoc         | 125 +---------
 Documentation/git-pull.adoc          |   3 +-
 Documentation/git-rebase.adoc        |  13 +-
 Documentation/git-revert.adoc        |   5 +
 Documentation/gitmergeconflicts.adoc | 330 +++++++++++++++++++++++++++
 Documentation/meson.build            |   1 +
 command-list.txt                     |   1 +
 10 files changed, 357 insertions(+), 131 deletions(-)
 create mode 100644 Documentation/gitmergeconflicts.adoc


base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2237%2Fjvns%2Fmerge-conflicts-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2237/jvns/merge-conflicts-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2237

Range-diff vs v2:

 1:  ab0344f947 ! 1:  7aa0ae7ec3 doc: add new gitmergeconflicts man page
     @@ Commit message
          place, since it's a really nice example of a place Git has a consistent
          interface between similar commands.
      
     +    Only discuss merge, rebase, cherry-pick, and revert for now even though
     +    there are other ways that merge conflicts can happen because it's
     +    awkward to talk about `am`, `apply`, and `checkout -m`.
     +
          Co-Authored-By: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
     -    Reviewed-by: D. Ben Knoble <ben.knoble+github@gmail.com>
     -    Reviewed-by: Patrick Steinhardt <ps@pks.im>
     +    Helped-by: D. Ben Knoble <ben.knoble+github@gmail.com>
     +    Helped-by: Patrick Steinhardt <ps@pks.im>
     +    Signed-off-by: Julia Evans <julia@jvns.ca>
     +    Signed-off-by: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
       ## .gitattributes ##
     @@ Documentation/gitmergeconflicts.adoc (new)
      +-----------
      +
      +Merge conflicts can happen during a `git merge`, `git rebase`, `git
     -+cherry-pick`, `git pull`, or `git revert`. All of those commands use
     -+the same merge algorithm, and the process for resolving a merge conflict
     -+is always very similar.
     ++cherry-pick`, `git pull`, `git revert`, or any other command that does
     ++a merge. All of those commands use the same merge algorithm, and the
     ++process for resolving a merge conflict is always very similar.
      +
     -+The most common ways to handle a merge conflict are:
     ++There are 3 ways to handle a merge conflict:
      +
      +* Resolve the conflict. (see <<resolve,HOW TO RESOLVE A MERGE CONFLICT>>
      +  below for details)
     -+* Or stop the operation and return your branch to its original state
     ++* Stop the operation and return your branch to its original state
      +  with the appropriate `--abort` command, for example `git merge --abort`
      +  or `git rebase --abort`. See <<git_status,EXAMPLE: GIT STATUS OUTPUT>> below
      +  for how to find the command to run.
     ++* Or (if you're in a multi-step rebase or cherry-pick) skip the problematic
     ++  commit with the appropriate `--skip` command
      +
      +WHAT IS A MERGE CONFLICT?
      +-------------------------
     @@ Documentation/gitmergeconflicts.adoc (new)
      +  sides' edits in the file, and leaves <<markers, merge conflict markers>>
      +  that you need to resolve.
      +
     ++[NOTE]
     ++================================
     ++Even if Git successfully merges both sides with no conflicts, it's
     ++possible to end up with code that doesn't work. For example, this can
     ++happen if one side renames a function, and the other side adds a call to
     ++the old function. This is called a "semantic merge conflict".
     ++================================
     ++
      +[[markers]]
      +MERGE CONFLICT MARKERS
      +----------------------
     @@ Documentation/gitmergeconflicts.adoc (new)
      +When there's a merge conflict, Git will update the conflicted file
      +to include merge conflict markers `<<<<<<<`, `=======`, and `>>>>>>>`.
      +For example, here's a merge conflict where both sides edited a list of
     -+fruits in different ways:
     ++fruits in different ways -- one side added "cherry" and the other side
     ++added "banana":
      +
      +----
      +FRUITS = [
     @@ Documentation/gitmergeconflicts.adoc (new)
      +    "apple",
      +<<<<<<< HEAD
      +    "cherry",
     -+    "mango",
      +=======
      +    "banana",
     -+    "mango",
      +>>>>>>> add-fruit
     ++    "mango",
      +    "orange",
      +]
      +----
     @@ Documentation/gitmergeconflicts.adoc (new)
      +  See also `merge.tool` in linkgit:git-config[1] for a list of
      +  the mergetools Git supports.
      +
     -+* You can set the configuration option `merge.conflictstyle=diff3`.
     -+  See <<diff3,DIFF3 AND ZDIFF3>> below for more.
     ++* You can set the configuration variable `merge.conflictstyle=diff3`.
     ++  See <<diff3,DIFF3>> below for more.
      +
      +* `git log --merge -p <filename>`  will list all commits which
      +  caused the merge conflict for `<filename>`, and the diff
     @@ Documentation/gitmergeconflicts.adoc (new)
      +* Look at the original files.  `git show :1:filename` shows the
      +  common ancestor, `git show :2:filename` shows the "ours"
      +  version, and `git show :3:filename` shows the "theirs"
     -+  version.
     ++  version. See <<ours,"OURS" AND "THEIRS">> below for more on
     ++  "ours" and "theirs".
      +
      +Here are some ways to track your progress while handling a conflict:
      +
     @@ Documentation/gitmergeconflicts.adoc (new)
      +
      +* Use `git diff AUTO_MERGE` to show what changes you've made so far to
      +  resolve the conflicts.
     ++  See <<automerge,EXAMPLE OF USING `AUTO_MERGE`>> below for more.
      +
      +[[git_status]]
      +EXAMPLE: GIT STATUS OUTPUT
     @@ Documentation/gitmergeconflicts.adoc (new)
      +  original state
      +* you should run `git rebase --continue` when you're done resolving all
      +  the conflicts
     -+* there's one file left with conflicts in it: `fruits.py`
     ++* the conflicts in `fruits.py` haven't been marked as resolved
      +
      +----
      +$ git status
     @@ Documentation/gitmergeconflicts.adoc (new)
      +
      +
      +[[diff3]]
     -+DIFF3 AND ZDIFF3
     -+----------------
     ++DIFF3
     ++-----
      +
      +By default, Git doesn't include the original code when formatting
      +a merge conflict. To include the original code, you can set the
     -+configuration option `merge.conflictstyle` to `diff3` or `zdiff3`.
     ++configuration option `merge.conflictstyle` to `diff3`.
      +This extra context can make it much easier to understand what's
      +happening in a merge conflict.
      +
      +Here's an example of what a merge conflict would look like when using
     -+`diff3`. It shows, in order, the "ours" side of the conflict, the
     -+original code (`"mangoooo"`), and the "theirs" side of the
     -+conflict. With this view, you can see that both sides fixed the spelling
     ++`diff3`. There's an extra section (between `|||||||` and `=======`)
     ++with the original code.
     ++
     ++With this view, you can see that both sides fixed a spelling
      +mistake in "mango", and each added one fruit to the list.
      +
      +----
     @@ Documentation/gitmergeconflicts.adoc (new)
      +]
      +----
      +
     -+Here's the same example using `zdiff3`. `zdiff3` takes lines that are
     -+shared between both sides (the `"mango"` line) and moves them outside
     -+the conflicted area. This makes the conflicted area shorter, but the
     -+downside is that it's impossible to tell if `"mango"` was part of the
     -+original list of fruits or not.
     -+
     -+----
     -+FRUITS = [
     -+    "apple",
     -+<<<<<<< HEAD
     -+    "cherry",
     -+||||||| 1c22e48
     -+    "mangoooo",
     -+=======
     -+    "banana",
     -+>>>>>>> add-fruit
     -+    "mango",
     -+    "orange",
     -+]
     -+----
     -+
     ++[NOTE]
     ++================================
     ++`zdiff3` is an alternative to `diff3` that makes the merge conflict
     ++shorter by making it more ambiguous.
     ++================================
      +
      +[[ours]]
      +"OURS" AND "THEIRS"
 2:  d5241eb901 = 2:  8bdbd64ca3 doc: git-merge: link to new merge conflicts guide
 3:  72b1207045 = 3:  34ba85fcad doc: git-rebase: link to new merge conflicts guide
 4:  cfa0a8254a ! 4:  85e117b070 doc: git-revert: link to new merge conflicts guide
     @@ Documentation/git-revert.adoc: both will discard uncommitted changes in your wor
       See "Reset, restore and revert" in linkgit:git[1] for the differences
       between the three commands.
       
     -+If there have been new commits since the reverted commit, there may
     -+be a merge conflict. See linkgit:gitmergeconflicts[7]
     -+(or `git help mergeconflicts`) for a guide to handling merge conflicts.
     ++Reverting a commit may result in a merge conflict.
     ++See linkgit:gitmergeconflicts[7] (or `git help mergeconflicts`)
     ++for a guide to handling merge conflicts.
      +
       OPTIONS
       -------
 5:  62b70e9a02 ! 5:  f99c99f955 doc: git-cherry-pick: link to new merge conflicts guide
     @@ Documentation/git-cherry-pick.adoc: Given one or more existing commits, apply th
       
      -When it is not obvious how to apply a change, the following
      -happens:
     -+When it is not obvious how to apply a change, there may
     -+be a merge conflict. See linkgit:gitmergeconflicts[7]
     -+(or `git help mergeconflicts`) for a guide to handling merge conflicts.
     -+
      +When a merge conflict happens:
       
       1. The current branch and `HEAD` pointer stay at the last commit
     @@ Documentation/git-cherry-pick.adoc: happens:
       
      -See linkgit:git-merge[1] for some hints on resolving such
      -conflicts.
     --
     ++See linkgit:gitmergeconflicts[7] (or `git help mergeconflicts`)
     ++for a guide to handling merge conflicts.
     + 
       OPTIONS
       -------
     - <commit>...::
      @@ Documentation/git-cherry-pick.adoc: $ git cherry-pick -Xpatience topic^  <4>
       SEE ALSO
       --------
 6:  ac77db6762 = 6:  7831b77178 doc: git-pull: link to new merge conflicts guide

-- 
gitgitgadget
