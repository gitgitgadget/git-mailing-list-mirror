Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 682D020C11
	for <e@80x24.org>; Wed,  6 Dec 2017 18:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752296AbdLFSAg (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 13:00:36 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:37972 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbdLFSAf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 13:00:35 -0500
Received: by mail-it0-f50.google.com with SMTP id r6so8227660itr.3
        for <git@vger.kernel.org>; Wed, 06 Dec 2017 10:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sourcegraph.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Y4BGfJ1ZwhPyUS+mbR8V0vjgtAjfYerjZJjUw+0oWAY=;
        b=dW38FTK3F5q6g2rLD8256vW85EJI6m9xfFhs5sPUi+0XtZ4Ec6HnIrzO4U3SKj9fYT
         VQSUq25xwsoPnv4Xs7vW6C4WTsfOa9NpPB8+Tp014mHUs0JLYDzQXtz8iZwcKD+KyQA6
         nlZjTzDA15pbLS55A3LK5lDhlkIgHWLyVlLLU4Rg7ieJUQH/gA4UnpNavXsyK4J+nzdr
         efhAr4c++y0Ye6BokyY6E6KKbYf/Mca5UzkkzXfWABOT2MJo3tOmhs+yiats8qYDbUAx
         ssWCr5MaAnk1kk6Epr4QrpyR9WyOWhjesDCNOu2Bx8z0Go+rbdrlkZV6Zcs2pwtllkZM
         ykzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Y4BGfJ1ZwhPyUS+mbR8V0vjgtAjfYerjZJjUw+0oWAY=;
        b=CX5HE/c6PrhwK1COdIMPe3h7B9l47II7jlF50aFIqmLZQPyG3N6SEM35zpDy7UHV0D
         7+K1c41XAOOVu5jeTqpRsd/w7ve6Ei8JFoRqQ34sXGTPjThlaKq0vMXqzKBq+FuoSsIb
         yqUrmvBOduAT+c9JJHbMbk0Lkmobb90frSGBO0d8IWfdzz1XrfJnorjD4M4NUM3QXBfy
         QmoQ79JNSaPsJY/lex9mMKIiSJCyaumdpomixgyhLMupM+/JfBxiqt+4hn80RKYYI9AT
         a38w0ypMFzVZ8uf59OmeTTw2/QaggBKEpBHRvt9L8nY1gn4CCf/41WrWFWSW1V2WMgLl
         p+PQ==
X-Gm-Message-State: AKGB3mLqeAk3kBHWP39IC11byctACnApEucPvu7ivGe25O4weXypla3Y
        bYVN89JEytAWBKnUHWFQnEuleyrl+T5tZEakHFze/LyhKJs=
X-Google-Smtp-Source: AGs4zMZM/2JRGs9VG1sXW5zeugapandrFPvhonCBFqgTGW2geIYQwwtofX9n/Vs8gIqy1O7Yw9BVppM9aRlBw9919K0=
X-Received: by 10.36.7.12 with SMTP id f12mr13909897itf.86.1512583234897; Wed,
 06 Dec 2017 10:00:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.165.7 with HTTP; Wed, 6 Dec 2017 10:00:14 -0800 (PST)
In-Reply-To: <xmqqh8t3hiuq.fsf@gitster.mtv.corp.google.com>
References: <CA+SQVf1W6BhNyB6bGxh7WfCwb6+E3pNjHLeS4xDYPJ6BLT8cng@mail.gmail.com>
 <CA+SQVf24rcQ1iKAQBW0Ky7Qm8zuF3Esw8qMKvG+KCbCA-mCcfA@mail.gmail.com> <xmqqh8t3hiuq.fsf@gitster.mtv.corp.google.com>
From:   Nick Snyder <nick@sourcegraph.com>
Date:   Wed, 6 Dec 2017 10:00:14 -0800
Message-ID: <CA+SQVf14g4zBP14BHEZQkyeqUE5Oqif3bUVADEwBZQTSwE=bKA@mail.gmail.com>
Subject: Re: git blame --reverse doesn't find line in HEAD
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Can you bisect to see when the feature stopped working as you expect?

I will see if I can do that but might take some time.

> It finds up to which commit each line survived without getting touched since the oldest commit in the range.

Right, this is where it is failing in my case.

With a history like this:
A <- B <- C <- HEAD

I have a particular line in C (HEAD) that blames to commit A.
If I run a git blame --reverse starting at commit A for that line, it
doesn't give me back C, it gives me back B instead.
The line is not added/deleted/moved between B and C.



On Wed, Dec 6, 2017 at 9:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nick Snyder <nick@sourcegraph.com> writes:
>
>> This can be reproduced on Linux and Mac. This behavior seems to be a bug.
>
> Can you bisect to see when the feature stopped working as you expect?
>
> Unlike a forward blame, where the command tries to find a commit
> that is responsible for a line being in the final result (i.e.
> typically, HEAD), a reverse blame is not about finding a commit
> that is responsible for a line (that used to be in the oldest
> commit) not being in a more recent codebase.  It finds up to which
> commit each line survived without getting touched since the oldest
> commit in the range.
>
