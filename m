Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FADC19F2A
	for <git@archiver.kernel.org>; Sat, 30 Jul 2022 20:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbiG3UGH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jul 2022 16:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiG3UGH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jul 2022 16:06:07 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA85ECE07
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 13:06:03 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bf9so11726353lfb.13
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 13:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=o4XLPuJNzqJEM2UQN6Pto/xYTlsHquY/J5lUxJwvvQE=;
        b=Xp+HjtWUiZy5PZDd+mhC4L//7KnC7AjlCCc0menTDdtFG/wSyCKxsvFnQpu3nPUG+C
         l1ZRnwUP76a5uNfQgzOKslm4+kSJ3O8ozUc218pA8Xn6kwbdMOeS8abjAR9EZ+rvqhi2
         CGuo9Ui2ule6m+s1rPHZ0KJe7qezitsn8aVfYRvn0qTTzMIIx9GvJugxiClzuQ168y+J
         K/OV9fdlO9cdfdrKSidtlzh+/6vIz//ECI1tTAKICecVxC9pWYLKwPt3Gl33n63My0oV
         lsK9VUUdvoo38CV2Ky1pHC441j9QDzkhShy1wyYaygK9lMC+tb0V3c7HKBjmdHvNRFps
         uEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=o4XLPuJNzqJEM2UQN6Pto/xYTlsHquY/J5lUxJwvvQE=;
        b=IBtWArW/yp7yHQ1eme2Q/HfZTTC3vLSx1pWqrVl1UfD+e3ItgXXYgr809UOnNax/QG
         PDCFsvqmpgLKeugeltI+eP2739n0Fi6KoVyoEyascQinjE03PVnilR82AmBolXSc/b5C
         TWIG6I0egkLL/tonyho6KY6ddmowX9zYEhCv+Zy/zeykJLT5TEvE5F7rwng1A3jHb+tw
         PLBS4faRJd7t+ciNpZXBjfHzpsOOH/xUDGKcGvWZo2i9TI80XqhayNqbT4w8krWf84+N
         NAEAmRt65fiFgtHzoLF0Bi7FDbnWjO4iTBiTDnIPVCgjj1yr3PJtYySZJdlZlSmKLo/L
         mSFQ==
X-Gm-Message-State: AJIora9MPPfIjGySkuB6ZAf9C8dDfJ0gxg1nQy34MJOqZrPw4whLvGq2
        oou5yjQK52+PKfnKS8O5oulEDzGzGRug3r5d+l39pQ==
X-Google-Smtp-Source: AGRyM1tJZp9Dr91pMQ18FTN2z9VHNMQUWuxuVOKQBgtmEblA6b9SXI3p3kN43U4MNRGuvOJpMlyLwERElSCNUksLM/s=
X-Received: by 2002:a05:6512:3503:b0:481:4470:4134 with SMTP id
 h3-20020a056512350300b0048144704134mr3155227lfs.42.1659211561857; Sat, 30 Jul
 2022 13:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657819649.git.matheus.bernardino@usp.br> <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com>
In-Reply-To: <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Date:   Sat, 30 Jul 2022 17:05:50 -0300
Message-ID: <CAHd-oW5VuqvMY55z-XsYUACWv+pmS6-AD7C0RG7BBq9XpshHuw@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] docs: de-duplicate sections, add more
 CONFIGURATION sections
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 5:25 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> This series is a follow-up to Matheus Tavares's v1[1] patches to
> de-duplicate some of our configuration documentation, per [2] I'm
> submitting this as a replacement series.

Thanks for submitting this version, which I very much appreciate. I
left some comments in the patches, but overall it is looking good to
me.
