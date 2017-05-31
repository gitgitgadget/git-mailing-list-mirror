Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9170B1FD09
	for <e@80x24.org>; Wed, 31 May 2017 18:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751080AbdEaSYl (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 14:24:41 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36122 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbdEaSYj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 14:24:39 -0400
Received: by mail-pf0-f176.google.com with SMTP id m17so14388870pfg.3
        for <git@vger.kernel.org>; Wed, 31 May 2017 11:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8TudIHw33nwOtAa3oI1cbHWZu9cWTTNm21QeMggKrwI=;
        b=bMaOvpOZl5JfmYRnfqvxr6tPhv2WhWhSS9rUShoElvQfvlkG/XZRqCexoIWsJHRDQL
         EtTARqJqLltsZkIyvJ0ZRkM7kbRYP2fjG/HmVeB6tQPFmJRTCXghKHMtXBhT8MxSkFMU
         Uz0fCYs1U9yYAI53h2aumt+E0oJojlkpJS4eYVHJk+nolVd6LA8IiFweqpgyW5bba+qB
         idiTT8Tm6AbX5tP643//NDfybath0ZFQejxwI8ddpdfeMEFFYL4vVVqeJ0aGYLhzgy8i
         mx4bnEmVEUhBNP53uSp0QffcXB4XsY4+jI1fk4+P4zXCX2kcAdvZ9t+lGKVXV0ALnHY5
         WN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8TudIHw33nwOtAa3oI1cbHWZu9cWTTNm21QeMggKrwI=;
        b=BEPfWkaXl+rCZA4H2VKWmUCwkjrghTycVxhbQwPajiWvbTE2fiFC94X/LkYcgw3Hzx
         TUW6AjjwvV5zHXfsUeuyamjAeY6IIWeDCfz7e6lrj/CQ/1qPUepi/ntyA/n9FMlREKTW
         56WAQeGG9ClQCquDlp5YQQPov36Dagqdw3V0qpRurZVNa3XYT0h9XJ2XPva3zLJBQVp5
         WE8MSfi3R53E78Lzh+FoMWah4DwXaHjd1aXVK7418IAs1m7jdAOjjvo9F4XDiDnzMw1k
         EOD1LGNaE7manWPgNiAAs8SpHwP8xCeqMshzZX/WTwK9umchs4VyruPpzIFu1DEEvk+L
         vSMg==
X-Gm-Message-State: AODbwcCzq+K5ia9MI2w3sk6GyBT4eIxJA4EJjQ2AiW9tzLmnLBV+WzJN
        fzzAtSNQwmxJ2tYErQnEjVucHUcXiQ5n
X-Received: by 10.98.236.150 with SMTP id e22mr31751560pfm.48.1496255073652;
 Wed, 31 May 2017 11:24:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Wed, 31 May 2017 11:24:33 -0700 (PDT)
In-Reply-To: <20170530173109.54904-31-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com> <20170530173109.54904-31-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 31 May 2017 11:24:33 -0700
Message-ID: <CAGZ79kZjVvk8GoUFMnR7XJMDyvjkKPhw_7kUYPFq_ShcW50pVQ@mail.gmail.com>
Subject: Re: [PATCH 30/33] tree-diff: convert diff_tree_paths to struct object_id
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 30, 2017 at 10:31 AM, Brandon Williams <bmwill@google.com> wrote:
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  combine-diff.c | 10 +++++-----
>  diff.h         |  4 ++--
>  tree-diff.c    | 63 +++++++++++++++++++++++++++++-----------------------------
>  3 files changed, 39 insertions(+), 38 deletions(-)
>
> diff --git a/combine-diff.c b/combine-diff.c
> index 04c4ae856..ec9d93044 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -1364,22 +1364,22 @@ static struct combine_diff_path *find_paths_multitree(
>         struct diff_options *opt)
>  {
>         int i, nparent = parents->nr;
> -       const unsigned char **parents_sha1;
> +       const struct object_id **parents_oid;
>         struct combine_diff_path paths_head;
>         struct strbuf base;
>
> -       ALLOC_ARRAY(parents_sha1, nparent);
> +       ALLOC_ARRAY(parents_oid, nparent);
>         for (i = 0; i < nparent; i++)
> -               parents_sha1[i] = parents->oid[i].hash;
> +               parents_oid[i] = &parents->oid[i];

I have the impression that we could get away with one layer less
of indirection. Previously we had a heap allocated array (*) of (char*),
now we'd have a an array (*) of pointers(*) of the oid struct, that
is a (char[]) essentially. Maybe I am just confused?
