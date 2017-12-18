Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CDB11F424
	for <e@80x24.org>; Mon, 18 Dec 2017 23:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936309AbdLRXnN (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 18:43:13 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:36051 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934965AbdLRXnM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 18:43:12 -0500
Received: by mail-it0-f46.google.com with SMTP id d16so729279itj.1
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 15:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KJBSVCXg7Cpu2N529Ur+Ss7nI9Bo8IXJZ4qoZaPR6nQ=;
        b=IMTwRlpudkSV492Y9nTxhNI7QWrL16Do+DiwFNoxrIMS9zz2M+rR967EN7H1DQwt5k
         R/AJ3AZO0yazdtjDbVzgA14WvQgDzfNTGFOZ1U7Shay8IH0CbP+kQleSs8GL2l606Pbo
         +TsGE7i3bubp7NdbOsvN/OuCgtdxig3LS4dKK62M/BoqRqG05EOX5GLgSzpNYS6AfEcU
         kPC7n3iqLxhCkGMQFUdfsbi9Lzp2Y5PrY+xYBmneR/cpQlyVORFZJVMr2S4xHdARCje3
         YyoTr2C9bp7fbSUnCvrVuvpR4sHp/cMA915ZVvwadTfYqBLBXSDuuRa7s9QpHthvCetX
         askg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KJBSVCXg7Cpu2N529Ur+Ss7nI9Bo8IXJZ4qoZaPR6nQ=;
        b=N56hkVs4XjPRrll+3bDux527cLE75Bd+vk9b1l/vlZ1W0hLO2XHXRnnpu2wsomes7G
         ovXXAUwovBASd38VUK+LmOZo6yi/JScGDNORFEX9ZqhyT637Mb90uAP03PYV9p2xpJAe
         BRYHtvjTuiCwrj3H/f148va5fUxq118kZYXcSzA///m1mW3nggyhXdmJsW3OzK0wAFTk
         l2uxfxyRI6oOzHRqFbJoIgvLc6D0ImIeraHXdy/z9x6KSuvXFdEcJjHcnnvmlEWUIZId
         nG5r5RUb97O080Bv50ggcynWbxRldQ1qfCAxYhBbQ/5DcDmjYyI529m6Y7Tjl+3et+0U
         vv9A==
X-Gm-Message-State: AKGB3mJFSzWu4neknv+8Q8yqRk2hbYkWAQivqc+GxG5hL07S3dckT0X0
        sP2alpos6eZ+0rtjdfTbgwwTEA==
X-Google-Smtp-Source: ACJfBotOtd4fy/s7/uTxRMfMw9StTAUZdHWrVM0dkqpxWeaCtz8CSZhQ7p5AImRtnBxeALop+CWafw==
X-Received: by 10.36.127.198 with SMTP id r189mr1021134itc.116.1513640591564;
        Mon, 18 Dec 2017 15:43:11 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:1883:9083:6c1f:dfbe])
        by smtp.gmail.com with ESMTPSA id g1sm271542itg.10.2017.12.18.15.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Dec 2017 15:43:11 -0800 (PST)
Date:   Mon, 18 Dec 2017 15:43:10 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [FYI PATCH] t/helper/test-lazy-name-hash: fix compilation
Message-Id: <20171218154310.aa62ea2c9f094b663393556e@google.com>
In-Reply-To: <20171218214947.210042-1-sbeller@google.com>
References: <20171218214947.210042-1-sbeller@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 18 Dec 2017 13:49:47 -0800
Stefan Beller <sbeller@google.com> wrote:

> I was compiling origin/master today with stricter compiler flags today
> and was greeted by
> 
> t/helper/test-lazy-init-name-hash.c: In function ‘cmd_main’:
> t/helper/test-lazy-init-name-hash.c:172:5: error: ‘nr_threads_used’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>      printf("avg [size %8d] [single %f] %c [multi %f %d]\n",
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          nr,
>          ~~~
>          (double)avg_single/1000000000,
>          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          (avg_single < avg_multi ? '<' : '>'),
>          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          (double)avg_multi/1000000000,
>          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          nr_threads_used);
>          ~~~~~~~~~~~~~~~~
> t/helper/test-lazy-init-name-hash.c:115:6: note: ‘nr_threads_used’ was declared here
>   int nr_threads_used;
>       ^~~~~~~~~~~~~~~
> 
> I do not see how we can arrive at that line without having `nr_threads_used`
> initialized, as we'd have `count > 1`  (which asserts that we ran the
> loop above at least once, such that it *should* be initialized).

Your analysis makes sense. (The compiler probably couldn't detect it because
"count" is a static variable, not a local variable.)

> --- a/t/helper/test-lazy-init-name-hash.c
> +++ b/t/helper/test-lazy-init-name-hash.c
> @@ -112,7 +112,7 @@ static void analyze_run(void)
>  {
>  	uint64_t t1s, t1m, t2s, t2m;
>  	int cache_nr_limit;
> -	int nr_threads_used;
> +	int nr_threads_used = 0;
>  	int i;
>  	int nr;

I agree that this is probably the best way to fix it. Another way might
be to omit printing out the number of threads used in the printf that
prints the average statistics.

The best way is probably to not use so many global variables, but that
is out of scope of this change.
