Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98BC61F453
	for <e@80x24.org>; Wed, 24 Oct 2018 03:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeJXLpo (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 07:45:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39043 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbeJXLpo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 07:45:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id y144-v6so3749270wmd.4
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 20:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lDLOTnHEHZXdNsYIwz5NY/GNoSidkl6UN2SQI2wLGe8=;
        b=ZYbajAY50UZY2hQuj4HPkROftu/GmiLivHALpXX/bTWcKbFv1Xv48ecrdGr5VuKY71
         oqMZ7kHviTu6wWjLDk5ZwWV4OKJtzulzTcLLPmJlF0jK006vMxugoX9rYtT4b0wmngQr
         oj4n11FXunv5cIHJ2sow0gEAO48rneI3OzRZYxkM9tZuEci0n8Du0ZKD04i3tEaJrSnF
         J5cFkPSnccqjOb4J8vFbYKHn9y+SFVbmg+Xw5IF2NIOZHeLzGPUqdxS2F4dYlpulZTuP
         Ftsbld2WhlRBM5laGHRfx7ih4ckDYHJldkQJEy/pAe6NiCG5ZlBQbcTEJugmNt2MA6jc
         0bnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lDLOTnHEHZXdNsYIwz5NY/GNoSidkl6UN2SQI2wLGe8=;
        b=EnSXeLwA+oF4+ElILggc14Z0PLm23QcqYAzXc0VCadhhtV/mBaMFwlKIfW2n2QW3R8
         4X3SVPnC+D3eO20/rR0Y7byQAwXVOrvp623I7uVN9ir+agmiApInXlWBO4hozzdTfh3m
         ujP7mUhA2gRWQO3Mtz85lefLa0KWjB2a9Urkd+rBmBson1MK7Gng3gV4gGvDT171AYmb
         UqQYaRg0DI5M2oW7c/gH0Atz54jrapJbA2KJVKbZyA5KP7R48PU5DSkNtmHHp7fKuBBA
         +Pa5lX8LDzN9qtO3hYXtU2EnRPkAza2K3mAKB3Q6yMHp2Pi+Qh4CZmO6GJkGjXLRAlml
         xEsw==
X-Gm-Message-State: AGRZ1gJG2lEdCDwB2vmn8FXTLzLGFekI9Xu10FtYQo8Jq3ChQ8NEvOjU
        4aYXobQIjmltPXmu9srUE8lectXNSUM=
X-Google-Smtp-Source: AJdET5dhAI4DD9EKFnp4OTdSv6BJsonds5oHC0reE3DSNZ4I93gYHFjeyKVk/qbxlX+ut6sBOagnQg==
X-Received: by 2002:a1c:7f83:: with SMTP id a125-v6mr434288wmd.23.1540344140252;
        Tue, 23 Oct 2018 18:22:20 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b8sm3062913wrx.97.2018.10.23.18.22.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 18:22:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: New semantic patches vs. in-flight topics [was: Re: [PATCH 00/19] Bring more repository handles into our code base]
References: <20181016233550.251311-1-sbeller@google.com>
        <20181022173935.GG30222@szeder.dev>
        <xmqqzhv5tx4m.fsf@gitster-ct.c.googlers.com>
        <xmqqefchroj4.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kZO6tAUOjO4YCostLmogGSwMmxGHj7g1kM1fNJWqJoFUA@mail.gmail.com>
Date:   Wed, 24 Oct 2018 10:22:16 +0900
In-Reply-To: <CAGZ79kZO6tAUOjO4YCostLmogGSwMmxGHj7g1kM1fNJWqJoFUA@mail.gmail.com>
        (Stefan Beller's message of "Tue, 23 Oct 2018 10:30:40 -0700")
Message-ID: <xmqq5zxsrvef.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> Anyway, even though "make coccicheck" does not run in subsecond,
>> I've updated my machinery to rebuild the integration branches so
>> that I can optionally queue generated coccicheck patches, and what I
>> pushed out tonight has one at the tip of 'pu' and also another at
>> the tip of 'next'.  The latter seems to be passing all archs and
>> executing Windows run.
>
> That is pretty exciting!
>
> Looking at the commit in next, you also included the suggestion
> from [1] to use a postincrement instead of a preincrement and I got
> excited to see how we express such a thing in coccinelle,
> but it turns out that it slipped in unrelated to the coccinelle patches.

See below, which was sitting in my working tree.

> How would we go from here?
> It is not obvious to me how such changes would be integrated,
> as regenerating them on top of pu will not help getting these changes
> merged down, and applying the semantic patch on next (once
> sb/more-repo-in-api lands in next) would created the merge conflicts for
> all topics that are merged to next after that series.

Conflicts with later topics is indeed worrysome.  That is why I did
it as an experiment.  If it becomes too painful, I'd probably stop
doing it while merging to anything other than 'pu', and then we can
follow the more distributed approach along the lines of what Szeder
suggested, to see how smoothly it goes.

-- >8 --
Subject: [PATCH] cocci: simplify "if (++u > 1)" to "if (u++)"

It is more common to use post-increment than pre-increment when the
side effect is the primary thing we want in our code and in C in
general (unlike C++).

Initializing a variable to 0, incrementing it every time we do
something, and checking if we have already done that thing to guard
the code to do that thing, is easier to understand when written

	if (u++)
		; /* we've done that! */
	else
		do_it(); /* just once. */

but if you try to use pre-increment, you end up with a less natural
looking

	if (++u > 1)

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/coccinelle/preincr.cocci | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 contrib/coccinelle/preincr.cocci

diff --git a/contrib/coccinelle/preincr.cocci b/contrib/coccinelle/preincr.cocci
new file mode 100644
index 0000000000..7fe1e8d2d9
--- /dev/null
+++ b/contrib/coccinelle/preincr.cocci
@@ -0,0 +1,5 @@
+@ preincrement @
+identifier i;
+@@
+- ++i > 1
++ i++
-- 
2.19.1-542-gc4df23f792

