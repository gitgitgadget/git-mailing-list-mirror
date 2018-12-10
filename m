Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72B7C20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 15:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeLJP6h (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 10:58:37 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35955 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbeLJP6h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 10:58:37 -0500
Received: by mail-it1-f194.google.com with SMTP id c9so18919263itj.1
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 07:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MWvwzcwFGACEuT15iUod5uzoidcsdeUpk4NCrIGZPIc=;
        b=jiimmira34HGNJZVQPpq51iA0vleGOcwDYzV0EvxYZdx8VouVFmV8ux6rImOFBn0VW
         mroBK/K9ui7FlMlAQUVvYCAQyT6VMLTrZ8K7uW28IgdFJ1D4WxLvCCKM7WmAqBKePwzm
         414OkxnI2hMyaXTQ2xq7y1bnBddusHqIRl4c0TW71C/sXDp8vZBjxV3PPCuVSa43Qvey
         yKK6UxT6gEv/RDaCEDB1eGrabm5y8OZCcrRMcpX9Ygz+IQWFy66YcD/Duy0NOEAAudxf
         q7th8ze9/+wHVY+XXqMpUlA2mlf7A7RZpE9JKV5+gqiEUIgvR8z486ZiqAKI+rGOiemK
         PJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MWvwzcwFGACEuT15iUod5uzoidcsdeUpk4NCrIGZPIc=;
        b=stsKzNjuslwQpmp37godnZnCj3JQgydmLC/TuRDEwYMJAw3j7vZPH4uwUyctjoVjeS
         3VR0uUnvi2w28W1zjCXIdbRwYfgheM53Du66zVBwAbGQ0F7EFm0warmnt+JXRuv4fQAK
         hfrZNINOs9pdUkk18H7b84YpQbwUvs06nn7olY8QtQHoANh0otNANO6Z4xfeNht/ae9o
         7h48mM73qu4BQ6mT3urYhex7ZpVvrTKj4fZfeZNgsPLXdxyxaAJMXf51Kt41QaGF/+vn
         qP8whF1kESWNCATxxuAnszkiYP9FzlznMOaMoF4GvsJNFkBg5ZgOLsCxjkCllxt8nzbY
         pm8Q==
X-Gm-Message-State: AA+aEWahu7XDOsvLSFoOt4NnHVI/gm5pAXr91C7fmR59/5tXu8ItO+yd
        ABbmLDnma8URfmr9LzbG6MB/N93INwWq/ZbCfFg=
X-Google-Smtp-Source: AFSGD/VPaOzifKwsx6lEYRsvup+631/Y7YBQk9ziUJrfFbc/YEBOCpEr/rzlcjpTWnFn7wLTbzXEILSmiZvVGDszqLQ=
X-Received: by 2002:a24:4606:: with SMTP id j6mr9946091itb.10.1544457516481;
 Mon, 10 Dec 2018 07:58:36 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-4-t.gummerer@gmail.com>
In-Reply-To: <20181209200449.16342-4-t.gummerer@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 10 Dec 2018 16:58:10 +0100
Message-ID: <CACsJy8DQd_DcuogF2Wnj47F6ef26L1dea7M2Yi-ESZ_naQZ=kw@mail.gmail.com>
Subject: Re: [PATCH 3/8] entry: support CE_WT_REMOVE flag in checkout_entry
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 9, 2018 at 9:05 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> 'checkout_entry()' currently only supports creating new entries in the
> working tree, but not deleting them.  Add the ability to remove
> entries at the same time if the entry is marked with the CE_WT_REMOVE
> flag.
>
> Currently this doesn't have any effect, as the CE_WT_REMOVE flag is
> only used in unpack-tree, however we will make use of this in a
> subsequent step in the series.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  entry.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/entry.c b/entry.c
> index 3ec148ceee..cd1c6601b6 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -441,6 +441,13 @@ int checkout_entry(struct cache_entry *ce,
>         static struct strbuf path = STRBUF_INIT;
>         struct stat st;
>
> +       if (ce->ce_flags & CE_WT_REMOVE) {
> +               if (topath)
> +                       BUG("Can't remove entry to a path");
> +               unlink_entry(ce);
> +               return 0;
> +       }

This makes the path counting in nd/checkout-noisy less accurate. But
it's not your fault of course.

Junio, do you still want to merge that series down to 'next' or drop
it? If it will be merged down, I'll keep a note and fix it once this
one lands too.

> +
>         if (topath)
>                 return write_entry(ce, topath, state, 1);
>
> --
> 2.20.0.405.gbc1bbc6f85
>


-- 
Duy
