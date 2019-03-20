Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E23CC20248
	for <e@80x24.org>; Wed, 20 Mar 2019 23:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfCTXFz (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 19:05:55 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34823 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfCTXFz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 19:05:55 -0400
Received: by mail-ed1-f66.google.com with SMTP id d6so3476455eds.2
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 16:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Oj87rynV2Bq5rClbQWpM06vV1EnpBTo2H4SBPvPjRKg=;
        b=NikS+6do6b/zyluBAcP5vqpb1+51bI37JtvZChXMcTfg5uhEOzX1Py9CSy66wrji7U
         NLPP/D8tT7s5ibIbO35wqO19qY8GdfjZsanKEU/mcUuggXWDFhQLblil15WRnSvUh5ua
         O1puQcTFGyEFlmwcarFf3yGUdYvLos9/ze5xCKceGAJXJtCZMOZl/386pMbyfegMoWpl
         crAw+inE2bfGwosfHMnmV5PZwGOJWhtvlyHLO8PDqBVwmWt+es7ls1NECpTeIY0huZ3G
         8uccDkcdgvGrqpCre/istRgFfUT25tBDnVwmsBtojujj2CPpqAt/1eLPkZJCHOyLa/7o
         oAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Oj87rynV2Bq5rClbQWpM06vV1EnpBTo2H4SBPvPjRKg=;
        b=AGH0mPVfEIvEawOrSwP7PDKO20X4qf8rPUUA5A69uEGnzF89t69ktS9zFXo36s2Uuw
         PEAKnC4f1CDhG30COsFZvjlljVa35G/GguMlc4Obe5rO6tLtGaXTwIbMdzAM20kJ10cK
         uqGjvegr1W41Rt3m0rUoIV2fI2RnKqORF59PEocXnbk3EddLxOuw6HtlaEDIZelaIROq
         40ERPcqlpRWKpNIxAcFALBD779umBJnlDYPxldbFaD9x+AXKcWVfOuweI+Ul3BPNKXPJ
         xwLWr60AujGaCJlUYU+r08nQjlxcf919mdRhNPgDTLt+5OVSkPFV+zQ0m3zsdxd9QpP2
         2hnQ==
X-Gm-Message-State: APjAAAX46JF91f973db3Sua0u+Fs42S8ffw1jULIVP1MqHKcIm0/EivR
        7RBB07RhWuZ9fE/FmVE+ETQuvQjr
X-Google-Smtp-Source: APXvYqxEFidXs0j1W/xgcJo5psxt5p/5OrNQqrzdyD41c0lRGmiXUAb5meu6B3ort1z1O0/ZpONZIQ==
X-Received: by 2002:a50:cd4b:: with SMTP id d11mr292534edj.137.1553123154005;
        Wed, 20 Mar 2019 16:05:54 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id 9sm679638ejg.71.2019.03.20.16.05.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 16:05:53 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 00/11] rebase -i run without forking rebase--interactive
References: <20190319190317.6632-1-phillip.wood123@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190319190317.6632-1-phillip.wood123@gmail.com>
Date:   Thu, 21 Mar 2019 00:05:52 +0100
Message-ID: <87y359cfjj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 19 2019, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> When the builtin rebase starts an interactive rebase it parses the
> options and then repackages them and forks `rebase--interactive`. This
> series refactors rebase--interactive so that interactive rebases can
> be started by the builtin rebase without forking. My motivation was to
> make it easier to debug the sequencer but this should help future
> maintainability.
>
> This series involves some code movement so viewing the diffs with
> --color-moved is recommended.
>
> These patches are based on a merge of master [e902e9bcae ("The second
> batch", 2019-03-11)] and ag/sequencer-reduce-rewriting-todo ed35d18841
> ("rebase--interactive: move transform_todo_file()", 2019-03-05). They
> can be fetched from the tag rebase-i-no-fork/rfc at
> https://github.com/phillipwood/git.git

Just a that the t/perf/*rebase* numbers look much better with this. I
don't have these in front of me anymore, but over 10 runs with -O3 one
of those long-runnings test was 30% faster.

Another one (rebase -i) went from 0.02 to 0.01 sec, with that short
amount of time I wonder (but didn't dig) if the test itself is broken...
