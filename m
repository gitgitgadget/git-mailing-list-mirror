Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E2FD1F404
	for <e@80x24.org>; Sat,  8 Sep 2018 19:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeIIAbY (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 20:31:24 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41721 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727608AbeIIAbY (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 8 Sep 2018 20:31:24 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id AE79621B36;
        Sat,  8 Sep 2018 15:44:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 08 Sep 2018 15:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stason.org; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=8Q0MMf9dJCYtUPIEgHh/n+B8x3HE2
        VOfxLQ1vE7LOyo=; b=BPavyq2D/r1aaQq0uyhgMohgEC+6qiu1wyad3EnA9mPfO
        J35q/kW+OoDQvjFET+emmFNCBWSLAMgz6a8PS/b8neyqYwvEcx8Nm1JC+hE6Wo9H
        RtRyvnuKen5iaO9tfjQjQt1rzus1uu9xZwBVfF92nMi2qtBD1aScFU2Q5LRVoKF1
        JSKRipy4JYxHRCroTTLWgUxhx13KrrV0n5n9QZqZvvsQBjL0P5+Ekq/fWespCMFg
        7Lnwy55lF1QmU8hVE1NE7mq8j5ayX2neSw3NyA7rQsnoI5eGBXntqZLC23iuhZc0
        xMCtPFSKz06pWEkOwJaxbjSPIvGexS8eYwPuimLCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=8Q0MMf
        9dJCYtUPIEgHh/n+B8x3HE2VOfxLQ1vE7LOyo=; b=t5hRkGo5rgNGbEHXk3sXvT
        Ubx9rlgkG4uIbjySSB4KKzB0vieJFz7tOrLHOQCtlkDvsngn/BWoJB6k7IcxfSMQ
        rqDAvkb/36PduasHTnaJlqFvOYoROZnSxBtYP2vxVTYZLvQRZIeM5gN1JU8JdlGs
        VWWNA13AzBPzk49iObxBhwLx5pSvVAV6Buhfs+oTt4Gkpudz7+v6vlHOgOeqOSoy
        stNitT+pElUXE4X/aLYJu/wbwnC0HOuN8oaha/5snAw9hJLMlaQ/9lvQkc0s0Y5j
        JpJECLafFO5K0HlwYjswEmrE5A16uc2w4Qs3tAEzGygBli+rIRvfUHQhtsjiKf8w
        ==
X-ME-Proxy: <xmx:oCaUW8FczImiuEI1DE5MfIOtclMhd536HkunfMcBi2RjKqGu6C8T0w>
    <xmx:oCaUWzCdsKKYUoECpTuJ7RXWOu6ZMcmGIUPjevpflyCAogZSRtzjOg>
    <xmx:oCaUWwmkBzsoi_lpeDs1NviLuS8UbY4_q5CIGO3nhq7qNaE_A5z0nA>
    <xmx:oCaUW2QPtw-Mmj4VY5e7BGdAuhSxZPwHOyS0mbI1cEKyd5AcixSigA>
    <xmx:oCaUW8IZBNvf6QANmggCKYzbzMUx_UYyfdK6q0hQLYr7jB--nFQTwA>
    <xmx:oCaUWwLtqC9RqRU5sM3n5fXapkpj0kQNL0q4__KKUBJYkY7BIU4fLA>
X-ME-Sender: <xms:oCaUW6KugSq4yrndbjhstktvM3oyJIxQQlH-W2mRspFDX5jvBJXqbg>
Received: from [192.168.0.10] (s0106f0f249e4dad3.gv.shawcable.net [96.54.245.187])
        by mail.messagingengine.com (Postfix) with ESMTPA id D820F10292;
        Sat,  8 Sep 2018 15:44:31 -0400 (EDT)
Subject: Re: git silently ignores include directive with single quotes
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org>
 <CAN0heSroxfcwiJaVgGFTweq=XKAgGsR-E6SeOgsG4m0rzK4dHQ@mail.gmail.com>
From:   Stas Bekman <stas@stason.org>
Organization: Hope, Humanized
Message-ID: <2824cc17-b4a4-8821-331f-1768246f2e6b@stason.org>
Date:   Sat, 8 Sep 2018 12:44:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAN0heSroxfcwiJaVgGFTweq=XKAgGsR-E6SeOgsG4m0rzK4dHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-09-08 12:30 PM, Martin Ågren wrote:

> Actually, there is a test explicitly testing that 'missing include files
> are ignored'. I couldn't find a motivation for this in 9b25a0b52e
> (config: add include directive, 2012-02-06).

Thank you for the follow up, Martin. And discovering that it is by design.

I suppose this could have been done to optimize run-time performance.
But there must be a way for a user to validate their custom
configuration. So perhaps there should be a specific directive to do so?
One could argue that:

  git config --list --show-origin

does exactly that. Except it should probably also indicate that some
configuration file or parts of were ignored - and clearly indicate the
exact nature of the problem. In which case it'd be sufficient.

>> (2) probably allow the quoted location of the file, but it's much less
>> important, as it's easy to rectify once git gives user #1
> 
> I don't think this will work. Allowing quoting for just this one item,
> or for all? Any and all quoting or just at the first and last character?
> What about those config items where quotes might legitimately occur,
> i.e., we'd need some escaping? Actually, something like '.gitconfig'
> *with* *those* *quotes* is a valid filename on my machine.

Let's ignore this sub-issue for now. If we can get git to report when
something is mis-configured, this issue can then be easily resolved.


-- 
________________________________________________
Stas Bekman       <'))))><       <'))))><
https://stasosphere.com  https://chestofbooks.com
https://experientialsexlab.com https://stason.org
https://stasosphere.com/experience-life/my-books
