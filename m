Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E54F1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 20:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732156AbeHCWE4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 18:04:56 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51852 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731997AbeHCWE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 18:04:56 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so7455413wma.1
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 13:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QCxY6ZQifUBFGUbi218EoniGr+AFsLZ8VmLxC9agA4w=;
        b=NQDnJCy0ECYKHXbndi2NyoELxfS2mGW1Za97oThdCkrUSLAwIbW7TerCChvjIUUwTu
         +65q05ySSPuTqLz0HT/cPxhDMnQob2qBWYj9yJBizflFBb0TGVg6IuMvmhtKSqM4Il6g
         K+9PcvxQCEI3jRtMAQXvIlqCdELRj4DSYny6emJ8y7h9u0sx2KhIbmK6/WqKUPIjxBoN
         QKy8uRnywSj9WyVo9euZcCqLOYVy2a4BiE2EI/jSp2kax9R+Kas+shgP/uL8lhdptX6l
         0hcM/Q13jumK8LSVaHvLd+PoA0CoERpl+U/Q+mt+zULSEdLTVP6pqBYQPgXT7FllJNi7
         sCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QCxY6ZQifUBFGUbi218EoniGr+AFsLZ8VmLxC9agA4w=;
        b=ZBScZxydSqP6QCEcTXwl7oytDeMbFmMEaDXZnkJbgM2+XHuH3FN2MgRiKVtC1Kttda
         a9cMHsSQ8rUDUQNw/SEctT84Im1ycjLU27PLI7te3jpzzLzuXuoVcWRWSMhR2DcEik/j
         CuNsVUAzovjXyKXG1coMR/z8MYmA7uwnoQESN5e4gbGP5GPBybPTFF7Vgv6bz7mBYzF8
         7bKwk4lz2c9lxajjJAOL2utIy2uM6Z0ZmZWJnFyZ8OM8KEtxn+IwkersifEIa1wsAqvD
         x+EfQaQPan5luPQFpaCeXLX8NuHxhwEM41Jk8kNOBUVxe8Xb5KxJHq3fZsotxW/pAGtb
         lCJg==
X-Gm-Message-State: AOUpUlFShSeL3C02L8DwWOb6uOAOiekqwC1UFjFkJQeKoM+q79yBjQAX
        EBFBYvi6N+4YzNduWsPk48c=
X-Google-Smtp-Source: AAOMgpfOBn0+601EGkVy3Zhh0yclZKcdh+PXX3pTuqb+5AqPizHSNTN0xk83Eh3SMdYrIiTP4PJgWw==
X-Received: by 2002:a1c:93d2:: with SMTP id v201-v6mr5703025wmd.77.1533326827732;
        Fri, 03 Aug 2018 13:07:07 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f18-v6sm3619650wrt.64.2018.08.03.13.07.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 13:07:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2018, #01; Thu, 2)
References: <xmqq4lgcz81f.fsf@gitster-ct.c.googlers.com>
        <20180803180912.GD106068@genre.crustytoothpaste.net>
        <xmqqwot7wayf.fsf@gitster-ct.c.googlers.com>
        <20180803184508.GE106068@genre.crustytoothpaste.net>
        <xmqqo9ejwag9.fsf@gitster-ct.c.googlers.com>
        <xmqqk1p7wa7t.fsf@gitster-ct.c.googlers.com>
        <20180803193256.GA164578@google.com>
Date:   Fri, 03 Aug 2018 13:07:05 -0700
In-Reply-To: <20180803193256.GA164578@google.com> (Brandon Williams's message
        of "Fri, 3 Aug 2018 12:32:56 -0700")
Message-ID: <xmqqftzvw6xi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> [1] https://public-inbox.org/git/CAGZ79kYGS4DvoetyGX01ciNrxxLCqgXoVSpLhmgYZ8B51LzhSg@mail.gmail.com/
> This mail seems to counter that indicating that the "What's Cooking"
> emails should not be used as a status update.

You are the second one who were negatively affected by Stefan's
"summary" that reads a lot more in what I said than what actually
was said by me.  Stop paying attention to that message, but do go to
the original if you want to hear what I actually said.

The mention of "discussion thread on the list is the authoritative"
was said in the context where somebody refuted these "cf. <msg>" on
a topic and I got an impression that it was done in the belief that
doing so for each and every "cf. <msg>" would be enough to exonerate
the topic of all the issues.  I was explaining that they were not
meant to be exhaustive list, but rather are my personal reminder so
that I can go back to the thread to recall why I said things like
"Waiting for review to conclude", "expecting a reroll", etc.; as I
do not need to point at all the review comments that matter for them
to serve that purpose, these "cf. <msg>" must not be taken as the
"clear these and you are home free" list.  To cover all the issues
pointed out in the review process, you must go to the original.

"What's cooking" primarily serves two purposes.

 - After list of patches in a topic, I try to summarize what the
   topic is about.  This is to become merge commit message for the
   topic when it is merged to various integration branches, and also
   to become an entry in the release notes.

 - Then an immediate plan like "Will merge to 'next'", etc. for the
   topic is announced, optionally with comments like "cf. <msg>" to
   remind me why I chose to label the topic as such.

The former is outside the topic of this thread, but both are *not*
obviously written by everybody; the former is my attempt to
summarize, and people are welcome to improve them.  If my attempted
summary is way incorrect, that might be an indication that the
topic, especially its log messages, is not clearly done.  

If my immediate plan contradicts the list concensus, it likely is an
indication that I missed the discussion, and it is very much
appreciated for those involved in the discussion to correct me.
That may result in my dropping a "cf. <msg>" when an issue I thought
to be blocking (or to require the topic to be fast-tracked) turns
out to have been resolved already, or adding another one when it is
pointed out to me that I missed an important issue to block (or
fast-track) the topic.

Hope this clarifies a bit of the confusion caused by that summary.



