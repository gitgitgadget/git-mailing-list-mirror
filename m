Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB859C433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 10:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C8D7613B3
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 10:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbhJDKE5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 06:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbhJDKE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 06:04:56 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095F2C061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 03:03:07 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t8so29867328wri.1
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 03:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a0I1kCycMVdpX7onuyHY+i3m+QVQpdV7uPNmQ3eb82s=;
        b=WykDI7GbGCnnohNah+xhUtqzGhi1ucFpIW+RMX5n5TyKoj8D+pZV7BkBLXNezwrJnB
         L+C0ntYyVXWvhRN4xEcCAw4novFyARGlUv/NlToGzDNry4Ol50VpcvE1AvDwG+2yes6w
         RwaiMB7/vO06xjussKGjMp2ttB4PRz/BuNyZO+sUcIwJmtqpPf0uQoPFsLTVunhyXXeE
         YSsHQcH1+uIwWZPYz57sbCG4GeEApsEgkJnTuIfSFYUMf1Ka2sxXfu5X995/K9SDJlcH
         L5eSfsIdJUYVb8QcsgjyHPIF3QYxL3r0h6lFu6ySguqIOATVHeRSaiLQZxjA8wmAzaEE
         i9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=a0I1kCycMVdpX7onuyHY+i3m+QVQpdV7uPNmQ3eb82s=;
        b=dGsLMlzkHcgwT81cBuNm+Bo7qcSCFx7JhSmxNJFutq9AyZxjnSNdTXT/C9buSJF3wO
         zu0hhruBToRfSQ6+qf6v9k2kXX8uANonYJTeU91yLb1EiU1Ur1gYPbr8EJs37D5HjPHR
         p+RlIcVnY5Bq9FpW7JrpXufCJ1bmCLLPGKvT10O5ipsBcqMBelrkmVRoHEC0/1b+ZUTq
         WM2hcQNA/+JWGTU16gy5lEC6fMEVW1S6mUg60kZcH2P7ijWgUXr9oQ6sTVJGPVFO/oCq
         r5nl5a2MZzKPoy5LPsvyT0Z43qtjb/tULWJVoA4Lxt7kr5/KVDvXiZrbDeB0TCwCUnp3
         NA/g==
X-Gm-Message-State: AOAM531ZB0vKtz83vmqe5KHJX/e+tN/RizjyWSa5YXohGZhQGLd/zW8i
        AUGidxXuPq8lCRW2VzJWmTs=
X-Google-Smtp-Source: ABdhPJwbx9BQY8h6rW4EAmq3KGOesaHhdsMxbYn/oFC8P/SfjNxzQWJVUrZ0IRlb1naVqEju3tjdrg==
X-Received: by 2002:adf:b1d7:: with SMTP id r23mr278602wra.145.1633341785630;
        Mon, 04 Oct 2021 03:03:05 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id k26sm18234947wms.39.2021.10.04.03.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 03:03:05 -0700 (PDT)
Message-ID: <27b8539e-f097-3027-ffee-f54de09a6361@gmail.com>
Date:   Mon, 4 Oct 2021 11:03:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 05/11] reset_head(): factor out ref updates
Content-Language: en-GB-large
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
 <0744c3d143b5c2020267c5f9ad7da9303d7a7835.1633082702.git.gitgitgadget@gmail.com>
 <xmqqlf3c5ul1.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqlf3c5ul1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 01/10/2021 22:00, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> In the next commit we will stop trying to update HEAD when we are just
>> clearing changes from the working tree. Move the code that updates the
> 
> "clearing changes" meaning...?  Like "rebase --abort"?

"rebase --abort" will update HEAD, "rebase --skip" would be a better 
example, I'll expand the commit message.

Best Wishes

Phillip

