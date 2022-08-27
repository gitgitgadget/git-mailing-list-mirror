Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD18FC0502E
	for <git@archiver.kernel.org>; Sat, 27 Aug 2022 09:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244125AbiH0Jva convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 27 Aug 2022 05:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244683AbiH0JvB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2022 05:51:01 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B120A6AC1
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 02:50:59 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-33dc345ad78so90084487b3.3
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 02:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=28TU1eXBfnz7Q4WXEGn10KZjb/DP4W+lWoxgK5SrYJw=;
        b=cruJ5fBTGp+K3VK9UvH3RG367Qj8l20vIGpSGEtaNjoTvKeir9UlTraXjKD9lvv7v5
         u4Cvv7Cd5FYS8oCaR/KXVAAebO/iNAgOtCToddCiNX1xCZbfD6pdgc1xkCoZ5yPp64EV
         DIquQYDBgTqaSeJgZgbGLt0UJjJz19928OZyMlWuB9+Gbbfn02D6j5NIwJK2i6cjy6p5
         p+pRvioJLRizsjv26dp8Z4IPn8YA26Q39hu9xRZUncbBpHUw3TlK+3I6MziSHjFyId0A
         AsCDt7cximcPScfNXSIWxb6Dnp0TMqTHk6drN0o5m30ppJ2ksSf39q00bINxf2shWUpz
         yb+A==
X-Gm-Message-State: ACgBeo0Ip918RnWwRRvZWf5ZfyXk7JavpW0/s4blIrWNBOV5y2iCGuTV
        wazYP+H58ufBDdACfumlGIzdLWiFkFcCj5wYx4ZG++nwUDUs3Q==
X-Google-Smtp-Source: AA6agR79FOY2p9jRCT1j3rQWnt1cmtcRTsVzmD3369ExFpd10Xk+8Nfx12vN01LEFkKkAfCkKnZTeN9hrIAZhvCDsVU=
X-Received: by 2002:a05:6902:150b:b0:695:6547:be9a with SMTP id
 q11-20020a056902150b00b006956547be9amr3099710ybu.475.1661593858145; Sat, 27
 Aug 2022 02:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <CA+VDVVVmi99i6ZY64tg8RkVXDc5gOzQP_SH12zhDKRkUnhWFgw@mail.gmail.com>
 <20220827085007.20030-1-tboegi@web.de> <20220827085439.4qqfdggdhnytxxav@tb-raspi4>
In-Reply-To: <20220827085439.4qqfdggdhnytxxav@tb-raspi4>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 27 Aug 2022 05:50:46 -0400
Message-ID: <CAPig+cQEj6LOW68r7m7pb5LAwZKjvP-Z53f3Sh4Gxy0P3gA3cw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] diff.c: When appropriate, use utf8_strwidth()
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git List <git@vger.kernel.org>, alexander.s.m@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 27, 2022 at 4:58 AM Torsten Bögershausen <tboegi@web.de> wrote:
> On Sat, Aug 27, 2022 at 10:50:07AM +0200, tboegi@web.de wrote:
> > From: Torsten Bögershausen <tboegi@web.de>
> > b) The same problem exist for all unicode code points (so we
>
> That should be "exists". Let's see if there are more comments,
> before sending a new patch.

Here's one:

> The choosen solution is to split code in diff.c like this

s/choosen/chosen/
