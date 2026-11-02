Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793636499;
	b=JF16/FxhXzQgACb9T6SOxR4H8JP3xJwuO5HFUNm1k8rg/yNOSaTANANBN/UM5sT1pnCg
	 vI3rlnl3+bL/Ueu0mITZ0FOTbD5ZukCM1hpTP0I6qqJB5jrR0BM2YOQIaflwv8sBKmWbf
	 L5mqI6niikhj5MeNNJYuZmC5KhWQT/7vyVpDWvVi0SLYYgpTgXUjOcoigyFqvPSRRfm69
	 8yILloNl4YvbH+UqaORyGZnY6MBGwCNT8PFsJLnICKIalpmHGlqm0qvHiha4F7lUS2ARD
	 0sfphGw+TFoEfkGd9R9n/tUDtlqS3neE8bi9LEENp5q8qmi4A2x2b/dD1KKzFTdrBYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793636499;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:Reply-To:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=dPnndEFt+kUc4cf3JVBDGKRYwtQzLOHnXJC58FAJQso=;
	b=P78S23/uwhHrwOUZ+VcIS5fG6/paLRHfWiprXLD5+eOk8xUHEvsx2Ix0wh5zV3f9dPyD
	 oyBG2/oR5QQDDkVYGY76ZMI4Fl10PgBbGZx+r0FwF3KwwMZxckToaIWLaBmgkW+A5F4VY
	 hd+BhddsFZvj8wA+pDheXDRDgorR+jj1MgDKSGT0996xZtQj3hQIDwuXRuMEKeLytKWmC
	 D56YO7+Q576pGv+EGEnVtWtQdkA6Mq82fcQvl7mXQ9UeOqpiD4cAMb9CPlI2esLRHQspb
	 8ZzVuae5C0fNguA1wmk37//Bu1+YR1ePAPNRflCgEmmGSupV5ABkV9D4hosJcpbSzKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FyAaLLlf;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F359608441D
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 16:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F359608441D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FyAaLLlf
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e20edd106so2479207f8f.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 08:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793636497; x=1794241297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dPnndEFt+kUc4cf3JVBDGKRYwtQzLOHnXJC58FAJQso=;
        b=FyAaLLlf+GqyzrehgCgYHVH4WKjD3vlkCCE6V//JGlJP15W0qphC/CUmoZt3xKEfYU
         XDn5YrvhQYwa/qWhAnsfvvA1/M0eoaxo0tiqM2GSsfA8jxaZ9d1mhUTw2DYyJHi5WdUw
         0+2U7O1bbO8jy3doSyzffHxsU96WmupB2mM36vfjlro4KtY5a+bQi4eMZnj0/hxKW2P3
         l3jG+kZ3L/wjBIlSP7mAF9we+z30OXR7Jal23ZggUxWkyzGYRKdosJLCpNiHyBVgl0Q/
         5k4UKUPpW2Bluquxm7MXXbOoW2C3r87m1YH851LGzO6Cw8UhVNt6HkWqZIKALOunvz88
         Mm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793636497; x=1794241297;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dPnndEFt+kUc4cf3JVBDGKRYwtQzLOHnXJC58FAJQso=;
        b=kVQ1JWQkAjzW9pjwxcUcCpVeOwY/Y9j5TUITy4xWySg5hy9QIuGUOEostLQmJdM4qL
         z41F1p/Z01cN8nOGSVvhWT2xIFdPOTTrT64sEB30CaDX1d7GxsDnD9Sg6K8DL61zQ9u8
         UYwiWe/TxctrF6wxl2cKL48X0dglsA2oB9dPBk4qZJKaXvB1ypHB12lEdU5qt9lGj+vl
         8qq3YQDtxgl7y2PK7HpzktJCDQZDyKXGDlKmr1ztF9COQqDs5Z38F7xJmuPSE0ZzxnV0
         lphlZ0vPsfsAtpeF4zEDUgt88ZpJEZKSuyTxAzjpMStYVg9qawPvC+pH7a+IinvJ+4hk
         58yw==
