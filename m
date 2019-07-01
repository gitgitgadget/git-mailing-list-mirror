Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9A661F461
	for <e@80x24.org>; Mon,  1 Jul 2019 18:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfGASWt (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 14:22:49 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:2483 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfGASWt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 14:22:49 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45cwhk6BYRz5tl9;
        Mon,  1 Jul 2019 20:22:46 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 6BF6DF9B;
        Mon,  1 Jul 2019 20:22:46 +0200 (CEST)
Subject: Re: [PATCH] t5319: don't trip over a user name with whitespace
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.261.git.gitgitgadget@gmail.com>
 <d4a3f56b-5eaa-1325-f8c1-be6797a9ac03@kdbg.org>
 <CAPig+cRpOHRgtCXXiqAZtmEtkWnMy7=4GsTVv0XB9R3fF0-66A@mail.gmail.com>
 <1a5bb5f9-e090-7f42-ec3f-cd74bcad831f@kdbg.org>
 <20190630222537.GA21696@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1907011409420.44@tvgsbejvaqbjf.bet>
 <b1f6a752-6edd-d86c-7d69-7624a2c5407f@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <3645e8cf-3538-7a4e-a54a-f58dc39510e1@kdbg.org>
Date:   Mon, 1 Jul 2019 20:22:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <b1f6a752-6edd-d86c-7d69-7624a2c5407f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.07.19 um 14:30 schrieb Derrick Stolee:
> On 7/1/2019 8:11 AM, Johannes Schindelin wrote:
>> Or we stop introducing new Perl calls, and use the perfectly fine
>> `test-tool path-utils file-size` command:
>>
>> https://github.com/git/git/blob/v2.22.0/t/helper/test-path-utils.c#L302-L312
>>
>> This solves not only portability problems but also avoids yet another
>> obstacle into making a `NO_PERL` test suite run really work without Perl.
> Thanks! This does seem like the best option. Thanks for bringing this to our
> attention. Here is a diff, and I'll prepare a full patch:

Thanks. Please also explain why the first of the two tests does not fail
with a large --batch-size (unless it is obvious for people who know a
bit about multi-pack-index, of course).

-- Hannes
