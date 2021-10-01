Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83726C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CDE061A84
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 14:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354658AbhJAO5K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 10:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354139AbhJAO5J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 10:57:09 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281AEC061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 07:55:25 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id b16so9175734qtt.7
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bv3CezCgYyfLhne7HXJx669DMHmo0TUOU8ounTpGjGQ=;
        b=U/OXdpS26tMKafwYsmNLpg3x43Yte8zcEYeM/uEgPWwBII6pT6cn65iknWhAIobYtv
         dfnE8eX3YHmRhT+pfnwWncyVcLu907wrBzD6JsIKAbeyl36yjRBINLnqMV8BMUp7/XQC
         K6XHK6+LEzDz04vm9POAwBrfyEBq0Bhe9HY7muFvvoCqfG6ZM2c5ovbkKNUtyWtGd+AR
         D0aUnCD9sKZkpvDbBONahHauV6TTJAuM61wRg0jUxtgoOXNPl/avIolr/wao2P4ymg2L
         ZG+0ixUEm1yVNZ8LWUgZnK0Ltw29cJV/r0u4p/gwize0bQqY2/ZzTHY8P551mO6g8eKL
         x6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bv3CezCgYyfLhne7HXJx669DMHmo0TUOU8ounTpGjGQ=;
        b=QTJ85WenDh+DvyqL+/pABAErcgPMAf3Ud+r2CY1ZlIQd/H4sMjtzqFlSHeD9A8VYER
         iJPu/83oA8f0ubHRpWvPV2S1Xo9UcLK6Oh4gNyPQq7r0etGCHOxramLSCmenmuW5V9wi
         Cd0L6xYqM0N1uB4Rr1AX5jN8sJFLZcwIoILilPzf7sZ0sDcnNDSPhv4AlbAJ0AlKalai
         LoGgwRTFbavE0ibrUar3CtHYgccIn5GZpt+4HZNKhM7iEHe/mS9QqVI7E/ZgGY0diOxi
         NnVXF0aqtVq5l+DWGyGbaHWbECnbNHyzCfSVHhnZOsdDaJRRJhFpHI5yf0PiHtVFnD0A
         upZg==
X-Gm-Message-State: AOAM531C75oScO2cMVP3aP/HWBAs6E65Vuix6LvAlGghGjOp4/6SLpZT
        4Oheh06IrGNG0DrcrFom5dWR
X-Google-Smtp-Source: ABdhPJzGxLe7zBhcu6WFAHihOdFpypf4p7oH1uneu8zuNEN69RpC8jyLIzJm9WdNND09CP/eysWrKQ==
X-Received: by 2002:ac8:4149:: with SMTP id e9mr13039523qtm.106.1633100124156;
        Fri, 01 Oct 2021 07:55:24 -0700 (PDT)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id az12sm3259349qkb.110.2021.10.01.07.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 07:55:23 -0700 (PDT)
Message-ID: <53263148-84b1-f76a-263d-afd00819e7a7@github.com>
Date:   Fri, 1 Oct 2021 10:55:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH 1/7] reset: behave correctly with sparse-checkout
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Kevin Willford via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Kevin Willford <kewillf@microsoft.com>
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
 <65905bf4e001118e8b9ced95c1bcecbacb6334ac.1633013461.git.gitgitgadget@gmail.com>
 <xmqqpmspc3pn.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqpmspc3pn.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "Kevin Willford via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> @@ -127,12 +129,49 @@ static void update_index_from_diff(struct diff_queue_struct *q,
