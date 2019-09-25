Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADF021F466
	for <e@80x24.org>; Wed, 25 Sep 2019 12:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405769AbfIYMsL (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 08:48:11 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38576 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404621AbfIYMsL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 08:48:11 -0400
Received: by mail-qt1-f194.google.com with SMTP id j31so6356415qta.5
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 05:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uUdAH7ZatVofGF61b51UbFfbbrIpSZVzfaeOlVqqG74=;
        b=TahRqxcB0yy+RmEgxk2peIZqL0A5OGwXVRNSRFO9wMgGUvrAPYhaV4taj53e8H3TU3
         4XXbJ3WtmRd+WvFrBGuCl6LkMM1GAQuM07joO1PkooL4BXIftd6KxAD3ctvlMLtKcRxj
         PhtMyTnxe3/EgL50qjNoWKTTlF2fji4skzNHLkpUKvo3kATAkpmCRe991lLZOcmMsJ41
         cNZ7/JpvKNwK/UI5EqqxE1MIg2lsfDRy9yqMilXj3F7Vcwr/X9w1ezUhQWdfNr6OZFga
         2h7BT64QcSV4ubSK9MrscL25GwHYQJE3K8DHPXGBj5IRLaqPCDp6PtrcLweEFPlF4r/n
         MSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uUdAH7ZatVofGF61b51UbFfbbrIpSZVzfaeOlVqqG74=;
        b=K+xy0VNwShJoR+wUUnS7VZ92NX2uQ10gRaSdBjudB1lmCZp8Kp0XjaNbuXJUiG1nrf
         QT5fK5xnwjSxEthOrKIQYt3MXxXJPCAQKzdwPLGN/aPvukHYP5gSXU6TMD0to/4Q21WU
         smf4+En01n+WIBiFOTS4BZEJcq4T1Ct9KrZiw1ddS5TYUy9seFyjaKYWfszEsUljW1fq
         p/EfFa3hSakxj1AHC9SXTzogL211wU0Ss0v8nPiEIJJuPwXZDkEnN3OTSFKNvMfKKIgP
         yqkW1htLDLGH33P3RiDpqVOBLtGisTMMerNtf2Sdwrn86FY9/hKsK5pz2H0K0wq/OLnP
         qw9Q==
X-Gm-Message-State: APjAAAWs5rTynRn7zjVIBgMrj8K1W/heNsaX90IugQ+epq0opejmab1g
        hNopV/ig1VjjkeVD8F/KHZvLZxIsS8E=
X-Google-Smtp-Source: APXvYqy0VMLjtqIa+53pbMkIcP5qrEsHoKULxd5UeOTSwn6sUFx/VccsR4iGGWIUpp4OkmqBeYcU0A==
X-Received: by 2002:ac8:5399:: with SMTP id x25mr8589301qtp.144.1569415690166;
        Wed, 25 Sep 2019 05:48:10 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4cc1:b74:5d5b:b0b0? ([2001:4898:a800:1010:fdf6:b74:5d5b:b0b0])
        by smtp.gmail.com with ESMTPSA id w73sm3161507qkb.111.2019.09.25.05.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 05:48:09 -0700 (PDT)
Subject: Re: [PATCH v2 04/19] hashmap_entry_init takes "struct hashmap_entry
 *"
To:     Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
References: <20190924010324.22619-1-e@80x24.org>
 <20190924010324.22619-5-e@80x24.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d0f08de3-3fa8-1e76-0b57-425eb96aefcf@gmail.com>
Date:   Wed, 25 Sep 2019 08:48:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20190924010324.22619-5-e@80x24.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/23/2019 9:03 PM, Eric Wong wrote:
> C compilers do type checking to make life easier for us.  So
> rely on that and update all hashmap_entry_init callers to take
> "struct hashmap_entry *" to avoid future bugs while improving
> safety and readability.
[snip]
> @@ -244,9 +244,9 @@ void hashmap_free(struct hashmap *map, int free_entries);
>   * your structure was allocated with xmalloc(), you can just free(3) it,
>   * and if it is on stack, you can just let it go out of scope).
>   */
> -static inline void hashmap_entry_init(void *entry, unsigned int hash)
> +static inline void
> +hashmap_entry_init(struct hashmap_entry *e, unsigned int hash)
>  {

I think the preferred line break here would be something like:

static inline void hashmap_entry_init(struct hashmap_entry *e,
				      unsigned int hash)

The rest of this patch is very mechanical and easy to check
for correctness.

Thanks,
-Stolee

