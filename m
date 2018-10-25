Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E062A1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 01:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbeJYJbA (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 05:31:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42388 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeJYJbA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 05:31:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id y15-v6so3058119wru.9
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 18:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4HAhY/voD600WPgO3k7LV13Irn864dZLo+oyey5zpl8=;
        b=OTXZH7QlOeA07WTRyl6PamFQ+uZ9phVQRXfrkqcCnCpFwD1smGxU4dDLCU8iTHcWgA
         nW+YIIXfTK4Sg2gFCck89UWWJ/JvmfHfC+YE744ovOLz8RVA0ReuJ9QMqWsh4JQmPBe7
         LSkbVBFaVkqL/t7ak/JShWELqiH+FbYsg76tmJu/271byyv0iR7hZXis590jutKRDOSG
         DO4RPP7FpwideJjet+JHhsSOogactFjAT1chMuyua2BmfZmPROvmYB9zZFjnKt3/2DwQ
         RbOHKBJEznYcz1P0bJ7jopGa25yKzq5HTLpRlx4zZoEKx1XmzIpD695NbedfTtqp+Hza
         sjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4HAhY/voD600WPgO3k7LV13Irn864dZLo+oyey5zpl8=;
        b=ECq66j8jtwp0Dl9/zPmJyQbmH/yR2j0G8SAyHomL5BIXr17mTGKDro3hciYI8nOOyE
         yvMFZUc6lxlmgdMJ1V7yX1w9f50wu9v1ScMuDXGXi+4rwjn+DN0pB4X/3Bn09VfZZmPX
         ZS1T7P3bu8DdBRUUWx7Kr83L6m6DOGEYfzrz7jhKHjTwEk70XnT8L7yOtUfKfbH6d6dz
         1AhGOxRKpZdIesQbCJ3+gxFW6xLOEdH8t2JYqCAn8GiCO2hXij3cceMZTcYvVfxGNNUO
         cTs7KHIAS9l8idtjiduy+L6Fi+jFv3W7ifUS56rH9hoAw3QdwIRQDAK94b9qXsb+NOWa
         SP4w==
X-Gm-Message-State: AGRZ1gK5Rauv9nCWiGiFqGrs+Xhi2pdfxS1Ik2qKEwn/VZQpweb5DZgC
        DGbX9REUrly0G2CqnrUlOAg=
X-Google-Smtp-Source: AJdET5eAGwF20aLfUEUtOcYjL0VeN4jYbJgIGeF/RoDmB2JOlONR9Tbla9Nn4PwHOncK98U8AEWj9g==
X-Received: by 2002:adf:e68c:: with SMTP id r12-v6mr1814906wrm.239.1540429235100;
        Wed, 24 Oct 2018 18:00:35 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 4-v6sm1513547wrk.52.2018.10.24.18.00.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 18:00:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] i18n: make GETTEXT_POISON a runtime option
References: <xmqqsh0xtwgb.fsf@gitster-ct.c.googlers.com>
        <20181023210154.32507-1-avarab@gmail.com>
        <xmqqefcfoq2a.fsf@gitster-ct.c.googlers.com>
        <20181024074400.GA31239@sigill.intra.peff.net>
Date:   Thu, 25 Oct 2018 10:00:31 +0900
In-Reply-To: <20181024074400.GA31239@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 24 Oct 2018 03:44:00 -0400")
Message-ID: <xmqqefcen8ls.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> but then you lose the default handling. I think if we added a new
> option, it would either be:
>
>   # interpret a value directly; use default on empty, I guess?
>   git config --default=false --type=bool --interpret-value "$GIT_WHATEVER_ENV"
>
> or
>
>   # less flexible, but the --default semantics are more obvious
>   git config --default=false --type=bool --get-env GIT_WHATEVER_ENV

Yeah, my thinko.  The latter would be closer to what this patch
wants to have, but obviously the former would be more flexible and
useful in wider context.  Both have the "Huh?" factor---what they
are doing has little to do with "config", but I did not think of a
better kitchen-sink (and our default kitchen-sink "rev-parse" is
even further than "config", I would think, for this one).
