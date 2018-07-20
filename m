Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 326D61F597
	for <e@80x24.org>; Fri, 20 Jul 2018 14:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731679AbeGTPRg (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 11:17:36 -0400
Received: from siwi.pair.com ([209.68.5.199]:31201 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731445AbeGTPRg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 11:17:36 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id BADE23F400C;
        Fri, 20 Jul 2018 10:29:02 -0400 (EDT)
Received: from [192.168.1.6] (8.sub-174-231-162.myvzw.com [174.231.162.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 1DF243F4008;
        Fri, 20 Jul 2018 10:29:02 -0400 (EDT)
Subject: Re: Git 2.18: RUNTIME_PREFIX... is it working?
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        paul@mad-scientist.net, dnj@google.com
References: <nycvar.QRO.7.76.6.1807061059260.75@tvgsbejvaqbjf.bet>
 <CAD1RUU-4a_jV_JjozjXOR4bi+_7rFW_AjmHbbrw6NHJ77=oGkw@mail.gmail.com>
 <bf0d4f33701ec694917f2e710c3fb097085c8d69.camel@mad-scientist.net>
 <nycvar.QRO.7.76.6.1807082346140.75@tvgsbejvaqbjf.bet>
 <20180709195822.GA9000@sigill.intra.peff.net>
 <20180710035635.GA13459@sigill.intra.peff.net>
 <5b445ca6.TkV9Dj8T2KFinxZP%perryh@pluto.rain.com>
 <20180710140310.GA9246@sigill.intra.peff.net>
 <20180714205132.GH1042117@genre.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.1807181418120.71@tvgsbejvaqbjf.bet>
 <20180719222613.GA7066@genre.crustytoothpaste.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <fc1c6b0b-e7a5-cbde-d927-8c1e1c4e9f11@jeffhostetler.com>
Date:   Fri, 20 Jul 2018 10:29:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180719222613.GA7066@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/19/2018 6:26 PM, brian m. carlson wrote:
> On Wed, Jul 18, 2018 at 02:18:44PM +0200, Johannes Schindelin wrote:
>> On Sat, 14 Jul 2018, brian m. carlson wrote:
>>> I will say that at cPanel, we have a configuration where end users can
>>> end up inside a mount namespace without /proc (depending on the
>>> preferences of the administrator).  However, it's easy enough for us to
>>> simply build without RUNTIME_PREFIX if necessary.
>>>
>>> If we turn it on by default, it would be nice if we documented (maybe in
>>> the Makefile) that it requires /proc on Linux for the benefit of other
>>> people who might be in a similar situation.
>>
>> Is there *really* no other way on Linux to figure out the absolute path of
>> the current executable than to open a pseudo file in the `/proc` file
>> system?
> 
> Nope, not that I'm aware of.  You have to read the destination of
> the /proc/PID/exe symlink.
> 

Getting the full path of the current executable is a very Windows thing.
On most Unix-based systems it just isn't possible (even if Linux does
have the /proc thing).  Think about hard-links, for example.  There just
isn't a single canonical pathname for an inode.

Jeff
