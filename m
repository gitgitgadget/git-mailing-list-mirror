Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F4201F453
	for <e@80x24.org>; Thu, 20 Sep 2018 14:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732466AbeITTwR (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 15:52:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43093 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730955AbeITTwR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 15:52:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id k5-v6so9536026wre.10
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 07:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UglD5jcc23HICFPPjOyXoNWk6RwzfKWMEfFN5q6khck=;
        b=SprxtB5IZDEK8iR8ZP5hOLZFZdVrHhn9Yr2i26gr2xuXjMp33q4b2lL2YwJhcE2aOu
         6FP6jcoNw023jN2RBr9OP5oBHLEYQmu8tETTb71vdn9p/tFEcE2wk2/kGe1/iTAUVhX0
         sooT67z7V8BzHVUoCD9K2CaRrmZvrDx3tCYY5gRePoGF50/gyVhhRr7kkJ283QJhdVSP
         jVFUmpMzR5kNVCcMp9q2gwVuOqj17q8rK2diYaLDw0DZEYjMxhLZOGqs06r6gBxPxfUL
         Pz91P5MEd7JxsmrqRvK1UKLBuOTPiwRfKYI/TJ+ogdlWeEH9EVhGOcaB6Cc+Sucgbe5w
         d2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UglD5jcc23HICFPPjOyXoNWk6RwzfKWMEfFN5q6khck=;
        b=LZUOJNFwg2eBR/ul9Kp8zlx5dUf8tb2Pl32OQ8AfkGIjS3Vr/ShCbC1RVf0XKAr1WM
         p/l/ozYmLj/0uWSKnpFqUmpl6KevZwiBZLpHCHyGESNm/iSE+M3rpfk93NQe0cIqGyt/
         1IZT86OeRSQSsLLZ9ROp4HwRo5Nz2LZxyU3je1Qm/1dM91jIVAkSD4voXjUUqbQH+dCk
         /hwlLrmIAvs29cpBNj3k/lsDK0iN48d9P2baU5aEpFDjCuoQvJSum9IhdDQms3iZgSAz
         pCCGrYokbElpRu7T2o73dI9eplsMGpjyaMp6uCY2jzeIxRVtwL4xrE73ZNTnUNdMX7Fq
         LRpA==
X-Gm-Message-State: ABuFfojQCiBwI83kIniDQaIOgl6MOf1zQzW2F8crg+pj2H5bLLvipHEj
        w1V9tkXimd+tJ94quNZ8MVFGTz/6
X-Google-Smtp-Source: ACcGV639mqaF0YRt5FxwyV/DHqAuqXsnOfRhPPpn50u8GxRcT9B6yFuq906mmx5QArah9Mspd0IdiA==
X-Received: by 2002:a5d:4912:: with SMTP id x18-v6mr2806799wrq.114.1537452516462;
        Thu, 20 Sep 2018 07:08:36 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t14sm4637063wrx.52.2018.09.20.07.08.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 07:08:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] Add an EditorConfig file
References: <20180917230307.588334-1-sandals@crustytoothpaste.net>
        <xmqqtvmm42es.fsf@gitster-ct.c.googlers.com>
        <20180920000013.GZ432229@genre.crustytoothpaste.net>
Date:   Thu, 20 Sep 2018 07:08:35 -0700
In-Reply-To: <20180920000013.GZ432229@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 20 Sep 2018 00:00:14 +0000")
Message-ID: <xmqqk1ng2rdo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I think "make style" and the EditorConfig file are complementary.  "make
> style" autoformats code into a diff.  I agree that if we always used
> clang-format to format code, then this would be a non-issue in the
> EditorConfig file, since we'd just tell people to format their code and
> be done with it.  However, we don't automatically do that, so I think
> this still has value.

Oh, we agree on that 100%.  These are complementary.  

My comment was that it would be confusing if they gave contradicting
suggestions to the end user.  After letting EditorConfig to enforce
one style while typing and saving, if "make style" suggests to
format it differently, it would not be a great user experience.

The ideal response would have been "Oh, of course EditorConfig folks
already thought about that, which is a natural thing to wish for,
and they have a tool to generate clang-format configuration from the
section for C language in any EditorConfig file---here is a link.
After all, tools like clang-format look like just another editor to
them ;-)".

But that is a response in a dream-world.  If there is no such tool,
I am perfectly OK if the plan is to manually keep them (loosely) in
sync.  I do not think it is good use of our time to try to come up
with such a tool (unless somebody is really interested in doing it,
that is).

Thanks.
