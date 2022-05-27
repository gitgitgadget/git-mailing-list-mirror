Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B0FC433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 15:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353707AbiE0PwE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 11:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiE0Pvp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 11:51:45 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A7213B8F3
        for <git@vger.kernel.org>; Fri, 27 May 2022 08:51:44 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id bo5so4674388pfb.4
        for <git@vger.kernel.org>; Fri, 27 May 2022 08:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6v1eOTxMXdIgHR6tTNOWnem0WKHijgB954VZBXPHy/4=;
        b=WYn7m9KVRgmNkK3evLx2jwP28mg/jl4uR1bIJ+EdQpDfzjJSuQJLxPjCMxRKocKvMk
         ZnLit9mkpJOf3lx5cUXCFzIssB6uSnl8lVWYS6jb4ztrFElZAQmp42NZQo9FBt4cjZAS
         mx74in9kDxlNB4rIKHXEZ9a5HR1ZjreIZzDVPgjrPbr7t3ZeBGn2aj94/ShRt33XpIcN
         wWpqaYhDhrsn95YUVomry76YnUt863hPXVd6asc0d60shgY7fwNwW7cUukWTdFqCWK8+
         NN5PCGqlUaal6LcJaKfV/UY0Dd++H7RagO5b+q97NdtXQXAOdpDwceBFxd+pIji/9rHU
         l8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6v1eOTxMXdIgHR6tTNOWnem0WKHijgB954VZBXPHy/4=;
        b=fHUo+Axov2pfO7gJOLMFExAwePsLNGkVhfnaugVrkQQ6gnt7RDpsf3tVGOcioRRRfP
         Sgwwc+1k5mTyojal3BwHnXUKXlHlCxI8sJcKuyO+mFASZAsVmF8t6Oi8MvrenWnQaQoF
         UMpyOUxpJDynNN4G95DcfFvOxwIytVcG31NousuuAnZhaPG8DcpHT7xAMgdy6N4xERH4
         5meFcBAQ0n2amegnnaIDfpdYRUz1f/9OiCMlcKzz/bPsbhJm3jDKMCRDFbqC9gKQtIIZ
         ePHXSIttKFeFAb4tOBHP4ogC+bqDwKnok2kc1N/dbCjuLKtzrwMu5f69z4X3ynxYtKP9
         yHHg==
X-Gm-Message-State: AOAM532PYEjy5KZrpLnuQqcaXxmj0P/gdJVjYqzC2yAql3ycuAca7PGn
        1nNM5KwHuZ1+EBW5kH5A0Ozd
X-Google-Smtp-Source: ABdhPJyOAKnLNMKL3dbK30uQ6yObzTD2CTsnmQAudHz847h4nhALjB7fYXC15Wokg6Gig5qlGrlTBQ==
X-Received: by 2002:a63:e049:0:b0:3fa:5e1c:c943 with SMTP id n9-20020a63e049000000b003fa5e1cc943mr21167441pgj.288.1653666703709;
        Fri, 27 May 2022 08:51:43 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id c1-20020a63d501000000b003c14af50631sm3632741pgg.73.2022.05.27.08.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 08:51:43 -0700 (PDT)
Message-ID: <bd079b1b-d5a6-3191-3517-cb6329cc1e55@github.com>
Date:   Fri, 27 May 2022 08:51:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [WIP v2 1/5] t7002: add tests for moving out-of-cone
 file/directory
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com, gitster@pobox.com, newren@gmail.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-1-shaoxuan.yuan02@gmail.com>
 <20220527100804.209890-2-shaoxuan.yuan02@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20220527100804.209890-2-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan wrote:
> Add corresponding tests to test following situations:
> 
> * 'refuse to move out-of-cone directory without --sparse'
> * 'can move out-of-cone directory with --sparse'
> * 'refuse to move out-of-cone file without --sparse'
> * 'can move out-of-cone file with --sparse'
> * 'refuse to move sparse file to existing destination'
> * 'move sparse file to existing destination with --force and --sparse'
> 
> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
>  t/t7002-mv-sparse-checkout.sh | 98 +++++++++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 
> diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
> index 1d3d2aca21..963cb512e2 100755
> --- a/t/t7002-mv-sparse-checkout.sh
> +++ b/t/t7002-mv-sparse-checkout.sh
> @@ -206,4 +206,102 @@ test_expect_success 'refuse to move file to non-skip-worktree sparse path' '
>  	test_cmp expect stderr
>  '
>  

Apologies in advance for adding more comments (after I said the last version
looked good)! I'm always learning things about Git, so hopefully my
suggestions are at least better than in my last review. :) 

> +test_expect_failure 'refuse to move out-of-cone directory without --sparse' '
> +	git sparse-checkout disable &&
> +	git reset --hard &&
> +	mkdir folder1 &&
> +	touch folder1/file1 &&
> +	git add folder1 &&
> +	git sparse-checkout init --cone &&

