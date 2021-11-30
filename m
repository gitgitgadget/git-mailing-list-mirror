Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321A6C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 21:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236185AbhK3VWl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 16:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343973AbhK3VVr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 16:21:47 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B0DC06174A
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:18:24 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id g14so92476911edb.8
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 13:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=zM11uPrEDodc4wOV21LyQePxIDSUR2dYouQw/L/pgD0=;
        b=BPmhiOKdeMqJHpjP6eTYIOjHojPE86nmL6aJPwxWWkgN3wCQEov+A7KEDpn1lw3v1W
         uLsuP3Ps4xZAeIrX8RMsvNBzS6leUgfsppXO6u6Px2xDaPOVNPc0Oo9XA9Ul4g+rx4Mq
         OfKbHIOfacTKuop0YnSVlZGHUhWjsqbzWVcoMtWH5rw3CcJb1otImeeUY5PkjYj5QMjm
         0aR0uxx+PHj7TIsU7QCF1SZbPAJClp5y/0oqDK5lklTJHhyk59s/uQKiqlDTyvZzrHMK
         LRL83Z8ZzOkU35WWz35o+ASncqZMBinP0Br2HbjlsVhJQ0MmP0JgQ+1ahzWdHQoeBcJQ
         53Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=zM11uPrEDodc4wOV21LyQePxIDSUR2dYouQw/L/pgD0=;
        b=qx6Ga5dRVB4Oh5dcYamP9ZD4KkhZjHkoBzshWy1k6AJYpr6zLmRMpylXUTg/m5E45B
         zvSSoX0aacy7ab+1gxykFH4wNLauuX4MUQf6RALV8zae+bcdhZdBb/1jlL7LMtx0wPTW
         a1y9mVWvirPiiITFLK5BiROBM2+VQaMfjkLw97fE1VTKB1N0DscdB626wPbx5/wDqYIV
         tWwfYFeV7xVcj4JWNTJ56v0SWlVzHA+tCiKXVLuUNHgUH3MIPLwa5M6agpvcdwH2k5k9
         lXiJ8VbEuKbqVCcAGmBcpYv8qKKhx2+H7/F/Hs1Aw8tubXFLchkljxatgkoZeu53GkLB
         P6Dw==
X-Gm-Message-State: AOAM530sjVjE0koHmALS3jVu9TLzYl7XL2NatN2i81ewCVsC7tcW6OKM
        qZiC9T8KkthFek09IcuiGAzHMYUxmuE=
X-Google-Smtp-Source: ABdhPJxMJzilgvTqBKrLHG2xWCj5U/H+usbGSUQdo3RPbd5zOPhJXFE49DN0jOzSpfTfI7Bk93VCAw==
X-Received: by 2002:a17:907:a411:: with SMTP id sg17mr1867200ejc.84.1638307102789;
        Tue, 30 Nov 2021 13:18:22 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hd18sm9453898ejc.84.2021.11.30.13.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 13:18:22 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1msAW6-001A9S-24;
        Tue, 30 Nov 2021 22:18:22 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Fabian Stelzer <fs@gigacodes.de>
Subject: fs/test-prereq (was: What's cooking in git.git (Nov 2021, #07; Mon,
 29))
Date:   Tue, 30 Nov 2021 22:17:02 +0100
References: <xmqqzgpm2xrd.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqqzgpm2xrd.fsf@gitster.g>
Message-ID: <211130.867dcpcpgh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 29 2021, Junio C Hamano wrote:

> * fs/test-prereq (2021-11-20) 3 commits
>  - test-lib: make BAIL_OUT() work in tests and prereq
>  - test-lib: introduce required prereq for test runs
>  - test-lib: show missing prereq summary
>
>  The test framework learns to list unsatisfied test prerequisites,
>  and optionally error out when prerequisites that are expected to be
>  satisfied are not.
>
>  Will merge to 'next'?

My reading of
https://lore.kernel.org/git/20211130143821.7dz5jj2z2x2q2ytn@fs/ is that
Fabian's planning to re-roll it.

I replied today to that to clarify some edge cases around TAP.
