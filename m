Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F201D1F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 21:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbeK0IxM (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 03:53:12 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:41257 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeK0IxM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 03:53:12 -0500
Received: by mail-ed1-f46.google.com with SMTP id z28so17231178edi.8
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 13:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1OCH7o33M+8ySyd2NsTyKQknx6NqjrwcadYl4ON9Daw=;
        b=ciRN4DzkseX8BAx34zj0s8ZoOeug/y2K/U4zHzl2semQSqPU7WkHWz/okl2t1TB1i8
         3iwBKJek60tWJ+m8an0I1LqWHGgCMy/UqCnVLsOdvnGIRcZE1tFGKbjJmFnpARq9QGxj
         16AxdquV0ezkjMygk9If2WTY8N/5Xtb6NKfdU3UGvVEXwvOGbWi27N1ORRzDN/oFU0ER
         +jgTNxVLiW4GgGOKRQ+MK4vW6nhsPZhzCHdggD8P7Bhd9CES8MKcaxHlsIsVP4RYW+Qk
         /OTp11lm/FJHY2poFC9WGIB+5KyRmrkqb45noGgXfov9gkD2gUhAGQMOqkSM6Ln3uDCL
         2MgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1OCH7o33M+8ySyd2NsTyKQknx6NqjrwcadYl4ON9Daw=;
        b=riCYv11xN775QvD7BsaxR6vOgAcxriMTWGLjxf1dCt7RIbEsa2XVqmP48HvPYN3XrV
         vS1wyfOLDU+hD60CfXLH9Wpau3OC81cnz9gdhc5geOC0TxzCkidjd+5o3FJfr00KzaQl
         gZUIeK2sL6n8xa9a6Pwawk50/E+313LfYZe7LTNtABh+UujIx736OANlKqftNpsO0wsF
         5J9hvVt4NiprLdPM51MoVc7FibhdXbTxz1/Q3DvCBuehlXj7gwDJv32qNXytp21P6ueX
         p1O438qiUXWD/GyNi09npE+fO4CyQNqSutp7S6+Z/Hefc3TTDu76CSKXd6lHISj7lZz6
         3+CQ==
X-Gm-Message-State: AA+aEWYZsdcqU2ypDK/TcMZy7sDr6hjR8vyBW+USdJoTEBURDDtdI8UH
        JNAFxun1Yyf5BEzbH3JwYUM28RATGggrzJxEVRIp0g==
X-Google-Smtp-Source: AFSGD/X+wlBJQYVIPKC1gtGJ/NChaMoC/QuTfM+LOiviFEBKnQOA/1GYOdMLo5EPn7KRVdkeE4b6/L0sioncjtv846M=
X-Received: by 2002:a50:8fe4:: with SMTP id y91mr9058195edy.231.1543269458708;
 Mon, 26 Nov 2018 13:57:38 -0800 (PST)
MIME-Version: 1.0
References: <xmqqlg5m7qlb.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlg5m7qlb.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Nov 2018 13:57:27 -0800
Message-ID: <CAGZ79kZ5UaUUjMPV-ev7CdQ0yEa9AM3LGGC7tjUK0mFcuyBvbw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2018, #06; Wed, 21)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> * sb/submodule-recursive-fetch-gets-the-tip (2018-10-31) 11 commits
> [...]
>
>  "git fetch --recurse-submodules" may not fetch the necessary commit
>  that is bound to the superproject, which is getting corrected.
>
>  Is the discussion on this topic over?  What was the outcome?

Please don't merge down the topic in the current state.

I have a local updated version sitting on my disk and plan to send
it once I made sure it addressed all comments of various revisions.
