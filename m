Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEEBA1FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 19:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935829AbdDSTwH (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 15:52:07 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:35230 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935823AbdDSTwG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 15:52:06 -0400
Received: by mail-io0-f171.google.com with SMTP id r16so34194853ioi.2
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 12:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iCVRHNyt11QlWKsAzcqe01twIQkCmM2iQmkuwwLChWY=;
        b=ejfzGS54Uj1eFo3xyWKrMJQZa5OJ0/BhICEb7W7cS6Jm0u9KGNCtTQ+oGrbASnQEQx
         UEveXUjF5F/iChVWUZMWu6FniHhl8hJs8kAgm5GqWEMKjR6VAd7ZgFpCX8IHv3XH05na
         LBdA9/YYDmdDqLpBFk268NQwFs6nwxMKkFDYC6TMFCJqmza0BaUALcjYDWO2ZUATw9Yd
         ovdaaoQ+TTyST9c4+OO3ktZRU2N5S17CDo/JIDefr8/2GhhO11unhruN/MM629trgoa6
         5qxbckrB4fsiBcdfWe7/14EJwMraJKKvXxxRLHitS+eu4RlGz6YOP7q8ON+P7sy6aMtc
         lqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iCVRHNyt11QlWKsAzcqe01twIQkCmM2iQmkuwwLChWY=;
        b=rx4w4HUFBscAnNh0KZe9LE++8k+R1d7UTCUDsvSraxd/i/CwnpHPBisv3t1Om3rlXK
         umDUwphQq0qzjwckPOI4Eo9n8qVTuuRRBtwL9LQqFXjCIxW7yqDlAr9i2Mf/0oRYGYxR
         fbmpoBoMbO95FfdabEmpA/eplEcolilDXmBBjx/9wXlNKSRBuhqZXEkcEsdecbP0nj/r
         oI7LWGxij69PUajy1Wdg0yksxr0Z6R84Bi/JG1zyLimYBwVNe5eAKGbtj/xS0Mlwl7ef
         czKJ70GDh+Hb8oiDVNsp0ne9avIbDZ+6qrld1WHtJjBiae/D19hTJSgn7pgzT2/1gnxt
         UoHw==
X-Gm-Message-State: AN3rC/4hTovxDjD74iFxWk49/sdcuwHkp2dhGJfo9SKYiNHmwTjSvjcV
        T8MfvOReNAOOGgIz8tNyXYC256aoyl6q
X-Received: by 10.99.56.66 with SMTP id h2mr4690565pgn.40.1492631523971; Wed,
 19 Apr 2017 12:52:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Wed, 19 Apr 2017 12:52:03 -0700 (PDT)
In-Reply-To: <20170411194616.4963-1-sbeller@google.com>
References: <20170411194616.4963-1-sbeller@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 19 Apr 2017 12:52:03 -0700
Message-ID: <CAGZ79kZMLVR-G1C3WL5sdo101oURuvhtnx43z=mT_u7x5XoZSw@mail.gmail.com>
Subject: Re: [PATCH 0/2] clone: record submodule alternates when not recursing
To:     Brandon Williams <bmwill@google.com>,
        Maxime Viargues <maxime.viargues@serato.com>,
        Junio C Hamano <jch@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+ Junio, Jacob

On Tue, Apr 11, 2017 at 12:46 PM, Stefan Beller <sbeller@google.com> wrote:
> The meat is in the second patch:
>     The commit 31224cbdc7 (clone: recursive and reference option triggers
>     submodule alternates, 2016-08-17) argued for any further `submodule update`
>     to respect the initial setup. This is not the case if you only pass
>     '--reference[-if-able]' to the initial clone without instructing to
>     recurse into submodules.
>
>     If there are submodules however the user is likely to later run
>     a 'submodule update --init' to obtain the submodules. In this case we
>     also want to have the references available.
>
> The first patch produces a nice helper function and some refactoring.
>
> Thanks,
> Stefan
>
> Stefan Beller (2):
>   submodule.c: add has_submodules to check if we have any submodules
>   clone: remember references for submodules even when not recursing
>
>  builtin/checkout.c          |  2 +-
>  builtin/clone.c             |  8 +++--
>  builtin/fetch.c             |  2 +-
>  builtin/read-tree.c         |  2 +-
>  builtin/submodule--helper.c |  6 ++--
>  submodule.c                 | 78 +++++++++++++++++++++++++++++++++++----------
>  submodule.h                 |  8 ++++-
>  unpack-trees.c              |  2 +-
>  8 files changed, 82 insertions(+), 26 deletions(-)
>
> --
> 2.12.2.575.gb14f27f917
>
