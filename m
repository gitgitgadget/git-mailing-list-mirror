Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9E491F453
	for <e@80x24.org>; Fri, 22 Feb 2019 10:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfBVKUe (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 05:20:34 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:22337 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfBVKUe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 05:20:34 -0500
Received: from [192.168.2.240] ([92.22.15.194])
        by smtp.talktalk.net with SMTP
        id x7wRgtVbF6cDmx7wSgNuaz; Fri, 22 Feb 2019 10:20:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1550830830;
        bh=qLEe67d72S3u6S0n9KAp8R/uwNxn5a2iOG79O5aYm8s=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kaYENiaUZB5kNf2an540dmgHoxd2f2h7BJTmQOj4EScjJqWmvwWsQQ605thkQxOwU
         TGv2HONJxcCVgx2Cvy9daP1v0Es/jor7PPqNDsRHJm4gCpH+5lFLq87oCowAvVLrjL
         nRiSRCCYs258ScXXqeF+9F9XyTtrU2xAQpdmy/p4=
X-Originating-IP: [92.22.15.194]
X-Spam: 0
X-OAuthority: v=2.3 cv=Cal2G4jl c=1 sm=1 tr=0 a=SbQTfhO/oL0pg4h8lvBCaA==:117
 a=SbQTfhO/oL0pg4h8lvBCaA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=pGLkceISAAAA:8 a=DhgQeCj3QoOSJyUbrTYA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] setup: don't fail if commondir reference is deleted.
To:     Duy Nguyen <pclouds@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Marketa Calabkova <mcalabkova@suse.cz>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1550508544.git.msuchanek@suse.de>
 <6f9c8775817117c2b36539eb048e2462a650ab8f.1550508544.git.msuchanek@suse.de>
 <CACsJy8AWezO7TFq8ne1a2pSAJZoc6oYqnNNxmVW_FkA9--ntbQ@mail.gmail.com>
 <20190221145056.53b98b2a@kitsune.suse.cz>
 <adc0f7f9-aa41-780e-6fce-94d493fac318@talktalk.net>
 <CACsJy8B2HRyBKQd+S7hjfU+xGFH+_y0YKcw8397znc2eGUBogQ@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <1e0e8a07-f310-adc7-0538-c1b738da0e98@talktalk.net>
Date:   Fri, 22 Feb 2019 10:20:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8B2HRyBKQd+S7hjfU+xGFH+_y0YKcw8397znc2eGUBogQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfK2j9D3xHy4VG2gS1knb2VtI1e35byHuktCe0Zub6TxackgXe9iQQrQtbKo33QWCMYgr0BCQUoggxrHK4gbg+PXmFpCSwbBh/CeFZ6iyYW5nj9f2GMY9
 DBR90zYpjsFv9j5oCRCqj8Bh1LaY5kTfbG/eSPCUU4PqMPI/h5f8gZ5aKb9FAwNN1Ou6ABhv1fw3NCBIocET9A23wE1KPXz2tbuq8t7kdVQ84Wd2pnlpCHHz
 euTm2sRhocZKBdRaldK9ntB07IKlMtioS3EefRLMdLsW524TltZ7M4cbP9mMvhI/8RoQtkGfUTxGeGPBmXeQOtiWdPSlJGIDam2oyrpWdZu4QxwGs9U49Gmh
 iI7agPAT9XC0k6w9H/ar1xbafapMhQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy

On 22/02/2019 09:32, Duy Nguyen wrote:
> On Fri, Feb 22, 2019 at 12:07 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>>
>> Hi Michal/Duy
>>
>> On 21/02/2019 13:50, Michal Suchánek wrote:
>>> On Thu, 21 Feb 2019 17:50:38 +0700
>>> Duy Nguyen <pclouds@gmail.com> wrote:
>>>
>>>> On Tue, Feb 19, 2019 at 12:05 AM Michal Suchanek <msuchanek@suse.de> wrote:
>>>>>
>>>>> When adding wotktrees git can die in get_common_dir_noenv while
>>>>> examining existing worktrees because the commondir file does not exist.
>>>>> Rather than testing if the file exists before reading it handle ENOENT.
>>>>
>>>> I don't think we could go around fixing every access to incomplete
>>>> worktrees like this. If this is because of racy 'worktree add', then
>>>> perhaps a better solution is make it absolutely clear it's not ready
>>>> for anybody to access.
>>>>
>>>> For example, we can suffix the worktree directory name with ".lock"
>>>> and make sure get_worktrees() ignores entries ending with ".lock".
>>>> That should protect other commands while 'worktree add' is still
>>>> running. Only when the worktree is complete that 'worktree add' should
>>>> rename the directory to lose ".lock" and run external commands like
>>>> git-checkout to populate the worktree.
>>>
>>> The problem is we don't forbid worktree names ending with ".lock".
>>> Which means that if we start to forbid them now existing worktrees
>>> might become inaccessible.
>>
>> I think it is also racy as the renaming breaks the use of mkdir erroring
>> out if the directory already exists.
> 
> You mean the part where we see "fred" exists and decide to try the
> name "fred1" instead (i.e. patch 1/2)?
> 
> I don't think it's the problem if that's the case. We mkdir
> "fred.lock" _then_ check if "fred" exists. If it does, remove
> fred.lock and move on to fred1.lock. Then we rename fred1.lock to
> fred1 and error out if rename fails.

Ah you're right, if another process tries to create fred.lock as we're 
renaming it either their mkdir fred.lock will fail or they'll see fred 
once they've made fred.lock

Sorry for the confusion

Phillip
