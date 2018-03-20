Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75E371F404
	for <e@80x24.org>; Tue, 20 Mar 2018 18:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbeCTSg4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 14:36:56 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:38265 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751880AbeCTSgz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 14:36:55 -0400
Received: by mail-qt0-f178.google.com with SMTP id n12so2692753qtl.5
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 11:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=16wXKyQp9Y/S9IagRh1H2ZhQUryuMbs27jnZlzCZnLE=;
        b=GGDDkt//zzJM2eZmQ20OwSIEWikR6MdqPYrKoWvfaq9W2QqOGq0i/V+PvR91l2+1Tt
         HHqtib+vmTb1FVJS50d0ye3j1HW8pGnwO7plNNXToedYizJOTST1vfS4FGxb/O8mYSGA
         3N6fa5z5ue2qBl1gz/4s+UrIvMYGQW3t+0rrKTFU/o0pLmWfrn8+P9FP83qk4mz8eemN
         ZwkI6N1Ed2NYGEpNWB5L9L9QyVGJ7WD0IEkEq3LrwkZUmiMWeozHsA7zzDEjo+U6PG6J
         aEKwPECKuLM7pN4MGM1uCLgUm5XlPBOjVC7XCW4Elq/D+eWZUjbZAeg3wzWsPy2icnYw
         h4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=16wXKyQp9Y/S9IagRh1H2ZhQUryuMbs27jnZlzCZnLE=;
        b=FeIJtj+qEMRpjEkdSESOVs2CJYMt+LsK7MBZEmQ+QVY+X9UV4kac8eO0N1s5WhDO3c
         ST/dXqe5NhWbbiHED3hC/5RNNm0lELcHoC1Dar4dF8bYy++TL0WYprH2sFOypsjWh+b5
         i5WUxnIpZRX2Vu3OGZeJNCkcof2s5q65JquGHs7pn9LuWhYlgPBPa7DhuxKpjl84Zs5i
         spvpRGY/z9UemxRBQvjP/vgq6dk3ORn+Tssg1Re8uzQLvOZgAE53n3pc0cZ9ZArnkiuH
         FOIiQyBq40h9vLZFY71h76yHWngs1qXxb5nMZ74gnTBAnb2RGTnz2yWrTb97RaY0Q+XN
         wgUA==
X-Gm-Message-State: AElRT7ElWpZXEvxmpB9dwRxwBZzj011GF9Nej5Qmalhifky+Q7HyBzJ4
        qO8it1c/VY7jhSY3c+O4eZ1gaqoqvyaiYG490Z6tfQ==
X-Google-Smtp-Source: AG47ELvRuGyYZ4iETuJMK2tMDHf9wQiIe4Ys/R4niNwduAE9Io3NjiWRfn/p7ImY2gmLHENRVO05b/Hc4PmS0+9k8E4=
X-Received: by 10.237.57.166 with SMTP id m35mr9685501qte.220.1521571014844;
 Tue, 20 Mar 2018 11:36:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Tue, 20 Mar 2018 11:36:54 -0700 (PDT)
In-Reply-To: <20180320175005.18759-1-ungureanupaulsebastian@gmail.com>
References: <20180320175005.18759-1-ungureanupaulsebastian@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 20 Mar 2018 14:36:54 -0400
X-Google-Sender-Auth: pr7uirXiUA65rsnbSz2Mz58DZc0
Message-ID: <CAPig+cT8OemuHYbkfX_zpQw47zjupDf65FKC-uC=GP+FLR62og@mail.gmail.com>
Subject: Re: [GSoC][PATCH v6] parse-options: do not show usage upon invalid
 option value
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 20, 2018 at 1:50 PM, Paul-Sebastian Ungureanu
<ungureanupaulsebastian@gmail.com> wrote:
> Usually, the usage should be shown only if the user does not know what
> options are available. If the user specifies an invalid value, the user
> is already aware of the available options. In this case, there is no
> point in displaying the usage anymore.
>
> This patch applies to "git tag --contains", "git branch --contains",
> "git branch --points-at", "git for-each-ref --contains" and many more.
>
> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> ---

As this is a very active mailing list, with reviewers poring over many
(sometimes dozens of) patches each day, it is easy for a reviewer to
forget exact details of each individual submission and review comment.
As a patch contributor, you can help ease reviewers' burden by adding
commentary to your submission here, below the "---" line following
your sign-off. In particular, reviewers find it very helpful when you:

* describe in some detail what changed since the previous version of
the patch, showing that you understood and took into consideration
each of the review comments from the previous iteration

* a link, like this[1], pointing at the previous round (and perhaps
further back) so reviewers can refresh their memories about issues
raised previously; this also helps people wanting to review this round
who were not involved in earlier rounds

[1]: https://public-inbox.org/git/20180319185436.14309-1-ungureanupaulsebastian@gmail.com/
