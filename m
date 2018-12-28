Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6654D1F45B
	for <e@80x24.org>; Fri, 28 Dec 2018 08:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbeL1I7I (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 03:59:08 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:38048 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729345AbeL1I7I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 03:59:08 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 43R0xk1BD7z5tlQ;
        Fri, 28 Dec 2018 09:59:06 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 9435B2091;
        Fri, 28 Dec 2018 09:59:05 +0100 (CET)
Subject: Re: [PATCH 0/2] Improve documentation on UTF-16
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
References: <20181227021734.528629-1-sandals@crustytoothpaste.net>
 <93f0a854-9b8d-500c-b015-59c50ecdb0f3@kdbg.org>
 <20181227164353.GC423984@genre.crustytoothpaste.net>
 <435b6870-379c-7183-da99-35aec5cf1137@kdbg.org>
 <20181227234535.GD423984@genre.crustytoothpaste.net>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <34d4f912-2ec3-9dd1-f5fb-aad6a26e1464@kdbg.org>
Date:   Fri, 28 Dec 2018 09:59:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181227234535.GD423984@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.12.18 um 00:45 schrieb brian m. carlson:
> On Thu, Dec 27, 2018 at 08:55:27PM +0100, Johannes Sixt wrote:
>> But why do you add another U+FEFF on the way to UTF-8? There is one in the
>> incoming UTF-16 data, and only *that* one must be converted. If there is no
>> U+FEFF in the UTF-16 data, the should not be one in UTF-8, either.
>> Puzzled...
> 
> So for UTF-16, there must be a BOM. For UTF-16LE and UTF-16BE, there
> must not be a BOM. So if we do this:
> 
>    $ printf '\xfe\xff\x00\x0a' | iconv -f UTF-16BE -t UTF-16 | xxd -g1
>    00000000: ff fe ff fe 0a 00                                ......

What sort of braindamage is this? Fix iconv.

But as I said, I'm not an expert. I just vented my worries that 
widespread existing practice would be ignored under the excuse "you are 
the outlier".

-- Hannes
