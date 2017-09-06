Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40AB41F4DD
	for <e@80x24.org>; Wed,  6 Sep 2017 17:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932217AbdIFRQC (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 13:16:02 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36600 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932081AbdIFRQB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 13:16:01 -0400
Received: by mail-pf0-f171.google.com with SMTP id e199so13731706pfh.3
        for <git@vger.kernel.org>; Wed, 06 Sep 2017 10:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=A0I1KaWCR40TletChAOOCJBIBsVpXPXw8iVC0QzgpoI=;
        b=ZevRQh24F+1XGisqn2q1tGPIAHuZ9+Z2aI2Q45wQ2kJ68WI5Fvsp1iNZ8imP7qouuH
         u08kDgYXAYqnGLFPpWeleohyfNwS/N8cVTFedPaHaIjJVKZfWrmariUEnJ9Phu/I/kla
         TpvdIwkV7RWKxWUQ6lC/QsvAFruAwHPyZteJ5g3d8TXRFCcw7Y+bNn6AE4S/LZj16g/9
         Ca3UQr2Pp6qrpjO0sTITzOeYjFj1eqSHCgJ612UC9nOeCqeyRxZT79okQT4UWvqBqOAC
         b/931kJNL2GCCIb+9lexPtrq8cCI1s3zR+W4A0np/93YJWGJGJQHE5Cph7wNuAwkA0f6
         scgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=A0I1KaWCR40TletChAOOCJBIBsVpXPXw8iVC0QzgpoI=;
        b=YwqdwnEgVkeW4uq7lDAcwHKOvo0jH6o6bfa595bRPJMXV95UpGfeoMbcxbHzKlc2ii
         9DFJ8sSPCTPsqDCNEkhoOBziK4eOJGHB+WYKxsusFLf0Yuade0cf4rM3AVJ7GZgpsSuX
         3qLt+DFqd4KjfYKK36wzFNos3ckg9uFE+xVuPKT0+KX1qraEQ038Lpt/duEATuHNeaNK
         1AFZNJT2Geknzs4vEQgcTjgkpVTqxbX5+sZjxVtJt6LWS+XTGuHZSkJtf62HJsE5kZWc
         yOQgatCYgDjm967dErCtNAHvh9lGgbQHKj/qyGF69zduXXwAZR4zYNh9aUaHChn0Vvt5
         wKbg==
X-Gm-Message-State: AHPjjUi42dP20cW33pXUocM7huBz9VDAMQDSpezaaKSASkOnqxxZIxIm
        r0TqpjDTKZNf8PTbpSacrQI322HVVayQ
X-Google-Smtp-Source: ADKCNb783FGkLqS1ZoZyVfcOWFQAyPyaH3vRdXr38ffXp2DeDPKxiNvktD1OCdRchTDurE5c8tNhVVHbhrTvjiapnko=
X-Received: by 10.99.126.84 with SMTP id o20mr8359597pgn.201.1504718160804;
 Wed, 06 Sep 2017 10:16:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.142.73 with HTTP; Wed, 6 Sep 2017 10:16:00 -0700 (PDT)
In-Reply-To: <20170905130505.him3p4jhxp64r2vy@sigill.intra.peff.net>
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net> <20170905130505.him3p4jhxp64r2vy@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 6 Sep 2017 19:16:00 +0200
Message-ID: <CAN0heSpYZT7cm=XNpfgcsGFa9FOR6SdaF=vXJ+M7NNaA6Mnb3g@mail.gmail.com>
Subject: Re: [PATCH 10/10] add UNLEAK annotation for reducing leak false positives
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5 September 2017 at 15:05, Jeff King <peff@peff.net> wrote:
>   1. It can be compiled conditionally. There's no need in
>      normal runs to do this free(), and it just wastes time.
>      By using a macro, we can get the benefit for leak-check
>      builds with zero cost for normal builds (this patch
>      uses a compile-time check, though we could clearly also
>      make it a run-time check at very low cost).
>
>      Of course one could also hide free() behind a macro, so
>      this is really just arguing for having UNLEAK(), not
>      for its particular implementation.

Like Stefan, I didn't quite follow 1. until after I had read the points
below it. But it's still a very good commit message (as always).

> diff --git a/builtin/commit.c b/builtin/commit.c
> index b3b04f5dd3..de775d906c 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1819,5 +1819,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>                 print_summary(prefix, &oid, !current_head);
>
>         strbuf_release(&err);
> +       UNLEAK(sb);
>         return 0;
>  }

These are both strbufs, so this ends up being a bit inconsistent. What
would be the ideal end state for these two and all other such
structures? My guess is "always UNLEAK", as opposed to carefully judging
whether foo_release() would/could add any significant overhead.

In other words, it would be ok/wanted with changes such as "let's UNLEAK
bar, because ..., and while at it, convert the existing foo_release to
UNLEAK for consistency" (or per policy, for smaller binary, whatever).
Or "if it ain't broken, don't fix it"? Did you think about this, or was
it more a random choice?

Martin
