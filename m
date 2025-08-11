Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3888F1FAC34
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 20:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754943133; cv=none; b=ngXBNSzmePEh9f7tMVdeObx64oyJsL6RGg26XATnQmBjA4fNYy0IUhnaA2ZnaNxV+vR6lwY0IYRISRDQwjvFfwIrWkbQFD8/AtPBbhEOBJPW/TQ0p16V/AZJGFSdsUvoQqHVLdLfK5qGUiyCkqQEby4yLewyW9LutBKUj9mCOEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754943133; c=relaxed/simple;
	bh=vhN+8gSO2NE6by3yiHa4KmgQE8eUHjiWmJPyiHBQ1MQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tMEKHGMWS7A6DVd2Jj5yC3Pd5mXiEnhgwQBKGjVXQIQmQ8Ex7+u73FfT/SUSaI61Tb5VX2R11UTvHAdJSCcjciVkE6zX1lxAzPUfk9ySvB4J2KCRZNH3A2qRXjrd6MDaJuAvtrAkC0nmkXli7Exec0tyh7VBHZTSqpTD1S9H2QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSG3/AFp; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSG3/AFp"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-458b49c98a7so30374955e9.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 13:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754943129; x=1755547929; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PkQGafjPFHm5AR2gFFOx59SBF1HwauSRhyK6yh8SXI=;
        b=lSG3/AFpggCgyfWe9KZF5t/FPnysLi+CqK1G3bMEr512B0cTfKsgABb5bPPOOURAXm
         TKwLy5qn4dr4Vi5wHjyP+qAfgB7pRH6iTM2k0RlxlU7uGE0wg6OJOdF1A4mIOh2i7azK
         F4OGF+QQSn5CRjrke9xJpXjPIjCrvY6VpSKOwkGaFBKXq94xVQdZvvBrKUuwwqr1sAhW
         WYQ2qvswxew6ELHGEt8SzDCKHDMpleNEM/Co+C15sIVRjmTJrSv1iXyPnjy6hn24izpE
         +ztqZBNCx9PnOapOQB+RF1T4LlStlU9So9ELdU9lPwH41LJeKk79IYWTgHpmI77m3N11
         FHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754943129; x=1755547929;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PkQGafjPFHm5AR2gFFOx59SBF1HwauSRhyK6yh8SXI=;
        b=o4REYgcoIXeSjZoH3wZtgN8YQyazoPH1m57R2gY9CwBST8S0f7fbc5xhqFrrCqBc6b
         i6MpvM2AcCR9YpTpkC+wpk6vUjccmxXXZxhw1g4SeAlJvaqNF/feEKEg/W9RpFjSWMf2
         sxJVXKv6ZEzffoTUQT+NFdC4+SwL2DE6E00i/MK0uOUpQQuGDWgoWPGyxThV92rgZH8z
         C2QJQ/J3i3OoHRx1dMNKlXbgpFS6VE6BsSpEsqnOBnFG13SX8FRRALeyn6VLmZBs6n8Q
         z3xvRJxCUkacCqJ6PjtFanNaZnLWk1d+BM9bQQP2Ivz19EOqm2wRMrKJecbfeQaltHBS
         WRJQ==
X-Gm-Message-State: AOJu0YxLkaZOR2lk44Jjh6IVOptAEAMb+0uViLc6+uvq6DAogS7xu4BS
	K40QdwRS4KUk2QW7d7FyImV5cqsSe5eNRdx16WY5Ac+PmRa3+bOJCkPylEiMCA==
X-Gm-Gg: ASbGncteAVJcjsGeM/FzRru+PvPhYFfVoNHBwwHm/s4gLQ4UtO7WAA0K90wiWdr9dPf
	I4DNfJ+nV6qNOwxACXxtigQ5El1sWzwQtpAVlU/LFRBgMMh0mmzirBbLLs9gQfEzF8Lpti/4IxY
	012dxgrNU7zhWvQjCEhL4tk5gt3PGa8R3/v1qAgyYCHupCiGBcMo/FBC8Ub3uzyJPwfYgIlB0y8
	GqQ4Q0FPJRdZbaDlQ2GdrNWNtJbj2LinW5DH0Eqs3z7NM49m4Pz9rOdY5veBAXdueVgZU6lFRbK
	YaynaS33Q0/7SGO0QmZZHJXECANN5u6bDyX3XYbSLH7xepWR6WFzTq7eaoywLhvY3hkgOUfLBrS
	KWwCCgnML5Wx9Zycf+AUohrO0BzIZCe4S6w==
