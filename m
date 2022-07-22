Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DFDC433EF
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 12:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbiGVMrf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 08:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiGVMrd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 08:47:33 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6566995C20
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 05:47:31 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id p6so5311846ljc.8
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 05:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bp/PryJSZvV3MVJBLSzAti4VPySSsCnReEfOtenhZqQ=;
        b=DGehofyBenr+6QZpTVcu1qqwuADfa9X9lCZ9v6/V9vrj29Mrk0+BFIMYFcL7ieeJTg
         UZ+a4UB4w7NZwPjSRo3B58SoyTb63f4lPhASLSTB/Bc0747y6HyFt9lkUi4HXKuljyT9
         xSsnCNSn6oHcjYDyn6rGFgqjLCHrxj42neTN6IEL7V+M5TsKEY+lmlDPd1U5HtYyte0W
         OsSZ2jk7FEYnDYSD+pqJ/EgOWwvNKn4r6eKQ+BH2U7YGyYSYk/y6erPDp/LvK5Abm+CD
         VbO7kmFIJ3tlnDUmTavtbGlSBdNnMKN0z2wDv2qVZTFBoxeqWWyT3seUQ0gfYrj9+bxC
         vwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bp/PryJSZvV3MVJBLSzAti4VPySSsCnReEfOtenhZqQ=;
        b=b2IUcQz9YNN6fcpH3rCoSID6CMgd4yOvD/sebN+NOtvAT5KtB8eVtj8COTT31u8KOS
         a7dMVC5ixC8PBqA4irSm1CHQz/GKl88f4SGSHwRMcpA+ldb15FkVND/ZtN/NZoNQdxUu
         j3x6tPCPYNPGts3sSJcQNWH/TfBpCzMD6u+fc0ZU2FEbZetM5n9qcWbD53dr7u8ja7GR
         Hqih2KkEmgqlwOFzlqyq23fL5fO3kpgW0rwhzdoEseNQ2OqM9oN8MlzGtXVSlfOAu8SA
         J1nAIMBJ0WdX/cAnd6dJApOcZQSt1xkViHT/FnLhKIbkqmw3I6esKduqrRc/uOXkaE90
         wq5Q==
X-Gm-Message-State: AJIora/mHxzYFLWHkXiJLeOVKDVNlyYjlxs+gblrNNd7kyAWfwtIx2i8
        M70k+NFmMhb1sIUUcQnDXzUxkxTi8+z86ZWOVJ2jWA2SI7Q=
X-Google-Smtp-Source: AGRyM1s2rEo8QxVVfYQdWJdmTeTqoPUkOo1DySm9zx+DD7rTXCKpXS0MGUC33Kp+kTVMMPvAFHxfWz1hIjQ4CuykP8Q=
X-Received: by 2002:a2e:8e2c:0:b0:25d:e021:ba8f with SMTP id
 r12-20020a2e8e2c000000b0025de021ba8fmr116769ljk.491.1658494049586; Fri, 22
 Jul 2022 05:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <6a14443c101fa132498297af6d7a483520688d75.1658488203.git.matheus.bernardino@usp.br>
 <220722.867d45s81o.gmgdl@evledraar.gmail.com>
In-Reply-To: <220722.867d45s81o.gmgdl@evledraar.gmail.com>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Date:   Fri, 22 Jul 2022 09:47:18 -0300
Message-ID: <CAHd-oW6HBkZPFR-vKwVSLBkqic=eSiWY8EY1T4ZNEzCk+Lx6Bw@mail.gmail.com>
Subject: Re: [PATCH] pkt-line.h: move comment closer to the associated code
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 22, 2022 at 8:25 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Fri, Jul 22 2022, Matheus Tavares wrote:
>
> > ec9a37d ("pkt-line.[ch]: remove unused packet_read_line_buf()",
>
> Nit: "log --pretty=3Dreference" for me emits this length of SHA-1 on a
> fresh clone:
>
>         ec9a37d69b (pkt-line.[ch]: remove unused packet_read_line_buf(), =
2021-10-14)
>
> In this case ec9a3 is non-colliding, but you might want to adjust
> whatever your local alias is to use our default hash length instead of a
> presumably hardcoded length of 7 ;)

Thanks, will do :)
