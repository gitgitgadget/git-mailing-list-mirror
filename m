Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E54C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 08:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240409AbiCJIhs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 03:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237382AbiCJIhr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 03:37:47 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC223136ED1
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 00:36:46 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 85so3830411qkm.9
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 00:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=4Ri7NI0VWjGyrnBuevErAuT1pPpeBrmRze07B12kBek=;
        b=BJ+xdzW66pq+wcQiV9EvLJm1EAgiyOm2HpWX7yBfEvZzgc9UHpS/lrbsQtjDMOfNGt
         8hlzn9ThMpjweQAfbOfaQCjZLE9fMxfbQYvEsMOSj7wsWJnwLsH0EQrYQazfPNsSH4ku
         FuM2hXqKfU9URA2rRjP+UAQ6tlurJhCM4xZtrdbFU5HkfN0xArSzVwp0XZdsHLuj0SSa
         Dj9B+/VsA7BHXM6QXkYr1Ez8ffU5zSW9/6nWLAD2TQLgIx1LMaw29zEna++5ZL+XIot9
         GJhnDs6ezEwUn0/wCpiCDZMMme3qKhmLzi+hLw+xFmzxe9jEF7cYAp8d6Zm6QdEqvoUU
         iz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=4Ri7NI0VWjGyrnBuevErAuT1pPpeBrmRze07B12kBek=;
        b=C9SKwj5wrRJ6LvfrY68e4SbQXpEx34177sjS54vf4XAk5RqqCHNsKexdJi/0u4LBHy
         RjVFmEAuIq1zqaCw+a9OKz6ABHt4fCh3WJdxjSPWOsZpdR7RgxuIIjInoORzA+LbMvrK
         /npkOkEJpqVjbMQ85XgUJgHQniSOiB2uNOJHwMXAgVdS8V1OuvM33jBjyTH/2JMmuchu
         Kdef2ihvrIt32WJzJx9pp8LIqeG179s/h2qpDsdBExXt0NR82lS3EyTQPLw/NLM5Lb2x
         fAhPrAh4paFFpKQkJHrd6p7SkwbmwMzSHmwMPURYaavU7k+3oYb8crtpMEuXipfe9Sy3
         nWcA==
X-Gm-Message-State: AOAM532OD+o8C29VrXDLqzyaZ++Le8wamaN67Nv8h5b3/yk1SPK4+/8d
        nWOpj0aC/mbKSJ3JX32Pj9O2+vSajkAsew==
X-Google-Smtp-Source: ABdhPJxzRl6Cu974Ky9gihUNpvwhwzKCsCFPjbg+BuPTw96BBwHym9aNHsfEwjR7ZMecInJ31Npv9A==
X-Received: by 2002:a05:620a:b52:b0:67d:45ab:2079 with SMTP id x18-20020a05620a0b5200b0067d45ab2079mr2243019qkg.780.1646901405987;
        Thu, 10 Mar 2022 00:36:45 -0800 (PST)
Received: from ?IPv6:2003:f6:ef00:8400:3d36:58a:667a:1da9? (p200300f6ef0084003d36058a667a1da9.dip0.t-ipconnect.de. [2003:f6:ef00:8400:3d36:58a:667a:1da9])
        by smtp.gmail.com with ESMTPSA id p12-20020a05622a048c00b002de8f67b60dsm2786142qtx.58.2022.03.10.00.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 00:36:45 -0800 (PST)
Message-ID: <f5be5b264f30f689546db3883b4b64c88ba00cb3.camel@gmail.com>
Subject: Re: git notes question
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Erik Cervin Edin <erik@cervined.in>, git@vger.kernel.org
Date:   Thu, 10 Mar 2022 09:37:18 +0100
In-Reply-To: <xmqqee3bm2b8.fsf@gitster.g>
References: <ea67407120aa710f81af048d22be09281ac28107.camel@gmail.com>
         <CA+JQ7M-dkV_AGJ8+4C6HcCN1sQgBtyfYbgUbnQQmYz9So3WwQQ@mail.gmail.com>
         <d204419925e7a4486d9a66a8a0f807a77be6d1b7.camel@gmail.com>
         <xmqqee3bm2b8.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2022-03-09 at 10:02 -0800, Junio C Hamano wrote:
> Nuno Sá <noname.nuno@gmail.com> writes:
> 
> > AFAICT, git-format-patch looks to be using --pretty=email and I
> > think
> > we can use --pretty in git-format-patch but having to mimic the
> > email
> > format "by hand" is just painful and I was hoping a better way
> > could
> > exist.
> 
> Well, this time it was "Notes:" label, but the next person who
> wants to see a deviation from the canned "email" format would want a
> deviation different from yours.  Perhaps they want a different way

I'm surely missing something but I'm not sure this is specific to the
email format? It's just that git-notes by default will always either
append the "Notes:" or "Notes (<refname>):" independent of the
predefined format you use. The only way to stop it from doing that is,
apparently, by using your own --format=<template>...

What I was asking was just if there was a way to not use these default
strings. I don't think this would open all kind of deviations... Either
you use these default strings or don't. But I think these strings are
probably used/important for git log? So we can know what is commit
message and what are notes...

> to format the author name?  Perhaps they want a different way to
> separate the title (to be on the "Subject:" line) out of the commit
> message?  Perhaps they want to see the log message be indented?
> Perhaps they want to see the message from the notes be line-wrapped?
> Perhaps they want to see the message from the notes not to be
> indented?  Perhaps they want to see the "Notes (amlog):" label to
> format the name of the notes tree differently?
> 
> Where would that end?  We have to draw the line somewhere.
> 
> The customizability via --format=<template> is given for these
> people who want to futz with that line.  One thing that may be a
> good little project to help them is to make sure that the vanilla
> "--pretty=email" can be reimplemented as "--format=<template>" (I
> doubt it is), design a way to fill the gaps (if there are) to get
> there.  Once that is done, write down the "--format=<template>" that
> is equivalent to "--pretty=email" somewhere in the doc, to give
> those who want to derive from the canned format some reasonable
> starting point.

Well, this would be surely nice. For now, I will just remove it by hand
or script something to do it before calling git-send-email.

Thanks for the feedback!
- Nuno Sá

