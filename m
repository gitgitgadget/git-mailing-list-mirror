Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19F361F453
	for <e@80x24.org>; Thu, 17 Jan 2019 18:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbfAQSdQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 13:33:16 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34414 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbfAQSdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 13:33:16 -0500
Received: by mail-ed1-f66.google.com with SMTP id b3so9208842ede.1
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 10:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oZCa00QJToZWx+ltcnvt8Ye9iNOfnFAEwYnQ0qqdfFg=;
        b=rTC2p6VyXmqzxDw066i1ycH/5xeHf3CwjhOkdnjD/0C/h2li8UV8wXvBxudUPBUdua
         Esd9ni2nsoMjcgjbB29LvUiHioBq4kLn61fKXbbhpI0cETcLlZJWihK1TFOz5L9RoJXb
         CC/nd3ErAvqkyGnWcfgx5d9YqQdGAY/35ipQFZnyoYU2ykCpPpQ40u6Ps4MX58VFdSdo
         Nr9OyYl3x8VcjBL5Jx8A1s+jibhZ3lGMWBWZR9valf5G3kWYJUkx8y+4Ql153j/IpT0K
         yC+lsqHKLvoJXaBzyx+i3kxFG4zeK2eCrRsqWQqZX6Uj2X6y6zRJryJHmW7zh5fxAg0x
         NWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oZCa00QJToZWx+ltcnvt8Ye9iNOfnFAEwYnQ0qqdfFg=;
        b=VJGoRNWJWkczia+IoXFqXwgcaQF87nwWb6dIOhAep07V4uF6H3qylMbrxSeiwXsrWA
         mV/X07eg1N71UFiLiQVR2/bvyvkojJjHT/dGVIGFr7p2pgrmOjeaBWj79KOYJTJ+q5tf
         azJZfsALxgj4SHmASh/P97RWUFq0HAGTQsupnFQ3E/4x1acH0HhftqZKxO9dNw5Qygtu
         NcIFe+6fAYVT/2UV2EkqrzshnbqejpOTNRR1+0w1pm/A+LfaIfss0/uSbEt/1Lws/NIU
         Cj2sjwx/I1b7/kc0J2hXuE+doOgiwHB3Fhl3k7KLRDmjaBIhNx3VTfBQfLe1YvjzaRTF
         ulMQ==
X-Gm-Message-State: AJcUukdB/+jLss9bkLf85QxnjuXqzyMj24rseTXDsjJRyvF9klslLIKE
        xXgr3s6g+zeSPr4z4wzrCDxiX4wy/niUg1N7YB5tDw==
X-Google-Smtp-Source: ALg8bN6WienCb56G8OGWfjbL39sUoppxT5G+RfcsbiR6X9UPal5QLl7MSae6LWc1NDLBXOKhI0iViLfGFHAQuSAceQc=
X-Received: by 2002:a17:906:5a11:: with SMTP id p17-v6mr11477134ejq.43.1547749994548;
 Thu, 17 Jan 2019 10:33:14 -0800 (PST)
MIME-Version: 1.0
References: <20190117130615.18732-1-pclouds@gmail.com> <20190117130615.18732-4-pclouds@gmail.com>
In-Reply-To: <20190117130615.18732-4-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 17 Jan 2019 10:33:03 -0800
Message-ID: <CAGZ79kZ0SvLs944z4N0r1rsJUpNaYyAdUv=L_kdvOJamxg0Riw@mail.gmail.com>
Subject: Re: [PATCH 03/76] parse-options: allow keep-unknown + stop-at-non-opt combination
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 17, 2019 at 5:06 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> These two are orthogonal. One is about unknown _option_ while the
> other non-option.

Though 0d260f9a09 ("parseopt: prevent KEEP_UNKNOWN and
STOP_AT_NON_OPTION from being used together", 2009-03-09)
seemed convincing to have this?

Maybe we only need this BUG in case of !PARSE_OPT_ONE_SHOT?

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  parse-options.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index eb5de0da29..678b263897 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -427,9 +427,6 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
>         ctx->prefix =3D prefix;
>         ctx->cpidx =3D ((flags & PARSE_OPT_KEEP_ARGV0) !=3D 0);
>         ctx->flags =3D flags;
> -       if ((flags & PARSE_OPT_KEEP_UNKNOWN) &&
> -           (flags & PARSE_OPT_STOP_AT_NON_OPTION))
> -               BUG("STOP_AT_NON_OPTION and KEEP_UNKNOWN don't go togethe=
r");
>         if ((flags & PARSE_OPT_ONE_SHOT) &&
>             (flags & PARSE_OPT_KEEP_ARGV0))
>                 BUG("Can't keep argv0 if you don't have it");
> --
> 2.20.0.482.g66447595a7
>
