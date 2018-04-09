Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 165DD1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 02:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755786AbeDICgE (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 22:36:04 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:51750 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755638AbeDICff (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 22:35:35 -0400
Received: by mail-wm0-f54.google.com with SMTP id u189so15175263wmd.1
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 19:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jWIlMT4xkYBDcIFjbCitDIGiae1Zx6q9zgnL6Ih++no=;
        b=AtvW6FVvjtWwAdB/ZnaNr++GMae9tG29gaenfVJdW3GcLu8yTxqAvdVFTVVrHhOkIg
         5hwRsgj1y3dj2wnG7uSY2JK0CK9aJMEq46BxgQo5ZFjhwOdbazTQulTXbAU45qDXm+a8
         p3Ko6kCgpnYf2djd1FGZMzbjIUs39gf6EM2O5J7QVrOeoTwvjsEtnHuvxNN8waTPyP+y
         khEmsJJ0mQWJb+B/8rnqRtyNy2p33k1HrgbVRJ2bt/6OsSzqUV9zpMhjoS44IMGOsgKa
         eUiuH/3ik8J0NvP8vwy4CuVxaDxunFncUPQ+As5gnXyT4WJWb3EMkMRgSt+W3HlMpL/u
         vRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jWIlMT4xkYBDcIFjbCitDIGiae1Zx6q9zgnL6Ih++no=;
        b=D8/s3Xov/hRRrZzYAHNhke5yBhL9Rc5IsIbRTUPjaVb+ZNUByiXpCEsux2ktIgSeQQ
         2d9nzPaYRddhctZexSB8R3VyYmb36pfhc+xC0kd7uQ8B/oQIwbDIx+fo1PVFtUtB4PYx
         pN67JFvcGjrZD8lBt5CoqYaqfMYlWIoEZk4BWOUUOj27mD+CnOgmKXL2U5i32nXQpoZ5
         0n+2I4/vF199A4uPJ0Vfj0u4+WHPmgiYRJk4oJk8LB1z6AGTMp+/gyQRLb4o0DNn5iFl
         o0HFfVhpYIfiafkBhEjDCuce5qeqKyLv5GjGJG6fcTvrSqXvdepGfWATDX+vBvlb12+p
         v0aA==
X-Gm-Message-State: ALQs6tAOPOh4N+EuXsINBdnHHpaYWQGFKKfNHNgwmwNumQHvb3uYs+ed
        wRnI8JYhzelWQ6VWcB/EWXQd3FL5
X-Google-Smtp-Source: AIpwx49Fjd36LZMHU3eNwyqYSWTzPOrVDHeRV3C829IBfWKYTIgLRYkxELzQUoCJuQfnItR8ifTkGg==
X-Received: by 10.28.231.4 with SMTP id e4mr18020928wmh.23.1523241333751;
        Sun, 08 Apr 2018 19:35:33 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j21sm18823436wrb.49.2018.04.08.19.35.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Apr 2018 19:35:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t/helper: 'test-chmtime (--get|-g)' to print only the mtime
References: <20180406221947.28402-1-ungureanupaulsebastian@gmail.com>
Date:   Mon, 09 Apr 2018 11:35:32 +0900
In-Reply-To: <20180406221947.28402-1-ungureanupaulsebastian@gmail.com>
        (Paul-Sebastian Ungureanu's message of "Sat, 7 Apr 2018 01:19:47
        +0300")
Message-ID: <xmqq1sfp6r9n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com> writes:

> Compared to 'test-chmtime -v +0 file' which prints the mtime and
> and the file name, 'test-chmtime --get file' displays only the mtime.
> If it is used in combination with (+|=|=+|=-|-)seconds, it changes
> and prints the new value.
>
> 	test-chmtime -v +0 file | sed 's/[^0-9].*$//'
>
> is now equivalent to:
>
> 	test-chmtime --get file
>
> Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
> ---
>  t/helper/test-chmtime.c              | 44 +++++++++++++++++++++++-----
>  t/t2022-checkout-paths.sh            |  4 +--
>  t/t3404-rebase-interactive.sh        |  2 +-
>  t/t3510-cherry-pick-sequence.sh      |  4 +--
>  t/t4200-rerere.sh                    |  8 ++---
>  t/t5000-tar-tree.sh                  |  2 +-
>  t/t6022-merge-rename.sh              | 25 +++++++---------
>  t/t6501-freshen-objects.sh           |  6 ++--
>  t/t7508-status.sh                    |  4 +--
>  t/t7701-repack-unpack-unreachable.sh |  6 ++--
>  10 files changed, 63 insertions(+), 42 deletions(-)

Thanks both for suggesting and implementing an obvious improvement
and updating many places that are helped by it.

Will queue.
.
