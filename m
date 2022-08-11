Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD1DC25B06
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 23:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbiHKXWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 19:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiHKXWP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 19:22:15 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A52CA1A47
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 16:22:14 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 12so18397684pga.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 16:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=S6Y7nLhizObPM675cNi2/ZDA4mTKlKtRcQyj+jbtHcc=;
        b=NAy/z5+Aq899MV7fjsTqUBrPlu4U1e23DIeRrcGq/Vg1XB8Prp9ThO7lGXB03jIEQU
         73DLj8k7lucTqUwAeD5SG//gtwuh8tbApbaJb1k7iD2z709T4Zg6tdvXziTA8hQAUD2A
         /ePY+VW6Ltkv7ue/ekcr04FPllI5x4iHgrVV9flXv0iaY2gfhN6Qve7zQkW4t3S01uwy
         n/RGIa++Drfyd95U30PkpRj9T0kYd1Ean2CHpeKsDBF6z2dafqopNfOZ3X3ZvjZoI0jj
         R8o58iK3HR+B6dHEU0Y0AY3QLIp2+UQXZxOqjlrz7/BwfBqAyMmGmC9F9B+Ml638BO89
         N0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=S6Y7nLhizObPM675cNi2/ZDA4mTKlKtRcQyj+jbtHcc=;
        b=pYQZPf72sSuWZKoy3cZ0XtAKfJUj8s0KGSk+P20dMDhotR+nwB3I/paOdGc/Rh9yJz
         7NqE9DVR+lBOpKwv6AQKPVQvT43ecQpdTHBuan8BSWO62RIN2HB+Axjzo4t7FBOqFwDs
         KBeCfsS5qhY+j+jw5/RV+MAstQnRs2MZyH0BzPN/4Q9hprUAC7byvqx3zP8Z2pBYiO/X
         JYp5CXg5sABrs2F52HJXPdhxE0LvEVIGCCJcYVQAkFymqar6pr81xwP/bapKn2QEvNRs
         q0R4/Ffnahf3+KFqZ51IKdw66A6tLjdRMINT0L9M0QnE3GSGMzIcHZYguWlrbTHuir0O
         oslA==
X-Gm-Message-State: ACgBeo2AB9Ca4C3Tcoczeb444g4sVox9WCtxBQ3ctG0MAs3+++YavUbt
        iuO6kdoYQOi6KKrKYgpth6Gc
X-Google-Smtp-Source: AA6agR4046Nd9Znc6UuqJ0J4GQ4hGq5SeV8FWEOCsvbxKwlFwjQtW/aQRH4xAIBaaHmg49AXXZHTHQ==
X-Received: by 2002:a63:ba49:0:b0:41c:2713:3984 with SMTP id l9-20020a63ba49000000b0041c27133984mr992978pgu.468.1660260133719;
        Thu, 11 Aug 2022 16:22:13 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id s188-20020a625ec5000000b0052dc9d8574dsm234914pfb.128.2022.08.11.16.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 16:22:13 -0700 (PDT)
Message-ID: <0e859fe2-3f23-4526-083c-082adb0028fc@github.com>
Date:   Thu, 11 Aug 2022 16:22:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [ANNOUNCE] Git for Windows 2.37.2
Content-Language: en-US
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
References: <20220811214252.4351-1-johannes.schindelin@gmx.de>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20220811214252.4351-1-johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:
> Dear Git users,
> 
> I hereby announce that Git for Windows 2.37.2 is available from:
> 
>     https://gitforwindows.org/
Just a heads-up: there was an issue with the process used to generate this
version. Consequently, a large chunk of Git for Windows-specific changes
(bugfixes, interoperability changes, etc.) is missing from this release. 

A fixed release in in progress (see [1] for the latest updates, if you're
interested). In the meantime, please *do not* use this version.

Thanks,
- Victoria

[1] https://github.com/git-for-windows/git/pull/3981

> 
> Changes since Git for Windows v2.37.1 (July 12th 2022)
> 
> (Upcoming) breaking changes
> 
> We updated the included Bash to version 5.1 (previously 4.4). Please
> check your shell scripts for potential compatibility issues.
> 
> Also, as previously announced, Git for Windows dropped support for
> Windows Vista.
> 
> Around the beginning of 2023, Git for Windows will drop support for
> Windows 7 and for Windows 8, following Cygwin's and MSYS2's lead (Git
> for Windows relies on MSYS2 for components such as Bash and Perl).
> 
> New Features
> 
>   * Comes with Git v2.37.2.
>   * Comes with tig v2.5.6.
>   * Comes with Bash v5.1 patchlevel 016 .
>   * Comes with Perl v5.36.0.
>   * Git's executables are now marked Terminal Server-aware, meaning:
>     Git will be slightly faster when being run using Remote Desktop
>     Services.
>   * git svn is now based on subversion v1.14.2.
>   * Comes with GNU TLS v3.7.7.
> 
> Bug Fixes
> 
>   * Git for Windows now ships without the zmore and bzmore utilities
>     (which were broken and included only inadvertently).
>   * A regression in the vimdiff mode of git mergetool has been fixed.
>   * With certain network drives, it was reported that some attributes
>     associated with caching confused Git for Windows. This was fixed.
> 
> Git-2.37.2-64-bit.exe | 9020623e95e8f250a6298aa98d4bce395adc121998a65bef143556c3fbd2462c
> Git-2.37.2-32-bit.exe | 3f1110d855a934194b8de1e032d8edcb622804a0b4223cccb9379f7d37a52915
> PortableGit-2.37.2-64-bit.7z.exe | 71294d3008d6da6bd25527498ff726d09d55c2cbd1af32d8e99200d5339d7817
> PortableGit-2.37.2-32-bit.7z.exe | 005253af6f96fc86a2ccec97dfd68c56f5b91f72c5cd953e5d1d240c35235390
> MinGit-2.37.2-64-bit.zip | 197422464897cfc8f6ebd73007c798658d21310a4c32d43888c9e8f92720ffec
> MinGit-2.37.2-32-bit.zip | 77b39507cc4b06cad754137e08465c14532b3fc4b0bc4cfc3c91dfeaa6badbe8
> MinGit-2.37.2-busybox-64-bit.zip | bfe43199e74d3d80ed7490b7f0aa09a92f907ecbe9ad80719a9bdf6a8ec4ae70
> MinGit-2.37.2-busybox-32-bit.zip | a752814318a5cc0c00902d5fafffb97c7201ac2e837e0718eaeaddd3fdf3bb07
> Git-2.37.2-64-bit.tar.bz2 | 0508cba06cc52b0e4e733cdd6ee19ad17cc67d31b69c34212f120c94f1806a98
> Git-2.37.2-32-bit.tar.bz2 | f2612e4ff5d63d922673b1c6437b8c292ecdcfd950a2f0bdf4704d6eedc42def
> 
> Ciao,
> Johannes

