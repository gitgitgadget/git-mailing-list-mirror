Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACFE71F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 12:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932620AbeGJM35 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 08:29:57 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45771 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933209AbeGJM35 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 10 Jul 2018 08:29:57 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 8306521ACF;
        Tue, 10 Jul 2018 08:29:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 10 Jul 2018 08:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=living180.net;
         h=cc:content-transfer-encoding:content-type:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=lfcfhug1gadr2bmxI
        tW60oZQddOxDhikYlj8Je19wzw=; b=lMx0kcdyzp9ZHoK9xPua2l9I82lvnuudp
        XZlRZ290YT4B5cZOXKCnHclNiUnpPqYuHg9LPxuJqnNxkuLzD9EW8zKdnF1T8FZO
        E5FOrkp7ZIcQFMolUsdKU9qdFzYn/2wbFT9TEoVSp+j2UEElfEB2HXsRGZqu1cR0
        xzInbfwHcFrqXBt0OPPjx+yRwRir4JPKlloFbtM4o3gPPZUTuRCJ5LIx/9uL7fDZ
        VBYBb2NoYuoiYeBI62G0bNFmDPZYfvU4jcM3WN5L8KiIZO0Ql+xO75sFtGG21EXc
        NPboNQifn/5WY+noXnWttgB96FW1t2c2PWzAYaACk+krMG5oSg6QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=lfcfhu
        g1gadr2bmxItW60oZQddOxDhikYlj8Je19wzw=; b=ctlTK7ELjhdD0Y7enMDz2q
        UtOzoVImh1FbmmyjdJiZGL0/J0GAnBMbAUJdQtRRjTzajatOJ28nHnOUvfi1dYLr
        1QpZt5U3W2yCfSSdQwrcg+zSMRZuT3a4Ejo/Hv0MO5P9sV74U9y5fDnay1NXD8wE
        jdS6Aj1L+uBMMNkafYdUuZsCwJGR/Ls03sJoZ1b836Q5U942+8eIdSKlP1k+Gcpz
        nT+mvisJbQ8N0KiSaVvKrpsYin5sQ9GKALrFLm/gs77dPkdmo1VS1RJntll7JSP5
        1/lX8DjkaDCRy58Z2nLbpYbsLjLqWxt2GUd9gQ8uRqzTWAITqg6BBtAYj/+FIAQw
        ==
X-ME-Proxy: <xmx:xKZEWz7WBpMNx0bmafNTRDUDc5isCbr-HbWTHnXbNN5af40qmWEpmw>
    <xmx:xKZEWwZEhLtEO8qgiyVXjhi2RTGMGVCFgu0tKgIdCjZPXq_Jfl2uuw>
    <xmx:xKZEWwhxmh9-Tqbgbsam3VARKOlXK887t2uVGJXvRVp4eIEE85VzdA>
    <xmx:xKZEWyNaYKlXovyghA1z6DzE5WlwcLnuHoG_waiO0JdRuEyUU2cdQA>
    <xmx:xKZEWyO08x7GzIcOiZMrgh5vZNBZyY6ecUZ6rc5sjbhDIFD3vfrAmg>
    <xmx:xKZEW885DLUg3rNlJmbWwLFqAyEj9q-26fGzrOCNEKCyNTI8RtzOOA>
X-ME-Sender: <xms:xKZEW6m16lq79SO4c5zWFQjJQiTQGFkELHwicj-geoGG9i-SF41PGw>
Received: from [0.0.0.0] (unknown [173.199.115.247])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8F1FFE48A9;
        Tue, 10 Jul 2018 08:29:54 -0400 (EDT)
Subject: Re: [PATCH 2/2] t3430: update to test with custom commentChar
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20180708184110.14792-1-dharding@living180.net>
 <20180708184110.14792-3-dharding@living180.net>
 <20180708210200.GA4573@genre.crustytoothpaste.net>
 <1084a573-4ed5-5a8c-a159-7773f7465704@living180.net>
 <nycvar.QRO.7.76.6.1807092109440.75@tvgsbejvaqbjf.bet>
From:   Daniel Harding <dharding@living180.net>
Message-ID: <aa716d3f-6a80-e3fc-0172-1027fb85c792@living180.net>
Date:   Tue, 10 Jul 2018 15:29:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1807092109440.75@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 09 Jul 2018 at 22:14:58 +0300, Johannes Schindelin wrote:
> 
> On Mon, 9 Jul 2018, Daniel Harding wrote:
>> 
>> On Mon, 09 Jul 2018 at 00:02:00 +0300, brian m. carlson wrote:
 >>>
>>> Should this affect the "# Merge the topic branch" line (and the "# C",
>>> "# E", and "# H" lines in the next test) that appears below this?  It
>>> would seem those would qualify as comments as well.
>>
>> I intentionally did not change that behavior for two reasons:
>>
>> a) from a Git perspective, comment characters are only effectual for comments
>> if they are the first character in a line
>>
>> and
>>
>> b) there are places where a '#' character from the todo list is actually
>> parsed and used e.g. [0] and [1].  I have not yet gotten to the point of
>> grokking what is going on there, so I didn't want to risk breaking something I
>> didn't understand.  Perhaps Johannes could shed some light on whether the
>> cases you mentioned should be changed to use the configured commentChar or
>> not.
>>
>> [0]
>> https://github.com/git/git/blob/53f9a3e157dbbc901a02ac2c73346d375e24978c/sequencer.c#L2869
>> [1]
>> https://github.com/git/git/blob/53f9a3e157dbbc901a02ac2c73346d375e24978c/sequencer.c#L3797
> 
> These are related. The first one tries to support
> 
> 	merge -C cafecafe second-branch third-branch # Octopus 2nd/3rd branch
> 
> i.e. use '#' to separate between the commit(s) to merge and the oneline
> (the latter for the reader's pleasure, just like the onelines in the `pick
> <hash> <oneline>` lines.
> 
> The second ensures that there is no valid label `#`.
> 
> I have not really thought about the ramifications of changing this to
> comment_line_char, but I guess it *could* work if both locations were
> changed.

Is there interest in such a change?  I'm happy to take a stab at it if 
there is, otherwise I'll leave things as they are.

Daniel Harding
