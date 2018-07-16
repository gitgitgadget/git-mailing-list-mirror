Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8EA91F597
	for <e@80x24.org>; Mon, 16 Jul 2018 18:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbeGPTSp (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 15:18:45 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:36731 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728495AbeGPTSp (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 16 Jul 2018 15:18:45 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id CE2973C8;
        Mon, 16 Jul 2018 14:50:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 16 Jul 2018 14:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=living180.net;
         h=cc:content-transfer-encoding:content-type:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ZE65C4gG0w/z8VnMf
        GerOvLzwyauPo0NM7s2P6vinAE=; b=ro7zraV+n23wHXWxwz7hMHLE7OvW9/DDb
        Wlvj7ylGpZbC3b54Z7kZyODmwcKt380hNZB818UCsYfBCxARjvGnmzsA5zlyQhLy
        eApyGGI9KW34tVOiOXMi4Pr5R9K2uAThTunHjI4/MFnsxyoK2uV6UOt/cjBOByNu
        4E95Q30qWB8ALzgn/4KLEkOtgDLZKQ9wp4WMJ0S4bDvhOKrUVj6UXcBnzB9Fg5Ed
        5D1FelOH8QMNuMeLo6ZS5ui79xOTmuvy/wwb9kSqH+n1zU9ft0kireXUB3PheC/K
        ai9+A3RRqDzD/8DzzqaVFTA3DZZQJv9l2WdZdgBZwc91bwDlPVnHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ZE65C4
        gG0w/z8VnMfGerOvLzwyauPo0NM7s2P6vinAE=; b=U5RSlFNQ7jcZeOq4Hppfso
        dpXibw08tYJJNW3+TDpi2xO/315BlzgNovsEbdQpzBtxG3at8gQrmb5gMPiyk7fG
        Af0GarAaf5hwIolH/9iA6uIh2ekIqpvTgHfYfY3g6rdrUortMZewyWArCqOVsbx/
        U8idgHjMWHR3s40LxrX9m5TvmLihN5/5QQFiNgkti5fmFfeJvgYY7AJzofXDWigA
        id/bZ2TERlHfEUxZCC0L34I2Y5qvqX5FQ1pbOZmXWSfRdbyd4BFZgaFk61lge53W
        IoJtm2zl5mWH1vFnY0/SLm7uWn6H9LOhlIdfJlOtOqflFKT7/Sr2rB6395aUivMQ
        ==
X-ME-Proxy: <xmx:2ehMW-9PfehkZA8YslKlRq8Tuixm668XX5mFow8zQr0gjz6yJHgXhw>
    <xmx:2ehMWyYE8XxjTNtCEfpY4RGlbr-4PPI_WqB_90Ib10vu3-3XMu3kow>
    <xmx:2ehMW91CJMxcsAn2C9bhmX6UNrqoiuFwgUDnpuNm-REZL4XZ5y3_fw>
    <xmx:2ehMW9Z1LK0YCjjwd3ADRVqEbHIO-7fONmAyOen7-DBk7qDScWA9xA>
    <xmx:2ehMW1I_ikkxjqSm9N4WTTochT9gLWtizTqoHmXlpkDBVJmJyFDsdA>
    <xmx:2uhMW1NxhpW6q6hz9nDfo_k5yuao6Nhe9ULjp3NsZO7WqvFNRZJYFw>
X-ME-Sender: <xms:2ehMWwOok-vMZ1hvjhJSQvTgPr48TMnNQ-dqUToL_5z58c08zj1yBA>
Received: from [0.0.0.0] (unknown [173.199.115.247])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1F27C10255;
        Mon, 16 Jul 2018 14:49:59 -0400 (EDT)
Subject: Re: [PATCH v3] sequencer: use configured comment character
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Aaron Schrab <aaron@schrab.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
References: <xmqq4lh4z870.fsf@gitster-ct.c.googlers.com>
 <20180716045902.16629-1-aaron@schrab.com>
 <nycvar.QRO.7.76.6.1807161758560.71@tvgsbejvaqbjf.bet>
From:   Daniel Harding <dharding@living180.net>
Message-ID: <66ce6f94-49ae-618e-bf6c-43a0f15bb752@living180.net>
Date:   Mon, 16 Jul 2018 21:49:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1807161758560.71@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Mon, 16 Jul 2018 at 18:59:03 +0300, Johannes Schindelin wrote:
> Hi Aaron,
> 
> On Mon, 16 Jul 2018, Aaron Schrab wrote:
>>
>> Looking into that a bit further, it does seem like my explanation above
>> was incorrect.  Here's another attempt to explain why setting
>> core.commentChar=auto isn't a problem for this change.
>>
>> 8< -----
>>
>> Use the configured comment character when generating comments about
>> branches in a todo list.  Failure to honor this configuration causes a
>> failure to parse the resulting todo list.
>>
>> Setting core.commentChar to "auto" will not be honored here, and the
>> previously configured or default value will be used instead. But, since
>> the todo list will consist of only generated content, there should not
>> be any non-comment lines beginning with that character.
> 
> How about this instead?
> 
> 	If core.commentChar is set to "auto", the intention is to
> 	determine the comment line character from whatever content is there
> 	already.
> 
> 	As the code path in question is the one *generating* the todo list
> 	from scratch, it will automatically use whatever core.commentChar
> 	has been configured before the "auto" (and fall back to "#" if none
> 	has been configured explicitly), which is consistent with users'
> 	expectations.

Honestly, the above still doesn't read clearly to me.  I've take a stab 
at it myself - let me know what you think:

     If core.commentChar is set to "auto", the comment_line_char global
     variable will be initialized to '#'.  The only time
     comment_line_char gets changed to an automatic value is when the
     prepare_to_commit() function (in commit.c) calls
     adjust_comment_line_char().  This does not happen when generating
     the todo list, so '#' will be used as the comment character in the
     todo list if core.commentChar is set to "auto".

Cheers,

Daniel Harding
