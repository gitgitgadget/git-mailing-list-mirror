Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5611D1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 11:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbfBLLNJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 06:13:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40074 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfBLLNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 06:13:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id q21so2553043wmc.5
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 03:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=hVg2OG6saYa9go5D7M6w5kKwb7pXFx7R3ClRiiXjdKo=;
        b=S+/zIqe+BR0wkaQVgydzxk8MPdG4tQyqHMJf5oZH6yzNZ8+ikp/jnlFVirbdkhEymr
         +JmROJ2pBcBAaRA6p7Y0mJoxjsyvcKtP3cK2nUujbjK9tdMsJLDMPWXhHg0SSI/CP4tm
         eGQZQO1WTPsYM0nP7Q+4M/m9/JhRHdGaferxV8/nhwP6F8aDtQpyLQKfXnAYzF71UIK2
         io/+Vr6te/RCm1gKELsqeipMnhXC9aUczI8T1nGkh2zAxPfvMjL+BkrbqaJBRerv3D8H
         Pez4tb/wDubn/nO0mzcJb88AmQ7gGAbMopBiFh78lGkqfXBUm0Y0S1/fxocvi/+yYcV/
         WFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=hVg2OG6saYa9go5D7M6w5kKwb7pXFx7R3ClRiiXjdKo=;
        b=ec+9AwZQ+I8QjqRcH5izULRRGulNNfaYB4+w/zq04aoU1rkWqDF9pN57At2lWZSxQC
         NaSOh3VKUcHCNigF7OjGcvWWTBSga6YWohVyQ9Rx7kGUvofUFgJU9TWErrneWpfzIBRC
         f6N1jc32oKi66ZRSCV3SGnJmQo0LEp+nptu8t+PHS8EgUE17loQiwh6s5JOW0JiQVNgh
         y36IQ1QoiXXDGV6EBBXvzaoyy8AaxM5phOy8QHUjdfeJoSrzOfehoIV50sivnhy1LivX
         PW4HyVFfpuMd88xqr7J7k7Vz+V/GCuTJ8diETjNMKdZTGRfHkFyn5irUHpdZWaznzscP
         xptA==
X-Gm-Message-State: AHQUAuaAOtcoIne6tkR/cNc4qfuEAAfkYxbE2JXvR1r8wWTDR9VshvAb
        2wTyN7aECpMn3Q/9tMmRQNyW6FTd
X-Google-Smtp-Source: AHgI3IbynGjM7gJp5rTPX40w0/TZg0GMXIdijfRrkOLe+JyuMKTlusTU49u+8ivjF2SmZVpi1QXgFw==
X-Received: by 2002:a7b:cb82:: with SMTP id m2mr2676048wmi.135.1549969987336;
        Tue, 12 Feb 2019 03:13:07 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id u6sm1041237wmj.28.2019.02.12.03.13.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 03:13:06 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 05/31] pack-bitmap: switch hard-coded constants to the_hash_algo
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net> <20190212012256.1005924-6-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190212012256.1005924-6-sandals@crustytoothpaste.net>
Date:   Tue, 12 Feb 2019 12:13:06 +0100
Message-ID: <87va1pjm4d.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 12 2019, brian m. carlson wrote:

> Switch two hard-coded uses of 20 to references to the_hash_algo.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  pack-bitmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 6d6fa68563..603492c237 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -138,7 +138,7 @@ static int load_bitmap_header(struct bitmap_index *index)
>  {
>  	struct bitmap_disk_header *header = (void *)index->map;
>
> -	if (index->map_size < sizeof(*header) + 20)
> +	if (index->map_size < sizeof(*header) + the_hash_algo->rawsz)
>  		return error("Corrupted bitmap index (missing header data)");
>
>  	if (memcmp(header->magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE)) != 0)
> @@ -157,7 +157,7 @@ static int load_bitmap_header(struct bitmap_index *index)
>  				"(Git requires BITMAP_OPT_FULL_DAG)");
>
>  		if (flags & BITMAP_OPT_HASH_CACHE) {
> -			unsigned char *end = index->map + index->map_size - 20;
> +			unsigned char *end = index->map + index->map_size - the_hash_algo->rawsz;
>  			index->hashes = ((uint32_t *)end) - index->pack->num_objects;
>  		}
>  	}

Similarly to my other comments upthread, what happens in a repo where we
have a SHA-1 bitmap file & a SHA-1<->SHA-256 mapping?
