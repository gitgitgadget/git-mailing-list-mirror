Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34ECF20248
	for <e@80x24.org>; Mon, 15 Apr 2019 14:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfDOODN (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 10:03:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55301 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbfDOODK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 10:03:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id o25so20811266wmf.5
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 07:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=F2+0vwsqZMOWgdXhvChk8xV7vI4k1KkWF82FTbBM03k=;
        b=a9C+MI3Xh2IRyE+BuhPsHZyxPcnnnBdJzGcXxPAkCoZYIBvyNIlzjhwMhhjn/rM5qT
         djUnFIz2+SGmB0tkK38AXHqTkschltMkBR1DwbL+Ut0ocZr2/9gl2ViZxMECnIR6+Bvn
         TfJdITCnF3g8Iu/Fq7lmF8TMw1IIp+s2dVqfkmOgW3ePv3FSvdDEeUOBdQ45SwWqeq+4
         1eaTUAvauxZDGYoCwEkKdRs3jIaASfKvN2FQboFU2ZJLmBKgThjXLEmVgl2eP8O+1Kxd
         oNTs/lrNwfUTX3NnLjRq5PY+T+Ibkzcc2kiVNYyWdxDSzvGkbxUX8JFeJyifg6BJ4lWV
         +izA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=F2+0vwsqZMOWgdXhvChk8xV7vI4k1KkWF82FTbBM03k=;
        b=eGyTUdKZv+YSadpoXGIIEAL41vxiCPExuULhbvR0Rq9jlupqJyTwUd8vUIsXXYQquX
         glRR7R0UxO4KU2cQjcM8DdW5zDwaEJod9OFPaCt9EaUloKLJI7s51VvPnbEhOy2mEwe1
         ZAeVHocb8kgEvAdSrRmiTs2xHqKWdMVaTfzQKqIt7wp/ZWD7ETleR9zfYx8fM6tn0enE
         T6eBxBt+JhLGAgt/wybqFFKkw1JEQEHsGC1+iwoqvAgk6OJGZO2h6tzufApa5NSm9uxM
         LRYyO83k9ulAnrgAixVh94QAkM32PQqSts/PLXy9Q4lE7VszRJ06YTYzVPDVVQatygeU
         /PgA==
X-Gm-Message-State: APjAAAXybSt8ZkrGF88LkNyKKEhcb5PXrRInD3R1+koyVCkeFAtiKKlX
        fXUl4Twqmzy0HXh9z+bTztY=
X-Google-Smtp-Source: APXvYqyGDSAS4n/CD7K1HkbIa8A1n6rQbSXW6HuNjbUkyV7mcl+/D8rfOhBgOxfjlExOdTSCyAfogQ==
X-Received: by 2002:a1c:988d:: with SMTP id a135mr23987216wme.24.1555336983777;
        Mon, 15 Apr 2019 07:03:03 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id c20sm88962675wre.28.2019.04.15.07.03.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 07:03:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 7/7] Turn `git serve` into a test helper
References: <pull.168.git.gitgitgadget@gmail.com>
        <411587e4b80bd4e5a1cb9b1ec438cda7a0681465.1555070430.git.gitgitgadget@gmail.com>
Date:   Mon, 15 Apr 2019 23:03:02 +0900
In-Reply-To: <411587e4b80bd4e5a1cb9b1ec438cda7a0681465.1555070430.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Fri, 12 Apr 2019
        05:00:37 -0700 (PDT)")
Message-ID: <xmqqa7grqsbt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The `git serve` built-in was introduced in ed10cb952d31 (serve:
> introduce git-serve, 2018-03-15) as a backend to serve Git protocol v2,
> probably originally intended to be spawned by `git upload-pack`.
>
> However, in the version that the protocol v2 patches made it into core
> Git, `git upload-pack` calls the `serve()` function directly instead of
> spawning `git serve`; The only reason in life for `git serve` to survive
> as a built-in command is to provide a way to test the protocol v2
> functionality.
>
> Meaning that it does not even have to be a built-in that is installed
> with end-user facing Git installations, but it can be a test helper
> instead.
>
> Let's make it so.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

I've excluded this step from tonight's pushout, as I would want to
hear from the people on the other side who have (once) thought that
this was an addition we would want to have, before we remove/demote
it.

I do not personally think, as the design of v2 stands, a standalone
"serve" server that "can serve anything as long as it goes over
protocol v2" makes much sense, but perhaps those who have been doing
the v2 work may have different ideas, in which case let's hear what
their plans are.

Thanks.

