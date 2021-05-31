Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EA6C47080
	for <git@archiver.kernel.org>; Mon, 31 May 2021 20:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDF72611CB
	for <git@archiver.kernel.org>; Mon, 31 May 2021 20:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhEaUmT convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 31 May 2021 16:42:19 -0400
Received: from kautler.net ([85.214.242.4]:45944 "EHLO kautler.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230032AbhEaUmH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 16:42:07 -0400
Received: from mail-yb1-f178.google.com ([209.85.219.178])
        by h1362875.stratoserver.net with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.69)
        (envelope-from <Bjoern@kautler.net>)
        id 1lnofy-00038K-O3
        for git@vger.kernel.org; Mon, 31 May 2021 22:38:18 +0200
Received: by mail-yb1-f178.google.com with SMTP id i4so18098749ybe.2
        for <git@vger.kernel.org>; Mon, 31 May 2021 13:38:18 -0700 (PDT)
X-Gm-Message-State: AOAM531sW7BhpQApnLglOx6SijqhKH4+J1FqgQANblWm8QmvE7CCICKA
        FOAWnTmvk+w3EAgAczqT+5eeIOgENHzwJ0OrrY4=
X-Google-Smtp-Source: ABdhPJyFY4SWBowXcEUEGnMPlzAqTmRQwJGFzbJJqseGUrvOBMeZSM67RcKRTq42z0pXWHLivQdmHmnjIJ5ahkrKHJw=
X-Received: by 2002:a25:aa48:: with SMTP id s66mr26028439ybi.341.1622493492462;
 Mon, 31 May 2021 13:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAKChYSqgGRfBh68oj=Gt7q4uyS7D879aQZQiZ1RsyqaDToV+0g@mail.gmail.com>
 <07edafe5-d0a2-4a2c-12a2-28c163f6fdda@gmail.com> <YLRoAIBExd+dAe0C@sleipnir.acausal.realm>
 <CAKChYSrQ3u3yH0+8Fwj-84cnAFGvuSEPHx+5Mcy8Ys4sXcN14A@mail.gmail.com>
In-Reply-To: <CAKChYSrQ3u3yH0+8Fwj-84cnAFGvuSEPHx+5Mcy8Ys4sXcN14A@mail.gmail.com>
From:   =?UTF-8?Q?Bj=C3=B6rn_Kautler?= <Bjoern@kautler.net>
Date:   Mon, 31 May 2021 22:38:01 +0200
X-Gmail-Original-Message-ID: <CAKChYSpGJ8WHsYRgYL9M8rr7Dp_SLrUuRsTONqNO3CTnX2DQ_Q@mail.gmail.com>
Message-ID: <CAKChYSpGJ8WHsYRgYL9M8rr7Dp_SLrUuRsTONqNO3CTnX2DQ_Q@mail.gmail.com>
Subject: Fwd: Bug when cloning a repository with a default branch called HEAD
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---------- Forwarded message ---------
Von: Björn Kautler <Bjoern@kautler.net>
Date: Mo., 31. Mai 2021 um 22:24 Uhr
Subject: Re: Bug when cloning a repository with a default branch called HEAD
To: asymptosis <asymptosis@posteo.net>


It happens the same no matter whether on Windows or Linux.
I now also have a reproduction recipe on how to get into that state.
- Create the `whelk` repository with standard settings, nothing for
default branch or anything is necessary
- Execute this: git clone https://github.com/seveas/whelk.git
whelk-src && git -C whelk-src remote add gitlab git@gitlab.com:<your
namespace>/whelk.git && git -C whelk-src push gitlab
refs/remotes/origin/*:refs/heads/* && git clone
git@gitlab.com:git-spindle-test-vampire-1/whelk.git && git -C whelk
fetch

Cheers
Björn
