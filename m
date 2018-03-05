Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E076D1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 12:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934958AbeCEMtC (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 07:49:02 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:50181 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934287AbeCEMs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 07:48:57 -0500
Received: by mail-wm0-f52.google.com with SMTP id w128so15621097wmw.0
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 04:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hc/tyxzHglcAbQiP9pOM4ShsmryEOgH+risdZeiaxmg=;
        b=gIXXL7YEaU99qJPfsSMSYX0lgw3jmYUnM+jTCwZ79wmtiTFnT1aUW599leqvwbHaWg
         gaQSiUEUgaxcDFGBVun7RCPfGdfkEXEvDVqsap9x1EXjHtmZxF297B04yPy0vhK/kC8K
         jYbP0UHnsxsouACYsjq9I+ZR78dxWDjyL1JSJK8/bJHNn+qUjcrkNLUGz1D6tMNF4Ubh
         u/7A/oyev/Pfq2vsJ+ycl8TDNhhOiw5AkRRyMOxHff5XsfvF4Bkd0F1QlBmo+mEnmXSM
         f4m8Igh1jno0TfYeYK5JuzRgO9QvYufe0fGiazLwezagMGHbP7mmTttd2qTjQNcAqXbP
         ifwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hc/tyxzHglcAbQiP9pOM4ShsmryEOgH+risdZeiaxmg=;
        b=NwmnusUcM0TXcdJYNYCH/XHjRjq3zU+H5CkV+jOyFgadO0ijxvpFkpLOj0OKl6Fj61
         qr6vjmZaFer0AFPJkFdH7X9PoYNQeWqrQgpi1ZDOFIO6V/OubtthEFTSMP9OcxS5seGs
         N8yXM4mNWvsXdtuQz/1DF4Qd64tw6hxGk7vp4jg4xbRRt2FdixGgemSR1M3bBpQzE8mS
         1DVCCX08NIm5RPW5LjfVeTPk7iMZkr+tJCAHvbALWoHqcSM+vnj+oKMd3b8YXlhVx9oP
         Gj2F1L0q4Z/8p9zGcwZD8M/gcaHZkDVi937KDfyKu/sr+gymMU9ZF/y2XjUrDzWCEx4t
         yq3Q==
X-Gm-Message-State: AElRT7GZk+7j98Jd/lYDdLkm1l9PqfuM+/gNTBcnS9KxN+fUTocf+gwH
        0uuHR40z4sk6vS0eeHyy1lc=
X-Google-Smtp-Source: AG47ELsPgpp+j7hhMUphvBquRbwmJJgoMQRJrpJ+56oa5oIzRtKHhX0aKjwxo9yCVGva4bKg0UXBOA==
X-Received: by 10.28.69.93 with SMTP id s90mr8109886wma.29.1520254136117;
        Mon, 05 Mar 2018 04:48:56 -0800 (PST)
Received: from localhost.localdomain (x4db272cf.dyn.telefonica.de. [77.178.114.207])
        by smtp.gmail.com with ESMTPSA id q77sm8267170wme.41.2018.03.05.04.48.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Mar 2018 04:48:55 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t2028: fix minor error and issues in newly-added "worktree move" tests
Date:   Mon,  5 Mar 2018 13:48:48 +0100
Message-Id: <20180305124848.7272-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.2.512.g74dde89aed
In-Reply-To: <20180304052647.26614-1-sunshine@sunshineco.com>
References: <20180212094940.23834-1-pclouds@gmail.com> <20180304052647.26614-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Recently-added "git worktree move" tests include a minor error and a few
> small issues. Specifically:
> 
> * checking non-existence of wrong file ("source" instead of
>   "destination")
> 
> * unneeded redirect (">empty")
> 
> * unused variable ("toplevel")
> 
> * restoring a worktree location by means of a separate test somewhat
>   distant from the test which moved it rather than using
>   test_when_finished() to restore it in a self-contained fashion

There is one more issue in these tests.
 

> diff --git a/t/t2028-worktree-move.sh b/t/t2028-worktree-move.sh
> index 082368d8c6..d70d13dabe 100755
> --- a/t/t2028-worktree-move.sh
> +++ b/t/t2028-worktree-move.sh
> @@ -75,7 +75,7 @@ test_expect_success 'move worktree' '
>  	git worktree move source destination &&
>  	test_path_is_missing source &&
>  	git worktree list --porcelain | grep "^worktree.*/destination" &&
> -	! git worktree list --porcelain | grep "^worktree.*/source" >empty &&
> +	! git worktree list --porcelain | grep "^worktree.*/source" &&

The main purpose of this test script is to test the 'git worktree'
command, but these pipes hide its exit code.
Could you please save 'git worktree's output into an intermediate
file, and run 'grep' on the file's contents?

This also applies to two other tests in this test script.

>  	git -C destination log --format=%s >actual2 &&
>  	echo init >expected2 &&
>  	test_cmp expected2 actual2
> @@ -86,10 +86,10 @@ test_expect_success 'move main worktree' '
>  '
>  
>  test_expect_success 'move worktree to another dir' '
> -	toplevel="$(pwd)" &&
>  	mkdir some-dir &&
>  	git worktree move destination some-dir &&
> -	test_path_is_missing source &&
> +	test_when_finished "git worktree move some-dir/destination destination" &&
> +	test_path_is_missing destination &&
>  	git worktree list --porcelain | grep "^worktree.*/some-dir/destination" &&
>  	git -C some-dir/destination log --format=%s >actual2 &&
>  	echo init >expected2 &&
> @@ -100,10 +100,6 @@ test_expect_success 'remove main worktree' '
>  	test_must_fail git worktree remove .
>  '
>  
> -test_expect_success 'move some-dir/destination back' '
> -	git worktree move some-dir/destination destination
> -'
> -
>  test_expect_success 'remove locked worktree' '
>  	git worktree lock destination &&
>  	test_when_finished "git worktree unlock destination" &&
> -- 
> 2.16.2.660.g709887971b
> 
> 
