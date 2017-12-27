Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83E881F404
	for <e@80x24.org>; Wed, 27 Dec 2017 01:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751655AbdL0BGq (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 20:06:46 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:43726 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751622AbdL0BGp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 20:06:45 -0500
Received: by mail-ot0-f196.google.com with SMTP id b56so17950595otd.10
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 17:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MWpmgcwWi37zIuFF1z2StTd3+fbVU/xyONMoDmCpf44=;
        b=OdLC4iOGrG6sCEv/ZqEUhRzOotV3RG1qFazJrguP2boz4wub/fCvY+jHXLwKE9rrNR
         kJXmpCe5UVLlwXhZxN49fN2YWxz00e4xSEDDxOermOFWqx/2qhe+pcKQswBtaXwEkAEO
         +uqd6PHMNzdUJEaDaDRnKdG6j1xpZcrz4m80Bzvqe9a47wJdZead2TP1cEL1akkvJNHz
         v+t5v9jQp9pFYW0iiAYnOWjykS3xsJAWMtqMvp1efWDopCcMF4Wl1qharIEvBTYMGx3r
         QptYnGqY175vEYeYFmS4Er0d7H9vlOjQx5qlEgD/Y4SOG6thxjFkFJluKkPCxAtDDDN1
         azUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MWpmgcwWi37zIuFF1z2StTd3+fbVU/xyONMoDmCpf44=;
        b=JsqpPd/nUk9LrjRmoCuuCFOwOMnII50w7IxleM7ACj0kPJHegwZDAUgwk+QB6wSbRZ
         bePeKd3GDTXPjxosnDB6yPtBLZfGwXFxiglHcibwYDHpGBVbmMfq3Ap6R+yU5+7UxCjU
         +PJs7KGWKm/yYo98upNuRmRBpHtxvpo/wDzzey6vdiphPUon4ltKzmf/G4p+S6ooHJ64
         oRNs66caBXL59xW5UGdQRm3pv91nn7HW2MtSShYssz9KHH0RGvv+Pjim/A3UuKHE7ilD
         MzQS3DfljwQhpdaKJCMs4j7dGQgv8azQRyUT/Qm7aSKeOB5/6wQ+E1Ziiz95E4GwE7hw
         Ejsg==
X-Gm-Message-State: AKGB3mLy8yGzhUJ0Tf4FX6TZNuMKbcDnLlo/m/TGe/RW4i6jGfdHR02S
        WzMTB5iWoDk9m1V0i38Oyi2GfgljPjCsEnaqxs8=
X-Google-Smtp-Source: ACJfBosQw2/cEywTFh6zTiynP8h7Mkhq13YoUArB2mAscrz8f2ev+6NJ2Q6l5D3b8LRyu/Ug1Y6FyDG4wfMKUYmmkso=
X-Received: by 10.157.17.204 with SMTP id y12mr20604726oty.337.1514336803659;
 Tue, 26 Dec 2017 17:06:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Tue, 26 Dec 2017 17:06:13 -0800 (PST)
In-Reply-To: <d0f2055c-e0c4-32af-6371-53d0e9a5fbc5@gmail.com>
References: <20171225103718.24443-1-pclouds@gmail.com> <20171226091012.24315-1-pclouds@gmail.com>
 <20171226091012.24315-7-pclouds@gmail.com> <d0f2055c-e0c4-32af-6371-53d0e9a5fbc5@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 27 Dec 2017 08:06:13 +0700
Message-ID: <CACsJy8Dn_XKA8=iLRZpj2EKYOSZqHT0jw9o_HzPH_vncGGeCCQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] wt-status.c: handle worktree renames
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Alex Vandiver <alexmv@dropbox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 27, 2017 at 1:14 AM, Igor Djordjevic
<igor.d.djordjevic@gmail.com> wrote:
> I`m afraid "--porcelain=v2" test might be incorrect here, as `git
> status --porcelain=v2` output seems to be too, with this v2 series
> applied. Test I sent previously[1] fails, and it looks valid.
>
> This is output I now get, with old/deleted file unstaged and
> new/created file staged with `git add -N`:
>
>     $ git status --porcelain=v2
>     2 .R N... 100644 100644 100644 12f00e90b6ef79117ce6e650416b8cf517099b78 12f00e90b6ef79117ce6e650416b8cf517099b78 R100 original-file new-file
>
> Note "original-file" listed first, where "new-file" listed second
> (last). According the "v2" documentation[2] (excerpt):
>
>   ... <path><sep><origPath>
>
>   <path>     The pathname. In a renamed/copied entry, this
>              is the path in the index and in the working tree.

Gaah.. as you may see in the other mail when I quoted this
(incorrectly). I must have modified this file at some point and
thought it was true (my version did not have "and in the worktree").

The "and" is still problematic if you take this very seriously
(because in this case index name and worktree name are different) but
I think it's ok to ignore that "and" and switch it to "or".

>   ...
>   <origPath> The pathname in the commit at HEAD. This is only
>              present in a renamed/copied entry, and tells
>              where the renamed/copied contents came from.
>
>
> If I`m reading this correctly, it should be vice-versa - value from
> HEAD, being "original-file", should come last, where value from
> working tree ("new-file") should be first.

Yeah I think the "where the renamed/copied contents came from" clears
up my confusion in this format. Back to v1 it is!
-- 
Duy
