Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792764297;
	b=lT8wPv5YcRNE774oRHpPNbpxKnYGnDPRs7/e38YnRAd8bm2ymGQo4cuFPQv+oEGPx5qz
	 F91mYaP+2DHq0QgpqNzskxEBjGWGSyewoBasAJVcb9QBXb2kLPwUkW+Ho0CCKHVjx1os1
	 J6MD2n8Vppw0ZPGrdl7IGPfleVVK6pn/oMVzKKfnBPBmfNm9CEMt8VmByfySMHAKK0ICt
	 yZux89VettU1waZFJNXLkPZduHJGoNZlAn6gJGAcw1utOxCQ3KJTvVQ8KoO3Rc0YZNDAi
	 xKEsq6QPz1f3UJhecrHk68nUkcROn0YIYsavySZPCqpD8iK3lgKqnNwaFIN/UC1Ch1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=/gURVKTf1geBz7NTM4dzBOtxO0V4bHh0aFEqIEDjkjQ=;
	b=sluejeSok1bFPa89+mKdzp/X6NevsIdgNqeWnbQPfKISCGtxpZF5l2rINzuexRkAcifv
	 FfhyCyJRkLPyGzuupN6suJa0Yp6GHzyZctrat7eWxnsvYc3Qwy2qvgxOKC7+msGAcEjs4
	 1DA5Qq+1pnnGuIJwABHKnnXm4cm7ICfUnp6IBwhHZus1cbQTK+6wMuP4DvZm6t7YcwPuA
	 fF731GUiu+wAQtEkXvjxaAdiU3calTag/foQxt6tANdZPEU94SzC8+fQLb1HY4nbAzMNO
	 tRaU/spYFlUw7CrbrJycF1P46WggGx5H2C2gDfEmxwjKd/YUjDVtzDzsscmoeOPl95A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DPcFTJ3H;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ACF606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 14:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4ACF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DPcFTJ3H
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-536717a4d83so7612001cf.2
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792764296; x=1793369096; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/gURVKTf1geBz7NTM4dzBOtxO0V4bHh0aFEqIEDjkjQ=;
        b=DPcFTJ3HAlv9D4wq+alnHUXoQ3FxIMV6KcEGc6tFJmCo67kuEaZVXjeurqgJE0SmEp
         ik42hQxsflQZHDMUK68okGg2Ph2dVxtrUy38xsSWV9IbwmG5HdkJFtzLvkNJ+A+kYprl
         ekMKN4V+YYja3iUEttt+VemEKJ3oWZgIeR6pyJ6GJpxgZzxyAV9v+MzuzwxkwsmhRXhk
         1cEg/gjNW/ngrQRHasrA9b7ec5ZBEcwCm5BpREECZJgWv6gUgqUkmNmVoBF1tJmQLRYp
         jlPeAPsWZzR2ENYB/MFqGzjGWiu9bbyOBi+DCwbz/YqRmhh6dcfXBwA+6CMlqh5gkXof
         7O8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792764296; x=1793369096;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/gURVKTf1geBz7NTM4dzBOtxO0V4bHh0aFEqIEDjkjQ=;
        b=EkRmtYvYa6dVXZTwWP3z90fxPqn8jJpe4RI7w75QLW48T7YqZSR4VPPYBxZJqPqaFc
         EyBTVYKl3cTp57cYGGzxioJZO/N5R12jZer5rA+RT73zKXc6GheXCOaOJ36W42QJ9qxj
         ScgsmYvB4Zpxadd++ypqwuTWvUAZF0Mr45tYWdIazfc7EWUm5e8EqJAbK3CILzsK0Hbt
         tS3O1eIM6+usFgRn1MKkkrYbvLIo+qge8OTvhUfYPW7jXvkfhax9Rme3YuBavGJgAEC6
         7oIJn8Fvv8DVeT7t82mmE08iioNmRBkqwI2Xsq3zUIXzUhpb9j2QwXGNpvpTetBo1oPr
         8JIg==
