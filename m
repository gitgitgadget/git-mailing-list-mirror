Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA28C1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 15:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388863AbeKGBWb (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 20:22:31 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46925 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388554AbeKGBWb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 20:22:31 -0500
Received: by mail-io1-f66.google.com with SMTP id y22-v6so9539345ioj.13
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 07:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i+KMfxR1FPqvXlCuvmqb2GISiiJHqdqnCHhjBJUot9Q=;
        b=oNvSBvfbCHlPexDJ1KacKLw5gGyf4tjlZyEhb95T2ieqM7HYlsI4cNBqNR/UEUo9nO
         4PT+DOkjpxTXL9owUL7ECwhVMO4bXhK1w8mgUIhvXhlwj30KNGOQIhLnTIWjPmP/qLLg
         z2S7RqxLWuSqu0MIoKN1vQv746Ll5zEQgi4LvE3c1yLUKTWpV1NezLArM68sww8IlHvg
         x+1b/DlNMF3zBb5WrIfBqw7oFWjEhlPdJ4XQmaADZPaNeKCF3o17a7jscb1GRSX3TNJg
         st+qRPTX9HJCxuR3bIUxZoFBDuNCfXTAeP//oFdRjZaZ1NuUBQnn/0I5mHImYF2Okfdi
         HLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i+KMfxR1FPqvXlCuvmqb2GISiiJHqdqnCHhjBJUot9Q=;
        b=pX/1XnWJaGQI6tdc6gLwiAWQdrULAvMwp6/WN2+nq28K5oh+eXZUgM8zGc+uwCpPuZ
         D/mDMTyJ44MhQjB/YbgsYBDuLJ6PTR7BuDt3Q1sgtcOD1pwvfMf+IsZQtwHHBCO2Ey8k
         TZ3fIETygocciLphbtjVXv8oOYYtHEjVPnf9wT8DasRL1wM7USrotYJ5IYBNUtysWwHk
         kpdh7sJfhqeGdR3lhamTXj70lFQV3YQkzeTvWBeGizcTsm9Gd8XKecQOWBIsAFY6l/23
         B0GW8XcmKnAuMdRCbJZ2AsmaGMs7oTzCazI/FTJ1obfhWiN4MmFQIhSaKRQv8xoiIYwD
         eiSA==
X-Gm-Message-State: AGRZ1gK9IEMIFdjPjydbqP81p+GVsm9PXFM2K6EEtSZm7MQrgyAPJ8TB
        ZrcCJ+lUHmwuFwU1wQMUlNcjzAmm/+9KdqD9D70=
X-Google-Smtp-Source: AJdET5ci7qTstnuTxA+vQ4EbHBMdm8zf1fqydlsdAnpcwcZp5FPugLaVwKAFcs5Itl27VeUtZb9ETFRO/Af/0QCKUhs=
X-Received: by 2002:a6b:216:: with SMTP id 22-v6mr22243273ioc.118.1541519798357;
 Tue, 06 Nov 2018 07:56:38 -0800 (PST)
MIME-Version: 1.0
References: <20181106104811.14625-1-leif.lindholm@linaro.org>
In-Reply-To: <20181106104811.14625-1-leif.lindholm@linaro.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 6 Nov 2018 16:56:11 +0100
Message-ID: <CACsJy8AjY1-KT9x_CXuo+L3-g947OaC5Av0KwuJF-Xkz6VMiPQ@mail.gmail.com>
Subject: Re: [PATCH] format-patch: respect --stat when explicitly specified
To:     leif.lindholm@linaro.org
Cc:     Git Mailing List <git@vger.kernel.org>, lersek@redhat.com,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 6, 2018 at 11:48 AM Leif Lindholm <leif.lindholm@linaro.org> wr=
ote:
>
> Commit 43662b23abbd
> ("format-patch: keep cover-letter diffstat wrapped in 72 columns") made
> format-patch keep the diffstat to within 72 characters. However, it does
> this even when --stat is explicitly set on the command line.
>
> Make it possible to explicitly override the new mechanism, using --stat,
> matching the functionality before this change. This also matches the
> output in the case of non-cover-letter files.
>
> Cc: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
> Cc: Junio C Hamano <gitster@pobox.com>
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> ---
>
> Note:
> In TianoCore we have LotsOfGloriousFilesNamedInReallyLongCamelCase, so
> our official submission guidelines specify the use of --stat.
>
>  builtin/log.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 061d4fd86..07e6ae2c1 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1009,7 +1009,8 @@ static void show_diffstat(struct rev_info *rev,
>
>         memcpy(&opts, &rev->diffopt, sizeof(opts));
>         opts.output_format =3D DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT=
;
> -       opts.stat_width =3D MAIL_DEFAULT_WRAP;
> +       if (rev->diffopt.stat_width =3D=3D -1)

I don't think we get -1 here when stat_width is not defined. The
"undefined" value is zero but I'm pretty sure we get MAIL_DEFAULT_WRAP
in here unless you specify --stat.

So I think you can just drop the below assignment. But if you want to
be on the safe side, check for zero stat_width instead of -1 and set
MAIL_DEFAULT_WRAP.

> +               opts.stat_width =3D MAIL_DEFAULT_WRAP;

How about a test to make sure this will not be broken in future?

>
>         diff_setup_done(&opts);
>
> --
> 2.11.0
--=20
Duy
