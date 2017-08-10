Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E591208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 18:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbdHJS6i (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 14:58:38 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:33624 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752713AbdHJS6h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 14:58:37 -0400
Received: by mail-lf0-f53.google.com with SMTP id d17so7533921lfe.0
        for <git@vger.kernel.org>; Thu, 10 Aug 2017 11:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n6mZwUWj3J6A0MXeQd3pOD4i609g2JayqLHyBMKKPJY=;
        b=j+Vf5tp2JbO1s8jaNdE5hA8QDQvlADSBBMZU0rk26fVHwcTWGbq7opERUkeFWX3yTT
         3Opmqk1mB5DQw82xHmrJzFJADjSKJo8WLgfKJ+dPpPe5UpV+i8ieqp+E/gda3LywuFMh
         jg9k52Q25SCV0K2Y2cQLI8UYbC1cywEickKctWX4tCjKV2HACLhYBb6IgvcTczFTcT4/
         Be/iTi32EW2LodeanVMnwUW0blOLYUiDXdd2oyOUB0ApiRGwSG1lftFJOsn1U4MszT0Z
         lSzTSOd9ThWkmdfAURnbK6SNuMAH9WhgIkGFzL1J112ayWFl4MTg5/8Qe4IDJ+Jp+2ep
         vO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n6mZwUWj3J6A0MXeQd3pOD4i609g2JayqLHyBMKKPJY=;
        b=oLq/V4VqpvVx7ut5D/GVdLS5iitvu3d8eCJM2vLZAvdkYm7e926RUZN8Ws4O0LMf/Y
         KwAFbN/UFp/gAM6DSESFWwt1PiN4LvAcZnrRYCG41p14N0ABEb44p6q7q9iOJAIEuApc
         rlXrI5eMqMVePkFHmzVRBV+QPv2T48z9khOQzP39rrTeSTlnVwn1O3Qi+K9gWffDLfpp
         wKxoKoHsBuJ28X/CUgm4GWV2yN4J5PSEddJ9JWAMUfxZpInywhwuSvaDEIyIrLNIELv/
         trV/jl49SNUizHU53A8Xvr/hn4/RBofoo2jp58IDNdzzWbFxocz3Bl8EtFldtNMQ8SEw
         JeDQ==
X-Gm-Message-State: AHYfb5jj1SzPppzgMcFK/UiTCyzG9aWxgIkXi8XO7jSG8yZn0JwnM1yz
        xZHnp9UcRKsHdOcB5+p6JkKXBtLZ1DAV
X-Received: by 10.25.20.68 with SMTP id k65mr5775390lfi.260.1502391515615;
 Thu, 10 Aug 2017 11:58:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Thu, 10 Aug 2017 11:58:34 -0700 (PDT)
In-Reply-To: <20170810184723.12424-1-kewillf@microsoft.com>
References: <20170810184723.12424-1-kewillf@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 10 Aug 2017 11:58:34 -0700
Message-ID: <CAGZ79kaB7w+OD_8LOgqHjBJ8gCtXUGWPj7Cw8bWXEEQweqMaFw@mail.gmail.com>
Subject: Re: [PATCH] cache-tree: remove use of strbuf_addf in update_one
To:     Kevin Willford <kcwillford@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <peartben@gmail.com>,
        Kevin Willford <kewillf@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 11:47 AM, Kevin Willford <kcwillford@gmail.com> wrote:
> String formatting can be a performance issue when there are
> hundreds of thousands of trees.

When changing this for the sake of performance, could you give
an example (which kind of repository you need for this to become
a bottleneck? I presume the large Windows repo? Or can I
reproduce it with a small repo such as linux.git or even git.git?)
and some numbers how this improves the performance?

> Change to stop using the strbuf_addf and just add the strings
> or characters individually.
>
> There are a limited number of modes so added a switch for the
> known ones and a default case if something comes through that
> are not a known one for git.
>
> Signed-off-by: Kevin Willford <kewillf@microsoft.com>
> ---
>  cache-tree.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/cache-tree.c b/cache-tree.c
> index 2440d1dc89..41744b3db7 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -390,7 +390,29 @@ static int update_one(struct cache_tree *it,
>                         continue;
>
>                 strbuf_grow(&buffer, entlen + 100);
> -               strbuf_addf(&buffer, "%o %.*s%c", mode, entlen, path + baselen, '\0');
> +
> +               switch (mode) {
> +               case 0100644:
> +                       strbuf_add(&buffer, "100644 ", 7);
> +                       break;
> +               case 0100664:
> +                       strbuf_add(&buffer, "100664 ", 7);
> +                       break;
> +               case 0100755:
> +                       strbuf_add(&buffer, "100755 ", 7);
> +                       break;
> +               case 0120000:
> +                       strbuf_add(&buffer, "120000 ", 7);
> +                       break;
> +               case 0160000:
> +                       strbuf_add(&buffer, "160000 ", 7);
> +                       break;

Maybe it is worth spelling out the modes in non-numeric,
but e.g. S_IFGITLINK.

> +               default:
> +                       strbuf_addf(&buffer, "%o ", mode);

Given the repository you are measuring, maybe we could
get away with fewer entries here and only take the 2 or
3 most used entries and special case them?

Or in case this is assumed to be the exhaustive list,
we could issue a warning here?

Thanks,
Stefan
