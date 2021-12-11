Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B28C433F5
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 08:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhLKIRB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Dec 2021 03:17:01 -0500
Received: from mail-pj1-f51.google.com ([209.85.216.51]:42995 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhLKIQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Dec 2021 03:16:59 -0500
Received: by mail-pj1-f51.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so9393932pjb.1
        for <git@vger.kernel.org>; Sat, 11 Dec 2021 00:16:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OeSX6L0OvziYFiyBTc1xwXwUQ850WBwJ1T0RRFI1Pzc=;
        b=Rl3jtr1zGwfgZPfvC30hxgDcihZvaKIQTzOCud44olrLZRgxFI17EfwBYuXFMeVKLV
         aOYL3LQuuwXW4eJWY+0ztsCHel7b+G/yL0N2Ev5AXLYz/hauo0lTaq79xlej3utPDjes
         4N00Rd8GBHea+ps2OILJ8g7n5SeZhxN3bQprG0vtx8RCNp+YwSCfxGGcBnBxL+OA7izD
         Exnh8sWiHTOlNkFYT0OzAaSr1UJ2nidgEIFeIf4PePHnYTi6YiX603mjtRQVryeacw6h
         Fva52leGq92cUcezOiU+qEPrH8ufwlVOt5B3vwlRUUp7Z4jGtlVNo21QEhWV0Mrjigns
         aDpw==
X-Gm-Message-State: AOAM531MSXbZ5wzuYT8s769zY+97+2N8YSmPmxzklEOqMxFPa7stWZzS
        AgDrwEtCwUzjcU97R54VfBYnWQQqbdgjdlOuXxA=
X-Google-Smtp-Source: ABdhPJyDTxdHdOtQX6ROSs5QFYPOCr1L8k+PC3mV9j4qiy9nOgoqR1/uRCaNn/9CWEzvmcsT/Jne/ql2QCrhSTq8yJU=
X-Received: by 2002:a17:90a:b107:: with SMTP id z7mr29609360pjq.104.1639210619091;
 Sat, 11 Dec 2021 00:16:59 -0800 (PST)
MIME-Version: 1.0
References: <20211209051115.52629-1-sunshine@sunshineco.com>
 <CABPp-BFM5ZbFAzVfvDE3=zm6Q4LN2fWthPP8WH5kbgVPSxomtA@mail.gmail.com>
 <CAPig+cRD_DzisMo-8ZuT4NzESEe4i2vPk_1Y-_JTeV9rbdwkLg@mail.gmail.com>
 <YbMgL6A+/12GTeuf@coredump.intra.peff.net> <20211210095757.gu7w4n2rqulx2dvg@fs>
In-Reply-To: <20211210095757.gu7w4n2rqulx2dvg@fs>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 11 Dec 2021 03:16:47 -0500
Message-ID: <CAPig+cT4U-HSCV4kDHLEi7T+8Pi0o+eJjki+c5pmQdx2DTWcjg@mail.gmail.com>
Subject: Re: [PATCH 00/19] tests: fix broken &&-chains & abort loops on error
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 10, 2021 at 4:58 AM Fabian Stelzer <fs@gigacodes.de> wrote:
> On 10.12.2021 04:38, Jeff King wrote:
> >On Thu, Dec 09, 2021 at 02:17:32PM -0500, Eric Sunshine wrote:
> >> Thanks. I'll wait a couple days and resend with a clarified commit
> >> message for the second patch unless, perhaps, Junio would accept a
> >> resend of just that patch so I don't have to spam the list again.
> >
> >These looked good to me. I left a few comments, but nothing that I think
> >would trigger a re-roll.
>
> Very nice work and good explanations. I learned a few new things :)

Thanks Elijah, Peff, and Fabian for reading through the series.
