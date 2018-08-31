Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81D471F404
	for <e@80x24.org>; Fri, 31 Aug 2018 17:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbeHaVIm (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 17:08:42 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35375 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbeHaVIm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 17:08:42 -0400
Received: by mail-ua1-f68.google.com with SMTP id m26-v6so8690081uap.2
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 10:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1/yBz/O3u/ypx+k8SKFL1jp8fIF3jUIyfFiSTRmU7W0=;
        b=TjKB5k+vAw3RpbhsUVBqvqv9CViKFg+J6FDPw4mJN25bSU5aimnlzyrI4p/v6gfmhg
         JATvIdPTJ2B9QW+bI+UVvI2/vaMhmgxsySKcHPxVPM6641vYI4Epj3mZWVSoaRWiZzap
         0pkBTpYEzfQ2JI+VXVn4R6Lk1PFoUKF/i2WDBK+bBnYGLhVsxWulU51nclxiQ8OC2eC9
         2BjkeD4KVBwORzYPc6NBPaheLFLnPLCD1Tx8al5phMgN83WHdlbJJlLDBFA38SElWQdP
         vimlGjakfJllnaCVqG0PaC+aH1k6IkPbK6HIjdZpR3gTY0wkbC9pwceNia8DI0r94MgC
         DBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1/yBz/O3u/ypx+k8SKFL1jp8fIF3jUIyfFiSTRmU7W0=;
        b=FBhdeOGkLqS9UVh98A7LEIu6fAPLRDUwOI0DvgPWjbq9fbAM5nuWmWqHXc/uuxyHY8
         cSgVeT7AhlT/micHhQwS/T/MmUj6Jr5g3b+ufYHklWcnLjo3hWJ4SB9E7VuZ+y1TcBPg
         AcMRCKkVW8UJDcRYtHI3q48kbMNrjzIHqswVNqYKrYPcCisTc3xfWT+gx9KrQD/LrPgs
         1ahy7/YVlezcF9W5ODIyZz8jhgDaIgkc81EHIx1PZyRGfmy4xh/SKu33CprZa8fsQIdf
         IzVrCCUjMEz19MxtwReRNRo/AquR7ZIlXcVCMryoOMkZ3WbWHq6t/luntzmUp2ry0yFZ
         4O3g==
X-Gm-Message-State: APzg51DVeZOv13Cr0j8oqPAAjroPvfSivR3iwTtswkuUTfYode1b54Wo
        Wmt/dtKj1H0ZBssY+t27rWY/NjTD
X-Google-Smtp-Source: ANB0VdZbSFJted+rJn2YpuJqv3ULeUv+AUUY+slUt/NfnBfhXiI8j8+p/HT8uxzvoEQLriP3y2dbFg==
X-Received: by 2002:ab0:59ae:: with SMTP id g43-v6mr10414911uad.182.1535734816735;
        Fri, 31 Aug 2018 10:00:16 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id d203-v6sm1958174vke.39.2018.08.31.10.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 10:00:16 -0700 (PDT)
Date:   Fri, 31 Aug 2018 10:00:13 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] config.mak.uname: resolve FreeBSD iconv-related
 compilation warning
Message-ID: <20180831170013.GA41433@aiede.svl.corp.google.com>
References: <20180805075736.GF44140@aiede.svl.corp.google.com>
 <20180831083342.34836-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831083342.34836-1-sunshine@sunshineco.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine wrote:

> From: Jonathan Nieder <jrnieder@gmail.com>
>
> OLD_ICONV has long been needed by FreeBSD so config.mak.uname defines
> it unconditionally. However, recent versions do not need it, and its
> presence results in compilation warnings. Resolve this issue by defining
> OLD_ICONV only for older FreeBSD versions.
>
> Specifically, revision r281550[1], which is part of FreeBSD 11, removed
> the need for OLD_ICONV, and r282275[2] back-ported that change to 10.2.
> Versions prior to 10.2 do need it.
>
> [1] https://github.com/freebsd/freebsd/commit/b0813ee288f64f677a2cebf7815754b027a8215b
> [2] https://github.com/freebsd/freebsd/commit/b709ec868adb5170d09bc5a66b18d0e0d5987ab6
>
> [es: commit message; tweak version check to distinguish 10.x versions]
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  config.mak.uname | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

I think it makes sense for you to take credit for this one.  You
noticed the original problem, tested on FreeBSD, wrote the
explanation, and figured out the firstword hackery.  All I did was to
say "somebody should fix this" and run "git log -S" a few times.  In
any event,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