X-Gm-Message-State: AFq9FYKwdhq3yaL3NezgILMue8hLFnhVL8FR6mdeWOpH53DwG8zVkDgZ
	W1/JqZJ8Us3oaPcdtdC480WYmF2DhiMWR2sY2LuhXKIPgfRBRUCQmz97euKYL/L6hj8=
X-Gm-Gg: AYBFou3dIsYRFn76zSHdKOYBFQQJZ3Y+bs5c8VU0tcbWTkQ0wtifnCwTq+p2GqXJO4m
	qixsRTM3pXcxMb009UNSthpJSHUzGB1p77WfL6F3Cy5Qe+oAd7S5Mnnh8/YqfDM9AIwGXXbkvZh
	6GYorOPeNtLzxx8e7FpQxW7mFjdDEBPA3WUDOcdHSy+lgHnKpB75k2roZk2Z/jIL65Ltwa0//2y
	exSsTO0feOd9z+K46fuBC9wAP29DiB6z/VOGmCQuybureifhiDJGrWNoZ1+vU/MpzTCF66gnyzQ
	lh0Gz4JeeZ4rbmY3+CFOLCNFXanYOs9lVyayn+NSbMPgkra7l7US3ubwPn+QGbblg813FphbQ+o
	panmxz09bwJ9q2JZ5xTe/PSnDL9aZdWea0OL5/KvCis8fjgRegopD1Y3rw4DTUo9OOuHMWdSWUB
	XId4VdGVIjvAb+bF7C9rk1QrUGsZcbixZMzJU1D2pbAeQhOMH7D5bD0AqrHakO+N5RXxvInfR+C
	uKXbjJxejvYlamSZd9WtOHhiGmQ2tAgrEtMbTAV2bK9yZ1Vn5brDz9MjA==
X-Received: by 2002:a05:620a:4511:b0:93f:1af1:7952 with SMTP id af79cd13be357-93f6f5a3313mr428671185a.4.1792764295242;
        Fri, 23 Oct 2026 07:04:55 -0700 (PDT)
Received: from [127.0.0.1] ([20.83.174.58])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9402ee30498sm27324885a.3.2026.10.23.07.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 07:04:53 -0700 (PDT)
Message-Id: <pull.2237.v4.git.1792764293.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 14:04:47 +0000
Subject: [PATCH v4 0/6] [doc] Add new page on merge conflicts
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
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

Changed in v4:

