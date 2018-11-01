Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E95B1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 23:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbeKBIvF (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 04:51:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55135 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbeKBIvF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 04:51:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id r63-v6so485789wma.4
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 16:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zaZhaWLM+990iAYVQgZIGzDeOiIyArryL3660qV+CjU=;
        b=dHkwR3b4VOYd9sAPgVvEQSHESR9Uci+a5qCy7flu8a10AMVVKK/N3ASgcd9eiKlYZ3
         Gw+Erjy2Y14VzXskg7IgJfhE+FkZ9tz+gBzDGjkSa3bhUJMudLDwIlZW880T4/nveWSG
         DeD7eLPiDF73TX9e2uJiVDNl9OOviaJeHhLfAOqaSvPh7tccbvMt1LOtGnyukHPPwsMI
         ElblffqDY4i95FVKe2bNnx+NypJcnDH1lU2PuF6sCeTKJLvSi3DB55ToRdTY02hLVwNp
         Beum9SgAKLehka2mUne1NMNjZDI1w8+lLoYhFpWkcJGvqXtoEnQAGC1TM4S9tvAxoGUB
         hw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zaZhaWLM+990iAYVQgZIGzDeOiIyArryL3660qV+CjU=;
        b=o6dwcM+X1g6STfkmBa1iu8hpVbZwLRApN9h86D1jT0aUvGMb3fvvnM4r6gHVRGGD4k
         tdgIucuZzCYQOGAy+6YOyGngCV4FAQDO0OKii9mOZWWva8zmgRt2e8BnnsfGUGLj4IuV
         jpxbiKImInZ49Cn6Mq7N6grIlKWUilAkqD0W0Qng4LYX+h2f6r1ykNTv6WKfad+sX4U5
         YfkTLF6fZTkAVIFStz0eBzQ/WRxfQtt69cRanbJVW4xUeqCfJFR9fQSb9979pMomOWoM
         rHQvAraWuiI6z/ZnebNRrbjSb5WpgW22hyE8KBn6inbyyqLnkYDug+PIMEh9fLv3caIY
         aJOg==
X-Gm-Message-State: AGRZ1gItph1ZUdwiSW0qOfF4DZa3NtHsgegA8waBThkw8puAg4wGGu9n
        meIcYpiMZCY+eWbT83jyPkk=
X-Google-Smtp-Source: AJdET5f5WgdC2W7F5qacEfZadbmNEJtDOzIY2of+Hn/6u73HUM6yiWxK2l1wP6BvpDg43VlPdaepdA==
X-Received: by 2002:a1c:dc86:: with SMTP id t128-v6mr6931983wmg.111.1541115957234;
        Thu, 01 Nov 2018 16:45:57 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o9-v6sm15624780wrq.55.2018.11.01.16.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 16:45:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] tests: optionally skip `git rebase -p` tests
References: <pull.63.git.gitgitgadget@gmail.com>
        <39734e4805cbd695cd69e7c1a3016de629ac9b3c.1541016115.git.gitgitgadget@gmail.com>
        <xmqqh8h1tjg9.fsf@gitster-ct.c.googlers.com>
        <da1d00b5-8516-6185-60cf-cc7738daa1a3@kdbg.org>
Date:   Fri, 02 Nov 2018 08:45:55 +0900
In-Reply-To: <da1d00b5-8516-6185-60cf-cc7738daa1a3@kdbg.org> (Johannes Sixt's
        message of "Thu, 1 Nov 2018 18:18:00 +0100")
Message-ID: <xmqq4ld0tl8s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 01.11.18 um 07:12 schrieb Junio C Hamano:
>> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
>> writes:
>>
>>> The `--preserve-merges` mode of the `rebase` command is slated to be
>>> deprecated soon, ...
>>
>> Is everybody on board on this statement?  I vaguely recall that some
>> people wanted to have something different from what rebase-merges
>> does (e.g. wrt first-parent history), and extending perserve-merges
>> might be one way to do so.
>
> Maybe you are referring to my proposals from a long time ago. My
> first-parent hack did not work very well, and I have changed my
> workflow. --preserve-merges is certainly not a feature that *I* would
> like to keep.

Thanks, that reduces my worries.

> The important question is whether there are too many users of
> preserve-merges who would be hurt when it is removed.

Yes, and the claim this series makes is that there is none and all
existing users should be able to happily use the rebase-merges,
which also means that we need to commit to improve rebase-merges to
support them, if there were some corner cases, which we failed to
consider so far, that are not yet served well.

As I said, as long as everybody agrees with the plan (e.g. we'll
know when we hear no objections to the planned deprecation in a few
weeks), I am perfectly OK with it.

Thanks.
