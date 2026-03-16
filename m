Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83903B7B83
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680380; cv=none; b=JcSUkR55wLofcmTRLlcVJaEP8n4tIePgiqy11TDEKYktXyEl+7xvJHrYbBDkFngcxnjxIhX1tTZqxUbPLQvR+I3Qg6kCpKeFbwAg9B80AVAN4iOGDk4XJP7CYR2BaByyANC1TOWwkwJHY6xIkTTCRh8gVgITZ1K6J50AxGvcJVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680380; c=relaxed/simple;
	bh=BHIFjW0yEpDlcsguPir7uEOJRESLB+sUBbtzdsG5BE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hz4+te+zktam77r9HRoTAVpURtWvB22ENKsGdX6x34e6AzZAlvZAegzmmZM8uCHKkJJj7He7Szl+PpbH5iJl4kqjeucABZNBIYbIkLPYQ3Mo6MwLs8p5ZRd+qfpciVhGZXwhQ5NQcIBWKzs0WN5uxA8/x1+qkxyrCuJ2VUxZUPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IG/k8jxl; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IG/k8jxl"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439b9b190easo3410492f8f.2
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 09:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773680377; x=1774285177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IZjoC8aEFEuV6PQPnQ5Ay6iZMF8mBZYwuaPO5/NxCVw=;
        b=IG/k8jxlxwRipc1iSgZSVzCUqvam5y78T5ZH5TrVeIpYm1WBdjgTN9kATdxa7dZUoH
         aAdTL+BV/EnNzLKvxyBaMIdwyWmPW2lZCy2mWORtNQ0de20S8h7UoHFGRFzcjW2qrOhU
         cF6TuLHq4OaD/Y27+TEcNY/DCiSOw61DmvScpOJhorpMgg37IpguarqpKSQHQ1R82ujR
         bTBTmiDnL3E6DxSx9K2pRZQv7J/+5hQZKHNQ3fhUWCd+y3UVMPxCboDPH+rf6mT5eyAe
         klV5O0UhJnpMiK61Vfhy8Y1BEkGMgkd6HfTaPzkjYGSkDXz46TeMJ9y5v85Jx9DaBVMF
         D0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773680377; x=1774285177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZjoC8aEFEuV6PQPnQ5Ay6iZMF8mBZYwuaPO5/NxCVw=;
        b=gc1pMkPI8+DopGZL8GG/zFHboKSRkGYIY9u1F9hyThmqbnkLhMtrfICTKWl6cv3tGV
         4JGo8fj1wWcKr8xt96D8Q9cMHZlhR8Q4lbq1tP5SQFE5tkLFLQnzl6bk8pBbrOwyL6I8
         DoOAr1322hyS5jP6noGecPcpIJt6ZgeOGjSFmss3lbLbz0GHLp96zvcUBQuftvcCFX2L
         cgFmys35Sj5X1ubczf1hbBlrMy9Tmqg2YfBLYTe1jy0Ry3vTQ7IY8v9MNkDwGK9Ejzww
         5rASrNtxiuz24h+pSYviLCwUWPac10otQl1QJidRn/iqFpcnChgZZ4mDxpYw78qydy+Z
         dlVg==
X-Forwarded-Encrypted: i=1; AJvYcCXPHlgHIbV1jJAyoB/a6lvvN1ovI6LQ+rlSVYkX60G23eJLEnNE90jEyk7x8nRHqvtzgBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyla1p51pTd/SVUsTPFDfIxqTAfldABeVkq5XwM1p+/dSA61YGW
	t312Os7c9zGUMlLhAootwr6hQ9hI4dG2TJYcUj92l3gVmazd+6UeTvxR
