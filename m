Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12E211F404
	for <e@80x24.org>; Tue, 10 Apr 2018 23:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754641AbeDJXbU (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 19:31:20 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:39115 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754616AbeDJXbS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 19:31:18 -0400
Received: by mail-wm0-f49.google.com with SMTP id b21so457808wme.4
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 16:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=iTwU39bqTf+D20NoxIr98nU+Ty6fspY3ORUx42TXQUE=;
        b=qQteuACt0kFAQ1YuaVY5TGdmLdHMkZo3LT3VOKUkiyNSJs5czVSgsT9M8fRq02w2hg
         Zot4OMTRP+v3nYHbcZtVZaD3I9ySkhuOJMBnZ6Cmhi/qIBU3umBdKSV3A2pZF1Gj9UZ3
         hTRNRJ9qnUbAy9DK7EqQr9MkAaXJ5gMA5CwTlM5ciTGkSC5KhshdoHgWNv5S+9ROLL9/
         3ft7zVpH0MO0AISBCC7mf2g5lMhTFb9JVYlVH/6abNETq/oe0QiZtcvsHK/VmKpqYpje
         ZbJCLLABsNVmfJHlyowdvLXioZJcIvPPFg2GmE90A43BllA9o/H8d6RV1cmCqQZAxVNj
         Cy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=iTwU39bqTf+D20NoxIr98nU+Ty6fspY3ORUx42TXQUE=;
        b=nsaEsu5wd3XJ9ElGnUbAcHyutjxlJ/QCM2RCufoUmdoMqpWUHa/NZluMySTmpBgqQC
         50dPwUF2hY3rWb+mAGkSRrZ+ihHtPfehvltftxX+zFnU8OF/UYcjp4qD4o7uPqsqpH5s
         fax30Rmyc9CVfRD7fvJrrMFRzSMPQ05eJpuNzp1amdU4/lWw3L6Rvs8lbnXBKA5xo5oE
         YjiF+bd5adTqArtpWXd84Z8FUxQUcbcVgySn+UtZ0H/QMR7MIYa2F5tK3LJiLoprqBJw
         il/zMzuIiJ5SlFzPN7S4RAwa0yF+ZHCh0jxB+IsOn0W7EZky03U9/TkTj2jiz7ZywZTA
         8pKw==
X-Gm-Message-State: ALQs6tD+3gpbrx6f/JDtfjk1x/aU9yv6IceXPtZZ4yxj91thFc2PtRBz
        J7AOMGgznBJr3TJzgsT+sRZjaL5L
X-Google-Smtp-Source: AIpwx4/cDgy2jgQzi3Uib8mnhWAncJZBtvMSj2PaBAZgbOOhHlU3gcBelcigpVzbYymDTUbfGB7mKw==
X-Received: by 10.28.237.11 with SMTP id l11mr875444wmh.124.1523403077376;
        Tue, 10 Apr 2018 16:31:17 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g38sm5832171wra.77.2018.04.10.16.31.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Apr 2018 16:31:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>, git@vger.kernel.org
Subject: Re: git remote rename problem with trailing \\ for remote.url config entries (on Windows)
References: <da730b21-58ae-bfa8-705f-7669c0f56764@syntevo.com>
        <xmqqo9y6dj1s.fsf@gitster.mtv.corp.google.com>
        <nycvar.QRO.7.76.6.1804110020380.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Wed, 11 Apr 2018 08:31:14 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1804110020380.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Wed, 11 Apr 2018 00:35:08 +0200
        (DST)")
Message-ID: <xmqq8t9u1vwd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> A quick test with my `empty-config-section` patch series shows that it
> addresses this issue. A quick bisec confirms that the patch with the
> online "git_config_set: make use of the config parser's event stream" is
> responsible for this fix.
>
> At first, I was puzzled by this, because I expected `git remote rename` to
> be backed by the `git_config_copy_or_rename_section_in_file()` function
> (which my patch series does not touch).

I played around with this test data:

        [sec "tio"]
                val = a\\
                ue = b

and saw "git config --rename-section sec.tio sec.tion" just work
fine (without the event stream change).  Without the event stream
change, "git config --unset sec.tio.ue" loses "sec.tio.val" but with
it we see we only lose the last line, which is the correct thing to
happen.

Nice.
