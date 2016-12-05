Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D067C1FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 21:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752794AbcLEVzU (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 16:55:20 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:35511 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbcLEVzS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 16:55:18 -0500
Received: by mail-qt0-f173.google.com with SMTP id c47so328619530qtc.2
        for <git@vger.kernel.org>; Mon, 05 Dec 2016 13:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6dd7YAVLaUpIoCVnypmuUMJsMpD6Xavp5Vb0OW50VWM=;
        b=BL2AA07ttC8XjiOQbvfimDXx+5VdsQC1HviXvomhj1tXMt4H/L1fkZUS+jriJAcIuc
         7IkmMmLQyAJWrPAfKLF3UEaMkuNhLaTOSICE6VzrgjC3+O7r8p588KilW7MEUbLA8ANR
         kTXmTysVjFnMKY6bnRuBe5eDRdzZDDSCe5qAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6dd7YAVLaUpIoCVnypmuUMJsMpD6Xavp5Vb0OW50VWM=;
        b=GUsJUFmHWRj0zRGgDHxUJmoYxD7DG+46QPgbYWhGOfSXN8v8LZ2kSDj2jKDP0oMwyq
         VWWczO1svkgdaU9eH/NpPP/AQNiJYvz0nveOHPWFd/dCfp//UBtjkx/Sm8THTdn6UFDj
         9QGoXJfZ2K0OpFV9lWDyom0c0yfo2IePO+xS4mKuWstZaCrf4k/uL8i1L1xvOgXQ7DI7
         UX1ODzyFFZjtwDZD/ndktx3BaiR3yJo4ykwXuitIG3wEZCdIH4RFtgyr/AvrxiJpt2oA
         r8HA+phEOPVjrAMzUe+tz8XecXSiTMVSY+FeeuylqFpF7QBj6mY+Q+T8xS0Yie4aLxsN
         Q4dA==
X-Gm-Message-State: AKaTC0360FTtLE4oyX7J4bH/EDDAEa/GbPHfrhUqTDiypP3ZQaiv4Dzsq+Rq4QwGXHughehCGNRaKWXDp0U33g==
X-Received: by 10.200.51.148 with SMTP id c20mr50408266qtb.228.1480974917912;
 Mon, 05 Dec 2016 13:55:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.47.111 with HTTP; Mon, 5 Dec 2016 13:55:17 -0800 (PST)
In-Reply-To: <xmqq4m2i3w8b.fsf@gitster.mtv.corp.google.com>
References: <20161202224319.5385-1-luke@diamand.org> <20161202224319.5385-2-luke@diamand.org>
 <xmqq8tru3xom.fsf@gitster.mtv.corp.google.com> <CAE5ih78Y_AbfgtW_6zMKLC8NzBxCKSagrgrjtfWZVOEwaAg6ZA@mail.gmail.com>
 <xmqq4m2i3w8b.fsf@gitster.mtv.corp.google.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Mon, 5 Dec 2016 21:55:17 +0000
Message-ID: <CAE5ih79efEu_2jgE9V-N7+UetyYu7RjH62whcfvMBtwM-Nb8Sg@mail.gmail.com>
Subject: Re: [PATCHv1 1/2] git-p4: support git-workspaces
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Users <git@vger.kernel.org>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5 December 2016 at 21:24, Junio C Hamano <gitster@pobox.com> wrote:
> Luke Diamand <luke@diamand.org> writes:
>
>> On 5 December 2016 at 20:53, Junio C Hamano <gitster@pobox.com> wrote:
>>> Luke Diamand <luke@diamand.org> writes:
>>>
>>>> Teach git-p4 about git-workspaces.
>>>
>>> Is this what we call "git worktree", or something else?
>>
>> Ah, I think you're right!
>
> Then I'll queue it like the attached.
>
> HOWEVER.
>
> How fast does isValidGitDir() function need to be?

It doesn't need to be fast.

> The primary one
> seems to check HEAD (but it does not notice a non-repository that
> has a directory with that name), refs and objects (but it does not
> notice a non-repository that has a non-directory with these names),
> and this new one uses a test that is even more sloppy.
>
> What I am trying to get at is if we want to use a single command
> that can be given a path and answer "Yes, that is a repository"
> here, and that single command should know how the repository should
> look like.  I offhand do not know we already have such a command we
> can use, e.g. "git rev-parse --is-git-dir $path", but if there isn't
> perhaps we would want one, so that not just "git p4" but other
> scripted Porcelains can make use of it?

That would be nicer than random ad-hoc rules, certainly. I couldn't
find any obvious combination that would work.

Luke