X-Gm-Gg: ATEYQzw/G6OQYuLhyeevC1YKtQu/fbHiK5bQKZlZisrwFxPrEQG3wvwoaVQAqLDXZl3
	JapZxZxSGv6Nye5ypnROF9jDLlnsRdGebeGUDo4w59poNMMTLoRt6kbfiKzAA6/mTAWuutiXYdv
	7nYasBQJA4lzNH14LcI7m3hkT3fBO4FWITGXI8Mh07vvDq7w2EIk92qQYbScGklbGb2d7qvG3hs
	V87aGIzkTXUZfW5Lb+xT0N5nYV9ynjEzzMyCwZ0AMuCvYIjDQs4JA+4LdZ2y4VleUm3Ug10w3gz
	1Kq78bHW463Sax7/xT13lPytyEXwLYceW9q9ql15ImCPxDX3a4Bm5oQjWsMCw39kplaNcRtqqeS
	NVJax7VzlBekWbP2NhPXLawnkV1zHCIbjTNVYQz4ReR2V1olHUUDmlinifMSIIP2uu1zV9IOpk4
	JH3fcELxWwr71jHcYPN0bZMta5eLsM+nYni6UFX680vsa3YIEoICY7p1kDHnHT9Ewiuroj/d74K
	jV18g==
X-Received: by 2002:a05:6000:40df:b0:43b:4469:d106 with SMTP id ffacd0b85a97d-43b4469d11emr7381737f8f.40.1773680376871;
        Mon, 16 Mar 2026 09:59:36 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1affe9sm45341223f8f.15.2026.03.16.09.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 09:59:36 -0700 (PDT)
Message-ID: <375b7285-9840-4704-9e3e-c83793e890d6@gmail.com>
Date: Mon, 16 Mar 2026 16:59:35 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/2] replay: add --revert mode to reverse commit
 changes
To: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, ps@pks.im, newren@gmail.com,
 gitster@pobox.com, karthik.188@gmail.com, johannes.schindelin@gmx.de,
 toon@iotcl.com
References: <20260218234215.89326-1-siddharthasthana31@gmail.com>
 <20260313054035.26605-1-siddharthasthana31@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260313054035.26605-1-siddharthasthana31@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/03/2026 05:40, Siddharth Asthana wrote:
> 
> Changes in v4:
> - Replaced sequencer_format_revert_header() with a more complete
>    sequencer_format_revert_message() that handles everything: subject
>    prefix, commit reference via refer_to_commit(), and merge-parent
>    references -- per Phillip
> - Updated refer_to_commit() signature to take (struct repository *r,
>    bool use_commit_reference) instead of (struct replay_opts *opts)
> - Reverts are now newest-first (revs.reverse = 0 for --revert),
>    chaining on last_commit rather than the parent mapping
> - Changed doc example to cross-branch scenario and restored the
>    merge-tree NOTE
> - Updated error message format to "'--revert' cannot be used with
>    multiple revision ranges..." (and same for --advance)
> - Empty revert commits are now dropped, consistent with cherry-pick

This looks good to me. I've left a couple of nitpicking comments but 
they're mainly for future reference - I'd be happy to see this merged as is.

Thanks

Phillip

