Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 844FA20248
	for <e@80x24.org>; Wed,  3 Apr 2019 18:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfDCSQN (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 14:16:13 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:16263 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfDCSQN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 14:16:13 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 44ZDmB199mz5tlH;
        Wed,  3 Apr 2019 20:16:10 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 3080049FF;
        Wed,  3 Apr 2019 20:16:09 +0200 (CEST)
Subject: Re: [PATCH v2.5 2/2] tag: prevent nested tags
To:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Robert Dailey <rcdailey.lists@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <1bd9ee28bc8726490ec0a93286056beeb147fc49.1554183429.git.liu.denton@gmail.com>
 <20190402230345.GA5004@dev-l> <xmqqzhp7sfw4.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <3a7a9348-188e-e2c1-58d9-52310b96081d@kdbg.org>
Date:   Wed, 3 Apr 2019 20:16:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <xmqqzhp7sfw4.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.04.19 um 09:32 schrieb Junio C Hamano:
> Denton Liu <liu.denton@gmail.com> writes:
> 
>> This is the first use of the '%n$<fmt>' style of printf format in the
>> *.[ch] files in our codebase, but it's supported by POSIX[1] and there
>> are existing uses for it in po/*.po files, so hopefully it won't cause
> 
> The latter is a stronger indication that this should be OK than the
> former ;-)  Thanks for digging and noting.

However, there is a difference in whether %n$ is in the code or just in
the translations: When it is not in the code, Git can be made to work on
a platform that does not support it by compiling with NO_GETTEXT. When
it is in the code, that won't be possible anymore.

I don't know whether there are any platforms that do not support %n$,
though.

-- Hannes
