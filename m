Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3AB11F428
	for <e@80x24.org>; Wed,  3 Jan 2018 01:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750865AbeACBSN (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 20:18:13 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:41176 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbeACBSM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 20:18:12 -0500
Received: by mail-wm0-f46.google.com with SMTP id g75so168557wme.0
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 17:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :signed-off-by:content-transfer-encoding;
        bh=Jtuztnp/jiKX12EbGtJ0ByTHmJp6XCXx9x6Ho6RZ3X0=;
        b=QBJt0qxyNS7zP6fnuzt4LYOh4jUxlhs2kLv+0an4Y/LPdHpDVTdaJ7SFxq/Q0NuazS
         fVHObfDgASzcBacwiNvC7gw48lZbTPi98Omg+AOQAV6GWYBO1fkW3s7crSGdb/Tylm8I
         HEZqSQh57+D9gjZ/7bgCXFF3lAGKOCaNa63x8YRxMOz5aZB3CoadxcI0AVsMu+dYWdsL
         jvtdY6KtOzp/sHrwnKY2DCwrdEVe2A5y6mWxo46dOD/8smkZMwHoYgqrySJ2BQRpIjFE
         4f/YlkPoDOhhLaI0v8HHslPxr/GUt/67VnwqHFGpN4GYdtowocXGU8YXHan2Zirz5wNX
         jcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:signed-off-by:content-transfer-encoding;
        bh=Jtuztnp/jiKX12EbGtJ0ByTHmJp6XCXx9x6Ho6RZ3X0=;
        b=U128oLEV13YK2zXBfsOvkyOnab1pXbrZdL8yiBi3ESHCqzZOV/+SVjDwlXTkKjSD87
         K++2cbOeziV8sxr6EmUMbc/rAZ55dvtxHl7i4AtQPyvPLa0WTWKw8wP5Gzosm6KkuY1u
         nUWtaA04pshJlBwy7ejc8DeinEB9rYZEiweQh20eAX1DrL1rdqvl/1AokM426375xLbF
         83FJBe6JArrgjjFQw9McZ4hwKDGZkk3j2kyLfsMcscnID5lv8ArSHr6Y7zAfqgvbAh+l
         1VTSa4MnGV48N2osZmh3DmdYOzlmX02xm2D+kjdPdrHFoMW8ZsdMqDJBNsyYq1LCd8s0
         vIEw==
X-Gm-Message-State: AKGB3mLpgqjAFNb2XgwdpRtlOnPbxC27c39C3Cu3vGULX1ohVMV47zre
        9yNK3HW5BqYzgWzUK3hDk40=
X-Google-Smtp-Source: ACJfBouVcifKFeH6miTVckoHqIsXHC2x4xIsFgEFYZ27ilm/pr1V/VqWFhAPR2l9vkFI/Q6H3UnOug==
X-Received: by 10.28.193.139 with SMTP id r133mr80558wmf.39.1514942291594;
        Tue, 02 Jan 2018 17:18:11 -0800 (PST)
Received: from localhost.localdomain (94-21-23-100.pool.digikabel.hu. [94.21.23.100])
        by smtp.gmail.com with ESMTPSA id 201sm60683wmm.38.2018.01.02.17.18.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jan 2018 17:18:11 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v5 04/34] directory rename detection: basic testcases
Date:   Wed,  3 Jan 2018 02:18:04 +0100
Message-Id: <20180103011804.13676-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.0.rc0.67.ge0c5f1248
In-Reply-To: <20171228041352.27880-5-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Signed-off-by: Elijah Newren <newren@gmail.com>
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> ---
>  t/t6043-merge-rename-directories.sh | 430 ++++++++++++++++++++++++++++++++++++

Many of the new tests added in this patch series perform a lot of checks
running 'test', which has the drawback to fail quietly, leaving us no
clue about which one of the several conditions failed and why.  We have
several test helper functions that check the same but provide a useful
error message if the condition were to fail.
Here are a couple of suggestions in one of the tests, but they are
applicable to many other tests in this patch series.

> +test_expect_failure '1d-check: Directory renames cause a rename/rename(2to1) conflict' '
> +	(
> +		cd 1d &&
> +
> +		git checkout A^0 &&
> +
> +		test_must_fail git merge -s recursive B^0 >out &&
> +		test_i18ngrep "CONFLICT (rename/rename)" out &&
> +
> +		test 8 -eq $(git ls-files -s | wc -l) &&
> +		test 2 -eq $(git ls-files -u | wc -l) &&
> +		test 3 -eq $(git ls-files -o | wc -l) &&

  git ls-files -s >out &&
  test_line_count = 8 out &&
  git ls-files -u >out &&
  test_line_count = 2 out &&
  git ls-files -o >out &&
  test_line_count = 3 out &&

> +
> +		git rev-parse >actual \
> +			:0:x/b :0:x/c :0:x/d :0:x/e :0:x/m :0:x/n &&
> +		git rev-parse >expect \
> +			O:z/b O:z/c O:y/d O:y/e A:y/m B:z/n &&
> +		test_cmp expect actual &&
> +
> +		test_must_fail git rev-parse :0:x/wham &&
> +		git rev-parse >actual \
> +			:2:x/wham :3:x/wham &&
> +		git rev-parse >expect \
> +			A:y/wham B:z/wham &&
> +		test_cmp expect actual &&
> +
> +		test ! -f x/wham &&

This one checks that the given path is not a file, therefore it would
succeed if that path were a directory or a FIFO or whatnot.  I believe
you want to check that the path doesn't exist:

  test_path_is_missing x/wham &&

> +		test -f x/wham~HEAD &&
> +		test -f x/wham~B^0 &&

  test_path_is_file x/wham~HEAD &&
  test_path_is_file x/wham~B^0 &&


> +
> +		git hash-object >actual \
> +			x/wham~HEAD x/wham~B^0 &&
> +		git rev-parse >expect \
> +			A:y/wham B:z/wham &&
> +		test_cmp expect actual
> +	)
> +'
