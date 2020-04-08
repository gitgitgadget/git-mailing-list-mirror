Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210DBC2D0EC
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 01:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2687206F7
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 01:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPvFnypD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgDHB0Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 21:26:25 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:38214 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgDHB0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 21:26:24 -0400
Received: by mail-oi1-f179.google.com with SMTP id w2so3315684oic.5
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 18:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Gx9y6Esc3+1nEanPzfz0n5kdhalI84PicCQ4UhRbQ68=;
        b=sPvFnypDwuOnlS+oz3NOCApQZzM3USlrmdxnvY8+Z5S8f3/L8DZhraY7HwUJeOEE6u
         HGVBmwUy6OOFN1vQVpz8ef/5nEbKFQVobUjeX3lfXSThg6p1BDLKdWhYKxaDu5Xk94K4
         A1vDuJlCDdydgLZUKqbRlJaBwJqB3b4Pc5GpcpUbmKQJ42IMrvafx9LjLOPA2k+0WT/N
         cstNgZRk79VGlED3DldWA6qUtLC/iT2uo3uvpCqE1jWH6pV3UOitmLz8ov730+u0pOwb
         lolO9OTF8rC0nPPBLj0tAub7d1et1o1FVHT/aFYTVBfjppf6yjzqt7XC07jLYBhaZTdh
         fmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gx9y6Esc3+1nEanPzfz0n5kdhalI84PicCQ4UhRbQ68=;
        b=shz1Qfp7XFqhbPymABXdpJ8+xVYQsDbMPhDc2hqrzqficygkrSIlSj4TDSb5ybyPmc
         5nolw9p8LsFcllA+YT18lPyGiillH4UgTt8J6jv0uCv5e6PVuMft+afT4HiGooeNFG50
         NknI+P3sqz+yuIOKO+Z5/pDWopfvsrEBaFYlSy9Je7uUtZIe0H9rIhNVBMKcAc/XodjX
         tp74A0rSgiV43dF1eg5V8M/yzxmwWfRkJAnhvgEXkjcys04FB9D1oCqtvi2/6uzx1/pY
         ELfrGiCvqQJhwUprm7OvojspXXmnAzuIMx3abckgcGgtx9QB2SxPSj3rhTsNs/SjhGHF
         xvPQ==
X-Gm-Message-State: AGi0PuYlAQLU/4TzNJQ5knylAUDEZP2IAM7lYpsA2o6Zm0Mqu0jwhKK/
        kMWC+QF1fhK4Go4aaE3a3fFlimvp7lo=
X-Google-Smtp-Source: APiQypLQI6orktfMUoDaOK8NyYlpSSHwDv5ZYxpwamjvFcNGZqS1wNQ07DRwbv/usGGEV+9MsCZbcQ==
X-Received: by 2002:aca:fd48:: with SMTP id b69mr743673oii.126.1586309183482;
        Tue, 07 Apr 2020 18:26:23 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id s27sm5939384otg.38.2020.04.07.18.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 18:26:22 -0700 (PDT)
Subject: Re: Happy birthday to all of us ;-)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqzhbmpyh6.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e0d80de2-3d82-fc05-96ea-890d6a3ba55a@gmail.com>
Date:   Tue, 7 Apr 2020 21:26:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <xmqqzhbmpyh6.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/7/2020 9:17 PM, Junio C Hamano wrote:
> So, it was today 15 years ago that Linus announced the availability
> of the first tarball of Git.  
> 
> Let me thank all the contributors, both long timers and relatively
> newer ones, for working on the system to help our users better.

As a relatively newer one, let me thank YOU for doing all the hard
work of maintaining the project.

> But I should not forget to thank others who help us by doing things
> other than writing code.  Writing code is not the only work on the
> software.

And maintaining is not just reviewing code and hitting "merge"! Your
deep expertise helps guide our contributions both in our code but
also to keep the philosophy of Git moving in the right direction.

> Some contributors are good at polishing documentation, which we the
> developer types are not particulary good at.  Others help new
> developers to get up to speed, mentoring them in programs like the
> summer of code and Outreachy.  There are folks who help us with
> legal work to manage and defend our trademark, which is taken care
> of by Software Freedom Conservancy, which the project is part of.
> Employers of "professional" Git contributors support the project by
> letting/making us work on Git, admittedly with their own agenda, but
> without necessarily being 'evil'---a particular area of interest
> they support, be it the lazy-clone scalability work, or more
> aggressive recursing into submodules, would eventually benefit all
> users.

Since working on Git is a big part of my dayjob, I am always
impressed by the contributors who volunteer their time to work on
Git.

> Thanks all, and let's look forward to see the next 15 years be as
> wondreful years for Git as the past 15 years ;-)

Thank you! Here's to an excellent future.

-Stolee

