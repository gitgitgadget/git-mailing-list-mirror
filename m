Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A114C6FD1D
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 04:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjC3EDI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 00:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjC3EDH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 00:03:07 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF9E4ED5
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 21:03:06 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id e9so3018516ljq.4
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 21:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680148984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDeowwVsrBbZJKnbNSzaJo0GTbHjmvHYRcabL6Z/NfI=;
        b=EF8rLfMbKm7yn4rYaYOI5b/KCYCNQ6flcLiMBMM/YL3cL97izGG5k0Ijtc1fpf0yFN
         q4saqA6ljl0bU7YmmlREmU7MLhbnfirLNYpNPspk4myOV/HLROMgQyZea74YSUvHOhUN
         3I0GHN3+2Dmn5B6ZfgTX97erdAgv7dBebE+abyOmEuulSaOorAUczVUayfKlKZpRO16L
         0E1ppLGWV5TMwRPzyJQit4MrGKjAcp3xrvu53dEwzUWI/zdqyCY2S+C4Bh1P+2Cc91pW
         1fEAbEqcGhoyd6FotxWRL/xsxIENO+XngfDSDsg5u1gCjXCdMoS5b+XJrMqtRVpljYfL
         Ps1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680148984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDeowwVsrBbZJKnbNSzaJo0GTbHjmvHYRcabL6Z/NfI=;
        b=i4Khcg6KY5I006xqzgOMstqI08YYQ0m0lIc3HpHo5bJ+SitLFqcZk67OAS1rP+bNrD
         az8HsPCCKQLOTQmUUhuV5kDmMg59+2vvygiYFbjpZLEVN53hNw4ptwEItiapNmXDpqbE
         05hsSGMwfJuDj961RBvWcmigPFuivW6f42sMF3/VW1c9QTTxukONp3uc3toLXd/alzzt
         N7xX7UawtI7k3KMsicDjRcg+TdMyMjqc1xdzTkt4kX/CpcAaPIiTXF5m6Vwm/zSp8xXG
         mdBt0kb/K5cDueIaR8GvvfiX4ZJXDhCYnM/UXBKeNBPJt0UNISbw/jJgXdffP5AZWoGy
         e/CA==
X-Gm-Message-State: AAQBX9ezHjYkK3g3JTYRImUyS7w4Jq2JjqE559/oPC84qN9TwLuYg6Bb
        AIbA1w+xgQPCCVlpJfG375W/iEGfTSOGtcXcedA=
X-Google-Smtp-Source: AKy350YSyGMCRfPdm1y5rb31PkI2Mh35YiSRogSB+ciR6RkYkBMhf6WA9ArfzKJ+dPd7y5doodrvDRpURXs3x4/pkYs=
X-Received: by 2002:a2e:240b:0:b0:299:ac4e:a8ad with SMTP id
 k11-20020a2e240b000000b00299ac4ea8admr6502127ljk.1.1680148984344; Wed, 29 Mar
 2023 21:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqv8ij5g83.fsf@gitster.g>
In-Reply-To: <xmqqv8ij5g83.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 29 Mar 2023 21:02:00 -0700
Message-ID: <CABPp-BHia5NO40-j=inCsroYn=J=+Zk12usNzL9keFFqTsghvg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2023, #06; Wed, 29)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 29, 2023 at 4:33=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> * en/header-split-cleanup (2023-03-21) 16 commits
>  - csum-file.h: remove unnecessary inclusion of cache.h
>  - write-or-die.h: move declarations for write-or-die.c functions from ca=
che.h
>  - treewide: remove cache.h inclusion due to setup.h changes
>  - setup.h: move declarations for setup.c functions from cache.h
>  - treewide: remove cache.h inclusion due to environment.h changes
>  - environment.h: move declarations for environment.c functions from cach=
e.h
>  - treewide: remove unnecessary includes of cache.h
>  - wrapper.h: move declarations for wrapper.c functions from cache.h
>  - path.h: move function declarations for path.c functions from cache.h
>  - cache.h: remove expand_user_path()
>  - abspath.h: move absolute path functions from cache.h
>  - environment: move comment_line_char from cache.h
>  - treewide: remove unnecessary cache.h inclusion from several sources
>  - treewide: remove unnecessary inclusion of gettext.h
>  - treewide: be explicit about dependence on gettext.h
>  - treewide: remove unnecessary cache.h inclusion from a few headers
>
>  Split key function and data structure definitions out of cache.h to
>  new header files and adjust the users.
>
>  Needs review.
>  source: <pull.1493.v2.git.1679379968.gitgitgadget@gmail.com>

Not sure if you want more review, or the notice is just stale.  If the
latter, some helpful pointers:

Jonathan Tan reviewed the latest series, v2, here:
https://lore.kernel.org/git/20230321215653.1615083-1-jonathantanmy@google.c=
om/

(=C3=86var also looked at v1, and pointed out one of my commit messages
needed clarification, and that my overall cover letter needed further
explanation -- both of which were provided in v2).
