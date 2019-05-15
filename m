Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D7151F461
	for <e@80x24.org>; Wed, 15 May 2019 17:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfEORqW (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 13:46:22 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:50433 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfEORqW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 13:46:22 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45426M3GsHz5tlC;
        Wed, 15 May 2019 19:46:19 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id D6BDF496D;
        Wed, 15 May 2019 19:46:18 +0200 (CEST)
Subject: Re: [PATCH v3] userdiff.c & doc/gitattributes.txt: add Octave
To:     "LI, BO XUAN" <liboxuan@connect.hku.hk>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        philipoakley@iee.org
References: <CALM0=-mTLakSBW67vqHNX84p=uw990QDbpeUfh1HKq9N0CiiLA@mail.gmail.com>
 <20190511041331.51642-1-liboxuan@connect.hku.hk>
 <aa86f483-9c73-eb6d-1a73-80fd4894c093@kdbg.org>
 <CALM0=-n_=8K4RWE9MvwPFT26UwN-rAA09ryqdTfEF4GJ57YBjg@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <a2455214-9ce5-71e3-74bc-114af6fcfca7@kdbg.org>
Date:   Wed, 15 May 2019 19:46:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CALM0=-n_=8K4RWE9MvwPFT26UwN-rAA09ryqdTfEF4GJ57YBjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.05.19 um 08:15 schrieb LI, BO XUAN:
> On Wed, May 15, 2019 at 1:57 PM Johannes Sixt <j6t@kdbg.org> wrote:
>>
>> Am 11.05.19 um 06:13 schrieb Boxuan Li:
>>> Octave pattern is almost the same as matlab. Besides,
>>> octave also uses '%%%' or '##' to begin code sections.
>>>
>>
>>> @@ -60,6 +60,11 @@ PATTERNS("java",
>>>  PATTERNS("matlab",
>>>        "^[[:space:]]*((classdef|function)[[:space:]].*)$|^%%[[:space:]].*$",
>>>        "[a-zA-Z_][a-zA-Z0-9_]*|[-+0-9.e]+|[=~<>]=|\\.[*/\\^']|\\|\\||&&"),
>>> +PATTERNS("octave",
>>> +      /* Mostly the same as matlab. In addition, Octave
>>> +       * supports '##' and '%%%' for code sections */
>>> +      "^[[:space:]]*((classdef|function)[[:space:]].*)$|^(%%%?|##)[[:space:]].*$",
>>> +      "[a-zA-Z_][a-zA-Z0-9_]*|[-+0-9.e]+|[=~<>]=|\\.[*/\\^']|\\|\\||&&"),
>>>  PATTERNS("objc",
>>>        /* Negate C statements that can look like functions */
>>>        "!^[ \t]*(do|for|if|else|return|switch|while)\n"
>>>
>>
>> In Matlab, are %%% and ## valid syntax? If not, instead of introducing a
>> new language, please just extend the Matlab rule to treat %%% and ## as
>> you need for Octave and mark your Octave files as Matlab.
> 
> '##' is not valid syntax in Matlab scripts.
> 
> '%%%' is valid syntax in Matlab. However, it is not used as a section divider.

In Matlab, is %%% followed by space at the beginning of a line
*commonly* used for something different? If I were to make a guess, I
would say no. If I'm right, it does not hurt to merge the Octave rules
into the Matlab rules.

-- Hannes
