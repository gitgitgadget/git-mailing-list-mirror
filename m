Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB5AD1F404
	for <e@80x24.org>; Wed, 12 Sep 2018 20:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeIMByX (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 21:54:23 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:58413 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbeIMByX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 21:54:23 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 429Yl933lRz5tlR;
        Wed, 12 Sep 2018 22:48:05 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id D47AD414A;
        Wed, 12 Sep 2018 22:48:04 +0200 (CEST)
Subject: Re: [Question] Signature calculation ignoring parts of binary files
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
References: <003901d44acd$12c2bb90$384832b0$@nexbridge.com>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <4102803b-d5de-5812-4cef-569c9869fed1@kdbg.org>
Date:   Wed, 12 Sep 2018 22:48:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <003901d44acd$12c2bb90$384832b0$@nexbridge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.09.18 um 21:16 schrieb Randall S. Becker:
> I feel really bad asking this, and I should know the answer, and yet.
> 
> I have a binary file that needs to go into a repo intact (unchanged). I also
> have a program that interprets the contents, like a textconv, that can
> output the relevant portions of the file in whatever format I like - used
> for diff typically, dumps in 1K chunks by file section. What I'm looking for
> is to have the SHA1 signature calculated with just the relevant portions of
> the file so that two actually different files will be considered the same by
> git during a commit or status. In real terms, I'm trying to ignore the
> Creator metadata of a JPG because it is mutable and irrelevant to my repo
> contents.
> 
> I'm sorry to ask, but I thought this was in .gitattributes but I can't
> confirm the SHA1 behaviour.

You are looking for a clean filter. See the 'filter' attribute in 
gitattributes(5). Your clean filter program or script should strip the 
unwanted metadata or set it to a constant known-good value.

(You shouldn't need a smudge filter.)

-- Hannes
