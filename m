Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DFCC1F424
	for <e@80x24.org>; Fri, 20 Apr 2018 09:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754461AbeDTJlL (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 05:41:11 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:21324 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754400AbeDTJlH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 05:41:07 -0400
Received: from [192.168.2.201] ([92.28.131.105])
        by smtp.talktalk.net with SMTP
        id 9SXRflo2JLjjA9SXRfXOlq; Fri, 20 Apr 2018 10:41:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1524217266;
        bh=M84uQ1tPvBQLD028GQx1ZiqhKr3H22ponidVbWWxAVE=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=iYvk5isOUwEwzNVkkpKE4H2Ifx9yF7is0u/TBlnOvp4gu1Obv/r4f6hUKVqgIoREk
         91AVKK06a1QDjEfpG4fWYAtREOBX7I3frexOxR7hkIy5D9Pz1I46VRuKjre5yNMLwN
         rdvtTGLCs/DpZ43dC/CbXrueZDM85ZIdifdNqgoU=
X-Originating-IP: [92.28.131.105]
X-Spam: 0
X-OAuthority: v=2.3 cv=LZYSFAXi c=1 sm=1 tr=0 a=D1tPBkQZhJ8hQpCscnDOhQ==:117
 a=D1tPBkQZhJ8hQpCscnDOhQ==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=A9qS8gIqAAAA:8 a=sWUjdX00SNH4Gy8lfLMA:9 a=k07w6zdoq_x7bTTN:21
 a=ysy7IFvnyPoScRiD:21 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
 a=H28RkzuXznr5akrmL4QT:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH] ident: don't cache default date
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
References: <5f5d5b88-b3ac-ed4f-ee24-6ce2cba2bd55@kdbg.org>
 <20180418102236.7183-1-phillip.wood@talktalk.net>
 <87vacoeovh.fsf@evledraar.gmail.com>
 <85ecb584-77a7-f818-14c9-1019873d87f9@talktalk.net>
 <d4aee85d-956f-ac93-b909-6dfeb5ea8fd7@kdbg.org>
 <65ca9629-46b1-2963-9b6b-99f12a18689d@talktalk.net>
 <nycvar.QRO.7.76.6.1804201010120.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <8ec9129f-5a27-1ece-91d8-0883dacadce9@talktalk.net>
Date:   Fri, 20 Apr 2018 10:41:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1804201010120.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfG14sfIhmZBwKgPuUHZTCqgXOQ5XCmOJr2E8fbWw2mIm2NfaLm3+xFKymywyOKhGUw5URCcTyaFMW4tL93HiM5Bwh1PNilZNipDcYUC+m3mJILy505fK
 zFxjDgFs7WMPDOR7UGFyLoXpSOqNhivspOJ3uEebAZHUwN8J6/Jq849mjNW3N1WJBRfwAtgmpykIgIW1BocyyqKEcVY/YPXNcnKxXGy3ueWfBmw9jzuH7FPy
 GYab07LVKazaA1Q9bk/r6QciCr6Wery7f9zmWYV0RLHsYEJ27W/btnQDz6TI8ML2S6GF8kxIW274eQKeq2mCebeEWXozmg+oHlRnmWF8unk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/04/18 09:11, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Thu, 19 Apr 2018, Phillip Wood wrote:
> 
>> On 18/04/18 19:15, Johannes Sixt wrote:
>>> Am 18.04.2018 um 19:47 schrieb Phillip Wood:
>>>> On 18/04/18 12:27, Ævar Arnfjörð Bjarmason wrote:
>>>>> On Wed, Apr 18 2018, Phillip Wood wrote:
>>>>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>>>> as it is created by running an separate instance of 'git commit'.  If
>>>>>> the reworded commit is follow by further picks, those later commits
>>>>>> will have an earlier committer date than the reworded one. This is
>>>>>> caused by git caching the default date used when GIT_COMMITTER_DATE is
>>>>>> not set. Fix this by not caching the date.
>>>>>>
>>>>>> Users expect commits to have the same author and committer dates when
>>>>>> the don't explicitly set them. As the date is now updated each time
>>>>>> git_author_info() or git_committer_info() is run it is possible to end
>>>>>> up with different author and committer dates. Fix this for
>>>>>> 'commit-tree', 'notes' and 'merge' by using a single date in
>>>>>> commit_tree_extended() and passing it explicitly to the new functions
>>>>>> git_author_info_with_date() and git_committer_info_with_date() when
>>>>>> neither the author date nor the committer date are explicitly
>>>>>> set. 'commit' always passes the author date to commit_tree_extended()
>>>>>> and relied on the date caching to have the same committer and author
>>>>>> dates when neither was specified. Fix this by setting
>>>>>> GIT_COMMITTER_DATE to be the same as the author date passed to
>>>>>> commit_tree_extended().
>>>>>>
>>>>>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>>>> Reported-by: Johannes Sixt <j6t@kdbg.org>
>>>>>> ---
>>>>>>
>>>>>> I'm slightly nervous that setting GIT_COMMITTER_DATE in
>>>>>> builtin/commit.c will break someone's hook script. Maybe it would be
>>>>>> better to add a committer parameter to commit_tree() and
>>>>>> commit_tree_extended().
>>>
>>> While I like the basic theme of your patch, I think we should fix this
>>> case in a much simpler way, namely, use the infrastructure that was
>>> introduced for git-am.
>>>
>>> I've shamelessly lifted the commit message from your patch.
>>
>> Thanks, that is a better way (I'm annoyed with myself for not having
>> noticed reset_ident_date() when I edited the function above it)
> 
> Don't be too annoyed. I did remember that The Linus had complained about
> something similar and assumed that it had been fixed in the meantime, but
> I failed to find it within 30 minutes where I tried to dig through
> public-inbox and pu.

Thanks, that makes we feel better about it (thanks for taking the time
to try and find the original mail as well)

Phillip

> Thanks Hannes for remembering, and for coming up with the final form of
> the patch!
> 
> Ciao,
> Dscho
> 

