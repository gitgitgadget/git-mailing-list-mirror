Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59E421FADF
	for <e@80x24.org>; Fri, 19 Jan 2018 05:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750780AbeASFcb (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 00:32:31 -0500
Received: from mail-ot0-f170.google.com ([74.125.82.170]:36036 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeASFca (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 00:32:30 -0500
Received: by mail-ot0-f170.google.com with SMTP id f100so496017otf.3
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 21:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=YhWx736hGRq1K4IRK78cmvXZI3M6DimFx8AhLUPtds8=;
        b=FDKHcSLUU/URliPZKUn69dmk+tmBZVEpxXc0vE+Gb7ROQ5l/sx829wRMBTnx2a1Elp
         9K7tV7eOM26pqK9n8qtFFLrnBgr6KXZJjchO5OD/mFr2gC6VSId9YmxWSMprkGRX1TuU
         6fK6mhNrajJu3rt70SfzMOgP8QHhduv1a6Zz2wjwi9vSXvqjpl7h0IDvlLYFdn1faz+b
         9Noyi4VRFu4ePtxXI23ZygiNvijYQcM95vI7ekslrPX3oTFAyLrxP1vj/NZOX9DZOA9c
         pIU3Yv9XWmkGXGMC+Aklsk05ZCEceDTSRRWxKcELplNd4M+NXQbybCZuCg0ZVVZCb46E
         2PRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=YhWx736hGRq1K4IRK78cmvXZI3M6DimFx8AhLUPtds8=;
        b=npUQf0mOVDvlI6NMaBsYtHFiW10jcK9/fBBKOX4JeDa3oSeo2vPFuGfwT5/YsObwj7
         fT0ugrF4IAigESc/cXhYBOanUgTbNjf5VyHIKQxv32jJL9gL3ppyXnO5AtfJwFPimQx1
         23j3h6J/q6RZykFN8cNfN7MZTwT1wbyhddCGAE9JnyolhLEAupJj8HL/KjWtInmQLNBd
         cTSHHsV8TghdwK3lZt2nKb8IV7FdVEwHd9llZ02pFeOByidFw49FMtFkqWAvpV5e6OdS
         X+gvAGyF4b51LJC25d+oxzmG2KBja0/gg1HU771y5ypX+UUQ04HMdLiYn/QsPm2Dbb/j
         rA8w==
X-Gm-Message-State: AKwxytd15LScXzhP0drsYmqeli5NlWxalvZPV8Ue8vtJd8V4IW4GlUYR
        y4pyofJcQeSbME1pZVIkOK3Hbtwe5lfQFWbfb9s=
X-Google-Smtp-Source: ACJfBotbVX+OQQtD49V6jIGRZG8Jo2ZUfbUsiM12kfuGTSC26DhTRpEAiVc13Q1OIi6HJ4Ww20OP5pghPgaR2NkFJ/U=
X-Received: by 10.157.32.82 with SMTP id n76mr5363952ota.301.1516339948844;
 Thu, 18 Jan 2018 21:32:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.27.3 with HTTP; Thu, 18 Jan 2018 21:31:58 -0800 (PST)
In-Reply-To: <20180119034025.GB222163@genre.crustytoothpaste.net>
References: <CALwADsGfB10f5+nOFN-pHCt4z1SkWMcvSHn8KokcyCM0V6K-BA@mail.gmail.com>
 <CAPig+cTkBEGyoS93GYCtoDgccTF_UixqBkVTExg7Zf0M1J7KRQ@mail.gmail.com>
 <20180119024738.GA222163@genre.crustytoothpaste.net> <CAPig+cSbbzKV0GttLjHCyY3CNcJO0bdP3Mp4pT+3waUTMAQ8kg@mail.gmail.com>
 <20180119034025.GB222163@genre.crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 19 Jan 2018 12:31:58 +0700
Message-ID: <CACsJy8BTFm_0sv=roL1OKKW=1DyU3vqD50NKyHg3KQ7G+mAepQ@mail.gmail.com>
Subject: Re: git 2.16.0 segfaults on clone of specific repo
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= 
        <aleks.bulaev@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 10:40 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Thu, Jan 18, 2018 at 10:06:10PM -0500, Eric Sunshine wrote:
>> > I have a guess about what the problem might be.  Can you try this patch
>> > and see if it fixes things?
>>
>> That does fix the crash. Thanks for the quick diagnosis.
>>
>> Can the commit message go into more detail as to why this was crashing
>> (or your speculation about why)? Perhaps give more detail about what
>> 'clone' is doing that led to the crash.
>
> Sure.  I ran into this as I was expanding the hash structure abstraction
> into my next series.  I'll send a follow-up patch with a more
> descriptive answer.
>
> I'm still extremely puzzled as to why this doesn't fail on Linux.  If
> it's failing in this case, it should very, very clearly fail all the
> time we access an empty blob or an empty tree.  I've tried with gcc and
> two versions of clang, using -fno-lto, with address sanitizer, with -O0,
> and so on.  I'd really like to catch this kind of issue sooner in the
> future if I can figure out how to reproduce it.

I think it's file system related, case-insensitive one in particular.

The call trace posted at the beginning of this thread should never
trigger for an initial clone. You only check if an _existing_ entry
matches what you are about to checkout when you switch trees. For this
to happen at clone time, I suppose you have to checkout entry "A",
then re-checkout "A" again. Which can only happen on case-insensitive
file systems and a case-sensitive repo where the second "A" might
actually be "a".

vim-colorschemes.git has these two entries, which meets one of the
conditions, I suppose macos meets the other

colors/darkblue.vim
colors/darkBlue.vim

On Linux, after I hacked all over the place to force ce_match_stat()
to eventually call index_fd() which in turns must use one of the
hashing function, I got a crash.
-- 
Duy