X-Forwarded-Encrypted: i=1; AKwUvBwFo1iCvQEHvw+i8FcGMe+6MesarbR+dMw6IJl3DSMGXH3DkGYCBXV8QgTkSUw6aQHQtAI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+B4h2zOKaU/K32AyibQ69xOtRgmq7U2xHnYt9p6REmLY09hHmC
	V2bJOS87u5vpCxMwEUjSyONeXPgLBH9X/ZC+SYMZp/zHmhcwIMQ4EBbf
X-Gm-Gg: AYBFou2blBJo7bV3kTzdzsELb6n7EmAvMxGeqQOUeTlOKbBKRWEpWjszDXRc1PpQ+th
	9v+PZqmg2sBFe7roHiQkpfYQOgFhD+I8TMFR5BJZhK5sPPd9Z7ANbSyb/jjk4Zh/vq+htSmrOO6
	PT6VxSz3UeoQpJoHiIdCnJU1w8cM/SgOHuJR5JFDzugj6qQgfgN9kycpEPYx1sVzV3p52Q8bfU9
	/RsyvcwUZjnVkkiBb3Ft7V0eeJsqliZeJO3/Pfz9zGSWbLroFg2JKmqQejD8h4mlBKD2dbXe+BT
	Ttb721EB+whKwep3h5mFtPaYS0KUGsB58slpqqvvCVQ+XR2ahwc5A+LF6LrD5xl/pJU0aUrlk7u
	DZcPMBHggaFm/xGJD1ooFck19O9FJP3x7S1UlnOQ3jbFfyoeH9m/GrIuKznhKUjnCqUXix5irVh
	JJLYVbHkRJ99rbap5c7V+amoR/jhKQMGvIfvsiw6z5s+NLMhZNkgTuOkaAz4zD/7yTCbDm1GdSH
	vOLDRvqeQHR/wWmWN2ZGVIpEdASb2X/Wu4VlqCcm9ee5tka3y+4ABa5ssRkDnMdm6ZfTXegpkla
	fgduzwpUPp2/Du7X+kAtQQZtc3vd4y13EudkeU/azcBLSS9uqrQUGJGoki1y82l42YHE0cOFkug
	s0ItQvQ==
X-Received: by 2002:a05:6000:4021:b0:48e:4300:c70e with SMTP id ffacd0b85a97d-48e6e304059mr22812992f8f.46.1793636496419;
        Mon, 02 Nov 2026 08:21:36 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8a5a7sm21893764f8f.37.2026.11.02.08.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 08:21:35 -0800 (PST)
Message-ID: <6fb08241-74c4-445d-8c75-6ed5f4175f26@gmail.com>
Date: Mon, 2 Nov 2026 16:21:34 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5] sequencer: honor --empty when a fixup!/squash! empties
 its target
Reply-To: phillip.wood@dunelm.org.uk
To: Farid Zakaria <farid.m.zakaria@gmail.com>, git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>
References: <20260709-fz-autosquash-empty-v1-1-84cb494c3613@gmail.com>
 <20261028-fz-autosquash-empty-v5-1-a3cfb582fff5@gmail.com>
Content-Language: en-US
In-Reply-To: <20261028-fz-autosquash-empty-v5-1-a3cfb582fff5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Farid

On 28/10/2026 21:09, Farid Zakaria wrote:
> ---
> Sorry this v5 has taken a while; I got sidelined by other personal
> and $DAYJOB work.  Thanks for the review, Phillip -- this version
> addresses it.

Yes, this looks pretty good. I've left a few comments below, they're 
mostly things that would be nice to have but I do think that we need a 
couple of changes in commit_staged_changes(). I have to say I found a 
lot of the code comments to be a bit hard to follow - they seem to start 
at the end of the story and work backwards, rather than starting at the 
beginning and leading the reader to the end in a series of logical steps.

