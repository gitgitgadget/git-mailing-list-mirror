Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF4961F403
	for <e@80x24.org>; Thu, 14 Jun 2018 01:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935878AbeFNBmU (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 21:42:20 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:40324 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935633AbeFNBmT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 21:42:19 -0400
Received: by mail-qt0-f194.google.com with SMTP id q6-v6so4374843qtn.7
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 18:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=Va+LmMg9Zc3ZKhuHwFxHLgr1fENGKH9dL0YCFBLVxFI=;
        b=jAVWW1vqh3DZHh0U53hnQbXosY5MCG+xRWvL6bfapJFr50ij5L0tCaGYDw99nJaZIe
         OgeDf0+YuvGWz8TKlDzENgcqH0fLAEozvyZT74laMs2vGcLFeF72NKBa8n6Z0mpbzkwc
         gd6LlG7j1dAXBwCyQWptSEu/cSHRhFBH3nck1GQS9JKCAseJV9xdcrQO6X89RJy2/4HY
         tSqgPWOw/j2F7t5NJrNa1Xsq4kSyAhGQ0JmrkHcFSKBtl61kVh+PCE82s+BUTUFfpiEv
         Bu9Pa8D06+4mTlTJqpZJqlER9sLd4csY5HZA8GK2MkHgw6alWE8NKeafTgTNhMgsSMWN
         BISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Va+LmMg9Zc3ZKhuHwFxHLgr1fENGKH9dL0YCFBLVxFI=;
        b=YW+ui43btLqfKSTTLmFGHpyQfktz4EA4zK+sdtP8cBjLxfTLPL6YG7eJJn0w5sA0dt
         XkupfLwWJpPOmcDwIGVqoJBC782emozdjn/NkCCnRFxktad+ZnJYgl8sFzVeIuFHM/kH
         /s7+i9hhXm+hs7GJSKA39X/EaivAzIxt/UPVUYRWeVYGJigyXTQkLmw+3fLyoao7UkKC
         Ad3TNW1BBV1BNWALBvQlKM/joBdBhygYeZFxqAcoMAbS0UOOjFEzQne4vlrubMLiPcK3
         gEYmHJ5sqF4FGPRXJDDul4tCe/8Ev5I9+496a65gM3qcg81cPC+t5v44KfiZGntD++o3
         20Tg==
X-Gm-Message-State: APt69E1dxvbSjhKaasOggwX8FPHzh1VQOoiPWn4Jy2M00vRPMD8HDGUo
        s3+K7h2bxOx+pBksbnNu6ZRG6zyj
X-Google-Smtp-Source: ADUXVKLyjSTm/vMR+vSH3u2Jg9IErZ2migANfELyAQ5j3Dthipqz6A3Y310xFm2y5kuowwY1Z0xdHQ==
X-Received: by 2002:aed:35dc:: with SMTP id d28-v6mr515141qte.294.1528940538207;
        Wed, 13 Jun 2018 18:42:18 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id f204-v6sm2849488qke.21.2018.06.13.18.42.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 18:42:17 -0700 (PDT)
Subject: Re: [PATCH v2 00/31] object-store: lookup_commit
From:   Derrick Stolee <stolee@gmail.com>
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <20180530004810.30076-1-sbeller@google.com>
 <20180613230522.55335-1-sbeller@google.com>
 <d5d95334-b0fc-bb8a-67ff-75b03ad7877a@gmail.com>
Message-ID: <a55e0dae-9cb1-62d8-be82-46b5f823fd58@gmail.com>
Date:   Wed, 13 Jun 2018 21:42:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <d5d95334-b0fc-bb8a-67ff-75b03ad7877a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 6/13/2018 9:23 PM, Derrick Stolee wrote:
> On 6/13/2018 7:04 PM, Stefan Beller wrote
>> * Once this is in good shape we can talk about converting parts of 
>> the revision
>>    walking code,
>
> This is another reason why I'll be waiting for this series of series. 
> I plan to rework the revision walking code around 
> sort_in_topological_order(), but I'll wait for your changes to land 
> before submitting a patch. I'm itching to play with it, so I may start 
> testing things out before then.
>
> In the meantime, I'll do my part by reviewing the current series.

Looks good to me.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

