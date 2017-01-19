Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A33920A17
	for <e@80x24.org>; Thu, 19 Jan 2017 23:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752835AbdASXMu (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 18:12:50 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:35875 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752420AbdASXMt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 18:12:49 -0500
Received: by mail-io0-f195.google.com with SMTP id q20so6568292ioi.3
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 15:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=KdLYn15QaylM/jQTxEWo5NKfCyxvRlBVn6C7QB13+7o=;
        b=H+Fv6KsM65uX+dfyBaZrWTSydvkrBewsxKv4AP+6Q7Ot3eSX750bRBtPNNsOoAXoFR
         cjAG5uayexWgR8d8aPjHQxdBxU4HjV63uw9pocUSbTdvCWDHkLHW2e8QuEk2CTtPoI9q
         x/SF/ECxL+TUcRcwBkcKezgh7h4SABJk4Kr9lR4JQD80G4UJ3YPb7doOSXeMqh9MdFn8
         AtxCcFhdIaqVIJYR1GwYMt7Yb1+AYH6/Zv1SdcNDjc+QzafNVz67ZYINAUAHPdGHVCiA
         RvLHGqdwJBuosLMzKb8xT8q/1bTQs17G2uurQzRII0ao5Fx6rNBP/koeMNxL2bcHp7b5
         9vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=KdLYn15QaylM/jQTxEWo5NKfCyxvRlBVn6C7QB13+7o=;
        b=eBybWp7gwkZa0i11uqdcGaXW4sL09x+0gkELVwWAOe4O1GKDi1ThIericHLnMM0iJH
         F+W6Zj3RKGqARcDRojr53bOCRRzedQOTGKRk52gWwO2+tizFrJm6KeIujAtlODjihL2t
         wyLw//gtDz33tzNJ1zVQysuj1yWq/NBT/athVoDNT0C9kL+1yMj80qrHbNVcaUNelwIV
         A7MLdmN2eXm7SVSLrqArv5xVz27l+kFp1Yn4gzJVc1DhSI3hMga5SLDhrC3/+6m5URB4
         F5tgoEvKAfkm/AEm621746aMpSf1ErAUK1hD1RPJPHHjL/Tw5v6hxwQd5BrF98SJCYoy
         p9Tg==
X-Gm-Message-State: AIkVDXLAJoBvH0z+btqW6h5XrgkioBcDfrIx18v9VhdNHz4Ogtnkh+2RxwDAwnbldGiUVQ==
X-Received: by 10.107.7.78 with SMTP id 75mr12259022ioh.165.1484867106522;
        Thu, 19 Jan 2017 15:05:06 -0800 (PST)
Received: from [192.168.1.190] (h69-129-206-25.mdsnwi.broadband.dynamic.tds.net. [69.129.206.25])
        by smtp.gmail.com with ESMTPSA id l74sm351997ita.15.2017.01.19.15.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jan 2017 15:05:05 -0800 (PST)
Subject: Re: submodule network operations [WAS: Re: [RFC/PATCH 0/4] working
 tree operations: support superprefix]
To:     Stefan Beller <sbeller@google.com>
References: <CAGZ79kZRV7x9B6SHRcHjJweHrjURxWKmN-=Wz_aNw2TPwYh_xw@mail.gmail.com>
 <ebf6c90e-044f-5538-2325-601d002a81fe@gmail.com>
 <CAGZ79kaf0BhbnJGhkjT_Ys44y4c4AaxV8U_ydWp4bbFMkGRcsQ@mail.gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        David Turner <novalis@novalis.org>
From:   "Brian J. Davis" <bitminer@gmail.com>
Message-ID: <e6c5567a-2032-c598-97c8-08518f86b611@gmail.com>
Date:   Thu, 19 Jan 2017 17:11:53 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kaf0BhbnJGhkjT_Ys44y4c4AaxV8U_ydWp4bbFMkGRcsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 1/17/2017 12:43 PM, Stefan Beller wrote:
> On Sun, Jan 15, 2017 at 1:02 PM, Brian J. Davis <bitminer@gmail.com> wrote:
>
>>> Technically it is submodule.<name>.url instead of
>>> submodule.<path>.url. The name is usually the path initially, and once
>>> you move the submodule, only the path changes, the name is supposed to
>>> be constant and stay the same.
>> I am not certain what is meant by this.  All I know is I can use my
>> "directory_to_checkout" above to place in tree relative from root the
>> project any where in the tree not already tracked by git.  You state name
>> instead of path, but it allows path correct? Either that or I have gone off
>> reservation with my use of git for years now. Maybe this is a deviation from
>> how it is documented/should work and how it actually works?  It works great
>> how I use it.
> Yes name can equal the path (and usually does). This is a minor detail
> that is only relevant for renaming submodules, so ... maybe let's not
> focus on it too much. :)
>
>>>>
>>>> but if say I want to pull from some server 2 and do a
>>>>
>>>> git submodule update --init --recursive
>>> That is why the "git submodule init" exists at all.
>>>
>>>       git submodule init
>>>       $EDIT .git/config # change submodule.<name>.url to server2
>>>       git submodule update # that uses the adapted url and
>>>       # creates the submodule repository.
>>>
>>>       # From now on the submodule is on its own.
>>>       cd <submodule> && git config --list
>>>       # prints an "origin" remote and a lot more
>>>
>>> For a better explanation, I started a documentation series, see
>>>
>>> https://github.com/gitster/git/commit/e2b51b9df618ceeff7c4ec044e20f5ce9a87241e
>>>
>>> (It is not finished, but that is supposed to explain this exact pain
>>> point in the
>>> STATES section, feel free to point out missing things or what is hard
>>> to understand)
>> I am not sure I got much out of the STATES section regarding my problem.
> Your original problem as far as I understand is this:
>
>    You have a project with submodules.
>    The submodules are described in the .gitmodules file.
>    But the URL is pointing to an undesired location.
>    You want to rewrite the URLs before actually cloning the submodules.
>
> And to solve this problem we need to perform multiple steps:
>
>    # --no is the default, just for clarity here:
>    git clone <project> --no-recurse-submodules
>    # The submodules are now in the *uninitialized* state
>
>    git submodule init
>    # the submodules are in the initialized state
>
>    git submodule update
>    # submodules are populated, i.e. cloned from
>    # the configured URLs and put into the working tree at
>    # the appropriate path.
>
> Between the init and the update step you can modify the URLs.
> These commands are just a repetition from the first email, but the
> git commands can be viewed as moving from one state to another
> for submodules; submodules itself can be seen as a state machine
> according to that proposed documentation. Maybe such a state machine
> makes it easier to understand for some people.

