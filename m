Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CE651F404
	for <e@80x24.org>; Wed,  7 Feb 2018 20:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754547AbeBGUTV (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 15:19:21 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:50879 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754266AbeBGUTU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 15:19:20 -0500
Received: by mail-wm0-f54.google.com with SMTP id f71so5467191wmf.0
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 12:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rnq3IT114fUuhpfHZowZKwjyGz33hvyJcUSXtvSecjc=;
        b=CmmT7R41Dha5HIo07Mg3jUmU3jNnTrdHTLYV6lSZQAthnWJFD8TICacghdA0xv2AbC
         UQfIUo/hcR+um5WsQLad4ltU6zjSXfVwr6RkqviUY89aAnacodSK7qtaHIJjbsEg9ywh
         55HTYmaUH1v0qzm/ecAY63GLCM+M6BbF7/G1EWp3YOEwVbBy3Fv/7mY/2zb4R7KVKy5g
         lfr8rnkQAmVsfG6dO5iDOLJ6BvKS7qQ/NJaFp1SsZfEXtk7ISHQctowFazw0ELVcNiT7
         EJqVi3QD3S7XrOR9Rze5SJwo0tUFF50eS5dEbyOrwqJzs/844ua3YDpOH4JcfUzY36Iv
         Vy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rnq3IT114fUuhpfHZowZKwjyGz33hvyJcUSXtvSecjc=;
        b=dll7FgN/ZJPt6Mhhq4SlXAba7/ImwfwdR+4meIh3XqUArlIyGwuSlVj6weAg1SqAV2
         h4gmnHVyosz8bu6ZqYd9BEpZ3N+UncvX/gOP4PccHBqDOQFXHIIdNEujCcPjz1TXFWmx
         U1WkT/zsv2LaFJN8AQU+02dFmiVYewKyqH/CnY7eSiZSOUIf3i3TldrxP2cz8FFMrmtz
         T1III8QT3lhURpizFzLFXPPJynPDxoIePPecOpJZ9UMC/QMMcGYuoJXKHOxoqtfRga9X
         8Ml5OOu1zLP24aHQw5NvtT2do2EEjJHjaTfIiF+LL6YsAGHqowZthAr06rEWg4Ms2rro
         sFeg==
X-Gm-Message-State: APf1xPBFpZ0aeMiK8kJAOrY7XHWGTqf65BlOjNZ11+ZfGqFHv3JiPcGG
        x8jt8Vq1F4b6FH45oTSN3+cvxcd1
X-Google-Smtp-Source: AH8x225axlsiMpauz+zspST1yyy6DmtCQ03LvKN2sPFYwByQiGzlS1dLScrDmzJS0E1E94NWDJD8ig==
X-Received: by 10.28.207.131 with SMTP id f125mr5320241wmg.32.1518034758863;
        Wed, 07 Feb 2018 12:19:18 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 56sm3903420wrt.23.2018.02.07.12.19.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Feb 2018 12:19:18 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Todd Zullinger <tmz@pobox.com>, Jason Racey <jason@eluvio.com>,
        git <git@vger.kernel.org>, Paul Smith <paul@mad-scientist.net>
Subject: Re: "git branch" issue in 2.16.1
References: <2412A603-4382-4AF5-97D0-D16D5FAAFE28@eluvio.com>
        <20180206195754.GE1427@zaya.teonanacatl.net>
        <CAGZ79kaxf3qUyOe6R-LCgyLtwzrwhB=y767tk2qPbC_KR473ig@mail.gmail.com>
        <5A7788B0-6250-4D1F-A86D-E3155C03EF0C@gmail.com>
        <20180207200859.GA9141@sigill.intra.peff.net>
Date:   Wed, 07 Feb 2018 12:19:17 -0800
In-Reply-To: <20180207200859.GA9141@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 7 Feb 2018 15:08:59 -0500")
Message-ID: <xmqqbmh07dtm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Keep in mind that we always run the pager, since we don't know ahead of
> time how much output will be generated. It's just that with certain
> configurations of "less", it may exit if it sees EOF before there's a
> whole screen worth of data.
>
> This is controlled by the "-F" option. By default, Git will set LESS=FRX
> in the environment if you do not already have a $LESS environment. So
> some other possibilities are:
>
>   1. You have $LESS in your environment (without "F") on one platform
>      but not the other.
>
>   2. Git was built with a different PAGER_ENV Makefile variable on one
>      platform versus the other (that's what controls the baked-in LESS
>      defaults).
>
>   3. "less" somehow behaves differently on macOS. The "F" behavior is
>      quite old, but possibly there's some platform-specific bug.

4. Between your two runs, you do not have that many branches to fill
   the screen vertically in either case, but only in one case you
   have a branch with very long name (or perhaps "branch -l -v" made
   a line longer), and you have S and F in LESS environment.  The
   case that shows branches with short names will cause pager to
   exit at the end, while the other one, because it wants to allow
   you to scroll sideways, will not.

