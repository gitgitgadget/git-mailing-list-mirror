Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26642D47E5
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918207; cv=none; b=oq/AOCMNetcftgbogQUaPrcxXV4AXySulbgA1G305+tiN4VJFwYM8zvqJhJEuRR14GlbxJaDH8WRKlE+FIGag+OstpATfxGF0ZFzo9x1W5VLD9yNPCZoXozX2eJGLvGXPmkvltw+N0qkFznVryKrP2Ur3e1+bNLjRGXZHIdKPhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918207; c=relaxed/simple;
	bh=g7kPMxp/PDQWntSHdt8aRyB9SSg5Ng/WdHpoB+xJfIE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uuJuZ7MGtvYEYXYvSZdg0Ji3gBpQ6VxlJ8pStZh2C5uVe5sq4JJybC0Q5GqaeM4Ksx+R10xn5KJIUqyyOdA7ppAG+BHJAO4YhDn221TvwXYwFCJ60zonrAdNqGhoBfGVTx5KRNRdzMWWm6AWtDJ05w7DqA4TRk6VIz0we/4bqRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xhwe/0Dr; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xhwe/0Dr"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b3d3f6360cso1624861cf.0
        for <git@vger.kernel.org>; Wed, 03 Sep 2025 09:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756918204; x=1757523004; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqinHlBHkA0sINjAZtW+MMIK24ijkEKY1UyqrZuj8us=;
        b=Xhwe/0DrNx7X6bx/kzrgfyCYPDz5+lUjM0H2nJNDpuLgnXfpCnkAAJoMcGbNAvnMNL
         h175I4AOd+79h3cUC45/DDAoHtYN7vZ4hguNgcj5nwFoXzQeegR5g3+prt9nWWejgCtG
         1iIap8GHV7YEx8vTeSZhvsN1ZffOzVv0aBGzw5zUHi47ykd22osmKqoJX7Lee7RZTQak
         KYD3DmdgrIrMATnhx2/IrA8OFY7+jJI59wQECnXMxUyBmevHA1C5sJm/mfZn+xzbkTmq
         VO+soZoBbvZE3G1kcB86GBzwZPB/Rgg27WrQ4+T7Kq62Q/a11+2FdoXK+YKKRGDMFqdx
         D6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756918204; x=1757523004;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqinHlBHkA0sINjAZtW+MMIK24ijkEKY1UyqrZuj8us=;
        b=mai6x9d6BJ+YN1tuCpMrviLaIY6dKvqgw9e8FTW7K9EwqWXHr0l8jgb3e4c7eCaHBc
         20mGYvX8fU+f5dnr/CRsqu++F9QDAPhKLAxWZs/mrFmNj10HDXm3xukXM1qT7vM0hIpU
         WkXq9OGFcjaw4nso9kDirzNUpE9plWZEdX/ph/GMJ1dxU5MJs0WxBMzHw0Jc5akJdRcL
         jZTjx1iDY8PCWT8qAdeB145254Wz9YTj3Ti3j4wWEbveHVfXwYufjdEUJgEprSC8qoZB
         cumIY05KseJi45tBAQlW9cKvij2rFVpRqkz085WfOGVNaZqnOC/SMVUGMscgZIsqhCce
         yexQ==
X-Gm-Message-State: AOJu0Yz667fsuF+lWSCrEwsN5yGgoEwuJ+zo9uWeMhMtLlYavMGuO/PC
	Q5xwODpmPa47C+7DlNlbgdF/rrV8uwyj6K6grZG5V7B1RoToohQ6x1eApCdCKQ==
X-Gm-Gg: ASbGncv2VPnsXxisWBUiSx5+wYavzkehPa5KdNzZ7D4uz0GxJKCHHdzreQX9ayq4f+q
	WJicHx84N4Hm2rcOKyX3bJi22pZGABOfgBoCWPw4JSkmStyMkp3VY+3/IjZwHO7T8B4TU+3BsvX
	eb3kpC3FzmuuLrk3CwgYEsnY0+nth9WaHxe7YhmKmHOC2lwLzy7oZJGjz8Mw9IoB4n9NAP/fcOD
	GfTTzcntWi/0l9UEnqpo/HHFzt9IdWcKqkgRZD5SbY6Q66VYbcaiC5zu9r3Po8iE/jJIFJ6eqVa
	XBxmgtm4NS9Fxv2omw6PiXVr27CUtpBg1QHyq8HddZlHZZlUARGhb2Hny7AuR3U5a7c0knw0kra
	90GSOaBQhN+FWTc2Do4rnyOvOEsYCLTHvup8=
