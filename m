Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794052541;
	b=Arxlbk3L9DppxktkEgJwuVu/v6qi1EX0leLjngQtpPCzwVJeb34Ts/If/KvFLGcLKsZu
	 dGRc6A1v2lXPxJMteHRGo6HNNfyNHrLdRerZ/g3h+zvhDLdXjr/e59zb+SZPtaQ0G9YP7
	 1IZBxJAlbIazeSrHpN5e8p26aTqGIua5Wc8tvhJrmvUTX7bZWMSC5opl+zg/uzrU5qT+b
	 F5WqGlH/C6KHenNRI5NWoT79nTTD+EMiDRNgbU/5k26+KltwDkPzSzZVTvwGGT4iwb7Rj
	 EapQVOydgkP0YldiyZTTMsunBttHOtgJ9f1dGTdXgMarQoPFbivfwLZuSj3BbVYm+pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794052541;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=0+DeMTnnPlt+HqsDqwTzd58CNFejGQz5m6t8sSgnKTs=;
	b=YOToYoYJ5IqjX7KxqJIioPViLbpkim6AA2rJfx6zBdR8NizaoJ+4f98G+Z984EYRm12b
	 4qU8mTZsJVRdq38d3tGS4Kv4P3/toDuqTeaBeBIgdQdmmFpIsm9mQ6KODVUo/AbC6DPs8
	 JqoXp1eZL0Q4U8FYI2Rnl6X1VngVZXI8X2uwj3iyIKqWTlMNR0AbxoWka/VYrFQKCPGV1
	 Ttxb6xcYTD3gc9rjeI2HYdaBfwLwDG2Z5rYhJxNW1Ub8w+5rhBCFAni8NLX6zmK1z14ww
	 WiqRACM27UOjlWQ76M621izNPJIU5vI+D+LVSd7Mwyd+XOsdSyjT5w4ftcdCTej04Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PFwVktfL;
	arc=none smtp.remote-ip=209.85.167.171
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC802606A32C
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 11:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC802606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PFwVktfL
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4b28d7c729fso1110870b6e.0
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 03:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794052540; x=1794657340; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0+DeMTnnPlt+HqsDqwTzd58CNFejGQz5m6t8sSgnKTs=;
        b=PFwVktfL2xih1g+8/KQjAS9aXX9keGS64MVjoTeyTDtJuTBfplT1w7BTQPt2KhwZHN
         ZaAVFWdRmSrEQnNksch2LCgx7+pAfOvvMkuR5xsfRhd6P5THb4vTkijMBFaDaaX1wybE
         XISwcuKB+sfC4Q5l/f177IFBOk26cB0ULY2/7WWyT+5iPfhEp5bU1smV9ytzjzqyvAuW
         psrkhZgy6JfWXDOj9ZJCUf3S/M2GX5HzyhfKi+Vzb4iRSRxVL2F0fExhpWJdaZk1w+00
         wy7wCjnTFQIUc+V2Kpj2J9vHkIFg1TjbsDihvyBTyp5W5g4BEirBh77KZw+TD8LGvmiI
         cr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794052540; x=1794657340;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0+DeMTnnPlt+HqsDqwTzd58CNFejGQz5m6t8sSgnKTs=;
        b=EZI5yAgAd+GOlt3wnI06Ek3c2J/47yr9Mg98cHQX5PSBcMeBKxr+zoWRI7/lwmjlfb
         WkO4YZ51zPg7BZc4LtiahwdkOkpySBFfgS/K7JhIUJRGFTH2dCtfCGFpiGSMx1OiHAcn
         22AmjGp2iMAwLJ+6jf52qLrW9PJwF8HvzomXchFYNj484c9SUMRBRrkixQvpOj9JSPIu
         wf2XipZbED3zF+bG4M0Y2SrAm00XK73aTjCpgp7wiCn+FauLrA9mJh0A/Od1NJuwGIcQ
         xVLkuTdd84chXSV2yDymKoj0Fj4u6c/Cy+Fa98K2Ogp/lL9CVZyJC8qNMQ5rt11oiXRz
         L3aA==
