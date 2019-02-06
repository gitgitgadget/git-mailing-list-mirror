Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3EDF1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 18:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfBFSMB (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 13:12:01 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:32376 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbfBFSMA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 13:12:00 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 43vqKB1N20z5tlG;
        Wed,  6 Feb 2019 19:11:58 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 2F7A0499E;
        Wed,  6 Feb 2019 19:11:57 +0100 (CET)
Subject: Re: [PATCH ps/stash-in-c] strbuf_vinsertf: provide the correct buffer
 size to vsnprintf
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <896ae9dd-7ac3-182e-6692-c09bc4864de0@kdbg.org>
 <xmqqd0o7tdxt.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1902051140060.41@tvgsbejvaqbjf.bet>
 <ef5f66fb-7467-93be-00fd-7900ce961f72@kdbg.org>
 <nycvar.QRO.7.76.6.1902061242380.41@tvgsbejvaqbjf.bet>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <f02e73e6-7e0e-6cd9-3d3a-b2b74d03f6be@kdbg.org>
Date:   Wed, 6 Feb 2019 19:11:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1902061242380.41@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.02.19 um 12:56 schrieb Johannes Schindelin:
> On Tue, 5 Feb 2019, Johannes Sixt wrote:
>> Am 05.02.19 um 12:06 schrieb Johannes Schindelin:
>>> The real examples are much more mundane, and very different from what you
>>> suspected, e.g. inserting the tag header before the tag message in
>>> `create_tag()` in `builtin/tag.c`. Basically, it is building up a strbuf
>>> for the sake of calling `strbuf_insert()` to insert that string elsewhere.
>>
>> I had a look, and this example does not convince me at all. If
>> separation of concerns were applied well around the launch_editor APIs,
>> you would not need strbuf_insert() in the first place. But, alas, these
>> functions focus more on DRY, and that is often the opposite of
>> separation of concerns.
> 
> So you actually are convinced that it is needed in this instance. Good.

I thought I said quite the opposite.

But never mind. Since I'm not going to help refactor any C code anyway
as long as the result is still C code, who am I to complain about the
existence of strbuf_vinsertf()?

-- Hannes
