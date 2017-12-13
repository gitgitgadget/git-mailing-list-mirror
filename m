Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E7C91F419
	for <e@80x24.org>; Wed, 13 Dec 2017 17:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753628AbdLMRq7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 12:46:59 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42382 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753311AbdLMRq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 12:46:58 -0500
Received: by mail-wr0-f193.google.com with SMTP id s66so2824465wrc.9
        for <git@vger.kernel.org>; Wed, 13 Dec 2017 09:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8+CBqLE7HU73nIGAA34vjBNt4yW3Yechy0b/zmeAMo0=;
        b=CkNwOW1sLmxxk1PNKb+cWM0bvh9AR9wpT/KgQAS1j0t7FIYtL94OaHHB4Tj9mZpbsm
         axPOfy2xP4bs2cNyCqC7RHCDD8jnvIYA/nW17r2DWzWA85VaO2dljwTZK0gqC0Bpd+1v
         CzdfPQe6oS6smikcH6TMZz6I7g17h0feqwj9lq8cLojrZVcM8bL1R7d/gi8AwL0vjvZq
         kGF2vp5O8Mlg7l8BGuq7DDYbO23m7l9Wk1TlB/gfU083h6K9lojG8zRrZDP9ogIPO/WQ
         HqgOnDTTKjAq+0y4vz6uPHb/afiJ8H52Lqm8t7CJnIDEZjpgTgXvU0MZP+A7uzer2rkQ
         qRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8+CBqLE7HU73nIGAA34vjBNt4yW3Yechy0b/zmeAMo0=;
        b=chK4DDoPhSUV5TfgNFEXfhcFWlLbp14ipE5XUPB/iSsG1SugwVgnhOaRUrvSiU30AU
         /uM5gah8dM0X69FRnceyB+Ol+NNN+tLqBQePVW9fxxRxllqS+CcYTGooesDjav9n8EmS
         bsDrsl3185Oh8XTaQG/H6L83JB7H1LgWmHEaoyvlXy8CQDhTCICOuClL6rf2AczaUFtz
         UZhCJkgeZfwuWdZg9mwI4wj24GIRRjUHLH/vnH04R1svYCfU8S0AAduuOusf37K3XRNA
         vIBPeeFlbG632vXaycxzTnsbSVLMMwmSLZ1Yb5k6Y/KbsESgUWdBP5tzr4QvGABczyYz
         Idyw==
X-Gm-Message-State: AKGB3mIkCceIfjCBL2wErfBkvsdE0diHXjv/A6qvkRtkSEp/Hp++CIQ+
        uF/7eaXHelipeEKR1DNhyto=
X-Google-Smtp-Source: ACJfBosOfmpPKZfVM64R1Rau6JcBwHeFBVShwCMS7QLcjKkWeFm3GuKeniT27A0XtHxblGaAgQmrfA==
X-Received: by 10.223.186.67 with SMTP id t3mr2906270wrg.276.1513187217346;
        Wed, 13 Dec 2017 09:46:57 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id h10sm847507wrf.47.2017.12.13.09.46.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Dec 2017 09:46:56 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 3/3] travis: run tests with GIT_TEST_SPLIT_INDEX
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq4louy1d9.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 13 Dec 2017 18:46:55 +0100
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <8BB646FF-A95A-434D-95E2-FC143B847AE0@gmail.com>
References: <20171210212202.28231-4-t.gummerer@gmail.com> <20171211210948.6867-1-szeder.dev@gmail.com> <20171211214255.GA24597@hank> <C5F93DFF-D3DF-4507-8546-941BFA768705@gmail.com> <xmqq609b3gi3.fsf@gitster.mtv.corp.google.com> <09E575DE-ED7A-40FA-9A47-0ABB61452C28@gmail.com> <xmqq4louy1d9.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 13 Dec 2017, at 18:38, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>> I think your solution points into the right direction.
>> Right now we have the following test matrix:
>> 
>> 1. Linux - clang
>> 2. Linux - gcc
>> 3. Mac - clang
>> 4. Mac - gcc
>> 5. Linux - gcc - GET_TEXT_POISION
>> 6. Linux - gcc - 32bit
>> 7. Windows
>> 
>> AFAIK your solution would run the split index test for 
>> 1, 2, 3, and 4. I think that is too much.
> 
> Not that it matters too much, but I meant to add it to 1. and
> 6. when I said "only one of 64-bit build plus 32-bit one".  

Ah. Sorry, I didn't get that.


>> 1 runs the fastest and I would like to keep it that way
>> to get a quick "general" result. I think only 2 should be
>> extended in the way you are suggesting. We could run
>> the tests with different env variables there. What else
>> do we have besides GIT_TEST_SPLIT_INDEX?
>> 
>> Would that work for everyone?
> 
> I am OK to make 2. use split-index (which unfortunately would mean
> we lose tests without split-index under gcc), or add 2.5 that is a
> copy of 2. plus split-index.


I think I experessed myself poorly. As far as I understand it,
GIT_TEST_SPLIT_INDEX is an environment variable that only needs
to be set at test time and not at compile time. Is this right?

If yes, my idea for 2. is as follows:
- build Git with gcc
- run tests with "make --quiet test"
- run tests with "GIT_TEST_SPLIT_INDEX=YesPlease make --quiet test"

This should be quicker than a new 2.5 target because we don't need to
spin up the machine and build Git. Plus, we could run the tests
a few more times with other test flags.

- Lars
