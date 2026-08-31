Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B223439F71
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788192605; cv=none; b=Sv5cmkWLtlvBZjF1ZCTRplKYfHVWRylWu4CtnLsUU9lw/skxEpHTpo14FTzX5s3M7hCiK/DjEOIdOJAbRiKMsH3lNwQlJMCfz/HLxGWOg6aMLTtPo6ICF4uL4oeS2jST1vMp7NgasKEN+vF4bZnWYXiy4xB0Tl4x/Q3wqFmQ8bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788192605; c=relaxed/simple;
	bh=eA0NFIV0bQuanQ7egtj1tjXn/tzQA3WFbr8NNEotcDQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tqghHkApJSjmTtf8nOvvpotJ7zRatYO+F7k4+w8iDaZqZdSYellbBS+Tbkr6C/jHN70tQVHiOj4RtdQDuRYNA+B4XJBFxucXU09okW4caYD9PpvNjQRKQUIxO5zE3n2fLmwTnvoGCYsYMWB7ivv3TtHUaC77PIoaQbNOqP91cZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kqku2J60; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kqku2J60"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a668cacdadso412065a12.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 09:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788192601; x=1788797401; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zNGVCJx8SntE6kIvjr54Z4eJ2p3GcF5RDsUYlEhPBSk=;
        b=Kqku2J60pOA/iOhjVr09AsEcpnTr05yXp45vgGtH0HAS5JO6Z6sPUcKProZ4oyRJ6a
         ztDb7b2MRDkSB7WdORxxLn42c3L3iN+QeItxwkDPUatz5D4DbmWgJUlZojnK0y7syjD2
         ZjQwSzirHYvCuM+lxQdbOkMuNckZsFX0a1Qs5YmLiz6L4BUMro/HwHANnYn4wlhilMsM
         jxUm/rbPWMJgnpZYOCP+EBuRyuG5ASM75Upxc5ilzskLTXMv8MbOsVRCDHvTmLti9nV6
         a6DRPSx0BMEof8QC+g7BWMoOpokyUZTyvY7JY06QMwRJgLbjA9vollAuq/c6HtiYVLRv
         1hUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788192601; x=1788797401;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zNGVCJx8SntE6kIvjr54Z4eJ2p3GcF5RDsUYlEhPBSk=;
        b=ALHEuQDO58haxAm7UFi8WaITxBO3dbb2EBTsbetsGxtHfDBzd3L7gR6TphqZYoGLkP
         BR7XCvGTG7Ubcp9OPdSji6tNnuymu4xwqniOECF8gpH6obhxc09kZDJRLb6WGyZgwjVG
         TqNwNjztLq9bO9xFxXIxyTHic2wAI/XgLBSQDTZB8nndwJ4IYNcb+CKSUlMmY8EbVrpr
         EPYlZOMY+lXIeE39Y4c745Vb/GD5KWpUXWIYXo3o2svDfdWThFDzgxiTSnQ2BgVA0ish
         +Juff4/uhzdF9i/Mm70yxw9IT107S3akLi44BH3CQdEMjTpCw0BJnyl5RYEA7hS2/gD7
         PZDw==
X-Forwarded-Encrypted: i=1; AHgh+RoKsoPAnNHcS/S9taPXyf/9oaYpXq2+0zBz4lR1e37Dw3gYo8uXNtKRb2EyW+Pfhtd3rtc=@vger.kernel.org
X-Gm-Message-State: AFuF++mHIbvBLHMbfSQvtOnW97bxQBtgfFLSSPXkeIUffRFmRM+G9Mp1
	Prh3ISrMy/QK92rE9JCNTbwI6N/xrrG0E8N3q6CE1RZxqG+Dpg+yH9iiaoym1A==
