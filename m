Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED82D20899
	for <e@80x24.org>; Wed, 23 Aug 2017 19:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932552AbdHWTOS (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 15:14:18 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:35905 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932458AbdHWTOR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 15:14:17 -0400
Received: by mail-yw0-f178.google.com with SMTP id y64so6338708ywf.3
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 12:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=krY+2gy/QQFDDkSUUuY/IwL0iSMR1lvMjHDJYNa6uYE=;
        b=g7wjRA2FpeVSS4M10Oikk3LmMbJPGNsQpLZEKOmGKgdjuWpe4HfBHQSHTCHk+LAl1E
         OuhvkKubtfeBFWgElUrXZCPK9qjRi1pDoVQ7u8/CmD5PQ2Fb0rgDxohJbQ0O+k7I+SBU
         NYg+0jbbXPMxCvvuUdPLU/gqlbNAtisRY1kz4i0FJ6Fo8u5yOJHKzGD20xHSQUuLjt0I
         hcnLrKbd+DFrPygSzDQRQV7HNDRVugqxumv0jLlL77ynnWFNTdQVKOmyUnpVGB47PPw+
         A43h5vz65PU3ml+nSXEWyD3hOXrxrDYwHdB29Kxq3sL+LU8forwSD1QqPwYurf20T4YM
         x7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=krY+2gy/QQFDDkSUUuY/IwL0iSMR1lvMjHDJYNa6uYE=;
        b=Y0SgbH8XEBIwlwLW15038xIPSn49A9oxUuFZqFJP2LdGLWNsR+Z2zVTjuIP1XBloVb
         vxLoFPToLaIE7Cr8oAYvIxpsUpW+QDaeKQNxkHCAuf+jyjTdL/F+rDIH/csm0hoLfypK
         Lz2fr/8ytcizEutel8i/UM5suKj38D+zrBGcFq0gTO6M0qaLi74lR1o3J6KA7AVXaMd7
         /IyaRRF0Wk016IufLU4LMWf4Dqv8mEo5XlYpJmlQBLoAW1dMeEbN70PWiazxJarm47S5
         pxiPXEVeaBcBUUon26GqxQYFGXxBDFSLY/PYXanlRfFHRdlFtul6csrHNyFvq84PFJFz
         9oaQ==
X-Gm-Message-State: AHYfb5jx9QK6KX3ucY/kKXnbQg99PZvc52+pVd9qFjB8YXvH6boJKZvu
        UnNxDcewcTg/le+1Eq5vH0WoMst4z/lZ
X-Google-Smtp-Source: ADKCNb4RkhOQoAzaI/mH/nhV/fUqYxxqsB2sRb9Z1XOdN5x0tWfzXjq71IRDiP+jH6sgwp0sDkLND7KM5M0sdEZce6Q=
X-Received: by 10.129.93.194 with SMTP id r185mr2886492ywb.33.1503515656432;
 Wed, 23 Aug 2017 12:14:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.214.133 with HTTP; Wed, 23 Aug 2017 12:14:15 -0700 (PDT)
In-Reply-To: <20170823123704.16518-3-pclouds@gmail.com>
References: <20170823123704.16518-1-pclouds@gmail.com> <20170823123704.16518-3-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 23 Aug 2017 12:14:15 -0700
Message-ID: <CAGZ79kbvKZXGy80RCU3zkdm0S3M-tGB=LAJYiY=o+YwUB9RNHA@mail.gmail.com>
Subject: Re: [PATCH v4 02/16] refs.c: use is_dir_sep() in resolve_gitlink_ref()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2017 at 5:36 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> The "submodule" argument in this function is a path, which can have
> either '/' or '\\' as a separator. Use is_dir_sep() to support both.
>
> Noticed-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>

Immediate questions that come to mind:
* Could this go in as an independent bug fix?
  -> If so do we have any test that fails or stops failing on Windows?
  -> If not, do we need one?
* Assuming this is not an independent bug fix:
  Why do we need this patch in this series here?
  (I thought this is about worktrees, not submodules.
  So does this fix a potential bug that will be exposed
  later in this series, but was harmless up to now?)

I'll read the next patches to see if I will be enlightened.

Thanks,
Stefan

> ---
>  refs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/refs.c b/refs.c
> index 3d549a8970..dec899a57a 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1507,7 +1507,7 @@ int resolve_gitlink_ref(const char *submodule, cons=
t char *refname,
>         struct ref_store *refs;
>         int flags;
>
> -       while (len && submodule[len - 1] =3D=3D '/')
> +       while (len && is_dir_sep(submodule[len - 1]))
>                 len--;
>
>         if (!len)
> --
> 2.11.0.157.gd943d85
>
