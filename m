Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAAF32082F
	for <e@80x24.org>; Sun, 16 Jul 2017 03:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751236AbdGPDxI (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jul 2017 23:53:08 -0400
Received: from mout.web.de ([212.227.15.14]:62580 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751223AbdGPDxH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2017 23:53:07 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LvSQV-1des4D0WQN-010ZmO; Sun, 16
 Jul 2017 05:52:46 +0200
Subject: Re: [PATCH] ls-files: don't try to prune an empty index
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <bbc51fb0-70ce-3b02-274b-31b5dc035e29@web.de>
 <8fdcc21d-ccf9-7594-4d69-dfcad580da32@ramsayjones.plus.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ae5359cf-a480-f357-cb51-78f9d4cc431c@web.de>
Date:   Sun, 16 Jul 2017 05:52:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <8fdcc21d-ccf9-7594-4d69-dfcad580da32@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:wUyB1vfZPbAOLVzeysqPUPly0P6Esdw3t9u8G4h56/Db7F0VQy3
 KtrxcB03qHodxmePKga49V+8FBBpB4C3BVd1Oh1joLjZXKzMuWJ87XHdiwfdX5q0qacWGir
 A8g/rRuQotO4sbhG/z5pdxGNipwZrOMKZH+He65kg5rqeVQ7rql64qoDR0Me8gDzXshPWke
 cKdhiua4V3FXpycuizjsw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:i8YbH+1zha4=:VRlQ/Q8vDsSE0h2ycEE56L
 +mGArRN90T4aYdJVKsYIWLNX7iYaa116e5SvfLo9t5gnjzC74ctoQHLxtP2BpdIuXv2MLaZ6G
 v6Op7d2NdUoMCAFhTNhSZMx25oK5Zz8+XiWhTGUWqTSUkv6e8uY8AaXMWc0Tgh/mHml/7pDAT
 r4fYO7XCRPFGKcavzu3x8CwsQjAVXRq0PFRnIJb1FHNNsWtWUmoX0peJrdimElE9Od1XnLION
 fOW0/kodUcEQegbi6tpXnzz5/BeiQ85IyihODHc1o9q3nX9GGVv+kPsjQ2Mz2oj9NAHiE5oV1
 o2CH1CXX5C5EQGAe6ybocsqcaJzeaBCGkfYZ4BJm9e1wviCaWcLVf6MTJpyTDlYfVhHE8W3qh
 7oLvg64vEnxmYv5IZqBmGhc1DFZIno6AARD+snXXIAZwN4eP7Fsd8xy/3xtFFycjG/0nk1mH5
 0R7GKdl5hqoyF6q5RzBJVFfPzNHRuvGavSSP5+PbyH6Au3cwazeNty/64BUcXxYSwdfAgJs8p
 HeWvnHvUWH2jKBmiwJR0j2nTYpzI7g2Y4eOHRoK4ngIFFWTg8svq5KVlE4F72M6BWYejTB4GA
 P2nA/JIaLtEG19C8gWtTSeIGXMynTnohT2N2zcQn1ojzkrTrCAxzDBNur/R9g9Ud88KILzwRL
 TzJT1sBSsdJ/DSF3w/ElQJajkRF+CjaDzU3MQ3QnhMTIOfpvGqArJCbCplVx/3EB2rLhkxlTV
 iVXRmK/1DhdVDtNYfWXFjanqZCUAiOnZgL5rQ2CgTT1lcQjDKyUsAe7ZAJ+4SjhhLzAQ8kv7R
 OirgygToMa9bKXm1VyWfr2pIEn5EOptTcx3i0qIUoC10s1q9fQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.07.2017 um 02:28 schrieb Ramsay Jones:
> 
> 
> On 15/07/17 21:11, René Scharfe wrote:
>> Exit early when asked to prune an index that contains no
>> entries to begin with.  This avoids pointer arithmetic on
>> istate->cache, which is possibly NULL in that case.
>>
>> Found with Clang's UBSan.
>>
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>>   builtin/ls-files.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
>> index b8514a0029..adf572da68 100644
>> --- a/builtin/ls-files.c
>> +++ b/builtin/ls-files.c
>> @@ -362,7 +362,7 @@ static void prune_index(struct index_state *istate,
>>       int pos;
>>       unsigned int first, last;
>>
>> -    if (!prefix)
>> +    if (!prefix || !istate->cache_nr)
>>           return;
>>       pos = index_name_pos(istate, prefix, prefixlen);
>>       if (pos < 0)
> 
> My patch looked like:
> 
> -       if (!prefix)
> +       if (!prefix || !istate->cache || istate->cache_nr == 0)
> 
> ... which is probably a bit 'belt-n-braces'. ;-)

Not checking for !istate->cache at this point is a good thing, I think.
If we have entries, then ->cache must not be NULL, and if it is we'd get
a segfault, notifying us that we have a bug.  We could add an assert to
state this requirement explicitly, but that would be the topic of a
different patch.

René
