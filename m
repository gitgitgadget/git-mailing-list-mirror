Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0928200B9
	for <e@80x24.org>; Sun,  6 May 2018 02:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeEFCdK (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 22:33:10 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36139 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751832AbeEFCdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 22:33:09 -0400
Received: by mail-wr0-f195.google.com with SMTP id f2-v6so12749258wrm.3
        for <git@vger.kernel.org>; Sat, 05 May 2018 19:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kpO0+KuHpUtAM0ABZEgqx+hmGE68gYBQIbZbsIX5uP4=;
        b=N8jJ1i1e0iYLyoASE+C69tKAAp/VjTidakNxJZeXV53AIfTxbx4CNMcKq038wjSMGw
         76DapM3cnsdZxLnu+4NDRAAYJ7Q8yZ4GJKJTfU9VMmnH4/L+Vhz118+iOd4jZGF6sVZd
         fLPQIPyH51f1EiIE3kvwqbQG/07E3YYJ8A4wv2ryFUY7vazc4Nx7DGazPwcYeiC7hk3P
         JgNt8PoYK9Ys97P0T04mU43XDaudOcGlCKxxZJzBjehaUfckx5Ye0Elsbcoz8a0uxJuT
         xp/dksMK1M2AqPj/bXBPYaWoglB3f1RIlJ//S5fFcLQmtRfLO+WEHDOpgC6RrT+55LDP
         2s/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kpO0+KuHpUtAM0ABZEgqx+hmGE68gYBQIbZbsIX5uP4=;
        b=lHANCdxwHGqvkavPACTNi3iGF4NwqREq4/E9YrBFwfP8GTCIr1BCwZ9UwmTPRK7Miw
         TIaJmjx8+P4xPD3KwL3xQU5pfsMI1JQNUdHNNzTfv+ZaIJIHQ5vcXBoEADrE/l616Lwg
         FLGOwgeapSIDJpLi++JyZu/tgtBx12uTCsqI8vfFt5cGke4zJ29o21LlKLgqY/oM/9o+
         SZeiaBqYbmkfOocuYyn6NHk8KrghUwVpYSG8mrpemvezaqZJ5ulEcSwpL/6yxDP2EENW
         bt/4UmZLBsKrAysqvQwPj7PDCPcYvzCT573OlOpI3wDB8Fh9Y7LNz31/7S0577G6t8Px
         ujFw==
X-Gm-Message-State: ALQs6tCRX1j0tk8zXUg9GSRux7PVCE0vkBFiHk5N2gyJfbLOmX6Umhpn
        6X8I2csj5mchVzVvjxXjnek=
X-Google-Smtp-Source: AB8JxZrE6JWP1iaBG5vRybjVBRlN9nSeux/znWZ9Y0I16w7Qy9iUMEFT/M9153RfvYYgHaNU6aiopw==
X-Received: by 2002:adf:9d8c:: with SMTP id p12-v6mr24462285wre.14.1525573988099;
        Sat, 05 May 2018 19:33:08 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k23-v6sm23716737wrc.59.2018.05.05.19.33.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 May 2018 19:33:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
        <cover.1525448066.git.johannes.schindelin@gmx.de>
        <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de>
        <20180505182631.GC17700@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet>
Date:   Sun, 06 May 2018 11:33:06 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sat, 5 May 2018 23:57:26 +0200 (DST)")
Message-ID: <xmqqk1shsecd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Peff,
>
> On Sat, 5 May 2018, Jeff King wrote:
>
>> On Fri, May 04, 2018 at 05:34:32PM +0200, Johannes Schindelin wrote:
>> 
>> > This builtin does not do a whole lot so far, apart from showing a usage
>> > that is oddly similar to that of `git tbdiff`. And for a good reason:
>> > the next commits will turn `branch-diff` into a full-blown replacement
>> > for `tbdiff`.
>> 
>> One minor point about the name: will it become annoying as a tab
>> completion conflict with git-branch?

If tbdiff were "Thomas's branch diff", I would call this jbdiff ;-)
but I think the 't' in there stands for "topic", not "Thomas's".

How about "git topic-diff"?
