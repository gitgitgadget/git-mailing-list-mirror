Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEB741F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 06:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbfACGmY (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 01:42:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37638 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729098AbfACGmY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 01:42:24 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so29360598wmd.2
        for <git@vger.kernel.org>; Wed, 02 Jan 2019 22:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RVXQ/CuaCHWeeSaLZt/2U/JkgpoOuZiSlmFarvvGQtY=;
        b=XnjcXfBjHgLgvw/q9ffVdECcj9JOoTlVugEvhIaA9ESGRDvsMb8/MNZuxYA3wBArjf
         4re+a7GVUNKKujXfrfZe/UMnzWdE7doXmuJ59oke+zOb0Rom30NoZnnobT4KdGUhO3RD
         EV6Ub+HXnnZBmE8va8LvsExRKK8bu7p9YD/VdGLb9hGkiRLblvgDfo57DbhRXPaB/57x
         lFW8057Kx7zta7uKA1Ny9tenCQCjp25Nt0Gam/CUMnLDFEgAr/SaAy3K1wRMC9Gaw8Mp
         AfLJ3qtPDNf3CZbZ7bLlrgRoLT31kLgsU8fl1IknW0ZcHl/FE9gE8Ky5BuS20VrvUxdd
         RbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RVXQ/CuaCHWeeSaLZt/2U/JkgpoOuZiSlmFarvvGQtY=;
        b=pZCxnrmL37KK1Shkdfg9/b3VLY0giPGLWQ885Qx+A6EQlagbROXOvzcZ4aV/AHDAwG
         CLlqRVAs4MCTjuktxGgolIWOalRBIzom+LL8+8+mnOCvtEMDMbkF9HWZrL2qA+MgvluU
         ejSN7Ntxant/YFrUoerA7nXPQ4HOjJf6LH6b4O9dheJ4t24uMFo5PGacX+E7U84Nbm1s
         vNuyeRZg/SzprNAxMfSByVym1XiRv++e9/1kip0dQc6ACmt5G5XdKupfTlUK3geLQbNc
         EJ6BK7TlFEcQ6Th0AcEGHIpNnT/kO1CsyNO8jikEgS36T8evITmYUUC0H/aaMM8vkRpQ
         RZDQ==
X-Gm-Message-State: AA+aEWY1MY9TBMvuYcZ6a5UKZ2RrBx3ekorGEU0LMqv1gvU9oofMVu21
        jNi74hQepnHYQfUVNrdVKPY=
X-Google-Smtp-Source: AFSGD/WCRpGRDS8xARhIBCwK36dtgF7gB+cnxbgN6Fr6RoGvXTEOFZt+dEx4irz6Hi1ZwU6mTioAIA==
X-Received: by 2002:a1c:c87:: with SMTP id 129mr35507948wmm.116.1546497741997;
        Wed, 02 Jan 2019 22:42:21 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r3sm40430135wrs.78.2019.01.02.22.42.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Jan 2019 22:42:21 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephen & Linda Smith <ischis2@cox.net>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 3/3] t0006-date.sh: add `human` date format tests.
References: <20181231003150.8031-1-ischis2@cox.net>
        <20181231003150.8031-4-ischis2@cox.net>
        <xmqqva37j595.fsf@gitster-ct.c.googlers.com>
        <2832897.SWEsZI4Xea@thunderbird>
Date:   Wed, 02 Jan 2019 22:42:20 -0800
In-Reply-To: <2832897.SWEsZI4Xea@thunderbird> (Stephen & Linda Smith's message
        of "Wed, 02 Jan 2019 19:36:16 -0700")
Message-ID: <xmqqk1jmi6nn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephen & Linda Smith <ischis2@cox.net> writes:

> On Wednesday, January 2, 2019 11:15:02 AM MST Junio C Hamano wrote:
>> 'date +%s' is used everywhere in this patch but has never been used
>> in our test suite before.  It is not portable.
> So I don't make this mistake again, Is there a reference somewhere for that is 
> and is not portable?

I usually go to http://pubs.opengroup.org/onlinepubs/9699919799/

Even though we do not say "We'll use anything that is in POSIX.1; it
is your problem if your platform does not support it", we tend to
say "It's not even in POSIX, so let's see if we can avoid it".

>> Using "show" here is much better than "log -1" above; using "show
>> -s" would be even better.
>
> I was attempting to test both git log and git show.  For get log the `-1` was 
> to only get the latest commit.
>
> Are you suggesting that t4202-log.sh not be updated and that only and  t7007-
> show.sh and t0006-date.sh updated?  

I am saying that using "log -1" and "show" in different tests _only_
for the value of "Date:" field does not buy us much.  And by unifying,
I was hoping that the single helper can be placed in a common file
that is dot-sourced by these three scripts more easily.

Thanks.
