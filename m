Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDF7C433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 19:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E92364E8B
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 19:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbhBITgP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 14:36:15 -0500
Received: from mail-ej1-f53.google.com ([209.85.218.53]:40887 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbhBITYk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 14:24:40 -0500
Received: by mail-ej1-f53.google.com with SMTP id i8so33600324ejc.7
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 11:23:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c3GmdUZKTu+zVLaGYEcOa5Yiv0qK6pf3+j2g6mSPXnY=;
        b=jPPUE0+xHpbKmzWyF8L5quuDKgw/ES3D7R1k0aYfHIF1e5KL+Zzz+0ReTEpStS+l76
         hvmQAyzHDHhssDqHewN8tSnzxRwjvt9zcrtLxnV5C8J7dZOHmcM2ykbG4NlKA0buZpCA
         Zbdo4B2tgm40fBYYfaIuRxXlt1HmPlNUqaeSzYhZrQj6PBAHbaIqQ6LHuYwx5hMMdzz7
         Q0+lCCAae6uelLp4tqLPFX0jIgazK+n+JdRpp4+i/oOgIfuNVx6wZjaW6dforXLtSavu
         LCvVWP0PM+gjazsGNRrC3Bj/wRrgyyS/KprrifO9cu+ZkJjJHTd6gbIqW6Q243j67T9/
         JX7Q==
X-Gm-Message-State: AOAM532ouqLOB8B1PapO/k7/zO/S6hVUKncb7hR0ZgptQADnnHeBXLna
        +idKkgSD4Jcqur1gRPe1L7klbtBxx8Ersx7apVOiaUAJnOo=
X-Google-Smtp-Source: ABdhPJzL6rzwPpKG6u5JtgJWt45XOwkgaEczY5Mm4huwdP6tOiQ6bwR2FYRpms0dCItBoRJLWbCmZrshgC4IjNCLDZU=
X-Received: by 2002:a17:906:488:: with SMTP id f8mr23146401eja.311.1612898005482;
 Tue, 09 Feb 2021 11:13:25 -0800 (PST)
MIME-Version: 1.0
References: <20210207181439.1178-1-charvi077@gmail.com> <20210208192528.21399-4-charvi077@gmail.com>
 <xmqq5z325k3j.fsf@gitster.c.googlers.com> <CAPSFM5dN=gs7m8VskCPMzD10i42ETQ_7UzuGKmi=X-xs2QkYSg@mail.gmail.com>
 <CAPig+cSoa4Vw0N53vJgMCWiW5yVS0j1H0ejS_01xs1WDF2d82g@mail.gmail.com> <xmqq5z312h5w.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq5z312h5w.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 9 Feb 2021 14:13:14 -0500
Message-ID: <CAPig+cR0aC-XynowmvAz23-h=LP8+vhF7_c3fUg+M+XHg5o8bA@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] rebase -i: clarify and fix 'fixup -c'
 rebase-todo help
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Charvi Mendiratta <charvi077@gmail.com>, git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 9, 2021 at 2:08 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > Here's another more concise attempt:
> >
> >     like "squash" but keep only the previous commit's log message,
> >     unless -C is used, in which case keep only this commit's message;
> >     -c is same as -C but opens editor
>
> Nice.

For conciseness, I intentionally omitted "the", however, upon
reflection, it probably would be a good idea to insert "the" between
"opens" and "editor".
