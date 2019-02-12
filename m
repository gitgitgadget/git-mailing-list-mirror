Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59D0F1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 17:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbfBLRH2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 12:07:28 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51910 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbfBLRH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 12:07:28 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so3825936wmj.1
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 09:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=nn3462BzLkfkDX7AqS9VyH581uKxAvijgVmkg8BqL14=;
        b=KtfsEGGhUb3oOvcZRZfLiJbnNrE155i+h8POVKDuSFbWTa4Bflnz9INlDXfxt8X8jz
         ziLgHcSAGKlwZv7i5EWY/FGuotfKsw4rf6rqGUuMIJNCuVHJye16n9GP9rtDCiX1/kC8
         nLtpjQfIISY1JlUKrhdkIPhwl5MVNgecJdTmTcuNSvIbWTBJKayOlnORbsXXzU+0++ru
         WFUbpLRzxPxJ0Ck6xXM+hcbs8aBX0A+jYuSpogLv0LDAmZFd0UXpcDitPmUsr+le4x1o
         74udOhJdAKasVjBOT3KQMVmnRbSuEcAWs3bBNfZDbD33PVw1GhHi2MYhzw8LRX4rxOBn
         yVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=nn3462BzLkfkDX7AqS9VyH581uKxAvijgVmkg8BqL14=;
        b=kRp88nwQdZJtlslAvRrYBfdDD8w2SrZrf0Fckf+cElP7z6KFin1XY2mDWmAdrkXDFA
         oEOdYoWDn1OWuvYNnBcfj0waqjyzSSVaDvGmWfK+6a4acyXiZwVbWsasPx/Qw0DX+tYp
         iRqIriuoQDXJBVtpiSTrqCXGvl2+geMuOCEQgv432A6hKFdKavyf/eCgPdP07MWL2x2O
         ucZ3Kt4U0PO8IZrwweZu8Md3uhH8foo+KDoL41rFuIG4EnJV7H7CdG8xrThBMjaOQyyE
         ySLo2BNv9pHrE4bLCOcCyXS2nqFlUc8hRgDFQbiVrJKiXHprsOYSfOe/XnHFwswSc4hO
         Iz6w==
X-Gm-Message-State: AHQUAubu9GQ43T1H94hHUgWJY4tiU+ooUosxmkHS4TzoPdjgTuiDfk/h
        owkEDTySOLdgvgAl2BkSx3I=
X-Google-Smtp-Source: AHgI3IYsDnhF2mDlBSNvHZqCumQNhR/8myXSyCHJxPquyhvjJ8NAEhuKPc7RLxZEFUjrjZY/Nltt4g==
X-Received: by 2002:a1c:67c2:: with SMTP id b185mr3414527wmc.96.1549991245435;
        Tue, 12 Feb 2019 09:07:25 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b2sm11067582wrp.94.2019.02.12.09.07.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 09:07:24 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, git-packagers@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git v2.21.0-rc0 broken on *BSD, maybe others
References: <xmqqh8dgqcqn.fsf@gitster-ct.c.googlers.com>
        <87sgwtjjbk.fsf@evledraar.gmail.com> <20190212124323.GA11677@ash>
Date:   Tue, 12 Feb 2019 09:07:23 -0800
In-Reply-To: <20190212124323.GA11677@ash> (Duy Nguyen's message of "Tue, 12
        Feb 2019 19:43:23 +0700")
Message-ID: <xmqqlg2ldjg4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Feb 12, 2019 at 01:13:35PM +0100, Ævar Arnfjörð Bjarmason wrote:
>> 
>> On Thu, Feb 07 2019, Junio C Hamano wrote:
>> 
>> > An early preview release Git v2.21.0-rc0 is now available for
>> > testing at the usual places.  It is comprised of 426 non-merge
>> > commits since v2.20.0, contributed by 57 people, 13 of which are
>> > new faces.
>> 
>> As seen on https://gitlab.com/git-vcs/git-ci/branches there are
>> regressions since 2.19.0, e.g. we have hard compile errors on BSD now,
>> and maybe AIX. I haven't dug into it.
>
> The build problem on BSD is known and being worked on [1]. I was going
> to install FreeBSD to examine it closey, but got distracted.
>
> The AIX problem is from d1dd94b308 (Do not print 'dangling' for
> cat-file in case of ambiguity - 2019-01-17). Apparently AIX compiler
> is a bit picky about enum being a strong or weak type. I like this
> compiler. The below patch should do.

Thanks.

If I find time later in the day, I may forge your sign-off and
fabricate log messages for both patches, but unfortunately I need to
run a long errand today during the day, so it may not happen.


