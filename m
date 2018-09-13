Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67AD11F404
	for <e@80x24.org>; Thu, 13 Sep 2018 19:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeINARr (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 20:17:47 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43264 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeINARq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 20:17:46 -0400
Received: by mail-ed1-f66.google.com with SMTP id z27-v6so5486099edb.10
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 12:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=UA+yRIB5x1ujuPW1FKs5eyc6pKd85nlfXFMWXtg4GKA=;
        b=M1skK2VV6i1acTIOb35P3YMYeKpiNVOQj9J4fXBIKhJ7EciHELbjzHI1lYugh3o5g+
         5DB0WX5TlL97eFiGQpfG8bk3JRmm2FjyxJ8+ARm/9GXU0dpH2Tu/tAKOEQwsPPeJLVGx
         MlRQO3XZS2qTJ4D6hx93I9Y3NH2s6gdz7ME8oVt1GXJAtUcCQsk1k5V5viGFyA2cy8QE
         J1WRGvFXPYUyUGL/+8kT9N8laVWEz3hcxSxSQRPW4RKNd9GZ+8OVUwVjX0dc0Cnak1Zz
         5cBz6FBKBGHEUSwHMA5skYsY9f64CTPQyXv5h9htfd7P52zITw8au0WXk1Wa7UZufyu3
         DYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=UA+yRIB5x1ujuPW1FKs5eyc6pKd85nlfXFMWXtg4GKA=;
        b=F+sdNeMTlw9G2TqnWsPOnW7o5YAWdsJsyZgdFtd9IURXm1xOsMF+f4UsOEz6wJ2d+l
         KwA8A8HWXZd/6jYqzd+sk8kuXK7U4tW/N9+doAh1/6ayGDbCRVg0jA8eD60eA0Xlwyj0
         K74coiCm5NG2eSEYTl30hVtPZmHUNX0mzs+dj1ukmjl0OVo9CDG+uh15TVUD5H6HQECI
         EfJT2I++9DasNVxDePmlXpFsTD9VkPpJWfgEMbEoYRIsrEdCAMACEJcSY4CJr2yuUPIb
         WfJ/gAT52eYovkQIhis6hDc/znxLL46uidS2yUrjZT5l7maaMDhx3pjvwOEKnN/yZfYp
         IGhg==
X-Gm-Message-State: APzg51AKZlyySFwUqEY054IvAUrg25LcMZEZ4vP1hyes7LH/ThNs+lqq
        af0wUgh89/CdCtDNm2/pqd4=
X-Google-Smtp-Source: ANB0VdY847gEV6DwE48aowY1l99SZmVD3kHOAUa6IsDyouPIdMH3nxJ+fExj4Mklo7C8Qpn/4r4xyg==
X-Received: by 2002:a50:8612:: with SMTP id o18-v6mr13703386edo.111.1536865617464;
        Thu, 13 Sep 2018 12:06:57 -0700 (PDT)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id y7-v6sm2072634edd.13.2018.09.13.12.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 12:06:56 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 11/12] t1407: make hash size independent
References: <20180913051742.252276-1-sandals@crustytoothpaste.net> <20180913051742.252276-12-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180913051742.252276-12-sandals@crustytoothpaste.net>
Date:   Thu, 13 Sep 2018 21:06:55 +0200
Message-ID: <87efdxkyi8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 13 2018, brian m. carlson wrote:

> -	$RWT for-each-reflog | cut -c 42- | sort >actual &&
> +	$RWT for-each-reflog | cut -d" " -f 2- | sort >actual &&

Aside from hash size issues, this just makes the tests easier to
read. Thanks!
