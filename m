Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04E671F42D
	for <e@80x24.org>; Sat, 26 May 2018 02:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030998AbeEZCyj (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 22:54:39 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34432 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030929AbeEZCyi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 22:54:38 -0400
Received: by mail-wr0-f196.google.com with SMTP id j1-v6so12086558wrm.1
        for <git@vger.kernel.org>; Fri, 25 May 2018 19:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=j16W6IjY3uQl+R6VFXA9kulyPqkoMRlM4st8ka/20pg=;
        b=DJRkmmxnEsEi47vvgzNlC7ECFuqnOXB1ZbSAsexcnMvqmv7kN1nmqC12wHJ9LFxA+G
         y5FaG/fsdHgDcsYv2BPOjUBG8/Wh04q6ufHlpYU+kBvo4YfJ9WcP2jOUN9x8xVw/tsZh
         3MboX/INfJfmbZDiKmpabDTRh2niTAkqM6Vkbs+/VEDVABWiv2GfYvbDuqSm5OEtiLPF
         5gr4hzrOzT/eHkryc/njYYtUbPnp85WG39/42s0aYwpPwI4XEzzeR72a5G2QpNKYgF0p
         DiIiYchVJQ1q7sXo6z0CM67LQFWw1mzJzMdBiUGYf5GSibOTBWttEp85L3REu/8pQGtD
         KCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=j16W6IjY3uQl+R6VFXA9kulyPqkoMRlM4st8ka/20pg=;
        b=QY9fMedl7k+LQEQHq1nQFHfD2bmSYp+NR8ZAu0W01ghd9FiRBNl1NtVt2ex1q9Hr8b
         JTL6Obzc1pcswnplkEl2AAj5Jt6ECVx/5VBHgSqfSjwyetRZbbL+JHzQ1Tz7jUzB1Tol
         CPREUp8B4qzRuctSfpZ6Z8G9EEFnga2y/LJYOB79NBL8LALkLHxXixyvFGF8/eq5XAum
         BvtDy627U7HJ3LFjiyiy7ARtW39X1gPyIGrSiewOXp/O5NCgJ6k3+tVUwS3dw4TuyWxw
         quIbFeZaGu7aGvN6ckZGz6OOa0bimV2HI2YIUawGMH9GDk/fTnoUHhTRxoxKAQycOb4x
         RyeA==
X-Gm-Message-State: ALKqPwfSA5ahFXzlosB9SxLbkSHzXxPm6ezGN6dZGT0XOY8naU64zBdF
        rEO/XtRAdDnIfkxBoj5aMMc=
X-Google-Smtp-Source: AB8JxZodjhM8661oEALt49wleEQdDLLqp4OhvhgiEviJxlTujDM3ggRbdymGBfzv12ErCCoY7l00wg==
X-Received: by 2002:adf:c613:: with SMTP id n19-v6mr3791829wrg.177.1527303276811;
        Fri, 25 May 2018 19:54:36 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o12-v6sm17526418wrf.30.2018.05.25.19.54.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 May 2018 19:54:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Wink Saville <wink@saville.com>
Subject: Re: [GSoC][PATCH v3 1/4] rebase: duplicate git-rebase--interactive.sh to git-rebase--preserve-merges.sh
References: <20180522211625.23893-1-alban.gruin@gmail.com>
        <20180524114958.26521-1-alban.gruin@gmail.com>
        <20180524114958.26521-2-alban.gruin@gmail.com>
Date:   Sat, 26 May 2018 11:54:35 +0900
In-Reply-To: <20180524114958.26521-2-alban.gruin@gmail.com> (Alban Gruin's
        message of "Thu, 24 May 2018 13:49:55 +0200")
Message-ID: <xmqqk1rrm8ic.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> This duplicates git-rebase--interactive.sh to
> git-rebase--preserve-merges.sh. This is done to split -p from -i. No
> modifications are made to this file here, but any code that is not used by -p
> will be stripped in the next commit.
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  .gitignore                     |    1 +
>  Makefile                       |    2 +
>  git-rebase--preserve-merges.sh | 1069 ++++++++++++++++++++++++++++++++++++++++

I would normally say "Yuck" to an approach like this series, because
it does not force us to make any explicit effort to share as much
code between the two codepaths.

But the codepath for "-p" is something that has been abandoned even
by its original author and would be going away, so the net effect of
this series to the project in the longer term is to remove the "dead
code" that will be made unnecessary from "git-rebase--interactive"
when support for "-p" gets discarded in a distant future, and do so
before we actually remove "-p" (and replace it with the "recreate
merges" feature).

So I won't have objection to the approach taken in this series.  I
may still raise issues on individual changes, though.

Thanks.
