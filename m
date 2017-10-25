Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 244D1202A0
	for <e@80x24.org>; Wed, 25 Oct 2017 11:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750921AbdJYLxJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 07:53:09 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:48134 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbdJYLxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 07:53:09 -0400
Received: by mail-qk0-f193.google.com with SMTP id d67so30116010qkg.5
        for <git@vger.kernel.org>; Wed, 25 Oct 2017 04:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=aa3YjGz/iDb5X2nxs6KsHN1hVLKQ+Sq19gmElDd9/og=;
        b=hP/ptxgOEGzc5MYF7TWY7EKcsPAcuVvSY/LW4bmDK6d5/r0oL6sPQ41OFcd3oD/Goa
         ewOERlYiF0W+Pi3tOaqVa30dYNcEWsoIFscjKHyY5Nr8RQ8WUyvuZ+RacL6QWuraMrV4
         5Y0oWiBXKPrwtMUEvD02pL4MqGI2hx8mcikjGcybMnzutFwJD9Jf7YEVqA9SF+zvO4pA
         czV5Krfa7tKi5j0FCxsO4JLnRX8h9UjKbx25D95IydvX8tcXYO8TCy9GNxUYr5p6Ek8p
         FaUuE0G7VSWs3ORYk6mY7Yr++HEi14wownOOntHnkZ/w+2idabWCXRUIGS1SnwFJU8nt
         PevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=aa3YjGz/iDb5X2nxs6KsHN1hVLKQ+Sq19gmElDd9/og=;
        b=W5g8/DjFCkAFNfTa24B7ISPABg/nzvtbJ50DCBzAq0kDT/GyQOEUJZERhCH4kBzE5f
         zIH1ANXVwrOn89BC+ROX8Bno0yrnkpm3sgpK9G6/djWyXTPGW1hL5OMSzEdCLEhk4Vpl
         SFsh1SkKCT2QwYetYVQIe91aZ2DuODeI5dR0lOHzrMlBxlGcjledzYGAqK2WVY2Ma2Us
         ycPVaU+tE77xzuWkrbNjPbf+2+qmxWpdQridjhtWtVfUJrN2ys65yBTX7mXfNlSRGtrC
         rhx3RwynLCHjp+IuXCMeQo1w7DUPPgX3fcvz8OINy6wrp+ovFCTTVasTrH8yC9jMLUP5
         LXDA==
X-Gm-Message-State: AMCzsaXYPxV8RJndfShIg31aduS+LYkP7CjIqF3NJFClTutfy4z1oh2q
        Hry8ihW+j0ZgJSPghlySWoi/qdrD044XDjaecO4=
X-Google-Smtp-Source: ABhQp+S2riIxswHpmuvSwYI8sHPD60lrlknN1zINl639ykCUyY400J62O3ODM8fLJPQHJrQDuF2xHgU1oyc+qhdSwVs=
X-Received: by 10.55.48.142 with SMTP id w136mr2550764qkw.147.1508932388030;
 Wed, 25 Oct 2017 04:53:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Wed, 25 Oct 2017 04:53:07 -0700 (PDT)
In-Reply-To: <38a80069-abdb-0646-a20c-eca39dd4f519@samsung.com>
References: <CGME20171024152727epcas2p4fb7dcf147e44aadf7733098151d469a5@epcas2p4.samsung.com>
 <3aed764b-388c-d163-08fc-32b294c6b9d3@samsung.com> <CAGZ79kaSZG9WriqX0SLbTnEDRr-4YdFRuK17+9wnxyrftfnMmg@mail.gmail.com>
 <CAPig+cRTL2amjsgdp1=T3GMZLa=favugOfnQw9XjWzC+U=v5Sw@mail.gmail.com>
 <CAN0heSp7b_6n3y=s4++oWhkPUuM=s9L7LWVx5vn8o=5aH6DKKw@mail.gmail.com>
 <20171024195221.gqgtibwjaztgeel6@sigill.intra.peff.net> <xmqq8tg0j8vb.fsf@gitster.mtv.corp.google.com>
 <CAPig+cSjQd=p1CdizU5oUaz91z=j02UnWLtTguWzvkjS+v6ETA@mail.gmail.com>
 <20171025072717.7svdq4kqlfxlwszi@sigill.intra.peff.net> <38a80069-abdb-0646-a20c-eca39dd4f519@samsung.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 25 Oct 2017 07:53:07 -0400
X-Google-Sender-Auth: LcrWleHxuBUetphU2DZM55VDXJQ
Message-ID: <CAPig+cRq1AEOgDoXeH-hDMvhEMnfiNK5CuSBbbio-mbHros=QQ@mail.gmail.com>
Subject: Re: [PATCH v2] merge-recursive: check GIT_MERGE_VERBOSITY only once
To:     Andrey Okoshkin <a.okoshkin@samsung.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>, vmiklos@frugalware.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 25, 2017 at 7:39 AM, Andrey Okoshkin <a.okoshkin@samsung.com> wrote:
> Check 'GIT_MERGE_VERBOSITY' environment variable only once in
> init_merge_options().
> Consequential call of getenv() may return NULL pointer.

It would be particularly nice to have a more detailed explanation in
the commit message of the potential problem this patch is trying to
solve. Given the amount of discussion, thus far, surrounding such a
simple patch, this cryptic warning about getenv() returning NULL upon
second invocation is insufficient to explain why this patch is
desirable; it merely leads to a lot of head-scratching.

> However the stored pointer to the obtained getenv() result may be invalidated
> by some other getenv() call as getenv() is not thread-safe.

This is even more cryptic, as it appears to be arguing for or against
_something_ (it's not clear what) and it seems to be talking about a
facet of the existing code, rather than explaining why the updated
code consumes its 'merge_verbosity' value as early as possible after
being assigned. Perhaps this part could be reworded something like
this:

    Instead, call getenv() only once, storing its value and
    consulting it as many times as needed. This update takes care
    to consume the value returned by getenv() without any
    intervening calls to getenv(), setenv(), unsetenv(), or
    putenv(), any of which might invalidate the pointer returned
    by the initial call.

> Signed-off-by: Andrey Okoshkin <a.okoshkin@samsung.com>
> Reviewed-by: Stefan Beller <sbeller@google.com>

As this patch is semantically quite different from the original to
which Stefan gave his Reviewed-by: (and which other people argued
against), it might be better omit this footer and let him re-give it
if he so desires.

> ---
> Changes since the previous patch:
> * no actions are taken between the merge_verbosity assignment and check.
>  merge-recursive.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 1494ffdb8..60084e3a0 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -2163,6 +2163,7 @@ static void merge_recursive_config(struct merge_options *o)
>
>  void init_merge_options(struct merge_options *o)
>  {
> +       const char *merge_verbosity;
>         memset(o, 0, sizeof(struct merge_options));
>         o->verbosity = 2;
>         o->buffer_output = 1;
> @@ -2171,9 +2172,9 @@ void init_merge_options(struct merge_options *o)
>         o->renormalize = 0;
>         o->detect_rename = 1;
>         merge_recursive_config(o);
> -       if (getenv("GIT_MERGE_VERBOSITY"))
> -               o->verbosity =
> -                       strtol(getenv("GIT_MERGE_VERBOSITY"), NULL, 10);
> +       merge_verbosity = getenv("GIT_MERGE_VERBOSITY");
> +       if (merge_verbosity)
> +               o->verbosity = strtol(merge_verbosity, NULL, 10);
>         if (o->verbosity >= 5)
>                 o->buffer_output = 0;
>         strbuf_init(&o->obuf, 0);
> --
> 2.14.3
