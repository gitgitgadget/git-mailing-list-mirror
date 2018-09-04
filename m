Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89C941F404
	for <e@80x24.org>; Tue,  4 Sep 2018 12:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeIDRBN (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 13:01:13 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:35029 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbeIDRBM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 13:01:12 -0400
Received: by mail-qk1-f179.google.com with SMTP id f62-v6so503402qke.2
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 05:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0kB1JVsKbWai7nwSZqgu31Cl8IcIAhQezSJ6x6oKO4k=;
        b=r//+QeCIL6T6StZrU7RsilcS30YE62/rnKGmi15Q6xqLzMu2ahV3nS9ZS+PdxgNyKX
         R3UCOciWRzyrui8KtJJ5o4JVOgB/fag/p+W33IWuTpSjSViHgaKxdB444XwTOPdazkPt
         JW6jrGRvtpFR0HyxBvp3mpYK8014EnM5+uP/nFAAW9kTGGchQWGZ8pZ15euF69r8hoTf
         Gf0xwu9rz5qUBmBmbx59jXE7Q+LS8cy3VPYdmYTJa3AKCfAAvW76Iqi5Ic07YUo65xHO
         fN9CCkJIszsVjhUGKTvPlrIJ4utsMSLu4HT+z7uQHJV8sbcmB6Tj2I7BYGebdwwuFaOE
         7wBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0kB1JVsKbWai7nwSZqgu31Cl8IcIAhQezSJ6x6oKO4k=;
        b=Q6NUsG6oEs3iAB1oRGdXvqciph4S3zR0ra0KGIWYsCnWp2Ihm2+N+mPkh1ddnTfDe9
         fD0RIRuMQ+LiesI+UUYHu7q5k1fBOHkALb4SOiK6MKCIKwNBKzldBT7vLqS9SWYVDbYt
         dC83yrxQYmjCzPsx4Q7m+pr5Hd25+We8MDXBU0wNuOUPudZDTfuMOBD7lGupHHoTgd7Y
         JhIFJpZAzhaMsUMPHqULilgmjfVZgxjZLZQIhiGitwFzah43nQjCHIig+ie/x9ov8EIM
         ZezThpi1WtWCSt+LKd06hgEhfBUqftaIFG+y0FFMg7kW8ov6R80mST9ZAf76ds/KP7ed
         7L8g==
X-Gm-Message-State: APzg51DdqoA5Ka5FQi2h3poJaYkOmf7/pPyX40Huzdu2Coy79nCaCmOZ
        waQcBu2K+RzIFkAf8UWWW7c=
X-Google-Smtp-Source: ANB0VdbR0MkE8iaynTk+b0R2MrHXLSs127Zl8EEDgsbwmbheQUHzvf4S4WF8yU+CYVMSxZNCjYXFqQ==
X-Received: by 2002:a37:6512:: with SMTP id z18-v6mr28488385qkb.269.1536064574935;
        Tue, 04 Sep 2018 05:36:14 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:e5f5:1735:3a0e:1f6? ([2001:4898:8010:0:cf2b:1735:3a0e:1f6])
        by smtp.gmail.com with ESMTPSA id n41-v6sm14145868qtn.73.2018.09.04.05.36.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 05:36:14 -0700 (PDT)
Subject: Re: [PATCH v4 12/12] t5318: use test_oid for HASH_LEN
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>
References: <20180903232515.336397-1-sandals@crustytoothpaste.net>
 <20180903232515.336397-13-sandals@crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8af735dc-99cd-f297-415f-24e53ea77344@gmail.com>
Date:   Tue, 4 Sep 2018 08:36:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180903232515.336397-13-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/3/2018 7:25 PM, brian m. carlson wrote:
> From: Derrick Stolee <stolee@gmail.com>
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>   t/t5318-commit-graph.sh | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 3c1ffad491..d286516f0e 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -8,7 +8,8 @@ test_expect_success 'setup full repo' '
>   	cd "$TRASH_DIRECTORY/full" &&
>   	git init &&
>   	git config core.commitGraph true &&
> -	objdir=".git/objects"
> +	objdir=".git/objects" &&
> +	test_oid_init
>   '

Ah yes, thanks for adding this.

>   
>   test_expect_success 'verify graph with no graph file' '
> @@ -273,7 +274,7 @@ test_expect_success 'git commit-graph verify' '
>   
>   NUM_COMMITS=9
>   NUM_OCTOPUS_EDGES=2
> -HASH_LEN=20
> +HASH_LEN="$(test_oid rawsz)"
>   GRAPH_BYTE_VERSION=4
>   GRAPH_BYTE_HASH=5
>   GRAPH_BYTE_CHUNK_COUNT=6
