Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26F2B20C11
	for <e@80x24.org>; Sun,  3 Dec 2017 12:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbdLCMrJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 07:47:09 -0500
Received: from mail-wr0-f182.google.com ([209.85.128.182]:34957 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbdLCMrI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 07:47:08 -0500
Received: by mail-wr0-f182.google.com with SMTP id g53so14445396wra.2
        for <git@vger.kernel.org>; Sun, 03 Dec 2017 04:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NnexJCki6rIP/1BkeC+Pqq85HW83hzYW9bweERzvp9A=;
        b=X4SV85UIz2GJlqTCmJ0Pdzf2nR4QwyrmTPADHAN++K6UQecN1eRMaE5RHgph8uYV2o
         Qwn+JBcCV7TCQA0PebsNliDPb3sOm/3zotLE104Q7doRHLUYxMQTUWmsZE6JKD8g1EfP
         Wm5ViboRSpDs8umK2fvVfSDMOAYG6oNH95ZlIg0atfvu7T0EyT4ndepuy1Zp8cxW8tBK
         FoX8ecw4QKAJ/h8RPjOS+m1VFkIgfTKe0bAH1AIhrWnawIP1M5Ot1wLTmNbXET2bnDma
         V+vdbcH1P7f4kx6BB8DQww+o36xlnXPOV0p7Y0MU/xzGaELOnyb2KvZPHMuEsoscozpz
         mhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NnexJCki6rIP/1BkeC+Pqq85HW83hzYW9bweERzvp9A=;
        b=YogFT2IoSkJ3oYDS8IqFxLHFZyl/Fu+HWOukCYaSWzyCGw+Uzpdksb/Efj+od+coPT
         qIJrIS3FdA9B+GKiS/KEvdLmXGlHH3vBDSsRyrE3LvktvGQdKZR64i/xdal6sTUHnrbI
         7p1+6PGVGwROi4FrBVBFMmjNxB6h8cQ9BtZrkR9ufOn22xde81BfrlpTglq95Zkc3TWQ
         bwrcfIcJqjdrGyjA+j8CWtgPnbQIFwbivZkEQBv04gBopadcZjEtJZO3QnQokgDtY10N
         l7TcDTJwW3lm/oHy23K9mUvFi24IK96A/nLWPcvfOFxubbBwaRRKdnOxKDvi43veNIpj
         m2/g==
X-Gm-Message-State: AJaThX6448rgbglmp/Y37HSX2o0TM4GEkvvLVSHGT2zHX5e4ic9KSlh0
        0Hmjyfb7VgsRieKhCBemt/Q=
X-Google-Smtp-Source: AGs4zMaVuIGbz3nQX/t0LKugFElHgyCN2bD+GXdsE3vmtMP3uatUMnp+sCLsarun/uU++dVRGine8Q==
X-Received: by 10.223.187.7 with SMTP id r7mr9952304wrg.253.1512305226803;
        Sun, 03 Dec 2017 04:47:06 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB6E6A.dip0.t-ipconnect.de. [93.219.110.106])
        by smtp.gmail.com with ESMTPSA id k14sm12350399wrc.90.2017.12.03.04.47.04
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 03 Dec 2017 04:47:05 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 2/2] launch_editor(): indicate that Git waits for user input
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqvahojssu.fsf@gitster.mtv.corp.google.com>
Date:   Sun, 3 Dec 2017 13:47:04 +0100
Cc:     Jeff King <peff@peff.net>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        kaartic.sivaraam@gmail.com, sandals@crustytoothpaste.net
Content-Transfer-Encoding: 7bit
Message-Id: <D3A5C7E6-A63C-431C-97B5-070632EE3540@gmail.com>
References: <20171129143752.60553-1-lars.schneider@autodesk.com> <20171129143752.60553-3-lars.schneider@autodesk.com> <20171130205137.GC3313@sigill.intra.peff.net> <xmqqvahojssu.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 03 Dec 2017, at 06:15, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Jeff King <peff@peff.net> writes:
> 
>> I tried to think of ways this "show a message and then delete it" could
>> go wrong. It should work OK with editors that just do curses-like
>> things, taking over the terminal and then restoring it at the end.
>> ...
> 
> I think that it is not worth to special-case "dumb" terminals like
> this round of the patches do.  If it so much disturbs reviewers that
> "\e[K" may not work everywhere, we can do without the "then delete
> it" part.  It was merely trying to be extra nice, and the more
> important part of the "feature" is to be noticeable, and I do think
> that not showing anything on "dumb", only because the message cannot
> be retracted, is putting the cart before the horse.  
> 
> Since especially now people are hiding this behind an advise.*
> thing, I think it is OK to show a message and waste a line, even.

Well, my reasoning was to minimize the risk of bothering people:
People using "dumb" terminals wouldn't be bothered because nothing
changes and people using "smart" terminals would see the message
only temporarily. Of course, emacsclient users would be the
exception. They would always be bothered and therefore I added
the "advice" switch.

That being said, I can also follow your logic. If we have such
a feature then we shouldn't surprise the user. We should make it 
consistently available in all environments.

I am on the fence here. I like consistency but I don't want to
bother Git users.

@Peff: Do you lean into either direction? Could you imagine that
novice/regular users are bothered? (I don't expect experts to be
bothered too much as they would likely be able to find and set 
the advice config).


Thanks,
Lars
