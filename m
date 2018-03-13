Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEE891F404
	for <e@80x24.org>; Tue, 13 Mar 2018 21:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbeCMV50 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 17:57:26 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:52328 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbeCMV5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 17:57:25 -0400
Received: by mail-wm0-f46.google.com with SMTP id t3so694647wmc.2
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 14:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=XFM6EZX9fvz1SVhfLizSRCLxUjEiGb8ZQa64avCmzHI=;
        b=YjTN/GkAIGvG2bkkG5cIw3YfcRf/4I0jy/RS43NajA5SG24Rb+p+HbLVch0lsbJv4p
         3L3X0yurMXpQWlGNtUN9kZT9HEVoaMFl4/fw2NtowQc0iQBB7C1r+cZPoNCuJGrsqX1n
         P6pc5V/aEa96oUPXTMt6fqoJUazre6JA1IGCjDyftUjaxYWZI2V4/wdW9IsGMCJSmobX
         0l2DxQEDOwBMasYQ+Hcjc03G+TayJSCbZSL67RhIZ5zyLrEu/C8wHd8x9g6x9k0pi9G1
         xaB26Qhb68/AI2uu+96F2StXVqtGco6fhlzU8VC5bj+KDoHkkDjK6OsaK5drPvBtWw4o
         XZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=XFM6EZX9fvz1SVhfLizSRCLxUjEiGb8ZQa64avCmzHI=;
        b=S+shq4fhtEu+ss6ooxJ1I2uvX9PhoM8AoGcCl6fyr0QqOsqMgf/wMsd5OTrr5zcy6l
         qiFb0HxW6bV7rTQvc9kKrqEiMU8XpTBoqo590Lj7/FMvudRSoNBFIgYxouiX6dqcHbXr
         sixZCB3SKKN2mnVz+71+FfZmYWc6XYvXmMEkBb1nbZiDu6rlxT/JfjlogSjsukdwuNTu
         hH5zsQxY4/dFCOInc6gy8kRB1CeHTtpd8EnfH2FtSNarPEomS3mfWazsHDUGb6eqLqCl
         srK/kZVMScI9lrqPaBT6Lmxmr8mYLCYEyde7Q6I+1hImq/d2MFdQjinmpCaiGoON8qJv
         /cbA==
X-Gm-Message-State: AElRT7GMFVtbhICZZv7NcNqBQE5EmAlPT9f7WAUmcV7ovPEpbf+AoFmE
        25ubFzfKPCuPskoS1D3SPM8=
X-Google-Smtp-Source: AG47ELtZ8h5gI6PfzpxlSqYfSEMVZUEK5J1RKxJOjYf+5iViUg0unI6E8/rzrqCawtfOnrDXHqCWJQ==
X-Received: by 10.28.20.74 with SMTP id 71mr1870090wmu.71.1520978244353;
        Tue, 13 Mar 2018 14:57:24 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id p21sm836508wmc.43.2018.03.13.14.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 14:57:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Alexander Mills <alexander.d.mills@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-log bug: --grep and -number args are at odds
References: <CA+KyZp6QZ4BmOtLFiByjmZ4NsZyDBFsqme64aT5ER-QpgD49pg@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CA+KyZp6QZ4BmOtLFiByjmZ4NsZyDBFsqme64aT5ER-QpgD49pg@mail.gmail.com>
Date:   Tue, 13 Mar 2018 22:57:21 +0100
Message-ID: <871sgnfxku.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 13 2018, Alexander Mills jotted:

> $ git log -50   ###  I get 50 results
>
> $ git log -50 --grep="*"   ### I get a lot more than 50...
>
> shouldn't `-50` minimize the results length to 50 or fewer?

On what git version? On my 2.16.2.804.g6dcf76e118 on git.git this works
as expected:

    $ git -c grep.patternType=basic log --oneline -50 --grep="*" |wc -l
    50
    $ git -c grep.patternType=basic log --oneline -50 | wc -l
    50
