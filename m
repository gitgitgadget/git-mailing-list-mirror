Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F1241F803
	for <e@80x24.org>; Thu, 10 Jan 2019 07:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfAJHLb (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 02:11:31 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:18465 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfAJHLb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 02:11:31 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 43ZxxX6p06z5tlD;
        Thu, 10 Jan 2019 08:11:28 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 2F05F20C3;
        Thu, 10 Jan 2019 08:11:28 +0100 (CET)
Subject: Re: [PATCH v3 1/3] t5323: test cases for git-pack-redundant
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Sun Chao <sunchao9@huawei.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
References: <20181219121451.21697-1-worldhello.net@gmail.com>
 <20190102043456.15652-2-worldhello.net@gmail.com>
 <20190109125628.GG4673@szeder.dev>
 <CANYiYbGqLHr-t+f6m6gyY3QiYgxbzbqsmmRw-afKe6NG_mxhPQ@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <74412c28-936a-5276-d6ca-db7d8c5c2124@kdbg.org>
Date:   Thu, 10 Jan 2019 08:11:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CANYiYbGqLHr-t+f6m6gyY3QiYgxbzbqsmmRw-afKe6NG_mxhPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.01.19 um 04:28 schrieb Jiang Xin:
> SZEDER Gábor <szeder.dev@gmail.com> 于2019年1月9日周三 下午8:56写道：
>> Use something like
>>
>>    find .git/objects -type f | grep -v pack >out &&
>>    test_must_be_empty out
>>
>> instead, so we get an informative error message on failure.
> 
> if `grep -v pack` return empty output, it will return error, so
> I will use `sed -e "/objects\/pack\//d" >out` instead.

So, you could even write this as

	find .git/objects -type f >out &&
	! grep -v pack out	# must be empty
or
	! find .git/objects -type f | grep -v pack

if you want to be terse.

-- Hannes
