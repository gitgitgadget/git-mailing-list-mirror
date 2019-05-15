Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 789F21F4BC
	for <e@80x24.org>; Wed, 15 May 2019 05:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbfEOF50 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 01:57:26 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:62100 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbfEOF50 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 01:57:26 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 453kNN17xlz5tlJ;
        Wed, 15 May 2019 07:57:23 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id DADD820BA;
        Wed, 15 May 2019 07:57:22 +0200 (CEST)
Subject: Re: [PATCH v3] userdiff.c & doc/gitattributes.txt: add Octave
To:     Boxuan Li <liboxuan@connect.hku.hk>
Cc:     git@vger.kernel.org, avarab@gmail.com, philipoakley@iee.org
References: <CALM0=-mTLakSBW67vqHNX84p=uw990QDbpeUfh1HKq9N0CiiLA@mail.gmail.com>
 <20190511041331.51642-1-liboxuan@connect.hku.hk>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <aa86f483-9c73-eb6d-1a73-80fd4894c093@kdbg.org>
Date:   Wed, 15 May 2019 07:57:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190511041331.51642-1-liboxuan@connect.hku.hk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.05.19 um 06:13 schrieb Boxuan Li:
> Octave pattern is almost the same as matlab. Besides,
> octave also uses '%%%' or '##' to begin code sections.
> 

> @@ -60,6 +60,11 @@ PATTERNS("java",
>  PATTERNS("matlab",
>  	 "^[[:space:]]*((classdef|function)[[:space:]].*)$|^%%[[:space:]].*$",
>  	 "[a-zA-Z_][a-zA-Z0-9_]*|[-+0-9.e]+|[=~<>]=|\\.[*/\\^']|\\|\\||&&"),
> +PATTERNS("octave",
> +	 /* Mostly the same as matlab. In addition, Octave
> +	  * supports '##' and '%%%' for code sections */
> +	 "^[[:space:]]*((classdef|function)[[:space:]].*)$|^(%%%?|##)[[:space:]].*$",
> +	 "[a-zA-Z_][a-zA-Z0-9_]*|[-+0-9.e]+|[=~<>]=|\\.[*/\\^']|\\|\\||&&"),
>  PATTERNS("objc",
>  	 /* Negate C statements that can look like functions */
>  	 "!^[ \t]*(do|for|if|else|return|switch|while)\n"
> 

In Matlab, are %%% and ## valid syntax? If not, instead of introducing a
new language, please just extend the Matlab rule to treat %%% and ## as
you need for Octave and mark your Octave files as Matlab.

-- Hannes
