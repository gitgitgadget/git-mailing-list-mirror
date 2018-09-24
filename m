Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97B5F1F453
	for <e@80x24.org>; Mon, 24 Sep 2018 01:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeIXHh2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 03:37:28 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:50547 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725981AbeIXHh2 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 24 Sep 2018 03:37:28 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id DA6DE1D0;
        Sun, 23 Sep 2018 21:37:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 23 Sep 2018 21:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stason.org; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=cvaJIQnn09ul8oUaOPUtbCeV+h5M9
        1AfoQYrNJwgZwY=; b=QA2a7SFVoFyC0cMSfU0awCQa/9tuw4y+HNLK6f82GOr7f
        EVQpfOy+jvfUWHPeSWjOFUNsTn7QXaNVGrwL2uEzdk3yQb+HR7De39tNoBo21g3e
        L2E6AQVDOx6AXtSuQce2gQH8V4HdOEy67yXUm5+m66UWq40affq4bWppBZj2oPir
        UMo7b2wAjv9rAsjbGXUSFiAdWEOCJhrSqwbRYoMyfftMwuq+WxZm/PXWMKuw4+Rx
        EIC324Ajj4JOiw9QhYVMm96/GHrL6IHpPrD3Nt8zHarPM8If/IcCh8EPqId62D9W
        p9FoGAc/Uz7CpBogjxc6WWJgDATBm1Z4/W3q+hP0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=cvaJIQ
        nn09ul8oUaOPUtbCeV+h5M91AfoQYrNJwgZwY=; b=jQqtGmoIz3nLGcrpA0vvNt
        WZVz/2TuMHrRZ7BOWDLl6Ty7uEIH6YIQ9hrf0r2FSiiINehnJaP8H2ZJthi5vBcr
        +/eIVsXHPchTAyl/F4MAdqG6io+4LsYgCa/o5Qeoy+UUdxWaqeUKZ8dWslIF+hZA
        42qJnb1N6uVn9tzf75518J0oTZY13JaHB8mnkuL3nJ6fwTMA3KspCSvtTkaBgyWO
        GbHQGLEXIKPrtfhRbmlYgxjHZx20+5yc+hW3+YAtbUSMLWZAVqpHiVQzBC5OP+7m
        vxnZ8kiLXWl8dxbNSn9sUkEQBProY0N6amyneenA1NqcXZC8IDw3qD7Z9/9Uog5w
        ==
X-ME-Proxy: <xmx:5z-oW3E_1DX2PgEWd0xWh4btxDY3QkJYqjZGsQyTgBH6VKve-9tJZg>
    <xmx:5z-oW10lbNn-RIk0-JXZJvA81uLFAcLOcF5YeFQTcf3pUczAaLOOrA>
    <xmx:5z-oW2xP__Y6j4o9exDJQOX-xWWgvoiljVShG7rRW8N0TRK_uTbYNg>
    <xmx:5z-oW8iLX3gQILTTp9wS2kanx-SO2pt75igJ5r96wbpbJa7KlvIUzQ>
    <xmx:5z-oW9zPzAELi5ctIe_Hn7as211-r2jdp5AFxG4Cninr16phQaQYmQ>
    <xmx:5z-oWwzr7EqajRQB0o4J0Q0K-H7vMJGKGwNfOzQVgmkwJIF7fpfqug>
X-ME-Sender: <xms:5z-oW8Q2yJcKvgmDbQNaVv72D7kvlIeadWZuRyySifVanQH1Y5VSNg>
Received: from [192.168.0.10] (s0106f0f249e4dad3.gv.shawcable.net [96.54.245.187])
        by mail.messagingengine.com (Postfix) with ESMTPA id AA570102D4;
        Sun, 23 Sep 2018 21:37:42 -0400 (EDT)
Subject: Re: git diff-tree ignores --textconv
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <41cd358c-d900-2996-b78a-b9d897a2ba2b@stason.org>
 <20180924004307.GA26103@sigill.intra.peff.net>
 <13dec8d3-b164-dc24-45e0-8e1bbd550524@stason.org>
 <20180924012354.GA27439@sigill.intra.peff.net>
From:   Stas Bekman <stas@stason.org>
Organization: Hope, Humanized
Message-ID: <84b70e1b-5868-f122-6960-e725163ccde1@stason.org>
Date:   Sun, 23 Sep 2018 18:37:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924012354.GA27439@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-09-23 06:23 PM, Jeff King wrote:
> On Sun, Sep 23, 2018 at 05:56:03PM -0700, Stas Bekman wrote:
> 
>>> You probably want "--ext-diff", not "--textconv".
>> [...]
>> Would it be safe to ask the maintainer of the application to include
>> both --textconv and --ext-diff in that 'git diff-tree' call? I only need
>> the latter, but someone needed --textconv there as it's in the code.
> 
> I think so. The main reason that they are not the default for plumbing
> commands such as diff-tree is that the output may be quite surprising to
> anything trying to parse the output. Using --textconv will always
> produce a diff, but one that may not be applied to the original content.
> Using --ext-diff may produce output that doesn't even look like a diff,
> though in practice they often do.
> 
>> This is for this package:
>> https://github.com/rsmmr/git-notifier
> 
> It looks like the output is meant to be read by humans, so yeah, I think
> it would be fine (and preferred) to enable both.

Fantastic. Thank you so much, Jeff.

-- 
________________________________________________
Stas Bekman       <'))))><       <'))))><
https://stasosphere.com  https://chestofbooks.com
https://experientialsexlab.com https://stason.org
https://stasosphere.com/experience-life/my-books
