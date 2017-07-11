Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E75A20357
	for <e@80x24.org>; Tue, 11 Jul 2017 05:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932192AbdGKFYL (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 01:24:11 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:9940 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932109AbdGKFYK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 01:24:10 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 3x69Vc338qz5tlC;
        Tue, 11 Jul 2017 07:24:08 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 7C26F139;
        Tue, 11 Jul 2017 07:24:07 +0200 (CEST)
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
 <c349f324-8f6d-2fe0-8982-2e37869d37b5@kdbg.org>
 <20170711000540.4tdytyiit27trmzo@genre.crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <577e31a0-ecb2-d0a0-b259-b65b31116be8@kdbg.org>
Date:   Tue, 11 Jul 2017 07:24:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170711000540.4tdytyiit27trmzo@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.07.2017 um 02:05 schrieb brian m. carlson:
> On Mon, Jul 10, 2017 at 09:57:40PM +0200, Johannes Sixt wrote:
>> It's a pity, though, that you do not suggest something even more useful,
>> such as C++14.
> 
> I have tried compiling Git with a C++ compiler, so that I could test
> whether that was a viable alternative for MSVC in case its C++ mode
> supported features its C mode did not.  Let's just say that the
> compilation aborted very quickly and I gave up after a few minutes.

It's 3 cleanup patches and one hacky patch with this size:

  80 files changed, 899 insertions(+), 807 deletions(-)

to compile with C++. It passed the test suite last time I tried. Getting 
rid of the remaining 1000+ -fpermissive warnings is a different matter, 
though.

I can revive the patches if there is interest.

-- Hannes
