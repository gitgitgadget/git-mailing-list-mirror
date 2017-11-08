Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E67AF1F43C
	for <e@80x24.org>; Wed,  8 Nov 2017 16:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752717AbdKHQuh (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 11:50:37 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:50377 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752256AbdKHQug (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 11:50:36 -0500
Received: by mail-wm0-f45.google.com with SMTP id s66so11671954wmf.5
        for <git@vger.kernel.org>; Wed, 08 Nov 2017 08:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oKhgoulMkQAgibAaTldP2XVZwxJBDy9HoNKJPmdzNWc=;
        b=O3jIANvWyPqL5WgImwDuaADVkjOJSg++7YmniYL3Zu21zFuWvf576vW6gxFa/l1zQx
         6/mG6FD9HuMk1Iw7Ga9oMeVHCNmnZDFQpZWE03DGnob/TrcX46XiaakT7HNhTNc98C89
         WW/4e9xxI/i1Oj/hnYWR1bVhxwfqtxi5WkyWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oKhgoulMkQAgibAaTldP2XVZwxJBDy9HoNKJPmdzNWc=;
        b=H4ylU7sYbzYufPhPpPXHod/DGozX2P0qsCSmfHa3vkHaG8O4kAYkhpyTw6jIadhHZy
         u3iHbdS57m82exbqCpRsHyBxm5cQ15qBeeDdfXsCZuhnprmcTJfWCoaWwSzsGobck4lB
         pclL/BK08FPb/6o+JgoLzwIwwob7bsa7aNMt15ntUmq7s6+/BSxIxOPkiFyOLzciY/Ta
         Trw5XWB1crxWyl4dhd0+cESzEkdFrOFsWrzgXsJdL7azHM/vh68Ek5y4IXtgveMfFyfo
         eua+SaXCz3BlnXjtIMpmw9Ow4NdfokNwizbYulOf1pcGj7JcbYAN84n7Iz3M44eHgiQx
         oQcQ==
X-Gm-Message-State: AJaThX6JmXlVU2FPxjvu+OGguNss542ZhGClMdqiaJrU5tsKfJhrlbAS
        eV/cVaD0prqOhkxszT+CzNb7fg==
X-Google-Smtp-Source: ABhQp+REOfZt5RCUbMENnQY3AkWNu5nXqS1g4e5QkOzy7eIR27HzYAyuZ7HCS/rZOeMCK+HVRtUd2Q==
X-Received: by 10.28.37.195 with SMTP id l186mr990503wml.144.1510159835583;
        Wed, 08 Nov 2017 08:50:35 -0800 (PST)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id v8sm2150749wrg.80.2017.11.08.08.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Nov 2017 08:50:34 -0800 (PST)
Date:   Wed, 8 Nov 2017 16:50:33 +0000
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [RFC PATCH] rebisect: add script for easier bisect log editing
Message-ID: <20171108165033.GF20681@dinwoodie.org>
References: <20171108135931.166880-1-adam@dinwoodie.org>
 <CAP8UFD015i76L4BgSZdr2k2TZk+C0vRAqOsj4DaqtNYuJjtNxQ@mail.gmail.com>
 <CAP8UFD35yFTB5_D6=WyXN47Lgo3PvLJi3yWfzTAK5aYjE9YjNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD35yFTB5_D6=WyXN47Lgo3PvLJi3yWfzTAK5aYjE9YjNg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 08 November 2017 at 05:15 pm +0100, Christian Couder wrote:
> >> +git bisect replay "$GIT_BISECT_LOG_TMP"
> >> +rm -f "$GIT_BISECT_LOG_TMP"
> 
> While at it, is there a reason for the -f option above?

I was following the lead of git-bisect.sh, which has used `rm -f` for
such things ever since it was first introduced[^1], although it appears
that, since v2.15.0, all the `rm`s in that script have been moved to the
C code[^2].

Actually applying thought, rather than just following existing
precedent, I suspect having `-f` is useful because it means the command
will work even if the shell has picked up that `rm` should otherwise
have a `-i` argument from somewhere.

[^1]: 8cc6a0831 ("[PATCH] Making it easier to find which change introduced a bug", 2005-07-30)
[^2]: fb71a3299 ("bisect--helper: `bisect_clean_state` shell function in C", 2017-09-29)
