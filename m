Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78FE81F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 15:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732426AbeGLPdG (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 11:33:06 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38024 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732418AbeGLPdG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 11:33:06 -0400
Received: by mail-wm0-f65.google.com with SMTP id 69-v6so6442445wmf.3
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 08:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HjfP0mYD8YxCuELeBCFjR3Sy6LiMCQi7Vol+pSLkXno=;
        b=RPfoaBYIorHwWGyAN6j31KhxiHg7w+6nigE1RLTmQOgEI2pciMTkIIs6DpNFXegK9h
         gBblX1/HMeEbRTlIoh/5450UiwUmTe/HMV50bOlTGP3rrDZcxwHH5WTS31Kuu4Tqdx9T
         p4z5y79Y/IV97SYi4IHmIKC1YiIUvZsuBeyCktQ1bANUDEo0zDz4BW0I8PnUnY2bmiba
         RAq2cj2OvEYY3ctNvJ2I9vIuUXTRO5j6QDf7kkAa++YkjzLjJ7LGJexHoUKiw6PIEPUa
         rnQ/yjAn+/JwdHb6Bql+MCRXyLEwDZ1tIvNDhw1r8XwgSigm55b2OQOjCEhqGVCnrbPL
         Om7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HjfP0mYD8YxCuELeBCFjR3Sy6LiMCQi7Vol+pSLkXno=;
        b=BRBY1gfS7HX4qRlAfIWma+ky5NsdJ6MEPQXOS61QRk6hxOyg+7VGX7D3Lh8B+ujUMU
         BgafXYomYNGW1AowyidFWglgNz7tqhiucqoTL1/KLPym+N1CoYnQqEI8AMJIwDLuVbrd
         yNXI/dca34ZWBNwskC9SyEZU8JBIsjAEM9I4X47a0hYveyx8bFPEp9UtM28uJqJwCzWR
         0lvE9v6rPR6BMG0Q7ycSlQD+Tv0InWa3XLcQkkPaAKhtd38OPwDz7eNjEs+NhUwya5wJ
         qSHRiISQC9nxFHpa2FNBr25Y8hGataW2nq7ANfo8ByE6yCfhhw6Ks/DnOLp8ho5CR55i
         hTAg==
X-Gm-Message-State: AOUpUlEqErMtEei80pKi/bkFH8YCUQC5+cVi1TT+guScFCas5BOoGARo
        WxcKWU34trdaEnN+IeDDaew=
X-Google-Smtp-Source: AAOMgpeIZHVV8tsgwO+4v1siDnmbH7i9vOMz/t+zLyzHSN15z9lXrbiJBn2PiI2142axTXvk85dj5Q==
X-Received: by 2002:a1c:1d4d:: with SMTP id d74-v6mr1729361wmd.85.1531408983243;
        Thu, 12 Jul 2018 08:23:03 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h5-v6sm13050051wrr.19.2018.07.12.08.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 08:23:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vitali Lovich <vlovich@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: rev-parse --show-toplevel broken during exec'ed rebase?
References: <CAF8PYMjub1KK_ZK0hijTNBACSa6SaFyu1dJgrXd5fJU5Hc_dhg@mail.gmail.com>
Date:   Thu, 12 Jul 2018 08:23:02 -0700
In-Reply-To: <CAF8PYMjub1KK_ZK0hijTNBACSa6SaFyu1dJgrXd5fJU5Hc_dhg@mail.gmail.com>
        (Vitali Lovich's message of "Wed, 11 Jul 2018 19:50:47 -0700")
Message-ID: <xmqq7em01ns9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vitali Lovich <vlovich@gmail.com> writes:

> Repro (starting with cwd within git project):
>> (cd xdiff; git rev-parse --show-toplevel)
> ... path to git repository
>> git rebase -i 18404434bf406f6a6f892ed73320c5cf9cc187dd
> # Stop at some commit for editing
>> (cd xdiff; git rev-parse --show-toplevel)
> ... path to git repository
>> git rebase 18404434bf406f6a6f892ed73320c5cf9cc187dd -x "(cd xdiff; git rev-parse --show-toplevel)"
> ... path to git repository/xdiff !!!
>
> This seems like incorrect behaviour to me since it's a weird
> inconsistency (even with other rebase contexts) & the documentation
> says "Show the absolute path of the top-level directory." with no
> caveats.

Does it reproduce with older rebase (say from v2.10 days), too?

I suspect that the above is because "git rebase" is exporting
GIT_DIR without exporting GIT_WORK_TREE.  When the former is given
without the latter, that tells Git that you are at the top-level of
the working tree (if that is not the case, you also export the
latter to tell Git where the top-level is).  

I suspect that "git rebase" before the ongoing piecemeal rewrite to
C started (or scripted Porcelain in general) refrained from
exporting GIT_DIR to the environment, and if my suspicion is correct,
older "git rebase" would behave differently to your test case.
