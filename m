Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BBEF1F42D
	for <e@80x24.org>; Sat, 26 May 2018 23:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032478AbeEZX7C (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 19:59:02 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53461 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751103AbeEZX7C (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 19:59:02 -0400
Received: by mail-wm0-f66.google.com with SMTP id a67-v6so22997193wmf.3
        for <git@vger.kernel.org>; Sat, 26 May 2018 16:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Gdpx9/jOlJc6qzCpfcgEx9pJ3aL8olPCOaeSCgOOkSI=;
        b=FUlLCtqlrmrKyYlVenDXyHzxe/z7EuzX3L2yjWz4TH+g9cH17eRzM95/gXPzUacXlS
         47ALhtglZVMLPBHuC0yTEEMh0Av6D0x9FoKTGJY8W3Q1pxK742AQ/fg1Z0vbX4veWbKw
         uODItkrNxpYrPYUFYScQPu6PteSbYHBL8tdB0VCPrxBh9+jpXSkwiFrZsa61gVzIW9KZ
         Tecv5X6OoFqq+lJdwiR49WKVPyBUZXwR9mDP/KU8ND9fxx+UvLBacm+/ilk/tmYgTnrg
         YYBYTShTB2WwJiDcOWzQTYfIQ/b5T7923ep+OSdHj2+TYq1FNR4swcv8Mgr0HTpONXKB
         Bs+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Gdpx9/jOlJc6qzCpfcgEx9pJ3aL8olPCOaeSCgOOkSI=;
        b=WR8PxVYrg6MfdteMaiLZIhsF3NN0RlG4ZMiSQSiwBHkHxyc8CbbDNedtVyhTD0WnDK
         F+tKwv33/V6xvtLsVVPw2gZ6e9ozkomB1LrxfhmW3jb3D/g608ifuTKpswbVI69YDthZ
         RpoPN+zJTrXA8VfrzoYEuF7R957KDNfR6kV9GK9hTo+u99n9agC4NqO9fbWMItgpNc9v
         q9CdfiC9/dWcguRqEqYD3qUau9t2OH313BE4vFg8c5p9OzsQK1kqn+bisu8+EzAQa+Ap
         YhiZTsM7bbRglTkkNxjFWqDDRpe4/+Z4KHlVovs8xv5KSK2zYWefALOi42lvEmMwxJjU
         JY5g==
X-Gm-Message-State: ALKqPwdBdkVC77LCddwu4PgnhYiKXX4CrO/RUvp6j3TqYMG0ONVuMlVc
        UOqXKMKjbVN/aU7xb2Uwxzw=
X-Google-Smtp-Source: ADUXVKIjmxQ4ElMt0lKMrxAv0vHiMZWaswjDWfYnD/U1WXQM9LiEd0xjRwhEkA6uTxtnuZ05Rc2Z5g==
X-Received: by 2002:a1c:d287:: with SMTP id j129-v6mr591589wmg.106.1527379140750;
        Sat, 26 May 2018 16:59:00 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d83-v6sm15004804wmh.16.2018.05.26.16.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 May 2018 16:59:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com
Subject: Re: [PATCH 2/5] t6036, t6042: use test_line_count instead of wc -l
References: <CABPp-BEcTKaPPUOVqTRUAW+LBBySCK0dgx1J66hYB30yMasK_Q@mail.gmail.com/>
        <20180526010944.9975-1-newren@gmail.com>
Date:   Sun, 27 May 2018 08:58:59 +0900
In-Reply-To: <20180526010944.9975-1-newren@gmail.com> (Elijah Newren's message
        of "Fri, 25 May 2018 18:09:44 -0700")
Message-ID: <xmqq4lium0jg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> I'd expect that a reader of the commit who cares enough to bother to
>> wonder by looking at the patch and seeing that 2 became 3 would know
>> why already.  And a reader of the resulting file would not know that
>> the 3 used to be 2, and won't be helped by "we used to count to 2,
>> now we have 'out' also counted" that much, especially in the commit
>> log message.  What would help the latter would be to name which
>> three paths we expect to see in the comment (or test against the
>> exact list of paths, instead of using test_line_count).
>>
>>> An alternative to consider would be to add a .gitignore file in the
>>> initial commit to ignore 'out', then the number of untracked files
>>> don't have to be adjusted.
>>
>> I think that is a preferred solution that we've used in ls-files and
>> status tests successfully.
>
> ...except that if we add a .gitignore to each initial commit (we use
> test_create_repo for nearly every test to keep them separable meaning
> we'd have to do this many times), then four lines above we have to
> adjust the number of expected tracked files.  And, for it to work,
> we'd have to add an --exclude-standard flag to ls-files -o.

Yeah, unless the original planned to use the .gitignore mechanism,
converting it to use it now will become noisy.
