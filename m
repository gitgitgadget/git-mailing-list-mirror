Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C7B11F404
	for <e@80x24.org>; Wed, 21 Feb 2018 19:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751565AbeBUTe5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 14:34:57 -0500
Received: from mail-yw0-f179.google.com ([209.85.161.179]:35060 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751401AbeBUTe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 14:34:56 -0500
Received: by mail-yw0-f179.google.com with SMTP id d205so893705ywe.2
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 11:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OsCFTJ2lsXd1L8ousWdzfMqMQEm0nAN3pR7qLOEtmuQ=;
        b=dDe1tr1FHOP8RMFJvkFt0CTb1QEMVslquCPYzR3nIs7jVEwdGExMLDSC1ZgrvnMsbS
         KZ5avnAljqNPojUpVLw/cjk18jsGvt9AGqFm/eNk+Hi9nNoxU1jLN1L2G8SLlVISoH0a
         QJTq4s+Ux7v8dKks7T769JV/DpWAi85ZAGlGU/6+BV2CFFAkNMH6HOnpBmg9PTH/kvU2
         Wx9R+gH4oBdU5jWQBaX7xO3h39xosBHxIPzZ1v/Xr+qFIIDBXW/dpI8uwjzuvtWSuSkk
         S5VKjGV8EgkK0graLp9CAovcivYr5tcc44vfmCnTto6upXPjxjPByyPoXOJvOPDj++No
         nagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OsCFTJ2lsXd1L8ousWdzfMqMQEm0nAN3pR7qLOEtmuQ=;
        b=TNTSqa8iAICiGcVrDHiE3z4p/SO32C17NolsuS+NyOd5YAViNOnb2KuJbUtGOwuYJG
         6kAfz6cJBz6IDE2XLWi356NMndYKO3C2+T5r7Vuile/VKoCym0Do42jR0MGJKM2s916N
         6KRYuNmnBsti0Mt6LDwVWr3rCtwitNhvap9ucrdFWZntAX7pIq3Qj7D0+pqfY3erisQ1
         ecl90LyAo/yrCtWw0uO7gGSxeL8kpNGVldCINwsIrabLMX0FuO0Jn17HbZzpn7ruAchy
         bdLJnzMbXXcx1gYWKY8s21GJxJZo3snjxiqj/otYDF8wq7HNMJE71NOFvOk5WQ6Gwb7k
         soYg==
X-Gm-Message-State: APf1xPAL6WpU+XysfZl3+zKN4q5KCDFsaDegU8PSCpXR0HizWvS53WDp
        Y4LvgV234eYKDykywXxHz0BV1LoqttCiqVpFTMOH0Q==
X-Google-Smtp-Source: AH8x227LxNnmMEiEoWR8KvkAfV/4jZOhXZfvwMl7cKgiykQsSAAH1XLFUxLmdGHkJofoY3XjMXTMpZsESpSqp13+kwo=
X-Received: by 10.129.182.2 with SMTP id u2mr3057559ywh.345.1519241695350;
 Wed, 21 Feb 2018 11:34:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Wed, 21 Feb 2018 11:34:54
 -0800 (PST)
In-Reply-To: <1519066406-81663-3-git-send-email-dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com> <1519066406-81663-3-git-send-email-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 21 Feb 2018 11:34:54 -0800
Message-ID: <CAGZ79kZy1Z9GnHjA=NRoiszjP+pYwBZCKRps_RCgwa+x-jmrWA@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] graph: add commit graph design document
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +[3] https://public-inbox.org/git/20170907094718.b6kuzp2uhvkmwcso@sigill.intra.peff.net/t/#m7a2ea7b355aeda962e6b86404bcbadc648abfbba
> +    More discussion about generation numbers and not storing them inside
> +    commit objects. A valuable quote:

Unlike the other public inbox links this links to a discussion with
all messages on one page,
https://public-inbox.org/git/20170908034739.4op3w4f2ma5s65ku@sigill.intra.peff.net/
would
have this be more inline with the other links. (this is a super small
nit, which I am not sure if
we care about at all; the rest of the doc is awesome!)
