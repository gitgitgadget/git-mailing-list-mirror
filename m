Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A4AC20248
	for <e@80x24.org>; Tue, 26 Mar 2019 04:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfCZEOd (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 00:14:33 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38696 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfCZEOc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 00:14:32 -0400
Received: by mail-it1-f196.google.com with SMTP id m18so17711937ita.3
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 21:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jH/tA5f0QVVG9blIwbwl8TWZDNleGZoJ6ODiWUUkkgA=;
        b=HWW2AldV7IJ1l04GNHw2t7BQgjW6xU8G/H0FhcKbWli3eH9ZJdcYAus/+7rhdcf6i+
         D+TU8ta7Qe55ECxBg+q1sCfmYhQV/F1ZMP+NcaCsxu2O7t/UeweiInNhGAeO50UR1iot
         eiiwiLRtl06jBma20mZeIjT75YDF+uajE2rDSx1EWhsbB+xi9X52WTYb/d+2pJfkjdsZ
         YInM+SdJm5OrtMhQKwlKv2vSsDV15QeI4ZSzyYuYh3QWgED0UuFu4jvzk3pI2wJzlG5g
         bba4DygQFIW6A1+guQTetM5UTP50YeoITzXsS8Sm3JhJ9a/uBNFqWGZAwchMklzZyDI2
         AtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jH/tA5f0QVVG9blIwbwl8TWZDNleGZoJ6ODiWUUkkgA=;
        b=G7kx0BBHSF/G8xNNS4l+bMburh006bpnvo5TMRw+galdBJLho9y9mB9U+BFtNGl0yf
         bDsT0DxcZ5BLPreMWj2hCq8urh4Nb3PDhE3QarAh+gOYrRcQUXb4XSoC8jmunV4L8px3
         eSwFT22sqGkT+ImRguneznsJgMgadb5Ud68bl9/6uJDDZ2p5RafQn1DG5LEoy1owcdvJ
         wHYmieN0/g/VF3OELk3QbpfhNEpYDiuO8mLj0+nCN5qVywp2QNnQdIGlVo4lM6ckHJz6
         4WQ61b1Z152z/llxLalzTf4eHfjwE7kvhUb3gvEGo2xUZZVEiUkWkXnp5EYyPXf3g5tf
         rWNQ==
X-Gm-Message-State: APjAAAUoyx9UfVwSMR6tZnEtAIwdSqQ1P/pJPhY27h33gf5OD9/MT9BT
        LIgqhrG/yIg8zn39wCadPUEqLYuAKRQ+RIXJQCI=
X-Google-Smtp-Source: APXvYqwvYHTF8GyInZwGNVT86VH/RHDFeZqEqT7J3ZKofj+CyVmbnyTbRS1PLTOEV/wl2rPizn03Em+PkpoR7dohglo=
X-Received: by 2002:a24:7542:: with SMTP id y63mr1957458itc.70.1553573671552;
 Mon, 25 Mar 2019 21:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.167.git.gitgitgadget@gmail.com> <20190325202329.26033-2-avarab@gmail.com>
 <CAPig+cR0Ldt3EpQ683ZFNFXggfsTrdeZ3R-V6pDBZNA1N3c+xg@mail.gmail.com> <87o95ybmgf.fsf@evledraar.gmail.com>
In-Reply-To: <87o95ybmgf.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 26 Mar 2019 11:14:05 +0700
Message-ID: <CACsJy8Bk=Z8BaVeAhKzF4PWYLLG76cADooHKNw+Xy3EztZL1DQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] parse-options: allow for configuring option abbreviation
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 26, 2019 at 5:48 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, Mar 25 2019, Eric Sunshine wrote:
>
> > On Mon, Mar 25, 2019 at 4:23 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >> diff --git a/Documentation/config/core.txt b/Documentation/config/core=
.txt
> >> @@ -1,3 +1,15 @@
> >> +core.abbreviatedOptions::
> >> +       Defaults to `true` which allows options to be abbreviated as
> >> +       long as they aren't ambiguous, e.g. for linkgit:git-init[1]
> >> +       the `--bare` option can be abbreviated as `--bar`, `--ba` or
> >> +       even `--b` since no other option starts with those
> >> +       prefixes. However, if such an option were added in the future
> >> +       any use of these abbreviations would break.
> >> ++
> >> +By setting this to false (e.g. in scripts) you can defend against suc=
h
> >> +future breakages by enforcing that options must always be fully
> >> +provided.
> >
> > I don't get why having a configuration option is better for defending
> > scripts against this problem than a simple environment variable. It
> > seems easier for the script prologue to contain:
> >
> >     GIT_TEST_ABBREVIATED_OPTIONS=3Dfalse
> >     export GIT_TEST_ABBREVIATED_OPTIONS
> >
> > than for it to muck about with git-config or use "git -c
> > core.abbreviatedOptions=3Dfalse ..." everywhere. The commit message
> > doesn't do a good enough job of justifying the configuration option
> > over the environment variable.
> >
> > Also, if this is now intended to be more general (aiding script
> > writers) than just being for our test suite, then dropping "TEST" from
> > the name seems warranted:
> >
> >     GIT_ABBREVIATED_OPTIONS
>
> If we want to make something user-configurable we tend to add config
> variables. The GIT_TEST_* variables are only intended for our own test
> suite, see t/README.
>
> I don't mind documenting this, but it's a well-established pattern, so
> if we're going to describe how this works/why use one or the other it
> should probably be some other series to t/README and/or git-config.txt
>
> We traditionally *only* expose this sort of thing to users via config,
> and not via env variables.

If this is mostly useful for scripts then I agree with Eric an
environment variable is the way to go. A configuration variable does
not make it more convenient.

And no we don't only export via config. There are a bunch of public
env variables in git.txt. "core" namespace is already very crowded. If
this one is only rarely used, I'd rather not add a new config
variable.
--=20
Duy
