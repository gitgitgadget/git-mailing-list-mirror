Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9819AC433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 19:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356891AbiALTnE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 14:43:04 -0500
Received: from mail-pj1-f53.google.com ([209.85.216.53]:40857 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344579AbiALTlc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 14:41:32 -0500
Received: by mail-pj1-f53.google.com with SMTP id 59-20020a17090a09c100b001b34a13745eso14331703pjo.5
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 11:41:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kdBUQWybX2GT6TR73E4bhibBqPu4232WSK+r5Z+651w=;
        b=Ono6rAXFRWpgRJyjhDnSKCUT4gY0rSHsMS4pFb0xfEJX4mqIO4cwaFFpWHj/GjK7px
         T78gWp/lU5zuTZBqfitJ0MLEZdhpLqs93vQD968cTGRnRs97Lax3ZGsIPX3b4z3TgbHp
         qJ9j3YLYVrmrDE6aCQH+7QIEhT/fXN/Fg7P7Ug54iBiBTix9XeeRV3uvDRIZekNGCzxp
         SV0A1ioY2D8H1WyoAcdqdHjl8PoYa/243NYZTSw9aQ4tVIiInjU+PNNPc/I2dRhiUI8z
         GHNv6VaihdgWdLAUniA4VPnMAHN/L46BThxjMgL11B6CiWNAWTguHPN9TZKy7EaTpFJn
         oQ9g==
X-Gm-Message-State: AOAM531RdOjpfzeHSumLIgIzkasQVLPzkvLTOPVaiTZIyBFQRwBo4F26
        JJ8f9yCEz5GYj1H9KbEDy8TwZ94UJTIC3thoY/Y=
X-Google-Smtp-Source: ABdhPJwI9PAB5g0tLlUpvrMbF3bL6fBdPrh90HvQMYUOSom+d+cF+y31TiT8NF3Vxj/GS46C5G52ymxftsCKXiW7d+o=
X-Received: by 2002:a63:7e4e:: with SMTP id o14mr992981pgn.139.1642016491911;
 Wed, 12 Jan 2022 11:41:31 -0800 (PST)
MIME-Version: 1.0
References: <20220112134635.177877-1-jholdsworth@nvidia.com> <20220112134635.177877-11-jholdsworth@nvidia.com>
In-Reply-To: <20220112134635.177877-11-jholdsworth@nvidia.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 12 Jan 2022 14:41:21 -0500
Message-ID: <CAPig+cRCnur5c6HVV+z5OW4XL3cQcLr0gWaZUSLC5so4kaM-OA@mail.gmail.com>
Subject: Re: [PATCH 10/20] git-p4: place a single space after every comma
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     Git List <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 12, 2022 at 8:47 AM Joel Holdsworth <jholdsworth@nvidia.com> wrote:
> This patch improves consistency across git-p4 by ensuring all command
> separated arguments to function invocations, tuples and lists are
> separated by commas with a single space following.
>
> Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
> ---
> diff --git a/git-p4.py b/git-p4.py
> @@ -303,7 +303,7 @@ def run_hook_command(cmd, param):
> -        (root,ext) = os.path.splitext(cmd)
> +        root, ext = os.path.splitext(cmd)

Someone who doesn't code in Python regularly might wonder if the
removal of parentheses on the left side of the assignment brings some
sort of semantic change with it. Perhaps the removal deserves mention
in the commit message?

Not necessarily worth a reroll.
