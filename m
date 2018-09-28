Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A21001F453
	for <e@80x24.org>; Fri, 28 Sep 2018 16:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbeI1XO5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 19:14:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34753 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbeI1XO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 19:14:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id z4-v6so5728203wrb.1
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 09:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=47ygUmpwypn123pOeR63MfF2YxI5+uPemhRa8HyjlQw=;
        b=hvKKvHNQQP+DlgExGGv9W+9HSOJRXPha2VaIR7je5J1Ro35vdexIGj2VMzh13l1RA0
         XhwmvNWKNVNK7nyJ6oxGzKOVllhBbREPH4I1+nTDa1lz81NA/VGXrC31DvJedY0zJrpq
         d0k6mJmOv0QcWzslA+4hjlvO/nPbGU7QWms0gi1j060HNwursHmyZZlIb8BbiKRN/S+8
         BvlZnXqbSPMsTZI0G/HpHIh+KtcB8Ht5s86VCIY2RxLO+NQU2M/SDwopOnvpX4sHE6/Q
         gH9E0w2nbjcAlDevqLrjuW7FeyI+LVKOF4P08D0jKbAPd0wBie8c5MiRB1c6ey5tb47q
         /erA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=47ygUmpwypn123pOeR63MfF2YxI5+uPemhRa8HyjlQw=;
        b=Nf/336PNrtCYXb7We/Bm3Hk86laviRWL/GWHvEFseyE4reU42JUCj7fjYwTvp5Log1
         gagcZnA7avorD869UkUoVTAIWtwV1vAfOLdZuyeBcD21+aVYJtjnHkTa08N50lhqSv9T
         Ye7S5/bSz/44m5YfyIHx0GVGJ3//nGSTgpX78amajomzGi1mCZn/zLX6ceAKtju0mH+1
         NlEo4BdkCo/QOrYoOOKuzMK0Jeb6ZzDPlBC7SJcJx8kGsjPKb0n+re62qV7xGEEvGwhe
         BMZWYLtJdWKNq5aSwZce//TNuaxaDMY2O7HTG6rIgSCcxlWfhMu5x1hAxYFzm4I/n6Ht
         M7vw==
X-Gm-Message-State: ABuFfogtZy7H+iPMyX1cTTGafxw/BwqJPW/dY3UHcLkId9lLD9Qp2ri2
        nVqjKRQjKyC+wMX8r9SogQo1lKrI
X-Google-Smtp-Source: ACcGV63Zb+CgkW4YwIg0f6edYf3hpF/SOtlRoYlJ2VaGh8QIKML2c2s48AMa0/3fcqdxtIS1KBSHTQ==
X-Received: by 2002:adf:ec11:: with SMTP id x17-v6mr10903575wrn.266.1538153417615;
        Fri, 28 Sep 2018 09:50:17 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u191-v6sm2727567wmd.31.2018.09.28.09.50.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 09:50:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, avarab@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH] Documentation/CodingGuidelines: How to document new APIs
References: <xmqqwor6hmgk.fsf@gitster-ct.c.googlers.com>
        <20180927212727.128214-1-sbeller@google.com>
        <20180927232732.GA216193@aiede.svl.corp.google.com>
        <20180928011129.GD11281@sigill.intra.peff.net>
Date:   Fri, 28 Sep 2018 09:50:14 -0700
In-Reply-To: <20180928011129.GD11281@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 27 Sep 2018 21:11:29 -0400")
Message-ID: <xmqq5zypefcp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Sep 27, 2018 at 04:27:32PM -0700, Jonathan Nieder wrote:
>
>> > There are different opinions on how to document an API properly.
>> > Discussion turns out nobody disagrees with documenting new APIs on the
>> > function level in the header file and high level concepts in
>> > Documentation/technical, so let's state that in the guidelines.
>> 
>> I disagree with this.  I think we should put all the API docs in the
>> header file, like we're already doing in e.g. strbuf.h.
>
> Me too.
>
> I think other high-level concepts that are _not_ APIs (e.g., file
> formats, protocol, etc) could go into technical/.
>
> (Though actually, those are the thing that I would not mind at all if
> they get formatted into real manpages and shipped to end users. We do
> not expect most users to dissect our file-formats, but they could at
> least be useful to somebody poking around).
>
>> Do you have a link to where in the discussion this split-docs strategy
>> was decided?
>
> I think the purpose of this patch is to spur people towards a decision.
> :)

OK.

-- >8 --
Subject: CodingGuidelines: document the API in *.h files

It makes it harder to let the API description and the reality drift
apart if the doc is kept close to the implementation or the header
of the API.  We have been slowly migrating API docs out of the
Documentation/technical/api-* to *.h files, and the development
community generally considers that how inline docs in strbuf.h is
done the best current practice.

We recommend documenting in the header over documenting near the
implementation to encourage people to write the docs that are
readable without peeking at the implemention.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 6d265327c9..e87090c849 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -385,7 +385,11 @@ For C programs:
    string_list for sorted string lists, a hash map (mapping struct
    objects) named "struct decorate", amongst other things.
 
- - When you come up with an API, document it.
+ - When you come up with an API, document it the functions and the
+   structures in the header file that exposes the API to its callers.
+   Use what is in "strbuf.h" as a model to decide the appropriate tone
+   in which the description is given, and the level of details to put
+   in the description.
 
  - The first #include in C files, except in platform specific compat/
    implementations, must be either "git-compat-util.h", "cache.h" or
