Return-Path: <SRS0=9sC2=2M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F50C2D0C0
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 09:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D8B520665
	for <git@archiver.kernel.org>; Sun, 22 Dec 2019 09:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiyzfAeB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfLVJ0e (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Dec 2019 04:26:34 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38880 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfLVJ0d (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Dec 2019 04:26:33 -0500
Received: by mail-ed1-f67.google.com with SMTP id i16so12754198edr.5
        for <git@vger.kernel.org>; Sun, 22 Dec 2019 01:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iCM5wJM5LoEFPvDqvg1aHPekWGtz7zHEETmsrbiRPbk=;
        b=HiyzfAeBOOB7vNsdPkChgRUuksDS/7sqokIYDb2W5PXimQAIMSEcDvyxQ3OX5i50eU
         rff7U6plqX3RuATx5YYWFT8eV3ow4DlJKtXuwM8Bi8xiz6zw8aXAxN8mEfE923F7D22O
         YE6hRrtl91FKkds7K2yh+bb9N/xXqx7oS4ui8TAtLCpavA4D9qsDQfjrLhVD/IQC4o0r
         7ARq61Mhv6dLgKjcnBHpIasQuaPLjr54SY0lroAOCDn6PkTatxbr1BFBMIv9xM5+BIfQ
         EEnJnYEBEhPgYJ/dzufAB7y43aldM/XbcoJxyBt55nivM070tNUeS253zAXRZfaFPrJ8
         sWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iCM5wJM5LoEFPvDqvg1aHPekWGtz7zHEETmsrbiRPbk=;
        b=VQ3p0MMAbCDKexadFAXxA33eMzTTUVB1tAGQ1QKW0ubXLS9BO/sE/GwPhPMD2WZNZb
         kH10DDf/DwWRDo3bwJaWb7elRQfrKCRxvgr89Zx3nw+I2PM4FDBDg3ZTHlPFypjuDszE
         KgY+Hi4/k23tP8w8nOCSpRclFUGPAq31ZPYoby/XBiPHs6TdMNUFAsArh9OsZV5nAf5M
         wtwYu08eCuK73pObDVECfQMizNh7xx93E/KPOhkejbF++mrt3vCMe6iOGWdhm8pJ1Tsc
         ZCdrzq5ep2pNTlXPZAKRqwrvW864bbc8dZFBxLF0l67G1eCdKaWNDtmOexXoxYu4iHWm
         jJcw==
X-Gm-Message-State: APjAAAXXlbH+tAHl+l1QeB7ww0bvTpWVdkjFYaXQqH0b9BboeAIPgN8l
        T8fbEzsRlz+VeXvdPM7Wu54CZTyYzPAy1swah8DqUAQqJBo=
X-Google-Smtp-Source: APXvYqwRXYlE28QOtp9ISxxImXXr72dXXQsBfFaZ9bFohSu3hH4UtVwItT9CyKEocdwwkwtM1p1u7yxwFf/uxz7qjZ8=
X-Received: by 2002:a17:906:1690:: with SMTP id s16mr25674332ejd.14.1577006791708;
 Sun, 22 Dec 2019 01:26:31 -0800 (PST)
MIME-Version: 1.0
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
In-Reply-To: <pull.497.git.1576879520.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 22 Dec 2019 10:26:20 +0100
Message-ID: <CAP8UFD1mOEUngLofTZ2hjsTooR49FktfWHWJGzQ9Y-a=oB-mZw@mail.gmail.com>
Subject: Re: [PATCH 0/9] [RFC] Changed Paths Bloom Filters
To:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Dec 20, 2019 at 11:07 PM Garima Singh via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> The commit graph feature brought in a lot of performance improvements acr=
oss
> multiple commands. However, file based history continues to be a performa=
nce
> pain point, especially in large repositories.
>
> Adopting changed path bloom filters has been discussed on the list before=
,
> and a prototype version was worked on by SZEDER G=C3=A1bor, Jonathan Tan =
and Dr.
> Derrick Stolee [1]. This series is based on Dr. Stolee's approach [2] and
> presents an updated and more polished RFC version of the feature.

Thanks for working on this!

> Performance Gains: We tested the performance of git log -- path on the gi=
t
> repo, the linux repo and some internal large repos, with a variety of pat=
hs
> of varying depths.
>
> On the git and linux repos: We observed a 2x to 5x speed up.
>
> On a large internal repo with files seated 6-10 levels deep in the tree: =
We
> observed 10x to 20x speed ups, with some paths going up to 28 times faste=
r.

Very nice!

I have a question though. Are the performance gains only available
with `git log -- path` or are they already available for example when
doing a partial clone and/or a sparse checkout?

> Future Work (not included in the scope of this series):
>
>  1. Supporting multiple path based revision walk
>  2. Adopting it in git blame logic.
>  3. Interactions with line log git log -L

Great!

> This series is intended to start the conversation and many of the commit
> messages include specific call outs for suggestions and thoughts.

I think Peff said during the Virtual Contributor Summit that he was
interested in using bitmaps to speed up partial clone on the server
side. Would it make sense to use both bitmaps and bloom filters?

Thanks,
Christian.
