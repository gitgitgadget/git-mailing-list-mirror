Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE2231F404
	for <e@80x24.org>; Thu, 30 Aug 2018 21:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbeHaBMC (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 21:12:02 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35572 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbeHaBMC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 21:12:02 -0400
Received: by mail-ed1-f67.google.com with SMTP id y20-v6so7567718edq.2
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 14:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=dpR5/SVfLywSJWl7M0zaj2X+64fJuMte/R6WOjKZI80=;
        b=bWimFEmRW30io+hUBJWlfLXK2omAM0SPH/F6Iq9ah86F+lFgQWG6eWkO2R4UH8oy8/
         gTUdQgE6H0m/JwTF1EA5n36A2De2ld3F8uwq9h2U10lgm16ZTxC42/L7ZsYobrmN3Y6h
         csVnuZTJeNC/YuUccf9pBYS7JAsgEZuw+a6n25GKWZSkxx+135qqElB/xjRPTv5iAO3Z
         Rotd1QNEulC24teAJyXBnZjNbPXkjgHFclmUdZFnskTat5aax3jURnb7pQwqsodm2HEl
         P7UwMrMoVKzxwpn+zTvDBBHqf1pNvI2n+iGkH6k31HY1/mfd7tRHMwiVlNib1XPTmZcW
         0YAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=dpR5/SVfLywSJWl7M0zaj2X+64fJuMte/R6WOjKZI80=;
        b=UsSJJa3/K89eICPd+9riquHX2dBENsH6526kIAj0eaUNG+b0lBclGBhWn+hQVfTsRj
         KPRYBxRX8Q1TOoB+wclE+KmAQPV6guEIMzQ8fah/kBa516VaZWziKbwyeFolpz8EDoyp
         mJV7gmaOv3eox5NEFkgUmK4Z4F0K+ypo19djhFO7eTvsgXNDdhDW/j86eaaUUjLh9dgY
         Okre//OK+EMe9IVnUgaKkeVBiGoSSgbT+IK8jAHh5Ym4AY1nnDYqs7OnOjHxEX6yKQbZ
         tMMsvRIa/Fe2DIwLVg3uJVdGlUXMZADCSMInktvPwyGoKHvJI6MBCEtbaYfDpwQSaWkE
         XyDA==
X-Gm-Message-State: APzg51B6YGTCS3SqDrPG5Koyv91D6bfQDxJJZvOuzEhhH2lM28PMZ7VC
        KBnst6UEnpHMl1JX/yo+USAVjbU5ldI=
X-Google-Smtp-Source: ANB0VdY8DTIV6D7puWqh/IZI6r9XCTN1qztzFGLpGnKW55ujRbDe97GEOSLiwARZr7amBTuk/f8spg==
X-Received: by 2002:a50:8c45:: with SMTP id p63-v6mr14946147edp.84.1535663277802;
        Thu, 30 Aug 2018 14:07:57 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id h8-v6sm3213128edi.68.2018.08.30.14.07.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 14:07:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH v2 4/4] branch: make "-l" a synonym for "--list"
References: <20180622092327.GA8361@sigill.intra.peff.net> <20180622092459.GD13573@sigill.intra.peff.net> <87wos8cjt8.fsf@evledraar.gmail.com> <xmqq4lfb667c.fsf@gitster-ct.c.googlers.com> <87in3rd422.fsf@evledraar.gmail.com> <20180830200452.GB22407@sigill.intra.peff.net> <xmqqo9dj4mym.fsf@gitster-ct.c.googlers.com> <20180830205033.GA27399@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180830205033.GA27399@sigill.intra.peff.net>
Date:   Thu, 30 Aug 2018 23:07:56 +0200
Message-ID: <87h8jbd0lv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 30 2018, Jeff King wrote:

> On Thu, Aug 30, 2018 at 01:29:53PM -0700, Junio C Hamano wrote:
>
>> >> > I do not know if the documentation that is shipped in 2.20 should
>> >> > talk about how the old world looked like, though.  `-l` was a short
>> >> > for `--create-reflog` is worth saying, but I do not see much value
>> >> > in talking about the warning given in 2.19.
>> >>
>> >> I'm anticipating that there will be users in the wild with similar -l
>> >> invocations, noting this helps them, because they'll be wondering what
>> >> some script that does "git branch -l <name>" is trying to do while
>> >> reading our docs.
>> >
>> > I don't have a strong opinion either way. If we do mention it, it should
>> > probably be short ("Until Git v2.20, the `-l` option was a synonym for
>> > `--create-reflog").
>>
>> I agree that the short one would of course be good.  I am on the
>> fence about mentioning the warning only given in 2.19.
>
> Yeah, I was confused about that part of the thread. Is there something
> proposed to (additionally) go into v2.19? Ævar, can you elaborate?

The patch I proposed was badly worded and on reflection I don't think
it's useful to include this, but FWIW what I meant was:

 * 1. <2.19: -l is --create-reflog
 * 2. =2.19: -l is --create-reflog, but will spew a warning to stderr about futre deprecation
 * 3. >2.19: -l is --list

I.e. should we in >2.19 docs say that -l used to mean something
different <= 2.19? Yeah, but it's probably worthless information to say
that it used to warn in that one release, since the actionable thing to
do with this information is to change it to --create-reflog, and unlike
going from >2.19 to <2.19 running =2.19 isn't silently going to treat
the -l option in a way you might not expect.
