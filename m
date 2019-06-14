Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCBF31F462
	for <e@80x24.org>; Fri, 14 Jun 2019 22:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbfFNWJP (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 18:09:15 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35727 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfFNWJP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 18:09:15 -0400
Received: by mail-ed1-f68.google.com with SMTP id p26so5559891edr.2
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 15:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=F6S0RbGKCPn+DHHSv3zYZWx4xze5eSsjmNidMx8IhaQ=;
        b=gX0XcsE2vWkxb/Ecc788c2mTACx4dD7e95J+bs6qiIJDPAw8RciFc8ORvbovGwMRyM
         OVydJccQkpFgaWaQaBN59L76tr3gaGGWQo25wBLH+hfIZaIZtQ+7TDD9xI4kJqm7OgEF
         spe3A6772MjO1KyqfGZo+TlgB+rdi/TDTX8/G4H6iwL17RIJXXDvrlGL1ta+n74z4mXP
         sVjqKiVe5LfK+536apCOzki14qrwlERo8eyJMy37cQnjB8wp8gXcmhPqT7dXyAU7Bwt7
         5oH2kmBFckWxetT4xdx6LV1TSeRsjKhG2AYAvEYTM0NnBHq5H4g46w24Kc8GW79KXE7a
         O6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=F6S0RbGKCPn+DHHSv3zYZWx4xze5eSsjmNidMx8IhaQ=;
        b=NKrxb7BUAUbJhOEulxheM4j4DFI5jEVKvc6BWl+1YU+4KDIFjwbdp7s4X1BDWoq41f
         x4F34/V4Lan/VEuTqKaCw9I4TjB6xzOO5JPVissKCHaeZd1zlqfQYPIVSm/AjlZp6pYo
         SNBQHoFa+EjvNyUGGYHXH8WDM6yxhQ2Pma82kNY+Q0WlfUZNmSv0j/PhkPg/2k5N6mPa
         ssBzy4fd1D/TgpSa82ceTYveVYNoKY8+UFWAQalHpukruQQjqy0gOmWH4gFLxhzqU1+6
         wCjI7VZs9eHHJQaRKqoq6ry/KigMUUf/4G17/p7h7LthIJupTVUGXzx74BpCkpdotx5o
         EAxw==
X-Gm-Message-State: APjAAAUz0XzmG0dvNQI5/bykqhDubptQIYtzuZEVYh9mdLwMK6iGleWT
        G1HIc7YnDlfS4WAXeISck94=
X-Google-Smtp-Source: APXvYqxY9RHSM3K8/ElTtjoZRUbxZP/MEi6u2e8EyD1sNejxV/p7B9xWCgYPfbpMWcFfj2uC4CPwcQ==
X-Received: by 2002:a17:906:5512:: with SMTP id r18mr85135701ejp.298.1560550153804;
        Fri, 14 Jun 2019 15:09:13 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id y11sm807482ejb.54.2019.06.14.15.09.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 15:09:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/4] kwset: allow building with GCC 8
References: <pull.265.git.gitgitgadget@gmail.com> <c1527a71672056859a4613f2318bcbfce31e8b50.1560426581.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <c1527a71672056859a4613f2318bcbfce31e8b50.1560426581.git.gitgitgadget@gmail.com>
Date:   Sat, 15 Jun 2019 00:09:12 +0200
Message-ID: <87wohn95vb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 13 2019, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The kwset functionality makes use of the obstack code, which expects to
> be handed a function that can allocate large chunks of data. It expects
> that function to accept a `size` parameter of type `long`.
>
> This upsets GCC 8 on Windows, because `long` does not have the same
> bit size as `size_t` there.
>
> Now, the proper thing to do would be to switch to `size_t`. But this
> would make us deviate from the "upstream" code even further, making it
> hard to synchronize with newer versions, and also it would be quite
> involved because that `long` type is so invasive in that code.

Also because we'd need to switch git.git to GPLv3, as noted at the top
of the file we've grabbed the last GPLv2 version of this code.

That or convince these authors of GNU grep to dual-license their
contributions, assuming their code isn't derived from something else (I
didn't check):

 grep.git $ git shortlog -sn e7ac713d.. -- '*kwset*'
    25  Jim Meyering
    25  Paul Eggert
     8  Norihiro Tanaka
     2  Paolo Bonzini
     1  Karl Berry
     1  Tony Abou-Assaleh
     1  Yuliy Pisetsky