changes to the content:

 * use Junio's much better example for diff3
 * clarify in the commit message why we're not mentioning git apply: to
   avoid dealing with patches (thanks to Junio)
 * adjust the wording around "multi-step operation like a rebase" (thanks to
   Junio)
 * Say "see git-config for more" in the description of zdiff3. Like Patrick
   said the explanation of zdiff3 is not really satisfiying, but I don't
   know how to write a satisfying explanation, and it's better to have a
   short and obviously unsatisfying explanation than a long unsatisfying
   one. Added a note in the commit message that perhaps this should be
   improved in the future. (from Patrick's comment)

changes cleaning things up:

 * add periods at the ends of various sentences in an attempt to be more
   consistent (thanks to Junio & Patrick)
 * Adjust the formatting around the [NOTE] to make the CI whitespace check
   pass
 * Replace a couple of instances of "code" with "lines" (thanks to Junio)
 * Fix Ben's email address (thanks to Ben)
 * Remove the double signoff (thanks to Ben).
 * Make the cherry-pick commit message more accurate (thanks to Patrick)

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
 Documentation/gitmergeconflicts.adoc | 339 +++++++++++++++++++++++++++
 Documentation/meson.build            |   1 +
 command-list.txt                     |   1 +
 10 files changed, 366 insertions(+), 131 deletions(-)
 create mode 100644 Documentation/gitmergeconflicts.adoc


base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2237%2Fjvns%2Fmerge-conflicts-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2237/jvns/merge-conflicts-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2237

Range-diff vs v3:

 1:  7aa0ae7ec3 ! 1:  486a77dbd7 doc: add new gitmergeconflicts man page
     @@ Commit message
      
          - The process for resolving a merge conflict is only explained in the
            `git merge` man page, even though there are several other commands
     -      which can result in conflicts
     +      which can result in conflicts.
          - Sometimes we use "ours" and "theirs" to refer to the two sides of
            the merge conflicts and sometimes we use HEAD and MERGE_HEAD. It should
            be consistent. Also the terms "ours" and "theirs" are not explained.
            Similarly, it says "The part before the `=======` is typically your
            side...", but doesn't explain what "typically" means.
          - It introduces the merge format using an analogy to RCS, which very few
     -      Git users have ever used
     +      Git users have ever used.
          - In "The only clean-ups you need are to reset the index file to the
            `HEAD` commit to reverse 2. and to clean up working tree changes made
            by 2. and 3.", it's not clear to users what "2" and "3" are supposed
     -      to mean
     +      to mean.
          - It uses a cultural reference ("Conflict resolution is hard; let's go
            shopping.") which is confusing or unfamiliar to some people. I think it
            would be clearer for users to use a code example instead.
     -    - It doesn't explain the difference between diff3 and zdiff3
     -    - It sometimes uses the term "area" and sometimes uses the term "hunk"
     +    - It doesn't explain the difference between diff3 and zdiff3.
     +    - It sometimes uses the term "area" and sometimes uses the term "hunk".
      
          Also document the unified `--abort`, `--continue` workflow in one
          place, since it's a really nice example of a place Git has a consistent
          interface between similar commands.
      
          Only discuss merge, rebase, cherry-pick, and revert for now even though
     -    there are other ways that merge conflicts can happen because it's
     -    awkward to talk about `am`, `apply`, and `checkout -m`.
     +    there are other ways that merge conflicts can happen to avoid getting
     +    into the difference between applying a patch and doing a 3-way merge.
     +
     +    Things to potentially improve in future docs revisions:
     +
     +    - The explanation of zdiff3 is unsatisfying. It would be good if we
     +      could have a clear example of a case where zdiff3 is helpful and a
     +      case where it's harmful, and if we could give a better sense for
     +      the reasons why users are actually choosing zdiff3 over diff3
     +      (or the reverse) in real life.
      
          Co-Authored-By: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
     -    Helped-by: D. Ben Knoble <ben.knoble+github@gmail.com>
     +    Helped-by: D. Ben Knoble <ben.knoble@gmail.com>
          Helped-by: Patrick Steinhardt <ps@pks.im>
     -    Signed-off-by: Julia Evans <julia@jvns.ca>
          Signed-off-by: Marie Claire LeBlanc Flanagan <hello@marieflanagan.com>
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
     @@ Documentation/gitmergeconflicts.adoc (new)
      +  with the appropriate `--abort` command, for example `git merge --abort`
      +  or `git rebase --abort`. See <<git_status,EXAMPLE: GIT STATUS OUTPUT>> below
      +  for how to find the command to run.
     -+* Or (if you're in a multi-step rebase or cherry-pick) skip the problematic
     -+  commit with the appropriate `--skip` command
     ++* Or (if you're in a multi-step operation like a rebase) skip the problematic
     ++  commit with the appropriate `--skip` command.
      +
      +WHAT IS A MERGE CONFLICT?
      +-------------------------
     @@ Documentation/gitmergeconflicts.adoc (new)
      +  that you need to resolve.
      +
      +[NOTE]
     -+================================
      +Even if Git successfully merges both sides with no conflicts, it's
      +possible to end up with code that doesn't work. For example, this can
      +happen if one side renames a function, and the other side adds a call to
      +the old function. This is called a "semantic merge conflict".
     -+================================
      +
      +[[markers]]
      +MERGE CONFLICT MARKERS
     @@ Documentation/gitmergeconflicts.adoc (new)
      +When there's a merge conflict, Git will update the conflicted file
      +to include merge conflict markers `<<<<<<<`, `=======`, and `>>>>>>>`.
      +For example, here's a merge conflict where both sides edited a list of
     -+fruits in different ways -- one side added "cherry" and the other side
     -+added "banana":
     ++fruits in different ways -- one side has "cherry" and the other side
     ++has "banana":
      +
      +----
      +FRUITS = [
     @@ Documentation/gitmergeconflicts.adoc (new)
      +]
      +----
      +
     -+The code from one side of the merge conflict is between `<<<<<<<` and
     -+`=======`, and the code for the other side is between `=======` and
     ++The lines from one side of the merge conflict is between `<<<<<<<` and
     ++`=======`, and the lines from the other side is between `=======` and
      +`>>>>>>>`. See <<ours,"OURS" AND "THEIRS">> below for a full explanation
      +of which side is which.
      +
     @@ Documentation/gitmergeconflicts.adoc (new)
      +
      +The process for resolving a merge conflict is:
      +
     -+1. Run `git status` to get a list of files with merge conflicts
     ++1. Run `git status` to get a list of files with merge conflicts.
      +2. For each one, find the conflict markers
     -+   (the `<<<<<<<`, `=======`, `>>>>>>>`) and edit the code to
     -+   fix the conflict
     -+3. Run `git add FILENAME` for each file to mark the conflict as resolved
     ++   (the `<<<<<<<`, `=======`, `>>>>>>>`) and edit the file to
     ++   fix the conflict.
     ++3. Run `git add FILENAME` for each file to mark the conflict as resolved.
      +4. Run the appropriate `--continue` command to continue the operation
      +   that was interrupted by the conflict, for example `git merge --continue`
      +   or `git rebase --continue`. See <<git_status,EXAMPLE: GIT STATUS OUTPUT>>
     @@ Documentation/gitmergeconflicts.adoc (new)
      +* You can set the configuration variable `merge.conflictstyle=diff3`.
      +  See <<diff3,DIFF3>> below for more.
      +
     -+* `git log --merge -p <filename>`  will list all commits which
     ++* `git log --merge --patch <filename>`  will list all commits which
      +  caused the merge conflict for `<filename>`, and the diff
      +  of how they changed the file.
      +
     @@ Documentation/gitmergeconflicts.adoc (new)
      +`diff3`. There's an extra section (between `|||||||` and `=======`)
      +with the original code.
      +
     -+With this view, you can see that both sides fixed a spelling
     -+mistake in "mango", and each added one fruit to the list.
     -+
      +----
      +FRUITS = [
      +    "apple",
     @@ Documentation/gitmergeconflicts.adoc (new)
      +    "cherry",
      +    "mango",
      +||||||| 1c22e48
     ++	"banana",
     ++	"cherry",
      +    "mangoooo",
      +=======
      +    "banana",
     @@ Documentation/gitmergeconflicts.adoc (new)
      +]
      +----
      +
     ++With this view, you can see that both sides fixed a spelling
     ++mistake in "mango", and each removed one fruit to the list.
     ++This makes it more clear how to resolve the merge conflict: since one
     ++side removed `banana` and one side removed `cherry`, it would probably
     ++make sense to remove both from the list, like this:
     ++
     ++----
     ++FRUITS = [
     ++    "apple",
     ++    "mango",
     ++    "orange",
     ++]
     ++----
     ++
      +[NOTE]
     -+================================
      +`zdiff3` is an alternative to `diff3` that makes the merge conflict
     -+shorter by making it more ambiguous.
     -+================================
     ++shorter by making it more ambiguous. See linkgit:git-config[1] for more.
      +
      +[[ours]]
      +"OURS" AND "THEIRS"
 2:  8bdbd64ca3 = 2:  6862cb4f04 doc: git-merge: link to new merge conflicts guide
 3:  34ba85fcad = 3:  2bd9850822 doc: git-rebase: link to new merge conflicts guide
 4:  85e117b070 = 4:  53083b48a3 doc: git-revert: link to new merge conflicts guide
 5:  f99c99f955 ! 5:  92cfdf260c doc: git-cherry-pick: link to new merge conflicts guide
     @@ Metadata
       ## Commit message ##
          doc: git-cherry-pick: link to new merge conflicts guide
      
     -    Remove the discussion of merge conflicts and replace it with a link to
     -    the guide.
     -
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
       ## Documentation/git-cherry-pick.adoc ##
 6:  7831b77178 = 6:  bbbf44aff1 doc: git-pull: link to new merge conflicts guide

-- 
gitgitgadget
