Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580DBC433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 14:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237847AbiCaOyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 10:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbiCaOyG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 10:54:06 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943B021FF52
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 07:52:16 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bu29so42076310lfb.0
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 07:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=koordinates.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pbDQVIAcFXUfOhJ/3KddFhHELZ+U38HCSSQe71YhJ9s=;
        b=BQCXcvmuG5hzi50fs0LUaXAa8ysWgSREm0MtPqeofKD8G9RdfnNPVuaoYpbLF8WmIQ
         ydel0EpaRDrXWCYKs23vp71yGcclAnCtJxJkmvLFinAdhe0Wk8tfzTItIvyvH7ig6JR4
         2HImPCKbUawOE2egWr4nAzfkATecn1ZOHv+LjfWBaLrTUr1lfuioesjiIN0ylY9fqE8b
         NIB4J2u/+pxNp3eoIpJBFaeHru5Z3LX5gtWgL8yrUUVqgthImIgjqRW5oEQx2tLYRhCz
         AFYo9AQscz37w5ZojzwRWHgPIFybNjlzXJg0raDb3zm8vnSedsqDM2bqQ4ML40UxegLX
         Zp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pbDQVIAcFXUfOhJ/3KddFhHELZ+U38HCSSQe71YhJ9s=;
        b=D+DapjwDLsoulsu5dA8R7lsy3jrf02X8OCp1NrgAdRBJyUFFvmQNcJQqojBDxefl+Z
         Bj+X1+FU6KWTnN10h2Wvz+0uYLHZdzWmgdtZY6OPaT8/I+obfPlFJDYhxviXhDf8/IbN
         YGTKfBbllZfbMAqcoMal81RGWMYUadOmG/DEDkbsVRc+45FBenMWPWrA58gSB7YnSOxc
         k5ibrPvZj382gSfVOHm8ylLs7Pap75MMozUk2ryNbHqG8HtMtL+8ZuXnpNxnl8sNtlM7
         ENlEGfvu1k56q0ezgttJ1bVkfpZcG5IKfFjYRBEGlew7UaFd9ggaao22nSROo6+eZaz4
         OWKg==
X-Gm-Message-State: AOAM532IrcQZ1IfWf8Z4/vnn95Lh99WaPM/oPAxRRACn1ZujPxGq4q29
        AQx0MktOZD/lcavqmLEOrSAaOJqettdLz1vsJoBeQxL8vcNFjtlP
X-Google-Smtp-Source: ABdhPJyvqh2kvL9i6UY+X8XUs+h9A3iWVe9bxfftlAz+JjA1LBWPSD2xXiyu46uqStsiTFyP/49wFk1Vftsjyk1F6YI=
X-Received: by 2002:ac2:4241:0:b0:448:4b83:8372 with SMTP id
 m1-20020ac24241000000b004484b838372mr11219414lfl.463.1648738318217; Thu, 31
 Mar 2022 07:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqee2i50h9.fsf@gitster.g>
In-Reply-To: <xmqqee2i50h9.fsf@gitster.g>
From:   Robert Coup <robert.coup@koordinates.com>
Date:   Thu, 31 Mar 2022 15:51:41 +0100
Message-ID: <CAFLLRp+Krry472G4zgSqv_3MHz19zxOyxjy0JCHCJcJ-34HO9g@mail.gmail.com>
Subject: rc/fetch-refetch (was: What's cooking in git.git (Mar 2022, #07; Wed, 30))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 31 Mar 2022 at 05:10, Junio C Hamano <gitster@pobox.com> wrote:

> * rc/fetch-refetch (2022-03-28) 7 commits
>  - docs: mention --refetch fetch option
>  - fetch: after refetch, encourage auto gc repacking
>  - t5615-partial-clone: add test for fetch --refetch
>  - fetch: add --refetch option
>  - builtin/fetch-pack: add --refetch option
>  - fetch-pack: add refetch
>  - fetch-negotiator: add specific noop initializer
>
>  "git fetch --refetch" learned to fetch everything without telling
>  the other side what we already have, which is useful when you
>  cannot trust what you have in the local object store.
>
>  Will merge to 'next'?
>  source: <pull.1138.v4.git.1648476131.gitgitgadget@gmail.com>

I'm not expecting any more comments at this point. Several people with
an interest in this area expressed support for the RFC, and after a
few iterations we have worked through the implementation details (most
notably the naming). At this point =C3=86var, Calvin, and you have reviewed
it in depth.

Thanks, Rob :)
