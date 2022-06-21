Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BF3C43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 21:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354083AbiFUV12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 17:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356538AbiFUV1O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 17:27:14 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BAE1145B
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 14:23:32 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id k14so2137234plh.4
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 14:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0MKfaVnsYCQ8fvHi+QUUUv8uU8hZ+msiIz/p01OhUPI=;
        b=Dy8AAgpNdT7HNtXdfNafA0JiHZ/r6Mc1wsxGRGVzuVIKLkR79M8VJnkDshtK+9nJ7c
         6dSV2K7NKUyjMJCEZdqeqmzCCkdmHJbMgE6TJ2Xc0MHZqaoFjZyfykD+C9rrfoAyeMV2
         BqVHEiF4oXuEJhdcDRP7qfQEJao1DSI8ndJEm3NWCVxo2LP6O07+PAw8jahUOUAILcPk
         caISIpUK0X3Uzk6G1kPcgBsmxI+4B2q2gaClMpd7Q8oB0bah4cVTtlPct57ttG0yu/pl
         LmGdQ143kTPkl0a+FI4QzyQsnGJt8rvK6m5x3yB6NuS3iD4CjZeVerBmPgfauKp65amP
         1BcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0MKfaVnsYCQ8fvHi+QUUUv8uU8hZ+msiIz/p01OhUPI=;
        b=vzMo3FlNBitcMoJ1ojbJGew+QD4ZPIAcM/qpOj3nES5ljHQnzcXaUtSX1BKfruN/mV
         YMFCvOQ6FumcU65pjSf9fumv8J54nQiO373VcpejXLIzIFw0BEqq7PE+T+bdjUnLe8sk
         SI+l2zrpJcYbNvQhLgqmQ8W7I/UYSAQ+I//e6xSxq3gEeqUxHf9EPaHy4RzVMLawU8RH
         X8szEW3iWttJnt+7+EDoe/PPItPtzJhVVYRE7QkeMTAyooAhI53FpTWpGRxi2sXIXS39
         T+kGRTRWwQHFQ0danEhB8PewRDTYQuqSqb/WzH3sIYKQOl+ROVgY8hwqSduHTtXcmT8w
         vpPQ==
X-Gm-Message-State: AJIora+5lfNw2il1U5unLE67p/XuLvfuVdWtpWNkb1S90beNyHQRbQjF
        9yVonxRLK+jokJd/HCmEOEx+QGmVYOxc
X-Google-Smtp-Source: AGRyM1vZUsOkhKVYOJM85GYLIjSGeOmwhvWZY9eKBn6yfQ5/1MKaG5iGZBaXVaBMfy8fvSF/j2403Q==
X-Received: by 2002:a17:90b:3849:b0:1e8:7f47:5dcd with SMTP id nl9-20020a17090b384900b001e87f475dcdmr45491959pjb.61.1655846611547;
        Tue, 21 Jun 2022 14:23:31 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id go22-20020a17090b03d600b001ec71be4145sm8950105pjb.2.2022.06.21.14.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 14:23:31 -0700 (PDT)
Message-ID: <adb795ba-56ce-8441-0c38-a3e6b0a6e861@github.com>
Date:   Tue, 21 Jun 2022 14:23:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [WIP v3 1/7] t7002: add tests for moving out-of-cone
 file/directory
Content-Language: en-US
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        newren@gmail.com
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220619032549.156335-1-shaoxuan.yuan02@gmail.com>
 <20220619032549.156335-2-shaoxuan.yuan02@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20220619032549.156335-2-shaoxuan.yuan02@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shaoxuan Yuan wrote:
