Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C52245008
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 05:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773380444; cv=none; b=oD7N6jDkd+CSWBrFc9NkQuwcMmiaoWPrNPhG9M3AFJAa0AaTwK92gKRS+uCsKUXzq5JqRCzofBGsHp913tZUt8RUz4XV0eqRzORjwMR9r/0B2fJyphcdo0A1eaB1pCHEzqztzPWKVxlv2Bivp4du/ftyQRO/sNJhraNEG0KuPN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773380444; c=relaxed/simple;
	bh=6GCvwYVofBdti8cUrb+cKe7xFr0qubMjAgJP0Gl67qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVyINPtIw0K1hRzEEKGqF7gEGvV+WkAR0Cgustx8jc6fwy32xSbUBgdawjFPhc3+8HzoFM59kjjpTTCTS/q6g5QvKtW8Kh8AlCsDFA0pRtaCo6CEOrxOBtnQ6CDMV09Cu1uSlzpU+Jix1KCjijaUl0U8inIQJ+VIIF4noKnNwlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3s2jkwi; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3s2jkwi"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ae3a2f6007so12763555ad.2
        for <git@vger.kernel.org>; Thu, 12 Mar 2026 22:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773380441; x=1773985241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsRFHvoHoItBcVqlEDsgCMkIJY/5emikRnhPgpMBIfQ=;
        b=O3s2jkwiuyi0omuoqpu0ePiSbo66g1s0BKi5rz/VTEEAByXnUxaqQKhPTrKnf+Qobg
         xaY0ExCv3TZNwXqjcGsjVuUQ4qxcCDyGrP726YAdiW/ze2FwBAnHGSreY+YC0CAfF8Nm
         jYMyLL258gdmmKUUs/zq8oq600GqPOnRTtIwRyTErrDGdcnlJMkJTj5zl4Nbu1tcItWN
         8GL1QoNc9rje4zOw+P+KOY1FPgB8+22vMyPODxbQ5ZRqEljJuyFvKJ93ysQa6GkO+DNo
         rbHghWWYI1jPsu6sBVMGYMVIbWhOkojhXvOTs16m/X7NenPrmLu4YSP7QkzsyOQSesYR
         clwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773380441; x=1773985241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HsRFHvoHoItBcVqlEDsgCMkIJY/5emikRnhPgpMBIfQ=;
        b=iW67AXKOPPT460UcT0DEe8NLnHY5/wZ8r1gGRHDer7LtpeCfIR0LKeuXW40qSv22gs
         mvBlq48Czr3p6qli9kBPLPksRiTzAdYRzAojBnKjhiOYbQ4WGvrL0i7Liuk7sT/jTICa
         2DykQGWfHQrd2tt4YL5x0ssFroHRJPbP4tHp5tviHscNjEBmynjUwnDEzluPeyVVonxp
         PTvc0wgw857nilouiKiaisgqLBL5FxxUhnefFNM4M9vy5LcJVkyt5bZkoPTp6Sljs/y9
         Nez1e7OZDCmjXbW8y9aAgntQJX3puAz3Vl9H7EknnwDLyjXWOkG/RI3uGeIdYMprfvD7
         h8Cg==
X-Gm-Message-State: AOJu0YyD0g/1t3k29xmhT9wsNslycLdIu3Ac16qDRCImIXDNvXV4o1dX
	e2SPO3by9r42YY9sC3dSMWxxHLZjFwWgOvsPQt8kvFB8BpivSz0GxNerbX1ngXOn
X-Gm-Gg: ATEYQzwuWLMSWQglPSkrEqM6RCMqb1vwZKXmkc02snKMY6fWFSG+sDSDs8YVoJ4NA5X
	iG122jWo42DCAzaKQ24ahi++eNInGSf30E3LhcGA/BejVSu2mD11fpttr5bEwaJqzLTs0QcXZa9
	3vp5dANEpW797XjV5tyPRtYT0XMFie+nSs0Y50srWyLQAJAJ7QXvFDXxFP+W3mojWeGC+Y/rqvV
	fNOCxV0phsqQqO5sxRzoI8j9Nb5NwZDL0PJ5g7m4fccA0BQmXwNQyajSVc3R21ORHDDBnj1Lx1W
	QGhW5A3W3Nh7XzolnkdhEzlV+4Bhc2w2vRXDyCh6dd6JVB2lQn5bHectIJG166MvqKGgN9sPtc/
	d2Mg6joXIHguW/DOr9FxIetC+o7mq9n/LdKfdYJ5nLtP9pR+aVLzd2+WhsaxibByaVr25FFVafR
	ZY0opzRjze/RwhsdPu0o0o4/u/Hq9RhTVh1y0cpW8QUpYKmHDw10k6W9GigQ==
