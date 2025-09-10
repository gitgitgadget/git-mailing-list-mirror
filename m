Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7105B253951
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 19:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757531674; cv=none; b=c6ckMQ96fikLdDFk2trPhoo4prKqdjt7SGiEYP19wOMOwQxlZ7ls3NrQ2egHEpSEpkmavTOXaJl2t1XbFu6GjNkQctOnXAYc5nmxS7vce5GXrgKfaOwjdVDMh+TZzlhz3tNc8GsHnAY7wA6Lb9sNbNCL9uUXggvP6Vuv/6GGQmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757531674; c=relaxed/simple;
	bh=9hMfy7Tm6Gc8BFWAcaDu0ELikVM7DX2Qlh1YLOCFALg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kXTS9pyLQvRwav7436DTNQt8F89g2hCKt6Gfz5dF58XagqyvGqhrO/9Dt7qJEWMkY34Zi22ykQZ6TDzEwSZZcQjvgYiryW8e9SiaauiIvTTTOY+SyENxyYyligAuAaqWHJjhkF2Ihpw18gKyQ0lLRfPoZxCKM/1cSaTUWfh8+eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcxM20mI; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcxM20mI"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32b5d8bea85so874830a91.1
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 12:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757531671; x=1758136471; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKM21XUOoDq9iMTkwgsKG3VVEZ/dPRm1m+AhjD/6UbE=;
        b=UcxM20mI+Z6iwiTtymOLIamZ7AlsFEnbBnlY8sffF1zEjxAw6DQU6dXJDw/Suz0e32
         AelRI+eN2HSKesBWATluCHJEqQXsZVivTxhnZaK1sFs8YOqkvLruWXPUiNRz8pXsJxNu
         5RJA9MBy8xxCiyKfnIKEgBBJ+ZKGtGy1EFexQWd0hSvisNB78lsQJD88zKszdyok5Xlb
         yLxoqqEOfK2R4u+gBwdZwGru01wRIUQ19iYbMOG+3v1eUosXp1iEA6n7KkkMyW2PGaOB
         4zNeuHoJwGrrC6x4uZ0/3isgz0aIuPMYVrwbz5VJcqCgWof/zEk0jK7lLqATj5bxoYx3
         S9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757531671; x=1758136471;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKM21XUOoDq9iMTkwgsKG3VVEZ/dPRm1m+AhjD/6UbE=;
        b=Ii+6sIiOyMTrXtKGJ67k2MmTDkUTlH3ZlZjsPY5pZROeEnCfsc2V6MQMcbMR7DlNDO
         LOd52SPezVP4gvPjlQm5PRhXHZb2xJ2QxT+HBNx8w+yuyFvRs7dXByXSn+SooqKjEFB8
         kBMX4nlfMJ1nud3gpjQZA7DtxOTWYRSTqu4iZm5n3XxxG5HDpU+mq1FNQ/k8DNotJ6Fg
         RPeVwt4aqVb16UnlLUBqdBwEMmwXsxxwMXuQUTXEjSDroV3xb5KSATnnaoqWnCrhR2Fm
         iwOIx2quod7ToYMz4YpCkhq3w2dfHUsmbpvLPkhbzwAbukaV8VTSJUhFuva7K4hnhiQn
         6mIw==
X-Gm-Message-State: AOJu0YzA8Wb4i2du3fvIQ9GDohX7VoNMg/f4CwBcumkvaS09BKiy4rw5
	HP23EulWG3/t5QLX77SsbCRiWitQ89N3wHnncwbf+T37lVXM4SMGXXbTtKtaUw==
X-Gm-Gg: ASbGncsXT5P3DvJjmb8WZ8ReqvjQek8moByBCh6s1NVi4WGyZPGZFI2uW0gwENn3DrQ
	wpOxPijoaPZM8yD3iFiaE6RuMoqWg9Ac6wlJas4KLEKNldoUvI6MkUarvGQWOUPRtDpwmGxyMW5
	FNQrYjPw9a088G8k+01qUoE9PtDKPBtT8ytwudHM/Zw3LvffPWXCoGUeEp3Nok3pC32qGan1rRe
	2csJg6pOPPaCicOYaFtEGs6LO0e+YVAjjv/F07gYfHdb2iSTCrW+R3c8mncaudx7z3qfis9kOc+
	DyA6OSxNnZiY2zbrpfIjqbdXMB+R/+IB4yWDP/dX14ghb+MuG6aIiQFjEdNGrrMJ2d/+nlolQRu
	MqFd7B2b4rTSlDy5xzw3gyhSaPkDVMjhQtcyBfA==
