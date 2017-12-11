Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3E4B1F407
	for <e@80x24.org>; Mon, 11 Dec 2017 06:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751276AbdLKGRl (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 01:17:41 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:44865 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750709AbdLKGRk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 01:17:40 -0500
Received: by mail-it0-f65.google.com with SMTP id b5so13309277itc.3
        for <git@vger.kernel.org>; Sun, 10 Dec 2017 22:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kce7Bupg+4Ju0B//HbpaSVTP2NZklpzI4fFtt9DU4zU=;
        b=UA0wWsOnqdam3TtW8TNDzkg7k7b9b/gwyanuEMj0p2jJf4BHcGu2f/b2uooisqgM43
         9agVKb5kufwObSfkM3+4+OJV0q0dLuZlQVvJUDDekuByLSpgK44Net7+rEEziwPqUyp6
         uAeV9Z7a/dJBBVnLvgZHAGwbFnghkwDL2yHQ+OpTxKohcduD/qoWJct08p0HhaLV1rHd
         tq05A74MUFIeZ91HJSyZPfp1ZB/hPiayV57jgBUivv5YMKosb7XA/etT+2TuI2RcRPwy
         E0lh517L4jNX/6nBz89/4A6bqNzDJQ7Rx0mK4CIHvOFRMk5tFF09lCljFKunwljRpoco
         SHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kce7Bupg+4Ju0B//HbpaSVTP2NZklpzI4fFtt9DU4zU=;
        b=JipCb3Qq/g71ri5bUpkMsmqeo27TMJLCMsyKtSRbzPNjQ/bjmBCBLizZ0kMWe51rXD
         VPOxxne7vyPXa+6RHeoqZYuBTzsCQAJhFuG2DdP9nY2Ps7x+F5W80nvwic+LXBrXjQ3d
         3ptmsRNTWRF9RaLs67P+oKJ4AOzWgYsOBxB5i04D9dnv0AHLfvVl47UnzBwL7aRIJXY9
         w6VH3KAzkXXD2OGgXlwoSflGYfvr4b5LTjnfR1EbJOlzL+eWY7UAfmBvwpelzLuX6r6v
         YhUeuzcvYGIWk+lW0NLiYdk2csbfw3V6JOMZgkdDL+T8zYSRuknr6NoT3asMNAAvmmW4
         MTew==
X-Gm-Message-State: AJaThX4m1oqYGFUSO+WzA+Y/rCyI/+SVXqkPlPkul81tWrdwrCaZwE9u
        B+nkCIWGWpvCaT1hpVCDvdI+MZjOIYq9iqpuYoo=
X-Google-Smtp-Source: AGs4zMbjtAEbXZXzn9LLzcYSaBV36bNs86l46CleNa8AJyfAsMFW4QCQTrp27CpDD6B7AXBp14VybSZIWGtg2JwxFlg=
X-Received: by 10.107.25.204 with SMTP id 195mr54754333ioz.67.1512973059431;
 Sun, 10 Dec 2017 22:17:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Sun, 10 Dec 2017 22:17:38 -0800 (PST)
In-Reply-To: <20171205165014.64488-4-git@jeffhostetler.com>
References: <20171205165014.64488-1-git@jeffhostetler.com> <20171205165014.64488-4-git@jeffhostetler.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 11 Dec 2017 07:17:38 +0100
Message-ID: <CAP8UFD1A8+tRqeY5v9gbbUHY6W6fS2LS-7Z3zCqiBZQ8ZTHkNg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] rev-list: support --no-filter argument
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 5, 2017 at 5:50 PM, Jeff Hostetler <git@jeffhostetler.com> wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Teach rev-list to support --no-filter to override a
> previous --filter=<filter_spec> argument.  This is
> to be consistent with commands that use OPT_PARSE
> macros.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  Documentation/rev-list-options.txt | 15 ++++++++++-----
>  builtin/rev-list.c                 |  4 ++++
>  2 files changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 11bb87f..8d8b7f4 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -715,16 +715,21 @@ ifdef::git-rev-list[]
>  The form '--filter=blob:none' omits all blobs.
>  +
>  The form '--filter=blob:limit=<n>[kmg]' omits blobs larger than n bytes
> -or units.  The value may be zero.
> +or units.  n may be zero.  The suffixes k, m, and g can be used to name

"'<n>' may be zero" would be more consistent with other parts of this file.
s/k, m, and g/'k', 'm', and 'g'/ could also help.

> +units in KiB, MiB, or GiB.  For example, 'blob:limit=1k' is the same
> +as 'blob:limit=1024'.
>  +
> -The form '--filter=sparse:oid=<oid-ish>' uses a sparse-checkout
> -specification contained in the object (or the object that the expression
> -evaluates to) to omit blobs that would not be not required for a
> -sparse checkout on the requested refs.
> +The form '--filter=sparse:oid=<blob-ish>' uses a sparse-checkout
> +specification contained in the blob (or blob-expression) '<blob-ish>'

For example here '<blob-ish>' is used.

> +to omit blobs that would not be not required for a sparse checkout on
> +the requested refs.