X-Received: by 2002:a17:902:e946:b0:2ae:6d9e:ed57 with SMTP id d9443c01a7336-2aecaa2fde9mr21222315ad.21.1773380441006;
        Thu, 12 Mar 2026 22:40:41 -0700 (PDT)
Received: from localhost ([2409:40e3:308b:f961:6950:2a48:4c4a:2156])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece5c1465sm11793705ad.21.2026.03.12.22.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 22:40:40 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	newren@gmail.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com,
	karthik.188@gmail.com,
	johannes.schindelin@gmx.de,
	toon@iotcl.com,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v4 0/2] replay: add --revert mode to reverse commit changes
Date: Fri, 13 Mar 2026 11:10:33 +0530
Message-ID: <20260313054035.26605-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260218234215.89326-1-siddharthasthana31@gmail.com>
References: <20260218234215.89326-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

git replay currently supports cherry-picking (--advance) and rebasing
(--onto), but not reverting. We need this at GitLab for Gitaly to
reverse commits directly on bare repositories without a checkout.

The approach is the same as sequencer.c -- cherry-pick and revert are
just the same three-way merge with swapped arguments. We swap the base
and pickme trees passed to merge_incore_nonrecursive() to reverse the
diff direction.

Patch 1 extracts the full revert message formatting logic into a new
sequencer_format_revert_message() function, following Phillip's
suggestion to move everything into one shared function rather than
just the header. refer_to_commit() is updated to take a struct
repository and a bool instead of replay_opts so it works outside the
sequencer.

Patch 2 adds --revert <branch> as a standalone mode. Reverts are
processed newest-first (matching git revert) to reduce conflicts by
peeling off changes from the top.

The series is based on top of d181b9354c (The 13th batch, 2026-03-07).

CI: https://gitlab.com/gitlab-org/git/-/pipelines/2329880894
The msvc-meson / Chocolatey failures are pre-existing infrastructure
issues unrelated to this series.

Changes in v4:
- Replaced sequencer_format_revert_header() with a more complete
  sequencer_format_revert_message() that handles everything: subject
  prefix, commit reference via refer_to_commit(), and merge-parent
  references -- per Phillip
- Updated refer_to_commit() signature to take (struct repository *r,
  bool use_commit_reference) instead of (struct replay_opts *opts)
- Reverts are now newest-first (revs.reverse = 0 for --revert),
  chaining on last_commit rather than the parent mapping
- Changed doc example to cross-branch scenario and restored the
  merge-tree NOTE
- Updated error message format to "'--revert' cannot be used with
  multiple revision ranges..." (and same for --advance)
- Empty revert commits are now dropped, consistent with cherry-pick
- Link to v3: https://public-inbox.org/git/20260218234215.89326-1-siddharthasthana31@gmail.com/
- Link to v2: https://public-inbox.org/git/20251202201611.22137-1-siddharthasthana31@gmail.com/
- Link to v1: https://public-inbox.org/git/20251125170056.34489-1-siddharthasthana31@gmail.com/

Thanks,
Siddharth

---
Siddharth Asthana (2):
  sequencer: extract revert message formatting into shared function
  replay: add --revert mode to reverse commit changes

 Documentation/git-replay.adoc |  43 ++++++++-
 builtin/replay.c              |  46 ++++++----
 replay.c                      | 165 ++++++++++++++++++++++++----------
 replay.h                      |  11 ++-
 sequencer.c                   |  78 +++++++++-------
 sequencer.h                   |  14 +++
 t/t3650-replay-basics.sh      | 114 +++++++++++++++++++++--
 7 files changed, 364 insertions(+), 107 deletions(-)

Range-diff versus v3:

