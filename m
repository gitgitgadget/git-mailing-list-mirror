Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D52B31F859
	for <e@80x24.org>; Tue, 30 Aug 2016 11:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758301AbcH3Lr0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 07:47:26 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37334 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757884AbcH3LrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 07:47:25 -0400
Received: by mail-wm0-f41.google.com with SMTP id i5so31262719wmg.0
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 04:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wx+aLGJ9cqhyg1C5pbjNu5ZnhdQEqsniDjq6gzyZoPs=;
        b=KLSHA8BAA+PC89Xdb1MFDPr4I/Wba+hv5L7QNnjJe02mv2VceqzBReqKYP4Z15uEWP
         yYk2JWNIITazyUuYjI9obGKmN04hSkq3qdHzT8auehawJV9LDOHPTyyNbC8SRKwoOO1o
         9oE4Xvd9CVgvj51w20QlhaNtBnC7U/sBL+rny5IhRhOsSnfYX98z+Jm231F0vsGlvURH
         AfRA6GnUiXqGwrL1hhPAMyATmkBzke/DFmQN0uh931oPpxmfrLHWl1//lWI/T2aqViKw
         nBxtZxUl5ARoLmjexRs1X9f5z4zaOAIN5AU3xRyvNcfe7kuLpRoiuiTlWQyyvcQO+dLm
         2L5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wx+aLGJ9cqhyg1C5pbjNu5ZnhdQEqsniDjq6gzyZoPs=;
        b=dMQ+eLnm1cyDeMA52oL/0pL+xJdajzs0KbXCLA/eMdSeBzQMitApbNbS7LzEnpJPYh
         imYqR88PLmHlYCbCgtUYHsl0vz85ZdzQPk0EI+mkszclTmmZUCLnrdjel8m6Bkfh/9wB
         /7sTNP6cs1ElIN2R0qPMRSBmqDNUlcL7p8i4zz0DZbyPlCXH1sRYb5LYEjKUAwgV3n5I
         hSZE/tTVK/B7xIhUoFtCcRxaRrG4bIALvJOy4GU84olO9GzbDA0LYcFs5UUVS9V5788s
         +v05Pj6PkvXeKZFfnwKqoL9iEQOjvy/nq30deZ4EjuLCTeUfWdJXxH44IKCn0bmFmTud
         qm6w==
X-Gm-Message-State: AE9vXwPj9eRCXaz+ROF2cZhcGFbQf6WgLwNy/wpnG3O7QSPM1dAvLqmjN6RkoRst4yGirQ==
X-Received: by 10.28.148.148 with SMTP id w142mr15982648wmd.48.1472557644257;
        Tue, 30 Aug 2016 04:47:24 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id e5sm18302689wma.13.2016.08.30.04.47.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Aug 2016 04:47:23 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v6 10/13] convert: generate large test files only once
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqq37lncvj6.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 30 Aug 2016 13:47:23 +0200
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <49AB8322-E322-486E-AF36-2C46BC55C82A@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com> <20160825110752.31581-11-larsxschneider@gmail.com> <CAGZ79kZ5utc+0iXKPh=tu4rD9H6+AKZmc08_jLxQhgiuFUA+Yw@mail.gmail.com> <E574E25A-F87F-416C-88E5-E3CE1F6B54D0@gmail.com> <xmqq37lncvj6.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 29 Aug 2016, at 19:52, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>>> On 25 Aug 2016, at 21:17, Stefan Beller <sbeller@google.com> wrote:
>>>=20
>>>> On Thu, Aug 25, 2016 at 4:07 AM,  <larsxschneider@gmail.com> wrote:
>>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>>=20
>>>> Generate more interesting large test files
>>>=20
>>> How are the large test files more interesting?
>>> (interesting in the notion of covering more potential bugs?
>>> easier to debug? better to maintain, or just a pleasant read?)
>>=20
>> The old large test file was 1MB of zeros and 1 byte with a one, =
repeated 2048 times.
>>=20
>> Since the filter uses 64k packets we would test a large number of =
equally looking packets.
>>=20
>> That's why I thought the pseudo random content is more interesting.
>=20
> I guess my real question is why it is not just a single invocation
> of test-genrandom that gives you the whole test file; if you are
> using 20MB, the simplest would be to grab 20MB out of test-genrandom.
> With that hopefully you won't see large number of equally looking
> packets, no?

True, but applying rot13 (via tr ...) on 20+ MB takes quite a bit of
time. That's why I came up with the 1M SP in between.

However, I realized that testing a large amount of data is not really
necessary for the final series. A single packet is 64k. A 500k pseudo =
random
test file should be sufficient. This will make the test way simpler.

Thanks,
Lars=
