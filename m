Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4008120248
	for <e@80x24.org>; Fri, 19 Apr 2019 20:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfDSUoB (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Apr 2019 16:44:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34647 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfDSUoA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Apr 2019 16:44:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id c6so2470784wrm.1
        for <git@vger.kernel.org>; Fri, 19 Apr 2019 13:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qgl052dp80iz5GriuZr8pq2xb4f0oTmfs7nca2BCuW4=;
        b=CDLPOsiLy1kGk3miDDs+MFqt5cbau27ZZqeF07FntM3DkFkScvpiKQSxQ9OVFWebwa
         MvnerjpKb9gBZ0Qt4Xg6VQXI9r27Omx96yGatNRUw7YXe8pUj8VzqkUwIrch4Alv+b1B
         grGAHXqVWNPFoEepioNEA55uEUSfn3LZr5lUtvsliYJVyP9vFBErMNimCTtzWizc9qZN
         dZQc/ivgSW1wr4a37ebtPyVzDsCvhDDZaqlmA/k8qge9hgDWYzlQymCKBx0MGRju5kNv
         FXT+I10NlIC0r/H0g6sxXDs9eCY4+UFDvBu86EAb30W96IEQjGE5Y5MqUVy+/pNxQatM
         Mkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qgl052dp80iz5GriuZr8pq2xb4f0oTmfs7nca2BCuW4=;
        b=bi9j9Bqr/E45Vpw1+ZS0/3oRLZWypYdy0aQLkFeDc3hHatfXr9sw3ejSp3khjoG1bD
         yyHliqwH6YhHB9hpeTjRNhrniwGAJijudvzNI7BNi/Q1SMiqZKF7wqpgPP4ojskntRt6
         +93mVHkxLm3MLdQLDq5X48newsQv0Y2s8rkunYjh/zcV/V65bNzI+6SEJYt2ahH3JyNu
         N5ZFr9PkLE2X6t+Otpk2XbLKji3MMZ8/LYc1TPNPhXY9kwoJzzQtUgEbEhf3zyx2ydRG
         8bU/PtYelmJhDgoLfxT5kJ9Hl0D74e7ixBSHRzAFkeVfugWsOZf5qe+Xhi7cWUa3qX6c
         8dUA==
X-Gm-Message-State: APjAAAWbcHJ08uj7pOEIxGmwj/3KL26Ku6DOb66Kvzn1HfPEjVxbfcYY
        6sbRjG+676jp++YmMBedIwz1eG3Zsuk=
X-Google-Smtp-Source: APXvYqwv3LFCTDM1zt0nGLZlia1wSo/948RlVnuUDz4YbGcPihaaADbQW2l0Mx0E/SnbkCahrn/AMA==
X-Received: by 2002:a05:6000:43:: with SMTP id k3mr1337640wrx.315.1555651248890;
        Thu, 18 Apr 2019 22:20:48 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id d3sm6526996wmf.46.2019.04.18.22.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 22:20:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 5/8] docs: exclude documentation for commands that have been excluded
References: <pull.168.git.gitgitgadget@gmail.com>
        <pull.168.v2.git.gitgitgadget@gmail.com>
        <f8d133c59725938afa85f6be349c2bba05fe98e7.1555593396.git.gitgitgadget@gmail.com>
Date:   Fri, 19 Apr 2019 14:20:47 +0900
In-Reply-To: <f8d133c59725938afa85f6be349c2bba05fe98e7.1555593396.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 18 Apr 2019
        06:16:44 -0700 (PDT)")
Message-ID: <xmqqef5yefkg.fsf@gitster-ct.c.googlers.com>
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
> When building with certain build options, some commands are excluded
> from the build. For example, `git-credential-cache` is skipped when
> building with `NO_UNIX_SOCKETS`.
>
> Let's not build or package documentation for those excluded commands.
>
> This issue was pointed out rightfully when running `make check-docs` on
> Windows, where we do not yet have Unix sockets, and therefore the
> `credential-cache` command is excluded (yet its documentation was built
> and shipped).
>
> Note: building the documentation via `make -C Documentation` leaves the
> build system with no way to determine which commands have been
> excluded. If called thusly, we gracefully fail to exclude their
> documentation. Only when building the documentation via the top-level
> Makefile will it get excluded properly, or after building
> `Documentation/GIT-EXCLUDED-PROGRAMS` manually.

I certainly know where you come from, but I am on the fence.  Being
able to omit documentation, without thinking, for what you do not
ship is surely handy, but at the same time, being able to format
everything you have the necessary material for is also valuable.