"Between the init and the update step you can modify the URLs."  Yes I can and have to... wish it was not this way.

>>>> what I would get is from someserver1 not someserver2 as there is no
>>>> "origin"
>>>> support for submodules.  Is this correct?  If so can origin support be
>>>> added
>>>> to submodules?
>>> Can you explain more in detail what you mean by origin support?
>> Yes so when we do a:
>>
>> git push origin master
>>
>> origin is of course the Remote (Remotes
>> https://git-scm.com/book/en/v2/Git-Basics-Working-with-Remotes)
>>
>> So I best use terminology "Remotes" support.  Git push supports remotes, but
>> git submodules does not.  The basic idea is this:
>>
>> If Git allowed multiple submodule
>> (https://git-scm.com/book/en/v2/Git-Tools-Submodules) Remotes to be
>> specified say as an example:
>>
>> git submodule add [remote] [url]
>>
>> git submodule add origin https://github.com/chaconinc/DbConnector
>> git submodule add indhouse https://indhouse .corp/chaconinc/DbConnector
>>
>> Where:
>>
>> [submodule "DbConnector"]
>>      path = DbConnector
>>      url = https://github.com/chaconinc/DbConnector
>>
>> Could then change to:
>>
>> [submodule "DbConnector"]
>>      path = DbConnector
>>      remote.origin.url = https://github.com/chaconinc/DbConnector
>>      remote.origin.url = https://indhouse .corp/chaconinc/DbConnector
> here I assume there is a typo and the second remote.origin.url should be
> remote.inhouse.url ?
yes second should have read remote.inhouse.url:

[submodule "DbConnector"]
     path = DbConnector
     remote.origin.url = https://github.com/chaconinc/DbConnector
     remote.inhouse.url = https://indhouse.corp/chaconinc/DbConnector

>>
>> Then it should be possible to get:
>>
>> git submodules update --init --recursive
> which would setup the submodule with both
>
> [remote "origin"]
>    url = https://github.com/..
> [remote "inhouse"]
>    url = https://inhouse.corp/..
>
> But where do we clone it from?
> (Or do we just do a "git init" on that submodule and fetch
> from both remotes? in which order?)
origin by default and inhouse if specified. There is already a implied 
default (origin). The idea was not to do both but rather what is 
specified.  Origin and inhouse are just names for remotes. If one wanted 
a "--all-remotes" could pull from everywhere in the Ether if feature was 
to be implemented.
>> To support
>>
>> git submodules update [remote] --init --recursive
> This would just clone/fetch from the specified remote?
> If implementing this, we may run into a collision with the
> specified submodules, what if a submodule is at
> path "origin" ?
>
> Does "git submodule update origin --init --recursive"
> then mean to update the single "origin" submodule or
> all submodules from their origin remote?
Yes. That is what I would think.  It does this already by default. It's 
not as though submodules were/are all that well thought out to begin 
with in git IMO.
>> And thus allow
>>
>> git submodules update origin --init --recursive
>>
>> git submodules update indhouse --init --recursive
> understood. I like the idea of being able to specify
> multiple remotes from the superproject..

Yes so do I!  It *could* be better than the current offering which is 
defaulted origin.

