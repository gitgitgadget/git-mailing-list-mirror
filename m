Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D36E620A10
	for <e@80x24.org>; Sat, 30 Sep 2017 08:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751644AbdI3ICi (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 04:02:38 -0400
Received: from siwi.pair.com ([209.68.5.199]:62240 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750724AbdI3ICh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 04:02:37 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 18723845E7;
        Sat, 30 Sep 2017 04:02:36 -0400 (EDT)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id DD7E6845E6;
        Sat, 30 Sep 2017 04:02:35 -0400 (EDT)
Subject: Re: [idea] File history tracking hints
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.org>
Cc:     Pavel Kretov <firegurafiku@gmail.com>, git@vger.kernel.org
References: <CAOZF3=Ouvk8ccME+fXr_T=GL1j4Gx3Hgj3ao_-GQng-noeOubg@mail.gmail.com>
 <E8C827ED458648F78F263F2F2712493B@PhilipOakley>
 <alpine.DEB.2.21.1.1709131322470.4132@virtualbox>
 <04DDB36236444FFD8C3668AA7B62B154@PhilipOakley>
 <alpine.DEB.2.21.1.1709300110350.40514@virtualbox>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <5fb263a8-d83b-64a7-812f-fd8e3748feb6@jeffhostetler.com>
Date:   Sat, 30 Sep 2017 04:02:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1709300110350.40514@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/29/2017 7:12 PM, Johannes Schindelin wrote:
> Hi Philip,
> 
> On Fri, 15 Sep 2017, Philip Oakley wrote:
> 
>> From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
>>
>>> In light of such experiences, I have to admit that the notion that the
>>> rename detection can always be improved in hindsight puts quite a bit of
>>> insult to injury for those developers who are bitten by it.
>>
>> Your list made me think that the hints should be directed toward what may be
>> considered existing solutions for those specific awkward cases.
>>
>> So the hints could be (by type):
>> - template;licence;boiler-plate;standard;reference :: copy
>> - word-rename
>> - regex for word substitution changes (e.g. which chars are within 'Word-_0`)
>> - regex for white-space changes (i.e. which chars are considered whitespace.)
>> - move-dir path/glob spec
>> - move-file path/glob spec
>> (maybe list each 'group' of moves, so that once found the rest of the rename
>> detection follows the group.)
>>
>> Once the particular hint is detected (path qualified) then the clue/hint is
>> used to assist in parsing the files to simplify the comparison task and locate
>> common lines, or common word patterns.
>>
>> The first example is just a set of alternate terms folk use for the new
>> duplicate file file case.
>>
>> The second is a hint that there has been a number of fairly global name
>> changes in the files. so not only do a word diff but detect & sumarise those
>> global changes. (your class move example)
>>
>> The third is the more simple global word changes, based on a limited char set
>> for a 'word' token list.
>> The fourth is where we are focussed on the white space part (complementing the
>> word token viewpoint)
>>
>> The move hints are lists of path specs that each have distinctly moved.
>>
>> It may be possible to order the hints as well, so that the detections work in
>> the right order, giving the heuristics a better chance!
> 
> I think my point was: no matter how likely we thought any heuristic rename
> detection can be perfected over time, history proved that suspicion
> incorrect.
> 
> Therefore, it would be good to have a way to tell Git about renames
> explicitly so that it does not even need to use its heuristics.

Agreed.

It would be nice if every file (and tree) had a permanent GUID
associated with it.  Then the filename/pathname becomes a property
of the GUIDs.  Then you can exactly know about moves/renames with
minimal effort (and no guessing).  But I suppose that ship has sailed...

Jeff