X-Gm-Gg: AR+sD12hH2QyD02Y3i9eyJjK7bShGLZ/5ZiMRXPu1uCnQI/lMGZ6AX9TClWFQTlAVlw
	rSlAxmcx67BTPg5Sg9sQIZJDLdkt8/W8q48eY7pyZvOMIdjZHDbhpgswpTpzy7RLy7HJl5WNWeR
	7AQal0gRSHuZjQnwA7uHbpChM6wTX4EdWG0Nfl8f4kCLe7S3wolx0YwXUrRifFRU7uX39F7kCMK
	JYot/AaxvFLfb+NwhccZh64YNcvAukK38XfSx8K5+lnGhl42YvGYlCJ9In5TkpqEumTpqmocl3K
	CBI+wePGGHqkLA2WzFaI3YeCXtsRuKzkRmhiGrpuL+jVDKJSTlyarbr7ch+12gmsb9AKwj+f1Fb
	EeVSoQ1iyxxyJSc/uJKkHCbtkpdqC3dVuLpROeYRYI15VSo/dBC22PgpG8O/Lbea7hVeyfzthK2
	BcbqeN+yhJ7Pl5yRdp3Clqvl+BZ7ZpkI0o3U1Dtzm51rwWr0lUZtqjh+rHfv5Vm8uIyyebtGKMY
	zmEkge8bIyANK0=
X-Received: by 2002:a17:906:4fc8:b0:c25:2e93:28a6 with SMTP id a640c23a62f3a-c2556be5796mr1625982766b.3.1788192600780;
        Mon, 31 Aug 2026 09:10:00 -0700 (PDT)
