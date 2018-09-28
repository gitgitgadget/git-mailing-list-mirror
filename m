Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D438B1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 01:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbeI1Hqr (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 03:46:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37036 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeI1Hqr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 03:46:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so4556272wrr.4
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 18:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=FvzOupFwsLy5NPDeDiwjGbNNUJY54hO2b2PUbpw5fgY=;
        b=LLBayxyGunyy37dAAHujF6ogRGox4b75EG7IOkHlL2szNylU+ewWGtmVpcQI/BXLwW
         XGTP+qAlqrw5opoAbZ3xDC7EFzLfjHUzYzP3VnbY/5zljCSNrPcBXsIub1nV2x5JXvII
         ENw6Og7pk90md3k+voVd1ozLU5gdpNxepnKoUdSZ5fparx3H93btA2+qk56YBh6gSdo5
         0CJtYrBoXBjVZUGNSl9QgIZl80pncIpQ0XZXybJRxdXG4lS4XKYaEnE/jjULSN87XGC8
         mm/kIMfabUA/uVmDGy4bu3X8I7L3VYinCvBf25cuHbB3b/Ikvu5Jg9likTnT02lJtOkT
         LZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=FvzOupFwsLy5NPDeDiwjGbNNUJY54hO2b2PUbpw5fgY=;
        b=MWcVsSbYIaADxyr2RHvxYef/o3LiZwRDteSMSQhwuZMbq/yft7L6l/2WEs6dpoD9Cf
         yVrXMWrFgTjP1RP49nb46dJEpnJ7U8CbMTEF8pxcW7XhOTKTvjRbn6VnrHTaRNvC3ZaE
         cNzCAqFrPRWRm39KOZX0tTHJr7C6plRCLGMBv6eX74Ep1aU1ZDM6W/NwT5Cs5j30+MGO
         uVEBjT9c64rvF3pg9eQPFf4fbFAWRzaMvAdvw0dqwH+iIl31WCugsrKkQ4M0FPtYBP2z
         9yvNt8X4GsULMMl+PbGYYo2hjGppDg6kMVuZS9G4Ed0LZO5+26Gke03iJACzENnw4lWM
         6AFg==
X-Gm-Message-State: ABuFfoir7+XZJ7hvzkK8airNtcouCBvXVWvf1pFcKQxOz3+qERtR9I88
        wJS8k7eEVHYnkluus418l/4=
X-Google-Smtp-Source: ACcGV60P7oEYgh4UdoAgZ3hIB56FZqnezUn+Zkx4IIvMGE4kPJxQnyNEcugnjTTSq7TUKWbiviBgfw==
X-Received: by 2002:a5d:4488:: with SMTP id j8-v6mr6288185wrq.236.1538097937041;
        Thu, 27 Sep 2018 18:25:37 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q5-v6sm2256838wru.79.2018.09.27.18.25.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 18:25:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Add proto v2 archive command with HTTP support
References: <20180912053519.31085-1-steadmon@google.com>
        <20180927012455.234876-1-steadmon@google.com>
        <CAGZ79kaBvHwUUf0rXeAwBY-M+Oi9JjsQnLs4v3FAvx4a9ZRbSA@mail.gmail.com>
        <20180927183017.GD112066@aiede.svl.corp.google.com>
        <xmqq1s9efuqc.fsf@gitster-ct.c.googlers.com>
        <20180927223314.GA230445@google.com>
Date:   Thu, 27 Sep 2018 18:25:35 -0700
In-Reply-To: <20180927223314.GA230445@google.com> (Josh Steadmon's message of
        "Thu, 27 Sep 2018 15:33:14 -0700")
Message-ID: <xmqqwor6e7lc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> Yes, the version on my desktop sends version=2 when archiving:
>
> ∫ which git
> /usr/bin/git
> ∫ git --version
> git version 2.19.0.605.g01d371f741-goog
> ∫ GIT_TRACE_PACKET=${HOME}/server_trace git daemon \
>   --enable=upload-archive \
>   --base-path=${HOME}/src/bare-repos &
> [1] 258496
> ∫ git archive --remote git://localhost/test-repo.git HEAD >! test.tar
> ∫ grep version ~/server_trace
> 15:31:22.377869 pkt-line.c:80           packet:          git< git-upload-archive /test-repo.git\0host=localhost\0\0version=2\0

Ah, that's truly broken.

Come to think of it, do we need to be using uniform versions across
different endpoints?  The archive request could be at v3 while fetch
request could still be at v2, in which case the design to use a
single protocol.version variable is probably the root cause of the
confusion?  Perhaps like protocol.<name>.allow, we would want
protocol.<name>.version or something like that (and no
protocol.version) to make it clear that protocol v2 used for
fetching has nothing to do with protocol v1 or v2 or v3 used for
archiving?

Luckily, protocol.version is still marked as experimental so it is
not too bad that we caught the design mistake (if it is one) and can
now correct it before the damage spreads too widely.


