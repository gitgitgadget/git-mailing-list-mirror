Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 543A31F991
	for <e@80x24.org>; Wed,  9 Aug 2017 14:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbdHIODu (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 10:03:50 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35109 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752461AbdHIODs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 10:03:48 -0400
Received: by mail-wm0-f45.google.com with SMTP id m85so32801819wma.0
        for <git@vger.kernel.org>; Wed, 09 Aug 2017 07:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=HsjrhgTEKCKoHQCFveZm+7OkpEGWHUwqh3Z+Bgh0FOM=;
        b=rU24SzGKD2QX+w93qdpjylXBx6ocS/cw3rCvPALBcWrnDMyRwnwptOly/OV5gPm+kS
         LatBoCTZDAdwlMZ+ptMQzqhP6zvpiqmPqTe6nxKyKCwcm39zaP+duN1Ds46MXsWraXd6
         xWmhgE76AcnjsymnMR0TeZw2giMaQ63NKdPCiMjTCvEevegT1EfesM0EnYOPCYqNLplj
         tjEafZ3181Kg7KJ3uwMT40OmD88cUB1bCg3itDXhL9C+G0j9EmYMKuMC2P9lvHZE5iwK
         ykdqDPn2vMRpC0jAYPfheebkRy0tcvedGjPyrHhtbK+JQ9QTr5XtxVnjR8c0nB4Qh7PA
         l6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=HsjrhgTEKCKoHQCFveZm+7OkpEGWHUwqh3Z+Bgh0FOM=;
        b=ObcupLqSbOiwpVYHzgQa9sNulQgPIu8oKoznBHltsRbmPo0aiaLu95Jg4IUIjwP+vA
         hUvmLCmcZMw/brNnWG3qPbpwq7QOboNLuMeM6LOiPppyD/5Fm/0Ky9e42IE95nh04rsv
         WkDI2m8Sad9FohYtNN8nuFpMGAsXfwBWf1IpggRp1rST9oB7/zR0FZnB87BiL7UyEk/G
         iuskYTzkXQ/Aa5M58KRfTba5gG+0bEgSF/Wpk35S9+TcnlO2vDvbHq6s7lnx0aw0kYfT
         MQcCVj8Fq+PygQtm9OQZW+PhL3lllc1eiGx/bFvtWSKC/4weQNdNzmGZITFA3wimc76Q
         5yag==
X-Gm-Message-State: AHYfb5heuRngSiTOl+58Za93GnAnKoNzopOHJU4xXn7qojEo0NEZZV8a
        domo3l4cVc7cy82BLIA=
X-Received: by 10.80.195.93 with SMTP id q29mr8192370edb.144.1502287427573;
        Wed, 09 Aug 2017 07:03:47 -0700 (PDT)
Received: from snth (157-157-140-194.dsl.dynamic.simnet.is. [157.157.140.194])
        by smtp.gmail.com with ESMTPSA id t2sm1780934edj.76.2017.08.09.07.03.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Aug 2017 07:03:46 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dfRaL-000535-MI; Wed, 09 Aug 2017 16:03:45 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [RFC] clang-format: outline the git project's coding style
References: <20170808012554.186051-1-bmwill@google.com> <20170809130127.ekd4tvyp2rrb7ftk@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 8.9 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20170809130127.ekd4tvyp2rrb7ftk@sigill.intra.peff.net>
Date:   Wed, 09 Aug 2017 16:03:45 +0200
Message-ID: <87y3qsg7ni.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 09 2017, Jeff King jotted:

> On Mon, Aug 07, 2017 at 06:25:54PM -0700, Brandon Williams wrote:
>
>> I'm sure this sort of thing comes up every so often on the list but back at
>> git-merge I mentioned how it would be nice to not have to worry about style
>> when reviewing patches as that is something mechanical and best left to a
>> machine (for the most part).  I saw that 'clang-format' was brought up on the
>> list once before a couple years ago
>> (https://public-inbox.org/git/20150121220903.GA10267@peff.net/) but nothing
>> really came of it.  I spent a little bit of time combing through the various
>> options and came up with this config based on the general style of our code
>> base.  The big issue though is that our code base isn't consistent so try as
>> you might you wont be able to come up with a config which matches everything we
>> do (mostly due to the inconsistencies in our code base).
>
> Right, the reason I stopped pursuing it was that I couldn't find a way
> to have it make suggestions for new code without nagging about existing
> code. If we were to aggressively reformat to match the tool for existing
> code, that would help. But I'm a bit worried that there would always be
> suggestions from the tool that we don't agree with (i.e., where the
> guiding principle is "do what is readable").
>
> I dunno. I guess "go fmt" people decided to just treat the tool's output
> as the One True Way. I haven't written enough Go to have an opinion
> myself, but it seems to at least work for them.

(I have no opinion either way on whether this clang formatting this is a
good idea or not)

> What does the tooling look like these days for just adjusting lines
> touched by a given patch?

Presumably even if it sucked we could easily write a "./git-fmt-check.sh
<file>" script to do it which would do the following:

 1. Check out the master branch
 2. Apply code formatting to entire project (or just the files you
    changed)
 3. Commit that on a throwaway branch
 4. Switch back to your WIP branch
 5. See if it would merge cleanly with the throwaway code formatting
    branch (I forget the actual 'not a real merge but check' command to
    do this, but it exists).

If there were any reported conflicts presumably the new code you're
adding is violating the coding standards laid out in this file. If not
you're good.
