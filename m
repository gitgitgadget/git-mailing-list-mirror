Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 988C41F453
	for <e@80x24.org>; Thu, 21 Feb 2019 20:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfBUUBu (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 15:01:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53044 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbfBUUBu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 15:01:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so10808589wml.2
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 12:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=X0E/2nwVHzKfSWU+d5zBU0i1MCmyVUlTlNUkE8gELwo=;
        b=hB0vicRCuYiL97z5laikBRzMiNcE71BSJeDafl2M7Iu1f8gA3ug3ywF5paoFZIHMQH
         ziY/e3yaTEtdjZWMnf6iAC2banKQvJJDmpHjyUKulbWT1tfFatiI30m+8l9YRPRnhq59
         y5dkOjTxvDvVm50bpU3XYnpZHSX78nOcN8uMl/oS2WQYjAHYTIwJcB5Zm2sGiCnknVu6
         2YgJ97AI71Tye+3qw3qoGkXd3TN0Zq8Kivq7yZV2dwHV63fYPlLvg1HI/DD6PF0/h93H
         8PBkqaldrBPO1hq7MyDMN1O21mFGEDzg5WhYem6vS9SUwXUWBUHdq9sl7XloVTFsy8Px
         rsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=X0E/2nwVHzKfSWU+d5zBU0i1MCmyVUlTlNUkE8gELwo=;
        b=mIhC11+CwN0eYBCypAS+UV1XjpYt4F4Jbvx9hfuhnhriZklgRNPb85s9qHq8o3abVi
         bULadXJD2pnl2kLMWsXPmvwYIIhObJAn+Xg3zKX6CTmQNp9FQTMYXZxJT+zuVAxCLgI6
         HDg3NzFb0vsiUO7M8Fc3gliiMULZjpSaNmzL/VSc/r7gdaAi+sDYxju9591OJPD6fiQJ
         pYaGQG+g5/qgCiPIS9NqyC+i19LsWQTrtbJf5vbWyRTWf9k9PfwMn6F7oygsKOtdl+LU
         4poYfCoMRk03WiOvXHB82g6DMd+PBXmfiia4624Om/lXgPF9Mkt+m7FoRU/jFecSHU6c
         7T3g==
X-Gm-Message-State: AHQUAuaqS+lo/i4vz9eMEapsUnRX7TUXp1Ed1O3N1w844y7PSMInRnZs
        yV1mYBXFWkHM8QKGjQYCgu8=
X-Google-Smtp-Source: AHgI3IZlkggpGKHmEcW0LmbuwmQ+edj7LykQxGoqAUR0LHzmCt+lYFF5bkbRCn1pObhqFqBo1avAYw==
X-Received: by 2002:a1c:4d6:: with SMTP id 205mr167142wme.66.1550779307837;
        Thu, 21 Feb 2019 12:01:47 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c186sm14277959wmf.34.2019.02.21.12.01.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 12:01:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Mateusz Loskot <mateusz@loskot.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: "Submodule registered for path" output with config aliases mixed in
References: <CABUeae_N3NFXn-E1+LHORL3RDf5iTCFn=zyuOo3c2Aot2QF7pg@mail.gmail.com>
        <20190221021825.GB488342@genre.crustytoothpaste.net>
        <CACsJy8BKhroHhVWCj5fvwxk2z4XsdSK_pSQ=o8hxZcZsAn3R-w@mail.gmail.com>
        <20190221041756.GA28389@sigill.intra.peff.net>
        <CABUeae81zRSZrAce86R7OQgGFoc3R1Lk2X8Ujg4ZPUAGVVSknw@mail.gmail.com>
        <20190221130717.GB20536@sigill.intra.peff.net>
Date:   Thu, 21 Feb 2019 12:01:46 -0800
In-Reply-To: <20190221130717.GB20536@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 21 Feb 2019 08:07:17 -0500")
Message-ID: <xmqqpnrkud05.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Junio, Johannes: I don't know if there were particular plans to pick up
> those getenv() fixes for "maint", but if we're going to do a v2.20.2, it
> might be worth it.  It's also possible that it's just due to ca1b411648
> (mingw: safe-guard a bit more against getenv() problems, 2019-02-15),
> but I'd consider that to be maint-worthy as well.
>
> It may be that we just don't do a v2.20.2, though, since v2.21 is so
> close to release.

Yeah, they are all low-risk and straight-forward changes, and were
queued on a topic branch forked at 2.19.2 to make it possible to
directly merge to older maintenance tracks.  So if we are going to
update 2.20.x (or even 2.19.x) series, we can certainly include
them.

Thanks.
