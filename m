Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9C3C636C9
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 01:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B30E61106
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 01:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhGPBr7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 21:47:59 -0400
Received: from avasout01.plus.net ([84.93.230.227]:51095 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhGPBr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 21:47:58 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Jul 2021 21:47:58 EDT
Received: from [10.0.2.15] ([147.147.167.4])
        by smtp with ESMTPA
        id 4CnDmJTXz7w2v4CnEmnuWm; Fri, 16 Jul 2021 02:37:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1626399453; bh=vlPls3LrrkbIQf8PeDMhPcjTGY5lG6diR8hoIkmE7Tc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Xnf8Wq+OA3wWor1WkmtBpBzMINLEP/8JU5IwlBeKd3cmqctX86sFhSGnmTI/I/rfR
         O5MlFcF/qBs21J6o4eqg7VYyuF/BL9wimmh3lPLuaA/BGimBehVG7qpV8muzI2weVf
         Dhatw+pnPeYdSGUl0qb76zmsHPo4tl6C5FwMgUVtVeSJ9jp6kOEK1ehJKHV16lv8CT
         yIwk+7L9z7VjZjEL6S9GmH7FZn7LgkSVg4oj11OsoaVR3voU51XuU38N93O4L9u60u
         EqmGmAmxGkRxK+HmuIUdL3xhIueP4L/70jqCAgbBmmzE2WlVR+UbhccFAPuJpmnOcP
         T+8l2mSyEvIAw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=YueUu7QX c=1 sm=1 tr=0
 a=ClpcMUpIpdFe3QrT4g3KPA==:117 a=ClpcMUpIpdFe3QrT4g3KPA==:17
 a=IkcTkHD0fZMA:10 a=Tt7qhPXtbgV_Vxr34DoA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] ci: run `make sparse` as a GitHub workflow
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
References: <pull.994.git.1626177086682.gitgitgadget@gmail.com>
 <f305f586-c3ac-a2ef-8769-5468a4c3e539@gmail.com>
 <nycvar.QRO.7.76.6.2107141052350.76@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2107141212140.76@tvgsbejvaqbjf.bet>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <aeecbcf6-eab8-54d4-9654-b5b2e1e1ea23@ramsayjones.plus.com>
Date:   Fri, 16 Jul 2021 02:37:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2107141212140.76@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHWqc3eMWYxEf4wLoXXfRUKlzYxbrRA5m+btycOPHuybNixP1rLyUzqo7KZBE8w90ugoVAviH8b084CJWENH95ZtVKkwNShGSGC+6TWwzj2c6Csg+uO4
 UN3HAU6xPwpLLAbIf4IQe5tdGM5hVb5gPkdQeET5Zqx9+S7x0OtxL6x8Z1MYlE2veFYoKV4Ozb1vDA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 14/07/2021 11:13, Johannes Schindelin wrote:
> Hi again,
> 
> On Wed, 14 Jul 2021, Johannes Schindelin wrote:
> 
>> On Tue, 13 Jul 2021, Philippe Blain wrote:
>>
>>> Le 2021-07-13 à 07:51, Johannes Schindelin via GitGitGadget a écrit :
>>>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>>>
>>>> [...]
>>>> +    - name: Download the `sparse` package
>>>> +      uses: git-for-windows/get-azure-pipelines-artifact@v0
>>>> +      with:
>>>> +        repository: git/git
>>>> +        definitionId: 10
>>>> +        artifact: sparse-20.04
>>>> +    - name: Install the `sparse` package
>>>> +      run: sudo dpkg -i sparse-20.04/sparse_*.deb
>>>
>>> Out of curiosity, why is this necessary (as opposed to using
>>> the Ubuntu package, i.e. 'sudo apt-get -q -y sparse') ?
>>
>> This is actually a historical curiosity: years ago, I created an Azure
>> Pipeline that builds the `sparse` Debian package for the specific purpose
>> of using it in our CI builds (if you care to look at the issue 345 I
>> linked above, you will see how long ago that idea was in the making). Now,
>> the historical curiosity is that back then, there was no current `sparse`
>> package available for Ubuntu, and Ramsay mentioned that a newer version
>> would be required to run `make sparse`.
>>
>> And when I implemented this patch yesterday, I did not even question this,
>> I was just happy that I had come up with the GitHub Action
>> `get-azure-pipelines-artifact` (to help with the `vcpkg` part of our CI
>> builds).
>>
>> I was already writing a detailed paragraph in the commit message to
>> explain all that when it occurred to me that two years might make a big
>> difference and an up to date `sparse` might be available. And lo and
>> behold, this is the case!
>>
>> Therefore, v2 will no longer jump through that hoop.
> 
> *Never mind*
> 
> I made a mistake in testing, and Ubuntu-20.04's `sparse` package _is too
> old_. So I will reintroduce that hoop even before sending v2.

Yes, last time I looked, 20.04's version of sparse was 0.6.1-2build1,
20.10 had 0.6.2-2 (both of which are too old), but 21.04, along with
Debian Testing, had 0.6.3-1 which would work fine.

[I am currently running v0.6.3-341-g8af24329]

So, maybe the next Ubuntu LTS, ... :-D

ATB,
Ramsay Jones

