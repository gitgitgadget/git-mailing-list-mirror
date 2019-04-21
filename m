Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A2C120248
	for <e@80x24.org>; Sun, 21 Apr 2019 17:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfDURHR (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 13:07:17 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56277 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727228AbfDURHQ (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 21 Apr 2019 13:07:16 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id A98C321A7B;
        Sun, 21 Apr 2019 13:07:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sun, 21 Apr 2019 13:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        reply-to:subject:to:cc:references:from:message-id:date
        :mime-version:in-reply-to:content-type
        :content-transfer-encoding; s=fm2; bh=+cKZP+A4ceUQjmVmPp7ZbBZ4R/
        9trlNqCUBGXPel4Hc=; b=XpNlRcI8qqkoTiNAn5lsUldQrhXLn6u3IFKtd+H02O
        bm59zjl3Ptl7tWCpu40zBavI/Z9tF/yIBcu8Bd+wRuBwPeK1P5CTKOktSAHl4G+v
        kNHGEqXYWdN5HP2rqkRgfiI8IfsJSoM8FcUSNYcoNXxbrH4brY1r/rXuGMvTHOh0
        9sj0t/IqyOuqMxTOPVfm4HdOOSVe09VjsFo5P0y4m38BGYUPcB3VMprWw8WMKk5c
        2Pxcc3KyhoWN8XEytliD0u82lHD6D7LoDjxD3dhBoXYU51yTjZzcIr0It87vPN3H
        yRs5acy5uNkVeW217Q0THrlHp7LmBM4EqR5d3byHxrgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=+cKZP+A4ceUQjmVmPp7ZbBZ4R/9tr
        lNqCUBGXPel4Hc=; b=W8yziGwpt0zda2csgoIjUQ8ktk6Pwjl1ymmL1xbRC+r/H
        L7YSm1toJfGsYEeEl67ZU2BiB4EuW7Fle/Ur5BSQh6/XDyEJliYgOIH1L/uKwqB+
        51PdzgVFfAQpTIVqH7RanVKYCXmOiRt7dSBO51TmJld7NvHu1njDD67dAUH0+Foo
        ca2CEIocu+ZuQD6lmo2VtlVIDDhCUgpPN1a07gPj4CV8qw2p4vfJMMPU+WIoq8hP
        QC1fUAerKNw6/8rdwGnW2o5OLuhb7W9JOr0NQXczSE/lroJOMMpOTLUYrVZyHE4r
        9NFCcE8xcuNgxoaehp4CrRAWNmMIoutWbmwvuOvtg==
X-ME-Sender: <xms:Q6O8XCiPXE-Y-zFPHpxVJ_a1gpENsau0hIQWiGMBqNpculr8oaBAlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrgeeggdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpehruffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomheprhhosgcu
    oegurhhrohgsuddttdesfhgrshhtmhgrihhlrdgtohhmqeenucffohhmrghinhepghhith
    hhuhgsrdgtohhmnecukfhppeejvddrkeelrdeliedrudekkeenucfrrghrrghmpehmrghi
    lhhfrhhomhepughrrhhosgdutddtsehfrghsthhmrghilhdrtghomhenucevlhhushhtvg
    hrufhiiigvpedt
X-ME-Proxy: <xmx:Q6O8XEWVuDnCEG1cYHRqhAPyZGYgRO1PL9hkRuaM0pTm7H-Y8Z9wFg>
    <xmx:Q6O8XOuQfnZo5u2tUn2aZkwIqR_up465HmBl1raQLPdVD7qHpVTajw>
    <xmx:Q6O8XN99djdkH8__ud9g8w7GZ8yR7dJdeJxQTs3dQ5ZOiCUsBNLJOQ>
    <xmx:Q6O8XAaUZ4qKiZbfI-jhJeXn0fxC2PZik8HJCAcHRU_2C_CwNaodPw>
Received: from [192.168.1.153] (pool-72-89-96-188.nycmny.fios.verizon.net [72.89.96.188])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1C131E432B;
        Sun, 21 Apr 2019 13:07:15 -0400 (EDT)
Reply-To: rob@drrob1.com
Subject: Re: I messed up my own git tree and I don't know how to fix it.
To:     Philip Oakley <philipoakley@iee.org>, rob@drrob1.com,
        Adrian H <adrianh.bsc@gmail.com>
Cc:     git@vger.kernel.org
References: <cb1f725f-1314-d320-104a-726ef1c906fa@fastmail.com>
 <CAP_kE8XaFW=G1f_qrS2sEp+ELQ9otk=j0-ZtbF1dATQX8ZjrAA@mail.gmail.com>
 <b0a8d228-78c5-a355-1ded-dc2904d8216e@fastmail.com>
 <4b388e60-703d-8ac3-ef74-211924374249@iee.org>
From:   rob <drrob100@fastmail.com>
Message-ID: <b05fee72-5536-65d5-1237-f4e5c83db9e8@fastmail.com>
Date:   Sun, 21 Apr 2019 13:07:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4b388e60-703d-8ac3-ef74-211924374249@iee.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

possibly.  What do I do about that?

--rob


On 4/21/19 9:03 AM, Philip Oakley wrote:
> Hi Rob,
>
> On 21/04/2019 13:34, rob wrote:
>> didn't work.  I did not get any error messages, just didn't work.  
>> After I did
>>
>>   git reset --hard
>>
>>   git status
>>
>> I see the same 3 files that say changes not staged for commit: 
>> modified and it lists the same 3 files.
> Could this be that the file timestamps are being changed in the 
> background and git is detecting those timestamp changes, even when 
> there is no change to the files.
> - Just as thought.
>
> (In-line posting is preferred, so as to see the replies in context)
> Philip
>
>>
>> --rob
>>
>>
>> On 4/21/19 1:03 AM, Adrian H wrote:
>>> If I understand the commands you are using correctly, you are
>>> referencing the remote repo.  You need to reference the local repo.
>>> So try using the following commands:
>>>
>>> git checkout -- alecthomas/gometalinter
>>> git checkout -- kisielk/errcheck
>>> git checkout -- rogpeppe/godef
>>>
>>> Or if those are the only files that have been modified, then you can
>>> use the following single command:
>>>
>>> git reset --hard
>>>
>>> and that will reset all files that have not been staged.
>>>
>>> HTH
>>>
>>>
>>> A
>>>
>>>
>>> On Sat, Apr 20, 2019 at 11:22 PM rob <drrob100@fastmail.com> wrote:
>>>> I have my own code at a github repository, using Go.  Part of using Go
>>>> libraries not part of the official Go people is by using a system they
>>>> call go get.  This essentially uses git to, well, go get source code.
>>>> Mine are at github.com and golang.org.  My computer runs LinuxMint 
>>>> 19.1.
>>>>
>>>> I used goland IDE from jetbrains to run go fmt on my entire project.
>>>> Now I am getting this message that I cannot get rid of:
>>>>
>>>> changes not staged for commit:
>>>>
>>>>     modified: github.com/alecthomas/gometalinter (modified content)
>>>>
>>>>     modified: github.com/kisielk/errcheck (modified content)
>>>>
>>>>     modified: github.com/rogpeppe/godef (modified content)
>>>>
>>>>
>>>> I do not want any changes to central repos to be tracked or committed,
>>>> but I cannot undo this.  I tried, for example,
>>>>
>>>> git checkout -- github.com/alecthomas/gometalinter
>>>>
>>>> I don't get an error message but it does not do anything. The file is
>>>> not changes, and git status show me the same information, ie, these
>>>> files have changes not staged for commit.
>>>>
>>>> I do not know how to restore these files to the state they were in in
>>>> the repo, and to have my own git tree not to flag this as an unstaged
>>>> alteration.  Running rm -rfv on the repos on my computer, then running
>>>> go get to restore them does not change git status. It still sahs 
>>>> changes
>>>> not stated for commit: modified.
>>>>
>>>> This happens for the above 3 tree items.
>>>>
>>>> How do I restore these to the github remote repository condition 
>>>> and not
>>>> have my own git tree mark these as changed?
>>>>
>>>> --rob solomon
>>>>
>>>
>
