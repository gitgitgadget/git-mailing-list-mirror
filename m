Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 656521F404
	for <e@80x24.org>; Mon, 13 Aug 2018 11:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbeHMOG1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:06:27 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36258 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbeHMOG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:06:27 -0400
Received: by mail-qt0-f195.google.com with SMTP id t5-v6so16925280qtn.3
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 04:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pZTnSCmzHvo5l4b/QIt+nDOxGGzXG9EijidpEcGngIQ=;
        b=fWrzjd2dowjHc6xJjbdD05qzyc8VX7xRSyQzjt7+FmqZQ7zg8n0ksysWAfttAvvvzd
         D457ZLg4nCEv+yd8M5L1vJCEa/nSmSZg71YQzfj0kjIt6K/4KIBPs+M74+OcTEs3JzJi
         eFlzUOFuU6n93zJPoaXB8KUAFFsYUtDDUg34KaiCZYag0B/rKlGDGv8Qt0r1sl/p8dOS
         uanaAIDHlF4GGGZnzNQto94IgWdcKYSzZPJg0X5OlD+HBw5OpwkqFNyx56wuNkCKz6UA
         4rY4Caod+lHcwlLS2F/nHby5yD5N8JesnYjfTHMl7zpXHpVf1FNY9TG6072P6Z9dfmYQ
         ZmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pZTnSCmzHvo5l4b/QIt+nDOxGGzXG9EijidpEcGngIQ=;
        b=JIrJYP10M9xZSbDGCvUNxYOtD76z50QThA9KAoK1xk3biV/e2IewyNkkaZc7qXcwz6
         4DRLcLQ8KA2h3dsTJo5aC4yRJD+JTNSYgfHL/IRzq+PChfEUYvCPE7LQ5EjHF7i2NxgZ
         QZtxhWrtSaNwtQrRDxSS3GGOC0pp22nCyIbl2Ktf10jSYmcCKlI8swIElG2hDDZtfjxZ
         5UAo6jueaxc1suZIZdbxrush8Q4K5CqWjR8+Z4/HBoOdu6tlEJ6k5YGWNqYK/89ny0hE
         8d25WywilfDooxXeB6H3OUQ9qPn6x1W3xTKqLd9XPB3vBRq9ypKTBuOY7d69Fw8nmNQU
         +SvQ==
X-Gm-Message-State: AOUpUlFZD+4k6nGVDqRoPduMHggbdhcVU+hpaqiW7pnBjRwTWT/2/1sG
        pi1ODoqFlf8THFnrIZYMmZldjFWm
X-Google-Smtp-Source: AA+uWPxKG6junOACPJY/6GyKKuOz4MThjRuUVw4uQxbAHqy/COpv5G9HdVTKLHbw5ukolyaqWgi1TQ==
X-Received: by 2002:aed:21a9:: with SMTP id l38-v6mr16816503qtc.364.1534159476212;
        Mon, 13 Aug 2018 04:24:36 -0700 (PDT)
Received: from [172.16.101.16] ([216.253.28.6])
        by smtp.gmail.com with ESMTPSA id b20-v6sm7960164qto.1.2018.08.13.04.24.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 04:24:35 -0700 (PDT)
Subject: Re: [PATCH] t5318: use 'test_cmp_bin' to compare commit-graph files
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20180627132447.142473-22-dstolee@microsoft.com>
 <20180812201845.2923-1-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f07a0a8f-bf19-0895-e48c-4daa9246df98@gmail.com>
Date:   Mon, 13 Aug 2018 07:24:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180812201845.2923-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/12/2018 4:18 PM, SZEDER Gábor wrote:
> The commit-graph files are binary files, so they should not be
> compared with 'test_cmp', because that might cause issues on Windows,
> where 'test_cmp' is a shell function to deal with random LF-CRLF
> conversions.
>
> Use 'test_cmp_bin' instead.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>   t/t5318-commit-graph.sh | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 4f17d7701e..1c148ebf21 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -254,9 +254,9 @@ test_expect_success 'check that gc computes commit-graph' '
>   	git config gc.writeCommitGraph true &&
>   	git gc &&
>   	cp $objdir/info/commit-graph commit-graph-after-gc &&
> -	! test_cmp commit-graph-before-gc commit-graph-after-gc &&
> +	! test_cmp_bin commit-graph-before-gc commit-graph-after-gc &&
>   	git commit-graph write --reachable &&
> -	test_cmp commit-graph-after-gc $objdir/info/commit-graph
> +	test_cmp_bin commit-graph-after-gc $objdir/info/commit-graph
>   '
>   
>   # the verify tests below expect the commit-graph to contain

Thanks, Szeder! I didn't know about test_cmp_bin, and I appreciate you 
keeping up test hygiene.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
