Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFDCC04A6A
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 05:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjHDF2o convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 4 Aug 2023 01:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjHDF1o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2023 01:27:44 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CEF123
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 22:27:42 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-63cfe6e0c32so10797226d6.1
        for <git@vger.kernel.org>; Thu, 03 Aug 2023 22:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691126861; x=1691731661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=np4j2l8pbH+2i6u8hU88HdWTTtLuMKDFbBqv/pYLvWo=;
        b=JM8k2CilXvhvaLknU8hSZLuBT5eGQtP+6KldR5B4JfjIo6WVh8VviBsMmdFCFisJ3O
         n3FfrYv+QHVm6ZNVbIYeZBi2qGTFQNiWQoWMO21VM/7bqpMrUa3WGX+9Qp5aIWx21j45
         zcxiizCxcbXGKMXonmxcIyoPlIHAGbr0oY14gmhmz6w/4KDdQXIbCjoSeW11HxC/b+0N
         U4bZI47y7oE+9mXSMoctvHektwqgZxyW73FtMDcs8Mca92fbPFeOB9jY4sxDkB55OSrF
         AgfijU5B41dKZq26GXHmzuPAaVjQsb4eD5GOdI2NrhMdOoRSoab4/VkfJ4UKwegjTyz1
         RrJg==
X-Gm-Message-State: AOJu0Yw1enxLT6Q4Ap3wC9NNGXR0OdCAOWzQtFeBcMtRa+rZLVP5Tp9N
        O7hvHBiwBnShKnpTOnEJn6alJseFfgjSjWzRNt4=
X-Google-Smtp-Source: AGHT+IG0NzJwCWivYn3T46MjeIZgpnbwznlUl57ainRBjWK/ytDuxIv6c79KAZQRgPd2KYd+77DvS7ZR3XZO/lEEXfw=
X-Received: by 2002:a0c:cb10:0:b0:63d:218:c83f with SMTP id
 o16-20020a0ccb10000000b0063d0218c83fmr623835qvk.36.1691126861392; Thu, 03 Aug
 2023 22:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1560.git.1691058498.gitgitgadget@gmail.com>
 <pull.1560.v2.git.1691122124.gitgitgadget@gmail.com> <042271990895c4cfdedb20c3aed3d4141df610bd.1691122124.git.gitgitgadget@gmail.com>
In-Reply-To: <042271990895c4cfdedb20c3aed3d4141df610bd.1691122124.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 4 Aug 2023 01:27:30 -0400
Message-ID: <CAPig+cTE__6B3RNbew8sHQQC3ELi9YAArYX5ofXRpMPBzZfmrw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] docs: update when `git bisect visualize` uses `gitk`
To:     =?UTF-8?Q?Matthias_A=C3=9Fhauer_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Louis Strous <Louis.Strous@intellimagic.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 4, 2023 at 1:22 AM Matthias Aßhauer via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> This check has involved more environment variables than just `DISPLAY` since
> 508e84a790 (bisect view: check for MinGW32 and MacOSX in addition to X11,
> 2008-02-14), so let's update the documentation accordingly.
>
> Signed-off-by: Matthias Aßhauer <mha1993@live.de>
> ---
> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
> @@ -204,9 +204,14 @@ as an alternative to `visualize`):
> -If the `DISPLAY` environment variable is not set, 'git log' is used
> -instead.  You can also give command-line options such as `-p` and
> -`--stat`.
> +Git detects a graphical environment through various environment variables:
> +`DISPLAY`, which is set in X Window System environments on Unix systems.
> +`SESSIONNAME`, which is set under Cygwin in interactive desktop sessions.
> +`MSYSTEM`, which is set under Msys2 and Git for Windows.
> +`SECURITYSESSIONID`, which is set on macOS in interactive desktop sessions.

Micronit: SECURITYSESSIONID is not universal on macOS[1]; some people
report its presence in iTerm2 and HyperTerm, and perhaps even Apple's
own Terminal (although it's not defined for me in Terminal on High
Sierra). Perhaps just say "may be set on macOS".

Probably not worth a reroll.

[1]: https://github.com/vercel/hyper/issues/482