1:  9d686bcdfe ! 1:  bdc710b265 sequencer: extract revert message formatting into shared function
    @@ Commit message
         sequencer: extract revert message formatting into shared function
     
         The logic for formatting revert commit messages (handling "Revert" and
    -    "Reapply" cases) is currently duplicated between sequencer.c and will be
    -    needed by builtin/replay.c.
    +    "Reapply" cases, appending "This reverts commit <ref>.", and handling
    +    merge-parent references) currently lives inline in do_pick_commit().
    +    The upcoming replay --revert mode needs to reuse this logic.
     
    -    Extract this logic into a new sequencer_format_revert_header() function
    -    that can be shared. The function handles both regular reverts ("Revert
    -    "<subject>"") and revert-of-revert cases ("Reapply "<subject>"").
    -    When an oid is provided, the function appends the full commit hash and
    -    period; otherwise the caller should append the commit reference.
    +    Extract all of this into a new sequencer_format_revert_message()
    +    function. The function takes a repository, the subject line, commit,
    +    parent, a use_commit_reference flag, and the output strbuf. It handles
    +    both regular reverts ("Revert "<subject>"") and revert-of-revert cases
    +    ("Reapply "<subject>""), and uses refer_to_commit() internally to
    +    format the commit reference.
     
    -    Update do_pick_commit() to use the new helper, eliminating code
    -    duplication while preserving the special handling for commit_use_reference.
    +    Update refer_to_commit() to take a struct repository parameter instead
    +    of relying on the_repository, and a bool instead of reading from
    +    replay_opts directly. This makes it usable from the new shared function
    +    without pulling in sequencer-specific state.
     
         Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
     
      ## sequencer.c ##
    +@@ sequencer.c: static int should_edit(struct replay_opts *opts) {
    + 	return opts->edit;
    + }
    + 
    +-static void refer_to_commit(struct replay_opts *opts,
    +-			    struct strbuf *msgbuf, struct commit *commit)
    ++static void refer_to_commit(struct repository *r, struct strbuf *msgbuf,
    ++			    const struct commit *commit,
    ++			    bool use_commit_reference)
    + {
    +-	if (opts->commit_use_reference) {
    ++	if (use_commit_reference) {
    + 		struct pretty_print_context ctx = {
    + 			.abbrev = DEFAULT_ABBREV,
    + 			.date_mode.type = DATE_SHORT,
    + 		};
    +-		repo_format_commit_message(the_repository, commit,
    ++		repo_format_commit_message(r, commit,
    + 					   "%h (%s, %ad)", msgbuf, &ctx);
    + 	} else {
    + 		strbuf_addstr(msgbuf, oid_to_hex(&commit->object.oid));
     @@ sequencer.c: static int do_pick_commit(struct repository *r,
      	 */
      
    @@ sequencer.c: static int do_pick_commit(struct repository *r,
      		base = commit;
      		base_label = msg.label;
      		next = parent;
    -@@ sequencer.c: static int do_pick_commit(struct repository *r,
    - 		if (opts->commit_use_reference) {
    - 			strbuf_commented_addf(&ctx->message, comment_line_str,
    - 				"*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
    + 		next_label = msg.parent_label;
    +-		if (opts->commit_use_reference) {
    +-			strbuf_commented_addf(&ctx->message, comment_line_str,
    +-				"*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
     -		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject) &&
     -			   /*
     -			    * We don't touch pre-existing repeated reverts, because
    @@ sequencer.c: static int do_pick_commit(struct repository *r,
     -			strbuf_addstr(&ctx->message, "Reapply \"");
     -			strbuf_addstr(&ctx->message, orig_subject);
     -			strbuf_addstr(&ctx->message, "\n");
    -+			strbuf_addstr(&ctx->message, "\nThis reverts commit ");
    - 		} else {
    +-		} else {
     -			strbuf_addstr(&ctx->message, "Revert \"");
     -			strbuf_addstr(&ctx->message, msg.subject);
     -			strbuf_addstr(&ctx->message, "\"\n");
    -+			sequencer_format_revert_header(&ctx->message, msg.subject, NULL);
    - 		}
    +-		}
     -		strbuf_addstr(&ctx->message, "\nThis reverts commit ");
    - 		refer_to_commit(opts, &ctx->message, commit);
    +-		refer_to_commit(opts, &ctx->message, commit);
    +-
    +-		if (commit->parents && commit->parents->next) {
    +-			strbuf_addstr(&ctx->message, ", reversing\nchanges made to ");
    +-			refer_to_commit(opts, &ctx->message, parent);
    +-		}
    +-		strbuf_addstr(&ctx->message, ".\n");
    ++		sequencer_format_revert_message(r, msg.subject, commit,
    ++						parent,
    ++						opts->commit_use_reference,
    ++						&ctx->message);
    + 	} else {
    + 		const char *p;
      
    - 		if (commit->parents && commit->parents->next) {
     @@ sequencer.c: int sequencer_pick_revisions(struct repository *r,
      	return res;
      }
      
    -+void sequencer_format_revert_header(struct strbuf *out,
    -+				    const char *orig_subject,
    -+				    const struct object_id *oid)
    ++void sequencer_format_revert_message(struct repository *r,
    ++				     const char *subject,
    ++				     const struct commit *commit,
    ++				     const struct commit *parent,
    ++				     bool use_commit_reference,
    ++				     struct strbuf *message)
     +{
    -+	const char *revert_subject;
    ++	const char *orig_subject;
     +
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
    ++	if (use_commit_reference) {
    ++		strbuf_commented_addf(message, comment_line_str,
    ++				      "*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
    ++	} else if (skip_prefix(subject, "Revert \"", &orig_subject) &&
    ++		   /*
    ++		    * We don't touch pre-existing repeated reverts, because
    ++		    * theoretically these can be nested arbitrarily deeply,
    ++		    * thus requiring excessive complexity to deal with.
    ++		    */
    ++		   !starts_with(orig_subject, "Revert \"")) {
    ++		strbuf_addstr(message, "Reapply \"");
    ++		strbuf_addstr(message, orig_subject);
    ++		strbuf_addstr(message, "\n");
     +	} else {
    -+		strbuf_addstr(out, "Revert \"");
    -+		strbuf_addstr(out, orig_subject);
    -+		strbuf_addstr(out, "\"\n");
    ++		strbuf_addstr(message, "Revert \"");
    ++		strbuf_addstr(message, subject);
    ++		strbuf_addstr(message, "\"\n");
     +	}
    ++	strbuf_addstr(message, "\nThis reverts commit ");
    ++	refer_to_commit(r, message, commit, use_commit_reference);
     +
    -+	strbuf_addstr(out, "\nThis reverts commit ");
    -+	if (oid) {
    -+		strbuf_addstr(out, oid_to_hex(oid));
    -+		strbuf_addstr(out, ".\n");
    ++	if (commit->parents && commit->parents->next) {
    ++		strbuf_addstr(message, ", reversing\nchanges made to ");
    ++		refer_to_commit(r, message, parent, use_commit_reference);
     +	}
    ++	strbuf_addstr(message, ".\n");
     +}
     +
      void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
    @@ sequencer.h: int sequencer_determine_whence(struct repository *r, enum commit_wh
      int sequencer_get_update_refs_state(const char *wt_dir, struct string_list *refs);
      
     +/*
    -+ * Formats a revert commit message following standard Git conventions.
    -+ * Handles both regular reverts ("Revert \"<subject>\"") and revert of revert
    -+ * cases ("Reapply \"<subject>\""). Adds "This reverts commit <oid>." if oid
    -+ * is provided, otherwise just adds "This reverts commit " and the caller
    -+ * should append the commit reference.
    ++ * Formats a complete revert commit message following standard Git conventions.
    ++ * Handles regular reverts ("Revert \"<subject>\""), revert of revert cases
    ++ * ("Reapply \"<subject>\""), and the --reference style. Appends "This reverts
    ++ * commit <ref>." using either the abbreviated or full commit reference
    ++ * depending on use_commit_reference. Also handles merge-parent references.
     + */
    -+void sequencer_format_revert_header(struct strbuf *out,
    -+				    const char *orig_subject,
    -+				    const struct object_id *oid);
    ++void sequencer_format_revert_message(struct repository *r,
    ++				     const char *subject,
    ++				     const struct commit *commit,
    ++				     const struct commit *parent,
    ++				     bool use_commit_reference,
    ++				     struct strbuf *message);
     +
      #endif /* SEQUENCER_H */
2:  066269706e ! 2:  bea6229575 replay: add --revert mode to reverse commit changes
    @@ Commit message
         We swap the base and pickme trees passed to merge_incore_nonrecursive()
         to reverse the diff direction.
     
    +    Reverts are processed newest-first (matching git revert behavior) to
    +    reduce conflicts by peeling off changes from the top. Each revert
    +    builds on the result of the previous one via the last_commit fallback
    +    in the main replay loop, rather than relying on the parent-mapping
    +    used for cherry-pick.
    +
         Revert commit messages follow the usual git revert conventions: prefixed
         with "Revert" (or "Reapply" when reverting a revert), and including
         "This reverts commit <hash>.". The author is set to the current user
    @@ Commit message
         Helped-by: Phillip Wood <phillip.wood123@gmail.com>
         Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
         Helped-by: Junio C Hamano <gitster@pobox.com>
    +    Helped-by: Toon Claes <toon@iotcl.com>
         Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
     
      ## Documentation/git-replay.adoc ##
    @@ Documentation/git-replay.adoc: all commits they have since `base`, playing them
     +To revert commits on a branch:
     +
     +------------
    -+$ git replay --revert main main~2..main
    ++$ git replay --revert main topic~2..topic
     +------------
     +
    -+This reverts the last two commits on `main`, creating two revert commits
    -+on top of `main`, and updates `main` to point at the result.
    ++This reverts the last two commits from `topic`, creating revert commits on
    ++top of `main`, and updates `main` to point at the result. This is useful when
    ++commits from `topic` were previously merged or cherry-picked into `main` and
    ++need to be undone.
    ++
    ++NOTE: For reverting an entire merge request as a single commit (rather than
    ++commit-by-commit), consider using `git merge-tree --merge-base $TIP HEAD $BASE`
    ++which can avoid unnecessary merge conflicts.
     +
      GIT
      ---
    @@ builtin/replay.c: int cmd_replay(int argc,
      
      	/* Parse ref action mode from command line or config */
      	ref_mode = get_ref_action_mode(repo, ref_action);
    +@@ builtin/replay.c: int cmd_replay(int argc,
    + 	 * some options changing these values if we think they could
    + 	 * be useful.
    + 	 */
    +-	revs.reverse = 1;
    ++	/*
    ++	 * Cherry-pick/rebase need oldest-first ordering so that each
    ++	 * replayed commit can build on its already-replayed parent.
    ++	 * Revert needs newest-first ordering (like git revert) to
    ++	 * reduce conflicts by peeling off changes from the top.
    ++	 */
    ++	revs.reverse = opts.revert ? 0 : 1;
    + 	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
    + 	revs.topo_order = 1;
    + 	revs.simplify_history = 0;
    +@@ builtin/replay.c: int cmd_replay(int argc,
    + 	 * Detect and warn if we override some user specified rev
    + 	 * walking options.
    + 	 */
    +-	if (revs.reverse != 1) {
    +-		warning(_("some rev walking options will be overridden as "
    +-			  "'%s' bit in 'struct rev_info' will be forced"),
    +-			"reverse");
    +-		revs.reverse = 1;
    ++	{
    ++		int desired_reverse = opts.revert ? 0 : 1;
    ++		if (revs.reverse != desired_reverse) {
    ++			warning(_("some rev walking options will be overridden as "
    ++				  "'%s' bit in 'struct rev_info' will be forced"),
    ++				"reverse");
    ++			revs.reverse = desired_reverse;
    ++		}
    + 	}
    + 	if (revs.sort_order != REV_SORT_IN_GRAPH_ORDER) {
    + 		warning(_("some rev walking options will be overridden as "
     @@ builtin/replay.c: int cmd_replay(int argc,
      		goto cleanup;
      
    @@ replay.c
      #include "strmap.h"
      #include "tree.h"
      
    +-/*
    +- * We technically need USE_THE_REPOSITORY_VARIABLE for DEFAULT_ABBREV, but
    +- * do not want to use the_repository.
    +- */
    +-#define the_repository DO_NOT_USE_THE_REPOSITORY
     +enum replay_mode {
     +	REPLAY_MODE_PICK,
     +	REPLAY_MODE_REVERT,
     +};
    -+
    + 
      static const char *short_commit_name(struct repository *repo,
      				     struct commit *commit)
    - {
     @@ replay.c: static char *get_author(const char *message)
      	return NULL;
      }
    @@ replay.c: static char *get_author(const char *message)
     +	subject_len = find_commit_subject(message, &subject_start);
     +	subject = xmemdupz(subject_start, subject_len);
     +
    -+	sequencer_format_revert_header(msg, subject, &commit->object.oid);
    ++	sequencer_format_revert_message(repo, subject, commit,
    ++					commit->parents ? commit->parents->item : NULL,
    ++					false, msg);
     +
     +	free(subject);
     +	repo_unuse_commit_buffer(repo, commit, message);
    @@ replay.c: static void get_ref_information(struct repository *repo,
     +	}
     +	*onto = peel_committish(repo, *branch_name, option_name);
     +	if (rinfo->positive_refexprs > 1)
    -+		die(_("cannot %s target with multiple sources because ordering would be ill-defined"),
    -+		    option_name + 2); /* skip "--" prefix */
    ++		die(_("'%s' cannot be used with multiple revision ranges "
    ++		      "because the ordering would be ill-defined"),
    ++		    option_name);
     +}
     +
      static void set_up_replay_mode(struct repository *repo,
    @@ replay.c: static struct commit *pick_regular_commit(struct repository *repo,
     +	merge_opt->branch2 = NULL;
      	if (!result->clean)
      		return NULL;
    --	/* Drop commits that become empty */
    --	if (oideq(&replayed_base_tree->object.oid, &result->tree->object.oid) &&
    -+	/* Drop commits that become empty (only for picks) */
    -+	if (mode == REPLAY_MODE_PICK &&
    -+	    oideq(&replayed_base_tree->object.oid, &result->tree->object.oid) &&
    + 	/* Drop commits that become empty */
    + 	if (oideq(&replayed_base_tree->object.oid, &result->tree->object.oid) &&
      	    !oideq(&pickme_tree->object.oid, &base_tree->object.oid))
      		return replayed_base;
     -	return create_commit(repo, result->tree, pickme, replayed_base);
    @@ replay.c: int replay_revisions(struct rev_info *revs,
      
      		last_commit = pick_regular_commit(revs->repo, commit, replayed_commits,
     -						  onto, &merge_opt, &result);
    -+						  onto, &merge_opt, &result, mode);
    ++						  mode == REPLAY_MODE_REVERT ? last_commit : onto,
    ++						  &merge_opt, &result, mode);
      		if (!last_commit)
      			break;
      
    @@ t/t3650-replay-basics.sh: test_expect_success 'no base or negative ref gives no-
      	test_must_fail git replay --advance=main --contained \
      		topic1..topic2 2>actual &&
      	test_cmp expect actual
    + '
    + 
    + test_expect_success 'cannot advance target ... ordering would be ill-defined' '
    +-	echo "fatal: cannot advance target with multiple sources because ordering would be ill-defined" >expect &&
    ++	cat >expect <<-\EOF &&
    ++	fatal: '"'"'--advance'"'"' cannot be used with multiple revision ranges because the ordering would be ill-defined
    ++	EOF
    + 	test_must_fail git replay --advance=main main topic1 topic2 2>actual &&
    + 	test_cmp expect actual
    + '
     @@ t/t3650-replay-basics.sh: test_expect_success 'invalid replay.refAction value' '
      	test_grep "invalid.*replay.refAction.*value" error
      '
    @@ t/t3650-replay-basics.sh: test_expect_success 'invalid replay.refAction value' '
     +'
     +
     +test_expect_success 'cannot revert with multiple sources' '
    -+	echo "fatal: cannot revert target with multiple sources because ordering would be ill-defined" >expect &&
    ++	cat >expect <<-\EOF &&
    ++	fatal: '"'"'--revert'"'"' cannot be used with multiple revision ranges because the ordering would be ill-defined
    ++	EOF
     +	test_must_fail git replay --revert main main topic1 topic2 2>actual &&
     +	test_cmp expect actual
     +'
    @@ t/t3650-replay-basics.sh: test_expect_success 'invalid replay.refAction value' '
     +	# Revert commits I and J
     +	git replay --revert topic4 topic4~2..topic4 &&
     +
    -+	# Verify the revert commits were created
    ++	# Verify the revert commits were created (newest-first ordering
    ++	# means J is reverted first, then I on top)
     +	git log --format=%s -4 topic4 >actual &&
     +	cat >expect <<-\EOF &&
    -+	Revert "J"
     +	Revert "I"
    ++	Revert "J"
     +	J
     +	I
     +	EOF
     +	test_cmp expect actual &&
     +
    -+	# Verify commit message format includes hash
    ++	# Verify commit message format includes hash (tip is Revert "I")
     +	test_commit_message topic4 <<-EOF &&
    -+	Revert "J"
    ++	Revert "I"
     +
    -+	This reverts commit $(git rev-parse J).
    ++	This reverts commit $(git rev-parse I).
     +	EOF
     +
     +	# Verify reflog message


base-commit: d181b9354cf85b44455ce3ca9e6af0b9559e0ae2