X-Google-Smtp-Source: AGHT+IHqlnSm36VyTrrBGVAAvR/dPvUg4lrYiX/1gk0uH24ubGKLl158gaaoEPGNMCWKJLr85wJbJw==
X-Received: by 2002:a17:90b:2884:b0:327:8813:c37e with SMTP id 98e67ed59e1d1-32dd1d4d05emr745686a91.5.1757531670858;
        Wed, 10 Sep 2025 12:14:30 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.201.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb1feb9bsm3453013a91.1.2025.09.10.12.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 12:14:30 -0700 (PDT)
Message-Id: <pull.1962.v4.git.1757531669.gitgitgadget@gmail.com>
In-Reply-To: <pull.1962.v3.git.1756918202.gitgitgadget@gmail.com>
References: <pull.1962.v3.git.1756918202.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 10 Sep 2025 19:14:22 +0000
Subject: [PATCH v4 0/7] doc: git-checkout: clarify DESCRIPTION section
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

I got feedback from 22 existing Git users on the existing git checkout man
page, using this tool: https://text-feedback.wizardzines.com/git-checkout.
From a short survey they filled out, about 90% of the users who gave the
feedback have 5+ years of experience using Git.

This series goes through the DESCRIPTION section from beginning to end,
addressing points that users found confusing in each variant of git
checkout. The goal is to clarify while communicating the same information.

Changes in v2:

 * Remove the numbered list from the beginning, from Junio's review
 * Describe what it means to "switch branches" in a way that's hopefully
   more accessible to newcomers, from Junio's review
 * Improve the ARGUMENT DISAMBIGUATION section, from Junio and Ben's reviews
   ("conflict" => "ambiguity", explain correctly what the default is)
 * The explanation of git checkout [<tree-ish>] <pathspec> had a lot of
   issues, from Junio's review. Resolve this by splitting up the git
   checkout [] section into two sections. Use "Replace" instead of
   "Restore".

