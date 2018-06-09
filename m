Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4AD11F403
	for <e@80x24.org>; Sat,  9 Jun 2018 09:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbeFIJ43 (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 05:56:29 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34458 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbeFIJ42 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 05:56:28 -0400
Received: by mail-wm0-f68.google.com with SMTP id l15-v6so5028982wmc.1
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 02:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=F/8+NrumZGS+MhkIuUdaQnGdYuSch9LSyvMT7XkrTXc=;
        b=CDXUKwAIzBHwrpir1/uLs2dJAzsa9ar3+vaDZ1YOwIJuA3hUk1u7B4irmspWGyyk6o
         0wI2KyWBAYWJ3NOfPKd0WobwHYWq+mcUI/9XDuqDF8YmviOcP36HMuPxzVxwo8EKq0Vp
         jMlpoFf1Quwao0Q2lzCIfOqKaPkonKLqIHsfMUCAMbo9nvkG7FRJsNiL8v7DMVMzFmvO
         dOj64jiVAZ9238R+JLI3bLKmbSVJ/nGIfOyxuyScrbnShpa0jGAfnkGtAmc379Fk2da1
         JPMTGY4HWLSkIHsvT10itOTIxL2/kNjc2SQ7okZR1CVyeUegKLunDnGDzCAKlgOIx/li
         feaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=F/8+NrumZGS+MhkIuUdaQnGdYuSch9LSyvMT7XkrTXc=;
        b=toACCqiPXAHnr7OZEmGezp+pCKNBPkJ/2ybkvRKQRpVr1IrEgnItPMiaJRY5oqUuxy
         rX8WDDGME+MDc53gaYX6L4WFZKsYV625mabSZTqtXv4EdRJx62mvSH5lQRVHx64tyMES
         E1+auspcRldi2ASgElrlolrKopNkU8XuZq6BDpTZdJsHUzfHi8Z55bUSMmPQnnl2zYk5
         8U0CwKhAmOF1V/zARhh+p6W1Jvn8YxzfHDuOOcqP1s4cgPGj81AT2NoW1DNKSfgFufRF
         furHz4CudYBREAWRQHVluac3+RsPrGSwX6sR6Rj1heu7nhFicxGzjIZjxlbmxRs+aajY
         h+tA==
X-Gm-Message-State: APt69E0dpEk6KWTy3ZqVdwnruw3Bo2gFc2DQMkVQyoQHmJwxNlID+QGA
        dTm7arisESQ064OJnvCsPqZdeeHg
X-Google-Smtp-Source: ADUXVKJwobqLC1aInc8EETYIzpayrnp8MNiH3VU15VcRPu3DZWzwswrcv+6Zs+0ERBlOWsn/aR1NaA==
X-Received: by 2002:a50:ad07:: with SMTP id y7-v6mr11130154edc.78.1528538187261;
        Sat, 09 Jun 2018 02:56:27 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id c13-v6sm10938479edr.78.2018.06.09.02.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Jun 2018 02:56:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 09/20] abbrev tests: test for "git-log" behavior
References: <20180608224136.20220-1-avarab@gmail.com> <20180608224136.20220-10-avarab@gmail.com> <CAN0heSoaNotgsvbLv03tqRxC75rXzS6LvvnYBrS=f6pk-Y_x3Q@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAN0heSoaNotgsvbLv03tqRxC75rXzS6LvvnYBrS=f6pk-Y_x3Q@mail.gmail.com>
Date:   Sat, 09 Jun 2018 11:56:25 +0200
Message-ID: <87a7s4471y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jun 09 2018, Martin Ågren wrote:

> On 9 June 2018 at 00:41, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>> The "log" family of commands does its own parsing for --abbrev in
>> revision.c, so having dedicated tests for it makes sense.
>
>> +for i in $(test_seq 4 40)
>
> I've just been skimming so might have missed something, but I see
> several instances of this construct, and I wonder what this brute-force
> approach really buys us. An alternative would be, e.g., "for i in 4 23
> 40". That is, min/max and some arbitrary number in between (odd because
> the others are even).
>
> Of course, we might have a bug which magically happens for the number 9,
> but I'd expect us to test for that only if we have some reason to
> believe that number 9 is indeed magical.

Good point, I'll change this in v2, or at least guard it with
EXPENSIVE. I hacked it up like this while exhaustively testing things
during development, and discovered some edge cases (e.g. "0" is special
sometimes).

> Also, 40 is of course tied to SHA-1. You could perhaps define a variable
> at the top of this file to simplify a future generalization. (Same for
> 39/41 which are related to 40.)

I forgot to note this in the commit message, but I intentionally didn't
guard this test with the SHA1 prereq, there's nothing per-se specific to
SHA-1 here, it's not a given that whatever our NewHash is that we won't
use 40 characters, and the rest of the magic constants like 4 and 7 is
something we're likely to retain with NewHash.

Although maybe we should expose GIT_SHA1_HEXSZ to the test suite.
