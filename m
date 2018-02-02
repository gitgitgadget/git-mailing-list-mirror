Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A971F1F404
	for <e@80x24.org>; Fri,  2 Feb 2018 23:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752068AbeBBXjE (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 18:39:04 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44194 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751827AbeBBXjC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 18:39:02 -0500
Received: by mail-wr0-f194.google.com with SMTP id v31so24063346wrc.11
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 15:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YKe0T3yrRpQWdSmVHokhJxpfU2u9S5WVLmJ7YE68ies=;
        b=NxzMUE/Fu7fLgvMoHHD72dn9/Lj5rQ9IOQa8NbMqcxSiFGxmfG9IPdGgQHXmE4e7fp
         glgm+af5qfOneMbF0krPlSYiCK70qfaD7YVlwBh83JvjAZ7Okmo6e0ZJNjTdnYA9GKA6
         KrMepX0Lo7+/hpnfcgI+y50EqPMp6gyVz1eH/DN/Pd3FkgNhSvC6Cv5sGZECjU12mXTp
         ujheaq1ACIoVrgtWpM77qe5yk0aFvbwR/YCZftDYOUET2GQ1g2x3C/IsokUnmBlGcn5S
         X7lAnRZg+tBlUJWDBSE+P9LlqhlM21Ivz0RNSkJjzP59sVZMENg++DNvsEHXPjVjURG9
         ZDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YKe0T3yrRpQWdSmVHokhJxpfU2u9S5WVLmJ7YE68ies=;
        b=oZikT2TgMlOFfNyTQ2YCfENPsrD58ogcPec56OdLa8b5+kG8HNLXu2owx3iSZo8jfG
         IL0tdiZPhwjoZb8U2qufGpJKZnO24wgT6oGV0Uez80vl5OvFnP15ja8itS7zy/WgQU2V
         Kwg0z/LDZPNjxyaM0D6afbfIvXLZvHfJZ2GzdXIrle2Se+pvLVWt900x5qEH6KVRTVHM
         kAR8bGGuVLN9wMDIHX3YYRsA7GK4bX/pT5d7jLtgwafufj782hzJEYFjpT33cmPhV3sp
         0q1bb6CUV2yXvARaetFt0Ikp+BvKxpPOSwmJIGEGsnm4g5WWeeDSPQ/Lca9QnRIWlSis
         zAdA==
X-Gm-Message-State: AKwxyte5o94LklwTRxZNoXRhDnS2APpc8Nw6pnViYSWuw9GmHlprjGpK
        FiSuigs1Xot3/o+b2orjmsA=
X-Google-Smtp-Source: AH8x226NZv803NEcVGEIKR8JQ+NVsbye3jWZieW9QZNqSv2sH+6Wc9IU6H0VoqNMC4BZgquKDREPGA==
X-Received: by 10.223.200.140 with SMTP id k12mr16512355wrh.146.1517614741530;
        Fri, 02 Feb 2018 15:39:01 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e15sm3059703wmd.26.2018.02.02.15.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Feb 2018 15:39:00 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephen R Guglielmo <srguglielmo@gmail.com>
Cc:     Avery Pennarun <apenwarr@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: Bug Report: Subtrees and GPG Signed Commits
References: <CADfK3RWXDuE=hYD==4sHXO1iJeOiVDOp7hBqhBtSn7gnQ+x7Qg@mail.gmail.com>
        <CADfK3RU4WJLV9EtieWYQzzRBoJkpyE+w178WQk+wj6soFwKW7g@mail.gmail.com>
        <CADfK3RVJdk3zK7+eE45-PSkb=_v86wrC0TzY+hUmAkfO0Dea=w@mail.gmail.com>
        <CAGZ79kafgyOujDM4BsXdDUnP+iFk5mp2bYnX-Q65khW-weEhUg@mail.gmail.com>
        <xmqqy3kfq6a9.fsf@gitster-ct.c.googlers.com>
        <CAHqTa-0kdkDUjH1nw=4JPAivtyL84zfZ5t8Dj1UYXPrMd7Poqw@mail.gmail.com>
        <CADfK3RXOqB7wKnXCWxgyDeov-Y7rVQiWFUa_hKZk=j9ReY9JDQ@mail.gmail.com>
Date:   Fri, 02 Feb 2018 15:39:00 -0800
In-Reply-To: <CADfK3RXOqB7wKnXCWxgyDeov-Y7rVQiWFUa_hKZk=j9ReY9JDQ@mail.gmail.com>
        (Stephen R. Guglielmo's message of "Wed, 31 Jan 2018 07:33:57 -0500")
Message-ID: <xmqqpo5narmz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephen R Guglielmo <srguglielmo@gmail.com> writes:

> On Tue, Jan 30, 2018 at 6:37 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
>>
>> Sorry I can't help more.
>>
>> Good luck,
>>
>> Avery
>
> Thanks all for the discussion/replies.
>
> We use subtrees extensively in our environment right now. The "sub"
> repos (90+) are located on GitHub, while the "main/parent" repo is
> provided by a vendor on website hosting infrastructure.
>
> I will take a look at:
> git/Documentation/CodingGuidelines
> git/Documentation/SubmittingPatches
> git/contrib/subtree/
>
> Should I follow up in this thread with a patch (it might be a while)?

These three are good place to start at.  You may find the output of
"git shortlog --no-merges --since=N.months contrib/subtree" and "git
blame contrib/subtree" also a good source of whom to ask for help.
As we said on this thread, this is a corner of the contrib/ section
that nobody seems to be actively working on, so if you really depend
on it working well, you might have to take the ownership of it ;-)

Thanks.


