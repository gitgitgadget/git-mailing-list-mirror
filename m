Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05CFD1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 21:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753296AbdBIVyI (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 16:54:08 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35736 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753258AbdBIVyG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 16:54:06 -0500
Received: by mail-pf0-f193.google.com with SMTP id b145so76405pfb.2
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 13:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9FNFns9EQKir1tdxdTvg3bzwIAaLpzFks7s0fOtVdWg=;
        b=YqObBZc9no+N7aKERW29S+CcFWUQlSokntZHwvwAXWRMvICg02XACpY3Xj6XQR1HdB
         6jWf/QHV+Ao4KkiffceRv8XIIsHMu3VoEUKBc3qfLth3YBlJW7cLiK4HqCbZNoUAIIue
         Tx+lv+VzwZzpesmRSNiguTw9ckXQxWcZOQ1r17QPbBjxwwBTs59SP24Ivc5x5xWjZZkh
         2wlPBENeRO63S1IT7s+bKj6G++/1+aRDsXnQlmlqk7lPNim3ZJwMMhkQ6AHW15tazYw6
         gQIPT+7BzBL5+s75TXjO3jYUi5yW+i7xoel1vIvtHaq6Zp0lHzxm/hne5ueShOtuCAQD
         Ublg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9FNFns9EQKir1tdxdTvg3bzwIAaLpzFks7s0fOtVdWg=;
        b=i7cf0opS0lrh+Y+8VdxNLP6RkO4MpyNmGoRnICh0hGlFQv19jsHmSoLVY3sOU7mxOl
         uA+//Z7kYuU+ZW2FNzjHKAensISxB3Q6cnJ2FmJmWNnQkUJ7aWKTE02NkLGbw7N3w0+q
         N+oi0x6dHYKOjnnhxV42dQ9RLVvkdaz0hyisnNRdazdtOb7L2xYbP5xylPrbF+z/qaSK
         HhEr03CfP6IG7xOiDnOM3B8pWM6Jzgr/tJ5Rz3aGsHHTsrp2DOZQ3ORHDKC5ObyF2Q8h
         vTXqHla5xoROd8iJzVufhFdk//atkt4Wqxzk76QfC7P63R1D6DBVubLc5AyMc3IxC7yg
         8UtQ==
X-Gm-Message-State: AMke39mp7Y5TJ8S6H5rL3AB8zMZAOxUlkMc94gPB07NPCZEPAPx5KEO0tpCgsJllU8OzjA==
X-Received: by 10.84.192.107 with SMTP id b98mr6758589pld.160.1486675286718;
        Thu, 09 Feb 2017 13:21:26 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:704f:61dd:c9f4:9782])
        by smtp.gmail.com with ESMTPSA id t185sm31296881pgb.32.2017.02.09.13.21.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Feb 2017 13:21:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Ashutosh Bapat <ashutosh.bapat@enterprisedb.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Bug with fixup and autosquash
References: <CAFjFpRe8zqxs4OLbCrjnuEzF=75sbBJ+HuZqek49B=O=TFHq8A@mail.gmail.com>
        <xmqqbmucuwb0.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702092142020.3496@virtualbox>
Date:   Thu, 09 Feb 2017 13:21:25 -0800
In-Reply-To: <alpine.DEB.2.20.1702092142020.3496@virtualbox> (Johannes
        Schindelin's message of "Thu, 9 Feb 2017 21:55:48 +0100 (CET)")
Message-ID: <xmqqwpcznjqi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This prefix match also happens to introduce a serious performance problem,
> which is why I "fixed" this issue in the rebase--helper already (which is
> the case if you are using Git for Windows, whose master branch builds on
> Linux and MacOSX as well). I quoted "fix" because my motivation was to fix
> the performance problem, not the "incorrect match" problem.

In other words, regardless of your motivation, you "fix"ed both,
which is very nice ;-)
