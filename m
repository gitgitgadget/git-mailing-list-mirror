Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F88220305
	for <e@80x24.org>; Sun, 21 Apr 2019 21:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfDUVSD (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 17:18:03 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51067 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbfDUVSD (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 21 Apr 2019 17:18:03 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 17ED221AC2;
        Sun, 21 Apr 2019 17:18:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sun, 21 Apr 2019 17:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        reply-to:subject:from:to:cc:references:message-id:date
        :mime-version:in-reply-to:content-type
        :content-transfer-encoding; s=fm2; bh=ip+YomYUZMofs3i0+rmPsfBzQw
        c1aDq9ad5L9qV0Tzk=; b=EdyxBzarnMu63kyoPqqiJSUtSyEoJ9NgTFYs8Uc/xW
        rQF5PLW6HTltZks5d0ZvUSY3g3oG68AB0pY87ShhYLd/gMDHXMdA6ztgG81noSiE
        uXoxrcHNYiMAIOaipa3g4OrX7+sZcl7nRaFfWl/JJK2I0eDVsMF5FOlfYpkUCPgZ
        8jTDqhTt3U7t/9lqDDLQOyBD42O4EAQyaK0zWuuPeJ04+TTDNQ7VQ788yLtq3GiF
        qDm3gsnhCl1madIrZR/t9IP1t3YFwNc18jBVatxxcvyAK/grInT3FWL/2GTemewd
        uLPyG4msfIzT1rhPQ9udZ6XaRCEonbBxbZg/P9R++o8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=ip+YomYUZMofs3i0+rmPsfBzQwc1a
        Dq9ad5L9qV0Tzk=; b=6cc52q8FtH1aIAHYKhqQsZRpvO9LMkSd+RqTMJ2fDPetb
        Ab1gT0TKM2YeYKTRTtB9u1kw1VNeMCGCIcRflXcgjz4s6e8u3F4b+AGYLtctsqrG
        QQTMlM8APHkjuVyZg9oCI8pRlMX87ATjkCSnkSJeLPirxYbLD+fkWjLa+0GE+R0f
        SrSlQM649m+jFYYDKdlxKd4cQ1/qJC4qr9yKCa7exCyJR5i1jRVb5lEywKJZbL+h
        qsqiHy5ePLMouCZgADq7PWonnpm4MQN0OZDJMZ3ooF0dS5SpXNrsulmxNGk9+M2c
        XOmS+9dkAyZD9goTG+3KNdXh6OXivL42hrsekkwSg==
X-ME-Sender: <xms:Cd68XLnqFEbzrgLZTktG-SyVqjJMT2wpb6_oc77mrW1sfsPcPxufNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrgeeggddufeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheprhfuhffvfhfkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpehrohgs
    uceoughrrhhosgdutddtsehfrghsthhmrghilhdrtghomheqnecuffhomhgrihhnpehgih
    hthhhusgdrtghomhenucfkphepjedvrdekledrleeirddukeeknecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegurhhrohgsuddttdesfhgrshhtmhgrihhlrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptd
X-ME-Proxy: <xmx:Cd68XJY0QOAcRYUmr_rAktVPVABys3igIwW--4SsTGVzJhs-upMAyw>
    <xmx:Cd68XOM1_ZGT97NRW5jqlbssIxsP6yUH8fprT3fep0q3gq49iNMUdg>
    <xmx:Cd68XGYZv9sj-VYuzYHc5rqcoJiOrAx5awRISpjPCNfDHbAlWC4Uhw>
    <xmx:Ct68XKrv8Dgi0gmWqFcw-5FEH08_uMHxIbh6qI_LGOjun8wO-tgCEQ>
Received: from [192.168.1.153] (pool-72-89-96-188.nycmny.fios.verizon.net [72.89.96.188])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0F469E44B4;
        Sun, 21 Apr 2019 17:18:01 -0400 (EDT)
Reply-To: rob@drrob1.com
Subject: Re: I messed up my own git tree and I don't know how to fix it.
From:   rob <drrob100@fastmail.com>
To:     Philip Oakley <philipoakley@iee.org>, rob@drrob1.com,
        Adrian H <adrianh.bsc@gmail.com>
Cc:     git@vger.kernel.org
References: <cb1f725f-1314-d320-104a-726ef1c906fa@fastmail.com>
 <CAP_kE8XaFW=G1f_qrS2sEp+ELQ9otk=j0-ZtbF1dATQX8ZjrAA@mail.gmail.com>
 <b0a8d228-78c5-a355-1ded-dc2904d8216e@fastmail.com>
 <4b388e60-703d-8ac3-ef74-211924374249@iee.org>
 <b05fee72-5536-65d5-1237-f4e5c83db9e8@fastmail.com>
 <2f3dc6f3-cd6a-7079-d81f-66c101c98a64@iee.org>
 <6811c1cf-201c-3881-9d46-533d251ba3ce@fastmail.com>
Message-ID: <6c98c228-2587-bf69-454b-83199a434014@fastmail.com>
Date:   Sun, 21 Apr 2019 17:18:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6811c1cf-201c-3881-9d46-533d251ba3ce@fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I got it to do what I want.  I have alias nuke='rm -rfv'

So I did

     nuke github.com/alecthomas/gometalinter (modified content)

     nuke github.com/kisielk/errcheck (modified content)

     nuke github.com/rogpeppe/godef (modified content)

     git rm github.com/alecthomas/gometalinter (modified content)

     git rm github.com/kisielk/errcheck (modified content)

     git rm github.com/rogpeppe/godef (modified content)

     git commit the rm operation.

     go get github.com/alecthomas/gometalinter (modified content)

     go get github.com/kisielk/errcheck (modified content)

     go get github.com/rogpeppe/godef (modified content)

     git add these, then git commit.

And my directories are clean when I git status them.

I could not figure out anything else to do.

--rob

On 4/21/19 2:53 PM, rob wrote:
> I did
>
>   git config --global core.trustctime false
>
>   git config --global core.checkStat minimal
>
> No difference
>
> -rob
>
> On 4/21/19 1:22 PM, Philip Oakley wrote:
>> On 21/04/2019 18:07, rob wrote:
>>> possibly. What do I do about that?
>>>
>>> --rob
>>>
>> see below.
>>>
>>> On 4/21/19 9:03 AM, Philip Oakley wrote:
>>>> Hi Rob,
>>>>
>>>> On 21/04/2019 13:34, rob wrote:
>>>>> didn't work.  I did not get any error messages, just didn't work.  
>>>>> After I did
>>>>>
>>>>>   git reset --hard
>>>>>
>>>>>   git status
>>>>>
>>>>> I see the same 3 files that say changes not staged for commit: 
>>>>> modified and it lists the same 3 files.
>>>> Could this be that the file timestamps are being changed in the 
>>>> background and git is detecting those timestamp changes, even when 
>>>> there is no change to the files.
>>>> - Just as thought.
>>>>
>>>> (In-line posting is preferred, so as to see the replies in context)
>>>> Philip
>>>>
>> If it is that, Try
>> core.trustctime::
>>     If false, the ctime differences between the index and the
>>     working tree are ignored; useful when the inode change time
>>     is regularly modified by something outside Git (file system
>>     crawlers and some backup systems).
>>     See linkgit:git-update-index[1]. True by default.
>>
>> Or,
>> core.checkStat::
>>     When missing or is set to `default`, many fields in the stat
>>     structure are checked to detect if a file has been modified
>>     since Git looked at it.  When this configuration variable is
>>     set to `minimal`, sub-second part of mtime and ctime, the
>>     uid and gid of the owner of the file, the inode number (and
>>     the device number, if Git was compiled to use it), are
>>     excluded from the check among these fields, leaving only the
>>     whole-second part of mtime (and ctime, if `core.trustCtime`
>>     is set) and the filesize to be checked.
>>>>>
>>>>> --rob
>>>>>
>>>>>
>>>>> On 4/21/19 1:03 AM, Adrian H wrote:
>>>>>> If I understand the commands you are using correctly, you are
>>>>>> referencing the remote repo.  You need to reference the local repo.
>>>>>> So try using the following commands:
>>>>>>
>>>>>> git checkout -- alecthomas/gometalinter
>>>>>> git checkout -- kisielk/errcheck
>>>>>> git checkout -- rogpeppe/godef
>>>>>>
>>>>>> Or if those are the only files that have been modified, then you can
>>>>>> use the following single command:
>>>>>>
>>>>>> git reset --hard
>>>>>>
>>>>>> and that will reset all files that have not been staged.
>>>>>>
>>>>>> HTH
>>>>>>
>>>>>>
>>>>>> A
>>>>>>
>>>>>>
>>>>>> On Sat, Apr 20, 2019 at 11:22 PM rob <drrob100@fastmail.com> wrote:
>>>>>>> I have my own code at a github repository, using Go.  Part of 
>>>>>>> using Go
>>>>>>> libraries not part of the official Go people is by using a 
>>>>>>> system they
>>>>>>> call go get.  This essentially uses git to, well, go get source 
>>>>>>> code.
>>>>>>> Mine are at github.com and golang.org.  My computer runs 
>>>>>>> LinuxMint 19.1.
>>>>>>>
>>>>>>> I used goland IDE from jetbrains to run go fmt on my entire 
>>>>>>> project.
>>>>>>> Now I am getting this message that I cannot get rid of:
>>>>>>>
>>>>>>> changes not staged for commit:
>>>>>>>
>>>>>>>     modified: github.com/alecthomas/gometalinter (modified content)
>>>>>>>
>>>>>>>     modified: github.com/kisielk/errcheck (modified content)
>>>>>>>
>>>>>>>     modified: github.com/rogpeppe/godef (modified content)
>>>>>>>
>>>>>>>
>>>>>>> I do not want any changes to central repos to be tracked or 
>>>>>>> committed,
>>>>>>> but I cannot undo this.  I tried, for example,
>>>>>>>
>>>>>>> git checkout -- github.com/alecthomas/gometalinter
>>>>>>>
>>>>>>> I don't get an error message but it does not do anything. The 
>>>>>>> file is
>>>>>>> not changes, and git status show me the same information, ie, these
>>>>>>> files have changes not staged for commit.
>>>>>>>
>>>>>>> I do not know how to restore these files to the state they were 
>>>>>>> in in
>>>>>>> the repo, and to have my own git tree not to flag this as an 
>>>>>>> unstaged
>>>>>>> alteration.  Running rm -rfv on the repos on my computer, then 
>>>>>>> running
>>>>>>> go get to restore them does not change git status. It still sahs 
>>>>>>> changes
>>>>>>> not stated for commit: modified.
>>>>>>>
>>>>>>> This happens for the above 3 tree items.
>>>>>>>
>>>>>>> How do I restore these to the github remote repository condition 
>>>>>>> and not
>>>>>>> have my own git tree mark these as changed?
>>>>>>>
>>>>>>> --rob solomon
>>>>>>>
>>>>>>
>>>>
>>
