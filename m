Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A06C433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 10:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C667B613B8
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 10:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343553AbhDMKnm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 06:43:42 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:33600 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhDMKnl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 06:43:41 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4FKMdd1GJwz1s1Vn;
        Tue, 13 Apr 2021 12:43:17 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4FKMdd0PRGz1sP6P;
        Tue, 13 Apr 2021 12:43:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id kO0eirmukvbv; Tue, 13 Apr 2021 12:43:16 +0200 (CEST)
X-Auth-Info: 396uocte/IownJ4rtA1ItDd5//oTwmGERmPgoiNwTeLiyGaCyS5LVgu1i2QfEIZl
Received: from igel.home (ppp-46-244-161-206.dynamic.mnet-online.de [46.244.161.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 13 Apr 2021 12:43:16 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 8FB552C36B4; Tue, 13 Apr 2021 12:43:15 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 5/8] list-objects: implement object type filter
References: <cover.1617967252.git.ps@pks.im> <cover.1618234575.git.ps@pks.im>
        <d22a5fd37dd793c78b1ac17244601cadd1f7c0c9.1618234575.git.ps@pks.im>
        <877dl6eccv.fsf@evledraar.gmail.com>
X-Yow:  MMM-MM!!  So THIS is BIO-NEBULATION!
Date:   Tue, 13 Apr 2021 12:43:15 +0200
In-Reply-To: <877dl6eccv.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 13 Apr 2021 11:57:04 +0200")
Message-ID: <87im4qh3cs.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Apr 13 2021, Ævar Arnfjörð Bjarmason wrote:

> On Mon, Apr 12 2021, Patrick Steinhardt wrote:
>> +test_expect_success 'verify object:type=blob prints blob and commit' '
>> +	(
>> +		git -C object-type rev-parse HEAD &&
>> +		printf "%s blob\n" $(git -C object-type rev-parse HEAD:blob)
>> +	) >expected &&
>
> Just use > and >> or a single printf with two arguments instead of a
> subshell?

You can also use just { } for grouping.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
