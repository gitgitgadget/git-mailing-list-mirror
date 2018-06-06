Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67D1D1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 21:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752290AbeFFVLk (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 17:11:40 -0400
Received: from siwi.pair.com ([209.68.5.199]:60128 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752053AbeFFVLj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 17:11:39 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 7B1483F40C0;
        Wed,  6 Jun 2018 17:11:39 -0400 (EDT)
Received: from [10.160.98.81] (unknown [167.220.148.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 370BB3F4088;
        Wed,  6 Jun 2018 17:11:39 -0400 (EDT)
Subject: Re: [PATCH v7 2/2] json-writer: t0019: add Python unit test
To:     Jeff King <peff@peff.net>, Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180605163358.119080-1-git@jeffhostetler.com>
 <20180605163358.119080-3-git@jeffhostetler.com>
 <20180606171052.GI3094@zaya.teonanacatl.net>
 <20180606210300.GA1879@sigill.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <dafabaf6-2cf7-6725-8524-9089776c31c3@jeffhostetler.com>
Date:   Wed, 6 Jun 2018 17:11:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180606210300.GA1879@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/6/2018 5:03 PM, Jeff King wrote:
> On Wed, Jun 06, 2018 at 01:10:52PM -0400, Todd Zullinger wrote:
> 
>> git@jeffhostetler.com wrote:
>>> +# As a sanity check, ask Python to parse our generated JSON.  Let Python
>>> +# recursively dump the resulting dictionary in sorted order.  Confirm that
>>> +# that matches our expectations.
>>> +test_expect_success PYTHON 'parse JSON using Python' '
>> [...]
>>> +	python "$TEST_DIRECTORY"/t0019/parse_json_1.py <output.json >actual &&
>>
>> Would this be better using $PYTHON_PATH rather than
>> hard-coding python as the command?
> 
> Probably. We may want to go the same route as we did for perl in
> a0e0ec9f7d (t: provide a perl() function which uses $PERL_PATH,
> 2013-10-28) so that test writers don't have to remember this.
> 
> That said, I wonder if it would be hard to simply do the python bits
> here in perl. This is the first use of python in our test scripts (and
> really the only user in the whole code base outside of a few fringe
> commands). Leaving aside any perl vs python flame-war, I think there's
> value in keeping the number of languages limited when there's not a
> compelling reason to do otherwise.
> 

Perl works too.  (I don't know perl, but I'm told it does work for
stuff like this. :-)

I'll take a stab at it.

Jeff



