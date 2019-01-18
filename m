Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1467C1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 19:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbfARTlD (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 14:41:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33354 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729277AbfARTlD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 14:41:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id r24so1692353wmh.0
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 11:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=+UBpUTGdJlRnAwbeuRhDzBy87ZpcQW0/hiH2bVThxHM=;
        b=prZXbwkWCeOSodgrQNVtCFY4GVR7fQIb39Oei17OJ5xsnbAcJfXanTtJdsZpVkSktg
         pCJ2zEKrGgg0iZTntNiPDATuFwx6fMagus/2GKCUqcm5R8fPBe7S3lhNO5uN/DsNd+ar
         VGrdcgEba91wXmGcGk+ARDsCo6jPDg9DA3e5PnpFeRXLceSHsk5ExIG6qntdOcmz4uVR
         BkPrIFcnl6VmbMjyy7yFxRtLG8ynYtBuHieRq6dQYKvyZRBcSkfWNHK2e+dieChjSnYb
         Gc9lN5Mnl5nPr8/C2IAAW3VKL1mj8X5zOqWAqte6taMgLFscoERW2S884r6eqAFxUqvt
         86TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=+UBpUTGdJlRnAwbeuRhDzBy87ZpcQW0/hiH2bVThxHM=;
        b=sp2HhydHch1fCu/JKA5gotapsMlUgmcZ5vFAgor2i2Ks8Z3jWqStjauI+Tykir7bkj
         rsW4/tql4Rpsc/GR5d+fgMGJ/rWXMRTRXHYJOlBCrafADWY4HWqFvJmvySStcf6rbfPL
         oMpTUYsDIrUiFL8WryiRnuQ0NtwHiSHrglbc8A/Pu2WQW+LzDk3GmuBwIQP3BoLNGYMW
         98b0MwAUEdpeTh3IB4qgw9+r/qKHSTZSXM9QaiJRJwTvIZ5xHhfXkT3kd1ANa2D1ZKw1
         Mi6AB6XrG3voLQQoHewCcCyQw4TqHVJgmK2RPSeZjjk1XIMCffVUL38ys496IrETlOeX
         ApYg==
X-Gm-Message-State: AJcUukdH9cGdA5lHvU+OmKpL77BQrBVzx8TdXt3JP+8KRjgctJS1H+Mb
        BIVXS8TUzBKYdMYzsC3K8xc=
X-Google-Smtp-Source: ALg8bN7A0WrO3oOWYLgKzDNLZjtsCwZ0Gnp4oATjTzYfgUzS5VrKaRhRy04E832tz0vn8/hfucta7g==
X-Received: by 2002:a1c:8d53:: with SMTP id p80mr17637580wmd.68.1547840461364;
        Fri, 18 Jan 2019 11:41:01 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g129sm41575083wmf.39.2019.01.18.11.41.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 11:41:00 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] commit-graph: minor cleanup and optimization
References: <a82a2bec-07f5-ccd2-85ab-b9efd406929e@gmail.com>
        <20190118170549.30403-1-szeder.dev@gmail.com>
Date:   Fri, 18 Jan 2019 11:41:00 -0800
In-Reply-To: <20190118170549.30403-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Fri, 18 Jan 2019 18:05:47 +0100")
Message-ID: <xmqqimylkb3n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Wed, Nov 21, 2018 at 06:32:19AM -0500, Derrick Stolee wrote:
>> >>I rename these variables to 'num_large_edges', because the commit
>> >>graph file format speaks about the 'Large Edge List' chunk.
>> >>
>> >>However, I do find that the term 'extra' makes much more sense
>> >>
>> >>Would it make sense to do the rename in the other direction?
>> >I tend to agree that "large edge" is a misnomer.
>> 
>> I agree with you both. "Extra" is better.
>
> OK, so here are the two patches with the rename done in the other
> direction.
>
> These should replace the bottom two patches of the topic
> 'ab/commit-graph-write-progress'.

Technically it is "replace the bottom two", but it involves a bit
more.  The effect of this cascades down, so patch 3 and later need
to be rebased on top, while doing some more s/large/extra/.

I've done all that on a detached head, and the result compiles, but
I'd rather see Ævar involved in the rebasing process, so I won't use
the result of _my_ rebasing (besides, the "enumerate in pack order"
optimization also needs rebasing on top, that is another chore).

Thanks.  I'd just consider these two patches as you giving feedback
to Ævar's series and expect them to be included in a reroll of it.


> SZEDER Gábor (2):
>   commit-graph: rename "large edges" to "extra edges"
>   commit-graph: don't call write_graph_chunk_large_edges() unnecessarily
>
>  .../technical/commit-graph-format.txt         |  4 +--
>  builtin/commit-graph.c                        |  4 +--
>  commit-graph.c                                | 25 ++++++++++---------
>  commit-graph.h                                |  2 +-
>  t/t5318-commit-graph.sh                       | 14 +++++------
>  5 files changed, 25 insertions(+), 24 deletions(-)
