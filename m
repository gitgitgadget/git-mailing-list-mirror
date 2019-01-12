Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF12E211B4
	for <e@80x24.org>; Sat, 12 Jan 2019 18:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfALSv4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Jan 2019 13:51:56 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44507 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfALSv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Jan 2019 13:51:56 -0500
Received: by mail-ed1-f65.google.com with SMTP id y56so15633456edd.11
        for <git@vger.kernel.org>; Sat, 12 Jan 2019 10:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3xO3YJz80yjb+b3goimcn7t6eazb8BM7iPKkTZmzBoE=;
        b=OF4zPSIyD3rm1OELJRYL3J9aw44M4NUeqxCEGeBLF6wEdnhVcZ6cdBiogq58LsK06m
         S3jfOBNCGoFG6GZveo2697VDHOd3MI+7eS6oV+D1TVVK5/z85g5H+/mQ9kMYidLCqRSi
         omPNmxtCxgmCzyg4vUaPCVR2Sk3rNIxrqAUTHLXCmDYJ3n53+WRdhpjyg9wH7OKdB0hV
         8J2D7opLWiarrfh2kXKbuJS3rJ2eh62IYBo9Fcl/vrKBcNj0lHn/UpvkeKzzIaQbtr/R
         yPF8oQYtkjD36ezA5jMs1JmuJBSAgk1+hBImRhGtiaT08OXxy2hDsYzGi1GYgVakjKWx
         idGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3xO3YJz80yjb+b3goimcn7t6eazb8BM7iPKkTZmzBoE=;
        b=R3w/2wpYVWZuY+ML7EZnm9IVfeIMa1RuAteM9ytl2fiZl5ZDOhOiuma4Yfa6Hbqhhb
         QxWoNfDGS0k7BFwfXmSvLG7WHlPslssZ32Ly3TSoeUYBA/QMds4aN49kyXzoHml2SC9S
         4+geos1f7j8ikjzZ6WrjFJU5Fe69LpZ51lVljn3RrSzsQwy8tUBAN3dZ/c6f+/Yi4eaE
         uoHsH9K92B4l1cs7cwGLLl3t4JbksU5Bsl/jpuN3d6Uu7tCZEwzrNknTgs8u1nm6kz9Q
         8W8fYOiDwt0K76y7WXNJgEs54PVujptJfNMWh0TyAk4S1NVRtNuXDHx1esWrfqf5pLNI
         +Vvg==
X-Gm-Message-State: AJcUukcPzKYYEm90ecSlYnVgtMPx855Jo8osBa8NzXldrz/Sm2RtpnxE
        qk2kV+0ve4oAPSwTutXDC0EFNTVe4Fu2zdzeL6OsUeSrs6o=
X-Google-Smtp-Source: ALg8bN4QhbfDqyTNxUiGAEqDqAeSMgM6t4rQwtkAwfH8Ut94mDojSLDtpc5OcOuDnOuWVG8J4affvLQm6f3b/15mpRA=
X-Received: by 2002:a50:ade7:: with SMTP id b36mr16807741edd.215.1547319113440;
 Sat, 12 Jan 2019 10:51:53 -0800 (PST)
MIME-Version: 1.0
References: <20190111221414.GA31335@sigill.intra.peff.net> <87va2u3yeu.fsf@evledraar.gmail.com>
In-Reply-To: <87va2u3yeu.fsf@evledraar.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Sat, 12 Jan 2019 10:51:42 -0800
Message-ID: <CAGZ79kZrcC=SBrBR_4JDWu4Odgz-Uf7LrusiKNe6tgs02JeAMA@mail.gmail.com>
Subject: Re: [PATCH 0/6] getenv() timing fixes
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I wonder, and not as "you should do this" feedback on this series, just

There is a getenv_safe() in environment.c, but I guess a xgetenv() that
takes the same parameters as getenv() is better for ease of use.
