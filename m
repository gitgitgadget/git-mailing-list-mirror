Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8A981F935
	for <e@80x24.org>; Wed, 21 Sep 2016 20:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933844AbcIUU67 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 16:58:59 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:47288 "EHLO bsmtp4.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933416AbcIUU66 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 16:58:58 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp4.bon.at (Postfix) with ESMTPSA id 3sfX6S0BYPz5tlD;
        Wed, 21 Sep 2016 22:58:55 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 9AA995306;
        Wed, 21 Sep 2016 22:58:55 +0200 (CEST)
Subject: Re: [PATCH tg/add-chmod+x-fix 2/2] t3700-add: protect one --chmod=+x
 test with POSIXPERM
To:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
References: <cee3c784-8f03-c524-2f67-d35cb3755a41@kdbg.org>
 <5effaf36-d017-3ff1-1de1-d9b303c04f23@kdbg.org> <20160920193444.GG8254@hank>
 <xmqqtwd986ml.fsf@gitster.mtv.corp.google.com>
 <xmqqa8f16kup.fsf@gitster.mtv.corp.google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <c3aefd9d-b794-21a1-619e-bce6a3c2cf47@kdbg.org>
Date:   Wed, 21 Sep 2016 22:58:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqa8f16kup.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.09.2016 um 22:47 schrieb Junio C Hamano:
> -test_expect_success 'file status is changed after git add --chmod=+x' '
> -	echo "AM foo4" >expected &&
> +test_expect_success 'git add --chmod=[+-]x changes index with newly added file' '
>  	echo foo >foo4 &&
>  	git add foo4 &&
>  	git add --chmod=+x foo4 &&
> -	git status -s foo4 >actual &&
> -	test_cmp expected actual
> +	test_mode_in_index 100755 foo4
>  '

No, that's redundant. There are plenty of other test cases that check 
for this. You could just remove the case.

But I came to a different conclusion as I said in a message that crossed 
yours. I hope Thomas can pick up the baton again.

-- Hannes

