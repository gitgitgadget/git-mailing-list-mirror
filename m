Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 200B41F404
	for <e@80x24.org>; Tue, 30 Jan 2018 23:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752781AbeA3XYe (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 18:24:34 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:53712 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752479AbeA3XYd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 18:24:33 -0500
Received: by mail-wm0-f42.google.com with SMTP id t74so4509117wme.3
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 15:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GYyiJFwlAL4AxUrhTkGKZPTNOsHuRUqA5tnfIZJv620=;
        b=WUN/AgqkfwDvwQaaF52IZ1GqYC8dVhdwgq+fVLxDjGg6JBqgO7H8pv9T6j98jEOTC/
         Lblu/7jqwcsG8n68k1WCT8Z1rf5aoXQLsCT2hXAuHfzBy7LJVzGRqG1uzpUxWaQlKTPI
         Xb6puH/G3OS5JOkJZgSpU8UmcpsdPOlSo/q+SqaSDuGgq/iEfy/+dJkBdZ7l4aYovFns
         QGs2NmRmGSDdAHsf1sI9Tv5m2+GlUYJyX04465dgn1rGm1SX4coQjgUaKNsAxlFgSkjy
         P32tA0btBAaUXzbEAwCWrBWBE2sjRZg0qx0tDvPsxvV9oGJjOzODPDtZLl2qc0MCxS5K
         xkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GYyiJFwlAL4AxUrhTkGKZPTNOsHuRUqA5tnfIZJv620=;
        b=G6iwewowzpybQ8+RQsVRHLYLiV+ypnRYXoD+YI35xGebFiRII+R6UH+yHA3UjEJWyV
         m/tTY8ZfAqyO1246ylD1B1OZo8mhingKnaxQXCXV6UO/jhO7B1lN5hKgBQ72Kt8ZW708
         DBp8H5ffnkS+FJKOwKk1+3yfoqaKvvFiTyb530d14wd5p/1L5gv+/GHtV/cUUQ2+gGGz
         98YyL1EhbLelAXBJFrJkC6Ygsfx6yHQqyhibDeuURiAtOHPIssWTGUx9TAA3oMw9Zc/N
         mn1Wry+0fpStQ0r5i3Akc9H7eJkch7/F9wcrK+N+qkhO2NdARvN2RTmccXPwESEV2IYr
         EfRg==
X-Gm-Message-State: AKwxytc5olaa5ptsdrdT0raEsFkLl7c5y9InfHluxFgF61pneQOyl67O
        a1G2i+rY3cB+WktIZxAm7d0=
X-Google-Smtp-Source: AH8x225jHM3KK63jYJtfSZpyRAe4puITfTiRoz6G4cdaTRUc6+HMRF7ci58o5Jk4q+2fTydI3qQygw==
X-Received: by 10.28.128.82 with SMTP id b79mr21402650wmd.113.1517354671727;
        Tue, 30 Jan 2018 15:24:31 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e16sm15843621wre.5.2018.01.30.15.24.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jan 2018 15:24:31 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Stephen R Guglielmo <srguglielmo@gmail.com>,
        Avery Pennarun <apenwarr@gmail.com>, git <git@vger.kernel.org>
Subject: Re: Bug Report: Subtrees and GPG Signed Commits
References: <CADfK3RWXDuE=hYD==4sHXO1iJeOiVDOp7hBqhBtSn7gnQ+x7Qg@mail.gmail.com>
        <CADfK3RU4WJLV9EtieWYQzzRBoJkpyE+w178WQk+wj6soFwKW7g@mail.gmail.com>
        <CADfK3RVJdk3zK7+eE45-PSkb=_v86wrC0TzY+hUmAkfO0Dea=w@mail.gmail.com>
        <CAGZ79kafgyOujDM4BsXdDUnP+iFk5mp2bYnX-Q65khW-weEhUg@mail.gmail.com>
Date:   Tue, 30 Jan 2018 15:24:30 -0800
In-Reply-To: <CAGZ79kafgyOujDM4BsXdDUnP+iFk5mp2bYnX-Q65khW-weEhUg@mail.gmail.com>
        (Stefan Beller's message of "Tue, 30 Jan 2018 15:17:31 -0800")
Message-ID: <xmqqy3kfq6a9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> There has not been feedback for a while on this thread.
> I think that is because subtrees are not in anyone's hot
> interest area currently.
>
> This is definitely the right place to submit&discuss bugs.
> Looking through "git log --format="%ae %s" -S subtree",
> it seems as if Avery (apenwarr@gmail.com) was mostly
> interested in developing subtrees, though I think he has
> moved on. Originally it was invented by Junio, who is
> the active maintainer of the project in 68faf68938
> (A new merge stragety 'subtree'., 2007-02-15)

Thanks for trying to help, but I have *NOTHING* to do with the "git
subtree" subcommand (and I personally have no interest in it).  What
I did was a subtree merge strategy (i.e. "git merge -s subtree"),
which is totally a different thing.

David Greene offered to take it over in 2015, and then we saw some
activity by David Aguilar in 2016, but otherwise the subcommand from
contrib/ has pretty much been dormant these days.

