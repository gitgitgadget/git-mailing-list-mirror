Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263C7C6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 08:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiITIlv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 04:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiITIlV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 04:41:21 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D0E1031
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 01:40:17 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 78so1826148pgb.13
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 01:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=77F+ci81mYtdeIf3rYa6GejmXOXciQfn7EQHcfIk5Dg=;
        b=XhszRY0jKBuVQj10Y2XHex5lxkQUpXDnB4cKClLeVtaJfYGUGG1JdMJ+FNmM03gIQ4
         zVtpdGNsPE4Z8Cl62kou1GaDBvskboZtyftd9QUKjT/WD3LVY58XLAZCq0utYtn2/R3k
         F47xpJPWfoAGHerXAO9xfY04nwwvHt4KlNGupOKLRLK/QeGQDEkGG8i2NQgdyPeyA9tC
         PBZT+Odwx5IMz3UlWlKQ736nnCkGLDUEYouvb/qZ5iMF11Fmg9IRknMUZ8XEpfC+jBNy
         YZ4gYpuP+AZaqKvLNtJo3jF0bhbT6xfKV2LdaWEi59wjSpbdirKKmj6w1oA9flX1YEN7
         SVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=77F+ci81mYtdeIf3rYa6GejmXOXciQfn7EQHcfIk5Dg=;
        b=Tzzsv/KEOoRx2kLE22oeRsW5VmJHKVY4i0S4Ia8uMcPOGnq7JbHIxG5V+cu7F7rjpi
         /5OxM9ya5oKoU2k1ci4g3EiBaiVtqyU07K/tURMLCubOmWFOsuNtKM/09IuLS1jDReeP
         je3uTpteRch0BnXynuJbPS0tY8JSINJRQMh0nzjd6GgbXs0UNVzcxwsqywUNRtGBShRZ
         877HRHBwLPW0xgGAQGFSRgb9F+Q/KNu0ygUIyArmYf+epKYHje4COMksO4BIaN1S223Y
         S1Msz3yS4R2PI3tUXA8hPz1gNp6BTDRwdaTAaIZWF0xdwnJpKOob9xilZIiUwW1svoxi
         kx0A==
X-Gm-Message-State: ACrzQf1d3Ujj2sVvy5mqcdcWqcXijC8Qba8g7s+95JqKp6nhhOxHgrz1
        GGlURR49IMkb1A/H2z7E9VLOR/b2O3C4TWhqTSI=
X-Google-Smtp-Source: AMsMyM4co7MFRkgkCSydw3YMqtI2RD8SDiSUcYSoT3Uwrdo4enwvNA92sj+a4fYMce7fkL33O2fWjkUwxoRk1lCQvhY=
X-Received: by 2002:a63:1864:0:b0:439:4c72:429a with SMTP id
 36-20020a631864000000b004394c72429amr19732885pgy.35.1663663217097; Tue, 20
 Sep 2022 01:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <CA+J78MWhp3qmbBhhSoioJP+d5eh-iEd_vHZdTNB69o7EvvXWYQ@mail.gmail.com>
 <220919.86zgev635z.gmgdl@evledraar.gmail.com> <xmqqbkrbb6ua.fsf@gitster.g>
In-Reply-To: <xmqqbkrbb6ua.fsf@gitster.g>
From:   Skrab Sah <skrab.sah@gmail.com>
Date:   Tue, 20 Sep 2022 14:10:05 +0530
Message-ID: <CA+J78MWvOEbJY6+NcLFn0SJGMZn=N7QUMwc=Bta+uHicvD892w@mail.gmail.com>
Subject: Re: what if i use makeheader tool to generate c header file, it would
 be accepted.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let me elaborate to you, how and why I wanted to implement the
makeheaders tool in the project.

First of all, this program will automatically generate c header(.h)
files for specified c source(.c) files, which will help the developer.

Here the test shows how the tool can be implemented in different
cases: https://github.com/skrab-sah/makeheaders-test


pros:
    1. it will slightly reduce the size of the project.
    2. no need to declare anything in the header file, which is time
consuming and a headache for developers.

On Mon, 19 Sept 2022 at 23:10, Junio C Hamano <gitster@pobox.com> wrote:
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> > On Mon, Sep 19 2022, Skrab Sah wrote:
> >
> > Just sending a $subject is rather light on details, so I'm having to do
> > a lot of guessing, but here goes.
> > ...
> > In case this is a genuine "prep question" that you're asking in
> > wonderining if you should even waste time on coming up with a patch to
> > do $subject I want to say that:
> > ...
> > Now, this does *not* mean that we're not interested, but just that we'r=
e
> > very big on a "show your work" approach to things.
>
> Perhaps this should be made into a FAQ entry?
>
> In general, we do not give promises or guidance, but something a
> contributor finds it rewarding to work on, whether we would leter
> accept in the upstream, will spread among users and developers, and
> eventually we would come begging to the contributor for upstreaming.
>
> On the other hand, a new thing that the contributor who thought of
> does not feel it is worth investing their work in, if only to use
> for themselves, is unlikely to be of interest to us.
>
> So saying "if this will be accepted, I'll work on it" is counter
> productive, as it is easily (mis)taken as a sign that it is the
> latter case.
>
> In other words, make it so good that we would come to you.
>
> Thanks.
>
