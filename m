Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BA151F453
	for <e@80x24.org>; Sat,  9 Feb 2019 19:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfBITC2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 14:02:28 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:58879 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfBITC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 14:02:27 -0500
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Feb 2019 14:02:26 EST
Received: from [192.168.1.12] ([92.29.15.245])
        by smtp.talktalk.net with SMTP
        id sXlZgdBG8whzSsXlZghPpi; Sat, 09 Feb 2019 18:54:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1549738458;
        bh=1lnMeOsZxMfu7MR9EIAQqUKX4bo7pTVECQT0aj0Z5UQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LqwGSmat5pLuhOSbhnamp3yVrBi4OGu0fLq79Xdx/1OhmGxjibZE8Ux++07v185z/
         +pGnppChEVfZekvTQG40iwobYMroN51E2eTNPvvugrs5J3YW4vQirOIyiLiFXETUBx
         ByT3UDg4bBl+ampRrtmBWolvhX72IOaScA99g5Os=
X-Originating-IP: [92.29.15.245]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=9anTPZJWX8pnfAL1p5p6vw==:117
 a=9anTPZJWX8pnfAL1p5p6vw==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=N54-gffFAAAA:8 a=UFTA8MH_AAAA:8 a=AK7OKGO-AAAA:8 a=2g1uuSb1M8MrRi_nwC0A:9
 a=ZwmVkkDuf4i_VqMf:21 a=ZYCCtfU3V3AsOun4:21 a=QEXdDO2ut3YA:10
 a=6l0D2HzqY3Epnrm8mE3f:22
Subject: Re: [PATCH v3 7/8] checkout: introduce --{,no-}overlay option
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20181220134820.21810-1-t.gummerer@gmail.com>
 <20190108215225.3077-1-t.gummerer@gmail.com>
 <20190108215225.3077-8-t.gummerer@gmail.com>
 <20190122235313.GA199923@google.com>
 <20190123202156.GA11293@hank.intra.tgummerer.com>
 <xmqqzhrr9j52.fsf@gitster-ct.c.googlers.com>
 <20190124011244.GE34357@google.com>
From:   Philip Oakley <philipoakley@talktalk.net>
Message-ID: <cff853ae-9339-3827-26af-273a6cf10ec6@talktalk.net>
Date:   Sat, 9 Feb 2019 18:54:16 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190124011244.GE34357@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfNP7tluaSVUxNO3cigGEZI4nAVIGd8CkdyCZza0BTNLXlJzndYnOV/BfE+ByE6rzm9bU76Hmizb1FfNDH9ciz1BbGV6MjkuGpcaH3H9I4SabbB/NV2xY
 A5bC1KoMLGJq8ZmO4Lyyk3A5YSMCaY+Pz/Yik8tyh1QDUcRnvcac826ED1E6WD9hdLj9kiHJoG9RNdyiwimmOtPlLKl2Lbb1V+Fzm415AfM/CboM9RNeRKye
 mt5jNggH1F3SC0v9ZKnSDI/IzLS8EBe1pubHT6yy1A1LO/88zNjiyJB5Azq9YpkZYmC9eeJY8vO0jy1TguwF7lmWWxK8R5wYc0opEPZGDCqkCyFA9CRT0dlh
 P4OZ40O3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 24/01/2019 01:12, Jonathan Nieder wrote:
> Hi,
>
> Junio C Hamano wrote:
>> Thomas Gummerer<t.gummerer@gmail.com>  writes:
>>> Jonathan Nieder wrote:
>>>> Is this analogous to "git add --ignore-removal"?  If so, can we just
>>>> call it --ignore-removal?
>>> Yes, it seems like they are very similar.
>> Hmm, I am not sure if the word "removal" makes sense in the context
>> of "checkout", as "removal" is an_action_  just like "checking out"
>> itself is, and not a_state_.  You'd check out a state out of a tree
>> to the index and the working tree, so "checking out absence of a
>> path" may make sense, though, as "absence of a path" is a state
>> recorded in that source tree object.
> I find --ignore-removal fairly easy to understand, and I had no idea
> what --overlay would mean.

I too had difficulty initially as to what 'overlay' meant, or that there 
were options.


>
> I realize this is just one user's experience.  I'd be happy to do a
> little informal survey (e.g. taking the description from the manpage
> and asking people to name the option) if that's useful.
>
> See alsohttps://dl.acm.org/citation.cfm?id=32212  on this subject.

I did locate a copy at 
http://zhang.ist.psu.edu/teaching/501/readings/Furnas.pdf

The whole word choosing problem does smack a bit of Orwell's Vocabulary 
C (OVC) where:

"The [Newspeak] C vocabulary encompasses words that relate specifically 
to science and to technical fields and disciplines. It is designed to 
ensure that technical knowledge remains segmented among many fields, so 
that no one individual can gain access to too much knowledge. In fact, 
there is no word for “science” " [1]

Most of the DVCS concepts have a newness to them that means that we 
don't have good words yet, hence the difficulties. Just my 2 cents.

>> The word "removal" makes little sense in "git add --ignore-removal",
>> but it and "git add --no-all" outlived their usefulness already, so
>> it may not be worth_fixing_  it.  But I am mildly opposed to spread
>> the earlier mistake to a new option.
> I think that's a good place to end up: once we flip the default for
> checkout, then --ignore-removal would be an obscure option in that
> command as well.  The consistency with "git add" is just a bonus.
>
> Thanks,
> Jonathan

Philip

[1] https://www.sparknotes.com/lit/1984/section11/

