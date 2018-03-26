Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AD201F404
	for <e@80x24.org>; Mon, 26 Mar 2018 00:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbeCZAL2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 20:11:28 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:36981 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeCZAL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 20:11:26 -0400
Received: by mail-qt0-f176.google.com with SMTP id w12so10348438qti.4;
        Sun, 25 Mar 2018 17:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=IfELDUhFG8SC4eYISU210bReIOYkqkbvRJtk0VfZoho=;
        b=lQ0DbLvkyWaFMOBa3do3+LYswNxdJ1hDORAk+ugYVrFuQU063z9iL+auhYZvcfY555
         X/JgRvaoRF6/cuUSDzOe6h9aN7s7p23A3KjIN+JVlZRTPgSLGsI/X72M6vdotj1W6Mhn
         NYISH3yNYs06BQkGGpdzuODnIRR63v4jk2M+jYj6jHqFmsnMp9CwQ0h3ntvgO7p6aKIi
         jZQ/CZpO0aGedLRG6hxV3Aot1cxD5OvS5pbopmp1kTvRxptxsBYLmKg25cjXS3IxiJMY
         PfvZ8NnOjTHlmuSE/N8DNc9r7DS1zCl37f3xEWt8n4jF+kfpxkom7+BtYRXjCrK1CBri
         4Fyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=IfELDUhFG8SC4eYISU210bReIOYkqkbvRJtk0VfZoho=;
        b=mIlaU3u/zMffej6KJz/CbMN3kayTN9UgQGdv0aZVgugsEacWBsWoCE9XLC/4YSyRDW
         usjDwrTanXRJQUPVEAGKsY1f3A4pU7UUTikwHNXHhgHl+rt0oYD0NmTO0Ot5+xnmstLK
         zqJoNAz7U31C+cBhljpcKsE5VuNhdjKOu4XssV0sZpASmTNKqnoU0OTaRophcEhZ9+TS
         VA9sD1a3eOnEyUTdLwK7rwNg3sOAcGvsSRMNk4VPuqJmrO2DnKdr/aN55kc0K4xuYsXF
         uEzBsLr5XFEDowg28FY7S2GQhXPXoJOEdz9F6PjzjEvA0zC62kdEqT6Sb7diaCNhZURw
         ICYA==
X-Gm-Message-State: AElRT7HKAGq1EbJ9xuMhT8yZFAtWbMWy4cs2dj/Ipo9UCbMYkb7+C1NE
        A9JrZuZMc5Yanx10EP8iyh6JjtAuWtcN9zqG800=
X-Google-Smtp-Source: AG47ELvyAcjoJm4aR+531CrNxnW67JuomWnR+XoMMVeCMj1vUDrGB7LRnlEe/BFMG6AvlhUzsYUTqWbYl1XpDBQf7LQ=
X-Received: by 10.200.42.37 with SMTP id k34mr38733897qtk.101.1522023085520;
 Sun, 25 Mar 2018 17:11:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sun, 25 Mar 2018 17:11:24 -0700 (PDT)
In-Reply-To: <20180325182803.30036-3-avarab@gmail.com>
References: <20180325182803.30036-1-avarab@gmail.com> <20180325182803.30036-3-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 25 Mar 2018 20:11:24 -0400
X-Google-Sender-Auth: l9iQk9vDwO21Uy8Os4ZJ6lUjogQ
Message-ID: <CAPig+cQ6EK=Q00panZECVvWt3pJyS9acC1n4mgogMmk5J4hO8g@mail.gmail.com>
Subject: Re: [PATCH 2/2] send-email: supply a --send-delay=1 by default
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 25, 2018 at 2:28 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> The earlier change to add this option described the problem this
> option is trying to solve.
>
> This turns it on by default with a value of 1 second, which'll
> hopefully solve it, and if not user reports as well as the
> X-Mailer-Send-Delay header should help debug it.
> [...]
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> @@ -3070,7 +3070,18 @@ sendemail.smtpReloginDelay::
>  sendemail.smtpSendDelay::
>         Seconds wait in between message sending before sending another
> -       message. Set it to 0 to impose no extra delay, defaults to 0.
> +       message. Set it to 0 to impose no extra delay, defaults to 1
> +       to wait 1 second.
> ++
> +The reason for imposing a default delay is because certain popular
> +E-Mail clients such as Google's GMail completely ignore the "Date"
> +header, which format-patch is careful to set such that the patches
> +will be displayed in order, and instead sort by the time the E-mail
> +was received.

A minor point: Are you sure that it's git-format-patch that's being
careful about arranging Date: to display in the desired order, and not
git-send-email? Looking at old patches I still have hanging around
which were created with git-format-patch, I see the Date: headers are
wildly out of order, presumably because the date is taken from
Author-Date: and the patches were heavily rebased.
