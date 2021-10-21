Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3B0C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 12:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1659B60F25
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 12:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhJUM6O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 08:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbhJUM6M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 08:58:12 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D08C061749
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 05:55:57 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id r4-20020a4aa2c4000000b002b6f374cac9so104030ool.6
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 05:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sWL+hL/o3lUbRxjl8NH/XH88xNidJ9oUfz63ROqPoUU=;
        b=q6d2n1WgC7QOsgl7Ug5EyIWafs4yYya9Wp7kbxE80U2gT7QyY5/flTCgEuiHCmwhjN
         J4H7yK+a3zcqF8wd/6b17zRqcn+2bMWP9Iw+BU1Z8wvdWRZYGYkm2fA08mT7ZVuBreGC
         KPhZbSds0YFnFT6tQUVHrtYORD0NwNtwmTnsFH9Bvl2IrlOrhqBrmq0KFMe7Txx0CQjw
         ouwd5HLgyzcnGp9qbluVd6gmTYb+OI0a35ivr0yBVafzE8tXtgwxzD5aZpQlPVkFBwBf
         +tBc9C1/U3VyQWGmV94PYTD4L2bonr1MBLr4biA5oZepwtcFtWNN+hp+0kkmmlQhIPcR
         8oEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sWL+hL/o3lUbRxjl8NH/XH88xNidJ9oUfz63ROqPoUU=;
        b=vOXij0vJ8QIUjXba0bxxgyoRNrbSGRSasjiKaerVCi93d0SKb5rG0I36mJsOvF22FV
         vuUwPt8ab2BF8LFVnAmBKuaBDdilMrms+iwNjBTYSF1sw1fPRkXIbOd3tGGRQmmbky3P
         KJx4q/5JKYAPWdPG9ARc9ounHn2zqCeannimWEAQ8y2+om9tb4nk00dO3szOZksPn81t
         JFI0DbU0but/59pePk9xuYlViLmyuS+nM6AMrWxkYon0U4sPz51m4Fhum9gPJdlvQXdg
         WR/wgEdMV4F4FSJdlppVVyH8BvOTsopQA7vVotzyx4009KV9+csLJLwhank7AHvALEcR
         mS/w==
X-Gm-Message-State: AOAM530GLkmAiMg4umlDEWIFr60usFdVAIwEhc3xkKLM1lpYpt4wu0+r
        ldH+EmYysw4vtVzf4UF9J003NWZ2UfUHA29XwYo=
X-Google-Smtp-Source: ABdhPJxykzPNYCme3YljRJW7FibqjM21WVUI7poFWIWh1McVlR5BBjVbPGx1W9h+mTFUqk+rTlCmwR47aFVLQ+gJAYg=
X-Received: by 2002:a4a:b501:: with SMTP id r1mr4223677ooo.20.1634820956564;
 Thu, 21 Oct 2021 05:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2110211149530.56@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2110211149530.56@tvgsbejvaqbjf.bet>
From:   Son Luong Ngoc <sluongng@gmail.com>
Date:   Thu, 21 Oct 2021 14:55:45 +0200
Message-ID: <CAL3xRKe6Ewps2n54KED7kX=8=Nk7RWHvTkhoB2X-Y1-ZjKEizw@mail.gmail.com>
Subject: Re: [Summit topic] Increasing diversity & inclusion (transition to
 `main`, etc)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Oct 21, 2021 at 1:57 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> This session was led by Johannes "Dscho" Schindelin. Supporting cast:
> brian "Bmc" carlson, Jeff "Peff" King, Taylor Blau, CB Bailey, =C3=86var
> Arnfj=C3=B6r=C3=B0 "Avarab" Bjarmason, Jonathan "Jrnieder" Nieder, Derric=
k Stolee,
> Lessley Dennington, Glen Choo, Philip Oakley, Victoria Dye, and Jonathan
> "Jonathantanmy" Tan.
>
> Notes:
>

...

>
>  5.  Git the community is still overwhelmingly male, white - what can we =
do?
>

...

>
>  19. Stolee: When we moved from MS to GH, we received quick feedback that=
 we
>      weren=E2=80=99t communicating well - too direct and unemotional. May=
be Git
>      community communicates that way, but that=E2=80=99s not how most peo=
ple interact;
>      that makes me think that our =E2=80=9Cefficient and effective=E2=80=
=9D communication is
>      actually too aggressive, and easily interpreted as attacks on
>      contributors. Basically=E2=80=A6 let=E2=80=99s all lighten up? :)
>
>  20. Taylor: Yep, my =E2=80=9Ctalking to GitHubbers at GitHub=E2=80=9D vo=
ice is different from
>      my =E2=80=9Ctalking to Gitters on Git list=E2=80=9D voice. New contr=
ibutors, are we on the
>      right track here?
>

...

>
>  34. Avarab: I think it=E2=80=99s a good thing to work on; we need to be =
really careful
>      about what guidelines we pick and choose. Need to ensure an easy pat=
h for
>      new contributors so they don=E2=80=99t need to read hours of documen=
tation for a
>      typo fix. Plus we need to ensure that this doc is accessible for fol=
ks who
>      have different first language than English.
>
>  35. Bmc: on git-lfs we have a contributor with very little English, so w=
hen we
>      did the review I=E2=80=99d offer an alternative text, and we would w=
ork together.
>      That process was useful to come up with readable documentation in a
>      helpful way. That is, proposing a solution instead of pointing out t=
he
>      problem and saying =E2=80=9Cfix it=E2=80=9D can help a lot in scenar=
ios like this.
>
>  36. Dscho: Yep, this is important and will help us be more accessible to
>      contributors whose English is not super top notch Cambridge exam :)

Yes, thanks for mentioning the non-English speaking community.

I have been an avid reader of the Git Mailing List for the past years and c=
an't
help but notice contributions from folks working in Alibaba(China) have bee=
n
taking a lot more iterations to get to final reviews than usual contributio=
ns.

I would recommend, on top of having a guideline document, to have a
Valve check (1) setup as a commit-msg hook and run it as part of
GitGitGadget CI to help folks shorten the feedback loops in some basic case=
s.

Cheers,
Son Luong.

(1): https://docs.errata.ai/vale/styles
