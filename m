Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2F7B1F462
	for <e@80x24.org>; Sun,  2 Jun 2019 11:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfFBLej (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Jun 2019 07:34:39 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:34204 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfFBLej (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jun 2019 07:34:39 -0400
Received: by mail-it1-f195.google.com with SMTP id u124so1837869itc.1
        for <git@vger.kernel.org>; Sun, 02 Jun 2019 04:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=c8ZzmH4c9hAbBXg9X2tWgdNbPbwmkVmz+3LIs+0P/iM=;
        b=mq1LZhHKjZD5U38kNfoil53+GSwf78KUTpeec5RFsmCb1IwcIdOlF2MlDi8LpIgDKV
         oO14OJizpaUHSoUGQux5ha0+YVcZXDV7d9GedPBWYgmTCVgeC0W73d0H3EqqeUlAKSXs
         nwH4AG3kb3xgaeJzgu0ctZuVnyn576AIRxFVL24UO1ICPKF5WVI+PeYDlk+P2m5ehs5P
         WrKiptDQ/glzGLbyW+2tklRLEOTMV3OuiLjpYcUv2MK77AIFcl3Enkg2H+doSnKLtQDy
         cBW9ikbKfj0F5bTgpI9g7uiospqc3XEiHFOM6hjFhWDO1tRRCFCKfgWV8vDBZgfCnfwE
         XkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=c8ZzmH4c9hAbBXg9X2tWgdNbPbwmkVmz+3LIs+0P/iM=;
        b=RP60AO2dvdLdwY54ItLia+unsfvLtNZHeMvKsgtgGmybtSSKxJX/MDKE2qD0rlm6cy
         tLT6ytiT1XB7XC1MtodXlb+I3iEISFHQ0sabeK2fu+P0+dIjztLik/gRV8v75F5u4b6n
         P4SFHP9WFNCp7Gjg3l5xhNH4wDk8EmVNowJ0yzuH+oYxkbsqxHQGzGZIg1vpUa/IJe6z
         RTGkaDpjUbMQR2DZu0LTPNx+l3gVWesic7lP5CGpWZE3U1QcfjdLpklzchjQseOBS4az
         VyIdCD4XTk8tEPNkZqaw533z1xXpO30ow/m6XS2W6sL/V8y/Up55NwizvxDJ5ruvjnv3
         De1A==
X-Gm-Message-State: APjAAAUuQWimok4g0jx+4vdyt1HP3LLBjpB8b9mVYbkew0R0mKMpqdMy
        POtHZR49iYn6nTC0ukVrSs574GmXO2B+0+RyvflRWg==
X-Google-Smtp-Source: APXvYqyjLQjypIx0lAAsJdK3Q9+SsDuGp9NLFu0+lPAP4arGDInBvniKXYzdtY+4W/d9Hbph5+kW5uMADPJ2pNfEJYU=
X-Received: by 2002:a02:5143:: with SMTP id s64mr13575624jaa.54.1559475276744;
 Sun, 02 Jun 2019 04:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8nMcVuLeLWrVumLaz2Pbi3GugzgY-Bw3SMipjJkaph85Q@mail.gmail.com>
 <20190602132150.4c1b320f@naga.suse.cz>
In-Reply-To: <20190602132150.4c1b320f@naga.suse.cz>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sun, 2 Jun 2019 07:34:12 -0400
Message-ID: <CAH8yC8n8XN1wKiF4FgTm6xfnRHUDi+1=iuWXE8F91P=7mLNsLg@mail.gmail.com>
Subject: Re: SHA-accelerated Git
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 2, 2019 at 7:21 AM Michal Such=C3=A1nek <msuchanek@suse.de> wro=
te:
>
> Hello,
>
> On Sun, 2 Jun 2019 06:43:07 -0400
> Jeffrey Walton <noloader@gmail.com> wrote:
>
> > Hi Everyone,
> >
> > I have a lot of experience with cutting in SHA acceleration. I have no
> > experience with Git.
>
> sha1 is dead. Git is planning to move away from it. It will not happen
> overnight but it probably does not make sense to accelerate it at this
> point.
>
> https://github.com/git/git/blob/next/Documentation/technical/hash-functio=
n-transition.txt

SHA-1 has been dead for years. That has not stopped Git yet :)

My guess is, Git will have to carry around a SHA-1 implementation for
a decade or so for interop purposes.

> > If someone would setup a fork and provide a call like:
> >
> >     // https://github.com/torvalds/linux/blob/master/arch/x86/include/a=
sm/cpufeature.h
> >     // Or whatever the project prefers
> >     has_x86_sha =3D cpu_feature_enabled(X86_FEATURE_SHA_NI);
> >
> >     if (has_x86_sha)
> >     {
> >         sha1_hash_block(state, ptr, size);
> >     }
> >
> > And provide a stub:
> >
> >     sha1_hash_block(uint32_t* state, uint8_t* ptr, size_t size)
> >     {
> >     }
> >
> > Then I would be happy to fill in the pieces.
> >
> > I can also help with ARMv8.
> >
> > In fact, if you want to use Andy Polyakov's asm from Cryptogams
> > (https://www.openssl.org/~appro/cryptogams/), then I can help with
> > that, too. Andy's skills are renowned and his code is used in the
> > kernel.
>
> And buggy. I am not referring to the sha1 implementation in particular
> but to the hand-crafted assembly in general.
>
> Do you have some performance data that shows significant improvement of
> common tasks that makes maintaining this hackery worthwhile?

Well, considering Git carries along an SHA-1 implementation with
undefined behavior, anything would be an improvement since it can't
pass acceptance testing out of the box. And Git does that for a 0.01
to 0.03 cpb increase in spperformance.

For SHA-1 intrinsics on x86, performance increases to about 1.7 cpb.
For SHA-256 performance increases to 3.8 cpb. On ARMv8, performance
will increase to about 2.0 cpb on A-53 cpu's, and about 1.5 to 1.0 cpb
on A-57 cpus.

Comparing against a standard C/C++ implementation, Git will see a 3x
to 6x speedup depending on the platform and algorithm.

Jeff
