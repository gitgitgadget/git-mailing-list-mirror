Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B6C41F403
	for <e@80x24.org>; Tue, 19 Jun 2018 18:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030585AbeFSSui (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 14:50:38 -0400
Received: from mout.web.de ([212.227.17.12]:34379 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030530AbeFSSuf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 14:50:35 -0400
Received: from [192.168.178.36] ([79.237.242.156]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M41Bm-1gMlbd1Fy6-00rZLw; Tue, 19
 Jun 2018 20:50:19 +0200
Subject: Re: [PATCH 0/7] grep.c: teach --column to 'git-grep(1)'
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com, gitster@pobox.com
References: <cover.1529365072.git.me@ttaylorr.com>
 <20180619163506.GB22034@sigill.intra.peff.net>
 <5282e3bb-bf7a-ab3a-98dc-d29ff1c37468@web.de>
 <20180619174846.GA27820@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6ab94453-84ef-e269-c320-e102b02d6f3b@web.de>
Date:   Tue, 19 Jun 2018 20:50:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619174846.GA27820@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7Lc2WpzI6aeLAC4UNaZcETSwZmHr9uMjq2zsDHNID45nKMPs2Fx
 lfRzUtbNV+YT3N6YYmHk0Zizu5eZ4xKFFfT/7bKTzr3/+bKrlTo3WiHjOwb0XjPd+cx6DkW
 5G+l62RJJSrNPgL5+Lb6hKFs2Ln/xFbpLuStpReBH/nAzxNeHO12xkOjMrzqRUnkD0DZDZi
 GnDcIYjBcresPun24+SFg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wAW91IT/2bI=:qxcLEq8uFsr8yLW8176Y/H
 06ScrQKmMbCGvjPAxQSWbmqQYzsxgYEu2quZ4k5GyE1R9crYGvZsvxvYiRPJ5IT1GTEuFJL12
 lhv8u3hg+RcdI5ragNH603jMVLGX9fEI/DqreG+MndbydMY304ZF1bOedyOWtjqRTwKePJ22K
 RDOtNARgnU2c68TYPcH7KYbzyMfprP6YZY0KgGhX2uqxByTIQh9IOfAycdwEOB/U2Nlr3UC+s
 2aujZFhqNT98EltNerBQkXS5XEUWD4US3fOChQItfZVexfMaFyGY84XejFhswYu5IpVSn6lPx
 wpWMdriz0C310C14+KVrdhq/c1j8y4XRFupcKjnFFfYMrJ9rn3QqeHWbzmfFuL/maV7/g5aOa
 xeHI6nz+pq8Ub0oaSos6rmEMFkpIPSUpV/x+2CSxM0Bea/JYiHAK75LPcXoFgbkfQ/0432AgM
 hGcuS1UEGOXxO/dE8zBRmNA5TA51lnYbQVyZUrf/C3U2dW+e7oYF6GqfD62YoMEBE3n0YwkJs
 ARsf08lQZrJIHXdvmKzkKwbqWzY3djJmrBDWn2PoOcJNjH+lsRa4u8IATQvgdMn6z3GnlO5iA
 6BWlK0aebUN5B98TiOyfhCBWB+hm18529OCi/EbCN2DT0qNM/VV2fu8VEmSQ/zw9JcHmbcBdx
 yxO/v9YxjF17yUZ7vbSmpet4MaQQdcRN2WQEPIC6AtbF/gu4IVKT+xOWECE2EN+HjofZwjh/T
 dC+a0u06Mu3Yve2n+9MbclyMSrW6RV10MFO7JhJBgzHHXGEqThyW4+hZyyp92+mB7lFMqWmcu
 F9c6P2e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.06.2018 um 19:48 schrieb Jeff King:
> On Tue, Jun 19, 2018 at 07:33:39PM +0200, René Scharfe wrote:
> 
>>> The key thing about this iteration is that it doesn't regress
>>> performance, because we always short-circuit where we used to. The other
>>> obvious route is to stop short-circuiting only when "--column" is in
>>> effect, which would have the same property (at the expense of a little
>>> extra code in match_expr_eval()).
>>
>> The performance impact of the exhaustive search for --color scales with
>> the number of shown lines, while it would scale with the total number of
>> lines for --column.  Coloring the results of highly selective patterns
>> is relatively cheap, short-circuiting them still helps significantly.
> 
> I thought that at first, too, but I think we'd still scale with the
> number of shown lines. We're talking about short-circuiting OR, so by
> definition we stop the short-circuit because we matched the first half
> of the OR.
> 
> If you stop short-circuiting AND, then yes, you incur a penalty for
> every line. But I don't think --column would need to do that.

Good point.  So disabling that optimization for --column (or in even
in general) shouldn't be a dramatic loss.

> Although there are interesting cases around inversion. For example:
> 
>    git grep --not \( --not -e a --and --not -e b \)
> 
> is equivalent to:
> 
>    git grep -e a --or -e b
> 
> Do people care if we actually hunt down the exact column where we
> _didn't_ match "b" in the first case?  The two are equivalent, but I
> have to wonder if somebody writing the first one really cares.

I'd rather not guess the intentions of someone using such convoluted
expressions. ;-)

Negation causes the whole non-matching line to match, with --column
reporting 1 or nothing in such a case, right?  Or I think doing the
same when the operator is applied a second time is explainable.

>> Disabling that optimization for --column wouldn't be a regression since
>> it's a new option..  Picking a random result (based on the order of
>> evaluation) seems sloppy and is probably going to surprise users.
> 
> I don't see it as a random result; short-circuiting logic is well
> understood and we follow the user's ordering.

When ORing multiple expressions I don't pay attention to their order
as that operator is commutative.  Having results depend on that
order would at least surprise me.

> I think the place where it's _most_ ugly is "--column --color", where we
> may color the short-circuited value in the second pass.

The double negative example you gave above has that discrepancy as
well, but I think in that case it just highlights the different
intentions (--color: highlight search terms, --column: show leftmost
match).

>> We could add an optimizer pass to reduce the number of regular
>> expressions in certain cases if that is really too slow.  E.g. this:
> 
> Yes, we actually discussed this kind of transformation. I think it's way
> out of scope for this patch series, though. If we do anything more, I
> think it should be to disable short-circuiting when --column is in use.

Yep.

René