> - Link to v3: https://public-inbox.org/git/20260218234215.89326-1-siddharthasthana31@gmail.com/
> - Link to v2: https://public-inbox.org/git/20251202201611.22137-1-siddharthasthana31@gmail.com/
> - Link to v1: https://public-inbox.org/git/20251125170056.34489-1-siddharthasthana31@gmail.com/
> 
> Thanks,
> Siddharth
> 
> ---
> Siddharth Asthana (2):
>    sequencer: extract revert message formatting into shared function
>    replay: add --revert mode to reverse commit changes
> 
>   Documentation/git-replay.adoc |  43 ++++++++-
>   builtin/replay.c              |  46 ++++++----
>   replay.c                      | 165 ++++++++++++++++++++++++----------
>   replay.h                      |  11 ++-
>   sequencer.c                   |  78 +++++++++-------
>   sequencer.h                   |  14 +++
>   t/t3650-replay-basics.sh      | 114 +++++++++++++++++++++--
>   7 files changed, 364 insertions(+), 107 deletions(-)
> 
> Range-diff versus v3:
> 
> 1:  9d686bcdfe ! 1:  bdc710b265 sequencer: extract revert message formatting into shared function
>      @@ Commit message
>           sequencer: extract revert message formatting into shared function
>       
>           The logic for formatting revert commit messages (handling "Revert" and
>      -    "Reapply" cases) is currently duplicated between sequencer.c and will be
>      -    needed by builtin/replay.c.
>      +    "Reapply" cases, appending "This reverts commit <ref>.", and handling
>      +    merge-parent references) currently lives inline in do_pick_commit().
>      +    The upcoming replay --revert mode needs to reuse this logic.
>       
>      -    Extract this logic into a new sequencer_format_revert_header() function
>      -    that can be shared. The function handles both regular reverts ("Revert
>      -    "<subject>"") and revert-of-revert cases ("Reapply "<subject>"").
>      -    When an oid is provided, the function appends the full commit hash and
>      -    period; otherwise the caller should append the commit reference.
>      +    Extract all of this into a new sequencer_format_revert_message()
>      +    function. The function takes a repository, the subject line, commit,
>      +    parent, a use_commit_reference flag, and the output strbuf. It handles
>      +    both regular reverts ("Revert "<subject>"") and revert-of-revert cases
>      +    ("Reapply "<subject>""), and uses refer_to_commit() internally to
>      +    format the commit reference.
>       
>      -    Update do_pick_commit() to use the new helper, eliminating code
>      -    duplication while preserving the special handling for commit_use_reference.
>      +    Update refer_to_commit() to take a struct repository parameter instead
>      +    of relying on the_repository, and a bool instead of reading from
>      +    replay_opts directly. This makes it usable from the new shared function
>      +    without pulling in sequencer-specific state.
>       
>           Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
>       
>        ## sequencer.c ##
>      +@@ sequencer.c: static int should_edit(struct replay_opts *opts) {
>      + 	return opts->edit;
>      + }
>      +
>      +-static void refer_to_commit(struct replay_opts *opts,
>      +-			    struct strbuf *msgbuf, struct commit *commit)
>      ++static void refer_to_commit(struct repository *r, struct strbuf *msgbuf,
>      ++			    const struct commit *commit,
>      ++			    bool use_commit_reference)
>      + {
>      +-	if (opts->commit_use_reference) {
>      ++	if (use_commit_reference) {
>      + 		struct pretty_print_context ctx = {
>      + 			.abbrev = DEFAULT_ABBREV,
>      + 			.date_mode.type = DATE_SHORT,
>      + 		};
>      +-		repo_format_commit_message(the_repository, commit,
>      ++		repo_format_commit_message(r, commit,
>      + 					   "%h (%s, %ad)", msgbuf, &ctx);
>      + 	} else {
>      + 		strbuf_addstr(msgbuf, oid_to_hex(&commit->object.oid));
>       @@ sequencer.c: static int do_pick_commit(struct repository *r,
>        	 */
>        
>      @@ sequencer.c: static int do_pick_commit(struct repository *r,
>        		base = commit;
>        		base_label = msg.label;
>        		next = parent;
>      -@@ sequencer.c: static int do_pick_commit(struct repository *r,
>      - 		if (opts->commit_use_reference) {
>      - 			strbuf_commented_addf(&ctx->message, comment_line_str,
>      - 				"*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
>      + 		next_label = msg.parent_label;
>      +-		if (opts->commit_use_reference) {
>      +-			strbuf_commented_addf(&ctx->message, comment_line_str,
>      +-				"*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
>       -		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject) &&
>       -			   /*
>       -			    * We don't touch pre-existing repeated reverts, because
>      @@ sequencer.c: static int do_pick_commit(struct repository *r,
>       -			strbuf_addstr(&ctx->message, "Reapply \"");
>       -			strbuf_addstr(&ctx->message, orig_subject);
>       -			strbuf_addstr(&ctx->message, "\n");
>      -+			strbuf_addstr(&ctx->message, "\nThis reverts commit ");
>      - 		} else {
>      +-		} else {
>       -			strbuf_addstr(&ctx->message, "Revert \"");
>       -			strbuf_addstr(&ctx->message, msg.subject);
>       -			strbuf_addstr(&ctx->message, "\"\n");
>      -+			sequencer_format_revert_header(&ctx->message, msg.subject, NULL);
>      - 		}
>      +-		}
>       -		strbuf_addstr(&ctx->message, "\nThis reverts commit ");
>      - 		refer_to_commit(opts, &ctx->message, commit);
>      +-		refer_to_commit(opts, &ctx->message, commit);
>      +-
>      +-		if (commit->parents && commit->parents->next) {
>      +-			strbuf_addstr(&ctx->message, ", reversing\nchanges made to ");
>      +-			refer_to_commit(opts, &ctx->message, parent);
>      +-		}
>      +-		strbuf_addstr(&ctx->message, ".\n");
>      ++		sequencer_format_revert_message(r, msg.subject, commit,
>      ++						parent,
>      ++						opts->commit_use_reference,
>      ++						&ctx->message);
>      + 	} else {
>      + 		const char *p;
>        
>      - 		if (commit->parents && commit->parents->next) {
>       @@ sequencer.c: int sequencer_pick_revisions(struct repository *r,
>        	return res;
>        }
>        
>      -+void sequencer_format_revert_header(struct strbuf *out,
>      -+				    const char *orig_subject,
>      -+				    const struct object_id *oid)
>      ++void sequencer_format_revert_message(struct repository *r,
>      ++				     const char *subject,
>      ++				     const struct commit *commit,
>      ++				     const struct commit *parent,
>      ++				     bool use_commit_reference,
>      ++				     struct strbuf *message)
>       +{
>      -+	const char *revert_subject;
>      ++	const char *orig_subject;
>       +
>      -+	if (skip_prefix(orig_subject, "Revert \"", &revert_subject) &&
>      -+	    /*
>      -+	     * We don't touch pre-existing repeated reverts, because
>      -+	     * theoretically these can be nested arbitrarily deeply,
>      -+	     * thus requiring excessive complexity to deal with.
>      -+	     */
>      -+	    !starts_with(revert_subject, "Revert \"")) {
>      -+		strbuf_addstr(out, "Reapply \"");
>      -+		strbuf_addstr(out, revert_subject);
>      -+		strbuf_addch(out, '\n');
>      ++	if (use_commit_reference) {
>      ++		strbuf_commented_addf(message, comment_line_str,
>      ++				      "*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
>      ++	} else if (skip_prefix(subject, "Revert \"", &orig_subject) &&
>      ++		   /*
>      ++		    * We don't touch pre-existing repeated reverts, because
>      ++		    * theoretically these can be nested arbitrarily deeply,
>      ++		    * thus requiring excessive complexity to deal with.
>      ++		    */
>      ++		   !starts_with(orig_subject, "Revert \"")) {
>      ++		strbuf_addstr(message, "Reapply \"");
>      ++		strbuf_addstr(message, orig_subject);
>      ++		strbuf_addstr(message, "\n");
>       +	} else {
>      -+		strbuf_addstr(out, "Revert \"");
>      -+		strbuf_addstr(out, orig_subject);
>      -+		strbuf_addstr(out, "\"\n");
>      ++		strbuf_addstr(message, "Revert \"");
>      ++		strbuf_addstr(message, subject);
>      ++		strbuf_addstr(message, "\"\n");
>       +	}
>      ++	strbuf_addstr(message, "\nThis reverts commit ");
>      ++	refer_to_commit(r, message, commit, use_commit_reference);
>       +
>      -+	strbuf_addstr(out, "\nThis reverts commit ");
>      -+	if (oid) {
>      -+		strbuf_addstr(out, oid_to_hex(oid));
>      -+		strbuf_addstr(out, ".\n");
>      ++	if (commit->parents && commit->parents->next) {
>      ++		strbuf_addstr(message, ", reversing\nchanges made to ");
>      ++		refer_to_commit(r, message, parent, use_commit_reference);
>       +	}
>      ++	strbuf_addstr(message, ".\n");
>       +}
>       +
>        void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
>      @@ sequencer.h: int sequencer_determine_whence(struct repository *r, enum commit_wh
>        int sequencer_get_update_refs_state(const char *wt_dir, struct string_list *refs);
>        
>       +/*
>      -+ * Formats a revert commit message following standard Git conventions.
>      -+ * Handles both regular reverts ("Revert \"<subject>\"") and revert of revert
>      -+ * cases ("Reapply \"<subject>\""). Adds "This reverts commit <oid>." if oid
>      -+ * is provided, otherwise just adds "This reverts commit " and the caller
>      -+ * should append the commit reference.
>      ++ * Formats a complete revert commit message following standard Git conventions.
>      ++ * Handles regular reverts ("Revert \"<subject>\""), revert of revert cases
>      ++ * ("Reapply \"<subject>\""), and the --reference style. Appends "This reverts
>      ++ * commit <ref>." using either the abbreviated or full commit reference
>      ++ * depending on use_commit_reference. Also handles merge-parent references.
>       + */
>      -+void sequencer_format_revert_header(struct strbuf *out,
>      -+				    const char *orig_subject,
>      -+				    const struct object_id *oid);
>      ++void sequencer_format_revert_message(struct repository *r,
>      ++				     const char *subject,
>      ++				     const struct commit *commit,
>      ++				     const struct commit *parent,
>      ++				     bool use_commit_reference,
>      ++				     struct strbuf *message);
>       +
>        #endif /* SEQUENCER_H */
> 2:  066269706e ! 2:  bea6229575 replay: add --revert mode to reverse commit changes
>      @@ Commit message
>           We swap the base and pickme trees passed to merge_incore_nonrecursive()
>           to reverse the diff direction.
>       
>      +    Reverts are processed newest-first (matching git revert behavior) to
>      +    reduce conflicts by peeling off changes from the top. Each revert
>      +    builds on the result of the previous one via the last_commit fallback
>      +    in the main replay loop, rather than relying on the parent-mapping
>      +    used for cherry-pick.
>      +
>           Revert commit messages follow the usual git revert conventions: prefixed
>           with "Revert" (or "Reapply" when reverting a revert), and including
>           "This reverts commit <hash>.". The author is set to the current user
>      @@ Commit message
>           Helped-by: Phillip Wood <phillip.wood123@gmail.com>
>           Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>           Helped-by: Junio C Hamano <gitster@pobox.com>
>      +    Helped-by: Toon Claes <toon@iotcl.com>
>           Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
>       
>        ## Documentation/git-replay.adoc ##
>      @@ Documentation/git-replay.adoc: all commits they have since `base`, playing them
>       +To revert commits on a branch:
>       +
>       +------------
>      -+$ git replay --revert main main~2..main
>      ++$ git replay --revert main topic~2..topic
>       +------------
>       +
>      -+This reverts the last two commits on `main`, creating two revert commits
>      -+on top of `main`, and updates `main` to point at the result.
>      ++This reverts the last two commits from `topic`, creating revert commits on
>      ++top of `main`, and updates `main` to point at the result. This is useful when
>      ++commits from `topic` were previously merged or cherry-picked into `main` and
>      ++need to be undone.
>      ++
>      ++NOTE: For reverting an entire merge request as a single commit (rather than
>      ++commit-by-commit), consider using `git merge-tree --merge-base $TIP HEAD $BASE`
>      ++which can avoid unnecessary merge conflicts.
>       +
>        GIT
>        ---
>      @@ builtin/replay.c: int cmd_replay(int argc,
>        
>        	/* Parse ref action mode from command line or config */
>        	ref_mode = get_ref_action_mode(repo, ref_action);
>      +@@ builtin/replay.c: int cmd_replay(int argc,
>      + 	 * some options changing these values if we think they could
>      + 	 * be useful.
>      + 	 */
>      +-	revs.reverse = 1;
>      ++	/*
>      ++	 * Cherry-pick/rebase need oldest-first ordering so that each
>      ++	 * replayed commit can build on its already-replayed parent.
>      ++	 * Revert needs newest-first ordering (like git revert) to
>      ++	 * reduce conflicts by peeling off changes from the top.
>      ++	 */
>      ++	revs.reverse = opts.revert ? 0 : 1;
>      + 	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
>      + 	revs.topo_order = 1;
>      + 	revs.simplify_history = 0;
>      +@@ builtin/replay.c: int cmd_replay(int argc,
>      + 	 * Detect and warn if we override some user specified rev
>      + 	 * walking options.
>      + 	 */
>      +-	if (revs.reverse != 1) {
>      +-		warning(_("some rev walking options will be overridden as "
>      +-			  "'%s' bit in 'struct rev_info' will be forced"),
>      +-			"reverse");
>      +-		revs.reverse = 1;
>      ++	{
>      ++		int desired_reverse = opts.revert ? 0 : 1;
>      ++		if (revs.reverse != desired_reverse) {
>      ++			warning(_("some rev walking options will be overridden as "
>      ++				  "'%s' bit in 'struct rev_info' will be forced"),
>      ++				"reverse");
>      ++			revs.reverse = desired_reverse;
>      ++		}
>      + 	}
>      + 	if (revs.sort_order != REV_SORT_IN_GRAPH_ORDER) {
>      + 		warning(_("some rev walking options will be overridden as "
>       @@ builtin/replay.c: int cmd_replay(int argc,
>        		goto cleanup;
>        
>      @@ replay.c
>        #include "strmap.h"
>        #include "tree.h"
>        
>      +-/*
>      +- * We technically need USE_THE_REPOSITORY_VARIABLE for DEFAULT_ABBREV, but
>      +- * do not want to use the_repository.
>      +- */
>      +-#define the_repository DO_NOT_USE_THE_REPOSITORY
>       +enum replay_mode {
>       +	REPLAY_MODE_PICK,
>       +	REPLAY_MODE_REVERT,
>       +};
>      -+
>      +
>        static const char *short_commit_name(struct repository *repo,
>        				     struct commit *commit)
>      - {
>       @@ replay.c: static char *get_author(const char *message)
>        	return NULL;
>        }
>      @@ replay.c: static char *get_author(const char *message)
>       +	subject_len = find_commit_subject(message, &subject_start);
>       +	subject = xmemdupz(subject_start, subject_len);
>       +
>      -+	sequencer_format_revert_header(msg, subject, &commit->object.oid);
>      ++	sequencer_format_revert_message(repo, subject, commit,
>      ++					commit->parents ? commit->parents->item : NULL,
>      ++					false, msg);
>       +
>       +	free(subject);
>       +	repo_unuse_commit_buffer(repo, commit, message);
>      @@ replay.c: static void get_ref_information(struct repository *repo,
>       +	}
>       +	*onto = peel_committish(repo, *branch_name, option_name);
>       +	if (rinfo->positive_refexprs > 1)
>      -+		die(_("cannot %s target with multiple sources because ordering would be ill-defined"),
>      -+		    option_name + 2); /* skip "--" prefix */
>      ++		die(_("'%s' cannot be used with multiple revision ranges "
>      ++		      "because the ordering would be ill-defined"),
>      ++		    option_name);
>       +}
>       +
>        static void set_up_replay_mode(struct repository *repo,
>      @@ replay.c: static struct commit *pick_regular_commit(struct repository *repo,
>       +	merge_opt->branch2 = NULL;
>        	if (!result->clean)
>        		return NULL;
>      --	/* Drop commits that become empty */
>      --	if (oideq(&replayed_base_tree->object.oid, &result->tree->object.oid) &&
>      -+	/* Drop commits that become empty (only for picks) */
>      -+	if (mode == REPLAY_MODE_PICK &&
>      -+	    oideq(&replayed_base_tree->object.oid, &result->tree->object.oid) &&
>      + 	/* Drop commits that become empty */
>      + 	if (oideq(&replayed_base_tree->object.oid, &result->tree->object.oid) &&
>        	    !oideq(&pickme_tree->object.oid, &base_tree->object.oid))
>        		return replayed_base;
>       -	return create_commit(repo, result->tree, pickme, replayed_base);
>      @@ replay.c: int replay_revisions(struct rev_info *revs,
>        
>        		last_commit = pick_regular_commit(revs->repo, commit, replayed_commits,
>       -						  onto, &merge_opt, &result);
>      -+						  onto, &merge_opt, &result, mode);
>      ++						  mode == REPLAY_MODE_REVERT ? last_commit : onto,
>      ++						  &merge_opt, &result, mode);
>        		if (!last_commit)
>        			break;
>        
>      @@ t/t3650-replay-basics.sh: test_expect_success 'no base or negative ref gives no-
>        	test_must_fail git replay --advance=main --contained \
>        		topic1..topic2 2>actual &&
>        	test_cmp expect actual
>      + '
>      +
>      + test_expect_success 'cannot advance target ... ordering would be ill-defined' '
>      +-	echo "fatal: cannot advance target with multiple sources because ordering would be ill-defined" >expect &&
>      ++	cat >expect <<-\EOF &&
>      ++	fatal: '"'"'--advance'"'"' cannot be used with multiple revision ranges because the ordering would be ill-defined
>      ++	EOF
>      + 	test_must_fail git replay --advance=main main topic1 topic2 2>actual &&
>      + 	test_cmp expect actual
>      + '
>       @@ t/t3650-replay-basics.sh: test_expect_success 'invalid replay.refAction value' '
>        	test_grep "invalid.*replay.refAction.*value" error
>        '
>      @@ t/t3650-replay-basics.sh: test_expect_success 'invalid replay.refAction value' '
>       +'
>       +
>       +test_expect_success 'cannot revert with multiple sources' '
>      -+	echo "fatal: cannot revert target with multiple sources because ordering would be ill-defined" >expect &&
>      ++	cat >expect <<-\EOF &&
>      ++	fatal: '"'"'--revert'"'"' cannot be used with multiple revision ranges because the ordering would be ill-defined
>      ++	EOF
>       +	test_must_fail git replay --revert main main topic1 topic2 2>actual &&
>       +	test_cmp expect actual
>       +'
>      @@ t/t3650-replay-basics.sh: test_expect_success 'invalid replay.refAction value' '
>       +	# Revert commits I and J
>       +	git replay --revert topic4 topic4~2..topic4 &&
>       +
>      -+	# Verify the revert commits were created
>      ++	# Verify the revert commits were created (newest-first ordering
>      ++	# means J is reverted first, then I on top)
>       +	git log --format=%s -4 topic4 >actual &&
>       +	cat >expect <<-\EOF &&
>      -+	Revert "J"
>       +	Revert "I"
>      ++	Revert "J"
>       +	J
>       +	I
>       +	EOF
>       +	test_cmp expect actual &&
>       +
>      -+	# Verify commit message format includes hash
>      ++	# Verify commit message format includes hash (tip is Revert "I")
>       +	test_commit_message topic4 <<-EOF &&
>      -+	Revert "J"
>      ++	Revert "I"
>       +
>      -+	This reverts commit $(git rev-parse J).
>      ++	This reverts commit $(git rev-parse I).
>       +	EOF
>       +
>       +	# Verify reflog message
> 
> 
> base-commit: d181b9354cf85b44455ce3ca9e6af0b9559e0ae2
> 
> 

