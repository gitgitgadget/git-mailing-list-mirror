Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D727FECAAD4
	for <git@archiver.kernel.org>; Sat,  3 Sep 2022 13:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiICN3t (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Sep 2022 09:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiICN3s (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Sep 2022 09:29:48 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1448217598
        for <git@vger.kernel.org>; Sat,  3 Sep 2022 06:29:44 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id se27so8740347ejb.8
        for <git@vger.kernel.org>; Sat, 03 Sep 2022 06:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=Jine2qF8ZtIMutr1n7GjdcKq+fIM0J93rzyqbh/CzQ8=;
        b=kUCjIQ5x7ApnhHIXjEvRGMN5be6f870PZhjpACgq89OW3iPxPlcPXwTCBvHnvoMST2
         mnwYxBCkWqHQy8llXm1eKp18m03MSUxPiyot9Cgh8oMyooxV9ugoEXrwTrY6zL7BOEQp
         dEhp7ybC1uqC01Mx3z03zOLh8Mmm/nPvK/JsPPnp8xL2vdvRyb9efXKcaM3uIA8gKxuG
         Quei0PvpGsCg7A4dtmFgjlVpf3JAvFuieHHYG/ycGFRV9ior2IglVw6Q+LjhxjCysWp4
         7XRVRbNuRbgi5fjc3vSaVF6BSuM7U53UZ+C8PFTZnOEYWcPvYBmWf1Px5CsABI2DImg2
         379g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Jine2qF8ZtIMutr1n7GjdcKq+fIM0J93rzyqbh/CzQ8=;
        b=jgJ2X5uL52wlbfR3k0y4Sn4gBIAkuFF/JgvK4Cuns7G0oBuDL0drO+9E/Z+AKEoH+l
         /7KwXxZRypm39IIJnJqNFmS8Zgbf6HuN6EZCeuyZGoYxXsJPJya93eYgv6TgcDEA2por
         BJDnC9mVaI7F4uAccH3y/m+MC9at2UnOtbI17CN41azEbQcT9LbA4/gWl1MaV8lwN9Kz
         nIHKH+sklfMHM18amBbG1zAXCA8cWyKJLCTN9Bf/ERxlz04DooWJLw+2nNYNkZDBIqA4
         MNQfpDmsSRXMcD/u21f8IVAoIhqRYmJteRAngJZzvxQvdclPcmQiMQzW/gAAzsB0pTuX
         9weA==
X-Gm-Message-State: ACgBeo3APgs7XosNtlVczsf4Idq90X8WgzmajK1oX27eOhcJqJSAxmqZ
        qZ6eSGONG6GS7OGarXunjlBZwoNiQgdH8BO2OPfNiB/HssHr7w==
X-Google-Smtp-Source: AA6agR7hB+NxxSxA5iqNrS3lhj17T5F/G6NDUPIwMRx3CoIscaYSHfpMU+TTE4snbmW48yAiEHKGaspY/W7MlM0OIPI=
X-Received: by 2002:a17:906:4794:b0:742:a5b2:546d with SMTP id
 cw20-20020a170906479400b00742a5b2546dmr11477946ejc.158.1662211782605; Sat, 03
 Sep 2022 06:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com>
In-Reply-To: <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Date:   Sat, 3 Sep 2022 10:29:31 -0300
Message-ID: <CAHd-oW4QpPBUqo5ToWXtBg7-LHbEam7aqSALSrwaA3OABma8ng@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] docs: de-duplicate sections, add more
 CONFIGURATION sections
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, =C3=86var

Thanks for the reroll. I looked at the range-diff, and you've
addressed almost all of my comments from the previous version. I only
spot one issue:

On Wed, Aug 31, 2022 at 5:41 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Range-diff against v2:
> [...]
>  8:  5c379ab1476 !  8:  af912e9ca65 docs: add CONFIGURATION sections that=
 map to a built-in
>     @@ Documentation/git-fast-import.txt: operator can use this facility =
to peek at the
>       --------
>       linkgit:git-fast-export[1]
>
>     + ## Documentation/git-init.txt ##
>     +@@ Documentation/git-init.txt: $ git commit    <3>
>     + <2> Add all existing files to the index.
>     + <3> Record the pristine state as the first commit in the history.
>     +
>     ++CONFIGURATION
>     ++-------------
>     ++
>     ++include::includes/cmd-config-section-all.txt[]
>     ++
>     ++include::config/init.txt[]
>     ++
>     + GIT
>     + ---
>     + Part of the linkgit:git[1] suite
>     +

Shouldn't this change be part of commit 9 instead of 8?
