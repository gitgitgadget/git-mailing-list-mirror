Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 893781F404
	for <e@80x24.org>; Thu,  6 Sep 2018 07:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeIFMNF (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 08:13:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34827 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeIFMNF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 08:13:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id j26-v6so10249964wre.2
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 00:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=xTy5eHSCd8CyICEi6YtqR3hITB/03/4EnINvSiLi5jY=;
        b=aXmOAuOT90cRfZydv584nLXAcWaGfmzzb5bfqFPAiLpl8fTm6ej2MiVC4TYL+MbNev
         CSk2xU0aC3Ns/d26Rn28GzXMmbkVbVBF7WoeRi1sijaJJJl/zKsKF5jJZIYAWmscZ1I9
         9tyfwOxK0FKEtBGRU3lizE2GgllQGhzNUdH4BeGXl1q+vuV1640nmgutzPR24Y1Yae8Q
         4PbC1V76toWnZSGG6D9gw7FYBS1HL3GLyrsnDMzpQUwYzbLHstf6lNr2fLjkvMENXB/w
         wUjNQeFyopstVW+Tb+i6IY9fyhFphdc2Mo/wCYoyH/VKSRb9CZlhaeOICOB8budPPFmZ
         pVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=xTy5eHSCd8CyICEi6YtqR3hITB/03/4EnINvSiLi5jY=;
        b=MhjXhltsO4ONiCmRK8c3lef/SvAjX9vtiYTpTZs62Gc3cSN+EqaiJcwjlM6M2UVo8r
         d07bQ6epvh8VDKuvFsGRt4hjXPndRrWaA31tvkxHu2Mm6Ot/89l89tV8sPCrAM0TXiSY
         91BnwmrQG1oILT0FqXoDne+z9Qp85FBOUwCgZC0RVLmInUH+WAbT0KUmwQ1lNIfPxmfP
         8bpzxWDFd0oRUoWkcX0CCYC83FNs/tLmymMzpfMKwXNNbZD0whie3zntEeXmh+Ul44BT
         GfUzaI3E1m8qE8FtrEQ8nsO763B/hrPrAB8gYFXV+Tou8jkAUxOqeh4rtIuKf31xgiBW
         yG7w==
X-Gm-Message-State: APzg51CJpjeh1+w9wRdBDqZnnjgufCrYBNlfmUw+ja+HcW/SsYTtGuIi
        psR4E8rvC+batR5WWRHZvgc=
X-Google-Smtp-Source: ANB0VdYoDx8kSjcC26iOcENifDm2XwwVdOCC/AOgCY6BPFafEki7F4WlrtRb2B0e6yk7jZvRF6Vtgw==
X-Received: by 2002:adf:ef89:: with SMTP id d9-v6mr1183794wro.195.1536219537071;
        Thu, 06 Sep 2018 00:38:57 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id v21-v6sm2841782wrd.4.2018.09.06.00.38.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 00:38:56 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Stephen P. Smith" <ischis2@cox.net>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 0/4] wt-status.c: commitable flag
References: <20180906005329.11277-1-ischis2@cox.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180906005329.11277-1-ischis2@cox.net>
Date:   Thu, 06 Sep 2018 09:38:55 +0200
Message-ID: <8736unrs6o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 06 2018, Stephen P. Smith wrote:

This all looks good to me this time around.

> Stephen P. Smith (4):
>   Move has_unmerged earlier in the file.
>   wt-status: rename commitable to committable
>   t7501: add test of "commit --dry-run --short"
>   wt-status.c: Set the committable flag in the collect phase.

Sometimes you send mail from this address as "Stephen & Linda Smith
<ischis2@cox.net>", do we also need Linda Smith's Signed-Off-By? :)
