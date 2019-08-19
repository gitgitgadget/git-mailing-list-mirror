Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52B431F461
	for <e@80x24.org>; Mon, 19 Aug 2019 21:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfHSVfm (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 17:35:42 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:41739 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728018AbfHSVfl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 17:35:41 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 46C6fg3pMNz5tlC;
        Mon, 19 Aug 2019 23:35:39 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 0E4B62B7;
        Mon, 19 Aug 2019 23:35:39 +0200 (CEST)
Subject: Re: [PATCH v2] userdiff: Add a builtin pattern for dts files
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     git@vger.kernel.org, Adrian Johnson <ajohnson@redneon.com>,
        William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        devicetree@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <20190816225658.8946-1-sboyd@kernel.org>
 <98f9cdc2-fa9b-b639-b906-44b17f0efd76@kdbg.org>
 <20190819204451.522D422CEB@mail.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <806dbf7a-0488-6dde-70b9-a62cc5dca23e@kdbg.org>
Date:   Mon, 19 Aug 2019 23:35:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819204451.522D422CEB@mail.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.08.19 um 22:44 schrieb Stephen Boyd:
> Quoting Johannes Sixt (2019-08-19 11:40:47)
>> Am 17.08.19 um 00:56 schrieb Stephen Boyd:
>>> diff --git a/t/t4018/dts-labels b/t/t4018/dts-labels
>>> new file mode 100644
>>> index 000000000000..27cd4921cfb6
>>> --- /dev/null
>>> +++ b/t/t4018/dts-labels
>>> @@ -0,0 +1,8 @@
>>> +/ {
>>> +     label_1: node1@ff00 {
>>> +             label2: RIGHT {
>>> +                     vendor,some-property;
>>> +                     ChangeMe = <0x45-30>;
>>
>> In these tests, it would be worthwhile to leave another (possibly blank)
>> line before the ChangeMe line in order to demonstrate that lines
>> beginning with a word, such as the 'vendor,some-property;' line, are
>> _not_ picked up when they are not in the hunk context.
> 
> Sure. I can add a blank line. Did you want it on all the tests or just
> some of them?

Some of them. We should have cases that show that
"vendor,some-property;" and "prop-erty = value;" are not picked up.

-- Hannes
