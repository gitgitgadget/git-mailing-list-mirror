Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42E351F406
	for <e@80x24.org>; Fri, 11 May 2018 01:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeEKB2y (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 21:28:54 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:53021 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbeEKB2x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 21:28:53 -0400
Received: by mail-wm0-f45.google.com with SMTP id w194-v6so296686wmf.2
        for <git@vger.kernel.org>; Thu, 10 May 2018 18:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Joqs3epV4EJdGIQzKMSBKFMEzM8IoxhlKoDTYvU0Q+A=;
        b=OFUhxmdCB1jm9puM/Z8aNKwWiPD++gop+sKS9reK9IWJZNmkx5W5Q+7sDLIoOYD3dj
         RGL55++bCCMpgTCqS3Ou95HLdsZz/rReBJbVfnJBcf//JrbOdn7q43xKsrLtb1jiaxPS
         H9RE5Kg9VUbnRo0FJyzVcOAv9ycXXTN/FLTTT1dZQt+6LCEBj2Gc0d8y1So5DXx15Mvk
         OWaJLPgY83NLi8788K+jK9YLjqo5sFU0zwnWVXDtqXJJYYpwcxw6d+UhH17sOj/SqWk/
         bLGRLCFtBP3NqgrFQ3RefuwzcT2zuLkgBFHM4ZIVeN+AKP6xrMGYhNSnfwmo3KbcLcC9
         xhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Joqs3epV4EJdGIQzKMSBKFMEzM8IoxhlKoDTYvU0Q+A=;
        b=PejXdXYqXgDOgpsgaZ0hwkN8jd7yQEXvlpn8uAaY2OwVyPA7/ZbL3cYfWKM6HlaKrA
         J867JMygwIot+8cowhcVc+eGJi6DLqldkWE03Dez6xhfjrvSbj9mfObOQlD3IU0cef0c
         W1v5r7THNtCFx9Rab+Qv9PhgPGR+/c3b5DHvKNCW25FR0vs7df6qNrgIZs9TFdNfFHBz
         X/ZPxaRrWNekaUU0hKGCCg+gJZv0p1yXmUEReZreGFgTEkYTP6UdAnHytjUySdi32wr/
         AVfGOA3mPkAP2vHnf31srPuMdeCUj6Scy9cHpdjntdQcGuJr1C58j+YqJ53lviLZ7PQk
         yk6g==
X-Gm-Message-State: ALKqPwf+8GzTpOh0yCDYw/fQ07uWp15WIIDIK2Ssc25sY29fYXOG6IY4
        xr43RpO8GTZIiBzNBvLHvrpnC2r4
X-Google-Smtp-Source: AB8JxZotJ2Xu5jVy1lhpZjos1iUWNU64iTWwESpYs1VPwFlTvXDWE4yCM09psLSmy0zrOfzj1D/qLQ==
X-Received: by 2002:a1c:18c5:: with SMTP id 188-v6mr578697wmy.148.1526002131532;
        Thu, 10 May 2018 18:28:51 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t203-v6sm363816wmt.33.2018.05.10.18.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 18:28:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/1] Fix UX issue with commit-graph.lock
References: <20180509141523.89896-1-dstolee@microsoft.com>
        <xmqqfu30j8q7.fsf@gitster-ct.c.googlers.com>
        <3b8005c4-a43d-bd46-c7d9-d6490d500114@gmail.com>
Date:   Fri, 11 May 2018 10:28:50 +0900
In-Reply-To: <3b8005c4-a43d-bd46-c7d9-d6490d500114@gmail.com> (Derrick
        Stolee's message of "Thu, 10 May 2018 08:52:55 -0400")
Message-ID: <xmqqk1sbhtf1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> Also, can't we tell why we failed to acquire the lock at step #1?
>> Do we only get a NULL that says "I am not telling you why, but we
>> failed to lock"?
>
> To tell why we failed to acquire the lock, we could inspect
> "errno". However, this requires whitebox knowledge of both the
> lockfile API and the tempfile API to know that the last system call to
> set errno was an open() or adjust_shared_perm().

That depends on your viewpoint.  We can make it a part of documented
API so that we keep the promise of preserving errno in the error
codepath when we update these APIs and then you do not have to worry
about errno being whitebox knowledge ;-).

