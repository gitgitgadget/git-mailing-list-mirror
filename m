Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4669F20401
	for <e@80x24.org>; Tue, 13 Jun 2017 06:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752528AbdFMGXr (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 02:23:47 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:35489 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752387AbdFMGXo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 02:23:44 -0400
Received: by mail-it0-f54.google.com with SMTP id m62so35354484itc.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 23:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=NcmAKAj12UDXZBoyC4sK4vJ/HftcgNe9dAs5Ei83Pgo=;
        b=NauDRHw1KRDfWMpZnH9cg1QRzbepyeJuwBmbR1f2b7zYngoNn4zAA8IMW7QS4uuldQ
         3zU2/okd3Rv44bzW9oyHfLYdFCqHtFFYn82Sv5+e3bcUp0noSUmMQainSIg8zHMKobeh
         lprFPFDCGQbHfd+bwqGFULlfSsOFQWGcn3rLBRiR1o0dsOcrlHlHN3enYLXtLfVETEDC
         qtg909yQBm6CwsVbRtk+Clp8DPvKd9OfVBRb4n/19kgpzEasBvpaIKOvA5gCUY691TVK
         H8OvfhRr4hfmPSPAa8ks+hLfcAvrQcbVfqskn7PmqPgwMzeU6a5BYQolnj2DXUXeothc
         6s5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=NcmAKAj12UDXZBoyC4sK4vJ/HftcgNe9dAs5Ei83Pgo=;
        b=A/Nsek2tKv+LXcHCi3lqBPqaH/45RSMiOjKfSRAcDYZozXYV8djL9/6B1Ko2d5L5h2
         p88yRwG4Ud1BARPsPLIQ7iAWNw4gB7z2/cF4dkqtII+R4uP26OrRlyJNrBS0T18coxHp
         S8x2wXvufhUwkTLY484eFcz0nHZuCz3q8MhDs9qaYdng/bnvJN8pebfC/0VKWfex/d+U
         zO+voHmEFK94hmjt9OEpg8TUhthAZe9eBv9xwsDGmAZYk5Ml4vneL1O8bsItLnxzi/MC
         qE3rbI6yiOmjteqvVVkAKbj4pRqJ8BSxJrNrv5jxTuxh6wn6QqTU73/AsAGkZ4A3bTC9
         uPMQ==
X-Gm-Message-State: AODbwcB066xCjkEUotLd8N8AlyaCf1/i9+P4GSMqa5SBStDXD8o/fKJU
        IFaVd6qiVc6ZZS8uJERUCbgXJTZqkA==
X-Received: by 10.36.79.214 with SMTP id c205mr15084061itb.58.1497335023908;
 Mon, 12 Jun 2017 23:23:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.157.20 with HTTP; Mon, 12 Jun 2017 23:23:43 -0700 (PDT)
In-Reply-To: <20170612211022.k7t2ywngrdcrkehn@sigill.intra.peff.net>
References: <20170602225148.drkl7obwhzypgjtr@sigill.intra.peff.net>
 <a8b789e6-d0cd-6d96-1bfb-ccc5bc174013@web.de> <20170607081729.6pz5yo2hmp4fwuas@sigill.intra.peff.net>
 <662a84da-8a66-3a37-d9d2-4ff8b5f996c3@web.de> <xmqq37b5qly8.fsf@gitster.mtv.corp.google.com>
 <CACBZZX5ofJC70S09rfL_EMK2KWAoPCMun1eisi+CXeX=FSwy6Q@mail.gmail.com>
 <22846.51138.555606.729612@a1i15.kph.uni-mainz.de> <CACBZZX6AH2nEGPHMq6XOLDxr4SH9v-zT_YGovLXN_ZQ+fB345g@mail.gmail.com>
 <20170612182045.z4d37ph5uqqhwmas@sigill.intra.peff.net> <CACBZZX5OQc45fUyDVayE89rkT=+8m5S4efSXCAbCy7Upme5zLA@mail.gmail.com>
 <20170612211022.k7t2ywngrdcrkehn@sigill.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jun 2017 23:23:43 -0700
X-Google-Sender-Auth: p2uOwE1_uAiAlqTtweQ_PyRFNZQ
Message-ID: <CA+55aFz5TC5XWWEZkf=e3rJZFwvQJoFyvWSaNSTiQZM3-yiOKQ@mail.gmail.com>
Subject: Re: [PATCH] strbuf: let strbuf_addftime handle %z and %Z itself
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ulrich Mueller <ulm@gentoo.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 12, 2017 at 2:10 PM, Jeff King <peff@peff.net> wrote:
>
> I suspect nobody has complained because we generally encourage real
> "-0800" names when specifying zones.

That's what any sane person uses, and it's what SMTP requiries.

The timezone names are a (bad) joke. If a human can't understand them
(and people don't), there's no point in thinking that a computer
should either.

So yes, timezones should strive very much to be numeric. The names are
an incomprehensible mess. Don't rely on them, and try to avoid using
them.

                  Linus
