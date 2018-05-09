Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 288C81F42D
	for <e@80x24.org>; Wed,  9 May 2018 06:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755846AbeEIGpB (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 02:45:01 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:46540 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753230AbeEIGpA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 02:45:00 -0400
Received: by mail-wr0-f180.google.com with SMTP id a12-v6so3679755wrn.13
        for <git@vger.kernel.org>; Tue, 08 May 2018 23:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+BuYZXonuh7LE2nvpGf46F2UUXz+XVxCDlRPuAYO1S8=;
        b=GYVADG99T3U19d8xvD1fWit+UWk3KliVwD3w2kFIcMB0UrHVkOTc5/joFDpRc+mk01
         mpBnUQ/HR+vmKhqcfwBL79dfpO7AcqHhBFTEVzuQeJRYkbWkBD8Gisc71isasPNRo/os
         +QSwhUPMSBjF791ahj76IwnKengQ4IUGmsFnbVm9sNTEgaqokyYHwj3VJZ8N9HThGP/x
         ThRSn/dLOOpMfHx7ade94yaj1kKaPV9V8GuHPPSW0wj6NH732H93gsyAc39Vo+kUVw2U
         LahU+G4ZpUGTuESi7hkFPJT+JKn5uOb2q9gpAo5Yo0BihBoPdhMDU0vMEGc6LpIwHc9c
         Li4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+BuYZXonuh7LE2nvpGf46F2UUXz+XVxCDlRPuAYO1S8=;
        b=LEDi0mbwzsgBMpntPqOEebGyoxkblkIs0/KKanu37yYqPOTiMPCij6pUzyMZAtDgHF
         /axzBG7QjIzrYc88FYE61uz0fukR6GxtBIsPGq3IGMWhL07XnIauRgdu9EGAXG9JSui/
         jOnJUs0vCvcheE/a9Plo/o5jCZ8JV00VlB604L2LV4zGTQkQo7Ipq/AhzJjGZQ9N2ay0
         WULnH2tdOz7QrcAmBdk3xhN2DmJikOZTSXR5qC65hSGAZF4gwG+y0iQgBIXsqp+UAAnn
         /6xVYVMTS3NyXO8Z4TucvvlYek6SsLRgubY7kuW17FmSICGm7QPLXF+rpj/daNVm/8DI
         1oJA==
X-Gm-Message-State: ALQs6tBuSU2MDVL/wjDtzLiD25lQJJm1Y/LwwjN1TRsu0gosfpqAFB+Y
        vqqoCmBny0QACgF66pJctHA=
X-Google-Smtp-Source: AB8JxZreLS2Aux0nIyxC3S2olfcadMx0QNWAEM/Xy1rLALLFbePIoUq6awTQn0m3ooSQCFDboVSdzQ==
X-Received: by 2002:adf:e24f:: with SMTP id n15-v6mr36024046wri.224.1525848298592;
        Tue, 08 May 2018 23:44:58 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m64sm17993743wmb.12.2018.05.08.23.44.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 May 2018 23:44:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Leslie Wang <qiwa@pensando.io>
Cc:     git@vger.kernel.org
Subject: Re: regarding fix on "git clone $there $here"
References: <2F384E33-2101-4D90-986B-FAE2FC2AD7C5@pensando.io>
Date:   Wed, 09 May 2018 15:44:57 +0900
In-Reply-To: <2F384E33-2101-4D90-986B-FAE2FC2AD7C5@pensando.io> (Leslie Wang's
        message of "Tue, 8 May 2018 22:25:58 -0700")
Message-ID: <xmqqin7xl446.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Leslie Wang <qiwa@pensando.io> writes:

> At 2.14.1 or 2.15.1, if I run command like 
>  - mkdir /tmp/111
>  - git clone git@github.com:111/111 /tmp/111
>
> because it will failure, then /tmp/111 will be removed automatically.

Yes, this was a (longstanding) bug that nobody bothered to fix for a
long time.  As "git clone" did not create /tmp/111 but it was given
to it by the external world, it shouldn't remove it upon failure.
Of course, if you omit the "mkdir" in the above sequence and let
"git clone" create /tmp/111, tne Git will remove it upon failure as
part of the clean-up.

