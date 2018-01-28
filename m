Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11ED11F404
	for <e@80x24.org>; Sun, 28 Jan 2018 20:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752537AbeA1Uak (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 15:30:40 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:42345 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752496AbeA1Uak (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jan 2018 15:30:40 -0500
Received: by mail-lf0-f50.google.com with SMTP id q17so7017367lfa.9
        for <git@vger.kernel.org>; Sun, 28 Jan 2018 12:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lwm/ATTvmesDUYoE560VkVu7NIpHyQDK9I4UY6kqJOI=;
        b=jAkD/78dq80i0v/Zrg7ZxiaqetzygVsqEVC2spMg6E+M/jYYL+fmTfEA8HjJdS44Kg
         9v2BavPOk9/9QrPQ2Ue3sn6KTURE6TouX4IKpEIckWFVGkco2Y7zqeyPakKM92ons3U7
         SHwYQ4wLCJiCbUZhgKWUnfoxY4hqzqBTLK3Z2lw8dxnQUvKCDFy09KR8fSg8qWhRpR9t
         TmM2J+2kHdn/XQ5cIjQqKeEEMTHV7TLg8QSnkPAuNtx65OepfHRm1CetbBMvSpnZB/pA
         +O+fWtgt2tt/TF418IGVTyyH71EFCF4VElSJ60LZlbusbQZfHj7QKzN5hfmnCHTJuPX+
         eCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lwm/ATTvmesDUYoE560VkVu7NIpHyQDK9I4UY6kqJOI=;
        b=kfNRbK7MDCSxkTz82Yp4n2yD9Eu1st6y4bhvQWYxuNXLNG+t5gYHhWePw1yFojlQkq
         s3j5wPaeTxVKE8fxn7pdOQ102VuFtBHCILRGa+0nuLAIvNhvUbPAkVPsoRQv5eOoEyGC
         xBmVHVrhi/aYLIVA9d5O1Z5zw6D/evWziMUYmTbPpgUEGNoHQKcecoIY0kyH4wWO+RLV
         q8coTbFWuLbj8RNQ+BF+yuBI8pamG29DaFAjOSSajlCQSfoxtwq/Meb+y2u8xkKDDbj6
         JVPLFo3/nqAO0EhJzpGDPzxW++0yvwMrN5ozp6kxEwkshFn2CVSsY37qQ1WQGWuHIeA8
         TRxg==
X-Gm-Message-State: AKwxytdFd8/5W2rI23CEMWj21VN3t50jSrIpt7+OJultOVwWffhGrTzT
        w9ER9S7abqISwiuwAK4dyZE=
X-Google-Smtp-Source: AH8x2268/vSvkABqCRGZwMB4I8HEWi0jIuVQENcEhdPdyV2IB1SCjR9nnS3Jxg6PE2ddiUQKuac5uw==
X-Received: by 10.25.167.85 with SMTP id q82mr12431591lfe.112.1517171438798;
        Sun, 28 Jan 2018 12:30:38 -0800 (PST)
Received: from [192.168.1.138] ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id 97sm2589725lft.85.2018.01.28.12.30.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jan 2018 12:30:37 -0800 (PST)
Subject: Re: [PATCH 08/12] pack-write: switch various SHA-1 values to abstract
 forms
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
References: <20180128155722.880805-1-sandals@crustytoothpaste.net>
 <20180128155722.880805-9-sandals@crustytoothpaste.net>
From:   Patryk Obara <patryk.obara@gmail.com>
Message-ID: <76f6c291-9c48-279d-3bb6-fc42a8e0eb9b@gmail.com>
Date:   Sun, 28 Jan 2018 21:30:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101
 Thunderbird/58.0
MIME-Version: 1.0
In-Reply-To: <20180128155722.880805-9-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/01/2018 16:57, brian m. carlson wrote:
>   		if (partial_pack_offset == 0) {
> -			unsigned char sha1[20];
> -			git_SHA1_Final(sha1, &old_sha1_ctx);
> -			if (hashcmp(sha1, partial_pack_sha1) != 0)
> +			unsigned char hash[GIT_MAX_RAWSZ];
> +			the_hash_algo->final_fn(hash, &old_hash_ctx);
> +			if (hashcmp(hash, partial_pack_hash) != 0)

Maybe "hash" should be struct object_id here?

>   char *index_pack_lockfile(int ip_out)
>   {
> -	char packname[46];
> +	char packname[GIT_MAX_HEXSZ + 6];
> +	int len = the_hash_algo->hexsz + 6;

Just me nitpicking, but "len" can be const :)

-- 
| ← Ceci n'est pas une pipe
Patryk Obara
