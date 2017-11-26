Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B63AD20954
	for <e@80x24.org>; Sun, 26 Nov 2017 05:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751628AbdKZF71 (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 00:59:27 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35496 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbdKZF70 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 00:59:26 -0500
Received: by mail-wm0-f53.google.com with SMTP id w73so210501wmw.0
        for <git@vger.kernel.org>; Sat, 25 Nov 2017 21:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=75kgPVleyXXg9BJczTFu/EVLc0pS59fTgyi0ptJb9ng=;
        b=SWnrkOlREdLeyhNKkdyLuA1ORt4t1InnWnWorHGiUdrz16IEhV4bHd5v5Hz4mWqnVD
         vZgYQQI/b+x2IZIqAZFnRAWE+tb515GKj25XOHNyxeieFeXVW2HJ7dMFbDZYqfx1WUdD
         koGXomHhTAEefuZza6fA3uMjMNgYrK/ZYPyXgb+MoHmld0JOYIpdXJwnpew9RKGH7iGJ
         cXv5IOz5iGXEdH27Ob9BsjqaFuwkREQi6WQr6qm6gX/+S8pyW69yj7WH9F2WeiNQbU2N
         pjzNwYUo9gai5Z37FJ6p9cJo2lawq9IDePfwV3zPJq61JPv76mYhlvFctS9LE6A5BpH3
         QO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=75kgPVleyXXg9BJczTFu/EVLc0pS59fTgyi0ptJb9ng=;
        b=f/5S5bT3c38QyDooE9z0rfjY+CDF431CDyPxZ08KbJ7NcxS2mQFjpNPvL14fJ7bmFP
         OEyxbPB0zzFQGosuYjJnEgbytn6VZt1GoFTSZ3tVBTTNKrkwhj1oT8Y+zF45vUTsusrb
         JEFds35iaYr+Y4Wb9sDJ1hWPFdLP1BgnFk9UYLhH1inGO0jA9ErW3P09+6LuB4Snnj5b
         iapRb4prE6zpXYripF3JdE3NOj1oZbUO2BL6j1U5NL6DB/ShuVh6M7RKUOv9CdNV0ibL
         7y3FzykcsR6glSOirdxGDDpU6DxbT+SHg3kq8HnuyvMgeXWZ19W6YnQOp1/N219JBv9P
         05nA==
X-Gm-Message-State: AJaThX4G+zMbA/D+8gP9QiKyFW7yBDKmPZn8uXAwDbgeMfV7IcHIStGX
        NR62w/nMsJ1nzeL56kNX3jIQ7CdiaZicFwfWoZU=
X-Google-Smtp-Source: AGs4zMZcSRctIXs97++cN/I6scnwWyuvDBZe3xrMWLb6Vcel6ELA5V9DsQsgm4GUdm6v9b/hYNwm3gvreh5Z7PhkPWA=
X-Received: by 10.80.149.152 with SMTP id w24mr29811479eda.76.1511675965401;
 Sat, 25 Nov 2017 21:59:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Sat, 25 Nov 2017 21:59:04 -0800 (PST)
In-Reply-To: <CABPp-BFdJr8AL3hJSSLiqwPJMt6LZcLOEcTtxz1vohEuw==wKg@mail.gmail.com>
References: <CABPp-BHDrw_dAESic3xK7kC3jMgKeNQuPQF69OpbVYhRkbhJsw@mail.gmail.com>
 <CAGZ79kbRY1gY8L361o568391Efoa1epZ1dFQZcTqJiOE7EAJfw@mail.gmail.com>
 <CA+P7+xorpJGrn=5zTrAPVDwHLkU5vCphOrebkH_d+MxV1k1oRg@mail.gmail.com> <CABPp-BFdJr8AL3hJSSLiqwPJMt6LZcLOEcTtxz1vohEuw==wKg@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sat, 25 Nov 2017 21:59:04 -0800
Message-ID: <CA+P7+xonU838dOAzsUY4KmweYyM-NLFQeKVYD9jYM7i5EuWXcw@mail.gmail.com>
Subject: Re: submodules and merging (Was: Re: [PATCH 02/30] merge-recursive:
 Fix logic ordering issue)
To:     Elijah Newren <newren@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 25, 2017 at 2:37 PM, Elijah Newren <newren@gmail.com> wrote:
> On Wed, Nov 15, 2017 at 9:13 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Tue, Nov 14, 2017 at 10:13 AM, Stefan Beller <sbeller@google.com> wrote:
>
>>> But this line of though might be distracting from your original point,
>>> which was that we have so much to keep in mind when doing tree
>>> operations (flags, D/F conflicts, now submodules too). I wonder how
>>> a sensible refactoring would look like to detangle all these aspects,
>>> but still keeping Git fast and not overengineered.
>>
>> I think given how complex a lot of these code paths are, that an
>> attempt to refactor it a bit to detangle some of the mess would be
>> well worth the time. I'd suspect it might make handling the more
>> complex task of actually resolving conflicts to be easier, so the
>> effort to clean up the code here should be worth it.
>
> I think changing from a 4-way merge to a 3-way merge would make things
> much better, as Junio outlined here:
>
> https://public-inbox.org/git/xmqqd147kpdm.fsf@gitster.mtv.corp.google.com/
>
> I don't know of any way to detangle the other aspects, yet.

I agree, that is absolutely a (big) step in the right direction.

Thanks,
Jake
