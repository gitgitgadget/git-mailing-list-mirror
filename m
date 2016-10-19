Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5592020986
	for <e@80x24.org>; Wed, 19 Oct 2016 22:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbcJSWP6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 18:15:58 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34982 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750768AbcJSWP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 18:15:58 -0400
Received: by mail-yb0-f195.google.com with SMTP id g68so440337ybi.2
        for <git@vger.kernel.org>; Wed, 19 Oct 2016 15:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8y4zCaGZm+7xI63JOzfQdif3xOs3bHOP2cwKez3G2zo=;
        b=Cqqw9gvKXUOApTBUOViPn2z3LkQe7NCSMzkyxZk1GgTxyjAkZyRw+67c8O2oN3eLf3
         7RW9HjYkKZZDdBjFVpYbfPB7NoIqf+UfICBk4hp0EYy6WfAQ+yuq3S6nIEyspnGWlFd5
         gK1WxAPoPhumKqfFpaCt4e3DQu9Hi0Q0yRnCBZkvfb/TuSthicYBaCTtVp2Y9NBWHgTP
         7Iowktp1hJNvTg59D4Gv4GM5kqApcqzRlWVDZlXRUkqkOg1XyDyK1wZyZN6RqS2j7X2X
         ECPVqeZxG848a+bYxNp0Dp7Tk4Wx9sPkuf91nbJlL9NPiiJBg9GwabtBtZujs8rsv8rB
         28NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8y4zCaGZm+7xI63JOzfQdif3xOs3bHOP2cwKez3G2zo=;
        b=JgZWIJs2+Bkh7a2DZ4hPZGtJjxNAzlR/xEp/Z2c7mnybMpkTyJyQDcJaMw6UmCRM4R
         CM5BXyhgUzHVOFi8Hk5rCkjlxdyrfenqD82DD+VIWMv7TYs0GFkhzrd+rgVq/sDLLzCL
         BKqHu7/dBitcl983d42nv2HrbHujevpUs6SCgZwmORhwxt5bUhSChdbBZoo8ft8RSA4h
         ijt84DrGabqIUf0DCGXje2+vZSG/E8fLHGhD4o+i5EHK0r2gurObYf7UXcEllUorCDRE
         rsVr1cANs1VKHvStjYiv+XdA5emetipPFT1SjoC+aKBlMWLCnSvDKJp7K2MebM0qlTHJ
         B3/g==
X-Gm-Message-State: AA6/9Rl7+Cjl/lJk4nDe1R3mEsHWMrwUfrATr4V129S8t1BD5YeaGRcWRuJ240JRV4AS+tL5jojCe+NEU2n4jQ==
X-Received: by 10.37.72.7 with SMTP id v7mr8365517yba.153.1476915357191; Wed,
 19 Oct 2016 15:15:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.10.2 with HTTP; Wed, 19 Oct 2016 15:15:36 -0700 (PDT)
In-Reply-To: <20161019210448.aupphybw5qar6mqe@hurricane>
References: <1476908699.26043.9.camel@kaarsemaker.net> <20161019210448.aupphybw5qar6mqe@hurricane>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 19 Oct 2016 15:15:36 -0700
Message-ID: <CA+P7+xogHOCbPV+rx7yrur85m=HX5ms9kGQYvTpQ7n2i7Hzuvw@mail.gmail.com>
Subject: Re: [PATCH] rev-list: restore the NUL commit separator in --header mode
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Oct 19, 2016 at 2:04 PM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> Commit 660e113 (graph: add support for --line-prefix on all graph-aware
> output) changed the way commits were shown. Unfortunately this dropped
> the NUL between commits in --header mode. Restore the NUL and add a test
> for this feature.
>

Oops! Thanks for the bug fix.

> Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
> ---
>  builtin/rev-list.c       | 4 ++++
>  t/t6000-rev-list-misc.sh | 7 +++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index 8479f6e..cfa6a7d 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -157,6 +157,10 @@ static void show_commit(struct commit *commit, void *data)
>                         if (revs->commit_format == CMIT_FMT_ONELINE)
>                                 putchar('\n');
>                 }
> +               if (revs->commit_format == CMIT_FMT_RAW) {
> +                       putchar(info->hdr_termination);
> +               }
> +

This seems right to me. My one concern is that we make sure we restore
it for every case (in case it needs to be there for other formats?)
I'm not entirely sure about whether other non-raw modes need this or
not?

Thanks,
Jake