>> refs to its own function in preparation for that.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   reset.c | 112 +++++++++++++++++++++++++++++++-------------------------
>>   1 file changed, 62 insertions(+), 50 deletions(-)
>>
>> diff --git a/reset.c b/reset.c
>> index 9ab007c0c34..668c7639127 100644
>> --- a/reset.c
>> +++ b/reset.c
>> @@ -8,26 +8,75 @@
>>   #include "tree.h"
>>   #include "unpack-trees.h"
>>   
>> +static int update_refs(const struct object_id *oid, const char *switch_to_branch,
>> +		       const char *reflog_head, const char *reflog_orig_head,
>> +		       const char *default_reflog_action, unsigned flags)
>> +{
>> +	unsigned detach_head = flags & RESET_HEAD_DETACH;
>> +	unsigned run_hook = flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
>> +	unsigned update_orig_head = flags & RESET_ORIG_HEAD;
>> +	struct object_id *orig = NULL, oid_orig, *old_orig = NULL, oid_old_orig;
>> +	struct strbuf msg = STRBUF_INIT;
>> +	const char *reflog_action;
>> +	size_t prefix_len;
>> +	int ret;
>> +
>> +	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
>> +	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : default_reflog_action);
>> +	prefix_len = msg.len;
>> +
>> +	if (update_orig_head) {
>> +		if (!get_oid("ORIG_HEAD", &oid_old_orig))
>> +			old_orig = &oid_old_orig;
>> +		if (!get_oid("HEAD", &oid_orig)) {
>> +			orig = &oid_orig;
>> +			if (!reflog_orig_head) {
>> +				strbuf_addstr(&msg, "updating ORIG_HEAD");
>> +				reflog_orig_head = msg.buf;
>> +			}
>> +			update_ref(reflog_orig_head, "ORIG_HEAD", orig,
>> +				   old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
>> +		} else if (old_orig)
>> +			delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
>> +	}
>> +
>> +	if (!reflog_head) {
>> +		strbuf_setlen(&msg, prefix_len);
>> +		strbuf_addstr(&msg, "updating HEAD");
>> +		reflog_head = msg.buf;
>> +	}
>> +	if (!switch_to_branch)
>> +		ret = update_ref(reflog_head, "HEAD", oid, orig,
>> +				 detach_head ? REF_NO_DEREF : 0,
>> +				 UPDATE_REFS_MSG_ON_ERR);
>> +	else {
>> +		ret = update_ref(reflog_head, switch_to_branch, oid,
>> +				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
>> +		if (!ret)
>> +			ret = create_symref("HEAD", switch_to_branch,
>> +					    reflog_head);
>> +	}
>> +	if (!ret && run_hook)
>> +		run_hook_le(NULL, "post-checkout",
>> +			    oid_to_hex(orig ? orig : null_oid()),
>> +			    oid_to_hex(oid), "1", NULL);
>> +	strbuf_release(&msg);
>> +	return ret;
>> +}
>> +
>>   int reset_head(struct repository *r, struct object_id *oid,
>>   	       const char *switch_to_branch, unsigned flags,
>>   	       const char *reflog_orig_head, const char *reflog_head,
>>   	       const char *default_reflog_action)
>>   {
>> -	unsigned detach_head = flags & RESET_HEAD_DETACH;
>>   	unsigned reset_hard = flags & RESET_HEAD_HARD;
>> -	unsigned run_hook = flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
>>   	unsigned refs_only = flags & RESET_HEAD_REFS_ONLY;
>> -	unsigned update_orig_head = flags & RESET_ORIG_HEAD;
>>   	struct object_id head_oid;
>>   	struct tree_desc desc[2] = { { NULL }, { NULL } };
>>   	struct lock_file lock = LOCK_INIT;
>>   	struct unpack_trees_options unpack_tree_opts = { 0 };
>>   	struct tree *tree;
>> -	const char *action, *reflog_action;
>> -	struct strbuf msg = STRBUF_INIT;
>> -	size_t prefix_len;
>> -	struct object_id *orig = NULL, oid_orig,
>> -		*old_orig = NULL, oid_old_orig;
>> +	const char *action;
>>   	int ret = 0, nr = 0;
>>   
>>   	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
>> @@ -47,7 +96,9 @@ int reset_head(struct repository *r, struct object_id *oid,
>>   		oid = &head_oid;
>>   
>>   	if (refs_only)
>> -		goto reset_head_refs;
>> +		return update_refs(oid, switch_to_branch, reflog_head,
>> +				   reflog_orig_head, default_reflog_action,
>> +				   flags);
>>   
>>   	action = reset_hard ? "reset" : "checkout";
>>   	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
>> @@ -90,49 +141,10 @@ int reset_head(struct repository *r, struct object_id *oid,
>>   		goto leave_reset_head;
>>   	}
>>   
>> -reset_head_refs:
>> -	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
>> -	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : default_reflog_action);
>> -	prefix_len = msg.len;
>> -
>> -	if (update_orig_head) {
>> -		if (!get_oid("ORIG_HEAD", &oid_old_orig))
>> -			old_orig = &oid_old_orig;
>> -		if (!get_oid("HEAD", &oid_orig)) {
>> -			orig = &oid_orig;
>> -			if (!reflog_orig_head) {
>> -				strbuf_addstr(&msg, "updating ORIG_HEAD");
>> -				reflog_orig_head = msg.buf;
>> -			}
>> -			update_ref(reflog_orig_head, "ORIG_HEAD", orig,
>> -				   old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
>> -		} else if (old_orig)
>> -			delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
>> -	}
>> -
>> -	if (!reflog_head) {
>> -		strbuf_setlen(&msg, prefix_len);
>> -		strbuf_addstr(&msg, "updating HEAD");
>> -		reflog_head = msg.buf;
>> -	}
>> -	if (!switch_to_branch)
>> -		ret = update_ref(reflog_head, "HEAD", oid, orig,
>> -				 detach_head ? REF_NO_DEREF : 0,
>> -				 UPDATE_REFS_MSG_ON_ERR);
>> -	else {
>> -		ret = update_ref(reflog_head, switch_to_branch, oid,
>> -				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
>> -		if (!ret)
>> -			ret = create_symref("HEAD", switch_to_branch,
>> -					    reflog_head);
>> -	}
>> -	if (!ret && run_hook)
>> -		run_hook_le(NULL, "post-checkout",
>> -			    oid_to_hex(orig ? orig : null_oid()),
>> -			    oid_to_hex(oid), "1", NULL);
>> +	ret = update_refs(oid, switch_to_branch, reflog_head, reflog_orig_head,
>> +			  default_reflog_action, flags);
>>   
>>   leave_reset_head:
>> -	strbuf_release(&msg);
>>   	rollback_lock_file(&lock);
>>   	clear_unpack_trees_porcelain(&unpack_tree_opts);
>>   	while (nr)
