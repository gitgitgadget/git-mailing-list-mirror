Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7F54201A9
	for <e@80x24.org>; Sat, 25 Feb 2017 01:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751430AbdBYBPi (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 20:15:38 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:36004 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbdBYBPi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 20:15:38 -0500
Received: by mail-io0-f170.google.com with SMTP id 25so1573363iom.3
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 17:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aCaBH/Wqobtu6jlvj3j3HKZR39dJp/fSfTpApjHOhd0=;
        b=KkilyNA2FFXNySRJF6q2a/6z/b5ZVsfJv6T2fDMV35qD/Rfsai8O2OEUZ8X0llsB9K
         Lk2hsvLzLGSKNdpmwjpCDrLMTvUADQwkCZuXM2j27iMAUrLgH7sRFnSUGGy+7XOQIYVX
         +ytOvkX7GxG8V+IX0sSpy5cSZOr8xDrIqqLFQSJ9qgb268dLnrsGxmDL5adJtMT2/3Ty
         i8CgY+sINkATXJDE8UsSvnjiucZKWO/R+6lUlmThzgyEpEtbpwR0Ew5QOFZMyd46Ux9C
         qJVupuIKgt0LqsL9Pd4S04rhH8aztU7quc2DFrw9YEvrbSNEPG3qgH1TyzLP/vqOLBY/
         Qamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aCaBH/Wqobtu6jlvj3j3HKZR39dJp/fSfTpApjHOhd0=;
        b=b41H6oSUYL1LHpn7i+rzFGc4MOV0Q3f9zzD+ZJBgzV7l/IOwhieinRQHv1+/q6JxIS
         036pri4ufGiVvsGThOofrRhmtkIWjoI9OBsaB7ynufEdrLYZHhVrWiQH+CFYxKkeelQT
         L+a6tOrzmPgvnvho2cu/de7XSMYGe8OH7a35PQtbwhJanq35ptIOyOfXJKfaSXi5mYM5
         bQ17mGCXPNZncpXNhNKsl2WMWvREyWZYI1qGlCs014wJ1RwYxJZMHBwFkdOKReI8Ats9
         YPQf0N80TCQaTgO+5/Eu9pqGEcxf4PUaBoxSslXvAOppTBqkPkwz1bVa4yYird+gAYN+
         w/xA==
X-Gm-Message-State: AMke39kHLSOs+oLL9tMni+dvAptfG7FyDEIsGKwxJc9EnZER0W1C4sv7QgeHKMRCBCbpEXDAYrx0Rs4RsiabGy8h
X-Received: by 10.107.37.148 with SMTP id l142mr4942696iol.159.1487985336807;
 Fri, 24 Feb 2017 17:15:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Fri, 24 Feb 2017 17:15:35 -0800 (PST)
In-Reply-To: <nycvar.QRO.7.75.62.1702241656010.6590@qynat-yncgbc>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com> <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net>
 <nycvar.QRO.7.75.62.1702241656010.6590@qynat-yncgbc>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 24 Feb 2017 17:15:35 -0800
Message-ID: <CAGZ79ka+U-TMpjsAOQLmSEfZd0UCi2bzRZ-XsLxpVXTXHfdcLg@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     David Lang <david@lang.hm>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2017 at 5:00 PM, David Lang <david@lang.hm> wrote:
> On Fri, 24 Feb 2017, Jeff King wrote:
>
>>
>> So I'd much rather see strong rules like:
>>
>>  1. Once a repo has flag-day switched over to the new hash format[1],
>>     new references are _always_ done with the new hash. Even ones that
>>     point to pre-flag-day objects!
>
>
> how do you define when a repo has "switched over" to the new format in a
> distributed environment?
>
> so you have one person working on a project that switches their version of
> git to the new one that uses the new format.
>
> But other people they interact with still use older versions of git
>
> what happens when you have someone working on two different projects where
> one has switched and the other hasn't?

you get infected by the "new version requirement"
as soon as you pull? (GPL is cancer, anyone? ;)

If you are using an old version of git that doesn't understand the new version,
you're screwed.
