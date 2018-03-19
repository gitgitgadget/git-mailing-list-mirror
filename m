Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11F241F404
	for <e@80x24.org>; Mon, 19 Mar 2018 12:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932277AbeCSMz0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 08:55:26 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:40120 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753151AbeCSMzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 08:55:25 -0400
Received: by mail-qt0-f181.google.com with SMTP id y6so17779760qtm.7
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 05:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=tAsWd7Tm21IlZBTErXTvp3U9xW2QDBHg10MDJeR4maY=;
        b=jGx0wM4NAyVIHi8rLazcEr27f2c+a9s4Td8lKGaxlxdG85yF37Te2Fm9QyfJXX1IrU
         cBHIJsDOKAeEBF3EiX2F2Htt99OBjma7wKPp1E05XD774bEVIuFc2T6LFZV69EcORhsb
         XBeaSUEIxCo5xxWTkg3wWTeAQ+NWiTjrgbxjjudcpc9HsBaBZ3VsFvTozoKT2tHReslI
         OnfN4vlkrl3M87+Bp+TG2/B+u9QVa8Hofm6dS0oYe5rrOacAm9EP9Ja42sTqzuuKClDN
         n1a1zt69c8CVzTgz2PYkQm7RmM8Y+y8Jrr7BU5ebn1e4y06CeTeJT+C6LZ0csoinoWd8
         //Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tAsWd7Tm21IlZBTErXTvp3U9xW2QDBHg10MDJeR4maY=;
        b=dgDcMVYPP0fs4JPHVRMFWC6LQ8/SnGvY/48fN4mYOtZEKLMOPylFQvZDgVWJsFD1Qv
         MRi5HQd68L/vUdscgEpK/vWw1kxqzqKq6yGXid0X6O1/vpN7Rz00h5pUNpgvECKaGxLb
         DOS42t32CDl05Ohru8c1RAMx+CI1Un2+fmPF2fZw1QDoqj2rvi+7dHFgwpZRYqJrfpvT
         TrhKLWks8sam/C9DS0TDFVCTap6UoNTUKRIZPbvAn0u7E6fFrb3KxuebHajudCZV8HBC
         5HG9ax+uvwl/c26hYx0q0/VVZd/ZJHxhvSgiJCKxmeOjGDfUnSObVlA3zO0ff0iDzvEr
         Zygw==
X-Gm-Message-State: AElRT7G9OJQrRQRcY6tN+5BTRP/rE9coNp0LnZs4qBIDYTsT8twwc9r0
        uyKlXP/rNsKnsmyPNryKIBg=
X-Google-Smtp-Source: AG47ELtzod2270n1Dd2apv/e59ZTMrcxbF7aY1A+1TwAc4iCQA0omPRAqGDGIvMDNeL9QJWrFU/HhQ==
X-Received: by 10.237.40.99 with SMTP id r90mr18127664qtd.233.1521464124375;
        Mon, 19 Mar 2018 05:55:24 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id i63sm10086351qtb.96.2018.03.19.05.55.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Mar 2018 05:55:23 -0700 (PDT)
Subject: Re: [PATCH v6 00/14] Serialized Git Commit Graph
To:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git@jeffhostetler.com, Derrick Stolee <dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
 <20180314192736.70602-1-dstolee@microsoft.com>
 <878tasdpqo.fsf@evledraar.gmail.com>
 <CAM0VKjknPZj-qHzf5nVr_RdHtB+pq2+APc1tesexP-eFSP9n_A@mail.gmail.com>
 <xmqq370z3m5o.fsf@gitster-ct.c.googlers.com>
 <CAM0VKjmVgiWsqo8rQWwP9+mEq0tLinc8xoUM=8XdMP3VTBwJxw@mail.gmail.com>
 <20180316200639.GA1845@sigill.intra.peff.net>
 <20180316201908.GA12281@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b6ca5f0a-d2c3-2487-ee09-9cf93377d1c1@gmail.com>
Date:   Mon, 19 Mar 2018 08:55:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316201908.GA12281@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/16/2018 4:19 PM, Jeff King wrote:
> On Fri, Mar 16, 2018 at 04:06:39PM -0400, Jeff King wrote:
>
>>> Furthermore, in order to look at an object it has to be zlib inflated
>>> first, and since commit objects tend to be much smaller than trees and
>>> especially blobs, there are a lot less bytes to inflate:
>>>
>>>    $ grep ^commit type-size |cut -d' ' -f2 |avg
>>>    34395730 / 53754 = 639
>>>    $ cat type-size |cut -d' ' -f2 |avg
>>>    3866685744 / 244723 = 15800
>>>
>>> So a simple revision walk inflates less than 1% of the bytes that the
>>> "enumerate objects packfiles" approach has to inflate.
>> I don't think this is quite accurate. It's true that we have to
>> _consider_ every object, but Git is smart enough not to inflate each one
>> to find its type. For loose objects we just inflate the header. For
>> packed objects, we either pick the type directly out of the packfile
>> header (for a non-delta) or can walk the delta chain (without actually
>> looking at the data bytes!) until we hit the base.
> Hmm, so that's a big part of the problem with this patch series. It
> actually _does_ unpack every object with --stdin-packs to get the type,
> which is just silly. With the patch below, my time for "commit-graph
> write --stdin-packs" on linux.git goes from over 5 minutes (I got bored
> and killed it) to 17 seconds.
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 6348bab82b..cf1da2e8c1 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -491,11 +491,12 @@ static int add_packed_commits(const struct object_id *oid,
>   {
>   	struct packed_oid_list *list = (struct packed_oid_list*)data;
>   	enum object_type type;
> -	unsigned long size;
> -	void *inner_data;
>   	off_t offset = nth_packed_object_offset(pack, pos);
> -	inner_data = unpack_entry(pack, offset, &type, &size);
> -	FREE_AND_NULL(inner_data);
> +	struct object_info oi = OBJECT_INFO_INIT;
> +
> +	oi.typep = &type;
> +	if (packed_object_info(pack, offset, &oi) < 0)
> +		die("unable to get type of object %s", oid_to_hex(oid));
>   
>   	if (type != OBJ_COMMIT)
>   		return 0;
>
> -Peff

Thanks for this! Fixing this performance problem is very important to 
me, as we will use the "--stdin-packs" mechanism in the GVFS scenario 
(we will walk all commits in the prefetch packs full of commits and 
trees instead of relying on refs). This speedup is very valuable!

Thanks,
-Stolee
