Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F3AC20248
	for <e@80x24.org>; Sun, 21 Apr 2019 18:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfDUSxO (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 14:53:14 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53909 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725767AbfDUSxO (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 21 Apr 2019 14:53:14 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 25D0921AF2;
        Sun, 21 Apr 2019 14:53:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sun, 21 Apr 2019 14:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        reply-to:subject:to:cc:references:from:message-id:date
        :mime-version:in-reply-to:content-type
        :content-transfer-encoding; s=fm2; bh=1AQGGGR09uq9PPCDkV02CGA/lY
        oHTQHvCrlKIrHmUIY=; b=q6LBoN/C7ms+Jbbjq3uPTaqIHDBow6774G+2XpCL33
        wM2CucdUVZntOdnQa8F6HpUMdsvXNMDxof2VqOypA40dMC8W3tyxdt1MhGDXQYIa
        /pR5ounzakTORGJv9BTepycHpGfw6G3O/Upu7mog92aGFTqNJmTbhT27wZKFeew8
        rLzY9bFHfveBsS00KXyLfeCur0lo1bbbioaaAMatnV53hhJkxMfMkdhmUgPQQjQI
        z+8wHrB1x7qflYCtJorEgRTKp1pnzBZIxV9xmMwN8adkArxro0H5UlDbCQWD6NhW
        nS++4wFmznQXv0gvMvkkMzl218Zs3oWRG5CtLOVjpb9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=1AQGGGR09uq9PPCDkV02CGA/lYoHT
        QHvCrlKIrHmUIY=; b=X7Tr1yie31Gp/VMbn7mTyzueRodNLjaJWDtZUH15zbey5
        A6ShwDiZ/uekt6DUdtDfDc0KpO+Z4UrJhFfBJ+dIuVNkxGWhlvej+DEgbD5IEcDK
        AcxsDnSrlhXVDfYhWjDfvLLPoq2TH28KGbUaAyit9RPOx47HVhFnbnpnFC9UcsIv
        NDIgfDy36zrDvUXYirljeGj7YR8v2pjClTeYahdC4tgNuqP66WwxfbvPr3dnVQff
        LIZ03YUG3loRy2ek9ohdraLUtsVn5O+M0fZiyPCEOzya7CQFlbxL56cK/qaK3WE2
        xs3kLob6HeJu9wcEduCcUpRHMPOZL1zeJuv2uL06A==
X-ME-Sender: <xms:GLy8XBNQIdlCPm3SzOTw7Hegof7Yf_UzakAr8rkHwn2UgbScZvmpjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrgeeggddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheprhfuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpehrohgs
    uceoughrrhhosgdutddtsehfrghsthhmrghilhdrtghomheqnecuffhomhgrihhnpehgih
    hthhhusgdrtghomhenucfkphepjedvrdekledrleeirddukeeknecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegurhhrohgsuddttdesfhgrshhtmhgrihhlrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptd
X-ME-Proxy: <xmx:GLy8XPJno3zgEUUftjrMH0jCZz_RepJQrQIkCh17-Ct94rJ_ASYvfQ>
    <xmx:GLy8XEEsR8wjoDoRgfRyOc3GgkBu4WWwpdI5mcqwF0Lt3PCWfeN4MA>
    <xmx:GLy8XIBDqfRuitqs7zDWOCwVoTtyuWznunDkWH46BKQLM7g8Ur1Qsg>
    <xmx:Gby8XPkXtL5rLKAP8OeGHovKK8jVmdipSb8ejkiK8lZYHL9jWZ056g>
Received: from [192.168.1.153] (pool-72-89-96-188.nycmny.fios.verizon.net [72.89.96.188])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8F9C4E43A3;
        Sun, 21 Apr 2019 14:53:12 -0400 (EDT)
Reply-To: rob@drrob1.com
Subject: Re: I messed up my own git tree and I don't know how to fix it.
To:     Philip Oakley <philipoakley@iee.org>, rob@drrob1.com,
        Adrian H <adrianh.bsc@gmail.com>
Cc:     git@vger.kernel.org
References: <cb1f725f-1314-d320-104a-726ef1c906fa@fastmail.com>
 <CAP_kE8XaFW=G1f_qrS2sEp+ELQ9otk=j0-ZtbF1dATQX8ZjrAA@mail.gmail.com>
 <b0a8d228-78c5-a355-1ded-dc2904d8216e@fastmail.com>
 <4b388e60-703d-8ac3-ef74-211924374249@iee.org>
 <b05fee72-5536-65d5-1237-f4e5c83db9e8@fastmail.com>
 <2f3dc6f3-cd6a-7079-d81f-66c101c98a64@iee.org>
From:   rob <drrob100@fastmail.com>
Message-ID: <6811c1cf-201c-3881-9d46-533d251ba3ce@fastmail.com>
Date:   Sun, 21 Apr 2019 14:53:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <2f3dc6f3-cd6a-7079-d81f-66c101c98a64@iee.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I did

   git config --global core.trustctime false

   git config --global core.checkStat minimal

No difference

-rob

On 4/21/19 1:22 PM, Philip Oakley wrote:
> On 21/04/2019 18:07, rob wrote:
>> possibly. What do I do about that?
>>
>> --rob
>>
> see below.
>>
>> On 4/21/19 9:03 AM, Philip Oakley wrote:
>>> Hi Rob,
>>>
>>> On 21/04/2019 13:34, rob wrote:
>>>> didn't work.  I did not get any error messages, just didn't work.  
>>>> After I did
>>>>
>>>>   git reset --hard
>>>>
>>>>   git status
>>>>
>>>> I see the same 3 files that say changes not staged for commit: 
>>>> modified and it lists the same 3 files.
>>> Could this be that the file timestamps are being changed in the 
>>> background and git is detecting those timestamp changes, even when 
>>> there is no change to the files.
>>> - Just as thought.
>>>
>>> (In-line posting is preferred, so as to see the replies in context)
>>> Philip
>>>
> If it is that, Try
> core.trustctime::
>     If false, the ctime differences between the index and the
>     working tree are ignored; useful when the inode change time
>     is regularly modified by something outside Git (file system
>     crawlers and some backup systems).
>     See linkgit:git-update-index[1]. True by default.
>
> Or,
> core.checkStat::
>     When missing or is set to `default`, many fields in the stat
>     structure are checked to detect if a file has been modified
>     since Git looked at it.  When this configuration variable is
>     set to `minimal`, sub-second part of mtime and ctime, the
>     uid and gid of the owner of the file, the inode number (and
>     the device number, if Git was compiled to use it), are
>     excluded from the check among these fields, leaving only the
>     whole-second part of mtime (and ctime, if `core.trustCtime`
>     is set) and the filesize to be checked.
>>>>
>>>> --rob
>>>>
>>>>
>>>> On 4/21/19 1:03 AM, Adrian H wrote:
>>>>> If I understand the commands you are using correctly, you are
>>>>> referencing the remote repo.  You need to reference the local repo.
>>>>> So try using the following commands:
>>>>>
>>>>> git checkout -- alecthomas/gometalinter
>>>>> git checkout -- kisielk/errcheck
>>>>> git checkout -- rogpeppe/godef
>>>>>
>>>>> Or if those are the only files that have been modified, then you can
>>>>> use the following single command:
>>>>>
>>>>> git reset --hard
>>>>>
>>>>> and that will reset all files that have not been staged.
>>>>>
>>>>> HTH
>>>>>
>>>>>
>>>>> A
>>>>>
>>>>>
>>>>> On Sat, Apr 20, 2019 at 11:22 PM rob <drrob100@fastmail.com> wrote:
>>>>>> I have my own code at a github repository, using Go.  Part of 
>>>>>> using Go
>>>>>> libraries not part of the official Go people is by using a system 
>>>>>> they
>>>>>> call go get.  This essentially uses git to, well, go get source 
>>>>>> code.
>>>>>> Mine are at github.com and golang.org.  My computer runs 
>>>>>> LinuxMint 19.1.
>>>>>>
>>>>>> I used goland IDE from jetbrains to run go fmt on my entire project.
>>>>>> Now I am getting this message that I cannot get rid of:
>>>>>>
>>>>>> changes not staged for commit:
>>>>>>
>>>>>>     modified: github.com/alecthomas/gometalinter (modified content)
>>>>>>
>>>>>>     modified: github.com/kisielk/errcheck (modified content)
>>>>>>
>>>>>>     modified: github.com/rogpeppe/godef (modified content)
>>>>>>
>>>>>>
>>>>>> I do not want any changes to central repos to be tracked or 
>>>>>> committed,
>>>>>> but I cannot undo this.  I tried, for example,
>>>>>>
>>>>>> git checkout -- github.com/alecthomas/gometalinter
>>>>>>
>>>>>> I don't get an error message but it does not do anything. The 
>>>>>> file is
>>>>>> not changes, and git status show me the same information, ie, these
>>>>>> files have changes not staged for commit.
>>>>>>
>>>>>> I do not know how to restore these files to the state they were 
>>>>>> in in
>>>>>> the repo, and to have my own git tree not to flag this as an 
>>>>>> unstaged
>>>>>> alteration.  Running rm -rfv on the repos on my computer, then 
>>>>>> running
>>>>>> go get to restore them does not change git status. It still sahs 
>>>>>> changes
>>>>>> not stated for commit: modified.
>>>>>>
>>>>>> This happens for the above 3 tree items.
>>>>>>
>>>>>> How do I restore these to the github remote repository condition 
>>>>>> and not
>>>>>> have my own git tree mark these as changed?
>>>>>>
>>>>>> --rob solomon
>>>>>>
>>>>>
>>>
>
