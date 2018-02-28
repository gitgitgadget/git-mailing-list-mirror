Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0C9F1F576
	for <e@80x24.org>; Wed, 28 Feb 2018 11:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752195AbeB1LKa (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 06:10:30 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:59345 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbeB1LK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 06:10:29 -0500
Received: from [192.168.2.201] ([92.22.16.137])
        by smtp.talktalk.net with SMTP
        id qzcxeK3n6AruKqzcyeKYd7; Wed, 28 Feb 2018 11:10:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519816228;
        bh=mDm+GMRhXKVoZwkGt0i+9tQ73ece1JrAVB2n0+ymNOo=;
        h=Reply-To:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=fUDQCdF/8HfbnFcq2waisNR954xn6jwm/4JjLIXQ2D/nVom8NGv1LqQ+JKs5KjLm6
         diJiXLogGZ7xqqwztcjbuTPrQhwwwMWBtu+YKZ7OltUL37fcx8EsHm4N+eMiTHkFXT
         cWpWxomGNGg+xi9uLLEs+2I83JWS/dIzkWn81N3o=
X-Originating-IP: [92.22.16.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=br5i+nSi c=1 sm=1 tr=0 a=nWy375ASyxHoIYnPohIYMA==:117
 a=nWy375ASyxHoIYnPohIYMA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=Ascsb8iJODw7nMzjqzwA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 4/9] t3701: don't hard code sha1 hash values
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180227110404.16816-1-phillip.wood@talktalk.net>
 <20180227110404.16816-5-phillip.wood@talktalk.net>
 <xmqqinainjfy.fsf@gitster-ct.c.googlers.com>
 <454d7edf-6331-2ca9-8113-de383aa5df4a@talktalk.net>
Message-ID: <a44c4432-ea10-bf0b-7014-bebee13eef3c@talktalk.net>
Date:   Wed, 28 Feb 2018 11:10:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <454d7edf-6331-2ca9-8113-de383aa5df4a@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfP6fLj9Z4Dq0edW+OB54Z5DORmaWRs/hCSpc1OU4Xwp0i+r90ZeyAlX9N1V2ADrVSsRFo7rnfmt3UdVZkc6oT57cPeILrOy8EYPCEV4KkfhicPCJ4bt6
 X5NarGReweKlPDrAgpPBDX/A2P1yrlYOJolesNM2fJon9YRCVR4rr0DIo9bEhC+e4u9abzpJuB8aRwwbR3dIy0rOeznO/IqDuWoCC6H5dFlUwDZbUbUFYrRA
 +Sv0AgCEYGV50kW6iqn60yYvTJdwaTUy4EmdtUd13pYQrr5xbmB54WhWubFp5H6mPoz1sgda7IpwqB0SUjo29SahHtDQ3ojHjlsYTyxCP48=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/02/18 11:03, Phillip Wood wrote:
> On 27/02/18 22:42, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood@talktalk.net> writes:
>>
>>>  t/t3701-add-interactive.sh | 30 ++++++++++++++++++++----------
>>>  1 file changed, 20 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
>>> index bdd1f292a9..46d655038f 100755
>>> --- a/t/t3701-add-interactive.sh
>>> +++ b/t/t3701-add-interactive.sh
>>> @@ -10,6 +10,16 @@ then
>>>  	test_done
>>>  fi
>>>  
>>> +diff_cmp () {
>>> +	for x
>>> +	do
>>> +		sed  -e '/^index/s/[0-9a-f]*[1-9a-f][0-9a-f]*\.\./1234567../' \
>>> +		     -e '/^index/s/\.\.[0-9a-f]*[1-9a-f][0-9a-f]*/..9abcdef/' \
>>> +		     "$x" >"$x.filtered"
>>
>> Interesting ;-)  You require .. and on the left hand side you want
>> to see a run of hexdec with at least one non-zero hexdigit, which is
>> filtered to fixed-length 1234567; right hand side is the same deal.
>>
>> Which sounds like a reasonable way to future-proof the comparison.
>>
>> If 7 zeros are expected in the result, and the actual output had 8
>> zeros, the filter does not touch either so they compare differently,
>> which is somewhat unfortunate.  Perhaps something like
> 
> Ah, good point
> 
>> 	/^index/s/^00*\.\./0000000../
>> 	/^index/s/\([^0-9a-f]\)00*\.\./\10000000../
>> 	/^index/s/\.\.00*$/..0000000/
>> 	/^index/s/\.\.00*\([^0-9a-f]\)/..0000000\1/
>>
>> after the above two patterns help?
> 
> Yeah, something like that though matching the beginning and end of the
> line for the beginning and end of the hashes wont work. I'll reroll with
> something similar

Thinking about it some more, just using your last three patterns should
do the job. - I'll test and reroll.

> Thanks
> 
> Phillip
> 

