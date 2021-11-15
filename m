Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AE9C433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 03:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DBD461A6F
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 03:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbhKODUI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Nov 2021 22:20:08 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:39749 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbhKODTL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Nov 2021 22:19:11 -0500
Received: by mail-ed1-f48.google.com with SMTP id r12so65373218edt.6
        for <git@vger.kernel.org>; Sun, 14 Nov 2021 19:16:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BGD3HJM8nOebBE4yjw7+90RMX3H4rYSIoJLvpJmkdqU=;
        b=lmDsJ5rhhaTpb7X+4cbpBB7jBUjqC9ZAtsxdDTVXXGPflGgRYmE2ZFiGFwWAoA3aOS
         T99gpQaSS/2iFB78/H0Zzw54sSQ1qzNyEiMwHlapWaxGncnvm5LyuesGvQCaGHNZfjVC
         c27YZsovA513UOqvqBoyn236RnPWKbpuoMadHMAA9YJkNlafMqdvgJXQj7WP/cfL+txK
         3W7KtUsHbRAAVyfxcghHx8+gOjPJXTSzr3oigFOUngv8xk4ah2DFf8xqCuhgm00LOuES
         FBjBIJ9EzsCU+rWZqGE8c+XdRwzLQHDV6FEGKHlDbbIigA75SVNmIRDaQMCxD12HqJF8
         wsXg==
X-Gm-Message-State: AOAM530tckyzcIdJ8tCebcX0AgeGYyospBCsv3y/q4fWDnv915AeDmzI
        XyUf6ysdqR3Ojnqf1s3BBflmj+Xf8uX7LMSX/ayxCqzPJ5w=
X-Google-Smtp-Source: ABdhPJxyFZURL48Pyg02h5futYT+EUs/W3lCuCOitbMxklKercwegv5bkwurx1XVkQWipX1zW8G99uvhKn33YACpWqQ=
X-Received: by 2002:a17:906:1451:: with SMTP id q17mr44555708ejc.36.1636946173485;
 Sun, 14 Nov 2021 19:16:13 -0800 (PST)
MIME-Version: 1.0
References: <20211114212437.1466695-1-sandals@crustytoothpaste.net> <20211114212437.1466695-2-sandals@crustytoothpaste.net>
In-Reply-To: <20211114212437.1466695-2-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 14 Nov 2021 22:16:02 -0500
Message-ID: <CAPig+cTAfOor11SDWG0N-eeZZ=4hsmkMVAdcmiiJ+jXz3BAQVQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] git-compat-util: add a test balloon for C99 support
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 14, 2021 at 4:27 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> +#if __STDC_VERSION__ - 0 < 199901L
> +/*
> + * Git is in a testing period for mandatory C99 support in the compiler.  If
> + * your compiler is reasonably recent, you can try to enable C99 support (or,
> + * for MSVC, C11 support).  If you encounter a problem and can't enable C99
> + * support with your compiler and don't have access to one with this support,
> + * such as GCC or Clang, you can remove this #if directive, but please report
> + * the details of your system to git@vger.kernel.org.
> + */
> +#error "Required C99 support is in a test phase.  Please see git-compat-util.h for more details."

You don't need to encapsulate the #error message in double quotes.
