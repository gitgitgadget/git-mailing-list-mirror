Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A87AC433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 13:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbiC2NVV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 09:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiC2NVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 09:21:16 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6A915A22
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 06:19:33 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id o20-20020a9d7194000000b005cb20cf4f1bso12735945otj.7
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 06:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/J1wkDzDoEQHMpUq5L3GUyffT3av/45bETC5XlzWuOc=;
        b=Xgm3rT0nwUsqRcgQFcd9VCkJIqo2+eqMSmBuwEKjHZ7/0g8YjHqK9SCka7S5oUQ50n
         J34/mwYoq+oFiQiZnUYNSFrKn8DIUAinHSMo+D8ShBpnaBFH10p0mddG3osDuVLM9Jf7
         hx+JW2sv5zVNpqPdh7Y3AfcEs1sq0ksXrpJ4cg0ax5X0vj5grhwZrQMejV9un9EU+ro8
         kAmRsye2Smnaj2Yk61yO0fMMk/MW5sqd4pcdUzvmUzDeX+LN99IMbL/Rq0GpT7rxmQR7
         IvLGq5vE32swWcmnyzatjM/erTUmnn/SN4gk5KtkC8tGTDqEfBZPDiewtm64weNnweLU
         9CnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/J1wkDzDoEQHMpUq5L3GUyffT3av/45bETC5XlzWuOc=;
        b=4PfvYO8jiVpzs42ZAzIqAAgf/J5PrcjW6UlCAw1SpIrPsXEM35UPm6gOqSzLouyMZZ
         JzjlFCaegivOFHFHoLr/vQmraX0XF+H0vQ3XR9gGYLiLH0FUyLiSDQ1X2xqEPruBR7q+
         L2spvf1lvkQYZnW7fliV10/dZvO3b+sO6PPk0u3fknSq1rJw0L3NYhfiOk7qA95bTHnj
         +mfQCNHO83T4pT4eXrqlD9rueMfZDIqZaq0NOT1g1oHr57TZazt1QuJm6OXCcJgeTFYZ
         Ua74AKUlc3KADoawNQA3KnyC0NKkRt4FIccpoN0sax+A0nvN0hbIvrU4hBEyPl1BvMyB
         W2Ug==
X-Gm-Message-State: AOAM532eJEDE/6Ou83qSWIc723ZTyIkeyW+wJcGwm1Zs4HsHAoVNokdX
        4lh38TXGm7SqS/zspd3klWAQgnHHP40R
X-Google-Smtp-Source: ABdhPJyqHPdgq8S4hLurFiV4lL9bNkynd1PfhteJYa/nbrUL0vbFOgqjaRl4qN9PHYcp8VbGQZJ7aQ==
X-Received: by 2002:a05:6830:1e9c:b0:5cd:8c15:5799 with SMTP id n28-20020a0568301e9c00b005cd8c155799mr1048635otr.265.1648559972499;
        Tue, 29 Mar 2022 06:19:32 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id ay5-20020a056820150500b00320f8a179d0sm7303530oob.30.2022.03.29.06.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 06:19:32 -0700 (PDT)
Message-ID: <5ca04e86-6c61-3d4e-88a0-a3c827e19e13@github.com>
Date:   Tue, 29 Mar 2022 09:19:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] mv: refresh stat info for moved entry
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     reichemn@icloud.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>
References: <pull.1187.git.1648173419533.gitgitgadget@gmail.com>
 <pull.1187.v2.git.1648516027925.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1187.v2.git.1648516027925.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/28/2022 9:07 PM, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>
> 
> Update the stat info of the moved index entry in 'rename_index_entry_at()'
> if the entry is up-to-date with the index. Internally, 'git mv' uses
> 'rename_index_entry_at()' to move the source index entry to the destination.
> However, it directly copies the stat info of the original cache entry, which
> will not reflect the 'ctime' of the file renaming operation that happened as
> part of the move. If a file is otherwise up-to-date with the index, that
> difference in 'ctime' will make the entry appear out-of-date until the next
> index-refreshing operation (e.g., 'git status').
> 
> Some commands, such as 'git reset', use the cached stat information to
> determine whether a file is up-to-date; if this information is incorrect,
> the command will fail when it should pass. In order to ensure a moved entry
> is evaluated as 'up-to-date' when appropriate, refresh the destination index
> entry's stat info in 'git mv' if and only if the file is up-to-date.
> 
> Note that the test added in 't7001-mv.sh' requires a "sleep 1" to ensure the
> 'ctime' of the file creation will be definitively older than the 'ctime' of
> the renamed file in 'git mv'.

Unfortunate that this is necessary, but it seems to be the only way
to handle this because of the interaction with the system clock and
the filesystem. There are several sleeps like this in
t1701-racy-split-index.sh, for example.

>  void rename_index_entry_at(struct index_state *istate, int nr, const char *new_name)
>  {
> -	struct cache_entry *old_entry = istate->cache[nr], *new_entry;
> +	struct cache_entry *old_entry = istate->cache[nr], *new_entry, *refreshed;
>  	int namelen = strlen(new_name);
>  
>  	new_entry = make_empty_cache_entry(istate, namelen);
> @@ -147,7 +147,20 @@ void rename_index_entry_at(struct index_state *istate, int nr, const char *new_n
>  	cache_tree_invalidate_path(istate, old_entry->name);
>  	untracked_cache_remove_from_index(istate, old_entry->name);
>  	remove_index_entry_at(istate, nr);
> -	add_index_entry(istate, new_entry, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
> +
> +	/*
> +	 * Refresh the new index entry. Using 'refresh_cache_entry' ensures
> +	 * we only update stat info if the entry is otherwise up-to-date (i.e.,
> +	 * the contents/mode haven't changed). This ensures that we reflect the
> +	 * 'ctime' of the rename in the index without (incorrectly) updating
> +	 * the cached stat info to reflect unstaged changes on disk.
> +	 */
> +	refreshed = refresh_cache_entry(istate, new_entry, CE_MATCH_REFRESH);
> +	if (refreshed && refreshed != new_entry) {
> +		add_index_entry(istate, refreshed, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
> +		discard_cache_entry(new_entry);

I'm glad you're checking that both refreshed is non-NULL and not equal
to new_entry. Both are possible results from refresh_cache_entry().

> +test_expect_success 'mv -f refreshes updated index entry' '
> +	echo test >bar &&
> +	git add bar &&
> +	git commit -m test &&
> +
> +	echo foo >foo &&
> +	git add foo &&
> +
> +	# Wait one second to ensure ctime of rename will differ from original
> +	# file creation ctime.
> +	sleep 1 &&
> +	git mv -f foo bar &&
> +	git reset --merge HEAD &&
> +
> +	# Verify the index has been reset
> +	git diff-files >out &&
> +	test_must_be_empty out
> +'
> +

New test looks good.

Thanks,
-Stolee
