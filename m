Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 197FE201A7
	for <e@80x24.org>; Sat, 20 May 2017 21:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755988AbdETVZX (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 17:25:23 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33554 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755825AbdETVZW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 17:25:22 -0400
Received: by mail-pf0-f175.google.com with SMTP id e193so54581429pfh.0
        for <git@vger.kernel.org>; Sat, 20 May 2017 14:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tu3pWj7NCvdRBy8qxjxzrnMGklLQyd58p4+FoMJ8oiw=;
        b=NvBiGHSm3w0uBA2LCdhWE8ILIkGtj0Q7M2BIktUwTGUUjsSYKM4kIV3eZZX8VOWFzH
         8HawBzRCXGPfkPNFK16mwSrOCNvGQc4a7unGU4sfQHkCfihGFoeI02Tfgb8snSHCBqvR
         5X+p+CYQNO3ZfM7B/FtpEKWxud+oPJouRU82S/IkS0kUIoOl8nIVfRloZNXGu8yQZD6E
         mVfq9MoVMtqtGCJclEbfZP19qQ0fz7tmxE7N68rk9WygvcKnKsTR5cYwNAAiRai5/GiY
         17Qsz/GDeQoFfqLxDNEWUQyoYUiLEoVIlaWSDe7ObfTlkF9OBzNOEui/JqcJYdqxepka
         ZxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tu3pWj7NCvdRBy8qxjxzrnMGklLQyd58p4+FoMJ8oiw=;
        b=tu4S2FRTSH/c7Zg6XZDAwCnpobc/gbkaQdPozg3+xFSSY9tXgjrGccdW+vFMopFFIR
         LkwByhM41wjFnb/VM37+vMhB9koZTfUbHAf9b6d8xxEYMmI0k8PonkfWvKEzMfsiDNQ2
         yQZfzBzsHXgIWYUzPo5de7yAZpOH6GjcSy7CGiBDSgDOwN/pYUrS2f6IT14FEtrWTIIs
         DZtlIfJyWxj8pBoxs9K+RElUFoNVzR86u3dQUCpcukaxi1aOmReTTjaFB+Wxnj1/fbSt
         ut7kmqTuYMDKw+xbqRFspB6q6otMq9ewW18mC0swnfEeDRppYXaz7XHNfA9DXFINHuPE
         EV3Q==
X-Gm-Message-State: AODbwcB8QgYPIkq6uWS7KUOZrQnssmOdBfX2Lg8PJSEdc6b0RkrjHmro
        wCxv25fBqN/x6qYU1l8VZcXeEXa4+iB1D+1NOA==
X-Received: by 10.98.148.2 with SMTP id m2mr17391265pfe.194.1495315521323;
 Sat, 20 May 2017 14:25:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Sat, 20 May 2017 14:25:20 -0700 (PDT)
In-Reply-To: <20170518232134.163059-18-bmwill@google.com>
References: <20170518232134.163059-1-bmwill@google.com> <20170518232134.163059-18-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Sat, 20 May 2017 14:25:20 -0700
Message-ID: <CAGZ79kZoCkrF_ruzkpULQVSZ7=WEgFP+8PcgDhacWBh7ZCac5Q@mail.gmail.com>
Subject: Re: [WIP/RFC 17/23] repo: introduce new repository object
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 18, 2017 at 4:21 PM, Brandon Williams <bmwill@google.com> wrote:
> Introduce 'struct repo' an object used to represent a repository.

Is this the right place to outline what you expect from a repo object?
Are you planning to use it everywhere?
Is it lazy-init'd and it takes care of it itself, or would the caller
have to take
care of the state of the repo? ("the repo object is just a place to put the
current globals")

>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  Makefile |  1 +
>  repo.c   | 42 ++++++++++++++++++++++++++++++++++++++++++
>  repo.h   | 15 +++++++++++++++
>  3 files changed, 58 insertions(+)
>  create mode 100644 repo.c
>  create mode 100644 repo.h
>
> diff --git a/Makefile b/Makefile
> index e35542e63..a49d2f96a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -821,6 +821,7 @@ LIB_OBJS += refs/ref-cache.o
>  LIB_OBJS += ref-filter.o
>  LIB_OBJS += remote.o
>  LIB_OBJS += replace_object.o
> +LIB_OBJS += repo.o
>  LIB_OBJS += rerere.o
>  LIB_OBJS += resolve-undo.o
>  LIB_OBJS += revision.o
> diff --git a/repo.c b/repo.c
> new file mode 100644
> index 000000000..d47e98d95
> --- /dev/null
> +++ b/repo.c
> @@ -0,0 +1,42 @@
> +#include "cache.h"
> +#include "repo.h"
> +
> +int
> +repo_init(struct repo *repo, const char *gitdir, const char *worktree)

style ;)


> +       /* Maybe need a check to verify that a worktree is indeed a worktree? */

add NEEDSWORK/FIXME prefix to comment?

> +void
> +repo_clear(struct repo *repo)

style ;)
