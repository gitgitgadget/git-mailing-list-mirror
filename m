Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A7221F453
	for <e@80x24.org>; Thu, 27 Sep 2018 17:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbeI0Xzi (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 19:55:38 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:43664 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeI0Xzh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 19:55:37 -0400
Received: by mail-wr1-f44.google.com with SMTP id z14-v6so3500828wrs.10
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 10:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qIXyHrHVgVpg9fO7JWBSotFHy4XC2Z3d/aw5sHrPrLU=;
        b=eWCa23kcFg8YJugx9NFKLRUndn9aGFmTgtSPfUDBdemiSY13364eaLqmIVFxrvBOGI
         xPjEWpq6inzx7N7q5FIi1x1+AWZ/B33rzTcbeN4s8tUuTTePitDi9grIzWYv5TbhJHdH
         CjmHF71v4uauovrEDZcBcKk3E//Ut3jNXggu28eZupUv8M54X98QzYEsTcqgxgH4KtC6
         tMMFAHsMtsUYiXuasIroOCs9385wSTZ16mZyJiOKHnXSu5sIOu/rJEeztNO2jFEf5aJC
         fl+uCbw2t/9xeovPqXjAh6I24pfZJykmShARJCxDYOnsevc6G/5t1Ukdc89obCyTLpr2
         hyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qIXyHrHVgVpg9fO7JWBSotFHy4XC2Z3d/aw5sHrPrLU=;
        b=Sh/anMrnXkD34KBpIF2i64/CWGBN3eDJUHoZ0GCYJxM+e8KetHSAvNyXktVmDWVnTl
         IRJxolM9IWbfLvpxWqOGXy73MmBa2NeRFTU2BFP35Hp0JKGEIT1MzQlpqeyUjCQG4eN7
         impKvoBcvYgwHYSgWZKPWS+SY1EbflQd8t2a4lRA+QSh/R+hVNDaFpOUM4c72fGcGZF1
         2kNcV1Q6zcukV8D1/zqaMXfQ1xUU0K8SUichnH5IO5qzs6vKNKXLwijVYgcPhmezptsk
         DOD7SKN9cvuQ9tywLf+AYPEQfZ/wYVM9cNoyuw1Ooc968e0dqd6/j26lLI1srfRx56BV
         9+Lg==
X-Gm-Message-State: ABuFfogEmXyutF7wS+tRAEmz/tilz14YUN9AbQJkPCOVe33ssMqBh1NS
        KpPeM6zaLwbrPzSyxPxMQibdXSSg
X-Google-Smtp-Source: ACcGV63rSsvIdSAANPdRS4bC6dYvLn2STZhcw4SPNilc4DskFp7jVD9nxti5wqqR9T/UvrFDWKoMww==
X-Received: by 2002:adf:ae5a:: with SMTP id u26-v6mr10002737wrd.246.1538069774976;
        Thu, 27 Sep 2018 10:36:14 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c8sm1643491wrx.92.2018.09.27.10.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 10:36:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: On shipping more of our technical docs as manpages
References: <20180921223558.65055-2-sbeller@google.com>
        <87h8ihk7sl.fsf@evledraar.gmail.com>
        <CAGZ79kZCkccV=4a1cAE0DpV7hZGxuCyJuceyAEow_u0LspwYAw@mail.gmail.com>
        <20180926041517.GA2140@sigill.intra.peff.net>
        <xmqqlg7ombgt.fsf@gitster-ct.c.googlers.com>
        <87d0t0jghm.fsf@evledraar.gmail.com>
        <xmqqd0t0ktau.fsf@gitster-ct.c.googlers.com>
        <87a7o4je0t.fsf@evledraar.gmail.com>
        <20180926185812.GD30680@sigill.intra.peff.net>
        <878t3oj8em.fsf@evledraar.gmail.com>
        <20180927062011.GA1318@sigill.intra.peff.net>
Date:   Thu, 27 Sep 2018 10:36:11 -0700
In-Reply-To: <20180927062011.GA1318@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 27 Sep 2018 02:20:12 -0400")
Message-ID: <xmqqwor6hmgk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If you're interested in pulling documentation out of the header files
> and generating asciidoc from it, I'm happy to at least try keeping it up
> to date. When we started putting this information into header files, we
> used "/**" to start the comment, as a special marker to indicate it was
> worth pulling out. I don't know how well we've maintained that
> convention, but it's a starting point.

I noticed some people add these extra asterisk at the beginning of
comment, but I do not recall that we declared it is a convention we
adopt, so I'd rather be surprised if we've "maintained" it.

Please have it in CodingGuidelines or somewhere once this thread
settles and we decide to keep that convention (I have no problem
with the convention; it is just I personally didn't think it was
worth doing myself at least until now that we might have found
somebody who wants to make use of the markings).
