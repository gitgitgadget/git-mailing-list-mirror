Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68D7E1FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 22:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755578AbdBGWa2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 17:30:28 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33480 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755474AbdBGWa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 17:30:26 -0500
Received: by mail-pf0-f196.google.com with SMTP id e4so10123720pfg.0
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 14:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=enVxo0HEGEr2NnouK3V1jwRQ2eLNXILMrk0X9oKUXww=;
        b=neMXZ7lHpKGcxa9Obiqrr2voVC4CMS4MuvgGGk0yIiF5rP2xfoc7kYPyP96Z9k6YuI
         gICeDi3X/T5nVNeOg2id8eD8t1DncCdHRCfT/1FbXHj/l7oiHHg89Mn2LrqZIQvn1B+X
         j7p678EhWFIVA01BAOofKRRG3bB9WjNd85QoNmdutngw6IObxzG+XnQSqGY+A7PafN/8
         TqOEckXjqwxJgbEOXOJqia7Dq+nEaMDnaJa3IX4Xb9zkf5MIY2qb7OUbvRTd9HjmIN2Q
         2auAXP15YTanzcXxeqKaV7GMCVmV0/ORlzafZweCxItLpY1L9hvV6dCKN5RtYrdZUnKc
         OYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=enVxo0HEGEr2NnouK3V1jwRQ2eLNXILMrk0X9oKUXww=;
        b=TwTHG34X4kVzE9j+HxDl6Hc3I5hkUyC5IXgFBphlYVL+YRqS9UAJhNcWIzDQ9rpIgd
         jRX11VKgHEHh1zjhOd3LhbgB7uLlEMLVzoHU3UhEUjepw5IbSEOpB+8MQictf89qnu/H
         W2nJAyM9qf2AVWuVzVc2RiFpeG2xpOZ3uaZeQa9BPTIGweVsh36bCSz27GRQ8woH/+xk
         3F3MmCW5PzQ47uk6M1AhJxYDuSHOqk2bMM3wpRgrtzPPql+kkS2gbQ/1Cs6zudvd1vyz
         6WMhGiwmEQ1EODipZTXz5YcCO3fiVqiFhQO3qWz795OZOII3Nn60HzImTq119uRL3YrX
         200A==
X-Gm-Message-State: AIkVDXJvFbmSaga8nL90C00QZ4ADV7vdDB83q0xJLGbQIetRfWxfeWCHbc7Zj/4Ridjang==
X-Received: by 10.99.61.202 with SMTP id k193mr22929993pga.154.1486506613926;
        Tue, 07 Feb 2017 14:30:13 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:1564:f4f3:f1b4:c9b2])
        by smtp.gmail.com with ESMTPSA id d124sm14038835pga.30.2017.02.07.14.30.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 07 Feb 2017 14:30:12 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/5] add SWAP macro
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
        <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
        <alpine.DEB.2.20.1701301643260.3469@virtualbox>
        <aa653d57-4a97-ac50-b20c-f94ed43a22fb@kdbg.org>
        <alpine.DEB.2.20.1701302158110.3469@virtualbox>
        <77098ac8-1084-a5c4-a5e6-fb382e3dc3a0@web.de>
        <20170130222157.GC35626@google.com>
        <8e94756a-c3a5-9b81-268d-d0f36876f710@web.de>
        <20170131213507.uiwmkkcg7umvd3f4@sigill.intra.peff.net>
        <alpine.DEB.2.20.1702011225250.3469@virtualbox>
        <20170201114750.r5xdy6emdczmnh4j@sigill.intra.peff.net>
        <bfd0d758-a9c8-9792-6294-9f9ed632cc98@web.de>
        <xmqqd1f1pxqc.fsf@gitster.mtv.corp.google.com>
        <12e7db44-ff69-a38e-322a-6b5fc5f1fc29@web.de>
Date:   Tue, 07 Feb 2017 14:30:12 -0800
In-Reply-To: <12e7db44-ff69-a38e-322a-6b5fc5f1fc29@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 7 Feb 2017 23:04:21 +0100")
Message-ID: <xmqqr339y6q3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Swapping between different types would then still have to be done
> manually, but I wonder how common that is -- couldn't find such a case
> in our tree.

I do not think it is a common thing to do, and more importantly, I
doubt we want to hide such a swap inside a macro.  And that is why
I said the seemingly extra "type" thing may be an improvement over
your original SWAP() thing if it gives us more type safety.

It seems that the thread has been quite for a while. Perhaps people
are happy enough with your patches?  If so, let's move it forward,
but I'll wait for a while in case follow-up discussion appears
soonish.  The changes are fairly well isolated and I do not think we
are in a hurry.


