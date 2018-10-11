Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4D4A1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 02:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeJKJZm (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 05:25:42 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:40627 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeJKJZm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 05:25:42 -0400
Received: by mail-wr1-f41.google.com with SMTP id d2-v6so7776237wro.7
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 19:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=L+nou+N7b7k23zlw47ylYEDrzczHyGBuueUJdFh6Rds=;
        b=SpTXwtGVoJjU37JRmGhcRildgOfOanjsYpqpUW/NMQOvld3X5q33sb2ygApp8vEvpe
         LdpsNEnzLycP0t6EolAA17IGG4co3aj5Qz9CLddqBOiqz7AvHa0tugsTHLIPq3FwExzI
         nH/tkBkVB1+ZPvOkkDnwqBQsSIHO4UZoxvXxzBmaZhBr+Gczwa2p5mbwqRCgx/nlVRkR
         MIKcCQcCubhXbuNf1aAVKoTdAYRjIo9FNQ3f6DmL6Mh5mgqnhL2P1u5yS+/t5BCs5uKt
         u4DR51gj02bLSRavbqYSvitB2eRtUjxww8NNlmMSjo7owibtOfRm9yKnwnvlp4+J0v2X
         SClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=L+nou+N7b7k23zlw47ylYEDrzczHyGBuueUJdFh6Rds=;
        b=sX6vk9F6YdqmKUl03V7NyWuzZ3cgzdtjaJRdJkxSz8RbNpZA9BZO+WNAGQawJmvyAR
         WCmXZhaUZz+cT3OzxO6ZU6w/wY1/V3aPBSc7YKVesvBm6i9H/44htw7cpMVYibcTRuKG
         VBf8qEyuYWMxqct6q1K/I9ZOboieBMj/ckUhhejTVtDszkEhz4dnbyaIYN2TeayO1d03
         RBDCFl8zUXHPbg09F8zEWLlWlWieKraIbZbdM6v9PzGTpubde58elVQrVpmX+htBC/Ej
         BL7rayLJAwrk7GtAfoewNKavkrKn1MVnbSZOMmQO7kILpjvUz3goGrjjKQIiz9sX+d1Q
         U9bQ==
X-Gm-Message-State: ABuFfohuFS6lgN8W13l69qbXWjmV6XR6BlhGocthMpNqfpmSCGEKhUQq
        2KaoJuOjPuW8UvrrOHI/w28=
X-Google-Smtp-Source: ACcGV63EDkZ5dzIV7EGI3/yzoTg9io46g6hqDTHhZv7tbV6XXd8fFh7eNTsRFDLrd7Sma4jr1xTWXg==
X-Received: by 2002:adf:f2d0:: with SMTP id d16-v6mr26894765wrp.258.1539223244490;
        Wed, 10 Oct 2018 19:00:44 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k25-v6sm46485305wre.18.2018.10.10.19.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 19:00:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Oct 2018, #01; Wed, 10)
References: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kYJGMOtroLhPwOdhWewXf3X_b0QOgiUb65pyJ7xJ-whQw@mail.gmail.com>
Date:   Thu, 11 Oct 2018 11:00:42 +0900
In-Reply-To: <CAGZ79kYJGMOtroLhPwOdhWewXf3X_b0QOgiUb65pyJ7xJ-whQw@mail.gmail.com>
        (Stefan Beller's message of "Wed, 10 Oct 2018 11:55:51 -0700")
Message-ID: <xmqqa7nli6np.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> * pw/diff-color-moved-ws-fix (2018-10-04) 5 commits
> I would suggest merging to 'next'.

OK.

>> * sb/strbuf-h-update (2018-09-29) 1 commit
> The patch as-is just adds names everywhere.
> I'd be happy to resend with either
> (a) not enforcing names everywhere, but only as needed or
> (b) having names everywhere, capitalizing them NAMES in
>     the doc comment.
>
> I am tempted to ask for
> (c) take as-is, defer the rewording of doc strings for a follow up patch.

As long as the planned update eventually comes before all of us
forget, (c) is fine by me.  I'll mark it to be merged to 'next' for
now, and follow through that plan, unless somebody else stops me
before it happens.

>> * sb/submodule-recursive-fetch-gets-the-tip (2018-09-12) 9 commits
> Will resend after a local review.

OK.

Thanks for helping me in updating the status for various topics.
