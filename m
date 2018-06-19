Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2A851F403
	for <e@80x24.org>; Tue, 19 Jun 2018 17:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030282AbeFSRdu (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 13:33:50 -0400
Received: from mout.web.de ([217.72.192.78]:60535 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030275AbeFSRdt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 13:33:49 -0400
Received: from [192.168.178.36] ([79.237.242.156]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LaTid-1fuzc23N5r-00mKEy; Tue, 19
 Jun 2018 19:33:41 +0200
Subject: Re: [PATCH 0/7] grep.c: teach --column to 'git-grep(1)'
To:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com
References: <cover.1529365072.git.me@ttaylorr.com>
 <20180619163506.GB22034@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <5282e3bb-bf7a-ab3a-98dc-d29ff1c37468@web.de>
Date:   Tue, 19 Jun 2018 19:33:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180619163506.GB22034@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ORbcrUpKvP/aMtZmb72XiTVIIWmeCWxLchXzfC6QQ/2iAbPzqQ9
 xjI4D0EBegRoEXTk4AbQE2iRW3f6YNpUYVtfRJMqXADm2R3mbHPJYGqoPJHH843L51JIiCV
 ckT4UNIauxMn6eAaDzjniotchfIiUZ6Zc3zbenbguai2xFDkln1Da2WBZG71BLHsYDIcBIU
 mW//ISyPxlTHNnopE0pJw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zk29RPeElJo=:871jKtbPOTJAxq2NKzzLsf
 pS1nLpcdLtb9mafkmXiPCjJ2F2IBP5T6R3bWCB5VnNx1FIEQEhKDAtNeDGvK4eY86X2B3mJot
 SFIc3oxQOnMyoJquhoUMzAMexHfpm8fpU7M4VwsgIYxRFYmIUfTYljjZBkfcGEh/4fDV5nm6p
 5/dBlXmLV1Snr5hxPj0sziPVZxS9t9eE6P+tKub15uu/YWmSZFVnp9TASqi440h+NyV64gDIV
 ONukAmq79OX1BomqkVPOBpW35gAv4B+ZGwJ1UZxOdW85rrEPT9NeLizfsASv/FyQWkTi474+E
 z6IP9/F65rC7Ay/7FxigxPHiqqT2pajJ6MNY/n/bAnfeaR8zFS44fTqe9mfIQREeRRQvGa4jR
 2tWgg0v9eClr99e+29a1fOnfUavuvo2NXbHrJ51D/1Sj/0eLoe9BXz2G6elVv2I0n1QzX8vzD
 04WaAAWiq+neQtoWoNh3YXRriiWm84/peYuAg0OD8fO0fIXSs8OIuTlTnS1XW/Qy0rC4RYGVF
 eFHqDjZrn+C+p0aadyqfNeGyEBitnBoDI99B4a99jMh88H7sl1AKJbVcx1/TirokdP9rWiahU
 grXCfViOTFBI05IAl4RLJetuF3zMumsZvZv36MWsnu5IHleeitcQ/SxtpMoxENwrrED6/hxU6
 QhB6pFhl+nxD0ec9VDIpRKtbW5CV9siq901YaMa1CncMU0DjpZbkxd/XcpCsfQYzruHkRjvdc
 74HRH19JzOV+VJ0ZFHYYZD4HFOhhi3/WudRkZbRFvWG+0Q2ZF5/glOQsBVzE3jURp3xUxAFih
 UAPjDrB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.06.2018 um 18:35 schrieb Jeff King:
> On Mon, Jun 18, 2018 at 06:43:01PM -0500, Taylor Blau wrote:
>> The notable case that it does _not_ cover is matching the following
>> line:
>>
>>    a ... b
>>
>> with the following expression
>>
>>    git grep --column -e b --or -e a
>>
>> This will produce the column for 'b' rather than the column for 'a',
>> since we short-circuit an --or when the left child finds a match, in
>> this case 'b'. So, we break the semantics for this case, at the benefit
>> of not having to do twice the work.
>>
>> In the future, I'd like to revisit this, since any performance gains
>> that we _do_ make in this area are moot when we rescan all lines in
>> show_line() with --color. A path forward, I imagine, would look like a
>> list of regmatch_t's, or a set of locations in the expression tree, such
>> that we could either enumerate the list or walk the tree in order to
>> colorize the line. But, I think for now that is #leftoverbits.
> 
> The key thing about this iteration is that it doesn't regress
> performance, because we always short-circuit where we used to. The other
> obvious route is to stop short-circuiting only when "--column" is in
> effect, which would have the same property (at the expense of a little
> extra code in match_expr_eval()).

The performance impact of the exhaustive search for --color scales with
the number of shown lines, while it would scale with the total number of
lines for --column.  Coloring the results of highly selective patterns
is relatively cheap, short-circuiting them still helps significantly.

Disabling that optimization for --column wouldn't be a regression since
it's a new option..  Picking a random result (based on the order of
evaluation) seems sloppy and is probably going to surprise users.

We could add an optimizer pass to reduce the number of regular
expressions in certain cases if that is really too slow.  E.g. this:

	$ git grep -e b -e a

... is equivalent to:

	$ git grep -e '\(b\)\|\(a\)'

In that example the optimizer should use a single kwset instead of a
regex, but you get the idea, namely to leave the short-circuiting to the
regex engine or kwset, which probably do a good job of it.

René