Note that 'init' is now deprecated [1] (I think that happened between your
v1 and now, FWIW). You can use 'git sparse-checkout set --cone sub', to do
the same thing as this + the subsequent line.

[1] https://lore.kernel.org/git/9d96da855ea70e7e8a54bb68e710cc60a2f50376.1639454952.git.gitgitgadget@gmail.com/

> +	git sparse-checkout set sub &&
> +

While the tests don't automatically "reset" between them (and therefore, you
don't need to disable & re-enable sparse-checkout), I like that you're
explicitly clearing & re-establishing the sparse-checkout state! It makes
selectively running tests *much* easier and generally avoids hand-to-see
side effects from prior tests.

As for test content, this particular setup block is (almost) identically
repeated in all of the tests. You could pull that into functions to reduce
duplication, e.g.:

setup_sparse_checkout () {
	mkdir folder1 &&
	touch folder1 &&
	git add folder1 &&
	git sparse-checkout set --cone sub
}

cleanup_sparse_checkout () {
	git sparse-checkout disable &&
	git reset --hard
}

You may want to consider using "test_when_finished <some cleanup function>"
to clean up each one *at the end* of the test, rather than the beginning of
the next one. E.g.:

test_expect_failure 'refuse to move out-of-cone directory without --sparse' '
	test_when_finished "cleanup_sparse_checkout" &&
	setup_sparse_checkout &&

	# ...the rest of the test
'

> +	test_must_fail git mv folder1 sub 2>stderr &&
> +	cat sparse_error_header >expect &&
> +	echo folder1/file1 >>expect &&
> +	cat sparse_hint >>expect &&
> +	test_cmp expect stderr
> +'
> +
> +test_expect_failure 'can move out-of-cone directory with --sparse' '
> +	git sparse-checkout disable &&
> +	git reset --hard &&
> +	mkdir folder1 &&
> +	touch folder1/file1 &&
> +	git add folder1 &&
> +	git sparse-checkout init --cone &&
> +	git sparse-checkout set sub &&
> +
> +	git mv --sparse folder1 sub 1>actual 2>stderr &&
> +	test_must_be_empty stderr &&
> +
> +	git sparse-checkout reapply &&
> +	test_path_is_dir sub/folder1 &&
> +	test_path_is_file sub/folder1/file1
> +'
> +
> +test_expect_failure 'refuse to move out-of-cone file without --sparse' '
> +	git sparse-checkout disable &&
> +	git reset --hard &&
> +	mkdir folder1 &&
> +	touch folder1/file1 &&
> +	git add folder1 &&
> +	git sparse-checkout init --cone &&
> +	git sparse-checkout set sub &&
> +
> +	test_must_fail git mv folder1/file1 sub 2>stderr &&
> +	cat sparse_error_header >expect &&
> +	echo folder1/file1 >>expect &&
> +	cat sparse_hint >>expect &&
> +	test_cmp expect stderr
> +'
> +
> +test_expect_failure 'can move out-of-cone file with --sparse' '
> +	git sparse-checkout disable &&
> +	git reset --hard &&
> +	mkdir folder1 &&
> +	touch folder1/file1 &&
> +	git add folder1 &&
> +	git sparse-checkout init --cone &&
> +	git sparse-checkout set sub &&
> +
> +	git mv --sparse folder1/file1 sub 1>actual 2>stderr &&
> +	test_must_be_empty stderr &&
> +
> +	git sparse-checkout reapply &&
> +	! test_path_is_dir sub/folder1 &&
> +	test_path_is_file sub/file1
> +'
> +
> +test_expect_failure 'refuse to move sparse file to existing destination' '
> +	git sparse-checkout disable &&
> +	git reset --hard &&
> +	mkdir folder1 &&
> +	touch folder1/file1 &&
> +	touch sub/file1 &&
> +	git add folder1 sub/file1 &&
> +	git sparse-checkout init --cone &&
> +	git sparse-checkout set sub &&
> +
> +	test_must_fail git mv --sparse folder1/file1 sub 2>stderr &&
> +	echo "fatal: destination exists, source=folder1/file1, destination=sub/file1" >expect &&
> +	test_cmp expect stderr
> +'
> +
> +test_expect_failure 'move sparse file to existing destination with --force and --sparse' '
> +	git sparse-checkout disable &&
> +	git reset --hard &&
> +	mkdir folder1 &&
> +	touch folder1/file1 &&
> +	touch sub/file1 &&
> +	echo "overwrite" >folder1/file1 &&
> +	git add folder1 sub/file1 &&
> +	git sparse-checkout init --cone &&
> +	git sparse-checkout set sub &&
> +
> +	git mv --sparse --force folder1/file1 sub 2>stderr &&
> +	test_must_be_empty stderr &&
> +	echo "overwrite" >expect &&
> +	test_cmp expect sub/file1
> +'
> +
>  test_done

These tests clearly establish the behavior you want to implement for 'git
mv'. As in V1, nice work!
