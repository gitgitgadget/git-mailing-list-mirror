Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6636C1F406
	for <e@80x24.org>; Sat, 12 May 2018 13:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750852AbeELNfX (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 09:35:23 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45414 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeELNfW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 09:35:22 -0400
Received: by mail-pg0-f65.google.com with SMTP id w3-v6so3581181pgv.12
        for <git@vger.kernel.org>; Sat, 12 May 2018 06:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XBc3ZbLlflDpnoBYiTsPsvEode9jmNSxxI1SpCz8PEo=;
        b=Cu0NvvdKxeCUGfoJyQFWWPYOdGa4xEgd2gYozu1LVFGJAsXY4XUBpxDAaJoxGLOaz3
         2ZXxNEI2yjmUpi8UXBfjhnTLDZuJvZLNUk3ljz33BhEReZuR+WBWBnd5xtaPUgmPK0pT
         kV7kDjvwnvnTy2HqJPNmzqps0eGEtT+iCIXlTP7XwnhbBEiPIaZy9oPxpvPTu9UetYEE
         K66528RRFfqQrivgZFUfL6ZplqxZrYHXiHhIL9AqNrB7ERWgOAgB1q0xYwkNUsYW9MWA
         bQ/c0+fhnxC/yggqPDt+w9WeH2Zsg7F4c0LPGZYprj9IfBWsBoOYINGir+3snT/X9YS3
         Nm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XBc3ZbLlflDpnoBYiTsPsvEode9jmNSxxI1SpCz8PEo=;
        b=srKTjURrMgf6JdNYOHHgIEbuaJ+NjEBMxXb0CEKmuS/9Nbb88CDQL+fKcCgcWv+Vfk
         IokO3sqn7Zveoa6Qm4QmbhR5YNFR02Y7pei5+Kc+Ls2fq6+mRrkUTW7uKswVUQOR0FI1
         pWDeWCOSrZPufYxX4CeKGO69N4HVuMb/oRacUgiBjaZ+m88gBQobB66h2tiFqjeSOb9m
         zRLugYmnhBu0ivAjQtGZkULTOhkWX1QR0f2TGHtcNmqarjfRmLpdEqCS7Z1NUcRqFA/6
         tLwDT1rdMQeGdf0bXMekQVb903glodQakhim3hovBiFHFzR7ZxXSjLYM+f4olA/Sg3Ln
         egng==
X-Gm-Message-State: ALKqPwe2B0iApyBQsXvs4DvPF1UNXMBZlcDnbccoprVg7aCivFOr6CuL
        mQ2B0ozeyO0sIJ66+grpfxreBD841NfMzZQj7yE=
X-Google-Smtp-Source: AB8JxZoB7zJBH7MVDPaiUzI+Qv3mO2lGv7tiaZz1XtWniuB/jPrwjyeEiCktsMvCPJMXDGiGtmSbzC+1ZGKmlOnxlOY=
X-Received: by 2002:a63:77cd:: with SMTP id s196-v6mr2752923pgc.146.1526132122245;
 Sat, 12 May 2018 06:35:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Sat, 12 May 2018 06:35:21 -0700 (PDT)
In-Reply-To: <20180511211504.79877-3-dstolee@microsoft.com>
References: <20180510173345.40577-1-dstolee@microsoft.com> <20180511211504.79877-1-dstolee@microsoft.com>
 <20180511211504.79877-3-dstolee@microsoft.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 12 May 2018 15:35:21 +0200
Message-ID: <CAN0heSrKFJbgwXXzUKaJQn24pY43S2bsn9Zx6Yyy6M2X2wDJ7w@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] commit-graph: verify file header information
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "peff@peff.net" <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11 May 2018 at 23:15, Derrick Stolee <dstolee@microsoft.com> wrote:
> During a run of 'git commit-graph verify', list the issues with the
> header information in the commit-graph file. Some of this information
> is inferred from the loaded 'struct commit_graph'. Some header
> information is checked as part of load_commit_graph_one().
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index b25aaed128..d2db20e49a 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -818,7 +818,37 @@ void write_commit_graph(const char *obj_dir,
>         oids.nr = 0;
>  }
>
> +static int verify_commit_graph_error;
> +
> +static void graph_report(const char *fmt, ...)
> +{
> +       va_list ap;
> +       struct strbuf sb = STRBUF_INIT;
> +       verify_commit_graph_error = 1;
> +
> +       va_start(ap, fmt);
> +       strbuf_vaddf(&sb, fmt, ap);
> +
> +       fprintf(stderr, "%s\n", sb.buf);
> +       strbuf_release(&sb);
> +       va_end(ap);
> +}

Right, so this replaces the macro-trickery from v1, and we print a
newline after each error.

>  int verify_commit_graph(struct commit_graph *g)
>  {
> -       return !g;
> +       if (!g) {
> +               graph_report("no commit-graph file loaded");
> +               return 1;
> +       }

> +
> +       return verify_commit_graph_error;
>  }

Not sure it matters much: I suppose you could introduce the parts that I
have quoted here in the previous patch. Or maybe not.

Martin
