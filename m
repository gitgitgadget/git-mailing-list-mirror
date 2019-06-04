Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AA991F462
	for <e@80x24.org>; Tue,  4 Jun 2019 21:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfFDVIB (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 17:08:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37743 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfFDVIB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 17:08:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id 22so170334wmg.2
        for <git@vger.kernel.org>; Tue, 04 Jun 2019 14:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8DqE48fRA4xlEgE1UoglcTn8Ss39BMNgYF4y5TmYzGM=;
        b=Lg2+od9pGbBji+mN9S3Sa0rS2Sf7aUnyHfFgqyYz4l9mpx3u/QjrbfPgRjFlN9lQwo
         7snm8mbf93OtBnjFc1UEdkUVHuVenqvLIsL2AwqLTcVy7dxFl/1BOmZsjTFbT5BEkh3m
         msEBgBRfQQVlkeyeVLCU7pFJpdEBWlcw0wQ06jQ+On9RKNBRnDPpS/Nx4a+E2b5NxVAg
         TH22Y3leHmVz48RtD/OLVd060bLEx7JtZirLuPUuoVgQ/fhb8NtyttPwuXwqYVeQsTAQ
         nyLvkEEorwqLBQIoSghbPpFC69kTDMHxVwEzgRaaRRrpm7iyrbYrxm4dIasZ4i/Grsm8
         r8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8DqE48fRA4xlEgE1UoglcTn8Ss39BMNgYF4y5TmYzGM=;
        b=FI0uB2SWngayJjSH01uoe7xwc4T6kZ4por2zmSPEySi7j/c8xBbOW/dskfXF0vVKZz
         V950FiOYwmFGNiMeD8bMu/Rdk08dCzr0Gcvv4Yc+Fb2oSzCFknXut7E7TY7aR2gIxnDP
         ZlqKfalEvZ8xj7uWW1A7lobw0qq+Nqv8MlJotg/cMSYVlPn5dxk6mFyLeth6J4RcdMuO
         yhhKPcYpyitK19hnWxJiyiImui6+g2pfAlQudjLQ2hJy+91otZ/Jr3h/kXCSsFGYZT47
         oluVvJi21BLTc0B59r4/5gNXaDFmKB7u3QjvD/7xpMdjrCtXxKKS7t9cn4bIGsX40Xth
         EwfQ==
X-Gm-Message-State: APjAAAWK2FRh84rXnMYHrVc8zQbaFU3pQNtmN/nV+gy5hV04bxeYh7hf
        dOi2rI57vIqV+23F7Pmv6Gs=
X-Google-Smtp-Source: APXvYqyM22vIkkKVFO33PgfeVid3uSGNNjZpj2UW7GDSGEyFg6RN6T572xSme58yr1hGO1Rj52vN4A==
X-Received: by 2002:a1c:8017:: with SMTP id b23mr19487098wmd.117.1559682478097;
        Tue, 04 Jun 2019 14:07:58 -0700 (PDT)
Received: from szeder.dev (x4dbe169e.dyn.telefonica.de. [77.190.22.158])
        by smtp.gmail.com with ESMTPSA id 3sm14341117wmj.21.2019.06.04.14.07.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 14:07:56 -0700 (PDT)
Date:   Tue, 4 Jun 2019 23:07:54 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        ben.humphreys@atlassian.com,
        Ben Humphreys <behumphreys@atlassian.com>
Subject: Re: [PATCH v2] merge-recursive: restore accidentally dropped setting
 of path
Message-ID: <20190604210754.GT951@szeder.dev>
References: <20190604072614.26885-1-newren@gmail.com>
 <20190604202750.3925-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190604202750.3925-1-newren@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 04, 2019 at 01:27:50PM -0700, Elijah Newren wrote:
> Changes since v1:
>   * Minor tweaks suggested by SZEDER

> diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
> index 09dfa8bd92..3fe2cd91dc 100755
> --- a/t/t6042-merge-rename-corner-cases.sh
> +++ b/t/t6042-merge-rename-corner-cases.sh
> @@ -411,6 +411,124 @@ test_expect_success 'disappearing dir in rename/directory conflict handled' '
>  	)
>  '
>  
> +# Test for basic rename/add-dest conflict, with rename needing content merge:
> +#   Commit O: a
> +#   Commit A: rename a->b, modifying b too
> +#   Commit B: modify a, add different b
> +
> +test_expect_success 'setup rename-with-content-merge vs. add' '
> +	test_create_repo rename-with-content-merge-and-add &&
> +	(
> +		cd rename-with-content-merge-and-add &&
> +
> +		test_seq 1 5 >a &&
> +		git add a &&
> +		git commit -m O &&
> +		git tag O &&
> +
> +		git checkout -b A O &&
> +		git mv a b &&
> +		test_seq 0 5 >b &&
> +		git add b &&
> +		git commit -m A &&
> +
> +		git checkout -b B O &&
> +		echo 6 >>a &&
> +		echo hello world >b &&
> +		git add a b &&
> +		git commit -m B
> +	)
> +'
> +
> +test_expect_success 'handle rename-with-content-merge vs. add' '
> +	(
> +		cd rename-with-content-merge-and-add &&
> +
> +		git checkout A^0 &&
> +
> +		test_must_fail git merge -s recursive B^0 >out &&
> +		test_i18ngrep "CONFLICT (rename/add)" out &&
> +
> +		git ls-files -s >out &&
> +		test_line_count = 2 out &&
> +		git ls-files -u >out &&
> +		test_line_count = 2 out &&
> +		# Also, make sure both unmerged entries are for "b"
> +		git ls-files -u b >out &&
> +		test_line_count = 2 out &&
> +		git ls-files -o >out &&
> +		test_line_count = 1 out &&
> +
> +		test_path_is_missing a &&
> +		test_path_is_file b &&
> +
> +		test_seq 0 6 >tmp &&
> +		git hash-object tmp >expect &&
> +		git rev-parse B:b >>expect &&
> +		git rev-parse >actual  \
> +			:2:b    :3:b   &&
> +		test_cmp expect actual &&
> +
> +		# Test that the two-way merge in b is as expected
> +		git cat-file -p :2:b >>ours &&
> +		git cat-file -p :3:b >>theirs &&
> +		>empty &&
> +		test_must_fail git merge-file \
> +			-L "HEAD" \
> +			-L "" \
> +			-L "B^0" \
> +			ours empty theirs &&
> +		test_cmp ours b

This one is OK.

> +	)
> +'
> +
> +test_expect_success 'handle rename-with-content-merge vs. add, merge other way' '
> +	(
> +		cd rename-with-content-merge-and-add &&
> +
> +		git reset --hard &&
> +		git clean -fdx &&
> +
> +		git checkout B^0 &&
> +
> +		test_must_fail git merge -s recursive A^0 >out &&
> +		test_i18ngrep "CONFLICT (rename/add)" out &&
> +
> +		git ls-files -s >out &&
> +		test_line_count = 2 out &&
> +		git ls-files -u >out &&
> +		test_line_count = 2 out &&
> +		# Also, make sure both unmerged entries are for "b"
> +		git ls-files -u b >out &&
> +		test_line_count = 2 out &&
> +		git ls-files -o >out &&
> +		test_line_count = 1 out &&
> +
> +		test_path_is_missing a &&
> +		test_path_is_file b &&
> +
> +		test_seq 0 6 >tmp &&
> +		git rev-parse B:b >expect &&
> +		git hash-object tmp >>expect &&
> +		git rev-parse >actual  \
> +			:2:b    :3:b   &&
> +		test_cmp expect actual &&
> +
> +		# Test that the two-way merge in b is as expected
> +		git cat-file -p :2:b >>ours &&
> +		git cat-file -p :3:b >>theirs &&
> +		>empty &&
> +		test_must_fail git merge-file \
> +			-L "HEAD" \
> +			-L "" \
> +			-L "A^0" \
> +			ours empty theirs &&
> +		git hash-object b >actual &&
> +		git hash-object ours >expect &&
> +		test_cmp ours b

Here, however, you only changed what test_cmp looks at, but still kept
the two 'git hash-object' invocations, and their output will never be
looked at.

> +	)
> +'
> +
>  # Test for all kinds of things that can go wrong with rename/rename (2to1):
>  #   Commit A: new files: a & b
>  #   Commit B: rename a->c, modify b
> -- 
> 2.22.0.rc3.1.gd51cc00994
> 
