Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F6641F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 01:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750737AbeFABmE (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 21:42:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40114 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbeFABmD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 21:42:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id x2-v6so49593136wmh.5
        for <git@vger.kernel.org>; Thu, 31 May 2018 18:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GrhBu/krZOHDULR4M8pxQYbdyVof1ojPOY4YRUZ+6Z4=;
        b=py/8Npj5D8K0TMSCZKF5t+C6TK4Vs28gbVqcVZ9CDogyHZ7Reph6AFN9l10BgI0p3y
         fRApytWcPclxH+VXMtb8zQhhf8/dEhMpQky4FtP1b/jszWn1rmCxZR0NLoD95MphMdZF
         P1ez2rq4vagdZGC5sALOn1lGM8r65KiWc2qnuNpuDn8/nZ1pzk4j90Flzc0YDsj1BVje
         PIQy/WjNFmtucLi3LiVc249YrJnhUyTysvZXIi9fFRHmAsZZqtHuHOg138QrMI9MdrI7
         iQfUH6KBACj9asXv5v9lx3Esv7QyiNmA6/aMJul49O+i9bFYuw9He8Vf8Ha8bOHIav3Y
         CARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GrhBu/krZOHDULR4M8pxQYbdyVof1ojPOY4YRUZ+6Z4=;
        b=UEcEOwGYZYP8ZFrpiiFnw8gg1pMNSXGyKAFWzAGJvnOe47ux3XVxOXum+KLsP8rbJJ
         +lEciBc0WF5Y1PyGNhCWfPRUt/mD7PjuHCgwxx6voRec4xTFCfFz93M8gWgUAoYq/V4a
         9uo6lzlPvOlRvD5MWfSaOsVCLgxBiqwEFwzoyiH+MPbcJzmT+wWx0OjnayL/o3wM2LvR
         CmColb2whSl6Tq0Rw6HFQJg5KbSOaDkCa/KWxNnM0RWYAQl0eBeUFDmScZHJr2ZoBEtS
         fgExMKrCu2yy+vF0855q7fWQ7aYAw0TF0yxH9h/VnBzbvkQpXC1rl1cqOhgg00UWvM3/
         e0hw==
X-Gm-Message-State: APt69E1WHtKtGRFWL4mn/9DHO3yFw2RVkQjZo3tkRxD7oZP1h2dLD6Ll
        l3s4YOCFDD81eKsECbkY3y865otq
X-Google-Smtp-Source: ADUXVKLVGQq6m2zhXHOFLECwVKXxY88zSZQui+98b2LCumMcwvwQLrP77ZGW0e6MFb0+Zq+OUwBPCg==
X-Received: by 2002:a1c:7153:: with SMTP id m80-v6mr1165955wmc.7.1527817322239;
        Thu, 31 May 2018 18:42:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b185-v6sm561509wmb.25.2018.05.31.18.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 18:42:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] fsckObjects tests: show how v2.17.1 can exploit downstream
References: <20180529211950.26896-1-avarab@gmail.com>
        <20180529212458.GC7964@sigill.intra.peff.net>
        <xmqqk1rmexng.fsf@gitster-ct.c.googlers.com>
        <20180531060259.GE17344@sigill.intra.peff.net>
Date:   Fri, 01 Jun 2018 10:42:00 +0900
In-Reply-To: <20180531060259.GE17344@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 31 May 2018 02:02:59 -0400")
Message-ID: <xmqq4linb7vb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I haven't tested it, but I suspect that doing multiple fetches could
> result in passing bad objects through a fetch.fsckObjects filter.
> Because the objects aren't quarantined on fetch, and because
> fsck_finish() requires the objects to be installed into place, they may
> ...
> I think in the long run fetch should implement a similar quarantine
> procedure to what happens on push.

Interesting.

I wonder if we can teach quickfetch codepath to notice the presence
of fsckObjects, instead of doing a full quarantine.  We can easily
enumerate those objects that were already in the object database but
outside of the reachability chain before we pretend that we fetched
them and make them reachable, and check the content integrity of
them, no?