X-Gm-Message-State: APuU4Z+wrwQJph1v9LM+mU035iC3TNs06kpidHZrVGsplMtRn7KK37jv
	OWn72ohOxOPubtsBm7yigkBeg4IPbD0NoLu6Wjw/XQKyAKZI/s3O2CfGxiy6reB7
X-Gm-Gg: AYBFou1zfGF/tFhyJ1r6MqZ+/z3t//IBB73FYm/v8mSXidgZBWX/EOZqKYNupesO81u
	oM5KjhUybHHUl6eaPHrE5YayI95urqaguYO/yDM/jckzLkq8WLOscNsgRAJAeJFzYEmtAS5/d+r
	4a4WQTTgZxGTgRZoFdJghHdslqsbFXPwxdWWfNXdiQ60JkYcORsrkjQPd6OMEPIZnngVMKILkjh
	CpGqRzT2ovNQeyIfCEgj1M1En1z+gYlaUiyjiNJiJYE5anFiYGsygBFKwIKFcSvCSt/xoEQikTG
	SdBMGyI9kttotpOjxn2vItxTmg7ANOO/qsh/tQDU4jUR+2szfcMwxAtoCLh3iqmJV8awCfYes/c
	uflmKQ+W6mcHqmZtA5W4EqKQlPT8/FZ98UYWZSRiwqnZTA6f/xmTR6VPqx51Y5VIjk1wEbFSLyR
	rQx+mRwmhSE517iGPDStpDsZbGkdcwNUTEvXNBo3Ch2hBoq3WLp94fmVXsBaBpP25IXJOdcYlye
	fsPQrCPJRQrjJRPT/QxLVIkfN+TVca6cgwR48xrzO4sOPKCMDkFVde6QqfEbaUOFeXpKOUf7e9n
	GmEgflFViFX2ohQf3eDLYBhpqtidDyBw
X-Received: by 2002:a05:6808:f04:b0:4f9:595:b80c with SMTP id 5614622812f47-567e160ad12mr4381169b6e.41.1794052539414;
        Sat, 07 Nov 2026 03:55:39 -0800 (PST)
Received: from [127.0.0.1] ([13.86.110.186])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567e7d8b4besm3777649b6e.6.2026.11.07.03.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 03:55:37 -0800 (PST)
Message-Id: <pull.2448.v5.git.git.1794052536.gitgitgadget@gmail.com>
In-Reply-To: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 11:55:34 +0000
Subject: [PATCH v5 0/2] reflog: add format %gb
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

Create a better reflog. Follows the discussion in
https://lore.kernel.org/git/akZfm-igZKeHaDST@pks.im/.

The reflog of HEAD records the work done on every branch, so "git reflog"
mixes them and does not say which entry was made on which branch. This adds
a "%gb" placeholder that names the branch HEAD was on when each entry was
recorded:

$ git log -g --format='%h %gd: (%gb) %gs'
9c8d7e6 HEAD@{0}: (topic) rebase (finish): returning to refs/heads/topic
1a2b3c4 HEAD@{2}: (topic) rebase (start): checkout main
1a2b3c4 HEAD@{3}: (main) commit: fix typo


It follows branch switches, branch renames and rebases, including "git
rebase ", rebases of a detached HEAD and rebases of a branch that was
already up to date. When HEAD was detached, the entry shows "detached at ".

Changes in v5:

 * detached at <commit> now names the commit HEAD was detached at, or for a
   detached rebase, the commit it ended on.
 * git rebase <upstream> <rev> counts <rev> as a branch only if
   refs/heads/<rev> exists, so origin/main and refs/heads/main show as
   detached.
 * A commit whose subject starts with checkout is no longer taken for a
   rebase checkout.
 * Added Phillip's test, and tests for a detached rebase that fast-forwards
   and one that is aborted.

Changes in v4:

 * %gb now names the right branch when git rebase <upstream> <branch> runs
   with GIT_REFLOG_ACTION set.
 * Reworded the %gb commit message.

Changes in v3:

 * Dropped --operations.
 * Replaced --historical-branch with a %gb placeholder for --format, e.g.
   git log -g --format='%h %gd: (%gb) %gs'.
 * %gb names the right branch after git rebase <upstream> <branch>, a rebase
   of a detached HEAD and an up-to-date rebase.
 * Named the returning to and checkout reflog strings in reflog.h too.