X-Google-Smtp-Source: AGHT+IH/QV5aDSAsYP2R/3T1ahufJO1qx8fsvKPTwhVOOlGwb7Kgi9NbeATymtsaLir0t8Nbxh5bxQ==
X-Received: by 2002:a05:600c:a46:b0:453:5a04:b60e with SMTP id 5b1f17b1804b1-45a10c0020amr7563685e9.26.1754943128741;
        Mon, 11 Aug 2025 13:12:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458f713eb44sm393548585e9.14.2025.08.11.13.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 13:12:08 -0700 (PDT)
Message-Id: <pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v4.git.1754702057.gitgitgadget@gmail.com>
References: <pull.1949.v4.git.1754702057.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Aug 2025 20:12:02 +0000
Subject: [PATCH v5 0/5] doc: git-rebase: clarify DESCRIPTION section
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Julia Evans <julia@jvns.ca>

 * Add a note about how you can use git rebase to reorder or combine commits
 * Convert the explanation of how rebase works to an ordered list, make it
   more accurate (include how duplicate commits are removed), and remove the
   diagram showing how duplicate commits are removed. I'm happy to bring the
   diagram back if folks think it's important, but I felt like it made the
   section end in an awkward way and I'm not sure that "git rebase removes
   duplicate commits" really needs a diagram to explain it.

Julia Evans (5):
  doc: git-rebase: start with an example
  doc: git rebase: dedup merge conflict discussion
  doc: git rebase: clarify arguments syntax
  doc: git-rebase: move --onto explanation down
  doc: git-rebase: update discussion of internals

 Documentation/git-rebase.adoc | 305 ++++++++++++++++------------------
 1 file changed, 139 insertions(+), 166 deletions(-)


base-commit: 2c2ba49d55ff26c1082b8137b1ec5eeccb4337d1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1949%2Fjvns%2Fclarify-rebase-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1949/jvns/clarify-rebase-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1949