X-Google-Smtp-Source: AGHT+IEttFbPf//0RfKEMhi6LqaoNszqN9HTXo1ZQ82eZZRVcmtZrxnFVQyQMkXt+zsQoMFAvmIKAQ==
X-Received: by 2002:ac8:5a12:0:b0:4b2:ffa1:3aae with SMTP id d75a77b69052e-4b31da00402mr201268861cf.31.1756918204026;
        Wed, 03 Sep 2025 09:50:04 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.213.113])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b5d57c6e0asm1183741cf.51.2025.09.03.09.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:50:03 -0700 (PDT)
Message-Id: <pull.1962.v3.git.1756918202.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v2.git.1756467934.gitgitgadget@gmail.com>
References: <pull.1962.v2.git.1756467934.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 03 Sep 2025 16:49:56 +0000
Subject: [PATCH v3 0/6] doc: git-checkout: clarify DESCRIPTION section
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
    Julia Evans <julia@jvns.ca>

 * Improve the storytelling in the commit messages
 * Take a different approach to the git checkout -b description (keep reset
   in -B, but simplify the description of -B a lot)
 * Make the description of git checkout [<branch>] more accurate.
 * Try a different approach to git checkout file.txt ("Discard any unstaged
   changes...")

Julia Evans (6):
  doc: git-checkout: clarify intro
  doc: git-checkout: clarify `git checkout <branch>`
  doc: git-checkout: clarify `-b` and `-B`
  doc: git-checkout: deduplicate --detach explanation
  doc: git-checkout: split up restoring files section
  doc: git-checkout: clarify restoring files section

 Documentation/git-checkout.adoc | 147 ++++++++++++++++----------------
 1 file changed, 72 insertions(+), 75 deletions(-)


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1962%2Fjvns%2Fclarify-checkout-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1962/jvns/clarify-checkout-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1962

Range-diff vs v2:

 1:  48e7f23029 ! 1:  1975384dd0 doc: git-checkout: clarify intro
     @@ Metadata
       ## Commit message ##
          doc: git-checkout: clarify intro
      
     -    - Many users do not understand the terms "index" or "pathspec". Clarify
     -      in the intro by using an example, so that users can understand the
     -      basic idea without learning the full definition of "pathspec".
     -    - Use the terminology "Switch" and "Restore" to mirror `git switch`
     -      and `git restore`
     -    - Reference (and clarify) the ARGUMENT DISAMBIGUATION section
     +    - Reduce use of jargon ("index", "pathspec", "tree") by using an
     +      example, and by mirroring the "switch" and "restore" language from the
     +      first line of the man page.
     +    - Reference and clarify the ARGUMENT DISAMBIGUATION section, as well
     +      as fixing a small error (in "`git checkout abc`, `abc` is a commit,
     +      not a `_<tree-ish>_`)
      
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
     @@ Documentation/git-checkout.adoc: $ git log -g -2 HEAD
      -to checkout these paths out of the index.
      +When you run `git checkout <something>`, Git tries to guess whether
      +`<something>` is intended to be a branch, a commit, or a set of file(s),
     -+and then switches branches, switches commits, or restores the files.
     ++and then either switches to that branch or commit or restores the
     ++specified files.
      +
      +If there's any ambiguity, Git will treat `<something>` as a branch or
      +commit, but you can use the double dash `--` to force Git to treat the
 2:  23a738981a ! 2:  940cd17e7e doc: git-checkout: clarify `git checkout <branch>`
     @@ Metadata
       ## Commit message ##
          doc: git-checkout: clarify `git checkout <branch>`
      
     -    - "To prepare for working on _<branch>_..." is confusing to some users:
     -      it makes it sound like these are steps that the user has to do, not
     -      steps that Git itself will do. Reword it.
     -    - Use "changes" instead of "modifications" (which Git normally does)
     -    - Mention that `git checkout` will fail if there's a merge conflict
     -    - The current explanation of `You could omit <branch>`... is confusing
     -      to users (what are the "expensive side effects"? what's a better way
     -      of getting the same info?). Be more direct and mention that `git
     -      status` is likely a better option.
     +    - Reduce use of jargon ("index", "HEAD")
     +    - Clarify that only identical files will be left unchanged, and that
     +      `git checkout` will fail rather than overwrite an unchanged file
     +    - Explain what `git checkout` with no arguments does in a more direct
     +      way
      
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
     @@ Documentation/git-checkout.adoc: DESCRIPTION
      -	`HEAD` at the branch. Local modifications to the files in the
      -	working tree are kept, so that they can be committed to the
      -	_<branch>_.
     -+	Switch to _<branch>_. This sets the current branch to <branch> and
     -+	updates the files in your working directory. Local changes to
     -+	the files in the working tree are kept, so that they can be committed
     -+	to the _<branch>_. If the local changes can't be cleanly merged into
     -+	the _<branch>_, no changes will be made and the checkout operation will fail.
     ++	Switch to _<branch>_. This sets the current branch to _<branch>_ and
     ++	updates the files in your working directory. Files which are
     ++	identical in _<branch>_ and your current commit are left unchanged
     ++	so that you can keep your uncommitted changes to those files.
     ++	This will not overwrite uncommitted changes to a file: instead it
     ++	will fail without making any changes.
       +
       If _<branch>_ is not found but there does exist a tracking branch in
       exactly one remote (call it _<remote>_) with a matching name and
 3:  360051d2a6 ! 3:  043fec7e66 doc: git-checkout: don't use "reset"
     @@ Metadata
      Author: Julia Evans <julia@jvns.ca>
      
       ## Commit message ##
     -    doc: git-checkout: don't use "reset"
     +    doc: git-checkout: clarify `-b` and `-B`
      
     -    Many Git users don't know what the term "reset" means. Resolve this by:
     -
     -    - Expanding it into its definition, in one case
     -    - Giving a simpler but still accurate explanation ("the branch will not
     -      be created or modified"), in the other case
     +    - Remove some unnecessary detail about `--track` (users can refer
     +      to the OPTIONS section instead)
     +    - Explain what the start point defaults to
     +    - Describe `-B` much more tersely as "the same as `-b`, except ..",
     +      since potential users of `-B` are almost certainly already very
     +      familiar with `-b`. Move all of the other contents of `-B` to `-b`,
     +      updating the example so that it's appropriate for `-b`
      
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
       ## Documentation/git-checkout.adoc ##
     -@@ Documentation/git-checkout.adoc: to print out the tracking information for the current branch.
     - 	`--track` without `-b` implies branch creation; see the
     - 	description of `--track` below.
     - +
     +@@ Documentation/git-checkout.adoc: $ git checkout -b <branch> --track <remote>/<branch>
     + Running `git checkout` without specifying a branch has no effect except
     + to print out the tracking information for the current branch.
     + 
     +-`git checkout (-b|-B) <new-branch> [<start-point>]`::
     +-
     +-	Specifying `-b` causes a new branch to be created as if
     +-	linkgit:git-branch[1] were called and then checked out.  In
     +-	this case you can use the `--track` or `--no-track` options,
     +-	which will be passed to `git branch`.  As a convenience,
     +-	`--track` without `-b` implies branch creation; see the
     +-	description of `--track` below.
     +-+
      -If `-B` is given, _<new-branch>_ is created if it doesn't exist; otherwise, it
      -is reset. This is the transactional equivalent of
     -+If `-B` is given, _<new-branch>_ is created if it doesn't exist;
     -+otherwise `<new-branch>` is forced to point at the commit. This is the
     -+transactional equivalent of
     - +
     - ------------
     - $ git branch -f <branch> [<start-point>]
     - $ git checkout <branch>
     - ------------
     +-+
     +-------------
     +-$ git branch -f <branch> [<start-point>]
     +-$ git checkout <branch>
     +-------------
     ++`git checkout -b <new-branch> [<start-point>]`::
     ++
     ++	Create a new branch named _<new-branch>_, start it at _<start-point>_
     ++	(defaults to the current commit), and check out the new branch.
     ++	You can use the `--track` or `--no-track` options to set the branch's
     ++	upstream tracking information.
       +
      -that is to say, the branch is not reset/created unless "git checkout" is
      -successful (e.g., when the branch is in use in another worktree, not
      -just the current branch stays the same, but the branch is not reset to
      -the start-point, either).
     -+that is, the branch will not be created or modified unless
     -+`git checkout` is successful.
     ++This fails without making any changes if there's an error checking out
     ++_<new-branch>_, for example if checking out the `<start-point>`
     ++commit would overwrite your uncommitted changes.
     ++
     ++`git checkout -B <branch> [<start-point>]`::
     ++
     ++	The same as `-b`, except that if the branch already exists it
     ++	resets `_<branch>_` to the start point instead of creating it.
       
       `git checkout --detach [<branch>]`::
       `git checkout [--detach] <commit>`::
     +@@ Documentation/git-checkout.adoc: of it").
     + 	see linkgit:git-branch[1] for details.
     + 
     + `-B <new-branch>`::
     +-	Creates the branch _<new-branch>_, start it at _<start-point>_;
     +-	if it already exists, then reset it to _<start-point>_. And then
     +-	check the resulting branch out.  This is equivalent to running
     +-	`git branch` with `-f` followed by `git checkout` of that branch;
     +-	see linkgit:git-branch[1] for details.
     ++	The same as `-b`, except that if the branch already exists it
     ++	resets `_<branch>_` to the start point instead of creating it.
     + 
     + `-t`::
     + `--track[=(direct|inherit)]`::
     + 	When creating a new branch, set up "upstream" configuration. See
     +-	`--track` in linkgit:git-branch[1] for details.
     ++	`--track` in linkgit:git-branch[1] for details. As a convenience,
     ++	--track without -b implies branch creation.
     + +
     + If no `-b` option is given, the name of the new branch will be
     + derived from the remote-tracking branch, by looking at the local part of
 4:  6f3e485c33 ! 4:  6ce31b6278 doc: git-checkout: deduplicate --detach explanation
     @@ Metadata
       ## Commit message ##
          doc: git-checkout: deduplicate --detach explanation
      
     -    Right now the explanation of `--detach` repeats a lot of the content in
     -    the description of `git checkout <branch>`: we can communicate the same
     -    thing by saying "This is the same as `git checkout <branch>`, except..."
     +    Say that `git checkout --detach` is almost the same as `git checkout`
     +    instead of duplicating the content of the `git checkout` section, since
     +    many users will already be familiar with what `git checkout` does.
      
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
       ## Documentation/git-checkout.adoc ##
     -@@ Documentation/git-checkout.adoc: that is, the branch will not be created or modified unless
     +@@ Documentation/git-checkout.adoc: commit would overwrite your uncommitted changes.
       `git checkout --detach [<branch>]`::
       `git checkout [--detach] <commit>`::
       
 5:  9c0119e70d ! 5:  24793f9a45 doc: git-checkout: clarify restoring files section
     @@ Metadata
      Author: Julia Evans <julia@jvns.ca>
      
       ## Commit message ##
     -    doc: git-checkout: clarify restoring files section
     +    doc: git-checkout: split up restoring files section
      
     -    - Split up the forms `git checkout file.txt` and
     -      `git checkout main file.txt` to match what's given in the SYNOPSIS
     -    - Remove `-f` from the SYNOPSIS for the second form, since according to
     -      this man page it is not relevant in that context
     -    - Many Git users do not know what a "tree-ish" is. Clarify by using an
     -      example of each case, and by saying "commit or tree" in the text
     -      instead of "<tree-ish>"
     -    - Many Git users do not know what the "index" is. Instead say "stage the
     -      file's contents" where appropriate, since Git often uses "stage" as a
     -      verb to mean the same thing as "add to the index" and it's a more
     -      familiar term.
     -    - Use "Discard unstaged changes" instead of "checking out paths from
     -      the index" where relevant
     +    Will make it easier to explain the two versions clearly in the following
     +    commit. As a bonus, now the structure of the DESCRIPTION
     +    matches the SYNOPSIS.
     +
     +    Also remove `-f` from `git checkout <tree-ish> <pathspec>` since it's
     +    not relevant in that context.
      
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
     @@ Documentation/git-checkout.adoc: git checkout [-q] [-f] [-m] [<branch>]
       git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [--] <pathspec>...
       git checkout [-f|--ours|--theirs|-m|--conflict=<style>] --pathspec-from-file=<file> [--pathspec-file-nul]
       git checkout (-p|--patch) [<tree-ish>] [--] [<pathspec>...]
     -@@ Documentation/git-checkout.adoc: that is, the branch will not be created or modified unless
     +@@ Documentation/git-checkout.adoc: commit would overwrite your uncommitted changes.
       +
       Omitting _<branch>_ detaches `HEAD` at the tip of the current branch.
       
     @@ Documentation/git-checkout.adoc: that is, the branch will not be created or modi
      -	overwrite working tree with the contents in the index.
      -	When the _<tree-ish>_ is given, overwrite both the index and
      -	the working tree with the contents at the _<tree-ish>_.
     -+	Replace the specified files and/or directories with the version from
     -+	the given commit or tree.
     - +
     --The index may contain unmerged entries because of a previous failed merge.
     --By default, if you try to check out such an entry from the index, the
     --checkout operation will fail and nothing will be checked out.
     --Using `-f` will ignore these unmerged entries.  The contents from a
     --specific side of the merge can be checked out of the index by
     --using `--ours` or `--theirs`.  With `-m`, changes made to the working tree
     --file can be discarded to re-create the original conflicted merge result.
     -+For example, `git checkout main file.txt` will restore the version
     -+of `file.txt` from `main`. This overwrites the file in the working
     -+directory and stages the file's contents.
     - 
     -+`git checkout [-f|--ours|--theirs|-m|--conflict=<style>] <pathspec>...`::
     ++	Overwrite both the index and the working tree with the
     ++	contents at the _<tree-ish>_ for the files that match the pathspec.
     ++
     ++`git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [--] <pathspec>...`::
      +`git checkout [-f|--ours|--theirs|-m|--conflict=<style>] --pathspec-from-file=<file> [--pathspec-file-nul]`::
      +
     -+	Replace the specified files and/or directories with the latest
     -+	committed or staged version.
     -++
     -+This overwrites the file(s) you specify with either the staged version
     -+or the version from the current commit if there is no staged version.
     -+For example, if you've been editing `file.txt` and you want to discard
     -+your changes to it, you can run `git checkout file.txt` to replace it
     -+with the latest committed version.
     -++
     -+This will fail if the file has a merge conflict and you haven't yet run
     -+`git add file.txt` (or something equivalent) to mark it as resolved.
     -+You can use `-f` to ignore the unmerged files instead of failing, use
     -+`--ours` or `--theirs` to replace them with the version from a specific
     -+side of the merge, or use `-m` to replace them with the original
     -+conflicted merge result.
     ++	Overwrite working tree with the contents in the index for the files
     ++	that match the pathspec.
     + +
     + The index may contain unmerged entries because of a previous failed merge.
     + By default, if you try to check out such an entry from the index, the
     +@@ Documentation/git-checkout.adoc: using `--ours` or `--theirs`.  With `-m`, changes made to the working tree
     + file can be discarded to re-create the original conflicted merge result.
     + 
       `git checkout (-p|--patch) [<tree-ish>] [--] [<pathspec>...]`::
      -	This is similar to the previous mode, but lets you use the
      +	This is similar to the previous two modes, but lets you use the
 -:  ---------- > 6:  90fe48cfe3 doc: git-checkout: clarify restoring files section

-- 
gitgitgadget
