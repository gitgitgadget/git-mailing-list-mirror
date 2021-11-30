Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F67C433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 20:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343820AbhK3Uzr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 15:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242493AbhK3Uzp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 15:55:45 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F38C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 12:52:25 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z5so27015700edd.3
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 12:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=pBmlh6GPD7ZVOYlG3YX9O2QBzBBiCTkjhnNqKn2U/18=;
        b=m/CBgpuShooQ9nWApuLin0VEmEum2Ksff6BAbwWmTjqVNHWJ10ZSrdNSpkO88F3pJP
         dsc7VcaYArM7PPgkzQTGFDPL44L+c0lvSXjLImY+STnvyWqnZZDEFIoTd+Ps64nPNRNZ
         fQzHiangK+kzHqkfVHUAmaVhwdPLKj3hWyDAUVdVnjYQFSTGQmAFbEwlnfGVd5A91VkR
         MW8J/8pkgAOrAaKClsHT/Cg6VFMKQeQpI8qQ/VbMGkBFzCgSVKhVcnAhTVEKV3Kj2Vyb
         fSv+0ToqJ1Wg73GsevzqVuEe69Xcl3c/jkWpQlQT5FPbmSG47YisMJ8xB9nji0sorSmF
         PMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=pBmlh6GPD7ZVOYlG3YX9O2QBzBBiCTkjhnNqKn2U/18=;
        b=FNi9mWtoyqEzQfj8WQqJNvZMQOu1VpK+ry9HgMIMnfjeUw2vIpYj0g+osuDywcWbop
         0WCOxE0KsuNxkaxAbsgpGACw3MVcZOMkW2G71keRP4OnFK6Bszgu22R34+y2oSmt4WI8
         W187VOv46nkIGtpLg5dcOaR3pMvpV9KMXZlHb0FKlCRq7oifbZgYM13bKn0dSEmsXfJm
         dz864KVvtqLlXjZ8pon7MH7WW65aqOnoUFaxgzbhoeQJ7L3iGFeHbNxE47MET1ZQ1j1G
         5sknqNZoTBOeEluFhvjlBu/NMqydH40vnPbCZZwsbUgFRce47TurPOf2RIJ+U/xmmbj8
         ZjlQ==
X-Gm-Message-State: AOAM531znL+P3whm18yuuvnz0mNThd6HB0t7lSDpV633CnSXin6VMTsi
        UH8NTrdB39Xz7N4spjg0J8R0bST/HC4=
X-Google-Smtp-Source: ABdhPJwmZGdTmvkCB8BrF4+ylfgP5thHOZVN5HcxJHbZ06C4VSpWa6MrSCz//hbEBL1sT4PRMZezCA==
X-Received: by 2002:a17:907:7d8b:: with SMTP id oz11mr1697596ejc.507.1638305542887;
        Tue, 30 Nov 2021 12:52:22 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id sb19sm10283596ejc.120.2021.11.30.12.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 12:52:22 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1msA6v-0019Ya-VW;
        Tue, 30 Nov 2021 21:52:21 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Microsoft's C language policy (was: [PATCH 0/1] Add a test balloon
 for C99)
Date:   Tue, 30 Nov 2021 21:43:15 +0100
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211114212437.1466695-1-sandals@crustytoothpaste.net>
Message-ID: <211130.86o861cqnu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 14 2021, brian m. carlson wrote:

[Replying to this tidbit in the v1 CL, which isn't in the V2 one]

> Unfortunately, Microsoft for many years refused[1] to support C99 in
> MSVC, and still does not officially do so.  However, they recently added
> support for C11 and C17, which are sufficient for modern programming.
> These require a newer version of MSVC, including an updated SDK.  The
> SDK update is available for download free of charge, and most public CI
> systems have support for both the updated MSVC and the SDK update.
>
> Even for users who would like to target an older version of Windows,
> such as the no longer supported Windows 7, GCC and Clang are available.
> The LLVM suite, including Clang, is available pre-compiled for download
> free of charge.  Using a different compiler is specifically proposed by
> Microsoft staff[1] as a solution for users who wish to build modern
> programs for MSVC versions which do not support modern C.
>
> As such, we can assume that Git can be safely compiled with C99 or C11
> support on all operating systems which receive security support, and
> even some which do not.  Our CI confirms that this series passes all
> tests.  Let's introduce a test balloon which checks for this support and
> fails with an error message if it is absent.
>
> [0] The reader will note that there are people working professionally in
> this industry who were not yet born at the time C99 was ratified.  Thus,
> this occurred quite a long time ago indeed.
> [1] https://herbsutter.com/2012/05/03/reader-qa-what-about-vc-and-c99/

I hadn't seen that blog post before I'd read it when going over your
series. I'd assumed that Microsoft was just dragging their feed on C
language support, but that post indicates (from what seems to be as
official of a source as anyone's going to get) that they're intending to
not support C at all, but just some pseudo-C that happens to be a
convenient subset of C++.

However that post is from 2012, and you indicate that they've since
added (full?) support for C11 and C17.

So is this "policy" of supporting some arbitrary subset of C++ at all
current as far as MSVC today goes?

Aside: I just remembered we had a (seemingly abandoned) effort to get git's sources to
compile with a C++ compiler[1], which would be another possible way
forward to using more modern C features that happened to overlap with
C++. Another one would be some sort of coccinelle-powered refactoring or
other source pre-processing...

1. https://lore.kernel.org/git/20180129223728.30569-1-bmwill@google.com/
