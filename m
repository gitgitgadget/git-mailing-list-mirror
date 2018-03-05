Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE7821F576
	for <e@80x24.org>; Mon,  5 Mar 2018 10:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752390AbeCEK7S (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 05:59:18 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:61173 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbeCEK7R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 05:59:17 -0500
Received: from [192.168.2.201] ([92.22.16.137])
        by smtp.talktalk.net with SMTP
        id snpreF8x5GrhCsnpresP5M; Mon, 05 Mar 2018 10:59:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1520247556;
        bh=TdR6uTFpFZdl7S1eKab7gOEm6RI4UT06d+5MI4aHTdg=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JmwTp70zwaDcKgh/8q73BN6V+NYh9X0DLwmWfDA2cRwJ18dUTetCWCj4ROCyyE5KY
         1rYxd4BoCk/ruMeCa2aHALUX1Do9FTju+GEsrJ2sJWzx5F+sMpDX4Cw5UJTTTadcOo
         qW5z3Kk1U+kK9Ps97TMRWtzeUsG75YoeBZnz0dqI=
X-Originating-IP: [92.22.16.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=SORsqtnH c=1 sm=1 tr=0 a=nWy375ASyxHoIYnPohIYMA==:117
 a=nWy375ASyxHoIYnPohIYMA==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=qNF6B9H7PPbY0lHX4IgA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 4/9] t3701: don't hard code sha1 hash values
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180301105103.24268-1-phillip.wood@talktalk.net>
 <20180301105103.24268-5-phillip.wood@talktalk.net>
 <20180302155528.12106-1-szeder.dev@gmail.com>
 <xmqqa7vqe9xn.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <bb6be000-7a62-7ad5-0b59-90a75fd6dca9@talktalk.net>
Date:   Mon, 5 Mar 2018 10:59:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqa7vqe9xn.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfA48x+d3tNtSz+QhqNHFIVxWkOT00+pTNrZUErCp5hZ26aowKQJlqIqQyZ944aHQHx4Iacb2lxa8SbJFFXx2TftD28tmBaksbEX+rHpYlgU/YgLGJQiy
 xMq/FcJVoOVE84N6PQuuCYe9l8yw7/dezObA94ZE3uAc/IPA3wfW34RNbiC9s18CyvZ1kB2WTUYKtFWxxHrbfCzxlRMvvRu6aq+lrzxwXUjZKKnV3AzmdA77
 a/TEd/iY0OIBTqy3SYaODKIn7tEAKOt2hrUonc19GffNYjnA8Om6wXyySBi6VI4dhHjCl5tplRqlfAw6KEt7Ld1awuaa+zow1lxcJewhv71d92+UbEmzJZEw
 7TaOYziq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/03/18 16:09, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
>>> +diff_cmp () {
>>> +	for x
>>> +	do
>>> +		sed  -e '/^index/s/[0-9a-f]*[1-9a-f][0-9a-f]*\.\./1234567../' \
>>> +		     -e '/^index/s/\.\.[0-9a-f]*[1-9a-f][0-9a-f]*/..9abcdef/' \
>>> +		     -e '/^index/s/ 00*\.\./ 0000000../' \
>>> +		     -e '/^index/s/\.\.00*$/..0000000/' \
>>> +		     -e '/^index/s/\.\.00* /..0000000 /' \
>>> +		     "$x" >"$x.filtered"
>>> +	done
>>> +	test_cmp "$1.filtered" "$2.filtered"
>>> +}
>>
>> t3701 is not the only test script comparing diffs, many other
>> tests do so:
>>
>>   $ git grep 'diff --git' t/ |wc -l
>>   835
>>
>> It's totally inaccurate, but a good ballpark figure.
>>
>> I think this function should be a widely available test helper
>> function in 'test-lib-functions.sh', perhaps renamed to
>> 'test_cmp_diff', so those other tests could use it as well.
> 
> I am on the fence.  
> 
> The above does not redact enough (e.g. rename/copy score should be
> redacted while comparing) to serve as a generic filter.
> 
> We could certainly extend it when we make code in other tests use
> the helper, but then we can do the moving to test-lib-functions when
> that happens, too.
> 
> Those who will be writing new tests that need to compare two diff
> outputs are either (1) people who are careful and try to find
> existing tests that do the same, to locate the helper we already
> have to be reused in theirs, or (2) people who don't and roll their
> own.  The latter camp cannot be helped either way, but the former
> will run "git grep 'diff --git' t/" and find the helper whether it
> is in this script or in test-lib-functions, I would think.
> 
> So, I certainly do not mind a reroll to move it to a more generic
> place, but I do not think I would terribly mind if we leave it in
> its current place, later to be moved by the first new caller that
> wants to use it from outside this script.
> 

I did wonder about putting this function in a library when I first wrote
it but decided to wait and see if it is useful instead. As Junio points
out it would need to be improved to act as a generic filter, so I'll
take the easy option and leave it where it is at the moment.

Best Wishes

Phillip
