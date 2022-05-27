Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF346C433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 12:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245646AbiE0MhU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 08:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352708AbiE0Mfk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 08:35:40 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6B727B1B
        for <git@vger.kernel.org>; Fri, 27 May 2022 05:17:53 -0700 (PDT)
Received: from [90.198.244.89] (helo=[192.168.0.6])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nuYue-0003qf-6w;
        Fri, 27 May 2022 13:17:52 +0100
Message-ID: <9455d0af-87f2-f331-a440-3d3feb743610@iee.email>
Date:   Fri, 27 May 2022 13:17:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] rebase.c: state preserve-merges has been removed
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
 <0a4c81d8cafdc048fa89c24fcfa4e2715a17d176.1653556865.git.gitgitgadget@gmail.com>
 <220526.86bkvk7hoo.gmgdl@evledraar.gmail.com>
 <19baf95d-67d4-d7ed-72a6-96d098171d3a@web.de> <xmqq5ylsxccw.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqq5ylsxccw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/05/2022 21:33, Junio C Hamano wrote:
> René Scharfe <l.s.r@web.de> writes:
>
>>>>   		OPT_SET_INT_F('p', "preserve-merges", &preserve_merges_selected,
>>>> -			      N_("(DEPRECATED) try to recreate merges instead of "
>>>> +			      N_("(REMOVED) try to recreate merges instead of "
>>>>   				 "ignoring them"),
>>>>   			      1, PARSE_OPT_HIDDEN),
>>>>   		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
>> Hidden options are shown if you use --help-all instead of -h.
>>
>> OPT_SET_INT_F always sets the struct option member "argh" to NULL.  The
>> string changed above is the "help" member, not "argh".
> Good points.  I do think it is OK to say REMOVED in case --help-all
> asks us to show everything, even though I wonder if we can leave it
> there until we remove the "support" of noticing the user asking for
> a now-removed feature.

I'll add "was .." to clarify its historic use.
I expect that it'll be there for many years to catch late upgrading 
users, as well as those that help others stuck in this trap using a 
modern portable Git (esp. Windows).
>>> So there's no point in changing this string, nor to have translators
>>> focus on it, it'll never be used.
>>>
>>>
The translation change would need to be a separate patch, no? That would 
make it easy to drop if not wanted.
P.
