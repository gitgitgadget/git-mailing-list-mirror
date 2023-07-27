Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E340BEB64DD
	for <git@archiver.kernel.org>; Thu, 27 Jul 2023 19:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjG0Tfb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jul 2023 15:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjG0Tf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2023 15:35:29 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BAC2D68
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 12:35:28 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-583a89cccf6so13570137b3.1
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 12:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690486527; x=1691091327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6SFQ2B3HUU6bhrpWhbWp8U4G4C99+RPsmCDEULqXHu4=;
        b=76CxiezWBAWUk8diXI3kmddco96Vg8hiPtcUsu4eoX+73O2DTPzSxshgvHOG9NDCgc
         uIzB9d43x45iZff3WygjcvwAXBaRATOkNyr+xf77qCsGqsDlfttP9SNFW1foy/kb9JCj
         vLon2aSVl9j8iTpNvYYqH5WhP1ngRZmNe7309G9axYOILeXO+VDW7IxzmyJn6VQyZj+v
         bc3iZK0xGDGtjBXY2ey7HB6OS3zA0Nt946s5UsW1WAy0NcKpSqie1f2xF8vqGLRPJ2Rh
         t5PMeuyfckAcEnIRLb8hcrIWxybjvktpFObRdCmvqF1aXaZ+CXpQe/LZxiE9g+l/SPQ6
         pIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690486527; x=1691091327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6SFQ2B3HUU6bhrpWhbWp8U4G4C99+RPsmCDEULqXHu4=;
        b=lgucm7x2Igjact+MtMpZR1+WbxdVzPneQAJtMq7XCbrpaH/b4iJ+EJme4CYgxs0qWi
         s4Igsj4pijaW115Szph4yVpyW+I4hAdJjk40pmc4cHc3Auf2Yw04ifsZanPSsBwOVaHC
         c89DMQAnabAsUqYYuXhoO65e1xk2zqIXP1qOLk4BTnknPQoJeRjz117lkcHE2RChjo4H
         ncBYUF6WW8kBskqQQYTYqo7ZmPG4UXtlkTHz8wKXWdoJqqBSrsDjoNDWhaRYCg5E0QH4
         uIZ0Ntb1AwF59HRUbRyvmjCZjkoMsjZISUHIQ6MzRAGqTAeXLm+y21+N/rHFp57le47p
         5fPw==
X-Gm-Message-State: ABy/qLZXmW5KvmH1eVzyCsz/mtmPcPadNTL38vVGsOIfEmzGFi4mL0J8
        m4CgDY3Y0PsqLxDVjZmNU0HAtz1mwZ0=
X-Google-Smtp-Source: APBJJlHf+WGm+QcvF/6Lr4iteTOOSQTM/sY9ClzYyBMZ8LGFTCGsXODRUfRaqBdGP5wpi5n9tetrbwaDUWU=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a25:2596:0:b0:d16:1f54:75e1 with SMTP id
 l144-20020a252596000000b00d161f5475e1mr2860ybl.0.1690486527746; Thu, 27 Jul
 2023 12:35:27 -0700 (PDT)
Date:   Thu, 27 Jul 2023 12:35:26 -0700
In-Reply-To: <xmqq351bfdtj.fsf_-_@gitster.g>
Mime-Version: 1.0
References: <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
 <pull.1556.v3.git.1690340701.gitgitgadget@gmail.com> <xmqq351bfdtj.fsf_-_@gitster.g>
Message-ID: <owlyila5f8qp.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 8/5] SubmittingPatches: use of older maintenance tracks is
 an exception
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Thank you for breaking out these patches (in the future I will try to do
it on my end to save you the trouble). I just have small wording nits
(see below), but otherwise LGTM.

Thanks again.

Junio C Hamano <gitster@pobox.com> writes:

> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 559c02c90c..0d1b53d4e5 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -46,15 +46,22 @@ latest HEAD commit of `maint` or `master` based on the following cases:
>  * If you are fixing bugs in the released version, use `maint` as the
>    starting point (which may mean you have to fix things without using
>    new API features on the cutting edge that recently appeared in
> -  `master` but were not available in the released version). If the bug
> -  exists in an older version (e.g., commit `X` introduced the bug, and
> -  `git describe --containx X` says `v2.30.0-rc2-gXXXXXX` has it), then
> -  use the tip of the maintenance branch for the 2.30.x versions in the
> -  `maint-2.30` branch in https://github.com/gitster/git[the maintainer's
> -  repo].
> +  `master` but were not available in the released version).
>  
>  * Otherwise (such as if you are adding new features) use `master`.
>  
> +
> +NOTE: In an exceptional case, a bug that was introduced in an old

I think "In exceptional cases" reads more naturally.

> +version may have to be fixed for users of releases that are much older
> +than the recent releases.  `git describe --contains X` may describe
> +`X` as `v2.30.0-rc2-gXXXXXX` for the commit `X` that introduced the
> +bug, and the bug may be so high-impact that we may need to issue a new
> +maintenance release for Git 2.30.x series, when "Git 2.41.0" is the
> +current release.  In such a case, you may want to use the tip of the
> +maintenance branch for the 2.30.x series, which may be available as

s/as/in the

> +`maint-2.30` branch in https://github.com/gitster/git[the maintainer's
> +"broken out" repo].
> +
>  This also means that `next` or `seen` are inappropriate starting points
>  for your work, if you want your work to have a realistic chance of
>  graduating to `master`.  They are simply not designed to be used as a
> -- 
> 2.41.0-450-ga80be15292