Changes in v2:

 * Move the "historical branch" rightward in the display for cleaner
   alignment.
 * Improve commit messages.

Harald Nordgren (2):
  reflog: name the strings that mark switches, renames and rebase steps
  pretty: add %gb to name the branch of each reflog entry

 Documentation/pretty-formats.adoc |   3 +
 builtin/branch.c                  |   3 +-
 builtin/checkout.c                |   3 +-
 builtin/rebase.c                  |  19 +--
 object-name.c                     |   3 +-
 pretty.c                          |   4 +
 reflog-walk.c                     | 217 +++++++++++++++++++++++++++-
 reflog-walk.h                     |   2 +
 reflog.h                          |   9 ++
 sequencer.c                       |  15 +-
 t/t1414-reflog-walk.sh            | 229 ++++++++++++++++++++++++++++++
 wt-status.c                       |   3 +-
 12 files changed, 484 insertions(+), 26 deletions(-)


base-commit: fb255012acbcbe81189cb8014da0280b09c66ecc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2448%2FHaraldNordgren%2Freflog-operations-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2448/HaraldNordgren/reflog-operations-v5
Pull-Request: https://github.com/git/git/pull/2448

Range-diff vs v4:

 1:  f960a24b8b ! 1:  115b5a81b7 reflog: name the strings that mark switches, renames and rebase steps
     @@ Commit message
          messages are written or read: the "checkout: moving from " prefix
          written by "git checkout", the "Branch: renamed " prefix written by
          "git branch -m", and the "start", "finish" and "abort" steps, the
     -    "returning to " before the branch a rebase goes back to and the
     -    "checkout " before what it checks out, all written by "git rebase".
     +    "returning to " before the branch a rebase goes back to, the
     +    "checkout " before what it checks out and the "fast-forward" it
     +    records when a commit can be reused, all written by "git rebase".
      
          No change in behavior.
      
     @@ reflog.h
      +#define REFLOG_STEP_ABORT "abort"
      +#define REFLOG_RETURNING_TO "returning to "
      +#define REFLOG_CHECKOUT "checkout "
     ++#define REFLOG_FAST_FORWARD "fast-forward"
      +
       #define REFLOG_EXPIRE_TOTAL   (1 << 0)
       #define REFLOG_EXPIRE_UNREACH (1 << 1)
     @@ sequencer.c
       #include "sparse-index.h"
       #include "strvec.h"
       #include "quote.h"
     +@@ sequencer.c: static int fast_forward_to(struct repository *r,
     + 	if (checkout_fast_forward(r, from, to, 1))
     + 		return -1; /* the callee should have complained already */
     + 
     +-	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
     ++	strbuf_addf(&sb, "%s: " REFLOG_FAST_FORWARD, action_name(opts));
     + 
     + 	transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
     + 						  0, &err);
      @@ sequencer.c: static int checkout_onto(struct repository *r, struct replay_opts *opts,
       			 RESET_WORKING_TREE_UPDATE_HEAD |
       			 RESET_WORKING_TREE_UPDATE_ORIG_HEAD |
 2:  99a1047702 ! 2:  34bb930908 pretty: add %gb to name the branch of each reflog entry
     @@ Commit message
          The branch is read from the entries created by branch switches,
          branch renames and rebases. The entries of a rebase are labeled with
          the branch being rebased. When HEAD was detached, the entry shows
     -    "detached at <commit>" with the commit HEAD was at when it moved on.
     +    "detached at <commit>" with the commit HEAD was detached at, or for a
     +    rebase of a detached HEAD the commit the rebase ended on. These
     +    entries only record what was typed, so when no newer entry says
     +    otherwise, a name counts as a branch if a branch of that name exists.
          When nothing older in the reflog says which branch a rebase started
          on, the rebase is taken to have started on the branch it rebased. For
          the reflog of any other ref, "%gb" is the name of that ref.
     @@ reflog-walk.c: static void complete_reflogs_clear(void *util, const char *str UN
       	free_complete_reflog(array);
       }
       
     -+static char *branch_label(const char *name, size_t len,
     -+			  const struct object_id *oid)
     -+{
     -+	if (name) {
     -+		struct object_id hex_oid;
     -+		char *branch;
     -+
     -+		if (skip_prefix(name, "refs/heads/", &name))
     -+			len -= strlen("refs/heads/");
     -+		branch = xmemdupz(name, len);
     -+		if (strcmp(branch, "HEAD") && get_oid_hex(branch, &hex_oid) &&
     -+		    !check_refname_format(branch, REFNAME_ALLOW_ONELEVEL))
     -+			return branch;
     -+		free(branch);
     -+	}
     -+	return xstrfmt("detached at %s",
     -+		       repo_find_unique_abbrev(the_repository, oid,
     -+					       DEFAULT_ABBREV));
     -+}
     -+
      +static const char *skip_rebase_step(const char *message, const char *step)
      +{
      +	const char *p = strstr(message, " (");
     @@ reflog-walk.c: static void complete_reflogs_clear(void *util, const char *str UN
      +	return p;
      +}
      +
     -+static const char *skip_rebase_checkout(const char *message)
     ++static bool is_commit_subject(const char *text, const struct object_id *oid)
      +{
     -+	const char *p = strstr(message, " (");
     -+	const char *colon = strstr(message, ": ");
     ++	struct commit *commit = lookup_commit_reference_gently(the_repository,
     ++							       oid, 1);
     ++	const char *buffer, *subject;
     ++	size_t len;
     ++	bool ret;
     ++
     ++	if (!commit)
     ++		return false;
     ++	buffer = repo_get_commit_buffer(the_repository, commit, NULL);
     ++	len = find_commit_subject(buffer, &subject);
     ++	ret = strcspn(text, "\n") == len && !memcmp(text, subject, len);
     ++	repo_unuse_commit_buffer(the_repository, commit, buffer);
     ++	return ret;
     ++}
      +
     -+	if (!colon || (p && p < colon) ||
     -+	    !skip_prefix(colon + 2, REFLOG_CHECKOUT, &p))
     ++static const char *skip_rebase_checkout(const struct reflog_info *item)
     ++{
     ++	const char *colon = strstr(item->message, ": ");
     ++	const char *rev;
     ++
     ++	if (!colon || !skip_prefix(colon + 2, REFLOG_CHECKOUT, &rev) ||
     ++	    is_commit_subject(colon + 2, &item->noid))
      +		return NULL;
     -+	return p;
     ++	return rev;
     ++}
     ++
     ++static const char *existing_branch(const char *name)
     ++{
     ++	char *ref = xstrfmt("refs/heads/%.*s", (int)strcspn(name, "\n"), name);
     ++	bool exists = refs_ref_exists(get_main_ref_store(the_repository), ref);
     ++
     ++	free(ref);
     ++	return exists ? name : NULL;
      +}
      +
      +struct branch_move {
      +	const char *from, *to;
      +	size_t from_len, to_len;
     ++	bool from_detached;
      +};
      +
     -+static bool parse_branch_move(const char *message, struct branch_move *move)
     ++static bool parse_branch_move(const struct reflog_info *item,
     ++			      struct branch_move *move)
      +{
     -+	const char *to;
     ++	const char *message = item->message;
     ++	const char *from, *to, *end;
     ++	struct object_id oid;
      +
     -+	move->from = move->to = NULL;
     -+	move->from_len = move->to_len = 0;
     -+	if (skip_prefix(message, REFLOG_SWITCH_PREFIX, &move->from) ||
     -+	    skip_prefix(message, REFLOG_RENAME_PREFIX, &move->from)) {
     -+		to = strstr(move->from, " to ");
     ++	memset(move, 0, sizeof(*move));
     ++	if (skip_prefix(message, REFLOG_SWITCH_PREFIX, &from)) {
     ++		to = strstr(from, " to ");
      +		if (!to)
      +			return false;
     -+		move->from_len = to - move->from;
     -+		move->to = to + strlen(" to ");
     ++		if (!parse_oid_hex(from, &oid, &end) && end == to) {
     ++			move->from_detached = true;
     ++		} else {
     ++			move->from = from;
     ++			move->from_len = to - from;
     ++		}
     ++		move->to = existing_branch(to + strlen(" to "));
     ++	} else if (skip_prefix(message, REFLOG_RENAME_PREFIX "refs/heads/",
     ++			       &from)) {
     ++		to = strstr(from, " to refs/heads/");
     ++		if (!to)
     ++			return false;
     ++		move->from = from;
     ++		move->from_len = to - from;
     ++		move->to = to + strlen(" to refs/heads/");
      +	} else if (((to = skip_rebase_step(message, REFLOG_STEP_FINISH)) ||
      +		    (to = skip_rebase_step(message, REFLOG_STEP_ABORT))) &&
     -+		   skip_prefix(to, REFLOG_RETURNING_TO, &to)) {
     ++		   skip_prefix(to, REFLOG_RETURNING_TO "refs/heads/", &to)) {
      +		move->from = move->to = to;
      +		move->from_len = strcspn(to, "\n");
     -+	} else if ((to = skip_rebase_checkout(message))) {
     -+		move->to = to;
     -+	} else if (!skip_rebase_step(message, REFLOG_STEP_START)) {
     ++	} else if (skip_rebase_step(message, REFLOG_STEP_START)) {
     ++		return true;
     ++	} else if ((to = skip_rebase_checkout(item))) {
     ++		move->to = existing_branch(to);
     ++	} else {
      +		return false;
      +	}
      +	if (move->to)
     @@ reflog-walk.c: static void complete_reflogs_clear(void *util, const char *str UN
      +	return true;
      +}
      +
     ++static char *detached_label(const struct complete_reflogs *array,
     ++			    int i, int end)
     ++{
     ++	const struct reflog_info *item = &array->items[i];
     ++
     ++	if (skip_rebase_step(item->message, REFLOG_STEP_START)) {
     ++		size_t len = strstr(item->message, " (") + 2 - item->message;
     ++
     ++		for (int j = end - 1; j > i; j--) {
     ++			const char *message = array->items[j].message;
     ++
     ++			if (!strncmp(message, item->message, len) ||
     ++			    starts_with(message,
     ++					"rebase: " REFLOG_FAST_FORWARD)) {
     ++				item = &array->items[j];
     ++				break;
     ++			}
     ++		}
     ++	}
     ++	return xstrfmt("detached at %s",
     ++		       repo_find_unique_abbrev(the_repository, &item->noid,
     ++					       DEFAULT_ABBREV));
     ++}
     ++
      +static void mark_branches(struct complete_reflogs *array)
      +{
      +	struct ref_store *refs = get_main_ref_store(the_repository);
     -+	struct object_id oid;
     -+	const char *head = refs_resolve_ref_unsafe(refs, "HEAD", 0, &oid, NULL);
     ++	const char *head = refs_resolve_ref_unsafe(refs, "HEAD", 0, NULL, NULL);
      +	char *branch = NULL;
     -+	int unknown = array->nr;
     ++	bool detached = false;
     ++	int unlabeled = array->nr;
      +
     -+	if (head)
     -+		branch = branch_label(head, strlen(head), &oid);
     ++	if (head && skip_prefix(head, "refs/heads/", &head))
     ++		branch = xstrdup(head);
     ++	else if (head)
     ++		detached = true;
      +
      +	for (int i = array->nr - 1; i >= 0; i--) {
      +		struct reflog_info *item = &array->items[i];
      +		struct branch_move move;
      +
     -+		if (!parse_branch_move(item->message, &move)) {
     ++		if (!parse_branch_move(item, &move)) {
      +			item->branch = xstrdup_or_null(branch);
      +			continue;
      +		}
      +
      +		if (!branch) {
     -+			branch = branch_label(move.to, move.to_len,
     -+					      &array->items[unknown - 1].noid);
     -+			for (int j = i + 1; j < unknown; j++)
     ++			branch = move.to && !detached ?
     ++				xmemdupz(move.to, move.to_len) :
     ++				detached_label(array, i, unlabeled);
     ++			for (int j = i + 1; j < unlabeled; j++)
      +				array->items[j].branch = xstrdup(branch);
      +		}
      +		item->branch = branch;
     -+		if (move.from) {
     -+			branch = branch_label(move.from, move.from_len,
     -+					      &item->ooid);
     -+		} else {
     -+			branch = NULL;
     -+			unknown = i;
     -+		}
     ++		branch = move.from ? xmemdupz(move.from, move.from_len) : NULL;
     ++		detached = move.from_detached;
     ++		unlabeled = i;
      +	}
      +
     -+	if (!branch && unknown < array->nr)
     -+		for (int i = 0; i < unknown; i++)
     -+			array->items[i].branch =
     -+				xstrdup(array->items[unknown].branch);
     ++	if (!branch) {
     ++		if (detached)
     ++			branch = detached_label(array, 0, unlabeled);
     ++		else if (unlabeled < array->nr)
     ++			branch = xstrdup(array->items[unlabeled].branch);
     ++		for (int i = 0; branch && i < unlabeled; i++)
     ++			array->items[i].branch = xstrdup(branch);
     ++	}
      +	free(branch);
      +}
      +
     @@ t/t1414-reflog-walk.sh: test_expect_success 'walk prefers reflog to ref tip' '
      +	)
      +'
      +
     -+test_expect_success '%gb names a detached HEAD by the commit it was left at' '
     ++test_expect_success '%gb names a detached HEAD by the commit it was detached at' '
      +	(
      +		cd branches &&
      +		git switch --detach topic~1 &&
     ++		detached_at=$(git rev-parse --short HEAD) &&
      +		test_commit detached &&
      +		git rebase topic &&
      +		rebased=$(git rev-parse HEAD) &&
      +		git switch topic &&
      +
     -+		left_before=$(git rev-parse --short detached) &&
     -+		left_after=$(git rev-parse --short $rebased) &&
     ++		rebased_at=$(git rev-parse --short $rebased) &&
      +		cat >expect <<-EOF &&
      +		(topic) checkout: moving from $rebased to topic
     -+		(detached at $left_after) rebase (pick): detached
     -+		(detached at $left_after) rebase (start): checkout topic
     -+		(detached at $left_before) commit: detached
     -+		(detached at $left_before) checkout: moving from topic to topic~1
     ++		(detached at $rebased_at) rebase (pick): detached
     ++		(detached at $rebased_at) rebase (start): checkout topic
     ++		(detached at $detached_at) commit: detached
     ++		(detached at $detached_at) checkout: moving from topic to topic~1
      +		EOF
      +		git log -g -5 --format="(%gb) %gs" >actual &&
      +		test_cmp expect actual
      +	)
      +'
      +
     -+test_expect_success '%gb names the branch of a "git pull --rebase" in a fresh clone' '
     -+	git clone branches downstream &&
     ++test_expect_success '%gb names a detached rebase by the commit it ended on' '
     ++	write_script add-exec <<-\EOF &&
     ++	{ echo "exec true" && cat "$1"; } >"$1.new" &&
     ++	mv "$1.new" "$1"
     ++	EOF
      +	(
      +		cd branches &&
     -+		test_commit upstream-change
     -+	) &&
     ++		git switch --detach topic^0 &&
     ++		test_set_sequence_editor "$TRASH_DIRECTORY/add-exec" &&
     ++		git rebase -i @^ &&
     ++		ended_at=$(git rev-parse --short HEAD) &&
     ++		test_commit after-fast-forward &&
     ++
     ++		cat >expect <<-EOF &&
     ++		(detached at $ended_at) commit: after-fast-forward
     ++		(detached at $ended_at) rebase: fast-forward
     ++		(detached at $ended_at) rebase (start): checkout @^
     ++		EOF
     ++		git log -g -3 --format="(%gb) %gs" >actual &&
     ++		test_cmp expect actual
     ++	)
     ++'
     ++
     ++test_expect_success '%gb names an aborted rebase of a detached HEAD' '
      +	(
     -+		cd downstream &&
     -+		test_commit local-change &&
     -+		git pull --rebase &&
     ++		cd branches &&
     ++		git switch --detach topic^0 &&
     ++		test_must_fail git rebase -f -x false @^ &&
     ++		git rebase --abort &&
     ++		returned_to=$(git rev-parse HEAD) &&
     ++		short=$(git rev-parse --short HEAD) &&
      +
     -+		echo "(topic)" >expect &&
     -+		git log -g --format="(%gb)" >out &&
     -+		sort -u out >actual &&
     ++		cat >expect <<-EOF &&
     ++		(detached at $short) rebase (abort): returning to $returned_to
     ++		(detached at $short) rebase (pick): B
     ++		(detached at $short) rebase (start): checkout @^
     ++		EOF
     ++		git log -g -3 --format="(%gb) %gs" >actual &&
      +		test_cmp expect actual
      +	)
      +'
     @@ t/t1414-reflog-walk.sh: test_expect_success 'walk prefers reflog to ref tip' '
      +test_expect_success '%gb follows a renamed branch' '
      +	(
      +		cd branches &&
     ++		git switch topic &&
      +		test_commit before-rename &&
      +		git branch -m topic renamed &&
      +		test_commit after-rename &&
     @@ t/t1414-reflog-walk.sh: test_expect_success 'walk prefers reflog to ref tip' '
      +		test_cmp expect actual
      +	)
      +'
     ++
     ++test_expect_success '%gb labels branches and detached HEADs' '
     ++	test_create_repo origin &&
     ++	(
     ++		cd origin &&
     ++		test_commit O1 &&
     ++		test_commit O2
     ++	) &&
     ++	git clone origin downstream &&
     ++	(
     ++		cd origin &&
     ++		test_commit O3
     ++	) &&
     ++	(
     ++		cd downstream &&
     ++		test_commit L1 &&
     ++		git branch side &&
     ++		test_commit L2 &&
     ++		git pull -r "file://$TRASH_DIRECTORY/origin" &&
     ++		test_commit L3 &&
     ++		GIT_REFLOG_ACTION="sync switch" git rebase -i FETCH_HEAD side^0 &&
     ++		H1=$(git rev-parse --short HEAD) &&
     ++		test_commit "checkout main" L4.t L4 L4 &&
     ++		git rebase FETCH_HEAD side &&
     ++		test_commit L5 &&
     ++		git rebase origin/main origin/main &&
     ++		H2=$(git rev-parse --short HEAD) &&
     ++		test_commit L6 &&
     ++		git rebase main refs/heads/main &&
     ++		H3=$(git rev-parse --short HEAD) &&
     ++		test_commit L7 &&
     ++		git switch side &&
     ++		test_commit L8 &&
     ++		git checkout origin/main &&
     ++		H4=$(git rev-parse --short HEAD) &&
     ++		test_commit L9 &&
     ++
     ++		cat >expect <<-EOF &&
     ++		commit: L9 (detached at $H4)
     ++		checkout: moving from side to origin/main (detached at $H4)
     ++		commit: L8 (side)
     ++		checkout: moving from $(git rev-parse L7) to side (side)
     ++		commit: L7 (detached at $H3)
     ++		rebase: checkout refs/heads/main (detached at $H3)
     ++		commit: L6 (detached at $H2)
     ++		rebase: checkout origin/main (detached at $H2)
     ++		commit: L5 (side)
     ++		rebase (finish): returning to refs/heads/side (side)
     ++		rebase (pick): L1 (side)
     ++		rebase (start): checkout FETCH_HEAD (side)
     ++		commit: checkout main (detached at $H1)
     ++		sync switch (pick): L1 (detached at $H1)
     ++		sync switch (start): checkout FETCH_HEAD (detached at $H1)
     ++		commit: L3 (main)
     ++		pull -r file://$TRASH_DIRECTORY/origin (finish): returning to refs/heads/main (main)
     ++		pull -r file://$TRASH_DIRECTORY/origin (pick): L2 (main)
     ++		pull -r file://$TRASH_DIRECTORY/origin (pick): L1 (main)
     ++		pull -r file://$TRASH_DIRECTORY/origin (start): checkout $(git rev-parse FETCH_HEAD) (main)
     ++		commit: L2 (main)
     ++		commit: L1 (main)
     ++		clone: from $(cd ../origin && pwd) (main)
     ++		EOF
     ++
     ++		git log -g --format="%gs (%gb)" >actual &&
     ++		test_cmp expect actual
     ++	)
     ++'
      +
       test_expect_success 'rev-list -g complains when there are no reflogs' '
       	test_must_fail git rev-list -g

-- 
gitgitgadget
