Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E4651F404
	for <e@80x24.org>; Tue, 11 Sep 2018 19:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeILAuF (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 20:50:05 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55528 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeILAuE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 20:50:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so2254196wmc.5
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 12:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=u8QrlBgv7CAEmikWsURRmFGx2NicicvoPHNOLYgY4a0=;
        b=eTgnOwfWkHxd820OH7lswg9ijRab7l5jCiKBA4IWkYOVBv3gwfJyH6O4lsJ1Mt8h+5
         UgPnIgaN+0Cvt8lfHr0gjkEB25D91RohLA7KOX4xTaRnvoe067cvI27iCxuBeglm+lha
         FipOemgTMtXVG/jF/v+tip3GSWn/d1hN6L52DkpaLPMXmelwgl/q+sVSHpCtF64IyLgI
         zesfyITdgcutmJ1Lik/4tlqMksTbJDDbVDYjoMBb+mlACVtMwdPf+wddhF2rKnUoEvaQ
         LsEEoE8Bac2gzhg5G6uv51lRfsg+4pbTtJH1+vcWcIbHZydQsB2JvU4iqOaSG6Wy68gC
         P9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=u8QrlBgv7CAEmikWsURRmFGx2NicicvoPHNOLYgY4a0=;
        b=P6V+FHnBw4WkUiCSzVoMLo3Swog/Bj9OqszBC4HQW1IxzL4q/WCbDh2KDxocKO35w3
         V2CDgZ/kwbJiAdBewoq7OxUkmbN0JO1QqxvDYOumX3Sf5T3CiGBM4OkWEXA5obKHiuYp
         WT3fwR8WJCxRi9+sYCjE5ShqrWWSr8Q/vFZ5bGy2O3MJ6US4LFeKenIVE4bqf9hh6VcM
         XVzdwcpqXmUTQg+SMbNJc13u1L6jEtzjH/uDOL1E6+Hr/4Op6k45Op9IrR3KhFoblvgz
         he6u0RTKU1GgFcstqXVmPQfTX6IarWIArxG0Qv6BgfEc/6onHB8iUkhnsSU0rRTy5wV0
         Sxbg==
X-Gm-Message-State: APzg51DSFiVVuNf7herB/Syf49t0j51oAuqEdODgt4bx1CTd+krDGhbZ
        h5O8VxOOn77e0WRHwvPVwU8=
X-Google-Smtp-Source: ANB0VdYMD47lHZKDeR7Lkpyn0sRCzIOlpdv94PLg3CMCZ3YBneO5WE+NL5PsKNbOM862+SI/IbOxZg==
X-Received: by 2002:a1c:7711:: with SMTP id t17-v6mr2428770wmi.35.1536695354040;
        Tue, 11 Sep 2018 12:49:14 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h73-v6sm3824738wma.11.2018.09.11.12.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 12:49:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, allan.jensen@qt.io,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] Revert "Merge branch 'sb/submodule-core-worktree'" (was Re: Old submodules broken in 2.19rc1 and 2.19rc2)
References: <2659750.rG6xLiZASK@twilight>
        <CAGZ79kaVQ0T=acpviOoD+8XVxYsefNkO7c5d+d0Wc0iCbr2Evw@mail.gmail.com>
        <20180907223515.GD103699@aiede.svl.corp.google.com>
        <CAGZ79kZvuGEPOSTUqT+y6nxs6W5qaP-BbHT_WQQE7+n=RVNsrw@mail.gmail.com>
        <20180908000946.GA225427@aiede.svl.corp.google.com>
        <xmqqmussvj72.fsf@gitster-ct.c.googlers.com>
        <deeaa4d5-3982-b47a-d2da-501d52fa38e1@kdbg.org>
Date:   Tue, 11 Sep 2018 12:49:12 -0700
In-Reply-To: <deeaa4d5-3982-b47a-d2da-501d52fa38e1@kdbg.org> (Johannes Sixt's
        message of "Sat, 8 Sep 2018 20:39:43 +0200")
Message-ID: <xmqqsh2folvr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>>> Like this (generated using "git revert -m1)?
>> 
>> OK.  Thanks for taking care of it.
>
> Please don't forget to remove the corresponding release notes entry.

Thanks for a reminder.  Very much appreciated.
