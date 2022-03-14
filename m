Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEDCC433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 15:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242398AbiCNPHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 11:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242421AbiCNPHI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 11:07:08 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C7543AF8
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 08:05:58 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id n7so17617907oif.5
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 08:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oznlCgZDrLIB2tXYeMvXswJtbiZG0JYKRs9Qz9/ggXE=;
        b=SCh1Ttq/yWq85FE7bJ6hSjrKD60pS3uTgWFKXnZ+Uexa50ZeBvQQNVnO5mbBYPFlw/
         vmPm4nKrhAc6WbxGRDkRT2a8ZfkiELbCKqJ2Xc3GHyEQ+H271lfrpuI0SNMQbulJkV36
         dwB2owH3hAoI64JKVjJRSGhoiwpmv37O7o9b0hFg8QCbSslaMDEhIRVZKf5v97bxHLNp
         E9R4fVE0B3IlClfYizt4YRYD8+yqzz7vbPVzLkrxQUpeaNMEdFRBsmLZ1KdV7odA/1eg
         7fMMmiRgSTE8Gl2uZuDCUaOBc7COHFel3Z4rsY3/p+oM+Von5uq4fTXh1vORUXzZrHl2
         k42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oznlCgZDrLIB2tXYeMvXswJtbiZG0JYKRs9Qz9/ggXE=;
        b=rxUop28R6a+l7XLuhfXisOI/uiLfldrVEz9XL7dS03pkxgtuc3AtOrV6cideCe/VRg
         pCihy+Mr19ES+aBzturev5fzBRmiq4djRm80dZmalHnElMXAiMm1zJelCl24P8VYcciu
         +gpN9Ny/EwU9lTcKn13LRyzf0ehd+LREalUhTwBdWujH+N7krfXjGf5p3PUAuJDAGZw3
         zzCTTVxJTTiLMmzZFbNv+HXI2Un7NNZ+JxRdATiZENLm1GhYRsQb2k7MPjlce5TyrlcA
         IhCCaHL/Xn6wAfpqh8FxnRR5RO53FTE5hpwRq1fVdW9DiaRYnOsMUyxIy/5j9T8VVl9Z
         g56Q==
X-Gm-Message-State: AOAM532cqFVgUYwuWeyZOUhxM7ZSWJeV4jTKz1c2UQ7KUiYonlsUXLe6
        sTvhi2G/+vwj1XEzKwdrWtUP
X-Google-Smtp-Source: ABdhPJxhY7VQxrEYcJp8bJHYFNqzY9Qk0SQIXvaUlrsKnf74eHjBriRle4IMWPckfMUX1bNjjZ6/jQ==
X-Received: by 2002:a05:6808:188a:b0:2da:5026:3663 with SMTP id bi10-20020a056808188a00b002da50263663mr14795124oib.79.1647270357223;
        Mon, 14 Mar 2022 08:05:57 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id t21-20020a9d7495000000b005c933cbc964sm5403648otk.5.2022.03.14.08.05.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 08:05:56 -0700 (PDT)
Message-ID: <fac1f57c-1bb8-2458-91ce-db5cb55f2e7d@github.com>
Date:   Mon, 14 Mar 2022 11:05:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/5] reset: introduce --[no-]refresh option to --mixed
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>
References: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
 <bda93703013e3576101079d6aa4b821ae4c73fb7.1647043729.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <bda93703013e3576101079d6aa4b821ae4c73fb7.1647043729.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/11/2022 7:08 PM, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>
> 
> Add a new --[no-]refresh option that is intended to explicitly determine
> whether a mixed reset should end in an index refresh.
> 
> A few years ago, [1] introduced behavior to the '--quiet' option to skip the
...
> [1] 9ac8125d1a (reset: don't compute unstaged changes after reset when
>     --quiet, 2018-10-23)

I believe convention would normally have this listing of the commit in-line
with your discussion of it. The "[1]" probably works, too, but I can't say
that I've seen that used except for URLs. Something like:

  Starting at <commit>, the '--quiet' option skips refresh_index()...

> call to 'refresh_index(...)' at the end of a mixed reset with the goal of
> improving performance. However, by coupling behavior that modifies the index
> with the option that silences logs, there is no way for users to have one
> without the other (i.e., silenced logs with a refreshed index) without
> incurring the overhead of a separate call to 'git update-index --refresh'.
> Furthermore, there is minimal user-facing documentation indicating that
> --quiet skips the index refresh, potentially leading to unexpected issues
> executing commands after 'git reset --quiet' that do not themselves refresh
> the index (e.g., internals of 'git stash', 'git read-tree').
> 
> To mitigate these issues, '--[no-]refresh' and 'reset.refresh' are
> introduced to provide a dedicated mechanism for refreshing the index. When
> either is set, '--quiet' and 'reset.quiet' revert to controlling only
> whether logs are silenced and do not affect index refresh.

Well motivated change.

> +test_index_refreshed () {
> +
> +	# To test whether the index is refresh, create a scenario where a
> +	# command will fail if the index is *not* refreshed:
> +	#   1. update the worktree to match HEAD & remove file2 in the index
> +	#   2. reset --mixed to unstage the change from step 1
> +	#   3. read-tree HEAD~1 (which differs from HEAD in file2)
> +	# If the index is refreshed in step 2, then file2 in the index will be
> +	# up-to-date with HEAD and read-tree will succeed (thus failing the
> +	# test). If the index is *not* refreshed, however, the staged deletion
> +	# of file2 from step 1 will conflict with the changes from the tree read
> +	# in step 3, resulting in a failure.
> +
> +	# Step 0: start with a clean index
> +	git reset --hard HEAD &&
> +
> +	# Step 1
> +	git rm --cached file2 &&
> +
> +	# Step 2
> +	git reset $1 --mixed HEAD &&
> +
> +	# Step 3
> +	git read-tree -m HEAD~1
> +}
> +
>  test_expect_success '--mixed refreshes the index' '
> -	cat >expect <<-\EOF &&
> -	Unstaged changes after reset:
> -	M	file2
> -	EOF
> -	echo 123 >>file2 &&
> -	git reset --mixed HEAD >output &&
> -	test_cmp expect output
> +	# Verify default behavior (with no config settings or command line
> +	# options)
> +	test_index_refreshed &&
> +'

It looks like this test ends with an &&. There's also a missing newline
after the test.

> +test_expect_success '--mixed --[no-]quiet sets default refresh behavior' '
> +	# Verify that --[no-]quiet and `reset.quiet` (without --[no-]refresh)
> +	# determine refresh behavior
> +
> +	# Config setting
> +	test_must_fail test_index_refreshed -c reset.quiet=true &&

This is failing, but not for the reason you want: It is running

	git reset -c --mixed HEAD

and failing to parse the "-c", I bet.

Perhaps you want to have two arguments: one for config settings
and another for arguments, meaning your call in test_index_refreshed
should be

	git $1 reset $2 --mixed HEAD

and calls like this should be

	test_index_refreshed "-c reset.quiet=true" "" &&

> +	test_index_refreshed -c reset.quiet=true &&
> +
> +	# Command line option
> +	test_must_fail test_index_refreshed --quiet &&
> +	test_index_refreshed --no-quiet &&

If you take a change like I recommend above, these would be

	test_index_refreshed "" --no-quiet &&

Thanks,
-Stolee
