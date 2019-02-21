Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D2931F453
	for <e@80x24.org>; Thu, 21 Feb 2019 17:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfBUR1J (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 12:27:09 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:28832 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfBUR1J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 12:27:09 -0500
Received: from [192.168.2.240] ([92.22.15.194])
        by smtp.talktalk.net with SMTP
        id ws7kgsBl66cDmws7lgNfe7; Thu, 21 Feb 2019 17:27:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1550770026;
        bh=9pUY9P7y4rZBDiFJEEhcKOyCWEIvOgCDEF7xaQ6TS+Q=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=eyU/iqEa+Q+RzA5aQ1o5gDfMjj2uMe/yVvQGc5vMJVKQMhS67Dzqs1FJ7WK64egCR
         zGMWovHlUTCKDDKgBHuK0KiBpn7fSuG1jmAyyzJf6JNsCnnR2DzAbLd+SUOfQUFM9W
         /pDZY9MouvpcA/hUt9Z9EbigL/iVa9dcA4vwxVPo=
X-Originating-IP: [92.22.15.194]
X-Spam: 0
X-OAuthority: v=2.3 cv=Cal2G4jl c=1 sm=1 tr=0 a=SbQTfhO/oL0pg4h8lvBCaA==:117
 a=SbQTfhO/oL0pg4h8lvBCaA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=xIHWIvI8Rzk9M42o3poA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] setup: don't fail if commondir reference is deleted.
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Marketa Calabkova <mcalabkova@suse.cz>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1550508544.git.msuchanek@suse.de>
 <6f9c8775817117c2b36539eb048e2462a650ab8f.1550508544.git.msuchanek@suse.de>
 <CACsJy8AWezO7TFq8ne1a2pSAJZoc6oYqnNNxmVW_FkA9--ntbQ@mail.gmail.com>
 <20190221145056.53b98b2a@kitsune.suse.cz>
 <adc0f7f9-aa41-780e-6fce-94d493fac318@talktalk.net>
 <CAPig+cTQMZFF-oX-SOzB5JR=V1WThBihC+kNm-2wjbpAWf-OHA@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <4309841e-2b98-22d4-505e-1b9ea2f5e3bb@talktalk.net>
Date:   Thu, 21 Feb 2019 17:27:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cTQMZFF-oX-SOzB5JR=V1WThBihC+kNm-2wjbpAWf-OHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfEDzoVvscADFzrsoUWtogdPiFd1OD+gPJ1bpVD/MhUEdQ/xY45vQZOTnr0PSWftT4awU8clHdmODBETcB3vFWh9ppJ4ELK9vb0RiyyxuCDVfSVwi0eTg
 cfijvWltZ1jewnkBJCI3gj3Kk1ookSgKBbVJfyy74m16OEaqcOuIttdr8hs46xx60wW57SW7ZYva6a8h25rhSViI8ZdspybIRZqRFlHreqypSeQuRFfddtNi
 7p/Ul20ZblAxxW5jx4SrxmA5GKxUney4SiRjq2v6Nu2UlHC4C10sMEm3e3EkTJ0whdDxgzwPZaEter5MpWD6uTr4Z+98Ws2UWEkMPerH/BzHEdyBIISCwZq3
 mYlx3PuQrfj6iEgXAn2jqPsNH/0FeQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric

On 21/02/2019 17:12, Eric Sunshine wrote:
> On Thu, Feb 21, 2019 at 12:07 PM Phillip Wood <phillip.wood@talktalk.net> wrote:
>> On 21/02/2019 13:50, Michal Suchánek wrote:
>>>> On Tue, Feb 19, 2019 at 12:05 AM Michal Suchanek <msuchanek@suse.de> wrote:
>>> The problem is we don't forbid worktree names ending with ".lock".
>>> Which means that if we start to forbid them now existing worktrees
>>> might become inaccessible.
>>
>> I think it is also racy as the renaming breaks the use of mkdir erroring
>> out if the directory already exists. One solution is to have a lock
>> entry in $GIT_COMMON_DIR/worktree-locks and make sure the code that
>> iterates over the entries in $GIT_COMMON_DIR/worktrees skips any that
>> have a corresponding ignores in $GIT_COMMON_DIR/worktree-locks. If the
>> worktree-locks/<dir> is created before worktree/<dir> then it should be
>> race free (you will have to remove the lock if the real entry cannot be
>> created and then increment the counter and try again). Entries could
>> also be locked on removal to prevent a race there.
> 
> I wonder, though, how much this helps or hinders the use-case which
> prompted this patch series in the first place; to wit, creating
> hundreds or thousands of worktrees. Doing so serially was too slow, so
> the many "git worktree add" invocations were instead run in parallel
> (which led to "discovery" of race conditions). Using a global worktree
> lock would serialize worktree creation, thus slowing it down once
> again.

The idea is that there are per-worktree lock stored under worktree-locks 
(hence the plural name). Using a separate directory for the locks gets 
round the problems of name clashes between the lock for a worktree 
called foo and one called foo.lock and means we can rely on mkdir 
erroring out if the worktree name already exists as there is no renaming.

Best Wishes

Phillip

