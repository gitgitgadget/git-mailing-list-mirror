Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8F1C4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 13:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbiLUNGD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Dec 2022 08:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiLUNGB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2022 08:06:01 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2779517E35
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 05:06:01 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id k79so10636722pfd.7
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 05:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGroQ5b0lt3q0uNGtH5csEg7+0Zu0iCxQ6ysIM2s4IU=;
        b=D2340Co+MFLKI6xBmUk69mVRIqHgaxrZPKOx6fs6b1g70ZE84SdJotXnANxEZDdXN+
         o7AiPVXx6F6NzjWqBBWN7emfc5dAK1+P0zPIwZ0GMLRK2Py7vqPh16g2TBvRMD/F7HYR
         bs9C3BAkrv0uha2Y/X0y2uvzcuS5BYA+Zt8FyLUCgHvisRMUh4Nvm2jHdxAmTUHUL0x2
         1eqKGv6zZmlEYx1tymT5J+WxX/fGTfto5u1IybQzGEUcutJHCHXDFhFlQ+BTAwU9u94V
         DGPQrExZUM7ODuKfbzo1j9UsrhoO84KzaUROeoLET3mfiJ7CCyZdLLoGt8EISswQ1+ib
         f7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGroQ5b0lt3q0uNGtH5csEg7+0Zu0iCxQ6ysIM2s4IU=;
        b=WTk/hdnaOimP3falWE6IHsvCl654M1qKKWbALvQjXmV3+fdyTEDbtD+xy06aZs2r51
         WQn1eFq/A7IRHGPa+1FqFK/fMgKBR75hBE9NJXn4AGvRpQ9MuB7+wSBUAcze0Eydd3EV
         Z5PFjVxaAbyrMfN/T2rlA9GnlYAisprlSuegoYgc2XisZQZGmwVeafYbCGSwDaseKE4W
         /WHVnKh4gkGpPTCT0zpIAU+mo0jswItDM3QIaVlGPlXEY/n23baaPyaN/HXSBUG+WJLL
         rz84e7KXSGY6yJTg6O63mtTI7fiqQbkiiXeRfSNACObE8U4xjSubQGD99gUN2Ve7Kbaz
         tjDg==
X-Gm-Message-State: AFqh2koIkn6pq8YXPrkkeUqrisQRl8D+5ZbVk724NahChCRt+I7c/yHc
        9RNhEqsr1pMwXIgCRreF44U=
X-Google-Smtp-Source: AMrXdXuwHZIcjU9P1Tiu62JedlXGo/5FCq4piiH+TiGVkRbAAKiFUtYV8v5hQqY8GhIYssFlWV24tQ==
X-Received: by 2002:a05:6a00:1d03:b0:573:a0a0:c5d2 with SMTP id a3-20020a056a001d0300b00573a0a0c5d2mr1735412pfx.7.1671627960533;
        Wed, 21 Dec 2022 05:06:00 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x4-20020aa79a44000000b005769cee6735sm10558012pfj.43.2022.12.21.05.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 05:06:00 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: js/drop-mingw-test-cmp, was Re: What's cooking in git.git (Dec
 2022, #03; Sun, 11)
References: <xmqqpmcqv7qh.fsf@gitster.g>
        <o428pr88-sn2p-o715-52ns-1r6750762572@tzk.qr>
        <xmqqa63ss3fl.fsf@gitster.g>
        <c57ecd23-7ca7-2501-983f-6661c7872a01@gmx.de>
Date:   Wed, 21 Dec 2022 22:05:59 +0900
Message-ID: <xmqq7cyksy88.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> IIRC the review comments hinted that MinGW specific test_cmp that
>> equates CRLF and LF are no longer needed,
>
> That does not match my understanding. The MSYS2 tools we use in Git for
> Windows' SDK (and therefore, in the `win` jobs of our CI runs) are outside
> of our control, and have been known to change behavior with regards to
> line endings.

We may have been following two different threads, I suspect?

The behaviour of the platform tools may unexpectedly change without
any good reason, and you may not be able to file a bug report when
that happens.  One way to allow our tests pass in such an
environment is to make them sloppy to accomodate the potential
variation in their behaviour.  That is what the "ignore line ending"
comparison gives us.

But it means tests in MinGW environment would not notice if the
output _we_ produce from Git has unintentional changes, no?
Imagine we break the checkout codepath to write LF working tree
files when we should write CRLF, or vice versa.  A lenient test_cmp
under discussion (whether the one in the current codebase, or the
one that the patch wants to update) would not care.

I know we have been operating under such a test environment, but
after seeing the exchange between Réne and J6t, I was hoping that we
do not have to keep being sloppy.  After all, noticing unintended
behaviour changes in our code is the whole point of running tests.

Getting rid of the "ignore line ending" comparison would mean that,
while we would be able to catch _our_ bugs, we would also notice and
have to deal with unintended behaviour changes in MSYS2 tools.  But
how bad would it be?  I doubt that it would be like you update from
upstream every other week, and every other such update flips the
line endings---that would make you scramble, filing bug reports to
MSYS2 and temporarily patching our tests to be sloppier, once every
month, that may be a bit too often.