Changes in v3:

 * Fix incorrect description of when git checkout <branch>, from Junio's
   review
 * Take a different approach to the git checkout -b description (keep reset
   in -B, but simplify the description of -B a lot to remove the
   "transactional equivalent.." paragraph), from Junio's review
 * Say "switch to the commit" instead of "switches commits", from Junio's
   review
 * Try a different approach to git checkout file.txt ("Discard any unstaged
   changes...")

Changes in v4:

 * Rewrite all the commit messages to try to take a more Problem / Solution
   approach, from Junio's review and thanks to help from @nasamuffin in
   Discord. Also change the cover letter format to match the style in
   https://lore.kernel.org/git/CAOLa=ZStgwBN0fMK3YxoqeR+1i772f621supva3Kvr7YPq4g8g@mail.gmail.com/T/#m8c99a3144cbdfb445e04f8f83a79364bfe8d797d
   , which hopefully matches the norms of this mailing list better.
 * Try a different approach to the "left unchanged...", from Junio's review
 * Bring back "index" (with a few hints about what the word might mean),
   from Junio's review.
 * Bring back the numbered list at the beginning from v1, since I think I
   misunderstood a comment about lists, and that the original was clearer
 * Fix an issue I noticed in -B ("instead of failing", not "instead of
   creating it")
 * Add a comma after branch or commit, to try to make it clear what "either"
   refers to in that sentence
 * Replace "will fail without making any changes" throughout with just "will
   fail". I think the default assumption is that Git will fail operations in
   a clean way, and that cases where it does not fail cleanly are the
   exceptions that the documentation should flag.

Julia Evans (7):
  doc: git-checkout: clarify intro sentence
  doc: git-checkout: clarify ARGUMENT DISAMBIGUATION
  doc: git-checkout: clarify `git checkout <branch>`
  doc: git-checkout: clarify `-b` and `-B`
  doc: git-checkout: deduplicate --detach explanation
  doc: git-checkout: split up restoring files section
  doc: git-checkout: clarify restoring files section

 Documentation/git-checkout.adoc | 151 ++++++++++++++++----------------
 1 file changed, 76 insertions(+), 75 deletions(-)


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1962%2Fjvns%2Fclarify-checkout-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1962/jvns/clarify-checkout-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1962

Range-diff vs v3:

 -:  ---------- > 1:  4b52ffd497 doc: git-checkout: clarify intro sentence
 1:  1975384dd0 ! 2:  08f0a5efab doc: git-checkout: clarify intro
     @@ Metadata
      Author: Julia Evans <julia@jvns.ca>
      
       ## Commit message ##
     -    doc: git-checkout: clarify intro
     +    doc: git-checkout: clarify ARGUMENT DISAMBIGUATION
      
     -    - Reduce use of jargon ("index", "pathspec", "tree") by using an
     -      example, and by mirroring the "switch" and "restore" language from the
     -      first line of the man page.
     -    - Reference and clarify the ARGUMENT DISAMBIGUATION section, as well
     -      as fixing a small error (in "`git checkout abc`, `abc` is a commit,
     -      not a `_<tree-ish>_`)
     +    There's no need to use the terms "pathspec" or "tree-ish" in the
     +    ARGUMENT DISAMBIGUATION section, which are terms that (from user
     +    feedback on this page) many users do not understand.
     +
     +    "tree-ish" is actually not accurate here: `git checkout` in this case
     +    takes a commit-ish, not a tree-ish. So we can say "branch or commit"
     +    instead of "tree-ish" which is both more accurate and uses more familiar
     +    terms.
     +
     +    And now that the intro to the man pages mentions that `git checkout` has
     +    "two main modes", it makes sense to refer to this disambiguation section
     +    to understand how Git decides which one to use when there's an overlap
     +    in syntax.
      
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
       ## Documentation/git-checkout.adoc ##
     -@@ Documentation/git-checkout.adoc: git checkout (-p|--patch) [<tree-ish>] [--] [<pathspec>...]
     +@@ Documentation/git-checkout.adoc: DESCRIPTION
     + 2. **Restore a different version of a file**, for example with
     +    `git checkout <commit> <filename>` or `git checkout <filename>`
       
     - DESCRIPTION
     - -----------
     --Updates files in the working tree to match the version in the index
     --or the specified tree.  If no pathspec was given, `git checkout` will
     --also update `HEAD` to set the specified branch as the current
     --branch.
     -+`git checkout` has two main modes: it can
     -+**switch branches**, for example with `git checkout <branch>`, and
     -+**restore files from a different version**, for example with
     -+`git checkout <commit> <filename>` or `git checkout <filename>`
     -+
      +See ARGUMENT DISAMBIGUATION below for how Git decides which one to do.
     - 
     ++
       `git checkout [<branch>]`::
       	To prepare for working on _<branch>_, switch to it by updating
     + 	the index and the files in the working tree, and by pointing
      @@ Documentation/git-checkout.adoc: $ git log -g -2 HEAD
       ARGUMENT DISAMBIGUATION
       -----------------------
     @@ Documentation/git-checkout.adoc: $ git log -g -2 HEAD
      -to checkout these paths out of the index.
      +When you run `git checkout <something>`, Git tries to guess whether
      +`<something>` is intended to be a branch, a commit, or a set of file(s),
     -+and then either switches to that branch or commit or restores the
     ++and then either switches to that branch or commit, or restores the
      +specified files.
      +
      +If there's any ambiguity, Git will treat `<something>` as a branch or
 2:  940cd17e7e ! 3:  551e56dea6 doc: git-checkout: clarify `git checkout <branch>`
     @@ Metadata
       ## Commit message ##
          doc: git-checkout: clarify `git checkout <branch>`
      
     -    - Reduce use of jargon ("index", "HEAD")
     -    - Clarify that only identical files will be left unchanged, and that
     -      `git checkout` will fail rather than overwrite an unchanged file
     -    - Explain what `git checkout` with no arguments does in a more direct
     -      way
     +    From user feedback: several users commented that "Local modifications
     +    to the files in the working tree are kept, so that they can be committed
     +    to the <branch>." didn't seem accurate to them, since
     +    `git checkout <branch>` will often fail.
     +
     +    One user also thought that "... and by pointing HEAD at the branch"
     +    was something that _they_ had to do somehow ("How do I point HEAD at
     +    a branch?") rather than a description of what the `git checkout`
     +    operation is doing for them.
     +
     +    Explain when `git checkout <branch>` will fail and clarify that
     +    "pointing HEAD at the branch" is part of what the command does.
     +
     +    6 users commented that the "You could omit <branch>..." section is
     +    extremely confusing. Explain this in a much more direct way.
      
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
     @@ Documentation/git-checkout.adoc: DESCRIPTION
      -	working tree are kept, so that they can be committed to the
      -	_<branch>_.
      +	Switch to _<branch>_. This sets the current branch to _<branch>_ and
     -+	updates the files in your working directory. Files which are
     -+	identical in _<branch>_ and your current commit are left unchanged
     -+	so that you can keep your uncommitted changes to those files.
     -+	This will not overwrite uncommitted changes to a file: instead it
     -+	will fail without making any changes.
     ++	updates the files in your working directory. The checkout will fail
     ++	if there are uncommitted changes to any files where _<branch>_ and
     ++	your current commit have different content. Uncommitted changes will
     ++	otherwise be kept.
       +
       If _<branch>_ is not found but there does exist a tracking branch in
       exactly one remote (call it _<remote>_) with a matching name and
 3:  043fec7e66 ! 4:  e636475cba doc: git-checkout: clarify `-b` and `-B`
     @@ Metadata
       ## Commit message ##
          doc: git-checkout: clarify `-b` and `-B`
      
     -    - Remove some unnecessary detail about `--track` (users can refer
     -      to the OPTIONS section instead)
     -    - Explain what the start point defaults to
     -    - Describe `-B` much more tersely as "the same as `-b`, except ..",
     -      since potential users of `-B` are almost certainly already very
     -      familiar with `-b`. Move all of the other contents of `-B` to `-b`,
     -      updating the example so that it's appropriate for `-b`
     +    From user feedback: several users reported having trouble understanding
     +    the difference between `-b` and `-B` ("I think it's because my brain
     +    expects it to contrast with `-b`, but instead it starts off explaining
     +    how they're the same").
     +
     +    Also, in `-B`, 2 users can't tell what the branch is reset *to*.
     +
     +    Simplify the sentence structure in the explanations of `-b` and `-B` and
     +    add a little extra information (what `<start-point>` is, what the branch
     +    is reset to).
     +
     +    Splitting up `-b` and `-B` into separate items helps simplify the
     +    sentence structure since there's less "In this case...".
     +
     +    Replace the long "the branch is not reset/created unless "git checkout"
     +    is successful..." with just "will fail", since we should generally
     +    assume that Git will fail operations in a clean way and not leave
     +    operations half-finished, and that cases where it does not fail cleanly
     +    are the exceptions that the documentation should flag.
      
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
     @@ Documentation/git-checkout.adoc: $ git checkout -b <branch> --track <remote>/<br
      -successful (e.g., when the branch is in use in another worktree, not
      -just the current branch stays the same, but the branch is not reset to
      -the start-point, either).
     -+This fails without making any changes if there's an error checking out
     -+_<new-branch>_, for example if checking out the `<start-point>`
     -+commit would overwrite your uncommitted changes.
     ++This will fail if there's an error checking out _<new-branch>_, for
     ++example if checking out the `<start-point>` commit would overwrite your
     ++uncommitted changes.
      +
      +`git checkout -B <branch> [<start-point>]`::
      +
      +	The same as `-b`, except that if the branch already exists it
     -+	resets `_<branch>_` to the start point instead of creating it.
     ++	resets `_<branch>_` to the start point instead of failing.
       
       `git checkout --detach [<branch>]`::
       `git checkout [--detach] <commit>`::
     @@ Documentation/git-checkout.adoc: of it").
      -	`git branch` with `-f` followed by `git checkout` of that branch;
      -	see linkgit:git-branch[1] for details.
      +	The same as `-b`, except that if the branch already exists it
     -+	resets `_<branch>_` to the start point instead of creating it.
     ++	resets `_<branch>_` to the start point instead of failing.
       
       `-t`::
       `--track[=(direct|inherit)]`::
 4:  6ce31b6278 ! 5:  e7d9641125 doc: git-checkout: deduplicate --detach explanation
     @@ Metadata
       ## Commit message ##
          doc: git-checkout: deduplicate --detach explanation
      
     -    Say that `git checkout --detach` is almost the same as `git checkout`
     -    instead of duplicating the content of the `git checkout` section, since
     -    many users will already be familiar with what `git checkout` does.
     +    From user feedback: several users say they don't understand the use case
     +    for `--detach`. It's probably not realistic to explain the use case for
     +    detached HEAD state here, but we can improve the situation.
     +
     +    Explain how `git checkout --detach` is different from
     +    `git checkout <branch>` instead of copying over the description from
     +    `git checkout <branch>`, since `git checkout <branch>` will be a
     +    familiar command to many readers.
      
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
       ## Documentation/git-checkout.adoc ##
     -@@ Documentation/git-checkout.adoc: commit would overwrite your uncommitted changes.
     +@@ Documentation/git-checkout.adoc: uncommitted changes.
       `git checkout --detach [<branch>]`::
       `git checkout [--detach] <commit>`::
       
 5:  24793f9a45 ! 6:  7b1e2f265b doc: git-checkout: split up restoring files section
     @@ Metadata
       ## Commit message ##
          doc: git-checkout: split up restoring files section
      
     -    Will make it easier to explain the two versions clearly in the following
     -    commit. As a bonus, now the structure of the DESCRIPTION
     -    matches the SYNOPSIS.
     +    From user feedback: one user mentioned that "When the <tree-ish> (most
     +    often a commit) is not given" is confusing since it starts with a
     +    negative.
      
     -    Also remove `-f` from `git checkout <tree-ish> <pathspec>` since it's
     -    not relevant in that context.
     +    Restructuring so that `git checkout main file.txt` and
     +    `git checkout file.txt` are separate items will help us simplify the
     +    sentence structure a lot.
     +
     +    As a bonus, it appears that `-f` actually only applies to one of those
     +    forms, so we can include fewer options, and now the structure of the
     +    DESCRIPTION matches the SYNOPSIS.
      
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
     @@ Documentation/git-checkout.adoc: git checkout [-q] [-f] [-m] [<branch>]
       git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [--] <pathspec>...
       git checkout [-f|--ours|--theirs|-m|--conflict=<style>] --pathspec-from-file=<file> [--pathspec-file-nul]
       git checkout (-p|--patch) [<tree-ish>] [--] [<pathspec>...]
     -@@ Documentation/git-checkout.adoc: commit would overwrite your uncommitted changes.
     +@@ Documentation/git-checkout.adoc: uncommitted changes.
       +
       Omitting _<branch>_ detaches `HEAD` at the tip of the current branch.
       
 6:  90fe48cfe3 ! 7:  db603b1e5f doc: git-checkout: clarify restoring files section
     @@ Metadata
       ## Commit message ##
          doc: git-checkout: clarify restoring files section
      
     -    - Reword to avoid jargon ("tree-ish", "index") where possible.
     -      Use "commit or tree" and "stage" (as a verb) instead where appropriate
     -    - Add examples
     -    - Use a simpler sentence structure to describe options for handling
     -      unmerged entries: "use -f to.., use --ours to..., or use -m to.."
     +    From user feedback on this section: 3 users don't know what "tree-ish"
     +    means and 3 users don't know what "pathspec" means. One user also says
     +    that the section is very confusing and that they don't understand what
     +    the "index" is.
     +
     +    From conversations on Mastodon, several users said that their impression
     +    is that "the index" means the same thing as "HEAD". It would be good to
     +    give those users (and other users who do not know what "index" means) a
     +    hint as to its meaning.
     +
     +    Make this section more accessible to users who don't know what the terms
     +    "pathspec", "tree-ish", and "index" mean by using more familiar language,
     +    adding examples, and using simpler sentence structures.
      
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
     @@ Documentation/git-checkout.adoc: Omitting _<branch>_ detaches `HEAD` at the tip
      -	Overwrite both the index and the working tree with the
      -	contents at the _<tree-ish>_ for the files that match the pathspec.
      +	Replace the specified files and/or directories with the version from
     -+	the given commit or tree and stage the files' contents.
     ++	the given commit or tree and add them to the index
     ++	(also known as "staging area").
      ++
      +For example, `git checkout main file.txt` will replace `file.txt`
      +with the version from `main`.
     @@ Documentation/git-checkout.adoc: Omitting _<branch>_ detaches `HEAD` at the tip
       
      -	Overwrite working tree with the contents in the index for the files
      -	that match the pathspec.
     -+	Discard any unstaged changes to the specified files and/or directories.
     -+	This works by copying the file from the index to your working directory.
     -+	For example, `git checkout file.txt` will replace `file.txt` with either
     -+	the staged version of `file.txt` (if there is one) or the version from the
     -+	current commit.
     ++	Replace the specified files and/or directories with the version from
     ++	the index.
     +++
     ++For example, if you check out a commit, edit `file.txt`, and then
     ++decide those changes were a mistake, `git checkout file.txt` will
     ++discard any unstaged changes to `file.txt`.
       +
      -The index may contain unmerged entries because of a previous failed merge.
      -By default, if you try to check out such an entry from the index, the
     @@ Documentation/git-checkout.adoc: Omitting _<branch>_ detaches `HEAD` at the tip
      -specific side of the merge can be checked out of the index by
      -using `--ours` or `--theirs`.  With `-m`, changes made to the working tree
      -file can be discarded to re-create the original conflicted merge result.
     --
      +This will fail if the file has a merge conflict and you haven't yet run
      +`git add file.txt` (or something equivalent) to mark it as resolved.
      +You can use `-f` to ignore the unmerged files instead of failing, use
      +`--ours` or `--theirs` to replace them with the version from a specific
      +side of the merge, or use `-m` to replace them with the original
      +conflicted merge result.
     + 
       `git checkout (-p|--patch) [<tree-ish>] [--] [<pathspec>...]`::
       	This is similar to the previous two modes, but lets you use the
     - 	interactive interface to show the "diff" output and choose which

-- 
gitgitgadget
