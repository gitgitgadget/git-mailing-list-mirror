Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 744301F42D
	for <e@80x24.org>; Thu, 10 May 2018 07:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756727AbeEJHAh (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 03:00:37 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:51771 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756613AbeEJHAf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 03:00:35 -0400
Received: by mail-wm0-f45.google.com with SMTP id j4-v6so2219411wme.1
        for <git@vger.kernel.org>; Thu, 10 May 2018 00:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NGQWsNsR/btOBVarVwlZCmcuuZfq4XVzo3KfT5K0QWA=;
        b=EIJZFLXny2Dp/0eIqZAE6n37WQJvqthQ4dIMkek1A1jalZr4cHI814kmCRgNEtR3+P
         sEIxzFur5KgaY+htd8WpirYe1BuWU2uRm80fQNlF+pFP3z+yGay6F4Fe4zL0pGOv994Z
         TyT1AuD4k3iVymrp0P7jCy5ev8vMO+KcCtVR0SJv9rpaQABg+QTYOHguTtjggMqSS7Dy
         IPUw88ftxv19Zu0LCFYATQMH0xOhsxc4WcrOM7H3Sbx5ISHs5FcLNhYnqifwCMfUb68L
         RU2RR1S4YNy5rcJeqsU82Nz02XjNo26eYYl0cTQGbMp6ihTH4cZJXx04oQepZaH6Tp+W
         uscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NGQWsNsR/btOBVarVwlZCmcuuZfq4XVzo3KfT5K0QWA=;
        b=UWp1P19ebAJnkA91uhn+hw+TmPlhyP2XV2c1Vfs/NPZ2Yd+lEbJDmxwzUviCxZ/e2x
         XI4RVFAg3jjq2rDIz3j+dc6O+9YyK3OhROCDfo4vjH4wZdxB2Y9jKWcvYmD/uR0mzXtj
         8rJIDNKQkHs1tVYB2e1tvnvHDjPsl4yqYR6LxrkL1/iPpLzXQSntHIINODMqPZkfYotL
         Fbmztw69cv0DGIt0yPEujRwJ3/16ZqpKmcyZUQAeS9FFHjZ8m+w5n2KZ59caBj6myWly
         Wr8YY6uz93o1BpTWqTAzXtRnlPCOZEiZCRYWE5jqf3DAPc3RSUBMORyml9KqxNf4awzH
         A6Ow==
X-Gm-Message-State: ALKqPwf24KkdceBewGV29j6YJXt10YmH8YOjEXkMY6GlMncOMdVIsysS
        Q0S/XoDFU6mNdvXwENHWa1A=
X-Google-Smtp-Source: AB8JxZoM++av1LkGQRCLP5AUTHVz42WIi7ef/a8LbbmN96KcdFA4Wl+Z/he6dzW/IV47e6z73HzJ3A==
X-Received: by 2002:a1c:6d97:: with SMTP id b23-v6mr395712wmi.86.1525935633936;
        Thu, 10 May 2018 00:00:33 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p10-v6sm171598wre.77.2018.05.10.00.00.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 00:00:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "stolee\@gmail.com" <stolee@gmail.com>
Subject: Re: [PATCH 0/1] Fix UX issue with commit-graph.lock
References: <20180509141523.89896-1-dstolee@microsoft.com>
Date:   Thu, 10 May 2018 16:00:32 +0900
In-Reply-To: <20180509141523.89896-1-dstolee@microsoft.com> (Derrick Stolee's
        message of "Wed, 9 May 2018 14:15:37 +0000")
Message-ID: <xmqqfu30j8q7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> We use the lockfile API to avoid multiple Git processes from writing to
> the commit-graph file in the .git/objects/info directory. In some cases,
> this directory may not exist, so we check for its existence.
>
> The existing code does the following when acquiring the lock:
>
> 1. Try to acquire the lock.
> 2. If it fails, try to create the .git/object/info directory.
> 3. Try to acquire the lock, failing if necessary.
>
> The problem is that if the lockfile exists, then the mkdir fails, giving
> an error that doesn't help the user:
>
>   "fatal: cannot mkdir .git/objects/info: File exists"

Isn't a better immediate fix to make the second step pay attention
to errno?  If mkdir() failed due to EEXIST, then we know we tried to
aquire the lock already, so we can die with an appropriate message.

That way, we can keep the "optimize for the normal case" that the
approach to assume object/info/ directory is already there, instead
of always checking its existence which is almost always true
beforehand.

Also, can't we tell why we failed to acquire the lock at step #1?
Do we only get a NULL that says "I am not telling you why, but we
failed to lock"?  What I am getting at is that the ideal sequence
would be more like:

    1. Try to acquire the lock.
    2-a. if #1 succeeds, we are happy. ignore the rest and return
         the lock.
    2-b. if #1 failed because object/info/ did not exist,
         mkdir() it, and die if we cannot, saying "cannot mkdir".
	 if mkdir() succeeds, jump t 3.
    2-c. if #1 failed but that is not due to missing object/info/,
	 die saying "cannot lock".
    3. Try to acquire the lock.
    4-a. if #3 succeeds, we are happy.ignore the rest and return
         the lock.
    4-b. die saying "cannot lock".

