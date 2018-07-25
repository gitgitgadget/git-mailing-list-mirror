Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0AA31F597
	for <e@80x24.org>; Wed, 25 Jul 2018 23:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbeGZA6F (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 20:58:05 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34510 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731401AbeGZA6E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 20:58:04 -0400
Received: by mail-wm0-f54.google.com with SMTP id l2-v6so735894wme.1
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 16:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aeXvCV65f2RuR0p/ixCGY6FWk8IRvXJK/mb8VCwYlM0=;
        b=gSgddzT0AKEz4szRCaohq1y8K9lpqY/OP2pwd9oJ57fvPQ/ZQUoEMarOwcdjuSt/TX
         FV35UdQpZAVPTxkXrOcS6m/F589ry7WqYRDybwmWTDCSS9zrLb5hy1jMbLiNvudizwtw
         QKvcwWGeJKFoSdDqSMHmA4bTtHR0eFBuHDDLvmWCajFKxuYLK2946edF5/Is9qtmOFgS
         jbbfYpz8IbhQ90K6cy0jnQR6v5LpA/awP2ItthL7VfFtPEsOibpeihoxalJEEXz6Ci6f
         ATXYOc6JPoVBZlrPgnDNhQ/4J5S9BjrpRFo5laIo7q0makRGHrKuyjQlTaBsDF9wLt6k
         Avng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aeXvCV65f2RuR0p/ixCGY6FWk8IRvXJK/mb8VCwYlM0=;
        b=FnvDwAsYs8qfncew2iUR+Q9CIxP/tHTKnwSwBn2SnSyQ6lp19/EVvn2f8soFRtZxqV
         vPKp7N30Y6QKvfT4omoKccYJJrc645+1aSiUzn/309/gKl5XffNAQi58J8ewhu8vd2D6
         M77WbjvzmtyFc8O7C0nJFohTRwZFYqhSg3jXpL5ZiANJ39FXR0+WP15Z4MqG2ylF4x1L
         oaFd4wF2rcIjfTnv3Jf9/L2NrvDKswMbVlKCi+Byjta1IRTuXxsmcxbkbLWdaaamFWdk
         sPjD6f3a6LpuaX0goarokOiTxGMkhY3P5DrgIxy3QYNZ/mgHwJxv+ClepR3yQnqW3JOo
         i/pw==
X-Gm-Message-State: AOUpUlFwT4wuQ3U4jjaMO+HMx2LWzLFy70pBR97bJXupgOq6cRSjeF57
        AGySRN/wzDEh7Zgg0dm83s4=
X-Google-Smtp-Source: AAOMgpdz7EI8WDv53Cn5RvPnpCKNZNUqS/m5z3xyHaHF7xIQonp3NSwjHrzkzLD18YcQEpB2WvVijg==
X-Received: by 2002:a1c:8313:: with SMTP id f19-v6mr49664wmd.144.1532562241776;
        Wed, 25 Jul 2018 16:44:01 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v15-v6sm61045wmc.16.2018.07.25.16.43.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 16:44:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2018, #03; Wed, 25)
References: <xmqqd0vbt14e.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kbO1KOfDgjT5duEd49MZ=EaYLtTDeg2efVO5kkO9QFx7g@mail.gmail.com>
Date:   Wed, 25 Jul 2018 16:43:59 -0700
In-Reply-To: <CAGZ79kbO1KOfDgjT5duEd49MZ=EaYLtTDeg2efVO5kkO9QFx7g@mail.gmail.com>
        (Stefan Beller's message of "Wed, 25 Jul 2018 15:56:17 -0700")
Message-ID: <xmqq4lgmubi8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> * js/range-diff (2018-07-25) 21 commits

> I think the current coloring is good enough to ship, but it still has
> errors around corners, for example introduction of new files,
> having lines in the inner diff as:
>
>      diff --git a/Makefile b/Makefile
>      --- a/Makefile
>      +++ b/Makefile
>
> will be colored white/red/green (in that order), but in the outer diff
> these are all "context", but as these specific context lines happen
> to start with +/- we color them.
> If we want to be perfect, we rather need to parse&understand
> the inner diff on a more detailed level, but I would argue to leave
> that to a later stage for another volunteer to step in and cleanup.

I think the primary part of coloring i.e. "white is common, green is
added, red is removed" together with "bold is new, dimmed is old" is
quite usable and not broken.  

The non-coloring part, like patch matching and driving diff over a
pair of "git show" output, looked reasonably solid when I read it
(even though I admit I did not audit for leaks).

The only thing I think we would be better off without is the
coloring of whitespace errors (at least in the current shape).  I
cannot shake the feeling that temporarily setting core.whitespace to
nothing (i.e. we do not detect any whitespace errors and hence we do
not show any) while running diff-of-diff may be a workaround that is
less damaging to the code base than piling band-aid on the codepath
that is shared with plain diff (not diff-of-diff).
