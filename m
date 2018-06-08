Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 779E11F403
	for <e@80x24.org>; Fri,  8 Jun 2018 15:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeFHPqt (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 11:46:49 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:44378 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752364AbeFHPqs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 11:46:48 -0400
Received: by mail-ot0-f195.google.com with SMTP id w13-v6so16184671ote.11
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 08:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B0Sp63V++A+CIazIcM5JY6yrbuLH0+5+zAEMuzFp87M=;
        b=Y0MyJ1Xk5xaym3j2Hi9cPJ10p7t6SEhfTSioAGgxdheYRvaftAQE5LM+kVTKZJ+q6t
         LG23kR2apWvdeXMzrpBxMXtm4bmeCXMnCGxvV225poqRM/A7AU4hNSKgSPQYzqSWlbvT
         AEwICCKRttBqEgOpYTReWpu14pbTR/UXZLjrINZj/dMUdR10NL731PeCuItDO0/wR8HA
         PtwLjdX/sH13y6HkxzxXbzP1VOv4iAFcFRMmJXfWNtLcgzjNNBCbpKKSPGntaczceRGO
         RZ04PoUTi8HUk5jxunr1U2Qw/JBHhUqatZcU33J8c6g3J92w3ix13dm/WNwRdzcEAH16
         9L+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B0Sp63V++A+CIazIcM5JY6yrbuLH0+5+zAEMuzFp87M=;
        b=ZkjhnY9otPnyUw4Q2CaqVM94dAtLpzjTxZE0qpcrBbfsxpvqmi7NnaZOayJ6kiA6i9
         6L5E+ECm2KXfFCzw3wbtCVQXyrworigr1CyyI9YwJqGqaorbBlPdM4OPVG6yZhr2AkTh
         A2TyDcdAYGGOv6BdTUfkKA7zgzRw98X3F4aIn8F40HpVL6IUqv+U/J/Qd7p3bMKesx+h
         dpLv4r8PqjxP88UyuunC1hTx+aidCpvWEP5OSzuMoNXJ85WmHhpZHBY5SWrtv3v9Cn8r
         bvmgBOHeoQg2R36zIA/9NZO3RqIabDwuLDtl1OahK++9TOsUBFZNNBAPrK9OcWDiFD3w
         geWw==
X-Gm-Message-State: APt69E1RdMv2WmCpYwo7mSUzubg367SAC15YbytLnotDGTzLCdsH9LnS
        wpwsGlj3x9A7NpxhrGuZR6PnJg1YXC7kNjPqmpo=
X-Google-Smtp-Source: ADUXVKJH9NSyWmbPyXTjD+mSs3Yy30sSfWALo7D0g3yC25UAcPn3lg6Hwhtw3nHTZZODO+n3xEE5+ITK8pV0TH7qpYU=
X-Received: by 2002:a9d:2f91:: with SMTP id r17-v6mr4267923otb.356.1528472808101;
 Fri, 08 Jun 2018 08:46:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:2082:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 08:46:17 -0700 (PDT)
In-Reply-To: <871sdhzkd2.fsf@evledraar.gmail.com>
References: <20180607145313.25015-1-git@jeffhostetler.com> <c3ed8128-1184-8199-06e5-a4e96b2bc7c5@kdbg.org>
 <871sdhzkd2.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 8 Jun 2018 17:46:17 +0200
Message-ID: <CACsJy8DYFfLdXLzdZOz1V2XC9hpGT0igMZ-WJVpWp_UvMEnOgA@mail.gmail.com>
Subject: Re: [RFC PATCH v1] telemetry design overview (part 1)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 8, 2018 at 11:40 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Jun 07 2018, Johannes Sixt wrote:
>
>> Am 07.06.2018 um 16:53 schrieb git@jeffhostetler.com:
>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>
>>> I've been working to add code to Git to optionally collect telemetry da=
ta.
>>> The goal is to be able to collect performance data from Git commands an=
d
>>> allow it to be aggregated over a user community to find "slow commands"=
.
>>
>> Seriously? "add code to collect telemetry data" said by somebody whose
>> email address ends with @microsoft.com is very irritating. I really
>> don't want to have yet another switch that I must check after every
>> update that it is still off.
>
> To elaborate a bit on Jeff's reply (since this was discussed in more
> detail at Git Merge this year), the point of this feature is not to ship
> git.git with some default telemetry, but so that in-house users of git
> like Microsoft, Dropbox, Booking.com etc. can build & configure their
> internal versions of git to turn on telemetry for their own users.
>
> There's numerous in-house monkeypatches to git on various sites (at
> least Microsoft & Dropbox reported having internal patches already).
> Something like this facility would allow us to agree on some
> implementation that could be shipped by default (but would be off by
> default), those of us who'd make use of this feature already have "root"
> on those user's machines, and control what git binary they use etc,
> their /etc/gitconfig and so on.

This elaboration should have been in the commit message of the first
patch (and I hope it will be in v2). You guys knew because it was
discussed at Git Merge but the rest of us may not.. It would be much
more convincing to have something like this spelled out.
--=20
Duy