This patch does not apply to master (I'm not sure if that's why Junio 
hasn't pick it up) so it would probably be worth rebasing it when you 
re-roll.

> diff --git a/sequencer.c b/sequencer.c
> index 65afd100d9..4524de3f8b 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> [...]
> +/*
> + * Remember what the commit that the current chain of fixup and squash
> + * commands is being applied to was picked as, both in the sequencer state
> + * and on disk so that it survives a stop for conflict resolution.
> + */
> +static int set_fixup_target(struct replay_opts *opts, enum fixup_target target)
> +{
> +	struct replay_ctx *ctx = opts->ctx;
> +	const char *name;
> +
> +	if (ctx->fixup_target == target)
> +		return 0;
> +
> +	ctx->fixup_target = target;
> +	if (!is_rebase_i(opts))
> +		return 0;

It's a bit strange to only check if we're rebasing after we've already 
set ctx->fixup_target. We only need to call this function if we're 
rebasing so it make sense to check that at the beginning of the function.

> +/*
> + * A "fixup" or "squash" is applied by amending HEAD, so the commit it
> + * produces is empty when the index matches the tree of HEAD's parent,
> + * rather than the tree of HEAD itself that is_index_unchanged() looks at.
> + * Returns 1 if amending HEAD would leave it empty, 0 if not, and negative
> + * on error.
> + */
> +static int is_amended_head_empty(struct repository *r)
> +{
> +	const struct object_id *parent_tree_oid;
> +	struct object_id *cache_tree_oid;
> +	struct commit *head;
> +
> +	head = lookup_commit_reference_by_name("HEAD");
> +	if (!head || repo_parse_commit(r, head))
> +		return error(_("could not parse HEAD commit"));
> +
> +	if (head->parents) {
> +		struct commit *parent = head->parents->item;
> +
> +		if (repo_parse_commit(r, parent))
> +			return error(_("could not parse parent commit %s"),
> +				     oid_to_hex(&parent->object.oid));
> +		parent_tree_oid = get_commit_tree_oid(parent);

For a merge commit (i.e. head->parents->next is non-NULL) we should 
return 0. However, we only call this function when the fixup target is 
NONEMPTY which is only set for "pick" commands so it is not a problem in 
practice.

> +/*
> + * Drop the commit at HEAD by moving HEAD back to its parent.  The index and
> + * the worktree already match the tree of that parent, so nothing else needs
> + * to be updated.  "action" names the command doing the dropping and is only
> + * used for the reflog message.
> + */
> +static int drop_head_commit(struct repository *r, struct replay_opts *opts,
> +			    const char *action)
> +{
> +	struct commit *head = lookup_commit_reference_by_name("HEAD");
> +
> +	if (!head || repo_parse_commit(r, head))
> +		return error(_("could not parse HEAD commit"));
> +	if (!head->parents)
> +		return error(_("cannot drop the root commit"));

We should BUG() if HEAD is a merge commit, as we should only call this 
when the fixup target is NONEMPTY.

> @@ -2540,7 +2682,61 @@ static enum pick_result do_pick_commit(struct repository *r,
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
> +	if ((flags & AMEND_MSG) &&
> +	    ctx->fixup_target == FIXUP_TARGET_PICKED_NONEMPTY) {
> +		if (!final_fixup || opts->keep_redundant_commits) {
> +			/*
> +			 * Keep the commit, even if it is empty for now, when

s/when/while/?

> +			 * more fixups are still to be squashed into it, as
> +			 * dropping it here would squash them into the
> +			 * previous commit instead.  Also keep it when
> +			 * --empty=keep asks us to.
> +			 */
> +			flags |= ALLOW_EMPTY;
> +		} else if (opts->drop_redundant_commits) {
> +			/*
> +			 * allow_empty() above may have dropped this final
> +			 * fixup as already upstream, leaving HEAD as the
> +			 * earlier fixups of the chain made it, so check
> +			 * HEAD whether or not drop_commit is set.
> +			 */

All the talk about allow_empty() and drop_commit is bit of a 
distraction. The important point is is the final fixup and we want to 
know whether HEAD has become empty.
> +			int emptied = is_amended_head_empty(r);
> +
> +			if (emptied < 0) {
> +				res = emptied;
> +				goto leave;
> +			}
> +			if (emptied) {

This would be clearer as "} else if (emptied) {"

> +				unlink(git_path_merge_msg(r));
> +				refs_delete_ref(get_main_ref_store(r), "",
> +						"AUTO_MERGE", NULL,
> +						REF_NO_DEREF);
> +				res = drop_head_commit(r, opts,
> +						       command_to_string(command));
> +				if (res)
> +					goto leave;
> +				drop_head = 1;
> +				fprintf(stderr,
> +					_("dropping %s %s -- squashing it in empties the commit\n"),
> +					oid_to_hex(&commit->object.oid),
> +					msg.subject);

If HEAD has become empty we drop it - good.

> +			}
> +		}
> +		/*
> +		 * Otherwise --empty=stop is in effect, and "git commit
> +		 * --amend" below refuses to make the commit empty, which
> +		 * halts the rebase.
> +		 */
> +	}
> +
> +	if (!opts->no_commit && !drop_commit && !drop_head) {

We only create a new commit if we're not dropping the fixup or HEAD - good.

> @@ -3318,6 +3516,17 @@ static int read_populate_opts(struct replay_opts *opts)
>   		}
>   		strbuf_reset(&buf);
>   
> +		if (read_oneliner(&buf, rebase_path_fixup_target(),
> +				  READ_ONELINER_SKIP_IF_EMPTY)) {
> +			enum fixup_target target;
> +
> +			for (target = FIXUP_TARGET_PICKED_EMPTY;
> +			     target <= FIXUP_TARGET_PICKED_NONEMPTY; target++)
> +				if (!strcmp(buf.buf, fixup_target_name[target]))
> +					ctx->fixup_target = target;

Do we want some error checking here, rather than assuming 
FIXUP_TARGET_UNKNOWN if the file does not contain one of the expected 
values? If we ever add a new value to the enum, that would prevent old 
versions of git getting confused if they continued a rebase started by a 
newer version.

> @@ -5057,9 +5266,25 @@ static int pick_one_commit(struct repository *r,
>   				    peek_command(todo_list, 1));
>   		return 0;
>   	} else if (pick_res == PICK_RESULT_DROPPED) {
> +		/*
> +		 * When a "pick" is dropped HEAD stays where it was, so a
> +		 * "fixup" that follows would be squashed into a commit we
> +		 * know nothing about.  A dropped "fixup" on the other hand
> +		 * leaves the commit it targets untouched.
> +		 */

I find this comment hard to understand. Hopefully it wont be too hard to 
avoid dropping a commit that is being fixed up before we've applied all 
the fixups once this patch lands.

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

This comment is also hard to understand. Maybe

	All the commits listed in the rewritten-pending file
	have been dropped, so they have not been rewritten.

> +		unlink(rebase_path_rewritten_pending());
> +		return 0;
>   	} else if (pick_res == PICK_RESULT_CONFLICTS &&
>   		   is_fixup(item->command)) {
>   		return error_failed_squash(r, item->commit, opts,
> @@ -5116,6 +5341,21 @@ static int pick_commits(struct repository *r,
>   		if (save_todo(todo_list, opts, reschedule))
>   			return -1;
>   		if (is_rebase_i(opts)) {
> +			/*
> +			 * Only a commit created by a "pick" is dropped when
> +			 * the fixups squashed into it empty it out, and only
> +			 * if it was picked with changes of its own.  Remember
> +			 * which kind of "pick" this is, and forget about the
> +			 * last "pick" as soon as any other command runs.
> +			 */

There is only one kind of pick command, there are different types of 
fixup targets though. I'm not sure how much value this comment adds.

> +			if (item->command == TODO_PICK) {
> +				if (set_fixup_target_picked(opts, item->commit))
> +					return -1;
> +			} else if (!is_noop(item->command) &&
> +				   !is_fixup(item->command)) {
> +				set_fixup_target(opts, FIXUP_TARGET_UNKNOWN);
> +			}
> +
>   			if (item->command != TODO_COMMENT) {
>   				FILE *f = fopen(rebase_path_msgnum(), "w");
>   
> @@ -5520,12 +5760,51 @@ static int commit_staged_changes(struct repository *r,
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

As before I think "} else if (emptied) {" is clearer

> +			ret = drop_head_commit(r, opts, "continue");
> +			if (ret)
> +				goto out;
> +
> +			/*
> +			 * Neither the dropped commit nor the fixups squashed
> +			 * into it were rewritten, so leave nothing behind for
> +			 * the post-rewrite machinery to report.

"so remove the list of pending rewrites"?

> +			 */
> +			unlink(rebase_path_stopped_sha());

This is not removed by another conditional branch in this function, so I 
don't think we should remove it here. Instead it is removed, along with 
the other files that were written when we stopped for user interaction, 
at the start of pick_commits().

> +			unlink(rebase_path_rewritten_pending());
> +
> +			/*
> +			 * Remove what "git commit" would have removed, and
> +			 * clean up after the chain like its final fixup does.
> +			 */

I don't understand what the last half of that sentence is saying.

> +			unlink(git_path_merge_msg(r));

If a "squash" command at the end of a chain of fixups has conflicts we 
write the message to git_path_squash_msg(r) instead, so we need to 
remove both those paths.

> @@ -6527,8 +6809,18 @@ static int skip_unnecessary_picks(struct repository *r,
>   		todo_list->current = 0;
>   		todo_list->done_nr += i;
>   
> -		if (is_fixup(peek_command(todo_list, 0)))
> +		if (is_fixup(peek_command(todo_list, 0))) {
> +			/*
> +			 * The picks that were skipped never reach
> +			 * pick_commits(), so record here what the last of
> +			 * them left at HEAD for the fixups that follow it.
> +			 */

The phrasing here is a bit strange, maybe

	If we've skipped a "pick" command before this command we need
	to record whether that commit is empty or not

The test changes all look good.

Thanks for working on this

Phillip
	
> diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
> index 07a5a11678..45f396cf62 100755
> --- a/t/t3415-rebase-autosquash.sh
> +++ b/t/t3415-rebase-autosquash.sh
> @@ -510,4 +510,168 @@ test_expect_success 'pick and fixup respect commit.cleanup' '
>   	test_commit_message HEAD -m "something"
>   '
>   
> +test_expect_success 'fixup! that empties its target is dropped with --empty=drop' '
> +	git reset --hard base &&
> +	test_commit --no-tag addX fileX 1 &&
> +	test_commit --no-tag changeX fileX 2 &&
> +	test_commit --no-tag later fileW hello &&
> +	test_commit --no-tag "fixup! changeX" fileX 1 &&
> +
> +	git rebase -i --autosquash --empty=drop HEAD~4 &&
> +
> +	cat >expect <<-\EOF &&
> +	later
> +	addX
> +	EOF
> +	git log --format=%s base.. >actual &&
> +	test_cmp expect actual &&
> +	git diff --exit-code ORIG_HEAD HEAD
> +'
> +
> +test_expect_success 'fixup! that empties its target is kept with --empty=keep' '
> +	git reset --hard base &&
> +	test_commit --no-tag addY fileY 1 &&
> +	test_commit --no-tag changeY fileY 2 &&
> +	test_commit --no-tag "fixup! changeY" fileY 1 &&
> +
> +	git rebase -i --autosquash --empty=keep HEAD~3 &&
> +
> +	cat >expect <<-\EOF &&
> +	changeY
> +	addY
> +	EOF
> +	git log --format=%s base.. >actual &&
> +	test_cmp expect actual &&
> +	: "the commit that was kept is empty" &&
> +	git diff --exit-code HEAD~1 HEAD
> +'
> +
> +test_expect_success 'fixup! that empties its target halts by default' '
> +	git reset --hard base &&
> +	test_commit --no-tag addZ fileZ 1 &&
> +	test_commit --no-tag changeZ fileZ 2 &&
> +	test_commit --no-tag "fixup! changeZ" fileZ 1 &&
> +
> +	test_when_finished "git rebase --abort" &&
> +	test_must_fail git rebase -i --autosquash HEAD~3
> +'
> +
> +test_expect_success 'squash! that empties its target is dropped with --empty=drop' '
> +	git reset --hard base &&
> +	test_commit --no-tag addS fileS 1 &&
> +	test_commit --no-tag changeS fileS 2 &&
> +	test_commit --no-tag "squash! changeS" fileS 1 &&
> +
> +	git rebase -i --autosquash --empty=drop HEAD~3 &&
> +
> +	echo addS >expect &&
> +	git log --format=%s base.. >actual &&
> +	test_cmp expect actual &&
> +	git diff --exit-code ORIG_HEAD HEAD
> +'
> +
> +test_expect_success 'a target emptied in the middle of a chain is not dropped' '
> +	git reset --hard base &&
> +	test_commit --no-tag addM fileM 1 &&
> +	test_commit --no-tag changeM fileM 2 &&
> +	test_commit --no-tag "fixup! changeM" fileM 1 &&
> +	test_commit --no-tag "fixup! changeM" fileN later &&
> +
> +	git rebase -i --autosquash --empty=drop HEAD~4 &&
> +
> +	: "the second fixup! refills the commit the first one emptied" &&
> +	cat >expect <<-\EOF &&
> +	changeM
> +	addM
> +	EOF
> +	git log --format=%s base.. >actual &&
> +	test_cmp expect actual &&
> +	git diff --exit-code ORIG_HEAD HEAD
> +'
> +
> +test_expect_success 'fixup! that becomes empty, after its target has become empty' '
> +	git checkout -f first-commit &&
> +	test_commit two file1 2 &&
> +	test_commit --no-tag "fixup! two" file1 0 &&
> +	test_commit --no-tag "fixup! two" file3 3 &&
> +	test_commit four file2 4 &&
> +
> +	git rebase --autosquash --empty=drop --reapply-cherry-picks base 2>err &&
> +	test_grep "contents already upstream" err &&
> +	test_grep "squashing it in empties the commit" err &&
> +	echo four >expect &&
> +	git log --format=%s base.. >actual &&
> +	test_cmp expect actual &&
> +	git diff --exit-code four HEAD
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
> +	echo placeholder >expect &&
> +	git log --format=%s base.. >actual &&
> +	test_cmp expect actual &&
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
> +	echo placeholder >expect &&
> +	git log --format=%s base.. >actual &&
> +	test_cmp expect actual &&
> +	git diff --exit-code ORIG_HEAD HEAD &&
> +	test_must_fail git diff --exit-code HEAD~1 HEAD
> +'
> +
> +test_expect_success 'a fixup! not preceded by a pick does not drop its target' '
> +	git reset --hard base &&
> +	test_commit --no-tag addQ fileQ 1 &&
> +	test_commit --no-tag changeQ fileQ 2 &&
> +	test_commit --no-tag "fixup! changeQ" fileQ 1 &&
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
> +	test_commit --no-tag "fixup! changeC" fileC 1 &&
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
> +	cat >expect <<-\EOF &&
> +	otherC
> +	addC
> +	EOF
> +	git log --format=%s base.. >actual &&
> +	test_cmp expect actual
> +'
> +
>   test_done
> diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
> index ca8a10fbb1..eb6e503b0c 100755
> --- a/t/t5407-post-rewrite-hook.sh
> +++ b/t/t5407-post-rewrite-hook.sh
> @@ -333,4 +333,24 @@ test_expect_success 'rebase with commits that become empty' '
>   	verify_hook_input
>   '
>   
> +test_expect_success 'rebase drops a commit that its fixup empties' '
> +	git checkout -b empty-fixup A &&
> +	test_commit --no-tag P1 file1 one &&
> +	test_commit --no-tag P2 file1 two &&
> +	test_commit --no-tag P3 file2 three &&
> +	test_commit --no-tag "fixup! P2" file1 one &&
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

