Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59F77200B9
	for <e@80x24.org>; Fri,  4 May 2018 04:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750940AbeEDE4I (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 00:56:08 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33522 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeEDE4H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 00:56:07 -0400
Received: by mail-wr0-f194.google.com with SMTP id o4-v6so19645873wrm.0
        for <git@vger.kernel.org>; Thu, 03 May 2018 21:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=X55v2DvB2nr+U1ITWf6Qjf2KiuGHoAEmIGCy1xgdILw=;
        b=Tz6n7JvbRqKITxT4lobu2wFTk18jyIGUrc64FIuYcygdTjZ+0/SGLzeXrTbKDv5vk9
         4HNXxArahjyVR45vngkvbIOa4bkxb0+j4cd2SbhaOE/rqDz3r5Wy1e4SMh2ktzEZcvLQ
         KqtClCeeaLFrYu3+kHBxcrIkCC68/f3Hc/LlV1T+07NVXm7nCmS8kwBVo+MHn2OsMo7E
         vY/yB0/PoQQkCrjwbMmpXyRNNJaK2xDvXQ0+yJLbGVuxxcaHcxLoxSspAc7UO082PVEk
         iwi5axBKebsDQTXzH/P9CkruCxwaNhxCAejc0hgX0YCmD96VpxFyYZYM8gPKLUe4B1dD
         SdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=X55v2DvB2nr+U1ITWf6Qjf2KiuGHoAEmIGCy1xgdILw=;
        b=TzOZBTrLHKcIn7DAsgMYpn+iCpN4JqA5rPfC2VvxpThEWkOVB4N7V5d7m8lup0VT91
         LSrtCx628SsT3RmuIEmZP8koR+GaoE6PbiUh8T/gfnK+7IaUYBRCz+EJ1KynhdPEqwb2
         2daUda+x37iF3YyiNkn3a1UF6XMlxZBD2ke0xlLjxDoJoMKyvv78Hrcdxt2P7iS1cq6E
         WIkKi6UoJCZ7fjyxJ7qdQVJyiLnNyW9jqikrfCV0lNFAc5ZX6TLCusPQ+6n8quqmWclZ
         /L0+hy1ZqI4FoeeUdjoKH0Li0oX1/NQzaYTV2jDIp9y9zi5gUzk/Rx0VaGQoRHAlGeJL
         /4Kw==
X-Gm-Message-State: ALQs6tBhcc5zPgDXEzOiQGbBwIuzAssaKZX3TyyKlmn5knMuvw/Pv1Pv
        4qEyLXj8eJuZC4q3CeGqC60=
X-Google-Smtp-Source: AB8JxZroIHMWu4iWUB1n9BDvga7UfkURGWbtOzpzQjWGI88lHpK9yNSreXB5ntWox9VYPfadtRYH5g==
X-Received: by 2002:adf:a558:: with SMTP id j24-v6mr20643705wrb.261.1525409765689;
        Thu, 03 May 2018 21:56:05 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u20-v6sm24006779wru.33.2018.05.03.21.56.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 May 2018 21:56:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 03/18] branch-diff: first rudimentary implementation
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
        <ec51c71779a325263c1b705a6b1bfb003fcd528a.1525361419.git.johannes.schindelin@gmx.de>
Date:   Fri, 04 May 2018 13:56:03 +0900
In-Reply-To: <ec51c71779a325263c1b705a6b1bfb003fcd528a.1525361419.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 3 May 2018 17:30:31 +0200")
Message-ID: <xmqq6044t3x8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Note: due to differences in the diff algorithm (`tbdiff` uses the
> Pythong module `difflib`, Git uses its xdiff fork), the cost matrix

Pythong???

> calculated by `branch-diff` is different (but very similar) to the one
> calculated by `tbdiff`. Therefore, it is possible that they find
> different matching commits in corner cases (e.g. when a patch was split
> into two patches of roughly equal length).
