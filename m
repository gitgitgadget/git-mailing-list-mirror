Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E177A1F453
	for <e@80x24.org>; Mon, 15 Oct 2018 15:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbeJOW5g (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 18:57:36 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36730 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeJOW5g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 18:57:36 -0400
Received: by mail-qk1-f196.google.com with SMTP id a85-v6so12027812qkg.3
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 08:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6ErejJa0EDocqddjpYV4aObDfp3b7inwclQSei9IbVo=;
        b=WEtqZ9QMzlaAPGgB1Kl2tIBT+Arb+07faEh6K+37b4HTE7vxOLUEBhHJkXtSeotfq0
         nSc5G+XZNqKhGEvHknvTAodOHqhoQnIKx7XS0vewUJubFEQuB0b2Nn5LFRVlJqDl+fn4
         ruS6bIRq+bR9i/Ufzy8qyZRSBsn0joOCvnEDMTiHmO7rCc7SE+pGNEuzb4YU6+gQ1hbI
         WvO0c5fLir7q71ieE2xuxAc/m8HAKlvMpa8GdylYpw4dMtNehw+vCFIDwIMdgixoWb1Y
         GKHLmZZQqm/HUHarz8uWygchQi9/ZXD/GFfBWk5/As2QH1q0UIi14bX5p7CM6TH51eyV
         zPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6ErejJa0EDocqddjpYV4aObDfp3b7inwclQSei9IbVo=;
        b=Y3qvzL5+gRtJ3tYx6Kpr2AN02yfQNowuLPxFjIT33qz5B/gkt8vL6cvw5kpu5TX3aS
         v2YTygo0H8ZBGNZsqpREM3IhzwUpyGq5eVXykKFumBV8ts2qiKBJLodCOw4uHtKWXzXd
         EC0i+I5nnWOwJAjjjBsEEuTwET61HJYFh2YVRf3fi+vX08CH78iMtsATsfBYk51308q3
         8k2W2ksy87ftNXyglt97Vq1fVeBsmb0gVoM0J4wIudfvgl4kzqWyNxm5As2v98hlnSnV
         nHuqLNcgpiR4V0vifjFVnVWZ+aIc8ZVDOP6ULW/vDPmtRUujzYvWm+KcYmD8Tq+epP5h
         A44w==
X-Gm-Message-State: ABuFfogvkAXYe1Lipmn5zc8lqFoO2429wfZ4tNr5k09x3cVJSjFOJexq
        Vv/hr+90igkMgYXButSXxno=
X-Google-Smtp-Source: ACcGV635EBVQrVsoJFL8LX780w96dAKpo3GA0tXo/7AdSU4YLkO/anfOeVkyzrWvYkt2kzkaFzii+w==
X-Received: by 2002:a37:a20d:: with SMTP id l13-v6mr16153057qke.297.1539616315383;
        Mon, 15 Oct 2018 08:11:55 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:a017:1942:43e1:ced3? ([2001:4898:8010:0:894d:1942:43e1:ced3])
        by smtp.gmail.com with ESMTPSA id a13-v6sm6430029qkg.94.2018.10.15.08.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 08:11:54 -0700 (PDT)
Subject: Re: [PATCH v2 13/13] commit-graph: specify OID version for SHA-256
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
 <20181015021900.1030041-14-sandals@crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a0a4bf24-ce6d-69e1-4485-8742c538304d@gmail.com>
Date:   Mon, 15 Oct 2018 11:11:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181015021900.1030041-14-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/14/2018 10:19 PM, brian m. carlson wrote:
> Since the commit-graph code wants to serialize the hash algorithm into
> the data store, specify a version number for each supported algorithm.
> Note that we don't use the values of the constants themselves, as they
> are internal and could change in the future.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>   commit-graph.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 7a28fbb03f..e587c21bb6 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -45,7 +45,14 @@ char *get_commit_graph_filename(const char *obj_dir)
>   
>   static uint8_t oid_version(void)
>   {
> -	return 1;
> +	switch (hash_algo_by_ptr(the_hash_algo)) {
> +		case GIT_HASH_SHA1:
> +			return 1;
> +		case GIT_HASH_SHA256:
> +			return 2;
> +		default:
> +			BUG("unknown hash algorithm");
> +	}
>   }
>   
>   static struct commit_graph *alloc_commit_graph(void)
Simple and easy!

Thanks,
-Stolee
