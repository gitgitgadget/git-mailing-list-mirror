Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEA161F576
	for <e@80x24.org>; Fri, 19 Jan 2018 08:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754862AbeASIWj (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 03:22:39 -0500
Received: from mail-oi0-f52.google.com ([209.85.218.52]:33778 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753741AbeASIWi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 03:22:38 -0500
Received: by mail-oi0-f52.google.com with SMTP id y141so613731oia.0
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 00:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=car32UkfNTMC2b6SL4xhHRbJmAzaBBViqTEid21awjI=;
        b=chDBMCbyenqQ/UMrSp1FP22A+J2lgkXahTrnOU8XOHddcUg7+eAfIbAj+T3Gnfrhks
         YlLPtHmW2Uqd8Y9Ojv7kyVSSRcEOQk7OQSNMfs0V5LNwDZ1ibWuHD3A+aaKg48RBKT2s
         bRw5rAFfMPwQZEjBDm+DIMKBZ+pKhlLujgxpbmmNEryDM+ChcjON3N+4mY4FRu51Z7Xi
         hDqI+syVQMCdsQB59npiaqUvHV6HWytR26gPv8Xu4cgMgdrTntTD2iSzPMyTuWwRiwx4
         rY87cWrHbdzzBXopohwGCdPhMOpjpqNS/oOd9W2VztDdhNwK7vwMhXjOPBvlaWfHsZyc
         2zDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=car32UkfNTMC2b6SL4xhHRbJmAzaBBViqTEid21awjI=;
        b=KhyaC9Zl7xPFCi6hp5arqcQhODsJo9XoyNk+VbcZDmlqBXCB/EwrJEPQ2tmz8SFPEN
         mlAMPXKymFtHsXm0zrs81l1m5gEjaNzaBN0UeI0nxKq79Sc+F0fDhkBhr0l/8johecHA
         Ogt42a+nuAipSjRnYs/jz/e5olwfcBcwn/dYm7wFrLVscdaJQLTARQZcGfsM+3yfp0nu
         3JRbY7yBpdIWFiyFbml9bUkcAevTZ3RQS+y0xdV8+rVYh0NlVLu1l/79zZDRqO4hdsNL
         aZSurbUKnlFAo4Oj3j8D1DU71OHn8cDNv/8W9dsE0C5KZq6Ys03Yz6PzI4OUBi5bPVlR
         1sGg==
X-Gm-Message-State: AKwxytchg73jwIYoG8i1IjVB3Tb3zRKKGRDq7HqKZQkl1o3vrWaJ5vk0
        Y5tcWc97tSnN8ocnBgOMRcU21j+PLHQtwndm/Pw=
X-Google-Smtp-Source: ACJfBouy2LFVw0lSFugAjGLBwG17+mpnS79NmvojscyywIfNcch+XFn9x892pr3XIcLpIlVY7ZLWRO8wCHFnkHbgklU=
X-Received: by 10.202.60.134 with SMTP id j128mr4993595oia.268.1516350157165;
 Fri, 19 Jan 2018 00:22:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.27.3 with HTTP; Fri, 19 Jan 2018 00:22:06 -0800 (PST)
In-Reply-To: <20180119074001.GA55929@flurp.local>
References: <CALwADsGfB10f5+nOFN-pHCt4z1SkWMcvSHn8KokcyCM0V6K-BA@mail.gmail.com>
 <CAPig+cTkBEGyoS93GYCtoDgccTF_UixqBkVTExg7Zf0M1J7KRQ@mail.gmail.com>
 <20180119024738.GA222163@genre.crustytoothpaste.net> <CAPig+cSbbzKV0GttLjHCyY3CNcJO0bdP3Mp4pT+3waUTMAQ8kg@mail.gmail.com>
 <20180119034025.GB222163@genre.crustytoothpaste.net> <CACsJy8BTFm_0sv=roL1OKKW=1DyU3vqD50NKyHg3KQ7G+mAepQ@mail.gmail.com>
 <20180119074001.GA55929@flurp.local>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 19 Jan 2018 15:22:06 +0700
Message-ID: <CACsJy8AOPDNTbAWzDHd+Oa5PSc1v2qdfcaq60P7X5wznM4VTug@mail.gmail.com>
Subject: Re: git 2.16.0 segfaults on clone of specific repo
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= 
        <aleks.bulaev@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 2:40 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Jan 19, 2018 at 12:31:58PM +0700, Duy Nguyen wrote:
>> On Fri, Jan 19, 2018 at 10:40 AM, brian m. carlson
>> > I'm still extremely puzzled as to why this doesn't fail on Linux.  If
>> > it's failing in this case, it should very, very clearly fail all the
>> > time we access an empty blob or an empty tree.[...]
>>
>> I think it's file system related, case-insensitive one in particular.
>>
>> The call trace posted at the beginning of this thread should never
>> trigger for an initial clone. You only check if an _existing_ entry
>> matches what you are about to checkout when you switch trees. For this
>> to happen at clone time, I suppose you have to checkout entry "A",
>> then re-checkout "A" again. Which can only happen on case-insensitive
>> file systems and a case-sensitive repo where the second "A" might
>> actually be "a".
>> [...]
>> On Linux, after I hacked all over the place to force ce_match_stat()
>> to eventually call index_fd() which in turns must use one of the
>> hashing function, I got a crash.
>
> Nice detective work.

And not stepping back to think for a bit. I realized now that if I
just mounted a vfat filesystem, I could have verified it much quicker.
It does crash on linux with similar stack trace.

(gdb) bt
#0  0x000000000055809f in is_empty_blob_sha1 (sha1=0x8fa6d4 "\236") at
cache.h:1055
#1  0x0000000000558acd in ce_match_stat_basic (ce=0x8fa690,
st=0x7fffffffcd20) at read-cache.c:272
#2  0x0000000000558c78 in ie_match_stat (istate=0x8e9fc0 <the_index>,
ce=0x8fa690, st=0x7fffffffcd20, options=5) at read-cache.c:342
#3  0x0000000000501e01 in checkout_entry (ce=0x8fa690,
state=0x7fffffffcea0, topath=0x0) at entry.c:424
#4  0x00000000005c8ea0 in check_updates (o=0x7fffffffd060) at unpack-trees.c:383
#5  0x00000000005cb2bb in unpack_trees (len=1, t=0x7fffffffd010,
o=0x7fffffffd060) at unpack-trees.c:1382
#6  0x00000000004214ca in checkout (submodule_progress=1) at builtin/clone.c:750
#7  0x00000000004229ce in cmd_clone (argc=1, argv=0x7fffffffd840,
prefix=0x0) at builtin/clone.c:1191
#8  0x0000000000405846 in run_builtin (p=0x89a908 <commands+456>,
argc=2, argv=0x7fffffffd840) at git.c:346
#9  0x0000000000405af7 in handle_builtin (argc=2, argv=0x7fffffffd840)
at git.c:554
#10 0x0000000000405c8f in run_argv (argcp=0x7fffffffd6fc,
argv=0x7fffffffd6f0) at git.c:606
#11 0x0000000000405e31 in cmd_main (argc=2, argv=0x7fffffffd840) at git.c:683
#12 0x00000000004a3231 in main (argc=3, argv=0x7fffffffd838) at common-main.c:43

> This particular manifestation is caught by the
> following test which fails without brian's patch on MacOS (and
> presumably Windows) and succeeds with it. On Linux and BSD, it will of
> course succeed always, so I'm not sure how much practical value it
> has.

There's a travis job running "on windows" (I don't what it really
means) so it might help actually. This vim-colorschemes repository has
shown up in git mailing list before, I think. We probably should just
add it as part of our regression tests ;-)
-- 
Duy
