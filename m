Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03DB41F404
	for <e@80x24.org>; Thu, 13 Sep 2018 20:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeINCKx (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 22:10:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36612 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbeINCKx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 22:10:53 -0400
Received: by mail-wr1-f66.google.com with SMTP id e1-v6so8111783wrt.3
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 13:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Zrkhzdm6gzLglXssMocLEaEiYJ4gck1AUprRgAsNlQk=;
        b=WnmaT1cIOX+pnj6V7MJCyViFlrEXdJXUuw6kBr4owiuI3yVJ7eBE0uLrJ9oRlqpPyi
         O8sFLDNUbhmNxpaDb42n1YluPa+YQ3uoHD0K6Ycg0gv5a9TW0k9DTdBTQYdtvr/gxWkN
         ICTOjXyM3wa/8Yu35xa+vNZWyB7y0ZexDHNkDe4i6a/zun+inamdcrdFLXwQ/N7SmnH7
         F4G84ZqZ1yZ/1nYN9LQDTsMvRoMt1F+kdGhIUTpJMfEtwCU5nWE6WOZj2rnI/Gu+1Kpt
         xIpMLCUtXuWYiJ335i7JRolrZoNC3bI7p0pCsW6uZZbVKXK57N7pY5h/4HjlTXO95GP7
         kzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Zrkhzdm6gzLglXssMocLEaEiYJ4gck1AUprRgAsNlQk=;
        b=S8U9s7vxjZY6P4t6lW7iYHiGmnb8gd+puONQ7XuSqP9cYzhVtZApF3kXBgOggd0MVU
         plKn7XEwzkcEp/W9FMwo/R13WsfMqgZ7d8S1FKgxxnvYoP9Nn9Sz9FUVLGVUUIZvPkE7
         iP0RBEE0oC7SmQroeYtb5qPejkIEGSL7EU5Ehbyg+gJFEbBtE0wozMHcpVhSHwQSEp+A
         0RbztYd/OubUr/gyJSfmbRJoaXniE1tn3Mo+vh8jnGZ/j5SmpDCsSO8CFk2wrXpMkjd3
         4adJ6aaoySY+NjzonSqqGbhH7AT9a2xpx8s2lc6w1yFLvtnQvYb0Ka0XeJuVqq14BUof
         hseg==
X-Gm-Message-State: APzg51B0HZ+T1R0sDUvdfkV3yLRYK6MZDGUezaZisxVkqYzgvnj3RAuA
        hAPPGUGabarezLItcW+fps3XEGMN
X-Google-Smtp-Source: ANB0VdZwiao47pX7rGhaZyzicQ+RKUsZc914R8xunFSD4wAPs3AmpYMBlEgAHvNnpzRk2fyqfz3kRg==
X-Received: by 2002:a5d:5009:: with SMTP id e9-v6mr7368803wrt.18.1536872380506;
        Thu, 13 Sep 2018 13:59:40 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k35-v6sm11491576wrc.14.2018.09.13.13.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 13:59:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Ben Peart <benpeart@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v1] read-cache: add GIT_TEST_INDEX_VERSION support
References: <20180912212544.33624-1-benpeart@microsoft.com>
        <87in39kzc3.fsf@evledraar.gmail.com>
Date:   Thu, 13 Sep 2018 13:59:39 -0700
In-Reply-To: <87in39kzc3.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 13 Sep 2018 20:49:00 +0200")
Message-ID: <xmqq36udf70k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Wed, Sep 12 2018, Ben Peart wrote:
>
>> -GIT_TEST_OE_DELTA_SIZE=<n> exercises the uncomon pack-objects code
>> +GIT_TEST_OE_DELTA_SIZE=<n> exercises the uncommon pack-objects code
>>  path where deltas larger than this limit require extra memory
>>  allocation for bookkeeping.
>
> If re-rolled maybe better as a leading "fix a typo" patch.

Yeah, an easy to miss change that is unrelated to the topic is
better made as a separate patch.

