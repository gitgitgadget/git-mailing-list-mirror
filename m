Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3E451F404
	for <e@80x24.org>; Sat,  8 Sep 2018 20:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbeIIAve (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 20:51:34 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33805 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727514AbeIIAve (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 8 Sep 2018 20:51:34 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 572A221607;
        Sat,  8 Sep 2018 16:04:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 08 Sep 2018 16:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stason.org; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=IarYKewD14w662W+r+7frvCT0DGs7
        lzQtLen4SXF3ew=; b=Gf6c3Zjv/48p0mLUAGVw7p86Zkz9Gw6wOd4xXagH/oerr
        lkuPkW0vL+w7GUHnh7v786lFP+g3kyB25FLnWZGJZqVr2SmNdDKDM87oIVY8lH81
        rvx8uo55oygAMZv5Ll8poR2tqakDbwEC/IC84bv2dNxV5F46FbSVDmYtLwJWGoWu
        k+UR/Yx+qKP6zIm9/WoN0e4ttV/lzHEc1wSwGIrUDFptJkxoS7VlGITNeIoqcWRL
        90UkMduGgY8r3h4ZhcpHcg6oitLOLuNHlHNAVBzSZAGtDdMfIGe6sOlceL+DFV2L
        LzY55h9AGwxs9BwmSTWVxkTKiURu/ouvVcu25t4Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=IarYKe
        wD14w662W+r+7frvCT0DGs7lzQtLen4SXF3ew=; b=BzL177iN1s2+KQ+2MO7km3
        +0hO0kpa04E06z1IrAlfXUJxA8NfjPup1ZqgPnMSgCJVty1xkLqGOASO4NCeJz5n
        3L6T/c1mVgzbzw/HeFXILhtHsfXjCiyryX7MWkDmIzrHCoSpUm2n71L1J51XFicP
        xsoiXgCREWjd74HXWXlXdbZGmw6AcDq/qwotRcyaSrfAHjOzExPA3U7tP68IQmAD
        m4uECWOmS6H3vkHyqQ0Rhx28f5JQSqH0Z2b7hm8fZtcVKf/2qTuw8VQetWLu2brw
        S+Lm7nJx1mKPWX3PaHpP0EPUGMO5i3MaFfEucqZPIGQEXWFCW5CwXr24AZBBXq+g
        ==
X-ME-Proxy: <xmx:VyuUW612UKDAtN3tMVguM91qv6Mzb2N6zY9fc-yTq2dwnRrYAi6Qlg>
    <xmx:VyuUW-gfrtsi678apb5q7wH7_ZFQsCM4BZ00F_iKAvYDTJacEkICYg>
    <xmx:VyuUW95MIWMriBaAgRJCpg_q4d55T1TwYcqiPbEk0I5upAlwcsXUdA>
    <xmx:VyuUWwV0kFT1d-zxFsBtldqL2zd8wdBScRa1xNr6hj8mFfZrL4F-dQ>
    <xmx:VyuUW9l9aoFK9izIKpxMdMgWVYKvrRjFJpX_y9wNIR6EG-8G545J_Q>
    <xmx:VyuUWyq75sajgB0sJWOIppw1tZ6QmDrKx3t0B0VxapCmie_rPbUX8w>
X-ME-Sender: <xms:ViuUW0tMUKoeYxjlengsbddhnFYbLAhqaZ0-m3DnQX35qeQKDhl1xw>
Received: from [192.168.0.10] (s0106f0f249e4dad3.gv.shawcable.net [96.54.245.187])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3B5C110294;
        Sat,  8 Sep 2018 16:04:38 -0400 (EDT)
Subject: Re: git silently ignores include directive with single quotes
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org>
 <CAN0heSroxfcwiJaVgGFTweq=XKAgGsR-E6SeOgsG4m0rzK4dHQ@mail.gmail.com>
 <87bm97rcih.fsf@evledraar.gmail.com>
From:   Stas Bekman <stas@stason.org>
Organization: Hope, Humanized
Message-ID: <c0844b98-0fee-9fbd-fedb-883ed88c3ac6@stason.org>
Date:   Sat, 8 Sep 2018 13:04:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87bm97rcih.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-09-08 12:54 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sat, Sep 08 2018, Martin Ågren wrote:
> 
>> Hi Stas
>>
>> On Sat, 8 Sep 2018 at 21:00, Stas Bekman <stas@stason.org> wrote:
>>> [include]
>>>         path = '../.gitconfig'
>>>
>>> Notice the single quotes around the filename. When this is the case git
>>> silently (!) ignores the custom configuration, which is clearly a bug.
>>
>> Thanks for reporting and describing out your expectations and what you
>> observed.
>>
>> Actually, there is a test explicitly testing that 'missing include files
>> are ignored'. I couldn't find a motivation for this in 9b25a0b52e
>> (config: add include directive, 2012-02-06).
>>
>>> The original problem cropped up due to using:
>>>
>>>  git config --local include.path '../.gitconfig'
>>>
>>> which on linux stripped the single quotes, but on some windows git bash
>>> emulation it kept them.
>>
>> Huh, I wouldn't have expected them to be kept. You learn something
>> new every day...
>>
>>> What am I suggesting is that git:
>>>
>>> (1) should complain if it encounters an invalid configuration and not
>>> silently ignore it. It took quite some effort and time to figure the
>>> culprit.
>>
>> Sounds reasonable to me, but I might be missing something. I'm cc-ing
>> the original author. Maybe he can recall why he made sure it silently
>> ignores missing files.
>>
>>> (2) probably allow the quoted location of the file, but it's much less
>>> important, as it's easy to rectify once git gives user #1
>>
>> I don't think this will work. Allowing quoting for just this one item,
>> or for all? Any and all quoting or just at the first and last character?
>> What about those config items where quotes might legitimately occur,
>> i.e., we'd need some escaping? Actually, something like '.gitconfig'
>> *with* *those* *quotes* is a valid filename on my machine.
> 
> The reason missing includes are ignored is that the way this is expected
> to be used is e.g.:
> 
>     [include]
>         path ~/.gitconfig.work
> 
> Where .gitconfig.work is some configuration you're going to drop into
> place on your $dayjob servers, but not on your personal machine, even
> though you sync the same ~/.gitconfig everywhere.

Thank you for clarifying why this is done silently, Ævar. It makes sense
then.

> If we were to make nonexisting files an error, we'd need something like
> an extension of the includeIf syntax added in 3efd0bedc6 ("config: add
> conditional include", 2017-03-01) 3efd0bedc6 ("config: add conditional
> include", 2017-03-01). I.e.:
> 
>     [includeIfcond "test -e ~/.gitconfig.work"]
>         path = ~/.gitconfig.work
> 
> Or something like that, this is getting increasingly harder to shove
> into the *.ini config syntax.

This suggestion won't solve the real problem. The real problem is that
git can't find '.gitconfig' even though it's there, due to single quotes
around the filepath. So the suggested check will still ignore the
configuration even if it's there.

This also leads me to think what if the include path has spaces in it?

    path = ~/somewhere on my system/.gitconfig.work

most people would assume quotes are needed around the filepath.


-- 
________________________________________________
Stas Bekman       <'))))><       <'))))><
https://stasosphere.com  https://chestofbooks.com
https://experientialsexlab.com https://stason.org
https://stasosphere.com/experience-life/my-books
