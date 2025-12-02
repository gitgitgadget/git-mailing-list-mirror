Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBEE79CF
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 20:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764706585; cv=none; b=nPD+oBYFLSY9sFmtvIcvOHuBnj5n4v42KNDjX1m8ZT6MJN0S6zSHjkEoSTY1ONUJ21NErxRKcpTQ5VyXBInWuG30r0GWZ3aMn7X6ohNoyFYtC7GCBKhiiRPcKzIIQ1t6ShXIvp3dwOKIjhknZS6uEwl2W+3pijJGa7xD9cPFP+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764706585; c=relaxed/simple;
	bh=jlk/ase1ubc3qkTLUomy+W44v3pEs0844faERiR8rYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtoCDRTQcmdGzeUGuvM5N9hf5zV7GF1VOEqblYWD3ERxa8HqaOK0lETF82kCSM3D3vXWZiz8FSaMSChaTlHX0sPPw/GhAo+k5Wti9/PxjwkaPs88wV+wQYw8iuofKoVBAQKvII0W4g2aftxdXxj/YBwiW3fmAp45KVIKrk1EV60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1W40zAp; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1W40zAp"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-295548467c7so68410015ad.2
        for <git@vger.kernel.org>; Tue, 02 Dec 2025 12:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764706582; x=1765311382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33n1x1FoBWcbQf8DGiQtUrQstAIDOsdV5SuOVEqakLA=;
        b=B1W40zApOawo+u+DYXWm3wuv9proxLnfKaVwYer/aJHSQByJ+CLUvCm/p/jSbAIdVm
         US/jGZTk1jo9gZpWNV50Po3ynheYQleml8T5v0ITG0x3pfg0UTt8gBDouyqxs3KhPZHT
         SXNeV5f5k4dzYhIilp6xHsaWHFYIfxhMsVT4Fd9iwEpCcjwMiX+UjLnGlujN1+RdM8Gy
         guoEUOHyeZtD4nzDcSUoyAFsuu/x+4WRK6+3TAIM5f5pRJrVandsmnuLzJRkw+8MQme7
         DWX+/qkQrS1Kg0QKAI1l3mgZUrXFqfe3PGMBCqDtqegJAO3y50MeMnaHUAXNq7Klww9h
         cVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764706582; x=1765311382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=33n1x1FoBWcbQf8DGiQtUrQstAIDOsdV5SuOVEqakLA=;
        b=QRTXagTFYnVwlLlqsmDQh1J9t8DQLePAx+Eh2OS8JB9/haCqUSqyWsQEgTTZZZOnSS
         Gq7g55sP/W4WID/23qQJf6yOu45VtRBwRhmLZyH7ugKj6iM1T1AO66zeaI3/TspRGtbE
         GIJB/g3UPx0iDLf/fzmRikSmtFPjKWluE9nMhnIbH/sMMRLQkcfxvt2GyG+8n0YPt3us
         iH4+ZKXJhMI9DIlu4Ed2uNow2CvAB/Z0j/0ax3Yqj0B0/2KXc1mIWVjjBZohp5i+pdSL
         HWZmd1jrpFOZuNKyKn5iVWRXA6IYL18agQKGEax94WPYIDefD0APUE52suFs2mk6aTvm
         W3Aw==
X-Gm-Message-State: AOJu0YyZ9Q/FH2jwzEjvpwtSXypmITqPqD2V+2Dx2I7+vcfykbu+7kME
	25S0xXYRfHGlnLUUuqqpGfIDOEpAvjxV7TIi+P6Sum9IIbbfate6fzFcyC4gJKKN
X-Gm-Gg: ASbGncsc9jbLjz8qZx/xRpcfRdVWqSH6+nOy0gFKy2LTDDMWVQH/TzBP22bUnY8RoXD
	wUKSLR/aqgRPR9v0j3X1/YSa/pHUW7yinFVnz4Sy8cuu7T0R21I3T9FkqN3ktYICRw4kDIDWRma
	GW3xX31YVX15f+4zvvxwDE0ShBD7aHc71+fPbAypmNm/ReJ5rnAsJ7+4PuPIeCK9y0LQnUJ5hFt
	gLXZLS9MyAWHzXNwAYcn8MtNRBFKzxWRcrMNXQgXdzVa9HkI6SlwFulkOeqeqGd9Wn1KoczNXpJ
	7xOSP3cFrZpX3AXK1t1rmGdlH8eJvid1Jk8pGaUdLka0VeX+aaqbXJgMAVCeuzV5xNXaqckv3yG
	8BGc7zi+qDxPegmeNywbo3fVId6KFrMlRqMrEUmCVyQ/QRZIr+sLBdVMhArv1Hqiq8gPHjBIJ0Q
	lRZ0baGoSyAV+CtLGOLjioLeq3RJg/VVfrwKZlrJMMxZNSm7iCdyfW+JdU9z7oRQ==
X-Google-Smtp-Source: AGHT+IF5H63XnbCVdHN7bwGrXeczNmV3FdPpTw+oQ0F72PW0fpXTC02XPsnZjObrzIvbE3g/RACF4A==
X-Received: by 2002:a17:903:13ce:b0:297:f2d6:17b2 with SMTP id d9443c01a7336-29b6bf5ee8emr459439305ad.40.1764706581743;
        Tue, 02 Dec 2025 12:16:21 -0800 (PST)
