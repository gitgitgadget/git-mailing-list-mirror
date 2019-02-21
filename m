Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C4DC1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 17:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbfBURH4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 12:07:56 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:61689 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfBURHz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 12:07:55 -0500
Received: from [192.168.2.240] ([92.22.15.194])
        by smtp.talktalk.net with SMTP
        id wrp8gs9WY6cDmwrp8gNf6Z; Thu, 21 Feb 2019 17:07:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1550768872;
        bh=RqkeBo/zgVhkz7zKMT6lLF5MFUlXgAp2VnkRtDZEd2g=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Ty442tIotNPQznnYg9Dfi5SZBdvAsGouMUn0AmMGWinXsXBhJhn79BHZ5Pcx7LNtW
         VsXWb4R/jJiLGKszey+IaRt9VEzLyruxa3BMc4w85WVqQijeq2e41BQK/Lnm7EozIN
         +MIaIfP77ZD0MNx4pjMbWZHbJ+OAkQh22L2fytrI=
X-Originating-IP: [92.22.15.194]
X-Spam: 0
X-OAuthority: v=2.3 cv=Cal2G4jl c=1 sm=1 tr=0 a=SbQTfhO/oL0pg4h8lvBCaA==:117
 a=SbQTfhO/oL0pg4h8lvBCaA==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=qfsCWp7gufaGXcusNysA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] setup: don't fail if commondir reference is deleted.
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
        Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Marketa Calabkova <mcalabkova@suse.cz>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1550508544.git.msuchanek@suse.de>
 <6f9c8775817117c2b36539eb048e2462a650ab8f.1550508544.git.msuchanek@suse.de>
 <CACsJy8AWezO7TFq8ne1a2pSAJZoc6oYqnNNxmVW_FkA9--ntbQ@mail.gmail.com>
 <20190221145056.53b98b2a@kitsune.suse.cz>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <adc0f7f9-aa41-780e-6fce-94d493fac318@talktalk.net>
Date:   Thu, 21 Feb 2019 17:07:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190221145056.53b98b2a@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfMpYNSCHnYUO1kima3o+ObEl3RV0CRshfLc5zi1uF477V4IyWAFvcTZ2BgE4pJblhWyw86oPOz8e2YIZaIdgnAO2TBB+z6+i39qj4A/GL6YWXHDG9UZK
 txxUEIwlhGOz/+Nnbt0X5e2k3J/oz4jmNJsrgg4EiKWGD4otTUJYUTOoosFQ+SwbE9dX5NnJpK0cWI8aJ5zRRV3N96HzDJxHCfbxYDntCZZAQuxGjVAg8vGu
 ZkQbmRwVjK4onXjmjSxTzGb2VoFF4K9dMB1l69h3B5Oum3uCtPsc2IYgzjWQsCeIPA7YcW5c1UesTRii5Vw4QsVgteFHaWPl31GkDhUIDlI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michal/Duy

On 21/02/2019 13:50, Michal Suchánek wrote:
> On Thu, 21 Feb 2019 17:50:38 +0700
> Duy Nguyen <pclouds@gmail.com> wrote:
> 
>> On Tue, Feb 19, 2019 at 12:05 AM Michal Suchanek <msuchanek@suse.de> wrote:
>>>
>>> When adding wotktrees git can die in get_common_dir_noenv while
>>> examining existing worktrees because the commondir file does not exist.
>>> Rather than testing if the file exists before reading it handle ENOENT.
>>
>> I don't think we could go around fixing every access to incomplete
>> worktrees like this. If this is because of racy 'worktree add', then
>> perhaps a better solution is make it absolutely clear it's not ready
>> for anybody to access.
>>
>> For example, we can suffix the worktree directory name with ".lock"
>> and make sure get_worktrees() ignores entries ending with ".lock".
>> That should protect other commands while 'worktree add' is still
>> running. Only when the worktree is complete that 'worktree add' should
>> rename the directory to lose ".lock" and run external commands like
>> git-checkout to populate the worktree.
> 
> The problem is we don't forbid worktree names ending with ".lock".
> Which means that if we start to forbid them now existing worktrees
> might become inaccessible.

I think it is also racy as the renaming breaks the use of mkdir erroring 
out if the directory already exists. One solution is to have a lock 
entry in $GIT_COMMON_DIR/worktree-locks and make sure the code that 
iterates over the entries in $GIT_COMMON_DIR/worktrees skips any that 
have a corresponding ignores in $GIT_COMMON_DIR/worktree-locks. If the 
worktree-locks/<dir> is created before worktree/<dir> then it should be 
race free (you will have to remove the lock if the real entry cannot be 
created and then increment the counter and try again). Entries could 
also be locked on removal to prevent a race there.

Best Wishes

Phillip

> Thanks
> 
> Michal
> 

