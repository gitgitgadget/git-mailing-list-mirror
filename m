Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAD8F1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 18:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfAVS37 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 13:29:59 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41978 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfAVS37 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 13:29:59 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so28498124wrs.8
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 10:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=r96jz6kxoEj5E90c8z2WSxl6ixwV8e4Z/cEdXqWjx4o=;
        b=NUobcbSGZ6t8xhebU0mSiHUufUNvCN0mpgM8ttNCksKpjyAMgGpXCkrbdUgQ+obF4k
         LFhhEExV6oyqF4MDc5gE/Fxgjr5mSBTMt+OGfuO+9p/VESOpXaEfUnA4kh0PZmQwzRgL
         fRtrHiFBzzMWisJ0HoUCVQA+/Zv5Ys8zxbm6I6hf1O1h53geUL9Wl5uRGM//Wu+2Lxms
         QacC0qnNthPwSa1JRDJpYQ3bQ6ZSwoMpqAf8WtE39mYWU6E9NraqRiM9et1Z3C/2AXNl
         u7fOhKG3dbjiBhHcVD/56iaG7xsTNQ6lrtj//Nczc5z8F79tJOQwujhUVWZPxjk8k67M
         wRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=r96jz6kxoEj5E90c8z2WSxl6ixwV8e4Z/cEdXqWjx4o=;
        b=A7nBy7sFMtO3abE53es+nHglRdbf23cjAJUCqfG9/1QUqNNegELZFcYwYSmqdfUddj
         G0qPmIzWz20dSFJO5p+SMTc4xmO+JwQi2oHk+U+POludbaxbonmHh8PoiOriMrlY9D/0
         EYnbD5byhLCqP2QCl8gtv923YG9UdEa1rCzK3pLwVntQb3My94F79LaKzV+3nGZkWroq
         fI7We4LhsmI53H2tApqMawOfkkB7ppjJZJQAFhqfaF+gZzJ8hfB9uPESUODiMsBGgADX
         AiSz97O3IYa8+4JY3AKBgVFhmIBCtkVzz2EiZ/OwoYthNqCFwPRgjhMeKFFpaMjkHlsd
         48Og==
X-Gm-Message-State: AJcUukcrb2bfG3Rf3CDUO/TTH4ZuNAwWdn4IEZt6EwiYxHE2CkNW4TIX
        dd1BCUL7RhxhBd2mLA8q22Y=
X-Google-Smtp-Source: ALg8bN6fDGTnbqFaHlQl0+6GECwpOyn40W0B9eBo/fFPWUB1W867SOUAclB4A30hmpYVhGK22npe+g==
X-Received: by 2002:adf:9484:: with SMTP id 4mr31932468wrr.98.1548181797518;
        Tue, 22 Jan 2019 10:29:57 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p12sm56193363wmi.5.2019.01.22.10.29.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 10:29:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Stephen P. Smith" <ischis2@cox.net>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 4/5] Add `human` format to test-tool
References: <20181231003150.8031-1-ischis2@cox.net>
        <20190118061805.19086-5-ischis2@cox.net>
        <xmqqtvi5kctv.fsf@gitster-ct.c.googlers.com>
        <3086071.UFgDplIbgl@thunderbird>
Date:   Tue, 22 Jan 2019 10:29:56 -0800
In-Reply-To: <3086071.UFgDplIbgl@thunderbird> (Stephen P. Smith's message of
        "Sun, 20 Jan 2019 15:11:24 -0700")
Message-ID: <xmqqh8e0h7ff.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Stephen P. Smith" <ischis2@cox.net> writes:

> Why don't I create a second patch set after I git this one to next for 
> relative to match your suggestion.  I don't like the idea of conflating two 
> topics.

I'd prefer two separate patches, too, and I'd prefer to see clean-up
first and then a new feature.

Thanks.
