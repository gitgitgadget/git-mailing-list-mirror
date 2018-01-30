Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F09F1F404
	for <e@80x24.org>; Tue, 30 Jan 2018 23:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754033AbeA3Xim (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 18:38:42 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37906 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752550AbeA3Xil (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 18:38:41 -0500
Received: by mail-wm0-f47.google.com with SMTP id 141so4446713wme.3
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 15:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ph2r6hUAww99VvXW9SDM+ehSy+OaZOyN+lOsS5i6Etw=;
        b=kcNseA0tLFbbUz9N85RV3LXD17aUtjmybKfAGpwNWz7vne3n0s8EOqGSyDDd2LBoOD
         H9TL2/bPQXOMTr+2z7GRXdfa4Tdwd0I6DYiHlqUHq1ViD2gwaFDFAs/lGosKYt1d6jVm
         lT/QN2tB5P4LNAPFMvIm1lDqeKaPWfdt1koo+3W4jJfDZ9subofLNazXw0O57ZAhuM+1
         dsyr5YRJPd1+Y/rwQbcOHejpQF1mAaXY2Fl85oXYVogwyvMe1AGCMtT7z9Ip8A/kOvF2
         rUqfcLeq8Gxsj49DLTFZ31LD/2bidd3OW7e0lK/vKjR/jNCXyKtyzF1gnoTxT3tv2Q22
         Bbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ph2r6hUAww99VvXW9SDM+ehSy+OaZOyN+lOsS5i6Etw=;
        b=fePxc82L4MWpEIbGCHDJUEZHnQW9L2cpCfFDIdpbWLfeHnPdCypjwQpaxCZeSul8kR
         UhWjKTg20lGH/7h+klhZwdQOM0m1K6EX5xx5dPBQ09aO8k6r/79SkFTFhkNaAB1SaI8N
         d+RRLe1FxNs664Qat2gb2JUKODd5X3qgXDaTzsR7r1hu+g273VU5i9pAn8YgqDEMhIoY
         8N2/pLI1UgrzKl9RnWkX5S7ZIq9Qg/NvOLxpFPa/imQvP5vWlc9PiihIGqFEibrELf6q
         KLc8nmKEwcmiTxdopebb2EEvL1lrJ665ulcj7NTx33DXFe8XQrOX+52takLbXVFieQBI
         1Beg==
X-Gm-Message-State: AKwxytfH0dl6JT0aUMfWRfYb1War+4s6owT+5J7oFodraZblMB7LjRAN
        nLczL9DRK9Spg/fS1THbftzvSaE04UPP9Ft7AFg=
X-Google-Smtp-Source: AH8x225ty0lBaWbXnnBpgNgrzBkVCjNXweo8PcifBxzjbkdURTslv/X3XV59kvzvH9RJ+oGpNnuKtoDfM0KRB0MI3tA=
X-Received: by 10.80.241.89 with SMTP id z25mr23644250edl.104.1517355520412;
 Tue, 30 Jan 2018 15:38:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.177.180 with HTTP; Tue, 30 Jan 2018 15:38:19 -0800 (PST)
In-Reply-To: <CAGZ79kYBhBbn3vs2pHGuVzBo79EjUVmUR4r2z5GexNFOVxfv7g@mail.gmail.com>
References: <CAMZgS+GT8pSx8rDy1KmzFV3LObA_bAkw25LMz5Oodb88QOXY5A@mail.gmail.com>
 <CAGZ79kYBhBbn3vs2pHGuVzBo79EjUVmUR4r2z5GexNFOVxfv7g@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 30 Jan 2018 15:38:19 -0800
Message-ID: <CA+P7+xr6JAsxat9D1zZmxgSCQuLZ7On=4zK4aZFFdGG8RR=_RA@mail.gmail.com>
Subject: Re: git add --all does not respect submodule.<name>.ignore
To:     Stefan Beller <sbeller@google.com>
Cc:     Michael Scott-Nelson <mscottnelson@gmail.com>,
        Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 30, 2018 at 1:56 PM, Stefan Beller <sbeller@google.com> wrote:
> The assume-unchanged bit is a performance optimisation for powerusers,
> but its documentation words it in a less dangerous way, such that it sounds
> as if it is a UX feature instead of a performance thing. I'd stay away from
> that know.
>
> Stefan

In almost all cases where someone incorrectly recommends
assume-unchanged, I think they could just use skip-worktree to get the
actual behavior they want.

Thanks,
Jake
