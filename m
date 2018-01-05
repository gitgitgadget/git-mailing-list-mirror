Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63D1E1F406
	for <e@80x24.org>; Fri,  5 Jan 2018 11:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751105AbeAELDL (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 06:03:11 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34114 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbeAELDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 06:03:09 -0500
Received: by mail-wm0-f43.google.com with SMTP id y82so5827382wmg.1
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 03:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OS0BJ6UIU1ngOzn9g7HrFh4pFd8GQD4EL4v9fP2lDLc=;
        b=iF2ovP078QV1lSzjsKZOHhG+tNukJCfN/B5ZlXgkJinjZiQoudswyGY71MlDGqyxb2
         3uZ9pNU4G8o/pBGBQ78MJVgqZy57ovAYud34gswbDi/SfBWME0HEzQfkvmt6vl1qkx7Y
         pvRercag96p9UvCZ+V3/T0j+ky2Cf08zRMS5RW5BlDhtmAgeFZNRlS/uIf2EqTjuEosg
         UHggX8cZJnUNZ/9ffzVdwwbiCi0FTEMfFc6O7zUweBBwUayuF37EdhcnTIEOtNumET3P
         TCunB9smStwyxqxVEp1Q5ZWmMszsjaBimZSFu8RJNaL0Nt06rDiN7nSNypZFqX+JqTww
         oLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OS0BJ6UIU1ngOzn9g7HrFh4pFd8GQD4EL4v9fP2lDLc=;
        b=I/Jw49vc+8NH6hAvPut8zCH16gmkP1QRlV7XaTpbvAHm+BIvQ+f92fUx2WW6F5maAA
         sLzN67bG311fOvs+HHc60mjRsAoPc/luYb+zFY5JXSc0mF65IKwOXww7gB2Rjt4Si2v9
         f/3IGQ8RNG6PioQcHn7k58yVoTnWP2rXHSip3C9C5xHQk+Pf/DF7d6747fpnGXMdkujo
         6ZZVQs3Vsz8cjLMA6Ky644TfYz2eyLAzoko1SXUCiJQbzzWDb2UrwjhzQ9Zh/R5uZ7kU
         Tgo2tTPSjLD/Mulk8JvF/CYj0btX10QgUY04jXD/X0XHquvLffUJSrfXpypcLnFCayGl
         FhIw==
X-Gm-Message-State: AKGB3mL9fa2N9d8PRB1XqWbOljxTa3C+9s7gBnytIF9ScFQVhKKkSvI4
        Rn+Pg78EzzVM2ZvT6BmFqDU=
X-Google-Smtp-Source: ACJfBouSI7o0RlVVmRSioUrN1mkx0lnXBqeaKl5IKa+FRKmy5LSOOU/ZCEolJoAe+nx4e+XeAg0dxA==
X-Received: by 10.28.106.26 with SMTP id f26mr1849403wmc.40.1515150188633;
        Fri, 05 Jan 2018 03:03:08 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 34sm5985249wry.34.2018.01.05.03.03.07
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Jan 2018 03:03:07 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 3/3] travis: run tests with GIT_TEST_SPLIT_INDEX
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180104201312.GD2641@hank>
Date:   Fri, 5 Jan 2018 12:03:06 +0100
Cc:     Git List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>,
        =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <65BD918A-DDE4-4940-84BE-ED28006BBE07@gmail.com>
References: <20171210212202.28231-1-t.gummerer@gmail.com> <20171217225122.28941-1-t.gummerer@gmail.com> <20171217225122.28941-4-t.gummerer@gmail.com> <CA6C93AD-B24D-43A2-8AAA-DE98A4C9E719@gmail.com> <20180104201312.GD2641@hank>
To:     Thomas Gummerer <t.gummerer@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 04 Jan 2018, at 21:13, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> 
> On 12/18, Lars Schneider wrote:
>> 
>>> On 17 Dec 2017, at 23:51, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>>> 
>>> Split index mode only has a few dedicated tests, but as the index is
>>> involved in nearly every git operation, this doesn't quite cover all the
>>> ways repositories with split index can break.  To use split index mode
>>> throughout the test suite a GIT_TEST_SPLIT_INDEX environment variable
>>> can be set, which makes git split the index at random and thus
>>> excercises the functionality much more thoroughly.
>>> 
>>> As this is not turned on by default, it is not executed nearly as often
>>> as the test suite is run, so occationally breakages slip through.  Try
>>> to counteract that by running the test suite with GIT_TEST_SPLIT_INDEX
>>> mode turned on on travis.
>>> 
>>> To avoid using too many cycles on travis only run split index mode in
>>> the linux-gcc and the linux 32-bit gcc targets.
>> 
>> I am surprised to see the split index mode test for the linux 32-bit
>> target. Is it likely that a split index bug appears only on 32-bit? 
>> Wouldn't the linux-gcc target be sufficient to save resources/time?
> 
> I'm not sure it's particularly likely for a bug to appear only on
> 32-bit builds.  It also doesn't seem to take too long to run, so I
> thought I'd add it just in case, but I'm happy running the tests only
> in the 64-bit builds if that's preferred.

CI running times naturally add up over time as more and more stuff is
tested. That's why I would argue testing GIT_TEST_SPLIT_INDEX on 64-bit
is probably sufficient. However, I am not really familiar with 
GIT_TEST_SPLIT_INDEX. 

There is no right or wrong here and either way is fine with me. 
I just wanted to express my "keep an eye on CI time" concern.


Thanks,
Lars
