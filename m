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
	by dcvr.yhbt.net (Postfix) with ESMTP id E8E401F404
	for <e@80x24.org>; Mon, 23 Apr 2018 08:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754029AbeDWIBV (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 04:01:21 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:41188 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751356AbeDWIBU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 04:01:20 -0400
Received: by mail-wr0-f172.google.com with SMTP id g21-v6so11004619wrb.8
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 01:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=1UM6Icc+zeSJxzpR5XKlnrMc9lENx2CBVuqrVLjrEpo=;
        b=YkSSARLbQNcBcW52Y3M4VRRLlDflg8pXvsRiFcQFyhg9/qqJk578As32kWkhwU0bBS
         CZh24MXNYQ+USCdvgm+oQNfO052roVJjDaM7HPG7ImbQtDNnLOtJ0QRNQKGr/4KJzURV
         sLrr/8DsmlCMG5gghDsgbvJgmUFSLJN0XG/4xwAbPkvxK2kUpCFVoY7KTyd3Hngv9aLP
         NNZu1Sax57O+WduawScsxP9RVfvISA5DVYEZWCM9Clc7khlBKextO5lApqvUsUCzMUcR
         bOfgfjtXNR+MG44nIGwYhJQkSsUQ9dPs49CYR2eeBIiXn+/G7cHfvggiPb0mldv4RDE/
         YRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=1UM6Icc+zeSJxzpR5XKlnrMc9lENx2CBVuqrVLjrEpo=;
        b=gptVSvOBTW1BVlju82kzknWlwkW9P5M/BXVNJDEhhJzvskxZ6QUVkScghHDPpAPCD2
         WiPfvtSGTGQbMvRLS9an60mkWimmc0mXn265ZpVg8/CnR6lXVjE37NTTY0hvbcvcIDty
         FhZt7y3R8RpwkjHbgFaoqoL8hmlnylLi+yuXKfwLn8VgCbj7lJKWif36weQCiAnGPHvz
         sN+pRuXBg3Xfb4W4cNDWFo649oTiafK6M0UWUGKllRRk5q768yN3X0KuntUyj5ETWtHL
         E6+9yH6i72Fq4+Z3OCCoLsDzFm5plTWbJ3cOsvt86dCMOd1vOTmjnXrf0R/+/9inGzvB
         XC+A==
X-Gm-Message-State: ALQs6tC9KXCcsMLa8hnO5faVeOu6pjgtJc4F/k4kLrLRuTa9TSqMbE3m
        eQAsDrONF5nXXZgfXZvG260bHxUL
X-Google-Smtp-Source: AIpwx48phpJxWHeGGSZ5cD8utQeXBxVGbSSvkk5H/385/0yjlhm5mMo2kLFyoaMYkwhh5opS9ngnag==
X-Received: by 10.28.161.4 with SMTP id k4mr9055843wme.106.1524470479495;
        Mon, 23 Apr 2018 01:01:19 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id s14sm6161705wmb.5.2018.04.23.01.01.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 01:01:18 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>, Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v2 2/6] grep.c: take column number as argument to show_line()
References: <20180421034530.GB24606@syl.local>
        <cover.1524429778.git.me@ttaylorr.com>
        <5aaf7bebb27d385ea090cb83e97c596983ebae47.1524429778.git.me@ttaylorr.com>
        <CAPig+cQ2+wTTXE0mhnGnp2pZug=Po0SCVwCO_2agxUDaOsFRLw@mail.gmail.com>
        <20180423011726.GD78148@syl.local>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180423011726.GD78148@syl.local>
Date:   Mon, 23 Apr 2018 10:01:17 +0200
Message-ID: <874lk2e4he.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 23 2018, Taylor Blau wrote:

> For your consideration: https://github.com/ttaylorr/git/compare/tb/grep-colno

Looks good to me aside from two minor issues I noticed:

 * In "grep.c: display column number of first match" you use a comment
   style we don't normally use, i.e. /**\n not /*\n. See "Multi-line
   comments" in Documentation/CodingGuidelines.

 * You're not updating contrib/git-jump/README to document the new
   output format. It just refers to the old format, but now depending on
   if you use "grep" or not it'll use this new thing. It also makes
   sense to update the example added in 007d06aa57 ("contrib/git-jump:
   allow to configure the grep command", 2017-11-20) which seems to have
   added jump.grepCmd as a workaround for not having this.

But also, after just looking at this the second time around; Is there a
reason we shouldn't just call this --column, not --column-number? I
realize the former works because of the lazyness of our getopt parsing
(also --colu though..).

I think when we add features to git-grep we should be as close to GNU
grep as possible (e.g. not add this -m alias meaning something different
as in your v1), but if GNU grep doesn't have something go with the trend
of other grep tools, as noted at
https://beyondgrep.com/feature-comparison/ (and I found another one that
has this: https://github.com/beyondgrep/website/pull/83), so there's
already 3 prominent grep tools that call this just --column.

I think we should just go with that.

Also, as a bonus question, since you're poking at this column code
anyway, interested in implementing -o (--only-matching)? That would be
super-useful (see
https://public-inbox.org/git/87in9ucsbb.fsf@evledraar.gmail.com/) :)