Range-diff vs v4:

 1:  07a4bdb7ce5 ! 1:  c2f2e05078f doc: git-rebase: start with an example
     @@ Metadata
       ## Commit message ##
          doc: git-rebase: start with an example
      
     -    Start with an example that mirrors the example in the `git-merge` man
     -    page, to make it easier for folks to understand the difference between a
     -    rebase and a merge.
     +    - Start with an example that mirrors the example in the `git-merge` man
     +      page, to make it easier for folks to understand the difference between
     +      a rebase and a merge.
     +    - Mention that rebase can combine or reorder commits
      
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
     @@ Documentation/git-rebase.adoc: SYNOPSIS
      +                 /
      +    D---E---F---G master
      +------------
     ++
     ++You can also use `git rebase` to reorder or combine commits: see INTERACTIVE
     ++MODE below for how to do that.
      +
       If `<branch>` is specified, `git rebase` will perform an automatic
       `git switch <branch>` before doing anything else.  Otherwise
 2:  061790686b9 ! 2:  5459b7ff560 doc: git rebase: dedup merge conflict discussion
     @@ Commit message
      
       ## Documentation/git-rebase.adoc ##
      @@ Documentation/git-rebase.adoc: shortcut for `git checkout topic && git rebase master`.
     -     D---E---F---G master
     - ------------
     + You can also use `git rebase` to reorder or combine commits: see INTERACTIVE
     + MODE below for how to do that.
       
      +If there is a merge conflict during this process, `git rebase` will stop at the
      +first problematic commit and leave conflict markers. If this happens, you can do
     @@ Documentation/git-rebase.adoc: shortcut for `git checkout topic && git rebase ma
      +3. Skip the commit that caused the merge conflict with
      +
      +   git rebase --skip
     -+
      +
       If `<branch>` is specified, `git rebase` will perform an automatic
       `git switch <branch>` before doing anything else.  Otherwise
 3:  fe9e161a51b ! 3:  948c205f1e6 doc: git rebase: clarify arguments syntax
     @@ Documentation/git-rebase.adoc: one of these things:
       
          git rebase --skip
       
     --
      -If `<branch>` is specified, `git rebase` will perform an automatic
      -`git switch <branch>` before doing anything else.  Otherwise
      -it remains on the current branch.
 4:  b37ebc8389d = 4:  e229b9fccb2 doc: git-rebase: move --onto explanation down
 5:  105a65e6e71 ! 5:  5ab235b067b doc: git-rebase: update discussion of internals
     @@ Commit message
          - make it clearer that we're talking about a multistep process
          - give a more technically accurate description how rebase works with the
            merge backend.
     -    - delete a duplicate explanation of how git rebase skips commits with
     -      the same textual changes (it's explained in more detail a few lines
     -      further down)
     +    - condense the explanation of how git rebase skips commits with the same
     +      textual changes into a single bullet point and remove the explanatory
     +      diagram. Lots of things which are more complicated are already being
     +      explained without a diagram.
          - remove the explanation of how exactly `--fork-point` and `--root`
            work since that information is in the OPTIONS section
          - put all discussion of `ORIG_HEAD` inside the note
     @@ Documentation/git-rebase.adoc: linkgit:git-config[1] for details) and the `--for
      -to point at the tip of the branch before the reset.
      +Here is a more detailed description of what `git rebase <upstream>` does:
      +
     -+First, it makes a list of all commits in the current branch that are not in
     -+`<upstream>`. This is the same set of commits that would be shown by `git log
     -+<upstream>..HEAD`. You can use `--fork-point` or `--root` to change how this
     -+list of commits is constructed.
     -+
     -+Then it checks out `<upstream>` (or `<newbase>` if the `--onto` option was
     -+supplied) with the equivalent of `git switch --detach <upstream>`.
     -+
     -+Then it replays the commits, one by one, in order. This is similar to running
     -+`git cherry-pick <commit>` for each commit. See REBASING MERGES for how merges
     -+are handled.
     -+
     -+Finally, it updates your branch to point to the final commit with the equivalent
     -+of `git switch -C <branch>`.
     ++1. Make a list of all commits in the current branch that are not in
     ++   `<upstream>`. This is the same set of commits that would be shown by `git log
     ++   <upstream>..HEAD`. You can use `--fork-point` or `--root` to change how this
     ++   list of commits is constructed.
     ++2. Check whether any of those commits are duplicates of commits already
     ++   in `<upstream>`, remove them from the list, and print out a warning about
     ++   each removed commit. You can use `--reapply-cherry-picks` to include
     ++   duplicate commits.
     ++3. Check out `<upstream>` (or `<newbase>` if the `--onto` option was
     ++   supplied) with the equivalent of `git checkout --detach <upstream>`.
     ++4. Replay the commits, one by one, in order. This is similar to running
     ++   `git cherry-pick <commit>` for each commit. See REBASING MERGES for how merges
     ++   are handled.
     ++5. Update your branch to point to the final commit with the equivalent
     ++   of `git switch -C <branch>`.
       
       [NOTE]
     -+`ORIG_HEAD` is set to point at the tip of the branch before the rebase.
     - `ORIG_HEAD` is not guaranteed to still point to the previous branch tip
     - at the end of the rebase if other commands that write that pseudo-ref
     - (e.g. `git reset`) are used during the rebase. The previous branch tip,
     - however, is accessible using the reflog of the current branch
     - (i.e. `@{1}`, see linkgit:gitrevisions[7]).
     - 
     +-`ORIG_HEAD` is not guaranteed to still point to the previous branch tip
     +-at the end of the rebase if other commands that write that pseudo-ref
     +-(e.g. `git reset`) are used during the rebase. The previous branch tip,
     +-however, is accessible using the reflog of the current branch
     +-(i.e. `@{1}`, see linkgit:gitrevisions[7]).
     +-
      -The commits that were previously saved into the temporary area are
      -then reapplied to the current branch, one by one, in order. Note that
      -any commits in `HEAD` which introduce the same textual changes as a commit
      -in `HEAD..<upstream>` are omitted (i.e., a patch already accepted upstream
      -with a different commit message or timestamp will be skipped).
      -
     - If the upstream branch already contains a change you have made (e.g.,
     - because you mailed a patch which was applied upstream), then that commit
     - will be skipped and warnings will be issued (if the 'merge' backend is
     +-If the upstream branch already contains a change you have made (e.g.,
     +-because you mailed a patch which was applied upstream), then that commit
     +-will be skipped and warnings will be issued (if the 'merge' backend is
     +-used).  For example, running `git rebase master` on the following
     +-history (in which `A'` and `A` introduce the same set of changes, but
     +-have different committer information):
     +-
     +-------------
     +-          A---B---C topic
     +-         /
     +-    D---E---A'---F master
     +-------------
     +-
     +-will result in:
     +-
     +-------------
     +-                   B'---C' topic
     +-                  /
     +-    D---E---A'---F master
     +-------------
     ++When starting the rebase, `ORIG_HEAD` is set to point to the commit at the tip
     ++of the to-be-rebased branch. However, `ORIG_HEAD` is not guaranteed to still
     ++point to that commit at the end of the rebase if other commands that change
     ++`ORIG_HEAD` (like `git reset`) are used during the rebase. The previous branch
     ++tip, however, is accessible using the reflog of the current branch (i.e. `@{1}`,
     ++see linkgit:gitrevisions[7].
     + 
     + MODE OPTIONS
     + ------------

-- 
gitgitgadget
