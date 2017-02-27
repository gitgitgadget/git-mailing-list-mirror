Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5A121F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 22:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751720AbdB0WTa (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 17:19:30 -0500
Received: from mout.web.de ([212.227.15.4]:56317 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751742AbdB0WT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 17:19:27 -0500
Received: from [192.168.178.36] ([79.237.49.102]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M844f-1cMhTs4Amf-00vhqy; Mon, 27
 Feb 2017 23:18:18 +0100
Subject: Re: [PATCH 1/2] apply: guard against renames of non-existant empty
 files
To:     Junio C Hamano <gitster@pobox.com>
References: <20170225101307.24067-1-vegard.nossum@oracle.com>
 <baf195cc-ef81-bbad-4e01-4149498efedb@web.de>
 <xmqqinnvwg2d.fsf@gitster.mtv.corp.google.com>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Michal Zalewski <lcamtuf@google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ed46f675-559a-88a3-cf97-d0ba7cf3112f@web.de>
Date:   Mon, 27 Feb 2017 23:18:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <xmqqinnvwg2d.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:gOVevM78gSgeq7lLSi44tV8MG5x2Ts9ZMBDF6fpMi2Zful86zry
 aXH3D6jdbUhZSmPlnajm2anSmqQeZO7UCnQhTRupdtaye8XyDhtzCkCf7URIghZfdrzKwk3
 7aN6TGoH5d2GMzMWHkMw75cjTfAhHT/pIOPuMDtU+jMbcZ8Uqy4L/ohRGud7kKnZLZRynkd
 uknLvIa76h9VlIgFGWvQg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gutPXmjiM0I=:7MWGavEUYskfw7FQBLblR6
 XsKeJNtMY+uTfGggwpv9oro29ZXoTsrgYEhqY4IqrobosNo1qlD84CHlxvDDD7w2CsSKbbyl5
 9uPMZLwVU7wAs20Uh1P28VWi+VbWZTWiSsi3pxqUwZ2JOd9eFvwLjwCpqRzJDo95VCU7PWZa+
 xPxNCjpMD4Ae4XDlab1xAyYXGfHcLkUP00ts0QKXUMMf3LSmn9W1pqk6xUqDe7Tc/0zkYy6Xv
 XbW9iTCOo2DyoTzlylnHICwv45NUxRfr9gvI7O5uDFmwKMLi2df2NWZV5oHpu1PW1KfmsFURF
 O3Ppj4B7WObY1wSmH7K2oqbpc8njuEsqAlFCsa7hYiRj/5P5BoVC2gUKbb8nt1b6D0nRKru9L
 MheX0NqyRnGkvE3gHZHp6UpABSjNGljaQwlOOjnHQqcmYIqGloDgcItV30KIffYweSdn1Nc7X
 UnXqN3jEQl4Sx/BFHkqwViqrRY7h/ApLJykV66oRPYAb6W9wUveeLFeLa1ntQ5qDL9KmVMLjI
 oge+Ej9pSsU1WJ75D5LP0JQsRalTvgbndR5hZ4eNzpTbhoyCV1Pu/vPWD4HZe0VAicjqPNUdo
 +5mO1opwu1ZhiRv7YseTsRifrCLJqbrTqsCKDccXmjrxcy81uzK3ZfoASv7CnHhlS7w+xJo/9
 DLSjgvnd9CYK3TeNI1z5eSsEG6/4dE26bsK1ngFNaiHy7vIXEPWQiDAjat6zpf+ZlwefFM9pk
 jYnDib33RoU93WJrEBvcBpUyUcs5sp+O5jfMxsvMmlzr2uclEQHd5azPERsB7eSOlY5LXe8Wr
 nIXBs+K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.02.2017 um 21:10 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
>
>> Would it make sense to mirror the previously existing condition and
>> check for is_new instead?  I.e.:
>>
>> 			if ((!patch->is_delete && !patch->new_name) ||
>> 			    (!patch->is_new    && !patch->old_name)) {
>>
>
> Yes, probably.
>
>> or
>>
>> 			if (!(patch->is_delete || patch->new_name) ||
>> 			    !(patch->is_new    || patch->old_name)) {
>
> This happens after calling parse_git_header() so we should know the
> actual value of is_delete and is_new by now (instead of mistaking
> -1 aka "unknown" as true), so this rewrite would also be OK.

The two variants are logically equivalent -- (!a && !b) == !(a || b).  I 
wonder if the second one may be harder to read, though.

René
