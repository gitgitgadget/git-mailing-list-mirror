Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5BC61F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 22:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751468AbdB0WTb (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 17:19:31 -0500
Received: from mout.web.de ([212.227.15.4]:61558 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751587AbdB0WT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 17:19:27 -0500
Received: from [192.168.178.36] ([79.237.49.102]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MXHoz-1cm68X1Z81-00WDbw; Mon, 27
 Feb 2017 23:18:04 +0100
Subject: Re: [PATCH 2/2] apply: handle assertion failure gracefully
To:     Junio C Hamano <gitster@pobox.com>
References: <20170225101307.24067-1-vegard.nossum@oracle.com>
 <20170225101307.24067-2-vegard.nossum@oracle.com>
 <a5626d97-e644-65b5-2fd3-41ce870f85a6@web.de>
 <xmqqmvd7wgc7.fsf@gitster.mtv.corp.google.com>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Michal Zalewski <lcamtuf@google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f191e3a8-a55b-7030-ebbb-3f46c74fdc94@web.de>
Date:   Mon, 27 Feb 2017 23:18:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <xmqqmvd7wgc7.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:3TJhCWIZIFFFQsjXmBctzlFgDEe4iwZT5Jd0IfUFF2npCZ7Oxgb
 hecUVbZlHCGaasLdKy2VRXhQIRI1AW8w6/QEh+5tSBExroeDzrlGerFKDnY5AjfriK8V+Zm
 LmQFO1+3AAcRkzrnnKG++zcWgRk/LSnLVXSBBDvnBEsusYDeXxAtLpXs82SK/hh8nCyAIJi
 v0sCiV4NS3ywhyvfs0+QQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hkeOG1ZlwCc=:bM2Cq70lHh9q4eVB1w4fVM
 HtdyU/ptYwY/tyZ7J3gxF2I/lQtNFthR/uROSr5pyBPMUVz0QPQr3WCBcUoFrxGBQ5Z20X9Bz
 lmvfeu0WHs4W/zfcSWe3v63/5C75w0+ANSfzEd/yfkqd7E+7AFjD04eQz6oUDESt9CICTSA6O
 Q5UHaaGU4mtLwdgJ8jWDdiELzNiUWh8xCKIsQfOka4vjS+tifts7oSuyCUAtjK+6num0w7JAw
 kgnjlv59oZ4Iz5OdjlN3gHDz3xyZctzgdK/1+tu3m1/wOHG0yNIKoX/RIYyIEN4l8tD2bxLPT
 95B4cTSs0G/gVn3+do+Au6qfajntLXU90yzyzwAtwu6qyn2QxawdxlAsycN/7/wPUrI4VnF+O
 48GSuXoSMT/zBfIeru0tjNybJJtRWB7dRKD2fl4Y7vJmCT7TNeeP5WuIin9UnWz7p2f+vQ2g7
 vjIo0CHS4uUyPcz+CHTLJL0tWlpvAeeOsTqAmAGgutr7/0u1ZUPUCgcQFgkcxXk8f9nsqFSU7
 dAx4H4UFicxDIJP8X09XEWQKmXmBE4UH53NZO+qY9GL7vAsIS0Uvdrc3i4DpwIZPMtj83Jxgi
 FZaOM1Ye6dPmPGpy4lW63+b9PzdpIQOssOnO7/E9z9w92iPkXSZ00ayp2YR4lIIEhqWTiT8ON
 demFZ9k5De5PaUo14av9SHtzGqekmn2xQlrpar+UepQuMFLtX/YHHNmeKi92mzEpfEgU6+sIu
 qSFph76h6wcUeOCbSqy7Wwq8br0fWsSABzd9xB9J6m7DhUm2uD8zPYJi5O7yy21UXTYCeAL99
 Xs+yAhV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.02.2017 um 21:04 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
>
>>> diff --git a/apply.c b/apply.c
>>> index cbf7cc7f2..9219d2737 100644
>>> --- a/apply.c
>>> +++ b/apply.c
>>> @@ -3652,7 +3652,6 @@ static int check_preimage(struct apply_state *state,
>>>  	if (!old_name)
>>>  		return 0;
>>>
>>> -	assert(patch->is_new <= 0);
>>
>> 5c47f4c6 (builtin-apply: accept patch to an empty file) added that
>> line. Its intent was to handle diffs that contain an old name even for
>> a file that's created.  Citing from its commit message: "When we
>> cannot be sure by parsing the patch that it is not a creation patch,
>> we shouldn't complain when if there is no such a file."  Why not stop
>> complaining also in case we happen to know for sure that it's a
>> creation patch? I.e., why not replace the assert() with:
>>
>> 	if (patch->is_new == 1)
>> 		goto is_new;
>>
>>>  	previous = previous_patch(state, patch, &status);
>
> When the caller does know is_new is true, old_name must be made/left
> NULL.  That is the invariant this assert is checking to catch an
> error in the calling code.

There are some places in apply.c that set ->is_new to 1, but none of 
them set ->old_name to NULL at the same time.

Having to keep these two members in sync sounds iffy anyway.  Perhaps 
accessors can help, e.g. a setter which frees old_name when is_new is 
set to 1, or a getter which returns NULL for old_name if is_new is 1.

René