Received: from [192.168.1.193] ([90.251.190.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f1fb94fsm459447766b.51.2026.08.31.09.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 09:10:00 -0700 (PDT)
Message-ID: <511300fe-112d-4f20-bd3f-e401e68c4a27@gmail.com>
Date: Mon, 31 Aug 2026 17:09:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4] sequencer: honor --empty when a fixup!/squash! empties
 its target
Reply-To: phillip.wood@dunelm.org.uk
To: Farid Zakaria <farid.m.zakaria@gmail.com>, git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>
References: <20260709-fz-autosquash-empty-v1-1-84cb494c3613@gmail.com>
 <20260827-fz-autosquash-empty-v4-1-f98ffd575780@gmail.com>
Content-Language: en-US
In-Reply-To: <20260827-fz-autosquash-empty-v4-1-f98ffd575780@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Farid

On 27/08/2026 19:19, Farid Zakaria wrote:
> When "git rebase --autosquash" squashes a "fixup!" or "squash!" commit
> into its target, the result can be a commit that no longer changes
> anything relative to its parent, for example when the squashed change
> reverts the target.  Rather than dropping or keeping that commit, the
> rebase stops with
> 
> 	You asked to amend the most recent commit, but doing so would
> 	make it empty. ...
> 
> and "--empty" has no effect on it.  This makes backing a change out of a
> series awkward: reverting a commit as a "fixup!" and running "git rebase
> --autosquash --empty=drop" ought to remove both the commit and its
> revert, but it halts instead.
> 
> A "fixup" is applied by amending HEAD, so the commit it produces is
> empty when the index matches the tree of HEAD's parent rather than the
> tree of HEAD.  allow_empty() only knows about the latter, so it never
> notices that the fixup cancelled the commit out and "git commit --amend"
> is left to refuse to create the empty commit.
> 
> Check for this case separately and honor "--empty" for it, subject to
> two restrictions.
> 
> First, "--empty" only governs commits that become empty, so a commit
> that was picked empty to begin with must be left alone.  To tell the two
> apart, record in "struct replay_ctx" what the "pick" that created the
> commit at HEAD was, and write it to "$GIT_DIR/rebase-merge/fixup-target"
> so that it survives a stop for conflict resolution.  Only a commit
> created by a "pick" is a candidate: when the todo list has been edited
> so that a chain starts after "reset", "exec" or "break", we do not know
> how the commit at HEAD came to be and keep it.
> 
> Second, only the last fixup of a chain may drop the commit.  Were an
> earlier one to drop it, the fixups still to come would be squashed into
> the previous commit instead, so a commit emptied mid-chain is kept --
> empty for the time being -- and the decision is deferred to the end of
> the chain.
> 
> With "--empty=drop" the emptied commit has already been created by the
> "pick", so drop it by moving HEAD back to its parent and report the new
> PICK_RESULT_DROPPED_HEAD, so that neither that commit nor any of the
> fixups squashed into it is recorded as rewritten and the post-rewrite
> machinery has nothing to report.  A "label" or "update-ref" that follows
> then sees HEAD at the parent.
> 
> A conflicted fixup that the user resolves by undoing the commit it is
> being squashed into leaves the same empty commit behind, so give
> commit_staged_changes() the same treatment.

This all sounds good - lets look at the implementation ...

> Signed-off-by: Farid Zakaria <farid.m.zakaria@gmail.com>
> @@ -2303,6 +2428,20 @@ static enum pick_result do_pick_commit(struct repository *r,
>   	else
>   		reflog_action = sequencer_reflog_action(opts);
>   
> +	/*
> +	 * Remember whether this commit is picked with changes of its own, as
> +	 * only such a commit is dropped when the fixups that follow it empty
> +	 * it out again.
> +	 */
> +	if (is_rebase_i(opts) && command == TODO_PICK) {
> +		int empty = is_original_commit_empty(commit);

So we only support dropping a "pick" that becomes empty, not a "reword"
or "edit". It would be strange to reword or edit a commit that is
destined to be dropped so that makes sense.

> +
> +		if (empty < 0 ||
> +		    set_fixup_target(opts, empty ? FIXUP_TARGET_PICKED_EMPTY :
> +				     FIXUP_TARGET_PICKED_NONEMPTY))
> +			return PICK_RESULT_ERROR;
> +	}
> +
>   	if (opts->no_commit) {
>   		/*
>   		 * We do not intend to commit immediately.  We just want to
> @@ -2540,7 +2679,51 @@ static enum pick_result do_pick_commit(struct repository *r,
>   			_("dropping %s %s -- patch contents already upstream\n"),
>   			oid_to_hex(&commit->object.oid), msg.subject);
>   	} /* else allow == 0 and there's nothing special to do */
> -	if (!opts->no_commit && !drop_commit) {
> +
> +	/*
> +	 * allow_empty() above only notices a commit that adds nothing to
> +	 * HEAD.  A "fixup" or "squash" can also cancel out the changes of
> +	 * the commit it is squashed into, which leaves that commit empty
> +	 * instead, so check for that here and honor --empty for it.
> +	 */
> +	if ((flags & AMEND_MSG) && !drop_commit &&

If we have a chain of fixups that looks like

	pick C
	fixup revert-C
	fixup becomes-empty

The "!drop_commit" above means that we wont drop "C" even though
squashing "revert-C" made it empty because "drop_commit == 1" after
"fixup becomes-empty".

> -	if (!opts->no_commit && !drop_commit) {
> +
> +	/*
> +	 * allow_empty() above only notices a commit that adds nothing to
> +	 * HEAD.  A "fixup" or "squash" can also cancel out the changes of
> +	 * the commit it is squashed into, which leaves that commit empty
> +	 * instead, so check for that here and honor --empty for it.
> +	 */
> +	if ((flags & AMEND_MSG) && !drop_commit &&
> +	    ctx->fixup_target == FIXUP_TARGET_PICKED_NONEMPTY) {
> +		int emptied = is_amended_head_empty(r);
> +
> +		if (emptied < 0) {
> +			res = emptied;
> +			goto leave;
> +		}
> +
> +		if (emptied && (!final_fixup || opts->keep_redundant_commits)) {

I'm not sure we need to check "emptied" here it should be fine to set
ALLOW_EMPTY unconditionally. That would allow us to move the call to
is_amended_head_empty() into the conditional block below, so we only
call it on the final fixup when dropping empty commits.

> +			/*
> +			 * Keep the commit, empty for now, when more fixups
> +			 * are still to be squashed into it, as dropping it
> +			 * here would squash them into the previous commit
> +			 * instead.  Also keep it when --empty=keep asks us to.
> +			 */
> +			flags |= ALLOW_EMPTY;

With a chain of fixups that looks like

	pick C
	fixup becomes-empty

and --empty=stop we wont stop because we've added ALLOW_EMPTY to flags.
However, because we're amending a non-empty commit it turns out the
existing code doesn't stop either, as it sees an non-empty commit when
it amends HEAD, so we're not making things any worse. With

	pick empty
	fixup becomes-empty

then the behavior is unchanged and we do stop. That inconsistency is
something we should fix but not as part of this series.

> +		} else if (emptied && opts->drop_redundant_commits) {
> +			unlink(git_path_merge_msg(r));
> +			refs_delete_ref(get_main_ref_store(r), "", "AUTO_MERGE",
> +					NULL, REF_NO_DEREF);
> +			res = drop_head_commit(r, opts,
> +					       command_to_string(command));
> +			if (res)
> +				goto leave;
> +			drop_head = 1;
> +			fprintf(stderr,
> +				_("dropping %s %s -- squashing it in empties the commit\n"),
> +				oid_to_hex(&commit->object.oid), msg.subject);
> +		}
> +		/*
> +		 * Otherwise --empty=stop is in effect, and "git commit
> +		 * --amend" below refuses to make the commit empty, which
> +		 * halts the rebase.
> +		 */
> +	}
> +
> +	if (!opts->no_commit && !drop_commit && !drop_head) {
>  		if (author || command == TODO_REVERT || (flags & AMEND_MSG))

> @@ -5057,9 +5253,26 @@ static int pick_one_commit(struct repository *r,
>   				    peek_command(todo_list, 1));
>   		return 0;
>   	} else if (pick_res == PICK_RESULT_DROPPED) {
> +		/*
> +		 * When a "pick" is dropped HEAD stays where it was, so a
> +		 * "fixup" that follows would be squashed into a commit we
> +		 * know nothing about. 

Dropping a commit and then squashing fixups into the previous pick is a
bug which we can fix using the changes in this patch. We should not drop
a pick that's followed by fixups, instead we should wait to the end of
the fixup chain to see if it is still empty. That doesn't necessarily
need to be part of this series though.

> + A dropped "fixup" on the other hand
> +		 * leaves the commit it targets untouched.
> +		 */
> +		if (!is_fixup(item->command))
> +			set_fixup_target(opts, FIXUP_TARGET_UNKNOWN);
>   		if (is_final_fixup(todo_list))
>   			flush_rewritten_pending();
>   		return 0;
> +	} else if (pick_res == PICK_RESULT_DROPPED_HEAD) {
> +		/*
> +		 * The commit the fixups were squashed into is gone, so
> +		 * neither it nor any of them were rewritten and there is
> +		 * nothing left for the post-rewrite machinery to report.
> +		 */
> +		unlink(rebase_path_rewritten_pending());
> +		set_fixup_target(opts, FIXUP_TARGET_UNKNOWN);

I guess this doesn't do any harm, but do we actually need it? We know
there are no more fixups in the chain so the next command will call
set_fixup_target() anyway.

> +		return 0;
>   	} else if (pick_res == PICK_RESULT_CONFLICTS &&
>   		   is_fixup(item->command)) {
>   		return error_failed_squash(r, item->commit, opts,
> @@ -5115,6 +5328,16 @@ static int pick_commits(struct repository *r,
>   
>   		if (save_todo(todo_list, opts, reschedule))
>   			return -1;
> +
> +		/*
> +		 * Only a commit created by a "pick" is dropped when the
> +		 * fixups squashed into it empty it out, so forget about the
> +		 * last "pick" as soon as any other command runs.
> +		 */
> +		if (item->command != TODO_PICK && !is_fixup(item->command) &&
> +		    !is_noop(item->command))
> +			set_fixup_target(opts, FIXUP_TARGET_UNKNOWN);
> +

It is a bit unfortunate that this is separated from setting the fixup
target for a "pick" command, it would be easier to follow if we did that
here rather than in do_pick_commit() and moved this below the next
line to give

>   		if (is_rebase_i(opts)) {

	if (item->command == TODO_PICK) {
		int empty = is_original_commit_empty(commit);

		if (empty < 0 ||
		    set_fixup_target(opts, empty ? FIXUP_TARGET_PICKED_EMPTY :
				     FIXUP_TARGET_PICKED_NONEMPTY))
			return -1;
	} else if (item->command != noop && !is_fixup(item->command)) {
		set_fixup_target(opts, FIXUP_TARGET_UNKNOWN);
	}

>   			if (item->command != TODO_COMMENT) {
>   				FILE *f = fopen(rebase_path_msgnum(), "w");
> @@ -5520,6 +5743,53 @@ static int commit_staged_changes(struct repository *r,
>   		}
>   	}
>   
> +	/*
> +	 * If resolving the conflicts of the last "fixup" or "squash" of a
> +	 * chain undid the commit they are being squashed into, honor
> +	 * --empty for that commit just as do_pick_commit() does when the
> +	 * chain applies cleanly.
> +	 */
> +	if ((flags & AMEND_MSG) && opts->drop_redundant_commits &&
> +	    ctx->fixup_target == FIXUP_TARGET_PICKED_NONEMPTY &&
> +	    !is_fixup(peek_command(todo_list, 0))) {
> +		int emptied = is_amended_head_empty(r);
> +
> +		if (emptied < 0) {
> +			ret = emptied;
> +			goto out;
> +		}
> +		if (emptied) {
> +			ret = drop_head_commit(r, opts, "continue");
> +			if (ret)
> +				goto out;
> +
> +			/*
> +			 * Neither the dropped commit nor the fixups squashed
> +			 * into it were rewritten, so leave nothing behind for
> +			 * the post-rewrite machinery to report.
> +			 */
> +			unlink(rebase_path_stopped_sha());
> +			unlink(rebase_path_rewritten_pending());
> +			set_fixup_target(opts, FIXUP_TARGET_UNKNOWN);
> +
> +			unlink(rebase_path_amend());
> +			unlink(rebase_path_fixup_msg());
> +			unlink(rebase_path_squash_msg());
> +			unlink(git_path_merge_head(r));
> +			unlink(git_path_merge_msg(r));
> +			refs_delete_ref(get_main_ref_store(r), "", "AUTO_MERGE",
> +					NULL, REF_NO_DEREF);
> +			if (ctx->current_fixup_count > 0) {
> +				unlink(rebase_path_current_fixups());
> +				strbuf_reset(&ctx->current_fixups);
> +				ctx->current_fixup_count = 0;
> +			}

This cleanup looks like it could easily go stale - can we have a single
place where we clean up and jump to that? Would a label just below "if
(run_git_commit(...))" do the job? That way we only need to remember to
clean up the files that "git commit" removes here.

> +			ret = 0;
> +			goto out;
> +		}
> +	}
> +
>   	if (run_git_commit(final_fixup ? NULL : rebase_path_message(),
>   			   reflog_action, opts, flags)) {
>   		ret = error(_("could not commit staged changes."));

> @@ -6527,8 +6798,28 @@ static int skip_unnecessary_picks(struct repository *r,
>   		todo_list->current = 0;
>   		todo_list->done_nr += i;
>   
> -		if (is_fixup(peek_command(todo_list, 0)))
> +		if (is_fixup(peek_command(todo_list, 0))) {
> +			/*
> +			 * The picks that were skipped never reach
> +			 * do_pick_commit(), so record here what the last of
> +			 * them left at HEAD for the fixups that follow it.
> +			 */
> +			struct commit *base = lookup_commit_reference(r,
> +								      base_oid);

If we changed the loop above to remember the commit as "struct commit
*base_commit", rather than the object id as "struct object_id base_oid"
we wouldn't need to lookup the commit again here. The loop above breaks
on the first command that isn't a "pick" so the logic here looks sound.

> +			int empty;
> +
> +			if (!base)
> +				return error(_("could not parse commit '%s'"),
> +					     oid_to_hex(base_oid));
> +			empty = is_original_commit_empty(base);
> +			if (empty < 0 ||
> +			    set_fixup_target(opts,
> +					     empty ? FIXUP_TARGET_PICKED_EMPTY :
> +					     FIXUP_TARGET_PICKED_NONEMPTY))
> +				return -1;
> +
>   			record_in_rewritten(base_oid, peek_command(todo_list, 0));
> +		}
>   	}


> diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
> index 07a5a11678..06b501b2af 100755
> --- a/t/t3415-rebase-autosquash.sh
> +++ b/t/t3415-rebase-autosquash.sh
> @@ -510,4 +510,155 @@ test_expect_success 'pick and fixup respect commit.cleanup' '
>   	test_commit_message HEAD -m "something"
>   '
>   
> +test_expect_success 'fixup! that empties its target is dropped with --empty=drop' '
> +	git reset --hard base &&
> +	test_commit --no-tag addX fileX 1 &&
> +	test_commit --no-tag changeX fileX 2 &&
> +	test_commit --no-tag later fileW hello &&
> +	echo 1 >fileX &&
> +	git commit -m "fixup! changeX" fileX &&

I think those two commands are just

	test_commit --no-tag "fixup! changeX" fileX 1

> +
> +	git rebase -i --autosquash --empty=drop HEAD~4 &&
> +
> +	git log --format=%s >actual &&
> +	test_grep ! changeX actual &&
> +	test_grep addX actual &&
> +	test_grep later actual &&

It would be easier to see what this was checking if we used test_cmp()
rather than a bunch of test_grep() calls.

The test coverage looks reasonable, I would add

test_expect_success 'fixup! that becomes empty, after its target has become empty' '
	git checkout -f first-commit &&
	test_commit two file1 2 &&
	test_commit --no-tag "fixup! two" file1 0 &&
	test_commit --no-tag "fixup! two" file3 3 &&
	test_commit four file2 4 &&

	git rebase --autosquash --empty=drop --reapply-cherry-picks base 2>err &&
	test_grep "contents already upstream" err &&
	test_grep "squashing it in empties the commit" err &&
	test_commit_message HEAD -m four &&
	git diff --exit-code four HEAD &&
	test_cmp_rev base HEAD~1
'

to check that we still drop the amended commit when the final fixup
becomes empty.

This is looking good, hopefully with a couple of tweaks it'll be ready
to be merged.

Thanks

Phillip

> +	echo 1 >expect &&
> +	test_cmp expect fileX &&
> +	echo hello >expect &&
> +	test_cmp expect fileW
> +'
> +
> +test_expect_success 'fixup! that empties its target is kept with --empty=keep' '
> +	git reset --hard base &&
> +	test_commit --no-tag addY fileY 1 &&
> +	test_commit --no-tag changeY fileY 2 &&
> +	echo 1 >fileY &&
> +	git commit -m "fixup! changeY" fileY &&
> +
> +	git rebase -i --autosquash --empty=keep HEAD~3 &&
> +
> +	git log --format=%s >actual &&
> +	test_grep changeY actual &&
> +	: "the commit that was kept is empty" &&
> +	git diff --exit-code HEAD~1 HEAD &&
> +	echo 1 >expect &&
> +	test_cmp expect fileY
> +'
> +
> +test_expect_success 'fixup! that empties its target halts by default' '
> +	git reset --hard base &&
> +	test_commit --no-tag addZ fileZ 1 &&
> +	test_commit --no-tag changeZ fileZ 2 &&
> +	echo 1 >fileZ &&
> +	git commit -m "fixup! changeZ" fileZ &&
> +
> +	test_when_finished "git rebase --abort" &&
> +	test_must_fail git rebase -i --autosquash HEAD~3
> +'
> +
> +test_expect_success 'squash! that empties its target is dropped with --empty=drop' '
> +	git reset --hard base &&
> +	test_commit --no-tag addS fileS 1 &&
> +	test_commit --no-tag changeS fileS 2 &&
> +	echo 1 >fileS &&
> +	git commit -m "squash! changeS" fileS &&
> +
> +	git rebase -i --autosquash --empty=drop HEAD~3 &&
> +
> +	git log --format=%s >actual &&
> +	test_grep ! changeS actual &&
> +	test_grep addS actual &&
> +	echo 1 >expect &&
> +	test_cmp expect fileS
> +'
> +
> +test_expect_success 'a target emptied in the middle of a chain is not dropped' '
> +	git reset --hard base &&
> +	test_commit --no-tag addM fileM 1 &&
> +	test_commit --no-tag changeM fileM 2 &&
> +	echo 1 >fileM &&
> +	git commit -m "fixup! changeM" fileM &&
> +	test_commit --no-tag "fixup! changeM" fileN later &&
> +
> +	git rebase -i --autosquash --empty=drop HEAD~4 &&
> +
> +	: "the second fixup! refills the commit the first one emptied" &&
> +	git log --format=%s >actual &&
> +	test_grep changeM actual &&
> +	echo 1 >expect &&
> +	test_cmp expect fileM &&
> +	echo later >expect &&
> +	test_cmp expect fileN
> +'
> +
> +test_expect_success 'a commit picked empty is kept when a fixup! leaves it empty' '
> +	git reset --hard base &&
> +	git commit --allow-empty -m placeholder &&
> +	git commit --allow-empty -m "fixup! placeholder" &&
> +
> +	git rebase -i --autosquash --empty=drop HEAD~2 &&
> +
> +	: "--empty only governs commits that become empty" &&
> +	git log --format=%s >actual &&
> +	test_grep placeholder actual &&
> +	git diff --exit-code HEAD~1 HEAD
> +'
> +
> +test_expect_success 'fixup! filling in an empty commit keeps a non-empty commit' '
> +	git reset --hard base &&
> +	git commit --allow-empty -m placeholder &&
> +	test_commit --no-tag "fixup! placeholder" fileP content &&
> +
> +	git rebase -i --autosquash --empty=drop HEAD~2 &&
> +
> +	git log --format=%s >actual &&
> +	test_grep placeholder actual &&
> +	echo content >expect &&
> +	test_cmp expect fileP &&
> +	test_must_fail git diff --exit-code HEAD~1 HEAD
> +'
> +
> +test_expect_success 'a fixup! not preceded by a pick does not drop its target' '
> +	git reset --hard base &&
> +	test_commit --no-tag addQ fileQ 1 &&
> +	test_commit --no-tag changeQ fileQ 2 &&
> +	echo 1 >fileQ &&
> +	git commit -m "fixup! changeQ" fileQ &&
> +
> +	: "an exec between the pick and the fixup hides what was picked" &&
> +	test_when_finished "git rebase --abort" &&
> +	set_fake_editor &&
> +	test_must_fail env FAKE_LINES="1 2 exec_true 3" \
> +		git rebase -i --autosquash --empty=drop HEAD~3
> +'
> +
> +test_expect_success 'resolving a conflicted fixup! by emptying its target drops it' '
> +	git reset --hard base &&
> +	test_commit --no-tag addC fileC 1 &&
> +	test_commit --no-tag changeC fileC 2 &&
> +	test_commit --no-tag otherC fileC 3 &&
> +	echo 1 >fileC &&
> +	git commit -m "fixup! changeC" fileC &&
> +
> +	test_when_finished "test_might_fail git rebase --abort" &&
> +	: "the fixup! is built on otherC, so it conflicts with changeC" &&
> +	test_must_fail git rebase -i --autosquash --empty=drop HEAD~4 &&
> +
> +	: "resolve it by undoing changeC, which leaves changeC empty" &&
> +	echo 1 >fileC &&
> +	git add fileC &&
> +	: "changeC is now gone, so otherC conflicts with addC" &&
> +	test_must_fail git rebase --continue &&
> +	echo 3 >fileC &&
> +	git add fileC &&
> +	git rebase --continue &&
> +
> +	git log --format=%s >actual &&
> +	test_grep ! changeC actual &&
> +	test_grep addC actual &&
> +	test_grep otherC actual
> +'
> +
>   test_done
> diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
> index ca8a10fbb1..a35671fea2 100755
> --- a/t/t5407-post-rewrite-hook.sh
> +++ b/t/t5407-post-rewrite-hook.sh
> @@ -333,4 +333,25 @@ test_expect_success 'rebase with commits that become empty' '
>   	verify_hook_input
>   '
>   
> +test_expect_success 'rebase drops a commit that its fixup empties' '
> +	git checkout -b empty-fixup A &&
> +	test_commit --no-tag P1 file1 one &&
> +	test_commit --no-tag P2 file1 two &&
> +	test_commit --no-tag P3 file2 three &&
> +	echo one >file1 &&
> +	git commit -m "fixup! P2" file1 &&
> +	p1=$(git rev-parse HEAD~3) &&
> +	p3=$(git rev-parse HEAD~1) &&
> +	clear_hook_input &&
> +
> +	git rebase -i --autosquash --empty=drop B &&
> +
> +	echo rebase >expected.args &&
> +	cat >expected.data <<-EOF &&
> +	$p1 $(git rev-parse HEAD~1)
> +	$p3 $(git rev-parse HEAD)
> +	EOF
> +	verify_hook_input
> +'
> +
>   test_done
> 
> ---
> base-commit: f78ce2f7b6df702f93d40b85d6bda92a3f65da79
> change-id: 20260709-fz-autosquash-empty-b6692cf36c60
> 
> 