Received: from localhost.localdomain ([2409:40e3:30a4:b776:698d:fcda:3aba:18d6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce40acc7sm162058925ad.2.2025.12.02.12.16.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 02 Dec 2025 12:16:20 -0800 (PST)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	newren@gmail.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk,
	karthik.188@gmail.com,
	johannes.schindelin@gmx.de,
	toon@iotcl.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v2 0/2] replay: add --revert mode to reverse commit changes
Date: Wed,  3 Dec 2025 01:46:09 +0530
Message-ID: <20251202201611.22137-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125170056.34489-1-siddharthasthana31@gmail.com>
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `git replay` command performs server-side history rewriting without
requiring a working tree. While it currently supports cherry-picking
commits (--advance) and rebasing (--onto), it lacks the ability to
revert them.

At GitLab, we use replay in Gitaly for efficient server-side operations
on bare repositories. Adding revert functionality enables us to reverse
problematic commits directly on the server, eliminating client-side
roundtrips and reducing network overhead.

The implementation follows the same approach as sequencer.c where
cherry-pick and revert are the same merge operation but with swapped
arguments. For cherry-pick we merge(ancestor=parent, ours=current,
theirs=commit), while for revert we merge(ancestor=commit, ours=current,
theirs=parent). By swapping the base and pickme trees when calling
merge_incore_nonrecursive(), we effectively reverse the diff direction.

The series is structured as follows:

Patch 1 extracts the revert message formatting logic into a shared
sequencer_format_revert_header() function, eliminating code duplication
between sequencer.c and the upcoming replay code. This follows Junio's
suggestion to split the changes.

Patch 2 adds the --revert <branch> mode to git replay. Following the
architectural pattern suggested by Elijah and Phillip, --revert is a
standalone mode (like --onto and --advance) that takes a branch argument
and updates that branch with the revert commits.

The series is based on top of f0ef5b6d9b (The fifth batch, 2025-11-29).

CI: https://gitlab.com/gitlab-org/git/-/pipelines/2191734674
The static-analysis and Windows CI failures are pre-existing
infrastructure issues unrelated to this series.

Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
Changes in v2:
- Split into two patches as Junio suggested
- Changed --revert from a modifier flag to a standalone mode
  (--revert <branch>) that is mutually exclusive with --onto/--advance
- Used enum replay_action instead of int is_revert
- Fixed subject extraction bug in generate_revert_message()
- Put common (cherry-pick) case first in if/else block
- Fixed repo_unuse_commit_buffer() to use repo parameter consistently
- Improved tests with test_commit_message() and atomic ref update handling
- Link to v1: https://lore.kernel.org/git/20251125170055.64991-1-siddharthasthana31@gmail.com/

Siddharth Asthana (2):
  sequencer: extract revert message formatting into shared function
  replay: add --revert mode to reverse commit changes

 Documentation/git-replay.adoc |  36 ++++++++-
 builtin/replay.c              | 145 ++++++++++++++++++++++++++++------
 sequencer.c                   |  39 +++++----
 sequencer.h                   |   8 ++
 t/t3650-replay-basics.sh      | 111 ++++++++++++++++++++++++++
 5 files changed, 300 insertions(+), 39 deletions(-)


Range-diff against v1:
-:  ---------- > 1:  bfd75484b4 sequencer: extract revert message formatting into shared function
1:  dd47a89a5b ! 2:  a2f99bc8c2 replay: add --revert option to reverse commit changes
    @@ Metadata
     Author: Siddharth Asthana <siddharthasthana31@gmail.com>
     
      ## Commit message ##
    -    replay: add --revert option to reverse commit changes
    +    replay: add --revert mode to reverse commit changes
     
         The `git replay` command performs server-side history rewriting without
         requiring a working tree. While it currently supports cherry-picking
    -    commits, it lacks the ability to revert them.
    +    commits (--advance) and rebasing (--onto), it lacks the ability to
    +    revert them.
     
         At GitLab, we use replay in Gitaly for efficient server-side operations
         on bare repositories. Adding revert functionality enables us to reverse
         problematic commits directly on the server, eliminating client-side
         roundtrips and reducing network overhead.
     
    -    Add a `--revert` option that reverses the changes introduced by the
    -    specified commits. The implementation follows the same approach as
    -    `sequencer.c` (around lines 2358-2390), where cherry-pick and revert
    -    are essentially the same merge operation but with swapped arguments:
    +    Add a `--revert <branch>` mode that reverses the changes introduced by
    +    the specified commits. Following the architecture of --onto and --advance,
    +    --revert is a standalone mode that takes a branch argument and updates
    +    that branch with the revert commits.
    +
    +    The implementation follows the same approach as sequencer.c (lines
    +    2360-2399), where cherry-pick and revert are the same merge operation
    +    but with swapped arguments:
     
           - Cherry-pick: merge(ancestor=parent, ours=current, theirs=commit)
           - Revert: merge(ancestor=commit, ours=current, theirs=parent)
     
         We swap the base and pickme trees when calling
    -    `merge_incore_nonrecursive()`, effectively reversing the diff direction.
    +    merge_incore_nonrecursive(), effectively reversing the diff direction.
         The existing conflict handling, ref updates, and atomic transaction
         support work unchanged.
     
    -    The revert message generation logic (handling "Revert" and "Reapply"
    -    cases) is extracted into a new `sequencer_format_revert_header()`
    -    function in `sequencer.c`, which can be shared between `sequencer.c`
    -    and `builtin/replay.c`. The existing code in `do_pick_commit()` is
    -    updated to use this shared function, eliminating code duplication.
    -    The `builtin/replay.c` code calls this shared function and then appends
    -    the commit OID using `oid_to_hex()` directly, since git replay is
    -    designed for simpler server-side operations without the interactive
    -    features and `replay_opts` framework used by `sequencer.c`.
    -
    -    The commit messages follow `git revert` conventions: prefixed with
    +    The commit messages follow git revert conventions: prefixed with
         "Revert" and including the original commit SHA. When reverting a commit
         that itself starts with "Revert", the message uses "Reapply" instead.
         Unlike cherry-pick which preserves the original author, revert commits
    -    use the current user as the author, matching the behavior of `git
    -    revert`.
    -
    -    Mark the option as incompatible with `--contained` because reverting
    -    changes across multiple branches simultaneously could produce unexpected
    -    results when branches have interdependencies or shared history.
    +    use the current user as the author, matching the behavior of git revert.
     
         Helped-by: Christian Couder <christian.couder@gmail.com>
         Helped-by: Patrick Steinhardt <ps@pks.im>
    +    Helped-by: Elijah Newren <newren@gmail.com>
    +    Helped-by: Phillip Wood <phillip.wood123@gmail.com>
    +    Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
     
      ## Documentation/git-replay.adoc ##
    @@ Documentation/git-replay.adoc: git-replay - EXPERIMENTAL: Replay commits on a ne
      --------
      [verse]
     -(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) [--ref-action[=<mode>]] <revision-range>...
    -+(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch>) [--ref-action[=<mode>]] [--revert] <revision-range>...
    ++(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch> | --revert <branch>) [--ref-action[=<mode>]] <revision-range>...
      
      DESCRIPTION
      -----------
    -@@ Documentation/git-replay.adoc: which uses the target only as a starting point without updating it.
    - +
    - The default mode can be configured via the `replay.refAction` configuration variable.
    +@@ Documentation/git-replay.adoc: The history is replayed on top of the <branch> and <branch> is updated to
    + point at the tip of the resulting history. This is different from `--onto`,
    + which uses the target only as a starting point without updating it.
      
    -+--revert::
    -+	Revert the changes introduced by the commits in the revision range
    -+	instead of applying them. This reverses the diff direction and creates
    -+	new commits that undo the changes, similar to `git revert`.
    ++--revert <branch>::
    ++	Starting point at which to create the new revert commits; must be a
    ++	branch name.
     ++
    -+The commit messages are prefixed with "Revert" and include the original
    -+commit SHA. If reverting a commit whose message starts with "Revert", the new
    -+message will start with "Reapply" instead. The author of the new commits
    -+will be the current user, not the original commit author.
    ++When `--revert` is specified, the commits in the revision range are reverted
    ++(their changes are undone) and the revert commits are applied on top of <branch>.
    ++The <branch> is then updated to point at the new commits. This is similar to
    ++running `git revert` for each commit in the range, but works without a working tree.
     ++
    -+This option is incompatible with `--contained` because reverting changes
    -+across multiple branches simultaneously could produce unexpected results
    -+when branches have interdependencies or shared history.
    ++The commit messages follow `git revert` conventions: prefixed with "Revert" and
    ++including the original commit SHA. When reverting a commit whose message starts
    ++with "Revert", the new message uses "Reapply" instead. The author of the revert
    ++commits is the current user, not the original commit author.
    +++
    ++This option is mutually exclusive with `--onto` and `--advance`. It is also
    ++incompatible with `--contained` (which is a modifier for `--onto` only).
    ++
     +
    - <revision-range>::
    - 	Range of commits to replay. More than one <revision-range> can
    - 	be passed, but in `--advance <branch>` mode, they should have
    + --ref-action[=<mode>]::
    + 	Control how references are updated. The mode can be:
    + +
     @@ Documentation/git-replay.adoc: all commits they have since `base`, playing them on top of
      `origin/main`. These three branches may have commits on top of `base`
      that they have in common, but that does not need to be the case.
      
    -+To revert a range of commits:
    ++To revert commits from a branch:
     +
     +------------
    -+$ git replay --revert --onto main feature~3..feature
    ++$ git replay --revert main feature~2..feature
     +------------
     +
    -+This creates new commits on top of 'main' that reverse the changes introduced
    -+by the last three commits on 'feature'. The 'feature' branch is updated to
    -+point at the last of these revert commits. The 'main' branch is not updated
    -+in this case.
    ++This reverts the last two commits from 'feature', creating revert commits on
    ++top of 'main', and updates 'main' to point at the result. This is useful when
    ++commits from 'feature' were previously merged or cherry-picked into 'main' and
    ++need to be undone.
     +
    -+To revert commits and advance a branch:
    ++NOTE: For reverting an entire merge request as a single commit (rather than
    ++commit-by-commit), consider using `git merge-tree --merge-base $TIP HEAD $BASE`
    ++which can avoid unnecessary merge conflicts.
     +
    -+------------
    -+$ git replay --revert --advance main feature~2..feature
    -+------------
    -+
    -+This reverts the last two commits from 'feature', applies those reverts
    -+on top of 'main', and updates 'main' to point at the result. The 'feature'
    -+branch is not updated in this case.
     +
      GIT
      ---
    @@ builtin/replay.c
      #include "strmap.h"
      #include <oidset.h>
      #include <tree.h>
    +@@ builtin/replay.c: enum ref_action_mode {
    + 	REF_ACTION_PRINT,
    + };
    + 
    ++enum replay_action {
    ++	REPLAY_PICK,
    ++	REPLAY_REVERT,
    ++};
    ++
    + static const char *short_commit_name(struct repository *repo,
    + 				     struct commit *commit)
    + {
     @@ builtin/replay.c: static char *get_author(const char *message)
      	return NULL;
      }
      
    -+/*
    -+ * Generates a revert commit message using the shared sequencer function.
    -+ * We use oid_to_hex() directly instead of refer_to_commit() since git replay
    -+ * is designed for simpler server-side operations without interactive features.
    -+ */
     +static void generate_revert_message(struct strbuf *msg,
    -+				    const char *orig_message,
    -+				    const struct object_id *oid)
    ++				    struct commit *commit,
    ++				    struct repository *repo)
     +{
    -+	sequencer_format_revert_header(msg, orig_message);
    -+	strbuf_addstr(msg, oid_to_hex(oid));
    ++	const char *out_enc = get_commit_output_encoding();
    ++	const char *message = repo_logmsg_reencode(repo, commit, NULL, out_enc);
    ++	const char *subject_start;
    ++	int subject_len;
    ++	char *subject;
    ++
    ++	subject_len = find_commit_subject(message, &subject_start);
    ++	subject = xmemdupz(subject_start, subject_len);
    ++
    ++	sequencer_format_revert_header(msg, subject);
    ++	strbuf_addstr(msg, oid_to_hex(&commit->object.oid));
     +	strbuf_addstr(msg, ".\n");
    ++
    ++	free(subject);
    ++	repo_unuse_commit_buffer(repo, commit, message);
     +}
     +
      static struct commit *create_commit(struct repository *repo,
    @@ builtin/replay.c: static char *get_author(const char *message)
      				    struct commit *based_on,
     -				    struct commit *parent)
     +				    struct commit *parent,
    -+				    int is_revert)
    ++				    enum replay_action action)
      {
      	struct object_id ret;
      	struct object *obj = NULL;
     @@ builtin/replay.c: static struct commit *create_commit(struct repository *repo,
    + 
      	commit_list_insert(parent, &parents);
      	extra = read_commit_extra_headers(based_on, exclude_gpgsig);
    - 	find_commit_subject(message, &orig_message);
    +-	find_commit_subject(message, &orig_message);
     -	strbuf_addstr(&msg, orig_message);
     -	author = get_author(message);
    -+
    -+	if (is_revert) {
    -+		generate_revert_message(&msg, orig_message, &based_on->object.oid);
    -+		/* For revert, use current user as author */
    -+		author = NULL;
    ++	if (action == REPLAY_REVERT) {
    ++		generate_revert_message(&msg, based_on, repo);
    ++		author = xstrdup(git_author_info(IDENT_STRICT));
     +	} else {
    -+		/* Cherry-pick mode: use original commit message and author */
    ++		find_commit_subject(message, &orig_message);
     +		strbuf_addstr(&msg, orig_message);
     +		author = get_author(message);
     +	}
    -+
      	reset_ident_date();
      	if (commit_tree_extended(msg.buf, msg.len, &tree->object.oid, parents,
      				 &ret, author, NULL, sign_commit, extra)) {
    +@@ builtin/replay.c: static struct commit *create_commit(struct repository *repo,
    + 	obj = parse_object(repo, &ret);
    + 
    + out:
    +-	repo_unuse_commit_buffer(the_repository, based_on, message);
    ++	repo_unuse_commit_buffer(repo, based_on, message);
    + 	free_commit_extra_headers(extra);
    + 	free_commit_list(parents);
    + 	strbuf_release(&msg);
    +@@ builtin/replay.c: static void determine_replay_mode(struct repository *repo,
    + 				  struct rev_cmdline_info *cmd_info,
    + 				  const char *onto_name,
    + 				  char **advance_name,
    ++				  char **revert_name,
    + 				  struct commit **onto,
    + 				  struct strset **update_refs)
    + {
    +@@ builtin/replay.c: static void determine_replay_mode(struct repository *repo,
    + 		}
    + 		if (rinfo.positive_refexprs > 1)
    + 			die(_("cannot advance target with multiple sources because ordering would be ill-defined"));
    ++	} else if (*revert_name) {
    ++		struct object_id oid;
    ++		char *fullname = NULL;
    ++
    ++		*onto = peel_committish(repo, *revert_name);
    ++		if (repo_dwim_ref(repo, *revert_name, strlen(*revert_name),
    ++				  &oid, &fullname, 0) == 1) {
    ++			free(*revert_name);
    ++			*revert_name = fullname;
    ++		} else {
    ++			die(_("argument to --revert must be a reference"));
    ++		}
    ++		if (rinfo.positive_refexprs > 1)
    ++			die(_("cannot revert with multiple sources because ordering would be ill-defined"));
    + 	} else {
    + 		int positive_refs_complete = (
    + 			rinfo.positive_refexprs ==
     @@ builtin/replay.c: static struct commit *pick_regular_commit(struct repository *repo,
      					  kh_oid_map_t *replayed_commits,
      					  struct commit *onto,
      					  struct merge_options *merge_opt,
     -					  struct merge_result *result)
     +					  struct merge_result *result,
    -+					  int is_revert)
    ++					  enum replay_action action)
      {
      	struct commit *base, *replayed_base;
      	struct tree *pickme_tree, *base_tree;
    @@ builtin/replay.c: static struct commit *pick_regular_commit(struct repository *r
     -	merge_opt->branch1 = short_commit_name(repo, replayed_base);
     -	merge_opt->branch2 = short_commit_name(repo, pickme);
     -	merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
    --
    ++	if (action == REPLAY_PICK) {
    ++		/* Cherry-pick: normal order */
    ++		merge_opt->branch1 = short_commit_name(repo, replayed_base);
    ++		merge_opt->branch2 = short_commit_name(repo, pickme);
    ++		merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
    + 
     -	merge_incore_nonrecursive(merge_opt,
     -				  base_tree,
     -				  result->tree,
     -				  pickme_tree,
     -				  result);
    -+	if (is_revert) {
    -+		/* For revert: swap base and pickme to reverse the diff */
    ++		merge_incore_nonrecursive(merge_opt,
    ++					  base_tree,
    ++					  result->tree,
    ++					  pickme_tree,
    ++					  result);
    + 
    +-	free((char*)merge_opt->ancestor);
    ++		free((char *)merge_opt->ancestor);
    ++	} else {
    ++		/* Revert: swap base and pickme to reverse the diff */
     +		const char *pickme_name = short_commit_name(repo, pickme);
     +		merge_opt->branch1 = short_commit_name(repo, replayed_base);
     +		merge_opt->branch2 = xstrfmt("parent of %s", pickme_name);
    @@ builtin/replay.c: static struct commit *pick_regular_commit(struct repository *r
     +					  base_tree,
     +					  result);
     +
    -+		/* branch2 was allocated with xstrfmt, needs freeing */
     +		free((char *)merge_opt->branch2);
    -+	} else {
    -+		/* For cherry-pick: normal order */
    -+		merge_opt->branch1 = short_commit_name(repo, replayed_base);
    -+		merge_opt->branch2 = short_commit_name(repo, pickme);
    -+		merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
    -+
    -+		merge_incore_nonrecursive(merge_opt,
    -+					  base_tree,
    -+					  result->tree,
    -+					  pickme_tree,
    -+					  result);
    -+
    -+		/* ancestor was allocated with xstrfmt, needs freeing */
    -+		free((char *)merge_opt->ancestor);
     +	}
    - 
    --	free((char*)merge_opt->ancestor);
      	merge_opt->ancestor = NULL;
     +	merge_opt->branch2 = NULL;
      	if (!result->clean)
      		return NULL;
     -	return create_commit(repo, result->tree, pickme, replayed_base);
    -+	return create_commit(repo, result->tree, pickme, replayed_base, is_revert);
    ++	return create_commit(repo, result->tree, pickme, replayed_base, action);
      }
      
      static enum ref_action_mode parse_ref_action_mode(const char *ref_action, const char *source)
     @@ builtin/replay.c: int cmd_replay(int argc,
    + {
    + 	const char *advance_name_opt = NULL;
    + 	char *advance_name = NULL;
    ++	const char *revert_name_opt = NULL;
    ++	char *revert_name = NULL;
    ++	enum replay_action action = REPLAY_PICK;
    + 	struct commit *onto = NULL;
    + 	const char *onto_name = NULL;
      	int contained = 0;
    - 	const char *ref_action = NULL;
    - 	enum ref_action_mode ref_mode;
    -+	int is_revert = 0;
    - 
    - 	struct rev_info revs;
    - 	struct commit *last_commit = NULL;
     @@ builtin/replay.c: int cmd_replay(int argc,
    + 
      	const char *const replay_usage[] = {
      		N_("(EXPERIMENTAL!) git replay "
    - 		   "([--contained] --onto <newbase> | --advance <branch>) "
    --		   "[--ref-action[=<mode>]] <revision-range>..."),
    -+		   "[--ref-action[=<mode>]] [--revert] <revision-range>..."),
    +-		   "([--contained] --onto <newbase> | --advance <branch>) "
    ++		   "([--contained] --onto <newbase> | --advance <branch> | --revert <branch>) "
    + 		   "[--ref-action[=<mode>]] <revision-range>..."),
      		NULL
      	};
    - 	struct option replay_options[] = {
     @@ builtin/replay.c: int cmd_replay(int argc,
    + 			   N_("replay onto given commit")),
    + 		OPT_BOOL(0, "contained", &contained,
    + 			 N_("advance all branches contained in revision-range")),
    ++		OPT_STRING(0, "revert", &revert_name_opt,
    ++			   N_("branch"),
    ++			   N_("revert commits onto given branch")),
      		OPT_STRING(0, "ref-action", &ref_action,
      			   N_("mode"),
      			   N_("control ref update behavior (update|print)")),
    -+		OPT_BOOL(0, "revert", &is_revert,
    -+			 N_("revert commits instead of cherry-picking them")),
    - 		OPT_END()
    - 	};
    - 
     @@ builtin/replay.c: int cmd_replay(int argc,
    + 	argc = parse_options(argc, argv, prefix, replay_options, replay_usage,
    + 			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);
    + 
    +-	if (!onto_name && !advance_name_opt) {
    +-		error(_("option --onto or --advance is mandatory"));
    ++	/* Exactly one mode must be specified */
    ++	if (!onto_name && !advance_name_opt && !revert_name_opt) {
    ++		error(_("exactly one of --onto, --advance, or --revert is required"));
    + 		usage_with_options(replay_usage, replay_options);
    + 	}
    + 
      	die_for_incompatible_opt2(!!advance_name_opt, "--advance",
    - 				  contained, "--contained");
    +-				  contained, "--contained");
    ++				  !!onto_name, "--onto");
    ++	die_for_incompatible_opt2(!!revert_name_opt, "--revert",
    ++				  !!onto_name, "--onto");
    ++	die_for_incompatible_opt2(!!revert_name_opt, "--revert",
    ++				  !!advance_name_opt, "--advance");
    ++	die_for_incompatible_opt2(contained, "--contained",
    ++				  !onto_name, "requires --onto");
      
    -+	/* --revert is incompatible with --contained */
    -+	die_for_incompatible_opt2(is_revert, "--revert",
    -+				  contained, "--contained");
    -+
      	/* Parse ref action mode from command line or config */
      	ref_mode = get_ref_action_mode(repo, ref_action);
      
    + 	advance_name = xstrdup_or_null(advance_name_opt);
    ++	revert_name = xstrdup_or_null(revert_name_opt);
    ++	if (revert_name)
    ++		action = REPLAY_REVERT;
    + 
    + 	repo_init_revisions(repo, &revs, prefix);
    + 
    +@@ builtin/replay.c: int cmd_replay(int argc,
    + 	}
    + 
    + 	determine_replay_mode(repo, &revs.cmdline, onto_name, &advance_name,
    ++			      &revert_name,
    + 			      &onto, &update_refs);
    + 
    + 	/* Build reflog message */
    +-	if (advance_name_opt)
    ++	if (revert_name_opt)
    ++		strbuf_addf(&reflog_msg, "replay --revert %s", revert_name_opt);
    ++	else if (advance_name_opt)
    + 		strbuf_addf(&reflog_msg, "replay --advance %s", advance_name_opt);
    + 	else
    + 		strbuf_addf(&reflog_msg, "replay --onto %s",
     @@ builtin/replay.c: int cmd_replay(int argc,
      			die(_("replaying merge commits is not supported yet!"));
      
      		last_commit = pick_regular_commit(repo, commit, replayed_commits,
     -						  onto, &merge_opt, &result);
    -+						  onto, &merge_opt, &result,
    -+						  is_revert);
    ++						  onto, &merge_opt, &result, action);
      		if (!last_commit)
      			break;
      
    -
    - ## sequencer.c ##
    -@@ sequencer.c: static int do_pick_commit(struct repository *r,
    - 		if (opts->commit_use_reference) {
    - 			strbuf_commented_addf(&ctx->message, comment_line_str,
    - 				"*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
    --		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject) &&
    --			   /*
    --			    * We don't touch pre-existing repeated reverts, because
    --			    * theoretically these can be nested arbitrarily deeply,
    --			    * thus requiring excessive complexity to deal with.
    --			    */
    --			   !starts_with(orig_subject, "Revert \"")) {
    --			strbuf_addstr(&ctx->message, "Reapply \"");
    --			strbuf_addstr(&ctx->message, orig_subject);
    --			strbuf_addstr(&ctx->message, "\n");
    -+			strbuf_addstr(&ctx->message, "\nThis reverts commit ");
    - 		} else {
    --			strbuf_addstr(&ctx->message, "Revert \"");
    --			strbuf_addstr(&ctx->message, msg.subject);
    --			strbuf_addstr(&ctx->message, "\"\n");
    -+			sequencer_format_revert_header(&ctx->message, msg.subject);
    - 		}
    --		strbuf_addstr(&ctx->message, "\nThis reverts commit ");
    - 		refer_to_commit(opts, &ctx->message, commit);
    +@@ builtin/replay.c: int cmd_replay(int argc,
    + 		kh_value(replayed_commits, pos) = last_commit;
      
    - 		if (commit->parents && commit->parents->next) {
    -@@ sequencer.c: int sequencer_pick_revisions(struct repository *r,
    - 	return res;
    - }
    + 		/* Update any necessary branches */
    +-		if (advance_name)
    ++		if (advance_name || revert_name)
    + 			continue;
    + 		decoration = get_name_decoration(&commit->object);
    + 		if (!decoration)
    +@@ builtin/replay.c: int cmd_replay(int argc,
    + 		}
    + 	}
      
    -+void sequencer_format_revert_header(struct strbuf *out, const char *orig_subject)
    -+{
    -+	const char *revert_subject;
    -+
    -+	if (skip_prefix(orig_subject, "Revert \"", &revert_subject) &&
    -+	    /*
    -+	     * We don't touch pre-existing repeated reverts, because
    -+	     * theoretically these can be nested arbitrarily deeply,
    -+	     * thus requiring excessive complexity to deal with.
    -+	     */
    -+	    !starts_with(revert_subject, "Revert \"")) {
    -+		strbuf_addstr(out, "Reapply \"");
    -+		strbuf_addstr(out, revert_subject);
    -+		strbuf_addch(out, '\n');
    -+	} else {
    -+		strbuf_addstr(out, "Revert \"");
    -+		strbuf_addstr(out, orig_subject);
    -+		strbuf_addstr(out, "\"\n");
    +-	/* In --advance mode, advance the target ref */
    ++	/* In --advance or --revert mode, update the target ref */
    + 	if (result.clean == 1 && advance_name) {
    + 		if (handle_ref_update(ref_mode, transaction, advance_name,
    + 				      &last_commit->object.oid,
    +@@ builtin/replay.c: int cmd_replay(int argc,
    + 			goto cleanup;
    + 		}
    + 	}
    ++	if (result.clean == 1 && revert_name) {
    ++		if (handle_ref_update(ref_mode, transaction, revert_name,
    ++				      &last_commit->object.oid,
    ++				      &onto->object.oid,
    ++				      reflog_msg.buf,
    ++				      &transaction_err) < 0) {
    ++			ret = error(_("failed to update ref '%s': %s"),
    ++				    revert_name, transaction_err.buf);
    ++			goto cleanup;
    ++		}
     +	}
    -+
    -+	strbuf_addstr(out, "\nThis reverts commit ");
    -+}
    -+
    - void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
    - {
    - 	unsigned no_dup_sob = flag & APPEND_SIGNOFF_DEDUP;
    -
    - ## sequencer.h ##
    -@@ sequencer.h: int todo_list_rearrange_squash(struct todo_list *todo_list);
    -  */
    - void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag);
      
    -+/*
    -+ * Formats a revert commit message header following standard Git conventions.
    -+ * Handles both regular reverts ("Revert \"<subject>\"") and revert of revert
    -+ * cases ("Reapply \"<subject>\""). Adds "This reverts commit " at the end.
    -+ * The caller should append the commit OID after calling this function.
    -+ */
    -+void sequencer_format_revert_header(struct strbuf *out, const char *orig_subject);
    -+
    - void append_conflicts_hint(struct index_state *istate,
    - 		struct strbuf *msgbuf, enum commit_msg_cleanup_mode cleanup_mode);
    - enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
    + 	/* Commit the ref transaction if we have one */
    + 	if (transaction && result.clean == 1) {
     
      ## t/t3650-replay-basics.sh ##
     @@ t/t3650-replay-basics.sh: test_expect_success 'invalid replay.refAction value' '
      	test_grep "invalid.*replay.refAction.*value" error
      '
      
    -+test_expect_success 'using replay with --revert to revert a commit' '
    -+	# Revert commits D and E from topic2
    -+	git replay --revert --onto topic1 topic1..topic2 >result &&
    -+
    -+	test_must_be_empty result &&
    -+
    -+	# Verify the commit messages contain "Revert"
    -+	# topic1..topic2 contains D and E, so we get 2 reverts on top of topic1 (which has F, C, B, A)
    -+	git log --format=%s topic2 >actual &&
    -+	test_line_count = 6 actual &&
    -+	head -n 1 actual >first-line &&
    -+	test_grep "^Revert" first-line
    ++test_expect_success 'setup for revert tests' '
    ++	git switch -c revert-test main &&
    ++	test_commit R1 &&
    ++	test_commit R2 &&
    ++	test_commit R3 &&
    ++	git switch main
     +'
     +
    -+test_expect_success 'using replay with --revert on bare repo' '
    -+	git -C bare replay --revert --onto topic1 topic1..topic2 >result-bare &&
    -+
    -+	test_must_be_empty result-bare &&
    -+
    -+	# Verify the commit message contains "Revert"
    -+	git -C bare log --format=%s topic2 >actual-bare &&
    -+	test_line_count = 6 actual-bare &&
    -+	head -n 1 actual-bare >first-line-bare &&
    -+	test_grep "^Revert" first-line-bare
    ++test_expect_success 'git replay --revert reverts commits' '
    ++	# Store original state
    ++	START=$(git rev-parse revert-test) &&
    ++	test_when_finished "git branch -f revert-test $START" &&
    ++
    ++	git replay --revert revert-test revert-test~2..revert-test >output &&
    ++	test_must_be_empty output &&
    ++
    ++	# Verify revert-test was updated with revert commits
    ++	git log --format=%s -n 5 revert-test >actual &&
    ++	cat >expect <<-\EOF &&
    ++	Revert "R3"
    ++	Revert "R2"
    ++	R3
    ++	R2
    ++	R1
    ++	EOF
    ++	test_cmp expect actual &&
    ++
    ++	# Verify commit message format
    ++	test_commit_message revert-test -m "Revert \"R3\"
    ++
    ++This reverts commit $(git rev-parse R3)."
     +'
     +
    -+test_expect_success 'using replay with --revert and --advance' '
    -+	# Revert commits from topic2 and advance main
    -+	git replay --revert --advance main topic1..topic2 >result &&
    ++test_expect_success 'git replay --revert with --ref-action=print' '
    ++	# Store original state
    ++	START=$(git rev-parse revert-test) &&
    ++	test_when_finished "git branch -f revert-test $START" &&
     +
    -+	test_must_be_empty result &&
    ++	git replay --ref-action=print --revert revert-test revert-test~2..revert-test >result &&
    ++	test_line_count = 1 result &&
     +
    -+	# Verify the commit message contains "Revert"
    -+	git log --format=%s main >actual &&
    -+	head -n 1 actual >first-line &&
    -+	test_grep "^Revert" first-line
    ++	# Verify output format: update refs/heads/revert-test <new> <old>
    ++	cut -f 3 -d " " result >new-tip &&
    ++	printf "update refs/heads/revert-test " >expect &&
    ++	printf "%s " $(cat new-tip) >>expect &&
    ++	printf "%s\n" $START >>expect &&
    ++	test_cmp expect result
     +'
     +
    -+test_expect_success 'replay with --revert fails with --contained' '
    -+	test_must_fail git replay --revert --contained --onto main main..topic3 2>error &&
    -+	test_grep "revert.*contained.*cannot be used together" error
    -+'
    ++test_expect_success 'git replay --revert reapply behavior' '
    ++	# Store original state
    ++	START=$(git rev-parse revert-test) &&
    ++	test_when_finished "git branch -f revert-test $START" &&
     +
    -+test_expect_success 'verify revert actually reverses changes' '
    -+	# Create a branch with a simple change
    -+	git switch -c revert-test main &&
    -+	echo "new content" >test-file.txt &&
    -+	git add test-file.txt &&
    -+	git commit -m "Add test file" &&
    ++	# First revert R3
    ++	git replay --revert revert-test revert-test~1..revert-test &&
    ++	REVERT_R3=$(git rev-parse revert-test) &&
     +
    -+	# Revert the commit
    -+	git replay --revert --advance revert-test HEAD^..HEAD >result &&
    ++	# Now revert the revert (should create "Reapply" message)
    ++	git replay --revert revert-test revert-test~1..revert-test >output &&
    ++	test_must_be_empty output &&
     +
    -+	test_must_be_empty result &&
    ++	# Verify Reapply message
    ++	test_commit_message revert-test -m "Reapply \"R3\"
     +
    -+	# The file should no longer exist (reverted)
    -+	test_must_fail git show revert-test:test-file.txt
    ++This reverts commit $(git rev-parse $REVERT_R3)."
     +'
     +
    -+test_expect_success 'revert of a revert creates reapply message' '
    -+	# Create a commit
    -+	git switch -c revert-revert main &&
    -+	echo "content" >revert-test-2.txt &&
    -+	git add revert-test-2.txt &&
    -+	git commit -m "Add revert test file" &&
    -+
    -+	ORIGINAL=$(git rev-parse HEAD) &&
    -+
    -+	# First revert
    -+	git replay --revert --advance revert-revert HEAD^..HEAD >result1 &&
    -+
    -+	test_must_be_empty result1 &&
    -+
    -+	# Check first revert message starts with "Revert"
    -+	git log --format=%s -1 revert-revert >msg1 &&
    -+	test_grep "^Revert" msg1 &&
    -+
    -+	FIRST_REVERT=$(git rev-parse revert-revert) &&
    -+
    -+	# Now revert the revert
    -+	git replay --revert --advance revert-revert $ORIGINAL..$FIRST_REVERT >result2 &&
    -+
    -+	test_must_be_empty result2 &&
    -+
    -+	# Check second revert message starts with "Reapply"
    -+	git log --format=%s -1 revert-revert >msg2 &&
    -+	test_grep "^Reapply" msg2 &&
    -+
    -+	# The file should exist again (reapplied)
    -+	git show revert-revert:revert-test-2.txt >actual &&
    -+	echo "content" >expected &&
    -+	test_cmp expected actual
    ++test_expect_success 'git replay --revert with conflict' '
    ++	# Create a conflicting scenario
    ++	git switch -c revert-conflict main &&
    ++	test_commit C1 &&
    ++	echo conflict >C1.t &&
    ++	test_commit C2 C1.t &&
    ++	git switch main &&
    ++	echo different >C1.t &&
    ++	test_commit C3 C1.t &&
    ++
    ++	# Try to revert C2 onto main (which has conflicting C3)
    ++	test_expect_code 1 git replay --revert main revert-conflict~1..revert-conflict
     +'
     +
    -+test_expect_success 'replay --revert includes commit SHA in message' '
    -+	git switch -c revert-sha-test main &&
    -+	echo "test" >sha-test.txt &&
    -+	git add sha-test.txt &&
    -+	git commit -m "Test commit for SHA" &&
    -+
    -+	COMMIT_SHA=$(git rev-parse HEAD) &&
    -+	git replay --revert --advance revert-sha-test HEAD^..HEAD >result &&
    ++test_expect_success 'git replay --revert reflog message' '
    ++	# Store original state
    ++	START=$(git rev-parse revert-test) &&
    ++	test_when_finished "git branch -f revert-test $START" &&
     +
    -+	test_must_be_empty result &&
    ++	git replay --revert revert-test revert-test~1..revert-test >output &&
    ++	test_must_be_empty output &&
     +
    -+	# Check that the commit message includes the original SHA
    -+	git log --format=%B -1 revert-sha-test >msg &&
    -+	test_grep "$COMMIT_SHA" msg
    ++	# Verify reflog message includes --revert and branch name
    ++	git reflog revert-test -1 --format=%gs >reflog-msg &&
    ++	echo "replay --revert revert-test" >expect-reflog &&
    ++	test_cmp expect-reflog reflog-msg
     +'
     +
    -+test_expect_success 'replay --revert with conflict' '
    -+	# Create a conflicting situation
    -+	git switch -c revert-conflict main &&
    -+	echo "line1" >conflict-file.txt &&
    -+	git add conflict-file.txt &&
    -+	git commit -m "Add conflict file" &&
    -+
    -+	git switch -c revert-conflict-branch HEAD^ &&
    -+	echo "different" >conflict-file.txt &&
    -+	git add conflict-file.txt &&
    -+	git commit -m "Different content" &&
    -+
    -+	# Try to revert the first commit onto the conflicting branch
    -+	test_expect_code 1 git replay --revert --onto revert-conflict-branch revert-conflict^..revert-conflict
    ++test_expect_success 'git replay --revert incompatible with --contained' '
    ++	test_must_fail git replay --revert revert-test --contained revert-test~1..revert-test 2>error &&
    ++	test_grep "requires --onto" error
     +'
     +
    -+test_expect_success 'replay --revert handles multiple commits' '
    -+	# Save the original topic2 state
    -+	ORIG_TOPIC2=$(git rev-parse topic2) &&
    -+	test_when_finished "git branch -f topic2 $ORIG_TOPIC2" &&
    -+
    -+	# Revert D and E from topic2, applying the reverts onto topic1
    -+	git replay --revert --onto topic1 topic1..topic2 >result &&
    -+
    -+	test_must_be_empty result &&
    -+
    -+	# Verify both revert commits appear in the log
    -+	git log --format=%s topic2 >log &&
    -+	head -n 2 log >first-two &&
    -+	test_grep "^Revert" first-two &&
    ++test_expect_success 'git replay --revert incompatible with --onto' '
    ++	test_must_fail git replay --revert revert-test --onto main revert-test~1..revert-test 2>error &&
    ++	test_grep "cannot be used together" error
    ++'
     +
    -+	# Verify we have both "Revert D" and "Revert E"
    -+	test_grep "Revert.*E" log &&
    -+	test_grep "Revert.*D" log
    ++test_expect_success 'git replay --revert incompatible with --advance' '
    ++	test_must_fail git replay --revert revert-test --advance main revert-test~1..revert-test 2>error &&
    ++	test_grep "cannot be used together" error
     +'
     +
      test_done

-- 
2.51.0

base-commit: f0ef5b6d9bcc258e4cbef93839d1b7465d5212b9

Thanks
- Siddharth
