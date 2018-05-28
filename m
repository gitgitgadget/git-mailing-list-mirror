Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 147581F42D
	for <e@80x24.org>; Mon, 28 May 2018 05:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753165AbeE1Fek (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 01:34:40 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:33226 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753140AbeE1Fej (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 01:34:39 -0400
Received: by mail-wr0-f176.google.com with SMTP id a15-v6so18179031wrm.0
        for <git@vger.kernel.org>; Sun, 27 May 2018 22:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jwGPTYjfAzfYF97TA9qRvMYBzcaZ+NZ5GXCgZ/X4Dbc=;
        b=E8PQkQFWi3JnZXNR3hNfzHUSWu4poIch4bwnIO1u0bMXAwxM3ho5ASMUhBFD8vPv6Q
         5wigtve/p08OsN59uJF0Xw5cQtFC+MVZJ3bMBZPIu4WSWZsJoRQJPBFyFXBjNvyUtraZ
         2m/wJkyK8OZ5uMznkwDaluv7uWBD95kg8P1a6h52cLI5NRZyE4u9bR8Q+UpMtpUpFVAY
         tXCf9ZRwDHUPNcBR+nzzKrkpuynyken4eh/ZyivE7ngxwbgcnLdsxzRhoYyCcZO8zPIm
         IJRKlNQylCHrQ/CZ/7io3Po+NOLfBfetLGVjzlqI8ZS6O/liouOXusGRvWrljTt/7H8/
         uFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jwGPTYjfAzfYF97TA9qRvMYBzcaZ+NZ5GXCgZ/X4Dbc=;
        b=qMFbZzA17d8MzejGVcmfFDwXchzxS0pgjPWvK80BWBT6nJyjZVmd4BYPzuvXSes75x
         9DPPmEdEa+tZINQ7kNix+LT3txlrbSXgDEFl/Ukht4/3KKnYxg7YBjdBRBqeAmU9gTbg
         xLjOTBRxMVvJdYFpYtU5w/Y97Hv4Ra5zaTFreDd+UAkE5QubVqpR9DAO56xpgE6eJaTe
         jJiybGNE8NTpJTMjIsKaFCZT+d2120AgAGD8pOp5j6thdzm8GYWIZCMcbLnizm1EY1OE
         Z3yaiKHVhlAyvK7akHP9mHNIcyEFUnL7eb70gs75qAuCjMrOA/td3ELc7mZv3e239jch
         mcGg==
X-Gm-Message-State: ALKqPwcFUn8QN3qKcPxBlbmUU20pGfE+xrgB6eQs5wJ9imTfc2+VUNQS
        JSceStdaDrTD2y6d7jTn8KA=
X-Google-Smtp-Source: AB8JxZod4LM02qGnL3xC4viZKXsS86QL9i61Q54FA4Q+5aZ4/3DiyfE7EyDb6P5RQI/+4c5bdmEH2Q==
X-Received: by 2002:adf:8607:: with SMTP id 7-v6mr8739960wrv.255.1527485677771;
        Sun, 27 May 2018 22:34:37 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v196-v6sm11622451wmf.36.2018.05.27.22.34.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 May 2018 22:34:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (May 2018, #03; Wed, 23)
References: <xmqqwovtudia.fsf@gitster-ct.c.googlers.com>
        <CABPp-BHrzaJ4O0WXJM2YhTMzSx-6nxhHTi4VmL0xXph0ts3Msg@mail.gmail.com>
Date:   Mon, 28 May 2018 14:34:36 +0900
In-Reply-To: <CABPp-BHrzaJ4O0WXJM2YhTMzSx-6nxhHTi4VmL0xXph0ts3Msg@mail.gmail.com>
        (Elijah Newren's message of "Wed, 23 May 2018 23:39:58 -0700")
Message-ID: <xmqq7enol4wj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Wed, May 23, 2018 at 5:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Here are the topics that have been cooking.  Commits prefixed with
>> '-' are only in 'pu' (proposed updates) while commits prefixed with
>> '+' are in 'next'.  The ones marked with '.' do not appear in any of
>> the integration branches, but I am still holding onto them.
>
> I don't see the series posted at
> https://public-inbox.org/git/20180522004327.13085-1-newren@gmail.com/
> (various merge-recursive code cleanups) -- or its predecessor --
> showing up anywhere.  Did it slip through the cracks, by chance?

It does not require any chance for various serieses, especially
their earlier iterations, do not get enough time slots to be
processed soon after they are posted, as there are too many topics,
both patches and discussions, active on the list.

Especially the ones that are designed not to apply to the current
'master', which would give me a strong incentive to ignore them
until the prerequisite topics in flight hits 'master' ;-)
