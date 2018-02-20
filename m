Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60BA51F404
	for <e@80x24.org>; Tue, 20 Feb 2018 20:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbeBTUoy (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 15:44:54 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35646 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbeBTUow (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 15:44:52 -0500
Received: by mail-pf0-f170.google.com with SMTP id a6so3930786pfi.2
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 12:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hwlEjLoERtzkzDHRMYJ1OVzXqBW24d878FMA6SiTvpk=;
        b=K/5Nx5AX/ePD+rRek+lxpNBjNdDAAvqpQT0adaa/KLRWAelj9mpkptIfypQ4QjX87A
         puUVp4RoloULeo276jiZEfMnLV+VGgUys57qrw+ookcTfQBdS5FsItOBDisBhNrid1m3
         194FAX2M5gL9Uu9rxW90ZG65ZQqtY2goczd5qVgnI5MWtLiGGMvEQHaRCJk1mfxWJ+Xg
         bFx4IBoJwcTzB3NTUlEJjEh0AeE4ivun5ufguLTdP39uIMoJaAEtDbJCjoPXwcI0+jgQ
         k1X5TaYD9XahO++qKDtFenImRg0TzdjEc/3d7e60fJ22cKY9kNd7G3JABakO0TgbWW6W
         sAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hwlEjLoERtzkzDHRMYJ1OVzXqBW24d878FMA6SiTvpk=;
        b=i10uLn0S2yJVIl9wHAr8MBgaJbJjOf4TagKB41lIYLbXpjWRc3DXOgxwdK55lDD7N2
         U7WUveKQUpl4f7Hy21Yt3yFI9qz818luPlwahUSihycNQOXj4puE3b7mjgay2CENoNi5
         SySwrm4vQ4AjYOn8xNRjGQJkklg+EyTpdhHxH9lvJUMaO7bUEMcgcfZAJfedChdX25dU
         COh79sB5KdrbAm4nsSNwFJQiCDNnYAYmqU8Efcn2qSNtlawCULDxVmxLLqQxHrFx7gav
         qnnDMq3gv+U5jld/d74ufMJkAqNY6OH4Jm+GBXUz8Fil1kW7StDQd7VZP8x52JXasrJr
         IFgA==
X-Gm-Message-State: APf1xPAYVK4uunIuqRAbu/pkbK7bXE/iMsbsfLzyjGkAjBft6Pg836cP
        6SpwxNE//FdXyJsEQT90Jc4+jV86o26ZfP4LBQ8=
X-Google-Smtp-Source: AH8x227H1v/0KCrfhSNgYW/4w/yE2PGJcTewnanXY2XAsy6XQI0+c2lJkypg5TnCgdYHM2kNWAKBiOyR48HXZVNsUTc=
X-Received: by 10.98.7.73 with SMTP id b70mr834479pfd.39.1519159492166; Tue,
 20 Feb 2018 12:44:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.236.191.144 with HTTP; Tue, 20 Feb 2018 12:44:51 -0800 (PST)
In-Reply-To: <20180219212937.GB9748@sigill.intra.peff.net>
References: <xmqqo9kro4oq.fsf@gitster-ct.c.googlers.com> <20180214215637.6462-1-martin.agren@gmail.com>
 <20180219212937.GB9748@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 20 Feb 2018 21:44:51 +0100
Message-ID: <CAN0heSoDJdA3tTVZZ=imj8+z5FeqKy00dA2kWP4CAC4=+7VBiw@mail.gmail.com>
Subject: Re: [PATCH] t/known-leaky: add list of known-leaky test scripts
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19 February 2018 at 22:29, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 14, 2018 at 10:56:37PM +0100, Martin =C3=85gren wrote:
>
>> Here's what a list of known leaks might look like. It feels a bit
>> awkward to post a known-incomplete list (I don't run all tests). Duy
>> offered to pick up the ball if I gave up, maybe you could complete and
>> post this as your own? :-? Even if I (or others) can't reproduce the
>> complete list locally, regressions will be trivial to find, and newly
>> leak-free tests fairly easy to notice.
>
> I didn't think about that when I posted my scripts. In general, it's OK
> to me if you miss a script when you generate the "leaky" list. But if
> you skip it, you cannot say whether it is leaky or not, and should
> probably neither add nor remove it from the known-leaky list. So I think
> the second shell snippet needs to become a little more clever about
> skipped test scripts.
>
> Even that isn't 100% fool-proof, as some individual tests may be skipped
> or not skipped on various platforms. But it may be enough in practice
> (and eventually we'd have no known-leaky tests, of course ;) ).

All good points.

> Or alternatively, we could just not bother with checking this into the
> repository, and it becomes a local thing for people interested in
> leak-testing. What's the value in having a shared known-leaky list,
> especially if we don't expect most people to run it.

This sums up my feeling about this.

> I guess it lets us add a Travis job to do the leak-checking, which might
> get more coverage. So maybe if we do have an in-repo known-leaky, it
> should match some canonical Travis environment. That won't give us
> complete coverage, but at this point we're just trying to notice
> low-hanging fruit.

Right. A Travis job to get non-complete but consistent data would be
"nice" (TM), but at this point it would perhaps just result in
blacklist-churning. At some point, adding/removing entries in a
blacklist will have some signal-value and psychology to it, but right
now it might just be noise. (My patch adds an incomplete blacklist of
539 scripts...)

For finding this sort of low-hanging fruit (windfall?) any local
scripting and greping will do. I sort of hesitate wasting community CPU
cycles on something which might be appreciated, in theory, but that
doesn't have enough attention to move beyond "every now and then,
something is fixed, but just as often, tests gain leaks and the
blacklist gains entries".

To sum up: I probably won't be looking into Travis-ing such a blacklist
in the near future.

Martin
