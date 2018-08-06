Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 198A2208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 18:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733115AbeHFVFU (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 17:05:20 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:41987 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732832AbeHFVFU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 17:05:20 -0400
Received: by mail-io0-f195.google.com with SMTP id n18-v6so2384015ioa.9
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 11:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yjuJZWhrgtU7S2iry3ayf4D14oti/APGb9C20/yvKZ4=;
        b=V96WeYwY7kgwe1xK1Cy/UnqbYhX6VdCiPn6yYI4Xu1H/7TiKXd0Pif3wTXuczup2/k
         H6ix/qwfCaZ5oW4OAqwaNRDp5MAQbK7ayssAoAwcmsmOAAsWn6jp21lfykChhP8EvRqi
         zNMCg59h2vOXgiiERmveEleBhqgLOQHapZUGz1T1EO38IMZTegUoQxQ0cnO/LgKrssLA
         XTML0d8/mskziz46yHnuf0zyyaR26uv27q4NlmrtB/KvS4UiCFnlz6EchhENoht5eI+b
         rmKg8dAXvB5+cORvp83k6mLCJUQf8srkuYt1B3QDk0KRHL8iC/K/K+gZ4DRFhqBt1vDA
         sNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yjuJZWhrgtU7S2iry3ayf4D14oti/APGb9C20/yvKZ4=;
        b=idX4ArpqAmZ2mG7tVpNEqsB5dJG0x9JR+Nd3dWac74I8jOHPcSbZZLDsPDcibiwSzH
         6H0/muGGS603pfQkmPeN/DA+90w1WHZOGa94NCLcvmVS3z979TUs8RHFpaWxqHF25FTw
         R+rcRNcWFlgvaz/khZsyeKiCdQs9r/r1vMJUn1WQ1mu0iYRDKazrZTInQG5u7j0jZq+h
         evxz6uiw5VQZbZREGmRPJfFm/XUwakw/EQJL7Ku2cyZq7Bw3SR4azryQs7JW4VCxoiVI
         e0JYT42fXqogT1UXPwFMZqNdCFyNnVZGpd3DWmvZZ7Wixt8tGhvpSkVO5NYa2TFdNgJW
         aXWg==
X-Gm-Message-State: AOUpUlE8db2FIw8L0MyZQTTjdq+JR10p1XXPfIC1/rGkLvUvFpgh/66u
        eH7zwze9Es7Cp+z0ywnpb03P2Oa7Hthv8hfkSZQ=
X-Google-Smtp-Source: AA+uWPwQnd/4+fB58HMW49O5YpBeyx2BNjcl8OXYvAOiTOpUbP/hu07yTE1P4odxWX3UI2yox7ty5Re47sg8zc/ZYb8=
X-Received: by 2002:a5e:960b:: with SMTP id a11-v6mr15868724ioq.53.1533581694472;
 Mon, 06 Aug 2018 11:54:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:228d:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 11:54:53 -0700 (PDT)
In-Reply-To: <CACsJy8Aa2xo+jVOPza_wt-EX8P4_M8XJD3jdLs=cr11M0ckUuA@mail.gmail.com>
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
 <20180722054836.28935-3-chriscool@tuxfamily.org> <CACsJy8AzksB=rfaX_dfboMXHjqj6gj+erdF6eRFAKmWA1-3PUg@mail.gmail.com>
 <CAP8UFD2frOjmZoOfWW-93xewA6LS5zTEisNr4QDz2FNQE2DY_A@mail.gmail.com> <CACsJy8Aa2xo+jVOPza_wt-EX8P4_M8XJD3jdLs=cr11M0ckUuA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 6 Aug 2018 20:54:53 +0200
Message-ID: <CAP8UFD35j1KkO=hB58Qcs=PZTFW2=djGi07z5uyayDENXzanwA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] Add delta-islands.{c,h}
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 6, 2018 at 5:53 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Aug 5, 2018 at 8:53 PM Christian Couder
> <christian.couder@gmail.com> wrote:
>>
>> As you can see the patch 6/6 (in the v2 of this patch series that I
>> just sent) moves `unsigned int tree_depth` from 'struct object_entry'
>> to 'struct packing_data'. I am not sure that I did it right and that
>> it is worth it though as it is a bit more complex.
>
> It is a bit more complex than I expected. But I think if you go with
> Jeff's suggestion (i.e. think of the new tree_depth array an extension
> of objects array) it's a bit simpler: you access both arrays using the
> same index, both arrays should have the same size and be realloc'd at
> the same time in packlist_alloc().

Ok, I will take a look at doing that to simplify things. Thanks to
Peff and you for that suggestion!

> Is it worth it? The "pahole" comment in this file is up to date. We
> use 80 bytes per object. This series makes the struct 88 bytes (I've
> just rerun pahole).

Did you run it on V1 or on V2? I guess on V2, but then what do you
think about converting the 'layer' field into a bit field, which might
be simpler and save space?

> On linux repo with 12M objects, "git pack-objects
> --all" needs extra 96MB memory even if this feature is not used. So
> yes I still think it's worth moving these fields out of struct
> object_entry.

And what about the fields already in struct object_entry? While I am
at it, I think I could move some of them too if it is really so worth
it.
