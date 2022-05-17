Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1B9C433EF
	for <git@archiver.kernel.org>; Tue, 17 May 2022 13:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245282AbiEQN2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 May 2022 09:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240106AbiEQN2K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 May 2022 09:28:10 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8D341F98
        for <git@vger.kernel.org>; Tue, 17 May 2022 06:28:09 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id z126so14526762qkb.2
        for <git@vger.kernel.org>; Tue, 17 May 2022 06:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tUoWir3d68QP0OU3niNDkjgBQR2J/+bnrw1rNR+6lCs=;
        b=eLsgeAPeY32y5oDpzLFcF+FOo1jKSpLiyUCuSIpfnJiEyD03zwANyX/WsQrwjLJ0oA
         tm3Z20BexsuW0uLr0yFI0MQ5LM2BpjpAK1UPbw8GL1NOWAMia6VQ3OtTiI0mE1ejQC4P
         uFQOVb4eNh4bDCqm1IEcx7cxmWsYwSc/jLDvroHFwGK4GbFXBNycMWEMhEr6t2gXy6Za
         sMvaLNr1gk4CvN1KQghebHzr8+/WohVKQ+s5wKfFTHXy6CLirjnnpzE0E86ITBvnIvay
         78kEFIGDI3mufLlPXJO2J90mLueYBzwvREt0ORg1q9FBv+nlAOs8R5mlzyL6F3YMTpS8
         zMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tUoWir3d68QP0OU3niNDkjgBQR2J/+bnrw1rNR+6lCs=;
        b=YhcvUYA5A48aUlIrJqCVKgkzjVw7MA5Ah6pixAPMLvLWAMowLoTATGRQyFMy/UtqNn
         JyxortABBnF/4eBoLzMfGllwUiblCjBwcyChq9C2TE5XXcV5OLjf7lgha6AuoshNQOrI
         ombMhUuUDAlTCeSZTrH4YXxib0Qp0Oe+48lB9kK8e2T7IgRD1d/IxaLT7XXJm1G0okRx
         rC49Qi0ufcVDCiyCbl8PVbXdO1RpV8mCbPnsaWed/+tKWEo16t2nYYTLREK1MDAsxro6
         hokirVFrsTqX9SBfA54DWaqECFU8HJsKLi0V5aYVvK42Z3kpf55U9QdmjgxHVaavSI3O
         99BQ==
X-Gm-Message-State: AOAM531qcCBa2wYI8HtDEhFWzgzbkag6ghCZY7/1YnolhDJ66v09nzDU
        ClppW1wkrtK+Ox+nmAMIgrzKLgFF+mIL
X-Google-Smtp-Source: ABdhPJyWkqbbZ7MkjF4cRBLRVr1+eetpBjowQ2+WdZww8mvdPNLzI17nw70nlXDljntxntDH4CtMjA==
X-Received: by 2002:a05:620a:1529:b0:69f:e354:c71f with SMTP id n9-20020a05620a152900b0069fe354c71fmr16263555qkk.375.1652794089093;
        Tue, 17 May 2022 06:28:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:d51:acba:6df0:5bea? ([2600:1700:e72:80a0:d51:acba:6df0:5bea])
        by smtp.gmail.com with ESMTPSA id v12-20020ac8748c000000b002f39b99f68bsm7575454qtq.37.2022.05.17.06.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 06:28:08 -0700 (PDT)
Message-ID: <f9f49c09-c566-6938-273d-56015ed14d4e@github.com>
Date:   Tue, 17 May 2022 09:28:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 8/8] sparse-checkout: integrate with sparse index
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
 <b8a349c6deeb4b970075629d0c292b2ae9f7d0d3.1652724693.git.gitgitgadget@gmail.com>
 <9191a98c-087a-39b9-cff3-eb7eccd198ea@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <9191a98c-087a-39b9-cff3-eb7eccd198ea@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/16/2022 4:38 PM, Victoria Dye wrote:
> Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>

>> +test_expect_success 'sparse index is not expanded: sparse-checkout' '
>> +	init_repos &&
>> +
>> +	ensure_not_expanded sparse-checkout set deep/deeper2 &&
>> +	ensure_not_expanded sparse-checkout set deep/deeper1 &&
>> +	ensure_not_expanded sparse-checkout set deep &&
>> +	ensure_not_expanded sparse-checkout add folder1 &&
>> +	ensure_not_expanded sparse-checkout set deep/deeper1 &&
>> +	ensure_not_expanded sparse-checkout set folder2 &&
>> +
>> +	# Demonstrate that the checks that "folder1/a" is a file
>> +	# do not cause a sparse-index expansion (since it is in the
>> +	# sparse-checkout cone).
>> +	echo >>sparse-index/folder2/a &&
>> +	git -C sparse-index add folder2/a &&
>> +
>> +	ensure_not_expanded sparse-checkout add folder1 &&
>> +
>> +	# Skip checks here, since deep/deeper1 is inside a sparse directory
>> +	# that must be expanded to check whether `deep/deeper1` is a file
>> +	# or not.
>> +	ensure_not_expanded sparse-checkout set --skip-checks deep/deeper1 &&
>> +	ensure_not_expanded sparse-checkout set
>> +'
>> +
> 
> These tests look good for ensuring sparsity is preserved, but it'd be nice
> to also have some "stress tests" of 'sparse-checkout (add|set)'. The purpose
> would be to make sure the index has the right contents for various types of
> pattern changes, e.g. running 'sparse-checkout (add|set) <path>', then
> verifying index contents with 'ls-files --sparse'. Paths might be:
> 
> - in vs. out of (current) cone
> - match an existing vs. nonexistent directory
> 
> etc.

I guess I was relying on tests added previously for the sparse index,
such as this one:

test_expect_success 'sparse-index contents' '
	init_repos &&

	git -C sparse-index ls-files --sparse --stage >cache &&
	for dir in folder1 folder2 x
	do
		TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
		grep "040000 $TREE 0	$dir/" cache \
			|| return 1
	done &&

	git -C sparse-index sparse-checkout set folder1 &&

	git -C sparse-index ls-files --sparse --stage >cache &&
	for dir in deep folder2 x
	do
		TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
		grep "040000 $TREE 0	$dir/" cache \
			|| return 1
	done &&

	git -C sparse-index sparse-checkout set deep/deeper1 &&

	git -C sparse-index ls-files --sparse --stage >cache &&
	for dir in deep/deeper2 folder1 folder2 x
	do
		TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
		grep "040000 $TREE 0	$dir/" cache \
			|| return 1
	done &&

	# Disabling the sparse-index replaces tree entries with full ones
	git -C sparse-index sparse-checkout init --no-sparse-index &&
	test_sparse_match git ls-files --stage --sparse
'

But this test isn't covering enough interesting cases that might
cause issues with the changes in this series. I'll add a patch that
increases coverage in this area.

Thanks,
-Stolee
