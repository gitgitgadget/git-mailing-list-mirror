Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,TRACKER_ID,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E25F11F404
	for <e@80x24.org>; Mon,  9 Apr 2018 17:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752857AbeDIR7y (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 13:59:54 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:39254 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752351AbeDIR7x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 13:59:53 -0400
Received: by mail-yw0-f177.google.com with SMTP id q66so3099121ywg.6
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 10:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=shyvVWVFFoUNzdNJW/4fUW5arXwYhBjMhnuJFrTCm+k=;
        b=ub3SdAdKgLq8tsLEnmVRJgdlapH7+0sQLUsHX4rTBqVleiNlD/EWB9URKmkHqs+CMZ
         m/QhqjzRTrBAbPRV88oftU3s3m6YrjKA5o//lE61TnSEwIT/2CTQYAWIdJ4L6LatQBpE
         KVZHTNA+TXyvcsde/mlpojB6hhbmwLqKQ9pig6QSvhgzUDFpn3r/KX2ZD8Wre/gCEJPd
         QuJ8cqxp+5e2djIc2T7U1N6swu1ukFSb2SiHBbyAmybFzKxb01Rdef15XKTum8MU8YT8
         b4YnXqIiiwyW2HQf5y7csblY08EGTYCJRpYFxIjh3pAAMdzo8zkZhrKuGD0qd+yVYuO4
         qlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=shyvVWVFFoUNzdNJW/4fUW5arXwYhBjMhnuJFrTCm+k=;
        b=R6JumAV/B+RnJOIZEjG4MYNePWg9FmHzNlisaSNpH79HbrjP4nq4PmWtfm9yfPB3V1
         JlAAhrY0WACRzBskJznQ2wjHZEGIQ3+ysbDC2MBIYGAfhD82Qrkugvx26Njofmxs7SxU
         hS5hnmqxQY7T60h3OELCkxj6berWcLpysaxuEb1c+L21kg93CJ8md8Qvxh0II9FLuKls
         LW19ItlxH5GWmRviTP/4nk6PpfWy22puX7IigvH4W55VQNfpAHMMzE8W7G6o9/c7E0An
         rkJrY3M4Gxfox5mxnn3mfHA4iDrc1wdL3sMcmDS6Hu10tI+v602TxlLTX38RbDLxcD+o
         NdJw==
X-Gm-Message-State: ALQs6tCLwX2K7bhZeI2duA/cEG5H2qmnKqOx3yA3FxNmkhsA9yWQkx+n
        Ip1nw0crgKtT9cAJSvefvwwZsqcA2onFkGxxvONjq9157Y8=
X-Google-Smtp-Source: AIpwx49S8h1HSjuWi3OxvOMP7DyQb8+i3bwcv/jSkTaa8O5NXLr00vkjYcg150hBU01ayiXBQjw/cYBRfbWv9xaIlkM=
X-Received: by 10.129.136.7 with SMTP id y7mr11886901ywf.238.1523296792904;
 Mon, 09 Apr 2018 10:59:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Mon, 9 Apr 2018 10:59:52 -0700 (PDT)
In-Reply-To: <20180409164131.37312-4-dstolee@microsoft.com>
References: <20180403165143.80661-1-dstolee@microsoft.com> <20180409164131.37312-1-dstolee@microsoft.com>
 <20180409164131.37312-4-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Apr 2018 10:59:52 -0700
Message-ID: <CAGZ79kZ74g7Q9ovX==8WTn-B6gZJyHvRnNVgTGJd3qQD2fdvRA@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] commit: add generation number to struct commmit
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 9, 2018 at 9:42 AM, Derrick Stolee <dstolee@microsoft.com> wrote:
> The generation number of a commit is defined recursively as follows:
>
> * If a commit A has no parents, then the generation number of A is one.
> * If a commit A has parents, then the generation number of A is one
>   more than the maximum generation number among the parents of A.
>
> Add a uint32_t generation field to struct commit so we can pass this
> information to revision walks. We use two special values to signal
> the generation number is invalid:
>
> GENERATION_NUMBER_ININITY 0xFFFFFFFF

GENERATION_NUMBER_INFINITY

On disk we currently only store up to 2^30-1,
(2 bits fewer than MAX_UINT_32), but here we just take the maximum
value of what a uint32_t can store. That miss match should not be a
problem albeit aesthetically.

Once we run into scaling problems, we can just up to uint64_t in the code,
and defer the solution on disk to a new file format.

With both ZERO and _INFINITY we are at the border of uint
wrap-around, so we have to be very careful to not add/subtract
one and then compare. Just to watch out for when reviewing.
