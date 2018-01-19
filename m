Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA8FE1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 17:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932379AbeASRb5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 12:31:57 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:42816 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932352AbeASRbx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 12:31:53 -0500
Received: by mail-io0-f181.google.com with SMTP id 25so2928639ioj.9
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 09:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xDyMUj1ys56A5vs+4yiTLWw1xHAZWVlD3S4MOK3xoA8=;
        b=SOAvkgwIG78NELaIY5FYH9cfjjVIUPYo0qUNPwkVuH0aEbZEhpABGJ5XruVFrrYJ1H
         gabcMpFR2pZmVeDTxq79XqM3uPnpJ3ctf5JBkBstT6cqCt2M082wXR3xbic4q7EuWb0p
         eJ2+yRFC1rbVWNpf3mj24dE7kVx+ivRz2NI8b0d0oER0mZbNHLEn9c1nY8up/c7pixzs
         TbCTqyTZopFSfqRz+FHmc4PBVFpzFUsEtvt2u9U+S+i7hOcTVeVrDZvJeaw7zJf0/Nb3
         gJmGZ0SIQ/crKnYJFYAqb/bkQUYW5ahfEBHLLTXDT2AwGwm9e1z+QNoEKvZtR1gcf76n
         AceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xDyMUj1ys56A5vs+4yiTLWw1xHAZWVlD3S4MOK3xoA8=;
        b=OeqC61VZC/9ujVT5bsqOgrwuo4p39r8rkiL5wofLbbO5zuVeBQWs2wf1CljxSr9KZi
         7Vo9UHOa/+aYPjkBXRoWmWggXNFR/bgLrkVWS+VrAowmdj2RYdVazfoxf9f5afavl0R9
         AfSuABWVUvISPX1dNBlL6Nr1L0MtMEyt/PZa8JpKVRbsHhXqTrUMqrd5zn4FqzVVC5CH
         b6zIbbCV4xbD+ijMq932S1YP0cZC6exjwOMOwLG5Y400aFdno4OtRNogJMvRPDrJ1CzP
         XAtOl+Mw7bgb6J4hwTXgbgoJ3gx2eGp09RLfEPI/lFzYNV1+a3tm/zCGR8Cwl+6I81Ye
         4vow==
X-Gm-Message-State: AKwxytdyWqp+8gSVHiqlMoLi/yhDxB+RvBNsusxosjB9nCLb8Nisl1S6
        NgzPvwLpQp75rHE7HU173IWLAxe6npWlJbz4Y+E=
X-Google-Smtp-Source: ACJfBou5wN70qIcB1SkhtCAXKRC+rF1tp4QeBExXvE9tgq0KbGe2dDdsMtGGiaOV474yo7Ok96EmKcUZsX30z32qHI4=
X-Received: by 10.107.3.209 with SMTP id e78mr31963263ioi.96.1516383112641;
 Fri, 19 Jan 2018 09:31:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.201.204 with HTTP; Fri, 19 Jan 2018 09:31:52 -0800 (PST)
In-Reply-To: <20180119172353.GA5752@sigill.intra.peff.net>
References: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
 <01020160df6dc529-fae54bd6-e595-44fa-9f9a-c44cb3a5a1a8-000000@eu-west-1.amazonses.com>
 <20180115214208.GD4778@sigill.intra.peff.net> <CAL21Bm=+uPrKECcCq2_rfJRuCpsOjZ41NfiyY3d1UA0b8YKj1w@mail.gmail.com>
 <20180117214354.GA13128@sigill.intra.peff.net> <CAP8UFD0PtOqX5c4ovRbYDWejQ55iUwtnPv-zGXS2GFAajhXqtA@mail.gmail.com>
 <CAL21BmnKd0qamJWJbrAzg_ZX1GkhCTPO_5zOiFNMBeF-xjDTiQ@mail.gmail.com>
 <CAP8UFD1dcwEA9z+oQKFV=aFoKn73mtP4qkLGovW2XTu6N=N4dA@mail.gmail.com> <20180119172353.GA5752@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 19 Jan 2018 18:31:52 +0100
Message-ID: <CAP8UFD0to_jok2uw9WTTDSPxb_a_pa-u5qSjLscL1Yw2UuKNPw@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] ref-filter: make valid_atom as function parameter
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 6:23 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jan 19, 2018 at 06:14:56PM +0100, Christian Couder wrote:
>
>> > Let's discuss, what behavior we are waiting for
>> > when atom seems useless for the command. Die or ignore?
>>
>> We could alternatively just emit a warning, but it looks like there
>> are a lot of die() calls already in ref-filter.c, so I would suggest
>> die().
>
> I actually think it makes sense to just expand nonsense into the empty
> string, for two reasons:
>
>   1. That's what ref-filter already does for the existing cases. For
>      example, try:
>
>        git for-each-ref --format='%(objecttype) %(authordate)'
>
>      and you will see that the annotated tags just get a blank author
>      field.
>
>   2. I think we may end up with a case where we feed multiple objects
>      via --batch-check, and the format is only nonsense for _some_ of
>      them. E.g., I envision a world where you can do:
>
>        git cat-file --batch-check='%(objecttype) %(refname)' <<-\EOF
>        master
>        12345abcde12345abcde12345abcde12345abcde
>        EOF
>
>      and get output like:
>
>        commit refs/heads/master
>        commit
>
>      (i.e., if we would remember the refname discovered during the name
>      resolution, we could still report it). It would be annoying if the
>      second line caused us to die().

Yeah, ok, that makes sense.

>> > And, which
>> > atoms are useless (as I understand, "rest" and "deltabase" from
>> > cat-file are useless for all ref-filter users, so the question is
>> > about - am I right in it, and about ref-filter atoms for cat-file).
>>
>> For now and I think until the migration process is finished, you could
>> just die() in case of any atom not already supported by the command.
>
> I'm OK with dying in the interim if it's easier, though I suspect it is
> not much extra work to just expand to the empty string in such cases. If
> that's where we want to end up eventually, it may be worth going
> straight there.
>
> I also think %(deltabase) does make sense for anything that points to an
> object. I suspect it's not all that _useful_ for for-each-ref, but that
> doesn't mean we can't return the sensible thing if somebody asks for it.
>
> I agree that %(rest) probably doesn't make any sense for a caller which
> isn't parsing input.

Yeah, ok.
