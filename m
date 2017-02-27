Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 812AF1F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 22:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbdB0Wzr (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 17:55:47 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34836 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751834AbdB0Wzo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 17:55:44 -0500
Received: by mail-pg0-f66.google.com with SMTP id 1so2405209pgz.2
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 14:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dmn2Xvpeh+7zdJsPM1VxjMoVr0hgXC1xgvm1OA3tHcM=;
        b=rzJ6OVsNb/2C0Kxp8uqH+pPM4p6YQgMLgvJiRfkVuPXqHwZZTiXvdzCrBJf3DrcK0n
         +38x5N8d27jTffjxxUX6CO32BYunvOF/43q/4qGEVw3vF19SMJkNFezV0yJRv1pJD1Xl
         picoJv7+CWVBIuiHSpg83twRG+PhnSGOHEnThoQbNnEDAzuVLq1T6qnlNR8NJOb1EVbx
         aDYmnj25Kt/wyCIa69gSToULGdkrFnUmyPLsAffKK/9MQfmt+N8frwQTb+OVhYJgKIi0
         Xpq8mkoXiTR4I1ufGYn77JsQzPbI3Z+MM0iWMNull1Up9el1kNzuXVwjbAJsKFvBpUhL
         e1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dmn2Xvpeh+7zdJsPM1VxjMoVr0hgXC1xgvm1OA3tHcM=;
        b=VAohQRekXRbtn2NqLo5T2BA39pRSTXZdneH1UKZfRVt+COzanZb7xpHwda4i9r4zdM
         nPc9/WJMRRIqSqtR0+CNtNSZt5Wnaz8CCuqe+9aHlROihXQ62X/Sk0GJ+4NCGvxaCyAh
         ztRaYxOn3qJ3dAB2U3BtN8DQ5Nz+BwbWnuEcJkdOtsEpMdYfiZHZhixcBLQ3WFzSbg3o
         kOR9ik8vBIEoqoAPT7Uc3cwuQmzFLSxmYqjrhsVr+4280zC6J9Bo2+w0/ri3NdiclA/r
         O1aYEpf8vnF/MUp7zk5K26c1qc/4lNXEQzBBO3L77giReKsYOVYqV42B2OjHrdb/QRG6
         M8aA==
X-Gm-Message-State: AMke39ljTMr91+2EOSC32CiKc5bLrJcKMN9Zc5pWceZbcpA8u6xtU75eVy1vbCVRtP3zPw==
X-Received: by 10.84.212.8 with SMTP id d8mr24283932pli.152.1488236143034;
        Mon, 27 Feb 2017 14:55:43 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:c953:ec42:862e:1e81])
        by smtp.gmail.com with ESMTPSA id o1sm32698256pgf.63.2017.02.27.14.55.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 14:55:42 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/6] t0006 & t5000: prepare for 64-bit time_t
References: <cover.1488231002.git.johannes.schindelin@gmx.de>
        <3871d1d9de0315a1a98bce5d8f544a5e18917f25.1488231002.git.johannes.schindelin@gmx.de>
Date:   Mon, 27 Feb 2017 14:55:41 -0800
In-Reply-To: <3871d1d9de0315a1a98bce5d8f544a5e18917f25.1488231002.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Mon, 27 Feb 2017 22:30:26 +0100
        (CET)")
Message-ID: <xmqqd1e3mefm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This quick fix, however, tests for *long* to be 64-bit or not. What we
> need, though, is a test that says whether *whatever data type we use for
> timestamps* is 64-bit or not.
>
> The same quick fix was used to handle the similar problem where Git's
> source code uses `unsigned long` to represent size, instead of `size_t`.
>
> So let's just add another prerequisite to test specifically whether
> timestamps are represented by a 64-bit data type or not. Later, when we
> will have switched to using `time_t` where appropriate, we can flip that
> prerequisite to test `time_t` instead of `long`.

The changes that move from LONG_IS to TIME_IS in this patch are all
about time (iow, LONG_IS_64BIT prereq is still used in the check on
sizes).  The patch looks sensible.

