Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B8EC43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 19:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiGOT6x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 15:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiGOT6w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 15:58:52 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762B6140AD
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 12:58:46 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 19so6834196ljz.4
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 12:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BV8Hz1b05YwrcPLmewb42015RsZ03q0Mbt/9CeHssY4=;
        b=FBlx/inkE9VLzo+yU0zxu0/TT5YK/sY4umb4731D5AFoLUYRvZvpedWJafeGTR+Q2N
         eUK/uQDLBAe4wvKDycEOiJQrbul39+wLRc1C/tIpqSjMaMCX8vUi/Wc/+NEiK5e9AYCd
         wFdEyvjuLDC3zWaR1p/w1gEKtskpjG9VE5mkBEJ4zNQf+IK0hd/KfztCC5H9WoX1qy9x
         xbBJzBBq/J9aZAEceiEnB8byStEsWEjTs8ILZSVl9TbjY1XyyTYKvjAX40bL2FhYuao2
         Lyjsg7AMCZLymflL//eO+nN4nfpJABH4dvoCI/LGl4sP/F+P0P/TKbnTth+YVsMDRlhl
         RC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BV8Hz1b05YwrcPLmewb42015RsZ03q0Mbt/9CeHssY4=;
        b=cyxBUJqY0HoHSuCGZbdGUrfX8RhXZkq5xWlXMN3KlYxrNNPY3LIlhLIDiGlyLQz+Li
         9mjk9kp2qUmuy4+h1zNfejBkNOh7eyDWLoGUlsngr0EzMMCce4tM5hviUuZUusLDVvdm
         TOBwUNHMud5DYZq97f6TJ6wEbFTNVOUo4WQdJr1yuMbleC9ouf13XAsamnHnbA0fewYz
         sFE1aMeCx/MMoGkGS4bm5LyKBzdZz3dTOnsSpshUFFGSS/PycWazOMa+SieuW8npVARq
         eqhUuL6JIeHZ5v1yty47CJdRapzT/2LyE18t1BP4yg3ZZn2H1uU9QT7gCgMJH7SRuIym
         Jiog==
X-Gm-Message-State: AJIora96ZCrQrgkmiPLG5TvaWKp1zzGFwtyB+e0cFGRPKpw3M2jXGtcw
        jkF3A2MBcYm5oYY4nnMarevaNeRjzH0SkJ9LpRZ3DKFvrpsYhQ==
X-Google-Smtp-Source: AGRyM1t6UnrM81GOUa27Ad8W5Rjd/1s+fnOPew3hFVkTZu4vWR2zj7zyGnOXT6x/uZH57vtBejIIEQ1u55JWvBD9eoc=
X-Received: by 2002:a2e:8255:0:b0:25d:8d25:b291 with SMTP id
 j21-20020a2e8255000000b0025d8d25b291mr6773950ljh.334.1657915123359; Fri, 15
 Jul 2022 12:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657819649.git.matheus.bernardino@usp.br> <220714.86ilnz1j1i.gmgdl@evledraar.gmail.com>
In-Reply-To: <220714.86ilnz1j1i.gmgdl@evledraar.gmail.com>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Date:   Fri, 15 Jul 2022 16:58:31 -0300
Message-ID: <CAHd-oW4zHA1YLX-5B1vYTA1f8PocziUCi0WxvSEkFUuf2GqKxg@mail.gmail.com>
Subject: Re: [PATCH 0/3] doc: unify config info on some cmds
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Em qui, 14 de jul de 2022 18:27, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> escreveu:
>
>
> Here's a cleaned up version of what I have, which I figure is probably
> better linked-to than contributing to my E-Mail quota :):
>
>         https://github.com/git/git/compare/master...avar:git:avar/doc-con=
fig-includes

Thanks for sharing your version!

> The one thing I'd like you to reconsider is to drop the idea of adding
> these "ifndef::git-grep[]" defines and the like. In your version it
> yields an arguably better result.
>
> But I think what we should be going for is the more general direction
> outlined above, at which point that becomes quite a mess of
> ifdefs. I.e. config/gc/rerere.txt would need to know what it's going to
> get include in, which would be N number of manpages in the genreal case,
> not just "main or config" as this series leaves it.
>
> I think the solution I have to that in 1/9 in that first series is a
> better trade-off, i.e. we just (eventually, your series doesn't need to
> do that) include some standard wording saying that what you're looking
> at in git-CMD(1) is transcluded as-is from the relevant part of
> git-config(1). I.e.:
>
>         Everything below this line in this section is selectively include=
d
>         from the linkgit:git-config[1] documentation. The content is the =
same
>         as what's found there:
>
> What do you think about doing that instead?

I like the includes/* idea, and I agree that it is a more sensible way
forward than the many 'ifndef[]::git-cmd.txt's :) Your linked changes
also cover a wider range of cmds than my series does. So I'd be happy
to have them as a replacement to this series.
