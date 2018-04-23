Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47A0B1F404
	for <e@80x24.org>; Mon, 23 Apr 2018 07:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751867AbeDWH1n (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 03:27:43 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:32819 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbeDWH1m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 03:27:42 -0400
Received: by mail-wr0-f170.google.com with SMTP id z73-v6so38224707wrb.0
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 00:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Z9v/3u6Qxv86g3JqsoQymsMnUfjGdR98SnhXqF5gZ48=;
        b=nVlG8bG/elfWzIfkX5r2mGCo7SKyETAFw5BbFORukYsOYN5tqEnxNvt9zwyfCTJ2yN
         JwmPpR1sJp2OCuM1sQ5+YtYbOiQ1/xLaitx/8r0I7dtbfIRp32HnUGdq1bD1l8GQNWHq
         poBjmjI3tSMgoYV2nphYoq8j4JeT1DIBLpcUo0ouztLXTkS13Hom9uqUcMo4lb4qSj29
         Ugr6JMeinOz5DpvQJcJVF+zxUfrRg+S6ne+EKJL/SZFIugddHffptM220VUkAG3vcAxo
         JgR2rtPLYTXQr5VrLav/lSg4OA8dyxvmMmGpZ9Ce8iCEI59O/4yyHfXHWSoI/5OPMEed
         hg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Z9v/3u6Qxv86g3JqsoQymsMnUfjGdR98SnhXqF5gZ48=;
        b=QtcYcsOnmbNavkP08iMF8/jsZLlGK3/59PfqlswhnswS54sXE+geSzfbP8O5s3lGFr
         ubxxqPdqRCD6UbSHitLlmbfe5PdZPsZGEc5utQmdoNsCerYlN03WPI9DFDSrwGsYf+ej
         J7zyTySP4jdIbSE05UUqyVRhIBN2ipz4SjEJ5BDulLpTt2rRUZCfHwMNiMORrrkaSxNU
         7fWMrWgz5KmEamLoJy5W6z7SkJb2QG7bempOBCBLJ3KS61OzhE0PNiN/7ZYkNHfoJPH6
         Z1teNL1PSTP2mmB0xDy5o29eRx1FPzv26hYLkmB3X30gQY4j6cUzRqhka1MNk+bTl21w
         miAQ==
X-Gm-Message-State: ALQs6tCkpdNMWbF9xlVlrLYCADYBMzMDykkd7YP02gonsPKClpnEXSIk
        w4zgTOvM2Lw9Ns1gScjxZY0=
X-Google-Smtp-Source: AIpwx48GEnOYpGU2wwvR9abL7MqfbS8+dnwZZDVHwhIBkPMJaF9M3aVhVcUVtF8SQfJXMJBnOflqtA==
X-Received: by 10.28.46.208 with SMTP id u199mr8182341wmu.99.1524468461037;
        Mon, 23 Apr 2018 00:27:41 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id b5-v6sm16814122wrh.67.2018.04.23.00.27.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 00:27:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/6] grep.c: take column number as argument to show_line()
References: <20180421034530.GB24606@syl.local>
        <cover.1524429778.git.me@ttaylorr.com>
        <5aaf7bebb27d385ea090cb83e97c596983ebae47.1524429778.git.me@ttaylorr.com>
        <CAPig+cQ2+wTTXE0mhnGnp2pZug=Po0SCVwCO_2agxUDaOsFRLw@mail.gmail.com>
        <20180423011726.GD78148@syl.local>
        <CAPig+cR0dP2Hrb4JhuqmCNFzDPoy7KdqYX3irso6mKdmh9Y4VQ@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAPig+cR0dP2Hrb4JhuqmCNFzDPoy7KdqYX3irso6mKdmh9Y4VQ@mail.gmail.com>
Date:   Mon, 23 Apr 2018 09:27:38 +0200
Message-ID: <87604ie61h.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 23 2018, Eric Sunshine wrote:

> On Sun, Apr 22, 2018 at 9:17 PM, Taylor Blau <me@ttaylorr.com> wrote:
> One important issue I noticed is that patch 3/7 neglects to update
> grep.c:init_grep_defaults() to initialize opt.color_columnno.

I think this is fine for fields that are 0 by default, since the struct
 is already zero'd out. See my e62ba43244 ("grep: remove redundant
 double assignment to 0", 2017-06-29) for some prior art.

> Looking at the tests again, are you gaining anything by placing them
> inside that for-loop? (Genuine question.)

The tests in that loop are just to stress-test grep with/without a
working tree. Even though we can see from the implementation that it's
the same in both cases here, I think it makes sense to add new stuff to
that loop by default to stress that case.
