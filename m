Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46BC51F597
	for <e@80x24.org>; Fri, 29 Jun 2018 19:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936275AbeF2TvX (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 15:51:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35423 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935467AbeF2TvW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 15:51:22 -0400
Received: by mail-wm0-f67.google.com with SMTP id z137-v6so3181349wmc.0
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 12:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=li73ZQndSlNdtv6TW6JvWno1ERjdorIBm8uLBRsKKys=;
        b=ViggPpwWjFOsz2gbkVL5vR8fQ0+Wbh/aciqT1vt6MAdjR9dbby02qTOPlm/UCIiisD
         bWuxC/Hqfbx0ZHpoUQ2JS28M+BYbcj6uVZWuS+JjZAcNCd4RU7Q16g4ONQJLKFNAhAZ1
         EXFe3UErrkH6hqci9OaidscliAQkmAM6fvduXOIJYg7KMx7W3lfZQqQ6wfCkoKCkabiv
         qsvaIQVFmUhur6wWvQJaAgxQHI+zk8/O4OCsr8IX0u+SmCe1qRcGqUxpkfDJY6oPi5aY
         9WV4aqFSLVFHIXgb0L2VcS49CaLa2Rm3KmONmJOX7ll+8JAKejMf+yVQPlEEu90ypnaK
         hWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=li73ZQndSlNdtv6TW6JvWno1ERjdorIBm8uLBRsKKys=;
        b=fh5/mqp5IXLTXHL7R/a6kLNjAzXHLeAQ7sIe9UY1HvATTqdYU4eqY3jSP8HgYIOGwg
         LVyaVii5oGLtuowxvCWs9GkiQqKSdLnUXfbc8G0LJx4bCndNrUfuMa8qL3Fd1nCGbJzY
         BA2S67N4nMVJ8qRsCnsdzzcrwuXTW7u0ZUAy68TYk61AZpwsB7lxPCrm9bBlENbNP239
         Ro43EwnucweQuyBY4TiEqOZT39iEIDUmfRyLTHTR3LT4N7x5h/3Tusxdz2DJFhXWHyDg
         xR2cYRdLIMLkvebpDvHg38HqKiSgVVy6Zj5Mxchfm3HIGkIj16yLWhw+KuyFCfi3iSql
         9e5w==
X-Gm-Message-State: APt69E3AJ1kgLeEieh7bpWNWWMHuGuohxC1J5ljCjSeyntkLeNhcIUzn
        wxoPY6eTeTaWKXe/Lf2Jdq4=
X-Google-Smtp-Source: AAOMgpfHWX1QMCUGU+Bl49MZ9tnPUwjpSHTwGqvEGAfkzfhk7DH9GWl5M3yQlxhv4qs4Iz/SLaaWvQ==
X-Received: by 2002:a1c:b6d6:: with SMTP id g205-v6mr2889904wmf.17.1530301880944;
        Fri, 29 Jun 2018 12:51:20 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d15-v6sm2515337wmb.0.2018.06.29.12.51.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 12:51:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jun 2018, #07; Thu, 28)
References: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kbKrDu8iW+867c73OMhgqEYA1H3-zQpejxq5jMMNRb2Bg@mail.gmail.com>
Date:   Fri, 29 Jun 2018 12:51:19 -0700
In-Reply-To: <CAGZ79kbKrDu8iW+867c73OMhgqEYA1H3-zQpejxq5jMMNRb2Bg@mail.gmail.com>
        (Stefan Beller's message of "Thu, 28 Jun 2018 15:42:57 -0700")
Message-ID: <xmqqk1qhtlqg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> * jt/remove-pack-bitmap-global (2018-06-21) 2 commits
>>  - pack-bitmap: add free function
>>  - pack-bitmap: remove bitmap_git global variable
>>
>>  The effort to move globals to per-repository in-core structure
>>  continues.
>
> This is mostly done, though Peff seems to expect a reroll with
> clarification on how the series is structured?
> https://public-inbox.org/git/20180611211033.GB26235@sigill.intra.peff.net/

That one has been resolved by squashing the updated log message in,
I think, so we should be able to merge it down.

>> * sb/submodule-move-head-error-msg (2018-06-25) 1 commit
>>  - submodule.c: report the submodule that an error occurs in
>>
>>  Needs a reroll.
>>  cf. <20180622081713.5360-1-szeder.dev@gmail.com>
>
> https://public-inbox.org/git/xmqqmuviq2n7.fsf@gitster-ct.c.googlers.com/
>
> suggests that you applied that change and a reroll would not be needed.

Yup, I forgot about that one.  Thanks.

> It is easy to quantify how often we are bitten by code churn
> (that you call useless here); and very hard to quantify bugs

By definition, churn is useless.  Useful ones are refactoring ;-).

And when you do want to operate on _the_ single in-core instance,
not having to say &the_index in the argument and use $foo_cache()
function does *not* become a source of "bugs".  It just saves
typing, and turning it to $foo_index(&the_index,...) does *not* make
it less error prone.

>> * sb/diff-color-move-more (2018-06-25) 11 commits
>>  - diff: fix a sparse 'dubious one-bit signed bitfield' error
>>  - SQUASH??? t/4015 GETTEXT_POISON emergency fix
>>  - SQUASH????? Documentation breakage emergency fix
> [...]
>>
>>  "git diff --color-moved" feature has further been tweaked.
>>
>>  Needs to be cleaned-up with various fix-up bits applied inline.
>
> I'll resend with those squashes and another (test-)fix SZEDER
> mentioned soon.

The interdiff of the topic looked alright.  Thanks.

