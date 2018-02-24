Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5992F1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 15:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751414AbeBXPBZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 10:01:25 -0500
Received: from mail-oi0-f54.google.com ([209.85.218.54]:38431 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbeBXPBY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 10:01:24 -0500
Received: by mail-oi0-f54.google.com with SMTP id 123so5359634oig.5
        for <git@vger.kernel.org>; Sat, 24 Feb 2018 07:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=k0Xic4OvR9l/bR2k/2a7W4oCWQ9LPYWOSwNwSzibHks=;
        b=PgPc4T9RBB/LyQ39ZmOp9jT9LWAntkaF69hn0TD81NWXf+L+ZMW3zI+y9JpLmLBuzi
         80T288Cy5Bbker397qRBAYaptKJpL7PjdNDnta1Y8Vouo+kuhThx4wpgecuU7H0CFqYO
         PqdaYATLdSDUm7PqI6r/3uK43eQtE9MmmXQwPnKs0gKGqFjfxT4yvaTRa8M6XoptN74c
         GgyHZAVcLurjdlw4qdHEZPDgQaOALc3fSpSEbohrh6OKfxq+c9wgjJudeeWAjWKX1MgX
         d1vzfa7sYSBvGqDw2iS0cKAlsiAwvOAS1Av0Opwc+6wzVi8lWSLt1XnPXk8n5MhFgydz
         FfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=k0Xic4OvR9l/bR2k/2a7W4oCWQ9LPYWOSwNwSzibHks=;
        b=q3XDkxA/lRiEqLePpuBs71a9EPXkgVPrrj9RadUsAe7+HpU4v71ftaCcVr5XsTfB+4
         gFaOC684YWMNY9Vtf7Cj9SCz9Kgo22rlll2IdWi/0Km20SyaUtN12jcqoxdtI+xjeI9B
         Fx019ISFHz5hIclxJJQIXPa3iH4FntHIMHhVs1b/OllpV9UnGrsDyZ6ENtvytFn45SgQ
         ySHWZOHmkrt5go9uT3gUYch6NizryCK3lVeuo2OD4tPX1F0rMdKV8XnzhkbEI6KC5t/x
         F/64nZsew82J4CCfWx2bQ/xi/w7PKDdLSYAoziGxN5BO6Da6X4LZsNrOv/tAxJHIWLC2
         W/tA==
X-Gm-Message-State: APf1xPAQU+jFuoYEvh3MnsBjm7LZKQRjZQ01v8ajiC625vde+9DSqWFM
        6Hpqlcs7kaaFFe0vuwffkmBANpmO05DZzUEwu+M=
X-Google-Smtp-Source: AG47ELsTqKliJfFMmv+1YKjpJ536yllOtJbO8v0LTPOvVdERV8fUcul8So4law3kq8Oy21shGsnxq5ywYQmPq3DXVbg=
X-Received: by 10.202.187.4 with SMTP id l4mr694561oif.56.1519484483777; Sat,
 24 Feb 2018 07:01:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Sat, 24 Feb 2018 07:00:53 -0800 (PST)
In-Reply-To: <20180224004754.129721-1-sbeller@google.com>
References: <20180221015430.96054-1-sbeller@google.com> <20180224004754.129721-1-sbeller@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 24 Feb 2018 22:00:53 +0700
Message-ID: <CACsJy8AS5RiuXeM2u34i0hjKXJqEhsrb4Ysi9Md9OhRpP4_B-A@mail.gmail.com>
Subject: Re: [PATCHv4 00/27] Moving global state into the repository object
 (part 1)
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I notice that there are a few global state (or configuration rather)
left after this: packed_git_window_size, packed_git_limit and
delta_base_cache_limit. These can be changed by $GIT_DIR/config, but
since it's still global, a submodule repository will use the same
settings of its super repository. If $SUBMODULE/config changes any of
these, they are ignored.

The natural thing to do is move these to raw_object_store too (and
repo_submodule_init needs to check submodule's config file). But one
may argue these should be per-process instead of per-repo though. I
don't know. But I thought I should mention this.
-- 
Duy
