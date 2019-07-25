Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B83D81F97E
	for <e@80x24.org>; Thu, 25 Jul 2019 12:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbfGYMPz (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 08:15:55 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46710 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfGYMPz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 08:15:55 -0400
Received: by mail-ot1-f66.google.com with SMTP id z23so23043409ote.13
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 05:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=5f38k0nIAGhz0d5uyHMZ5XoHbZB40VLtYE1zl/zkRjM=;
        b=S2kIRjFF27kvwlW7obdvNx+9jdtC+HcQ44y/QkGiuSn4ZsZQTb3SJO79crIPr1/YNv
         ClipG+QkIR7b8AMK82izQd6zP1r/6FZc3C/D/2JegVo0/go81JpRaACHksYUM/6oNbpo
         1+mDNBuT0EhtVJvz2IUWXqFo3QDcHNnXz3mSOQ6INkHvmmDdOHBJxd+swx3HcYPVwLZD
         5YP2H6FTFg38Rll27Bg5nY1N90gWs1q8VfqSrT8guihF6CucIXwK5mavpwutFwtnqNr7
         TzdEF0inF3EIp7L2KBQg0Cw120qgzIdZamijmziun4okKm0gMU8iIljaBA/pxhtgRozg
         L0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=5f38k0nIAGhz0d5uyHMZ5XoHbZB40VLtYE1zl/zkRjM=;
        b=P6tRVJRb8dIeDrfXtno1yjSpIPBXdUWwBd1h5PcFab8nwcYx+DAWb9n2R8QrkUN38L
         QmXeSLa/H9xU6LrbhIORsDhht783iM4ujQeNYE4uX2RvKpc2ZVGNB6k8sAMEhGBLk1PQ
         UDI5bdx9LgaFwofWyZID2J2EOk6Fmh5joacYdi2B8bPxvdTfl4sGZIkGPQmFFO95DTnt
         hrGT4jgByeAH2kYL1lXmSJ0/2SKC4KO9w/ouD7YmEsnR4KjMHZei62F/x4kQ/JFGWN1q
         5qTC/yLf1pkINRT8wEwbkxMiNoY0Z9Jq54EhfL8w+fnmSjaPAl+qKDhT+Gf1/AESzq2u
         ISFw==
X-Gm-Message-State: APjAAAXClCWtg6LqfzmXipIgqZff7NpA/qCNwzw04WOiljVDrrScAUmN
        IVJZNoSlkwpFB621JM8ufOvcdR2+Ju0EQhQTihcsdBfTDCU=
X-Google-Smtp-Source: APXvYqxo9MmkPIUd3fVsW8zFT6dMVxStoD4IhdFVsdd0UvIO8e+W4QJrWGz8RDSmAJEUzr3Kw0WULr/bLo/L+cDGLDQ=
X-Received: by 2002:a9d:6d12:: with SMTP id o18mr31290798otp.166.1564056954497;
 Thu, 25 Jul 2019 05:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <1564051425-69139-1-git-send-email-simon29rock@gmail.com>
In-Reply-To: <1564051425-69139-1-git-send-email-simon29rock@gmail.com>
From:   simon gao <simon29rock@gmail.com>
Date:   Thu, 25 Jul 2019 20:15:43 +0800
Message-ID: <CAGR3woXsDgYTMWcMKEXO_TkynrR3ZAYKn+fpAoThT=Ey4q+b1g@mail.gmail.com>
Subject: Re: [PATCH] stop it from failing silently when git apply patch and
 show err info
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I create 001.patch in dir, ceph_master

ceph_master
|--- .git
|--- src
|--- tools
|--- ...

local project directory:
storage
|---.git
|---ceph_**.*.**
    |--- src
    |--- tools
    |--- ...

I'm trying to apply the patch, and git apply patch doesn't give me any erro=
rs.
like this
cd storage/ceph_**.*.** && git apply 001.patch
I check code and I find that root directory need to be set using "--directo=
ry"
I think we need show some info about it.

thinks


simon gao <simon29rock@gmail.com> =E4=BA=8E2019=E5=B9=B47=E6=9C=8825=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=886:43=E5=86=99=E9=81=93=EF=BC=9A
>
> Signed-off-by: simon gao <simon29rock@gmail.com>
> ---
>  apply.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/apply.c b/apply.c
> index 4992eca..47b16aa 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -2093,8 +2093,10 @@ static int use_patch(struct apply_state *state, st=
ruct patch *p)
>         /* Paths outside are not touched regardless of "--include" */
>         if (state->prefix && *state->prefix) {
>                 const char *rest;
> -               if (!skip_prefix(pathname, state->prefix, &rest) || !*res=
t)
> +               if (!skip_prefix(pathname, state->prefix, &rest) || !*res=
t){
> +                       error(_("%s doesn't contain the prefix(%s)"), pat=
hname, state->prefix);
>                         return 0;
> +               }
>         }
>
>         /* See if it matches any of exclude/include rule */
> --
> 1.8.3.1
>
