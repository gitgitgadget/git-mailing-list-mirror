Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECF1C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 11:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbiGRLiR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 07:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiGRLiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 07:38:16 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A013B21271
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 04:38:15 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id e15so14859386edj.2
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 04:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Gdm5oeH+8AEv9lgfVqjo/t3+tSzf4Dy+gl4qtZpUnms=;
        b=d9S9W4s9VdiGscKPU2+fYxER3+hCpIpUpVIZP406T8csK5Drzpe4K8itjI/Blg3WnB
         CLtx3GcIAP+7dCEvFIBaHvpds7Y1Tz1rO3EJY6nWN3+ZOFND+2Ej9vP2Z7eXhEtrNkWc
         IENeaOWROkFieb56SV/yasvW4w7KOmDvqFrvnhZd3jC+KEBgTegTosJE4u11MiaNddAG
         H78whXr0KHD8FIvj1nsmLk3dGEuHfKVP7PGwiVOQe0wa04+13t6Jl6OOnqyzkHZfEKPz
         +ALfyjfQYvLaCcOs8DAY4uRefHi6LAp65KIcd0fXzKok05HhOEdh2anHw9HX/7DY/Nyv
         bFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Gdm5oeH+8AEv9lgfVqjo/t3+tSzf4Dy+gl4qtZpUnms=;
        b=CKm+WpLwMI2FhsXAZkc1J2lF46kwQZ1VNGTcbJrMfl9W+mxN8O7Uh2ad/Qf850zFxS
         aWioQh94fp/zUzqsPkZ+uJzvs6CZlVqhrljoAZZrbVO/dBA4e7b4UxEGZDFNgDgIsy/k
         g2NRFM6WoNIj9NdhXR58f20RrTTLTtTgGyHr0MzOKaqOzKxbbtB/Kblz4taRHge1VlwH
         h9LIiiOjZsfi8OhxGfhOgEMtxgrZAQEG3gdIJBtuRk9tAPp4BfJzEduLaZDM+9CTiavN
         VD/Qi5zx4zL5OFnoJMwLeiEbe0/55Z65R0MlamXgyCwP9CiCpbvrOBoW8vgVOzZ70ov+
         Kyzg==
X-Gm-Message-State: AJIora+i7yeIny86KeFBxqlu7PubQ64dfDAFq7wCp+W0lOAYehTg/21y
        hz5rx0DW27AmEVYrw9QI51HFQrtz57KazF45L4CLHUbw7455sQ==
X-Google-Smtp-Source: AGRyM1smcX9+/9fvY/Z/hdRw9+Gw19ajyhTboT3YuUW2dSdvsdAntvIqWuT5GtVHeN+DnLSm1Rx35J/zTj1ZQO7QdV0=
X-Received: by 2002:a05:6402:1bda:b0:43a:55d7:9f2f with SMTP id
 ch26-20020a0564021bda00b0043a55d79f2fmr35858103edb.360.1658144294218; Mon, 18
 Jul 2022 04:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAPOJW5x4McofC5fxBvsRAzum28wmeDJCMTMRmY_0oy=32JjKqQ@mail.gmail.com>
 <85r12iu10e.fsf@gmail.com>
In-Reply-To: <85r12iu10e.fsf@gmail.com>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Mon, 18 Jul 2022 17:08:02 +0530
Message-ID: <CAPOJW5xR-MBU74h2mM3wENf_XjU-xm6n7qis0FLjFxZsUHsHAQ@mail.gmail.com>
Subject: Re: Can I use CRoaring library in Git?
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 18, 2022 at 4:43 PM Jakub Nar=C4=99bski <jnareb@gmail.com> wrot=
e:
>
> Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com> writes:
>
> > Hello,
> >
> > I need the CRoaring[1] library to use roaring bitmaps. But it has
> > Apache license v2 which is not compatible with GPLv2[2].
>
> Actually Apache License v2.0 *is* compatibile with GPLv2 and GPLv3
> in the sense that you can include the Apache licensed code (like the
> CRoaring library) in the GPLv2 project (like Git).
>
> Quote from the cited "Apache License V2.0 and GPL Compatibility"[2]:
>
>   The Free Software Foundation considers the Apache License, Version 2.0
>   to be a free software license, compatible with version 3 of the GPL.
>   The Software Freedom Law Center provides practical advice for
>   developers about including permissively licensed source.
>
>   Apache 2 software can therefore be included in GPLv3 projects, because
>   the GPLv3 license accepts our software into GPLv3 works. However,
>   GPLv3 software cannot be included in Apache projects. The licenses are
>   incompatible in one direction only, and it is a result of ASF's
>   licensing philosophy and the GPLv3 authors' interpretation of
>   copyright law.

But the same article also says  -

  Despite our best efforts, the FSF has never considered the Apache License
  to be compatible with GPL version 2, citing the patent termination
and indemnification
  provisions as restrictions not present in the older GPL license. The
Apache Software
  Foundation believes that you should always try to obey the
constraints expressed by
  the copyright holder when redistributing their work.
