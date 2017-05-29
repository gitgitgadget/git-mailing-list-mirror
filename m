Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55AE32027C
	for <e@80x24.org>; Mon, 29 May 2017 11:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751138AbdE2LUZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 07:20:25 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36152 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750974AbdE2LUY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 07:20:24 -0400
Received: by mail-io0-f193.google.com with SMTP id f102so6557171ioi.3
        for <git@vger.kernel.org>; Mon, 29 May 2017 04:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DT1Bx8RGjKS/nau5UopJjuqF1rl+aE+opwNmKpT1WsY=;
        b=X4xfxmnO3mGL/WdOMXiqvMfFQ6aMSTLrUXgHGgUqsqYHgOEmIRMUiA1xE36cyGd7UF
         I1oODiOI4j5oWiaRZ6c8kEcfzfBeFqHS4MdycJkH8zrzpbLoUmSDXOuZd7ERISNA7i7d
         4aa92INKzdJFnOD3uJAXC2gMeZU0ClgmYB0Q43y6+xa7qOUUps4QVCIvgwYpbQGfFiJX
         bnkgkvihRN15vT4GFBtHu3Yc0hMkwVjyqeHxwLo59QzsUgnnylVbf7Q6Ow8oBLcwqiWQ
         3Ibnk4B6hDrwVRcepr9WBwQS1NldRzcaopuPw0Y/ZOHmztlfC+aIbw355kiq4y/iN6lN
         NWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DT1Bx8RGjKS/nau5UopJjuqF1rl+aE+opwNmKpT1WsY=;
        b=rJi1XEso6XH3aXU2x6dc4yfoaKYSzsjzhZl4vHKNSJMBRyhk9OZ2+fgxLae3UOk7P1
         QI0z74qUie8XJKy4QiJ1XMSgFrCf70jdiJ7wGweHIToJlpr2iO77XbtFXZX+/w4GxY5i
         +EpCzhBJYboXtmgjRR6bWhmokC030D/p2/QhoZSrZFWT2orTBmseBrcSpUQOuO1bk4K7
         /uzWtjOohYg1ENXQr2BIA72gRogC8f0KUbZM41r722We3U/sqlrX5ehwzTnkECCYckwF
         zMzzL3pxvJZTy/QhJbemsrQrD+mKp8Jr8XufZDQAyGOHIKWJNSo/Xqe1h81Hhu/Ayx1q
         c9nA==
X-Gm-Message-State: AODbwcBeW70LhLDKEwPFyEGD7ir+u5Q2GADnqoHC08OQddLieMeirPws
        th4eS4e/mLwRWsNmm7ojPlnOalRg/g==
X-Received: by 10.107.178.12 with SMTP id b12mr11910814iof.50.1496056823190;
 Mon, 29 May 2017 04:20:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Mon, 29 May 2017 04:20:02 -0700 (PDT)
In-Reply-To: <CACsJy8CUpHNDfvN+P7=Jub4+Z281rzExFV9x3_hdVKw6ORUSqQ@mail.gmail.com>
References: <20170527111032.30897-1-avarab@gmail.com> <CACsJy8CUpHNDfvN+P7=Jub4+Z281rzExFV9x3_hdVKw6ORUSqQ@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 29 May 2017 13:20:02 +0200
Message-ID: <CACBZZX5SbYo5fVPtK6LW1FF96nR5591RHHC-5wdjW-fmg1R0EQ@mail.gmail.com>
Subject: Re: [RFC/PATCH] WIP: add deprecation & experimental process/interface
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 29, 2017 at 12:23 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, May 27, 2017 at 6:10 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> This is the WIP start of a deprecation & experimental interface to
>> git. The goal is to formalize the workflow around deprecating
>> features, or around introducing new experimental features.
>>
>> This is much more idea than code at the moment, but included is an
>> example showing how :/ might be deprecated[1] (let's not discuss /if/
>> we should do that here, this is just an example).
>>
>> The plan, subject to RFC feedback is to:
>>
>>  * Add a new config variable `core.version`. E.g. `core.version =3D
>>    2.14.0` With this the user can specify that they'd like
>>    new/experimental features introduced in that version (and below),
>>    as well as immediately getting new deprecations added in that
>>    version as errors.
>
> We have extensions.* for this purpose (or close to this purpose). I

From reading repository-version.txt it seems unrelated to what I'd
like to do. I.e. there you'd like to introduce a hard breakage and
it's already documented that if you encounter some extensions.* keys
you don't understand you *must not* proceed.

Whereas for this you'd like to e.g. turn on some experimental feature
in 2.16, but if you're running a 2.14 git you'd like it to just ignore
that config key it doesn't know about instead of git breaking.

> think it's more flexible to go with extensions.* instead of a single
> "core.version". extensions.* are non-optional though (if a git binary

I'd like there to be both, and the experimental() function would
define this on the source level, i.e. the call would include a
corresponding version where it was introduced, and a config key to
toggle it individually.

The reason to have both is that you can just upgrade git and say "I'm
not concerned about backcompat here, please give me all the latest
features" without having to exhaustively hunt down the list of things
we're shipping with that version.

> does not understand it, the repo can't be accessed). So it's more
> about fundamental experiments (like sha256 transition). I'm guessing
> we can have a "soft" extensions (warn if not understand, instead of
> die), like what we have in $GIT_DIR/index.

> Deprecation via extension.* though may be unintuitive. But I think
> something along that line (e.g. deprecation.*) might work.
