Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E070A1FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 20:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754434AbdAIUKv (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 15:10:51 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:38347 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752176AbdAIUKu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 15:10:50 -0500
Received: by mail-it0-f41.google.com with SMTP id x2so72031635itf.1
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 12:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sMkaRHhzmRMDMZPWb1pUkfn01N9XIxMsj6ZGaCJBV30=;
        b=p1gNwIKcxqxR3v2eRadtIJebGzRpD4ieB4jb3a4TrChQtiRdREecnSlwdR2Z4fvNTF
         9YzdKsvjlS+TKQaZ8cdQRDgatFRAOuyjdRtAgmWyZlNCoMQRVeVTwfmoopEwZzl4+cG3
         ibb6TAhgL1SiLvp8I5qt6Bs3jboPUHaZfaTngqgz1Ipxp8cx1Yl2udXdOBqTeHy3iVba
         o+J7DETS7WWRmJ3vLym+OF+F6fEzSgbWIu6M6QUMblRpEGl/zKt7pnjFxcY2DdSGrxVI
         TCB/ZHlSk2tzyoDWZWgTLZZ0wp+wp+Nbl0njhYJMXVYQDQyym3pnVPllT915myI26XGJ
         xr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sMkaRHhzmRMDMZPWb1pUkfn01N9XIxMsj6ZGaCJBV30=;
        b=Ns2JtulMhSrhUZ+MxV+y+WF5VprPVVkkiNRqIw1qxiVjh7zR3CRsQq5Tggy6ldvTRy
         V/Xu8mhyTc7sRNja5yiMfjrUv5M1kYsUahkhDeRSNjr1GaVNiUPTdcXgg7HI8Hhkc36X
         z454N/YxnnPKyjF2vHWOxaw+uUlloqFf3plT4J8EzGWPSQZJYxm7NHGYJs8JP9tCTwyD
         4OwI2KnBdAFsJXP/94e3yjB+Bv8jz015chG4+5Dr9mJ7huXsmS2O+QXUXSIKa35u5Sh4
         LBQkU3ZCOol2qPndXqDY/lYFlM5mceL5/0VJqH49+bXflP3p3tWg6967+zkPzxLLhhLr
         dtdA==
X-Gm-Message-State: AIkVDXKX9Je62nNfVqr4ZyV1Q+sTF9LLmyu7jilQoXHgtcBHPXmCEKOJg+F+TAG7Eb/k7IKnQXtcegUZv+9rVcgk
X-Received: by 10.36.65.161 with SMTP id b33mr48513itd.114.1483992649676; Mon,
 09 Jan 2017 12:10:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Mon, 9 Jan 2017 12:10:49 -0800 (PST)
In-Reply-To: <xmqqh959ynb4.fsf@gitster.mtv.corp.google.com>
References: <20170105192904.1107-1-sbeller@google.com> <20170105192904.1107-2-sbeller@google.com>
 <xmqqh959ynb4.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 9 Jan 2017 12:10:49 -0800
Message-ID: <CAGZ79kak8qzUG5G1mM8uDqxW8tVBNmuLcvMhopby_U8PvUOjJg@mail.gmail.com>
Subject: Re: [PATCHv6 1/2] submodule tests: don't use itself as a submodule
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 8, 2017 at 6:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This provides an easier way to have submodules in tests, by just setting
>> TEST_CREATE_SUBMODULE to a non empty string, similar to
>> TEST_NO_CREATE_REPO.
>
> Yuck.
>
> I find it doubtful that it is a good idea to create two submodule
> repositories by merely dot-including the test-lib.sh; I find it
> doubly doubtful that it is a good idea to make test_create_repo
> pay attention to the special variable to implement that.
>
> I am OK with a solution where callers that set TEST_CREATE_SUBMODULE
> variable in this patch to instead have an explicit call
>
>         test_create_repo --submodule pretzel
>
> That would be a lot more obvious.

agreed.

>
> The primary reason why I hate the implementation in this patch is
> that it is very easy for a test that says TEST_CREATE_SUBMODULE
> upfront, only to get the initial test repository (which everybody
> else gets) with two test submodules, to later gain a test that wants
> to use a separate repository and call "test_create_repo".  It will
> always get the pretzel submodules, which may or may not match what
> the test writer who adds a new test needs.

I agree. At the time of writing the patch series, I was anticipating writing
way more submodule tests, but now I have these future tests integrated into
lib-submodule-update.sh.

>
>> Make use of it in those tests that add a submodule from ./. except for
>> the occurrence in create_lib_submodule_repo as there it seems we craft
>> a repository deliberately for both inside as well as outside use.
>
> But isn't the point of this change that use of ./. cannot be
> mimicking any real-world use, hence pointless for the purpose of
> really testing the components of the system?  If "we craft
> deliberately for both inside and outside use" indeed _IS_ a good
> thing, then perhaps use of ./. has practical real-world use---if
> not, wouldn't we want to fix the scripts that include the
> lib-submodule-repo helper not to test such an unrealistic layout?
>

Makes sense; I tried to fix it up to avoid the ./. clone in
create_lib_submodule_repo, but the issue is there are too many
implicit assumption of these two repos, such that a faithful conversion
would just duplicate code for the submodule, (e.g. create the same
amount of commits, containing the same diffs, etc.), which then
can be argued to just slow down the test suite as the clone from ./.
is actually reducing the needed work by a factor of 2.
