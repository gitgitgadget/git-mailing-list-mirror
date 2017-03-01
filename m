Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9F052023D
	for <e@80x24.org>; Wed,  1 Mar 2017 17:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753151AbdCAR66 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 12:58:58 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:34953 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752101AbdCAR56 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 12:57:58 -0500
Received: by mail-io0-f178.google.com with SMTP id j18so36476604ioe.2
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 09:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=8t9jN+aRRwIs+Tt6gaOxy36QkPIuTJJ8obZ0vZ+k2BE=;
        b=sOetQTNHwYhihucC/AvMoRg1XOd4tiWi41je+7vNv9VFwFPrF8c7xnyKtpx9zLMxEL
         Vy8/QjwdCqA+RpzOqs1eAe3Ky6js27cgcLlnqfNQ69Wn2YNuOMWWqI9zUntjYxk1v+rJ
         9fSd3xliUX3XncLnnHUh2F7h8l+Shf1hE/JptRHecO8XPT5qPw6X4FRm2RG6y2UfuO/c
         SSDYNiL7hE96uQuv7wVmXvW+or2CBEszxWfwb6l2iMniQ15OUdRdiW7bb56Pfy+HXq46
         8evIKy+UDoQuMJ75VAJKQVBgWslfQV9fsygMPRhB04Zj50C+7qSF+oLemgvVEzMU0HnA
         daBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=8t9jN+aRRwIs+Tt6gaOxy36QkPIuTJJ8obZ0vZ+k2BE=;
        b=TTYoM4/toVxw/uBWb2zsEJmtAQBH/c5jFqxQCkI9la7axVaa6b92r9un7ZRubznpCJ
         2Jdo1qGWXwm3D8IA3pEyPPai0TOVX2GJNqZb9D0q6OVHqVT1XqA8G+fOgzxRqs532N4R
         d29JT8PzR5+DlcXIMOxDaaljXEB+Z/anl0fGVklSL03Cu1C93o3g9PLjhdGU/SfWbPpt
         yfL82Z2n5q2fkd3uukHzNqZNZNtxxh9ykNmW7wfEXWLRbmlQ3Ub6vGWzo74z+uK5SABM
         XH6lsl+vzm/cb/L3qFNYHmNLhO/UxLS1Y81MUPclZpkA2H3cCXcWqs1AkJEpPDdnbS2b
         6CYg==
X-Gm-Message-State: AMke39mdX/67jbuvXbcKpaYt21jZ9bYzqOd8/AlFaUZd0j4fgrExnUo/i3lpEQhW6yFuUw==
X-Received: by 10.107.131.211 with SMTP id n80mr9977825ioi.210.1488391045861;
        Wed, 01 Mar 2017 09:57:25 -0800 (PST)
Received: from [10.3.3.214] ([199.227.34.94])
        by smtp.gmail.com with ESMTPSA id f127sm7206921ite.26.2017.03.01.09.57.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Mar 2017 09:57:25 -0800 (PST)
Subject: Re: Delta compression not so effective
To:     Linus Torvalds <torvalds@linux-foundation.org>
References: <4d2a1852-8c84-2869-78ad-3c863f6dcaf7@gmail.com>
 <CA+55aFzQ0o2R2kShS=AuKu0TLnfPV-0JCkViqx5J_afCK0Yt5g@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Marius Storm-Olsen <mstormo@gmail.com>
Message-ID: <eba83461-34cf-6d64-4013-873b04af9b82@gmail.com>
Date:   Wed, 1 Mar 2017 11:57:27 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CA+55aFzQ0o2R2kShS=AuKu0TLnfPV-0JCkViqx5J_afCK0Yt5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/1/2017 11:36, Linus Torvalds wrote:
> On Wed, Mar 1, 2017 at 5:51 AM, Marius Storm-Olsen <mstormo@gmail.com> wrote:
>>
>> When first importing, I disabled gc to avoid any repacking until completed.
>> When done importing, there was 209GB of all loose objects (~670k files).
>> With the hopes of quick consolidation, I did a
>>     git -c gc.autoDetach=0 -c gc.reflogExpire=0 \
>>           -c gc.reflogExpireUnreachable=0 -c gc.rerereresolved=0 \
>>           -c gc.rerereunresolved=0 -c gc.pruneExpire=now \
>>           gc --prune
>> which brought it down to 206GB in a single pack. I then ran
>>     git repack -a -d -F --window=350 --depth=250
>> which took it down to 203GB, where I'm at right now.
>
> Considering that it was 209GB in loose objects, I don't think it
> delta-packed the big objects at all.
>
> I wonder if the big objects end up hitting some size limit that causes
> the delta creation to fail.

You're likely on to something here.
I just ran
     git verify-pack --verbose 
objects/pack/pack-9473815bc36d20fbcd38021d7454fbe09f791931.idx | sort 
-k3n | tail -n15
and got no blobs with deltas in them.
   feb35d6dc7af8463e038c71cc3893d163d47c31c blob   36841958 36461935 
3259424358
   007b65e603cdcec6644ddc25c2a729a394534927 blob   36845345 36462120 
3341677889
   0727a97f68197c99c63fcdf7254e5867f8512f14 blob   37368646 36983862 
3677338718
   576ce2e0e7045ee36d0370c2365dc730cb435f40 blob   37399203 37014740 
3639613780
   7f6e8b22eed5d8348467d9b0180fc4ae01129052 blob   125296632 83609223 
5045853543
   014b9318d2d969c56d46034a70223554589b3dc4 blob   170113524 6124878 
1118227958
   22d83cb5240872006c01651eb1166c8db62c62d8 blob   170113524 65941491 
1257435955
   292ac84f48a3d5c4de8d12bfb2905e055f9a33b1 blob   170113524 67770601 
1323377446
   2b9329277e379dfbdcd0b452b39c6b0bf3549005 blob   170113524 7656690 
1110571268
   37517efb4818a15ad7bba79b515170b3ee18063b blob   170113524 133083119 
1124352836
   55a4a70500eb3b99735677d0025f33b1bb78624a blob   170113524 6592386 
1398975989
   e669421ea5bf2e733d5bf10cf505904d168de749 blob   170113524 7827942 
1391148047
   e9916da851962265a9d5b099e72f60659a74c144 blob   170113524 73514361 
966299538
   f7bf1313752deb1bae592cc7fc54289aea87ff19 blob   170113524 70756581 
1039814687
   8afc6f2a51f0fa1cc4b03b8d10c70599866804ad blob   248959314 237612609 
606692699

In fact, I don't see a single "deltified" blob until 6355th last line!


> For example, we have that HASH_LIMIT  that limits how many hashes
> we'll create for the same hash bucket, because there's some quadratic
> behavior in the delta algorithm. It triggered with things like big
> files that have lots of repeated content.
>
> We also have various memory limits, in particular
> 'window_memory_limit'. That one should default to 0, but maybe you
> limited it at some point in a config file and forgot about it?

Indeed, I did do a
     -c pack.threads=20 --window-memory=6g
to 'git repack', since the machine is a 20-core (40 threads) machine 
with 126GB of RAM.

So I guess with these sized objects, even at 6GB per thread, it's not 
enough to get a big enough Window for proper delta-packing?

This repo took >14hr to repack on 20 threads though ("compression" step 
was very fast, but stuck 95% of the time in "writing objects"), so I can 
only imagine how long a pack.threads=1 will take :)

But arent't the blobs sorted by some metric for reasonable delta-pack 
locality, so even with a 6GB window it should have seen ~25 similar 
objects to deltify against?


-- 
.marius
