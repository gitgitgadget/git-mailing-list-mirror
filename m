Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54F651F406
	for <e@80x24.org>; Fri, 22 Dec 2017 19:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756149AbdLVTx2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 14:53:28 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:44315 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752224AbdLVTx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 14:53:27 -0500
Received: by mail-qk0-f196.google.com with SMTP id v188so8614206qkh.11
        for <git@vger.kernel.org>; Fri, 22 Dec 2017 11:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=URZCWO4byRemBqkIMiFjlvDso1t3RGQrESxeYDggXyA=;
        b=bgf6qaZo/hklMZdqhMz/bX5joYTi9I6hEvND+VAo8HztY5g2A9LTjj2oscPDprYpo0
         wayqeRlAkhGgkbEBG3HzksQpodpIk4/COzkQvfD1p+BKNXfWzurubLJr1JhiM6EigkU6
         dxLODsurlSmrLuLJBytpQwZPWHSgwsMS1BIA7SPD8nSxhPzPQIPakGjxqsaFYYTjWoCR
         qYhP3H4Nxn87C1oDoECoM6KgvvrnRz8hXuBulHSZZvJ3NgFARgDjDdXmJUp19SWJmt6s
         kalafVQLdEQGZum/X13RHFdiIXNmVdCmXWNAcO6VCTDxJ5XqLjbvy1D7s8//7f66Mb/k
         6bYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=URZCWO4byRemBqkIMiFjlvDso1t3RGQrESxeYDggXyA=;
        b=kmd8e1LwU07l3X8IdkO8Wxb+zVkTDArE57xketPhAlvl7E9G79T/QUU0245WatvXHy
         F1HTqqiHqh3xpw6K/ms5R9JYWKC9sez0ipg2/n9il83otKzRIsxFdVvLGfW4NanEGR9y
         pVSqmW7ahnYt4MiKpFO8XqAGrnc8VV4qz2H/utmsh8hN4qO2BRw2SJCsA1sny2344r5T
         uv+A7cB54pWgEO6xcYP3BuGDkzTBWdyg5u2HtANBJn/t/SXWItFDXtvfXNBUGBMxpllb
         Bk0mDPmdTSlSsk8ahasHilVk+YENpwlM56Prv3xU/3KwdJ8Zcu29g7IvxRUQenIDOAjd
         qsaQ==
X-Gm-Message-State: AKGB3mJ54xcz+c/InqNr6oVazPOxWJMpS59jIUps0cWBpmIhoMQp8gv/
        wJSHjHyTM79RdL+XGjYpJwiCWLQT3wV8ugiayG8=
X-Google-Smtp-Source: ACJfBos0fMqCHBhmHACMn4DSWq+BlyaWkkSoGOneErCxa2xoAVUU6/AHWc41eyx/ihLjRjl/T2iglKdR1mgmNH3k5vA=
X-Received: by 10.55.130.194 with SMTP id e185mr20047777qkd.357.1513972406596;
 Fri, 22 Dec 2017 11:53:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.2 with HTTP; Fri, 22 Dec 2017 11:53:26 -0800 (PST)
In-Reply-To: <20171222160056.10102-1-avarab@gmail.com>
References: <CAPig+cRDi14Rez+6ZJAEdxHpo0Mw7JQFkcuG2oVqv2pP_ZbvhQ@mail.gmail.com>
 <20171222160056.10102-1-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 22 Dec 2017 14:53:26 -0500
X-Google-Sender-Auth: x4FVLFr4jpdmk3gKHP7CN3irt-k
Message-ID: <CAPig+cQj8=YFRBQZ3+9NJAsr2rNq0GvxrUpmt18ttvmVu1Nyhg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] support -m"<msg>" combined with commit --fixup
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Pat Notz <patnotz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 22, 2017 at 11:00 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Here's a hopefully ready to apply v2 incorporating feedback from Eric
> (thanks!). A tbdiff with v1 follows below.
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
>   commit doc: document that -c, -C, -F and --fixup with -m error
>   commit: add support for --fixup <commit> -m"<extra message>"

Patch 2/2 doesn't seem to have made it to the list...

> 2: bd78a211ed ! 2: 780de6e042 commit: add support for --fixup <commit> -m=
"<extra message>"
>     @@ -22,6 +22,21 @@
>             In such a case you might want to leave a small message,
>             e.g. "forgot this part, which broke XYZ".
>
>     +    With this, --fixup <commit> -m"More" -m"Details" will result in =
a
>     +    commit message like:
>     +
>     +        !fixup <subject of <commit>>
>     +
>     +        More
>     +
>     +        Details
>     +
>     +    The reason the test being added here seems to squash "More" at t=
he end
>     +    of the subject line of the commit being fixed up is because the =
test
>     +    code is using "%s%b" so the body immediately follows the subject=
, it's
>     +    not a bug in this code, and other tests t7500-commit.sh do the s=
ame
>     +    thing.

Did you also intend to mention something about --edit still working
with -m? (Or do we assume that people will understand automatically
that it does?)