> Add corresponding tests to test following situations:
> 
> We do not have sufficient coverage of moving files outside
> of a sparse-checkout cone. Create new tests covering this
> behavior, keeping in mind that the user can include --sparse
> (or not), move a file or directory, and the destination can
> already exist in the index (in this case user can use --force
> to overwrite existing entry).
> 
> Helped-by: Victoria Dye <vdye@github.com>
> Helped-by: Derrick Stolee <derrickstolee@github.com>
> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
>  t/t7002-mv-sparse-checkout.sh | 87 +++++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
> index f0f7cbfcdb..d6e7315a5a 100755
> --- a/t/t7002-mv-sparse-checkout.sh
> +++ b/t/t7002-mv-sparse-checkout.sh
> @@ -4,6 +4,18 @@ test_description='git mv in sparse working trees'
>  
>  . ./test-lib.sh
>  
> +setup_sparse_checkout () {
> +	mkdir folder1 &&
> +	touch folder1/file1 &&
> +	git add folder1 &&
> +	git sparse-checkout set --cone sub
> +}
> +
> +cleanup_sparse_checkout () {
> +	git sparse-checkout disable &&
> +	git reset --hard
> +}
> +
>  test_expect_success 'setup' "
>  	mkdir -p sub/dir sub/dir2 &&
>  	touch a b c sub/d sub/dir/e sub/dir2/e &&
> @@ -196,6 +208,7 @@ test_expect_success 'can move files to non-sparse dir' '
>  '
>  
>  test_expect_success 'refuse to move file to non-skip-worktree sparse path' '
> +	test_when_finished "cleanup_sparse_checkout" &&
>  	git reset --hard &&
>  	git sparse-checkout init --no-cone &&
>  	git sparse-checkout set a !/x y/ !x/y/z &&
> @@ -206,4 +219,78 @@ test_expect_success 'refuse to move file to non-skip-worktree sparse path' '
>  	test_cmp expect stderr
>  '
>  
> +test_expect_failure 'refuse to move out-of-cone directory without --sparse' '
> +	test_when_finished "cleanup_sparse_checkout" &&
> +	setup_sparse_checkout &&

The setup and cleanup approach looks good - thanks for updating it!

> +
> +	test_must_fail git mv folder1 sub 2>stderr &&
> +	cat sparse_error_header >expect &&
> +	echo folder1/file1 >>expect &&
> +	cat sparse_hint >>expect &&
> +	test_cmp expect stderr
> +'
> +
> +test_expect_failure 'can move out-of-cone directory with --sparse' '
> +	test_when_finished "cleanup_sparse_checkout" &&
> +	setup_sparse_checkout &&
> +
> +	git mv --sparse folder1 sub 1>actual 2>stderr &&
> +	test_must_be_empty stderr &&
> +
> +	git sparse-checkout reapply &&

You shouldn't need to run 'reapply' here (you remove it in Patch 7, but it
should probably be dropped here instead).

> +	test_path_is_dir sub/folder1 &&
> +	test_path_is_file sub/folder1/file1
> +'
> +
> +test_expect_failure 'refuse to move out-of-cone file without --sparse' '
> +	test_when_finished "cleanup_sparse_checkout" &&
> +	setup_sparse_checkout &&
> +
> +	test_must_fail git mv folder1/file1 sub 2>stderr &&
> +	cat sparse_error_header >expect &&
> +	echo folder1/file1 >>expect &&
> +	cat sparse_hint >>expect &&
> +	test_cmp expect stderr
> +'
> +
> +test_expect_failure 'can move out-of-cone file with --sparse' '
> +	test_when_finished "cleanup_sparse_checkout" &&
> +	setup_sparse_checkout &&
> +
> +	git mv --sparse folder1/file1 sub 1>actual 2>stderr &&
> +	test_must_be_empty stderr &&
> +
> +	git sparse-checkout reapply &&
> +	! test_path_is_dir sub/folder1 &&
> +	test_path_is_file sub/file1

You can also drop the 'reapply' here (same reason as above), but you'll also
probably need to drop the '! test_path_is_dir sub/folder1'. Based on some
rough testing of the command in its current state, 'git mv' doesn't delete a
directory if 'mv' the last remaining file in that directory. In this test,
the directory being deleted is a result of 'sparse-checkout reapply', not
'mv'.

> +'
> +
> +test_expect_failure 'refuse to move sparse file to existing destination' '
> +	test_when_finished "cleanup_sparse_checkout" &&
> +	mkdir folder1 &&
> +	touch folder1/file1 &&
> +	touch sub/file1 &&
> +	git add folder1 sub/file1 &&
> +	git sparse-checkout set --cone sub &&
> +
> +	test_must_fail git mv --sparse folder1/file1 sub 2>stderr &&
> +	echo "fatal: destination exists, source=folder1/file1, destination=sub/file1" >expect &&
> +	test_cmp expect stderr
> +'
> +
> +test_expect_failure 'move sparse file to existing destination with --force and --sparse' '
> +	test_when_finished "cleanup_sparse_checkout" &&
> +	mkdir folder1 &&
> +	touch folder1/file1 &&
> +	touch sub/file1 &&
> +	echo "overwrite" >folder1/file1 &&
> +	git add folder1 sub/file1 &&
> +	git sparse-checkout set --cone sub &&
> +
> +	git mv --sparse --force folder1/file1 sub 2>stderr &&
> +	test_must_be_empty stderr &&
> +	echo "overwrite" >expect &&
> +	test_cmp expect sub/file1
> +'
> +
>  test_done

