Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7F231FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 22:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752033AbdBFWQR (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 17:16:17 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36124 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbdBFWQP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 17:16:15 -0500
Received: by mail-pg0-f68.google.com with SMTP id 75so10147115pgf.3
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 14:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=j2SsfeflnV0p8Pkh5212ekKk6m0OA6zV9g88twaj5Rk=;
        b=bnRApRt3YwVmKqdB+JGo00FFaAhtgNTB4f/9SmWxmWo69iplWLG1nG+ivju/LqGzQ9
         LZXys2bH8d3/YJd/Zz1zFzxQZtNWGoCbFoicu1bM5b/uw4A+jmIbSvJjSldeWv7mtRsT
         kY+8Z2uRrGTzQy2hqJqtoTkkGImEaz7zeY5mB+apnUtH0DMjyZlm+nDYyhLbHrqG3sx6
         9g0ipwuAUAoz8b5dyFMvoitfWmqu7dPVb6ghNr8Kc/XS+y1JRpXkAL+eHsTHhhSidRrN
         mviUAFuqfUTW9TdI9BIrwij9hObgRaZ+ddFPMsq6pYhMwPuCwcTrfzhQEDBiVKZg7875
         MCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=j2SsfeflnV0p8Pkh5212ekKk6m0OA6zV9g88twaj5Rk=;
        b=EXsDNAgdLHpUgOLRghgaCp4vNOBTPnvZAlOM6goDtBx/yQTcZDxigNIvXsTNfPn8WM
         DRgeJGWvJdE8t+VNtJvaDGGjx81kQ9oJ8k892zjX4NEG/TXnTXelUCbAqKX3bYppcWd9
         3HeRSlnBbYyyozBEc6hQpOR/d75ZAgh1d8IH4KtJkUWQsFuUWVK+ZH/uvpucUSDCLb5N
         7xKOytDV0qkXnVCR2Zs3B4PEdYkVbRIf8m43ixRoKHVnIRmNrPnHW7imfYTILjNSx7J2
         /pdSUX8nTMwgcXhWzvbH3OGnuaMQjlt3mTHiEmuHWLEbY9kI3KyHKSeg/EEkMPCZwyNe
         LkKg==
X-Gm-Message-State: AIkVDXKJl6rNMFSHwGPpjOZG3Frer3obsVLXKo/OAZ5I2hkBNynuFztgQ4CuPOmWcw5sHw==
X-Received: by 10.99.158.68 with SMTP id r4mr16036431pgo.153.1486419375158;
        Mon, 06 Feb 2017 14:16:15 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:310c:cda4:fdbc:2aa2])
        by smtp.gmail.com with ESMTPSA id j78sm5080774pfk.39.2017.02.06.14.16.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Feb 2017 14:16:14 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Shawn Pearce <spearce@spearce.org>,
        Stefan Saasen <ssaasen@atlassian.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Git clonebundles
References: <CADoxLGPFgF7W4XJzt0X+xFJDoN6RmfFGx_96MO9GPSSOjDK0EQ@mail.gmail.com>
        <CAJo=hJsS6FmL9iNScaXqkWJumALfGr8Od5QkbfZ+ZG3osxkp7Q@mail.gmail.com>
        <CAP8UFD2ffeHr0-z3xPFFODqRTTgVnrrWcYRbASpUOrp0QGnp6g@mail.gmail.com>
Date:   Mon, 06 Feb 2017 14:16:13 -0800
In-Reply-To: <CAP8UFD2ffeHr0-z3xPFFODqRTTgVnrrWcYRbASpUOrp0QGnp6g@mail.gmail.com>
        (Christian Couder's message of "Sun, 5 Feb 2017 17:37:06 +0100")
Message-ID: <xmqq4m070xua.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> There is also Junio's work on Bundle v3 that was unfortunately
> recently discarded.
> Look for "jc/bundle" in:
>
> http://public-inbox.org/git/xmqq4m0cry60.fsf@gitster.mtv.corp.google.com/
>
> and previous "What's cooking in git.git" emails.

If people think it might be useful to have it around to experiment,
I can resurrect and keep that in 'pu' (or rather 'jch'), as long as
it does not overlap and conflict with other topics in flight.  Let
me try that in today's integration cycle.