>>  		struct diff_options *opt, void *data)
>>  {
>>  	int i;
>> +	int pos;
>>  	int intent_to_add = *(int *)data;
>>  
>>  	for (i = 0; i < q->nr; i++) {
>>  		struct diff_filespec *one = q->queue[i]->one;
>> +		struct diff_filespec *two = q->queue[i]->two;
>>  		int is_missing = !(one->mode && !is_null_oid(&one->oid));
>> +		int was_missing = !two->mode && is_null_oid(&two->oid);
> 
> Not a problem introduced by this patch per-se, but is_missing is a
> counter-intuitive name for what the boolean wants to represent, I
> think, which was brought in by b4b313f9 (reset: support "--mixed
> --intent-to-add" mode, 2014-02-04).  Before the commit, we used to
> say
> 
>  	for (i = 0; i < q->nr; i++) {
>  		struct diff_filespec *one = q->queue[i]->one;
> 		if (one->mode && !is_null_sha1(one->sha1)) {
> 			... create ce out of one and add to the	index ...
> 		} else
>  			remove_file_from_cache(one->path);
> 		...
> 
> i.e. "if one is not missing, create a ce and add it, otherwise
> remove the path".
> 
> It should have been called "one_is_missing" if we wanted to
> literally express the condition the code checked, but an even better
> name would have been given after the intent of what the code wants
> to do with the information.  If the resetted-to tree (that is what
> 'one' side of the comparison in diff_cache() is) has a valid blob,
> we want it to be in the index, and otherwise, we do not want it in
> the index.
> 
> Now, the patch makes things worse and I had to do the above digging
> to see why the new code is even more confusing.  The 'two' side of
> the comparison is what is in the to-be-corrected-by-reset index.
> "was_missing" in contrast to "is_missing" makes it sound as if it
> was the state before whatever "is_missing" tries to represent, but
> that is not what is happening.  "is_missing" does not mean "the
> entry is currently not there in the index", but "was_missing" does
> mean exactly that: "the entry is currently not there in the index".
> 
> There isn't any "was" missing about it.  It "is" missing in the
> index.  Instead of renaming, I wonder if we can do without this new
> variable.  Let's read on the patch.

The new variable can most likely be refactored away, but based on this it's
probably worth renaming "is_missing" to "is_missing_in_reset_tree" (or
inverting the boolean and using "is_in_reset_tree").

> Also, now the code uses both sides of the filepair, we must double
> check that our do_diff_cache() is *not* doing any rename detection.
> It might be even prudent to ensure that 
> 
> 	if (strcmp(one->path, two->path))
> 		BUG("reset drove diff-cache with rename detection");
> 
> but it might be with too much paranoia.  I dunno.

I don't think a rename would break what this change intends to do (although
it does break some of the current assumptions in the patch). I'll make sure
to verify the rename case works before submitting a new version, just in 
case.

>>  		struct cache_entry *ce;
>> +		struct cache_entry *ce_before;
>> +		struct checkout state = CHECKOUT_INIT;
> 
> These two new variables do not need this wide a scope, I would
> think.  Shouldn't it be inside the body of the new "if" statement
> this patch adds?

I will likely need to make other changes to this patch and re-roll, so I'll
fix the scoping of all of the variables added here when I do.

>> +		/*
>> +		 * When using the sparse-checkout feature the cache entries
>> +		 * that are added here will not have the skip-worktree bit
>> +		 * set. Without this code there is data that is lost because
>> +		 * the files that would normally be in the working directory
>> +		 * are not there and show as deleted for the next status.
>> +		 * In the case of added files, they just disappear.
>> +		 *
>> +		 * We need to create the previous version of the files in
>> +		 * the working directory so that they will have the right
>> +		 * content and the next status call will show modified or
>> +		 * untracked files correctly.
>> +		 */
>> +		if (core_apply_sparse_checkout && !file_exists(two->path)) {
> 
> In a sparsely checked out working tree, there is nothing in the
> working tree at the path.  It may be because it is sparse and we
> didn't want to have anything there, or it may be because the user
> wanted to get rid of it and said "rm path" (not "git rm path") and
> this part of the tree were of interest even if the sparse checkout
> feature was used to hide other parts of the tree.  With the above
> two checks alone, we cannot tell which.  Let's read on.
> 
>> +			pos = cache_name_pos(two->path, strlen(two->path));
> 
> We check the index to see if there is an entry for it.  I suspect
> that because we need to do this check anyway, we shouldn't even have
> to look at 'two' (and add a new 'was_missing' variable), because
> 'one' and 'two' came from a comparison between the resetted-to tree
> object and the current index, and if cache_name_pos() for the path
> (we can use 'one->path') says there is an entry in the index, by
> definition, 'two' would not be showing a "removed" state (i.e. "the
> resetted-to tree had it, the index does not" is what "was_missing"
> wants to say).
> 
> So I wonder if it is better to
> 
>  - use one->path for !file_exists() above and cache_name_pos() here
>    instead of two->path.
> 
>  - drop the confusingly named 'was_missing', because (pos < 0) is
>    equivalent to it after this point, and we didn't need it up to
>    this point.
> 
>> +			if ((pos >= 0 && ce_skip_worktree(active_cache[pos])) &&
> 
> And we do find an entry for it.  So this path is not something
> sparse cone specifies not to check out (otherwise we would have a
> tree-like entry that covers this path in the index and not an entry
> for this specific path)?
> 
> Anyway, if it is marked with the skip-worktree bit, does that mean
> there is no risk that the reason why two->path does not exist in the
> working tree is because we earlier gave it in the working tree but
> it was later removed by the user?  Just making sure that we are not
> breaking the end-user's wish that the path should be removed by
> resurrecting it in the working tree with a new call to
> checkout_entry().
> 
>> +			    (is_missing || !was_missing)) {
> 
> And in such a case, if the resetted-to tree says we shouldn't have
> the path in the resulting index, or if the original state in the
> index had this path (but because (0 <= pos) must be true for us to 
> reach this point, I am not sure if "was_missing" can ever be true
> here), then do the following, which is ...
> 
>> +				state.force = 1;
>> +				state.refresh_cache = 1;
>> +				state.istate = &the_index;
>> +
>> +				ce_before = make_cache_entry(&the_index, two->mode,
>> +							     &two->oid, two->path,
>> +							     0, 0);
>> +				if (!ce_before)
>> +					die(_("make_cache_entry failed for path '%s'"),
>> +						two->path);
>> +
>> +				checkout_entry(ce_before, &state, NULL, NULL);
> 
> ... to resurrect the last "git add"ed state from the index and write
> it out to the working tree.  As I suspected, ce_before and state
> should be scoped inside this block and not visible outside, no?
> 
> I am not sure why this behaviour is desirable.  The "mixed" reset
> should not have to touch the working tree in the first place.
> 
> The large comment before this block says "... will not have the
> skip-worktree bit set", but we are dealing with a case where the
> original index had a cache entry there with skip-worktree bit set,
> so isn't the more desirable outcome that the cache entry added back
> to the index has the skip-worktree bit still set and there is no
> working tree file that the user did not desire to have?
> 
> And isn't it the matter of preserving the skip-worktree bit when the
> code in the post context of this hunk this patch did not touch adds
> the entry back to the index?
> 
>> +			}
>> +		}
>>  
>>  		if (is_missing && !intent_to_add) {
>>  			remove_file_from_cache(one->path);
> 
> If we look at the code after this point, we do use "is_missing"
> information to tweak ce->ce_flags with the intent-to-add bit.
> 
> Perhaps we can do a similar tweak to the cache entry to mark it with
> skip-worktree bit if the index had a cache entry at the path with
> the bit set?  The code that needs to do so would only have to
> remember if the one->path is in the current index and the cache
> entry for the path has the skip-worktree bit in the body of the new
> if() statement about (core_apply_sparse_checkout && !file_exists())
> added by this patch (I am not sure if !file_exists() even matters,
> though, as the approach I am suggesting is to preserve the skip bit
> and not disturb the working tree files at all).

I think it might easier to address these points as a whole rather than
inline.

The problem this patch is attempting to solve is that, while (as you noted)
`git reset --mixed` should not touch the working tree, it is *also* expected
to preserve the files of the pre-reset state (both statements paraphrased
from the `--mixed` option doc). Normally these statements don't conflict,
but if `skip-worktree` is respected and nothing is done to the working tree
before resetting the index, `skip-worktree` files will effectively be `reset
--hard`. So, to force preservation of the pre-reset state, the files are
checked out.

Based on that high-level intent, the implementation here can be simplified
(and clarified). The condition on checking out a file (to avoid the `reset 
--hard`) would be "if the path exists in the current index and the entry 
in the index has `skip-worktree` enabled".

* "if the path exists in the current index" - if it does not exist in the
  index, there's nothing to preserve.
* "if the entry in the index has `skip-worktree` enabled" - if it does not,
  it's already in the working tree so we don't need to checkout.

Then, `checkout_entry()` can then be run on the index entry found (rather
than a "fake" one created with `make_cache_entry`). This eliminates a lot of
unnecessary usage of `one` and `two`, which hopefully addresses some of your
concerns about them. After that, the index reset proceeds as normal (without
manual changes to the `skip-worktree` bit).

As for the issue of ignoring `skip-worktree`: all of this could be
conditioned on a "--ignore-skip-worktree-bits" flag (or something like it)
if you'd prefer the default behavior is "don't touch the working tree".
