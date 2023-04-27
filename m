Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EE6C77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 04:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242681AbjD0Ee5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 00:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbjD0Eez (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 00:34:55 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A33130F0
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 21:34:54 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-b99489836aaso5307043276.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 21:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682570093; x=1685162093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmkBvKtVdvM8HTBQ8H7ECRCLxbWeWEUmVpRDo+2O+SE=;
        b=F+xEcVZDJHXlcmZDIlrB0pcA41vZ5c61x/6tCn51Oox0rvotVBAx/2+r7BAQHiSRMf
         A5PPT9RZq/hSi45x8pvjZxLNQ+sGUykGSztPaOjH3QqHt3SoBOgH5Yy4/rDWAXOlsYjM
         4N1Bvt1Ck8bhvGFLLf6FQSGg5C5/RyVh3mbMwDWysE0qEhRm13n7YhJPm/qcXY/A6Yx4
         Jr1MhuXawQnS5kgqL+kSxOdO+a5/CYjixx0YvEbVFkhP1xtebvzZYA8il8tGRp/6AKk/
         QpFxk4FRckyyIQJoznD3DngxoP3c3OEoFPgp+qq02wlMkMGslQNDSu6GhGx19am9n9oU
         z/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682570093; x=1685162093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmkBvKtVdvM8HTBQ8H7ECRCLxbWeWEUmVpRDo+2O+SE=;
        b=H6qgcjTqpIYTC39lpJtKK/8xFZZzdvgB045clTg5ctMWCGRD9M0K5OAfDGsE/n6Lwk
         NRQFMn6a3ygNz3JeCUubXKaiHrP0TalYuph1T0N17nO90uo+cDgyEUuthzTs+ahTc1IJ
         57paJPHv9peXQQf8g2wgmuI+eH97k8jcjqT8IZRJ6T/376MO9mbkLlkr97+jiYljGPte
         rZJNU30Ey0lFexOqR0Uys4HcH6cQVJJwBzJ5o8pqUDVLXnxK2nn2WHPJ4AfPUg+omAqQ
         KhfWKhB6uPP6K+lXdsDYyiLMryEPXsvZwJQgJsLlDPbCMesbOv6mAn9V+hKJmtvGBfGF
         J9ZQ==
X-Gm-Message-State: AC+VfDz2+/AjYWBsqvvAZU2vYrLxEGReSktpUMF4aDQjbcLxhvqYgMzG
        YOpxf6XoCM/NpHqrNWjOsQyKJTOvHDdx+bOYGio=
X-Google-Smtp-Source: ACHHUZ6Pu+/Lxm8KfrcQIu8ZNOPRQD6axSLoVyP4711+s76qExQOyrOxznZKRiRihpXzoNTXlX02Ce5hbUjR0Ijk5MA=
X-Received: by 2002:a25:d93:0:b0:b6b:b120:4e0c with SMTP id
 141-20020a250d93000000b00b6bb1204e0cmr6504ybn.55.1682570093403; Wed, 26 Apr
 2023 21:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1523.git.1682342241825.gitgitgadget@gmail.com> <xmqq354o8v8u.fsf@gitster.g>
In-Reply-To: <xmqq354o8v8u.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 27 Apr 2023 12:35:23 +0800
Message-ID: <CAOLTT8Qmo31YExXUOPk2sx73b734wuxiD3AUX0UAnPo9WSqpfQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] transport: add --show-service option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Zeger-Jan van de Weg <zegerjan@gitlab.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2023=E5=B9=B44=E6=9C=8825=E6=97=
=A5=E5=91=A8=E4=BA=8C 12:02=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Without using protocol v2, the git server needs to send a pktline
> > "# service=3D$servicename" to the git client first. This often
> > requires the git server to implement it independently, but it can
> > be delegated to the `git receive-pack` and `git upload-pack` to complet=
e
> > the work proactively. Therefore, the `--show-service` option is added
> > to `git receive-pack` and `git upload-pack`, which can be used to send
> > the "# service=3D$servicename" pktline, making the logic of the git
> > server more concise.
> >
> > Note that this `--show-service` option can only be used together with
> > `--http-backend-info-refs` and it is not applicable when using protocol=
 v2.
> >
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
>
> The above is a very well written description of why we _can_ do
> this, but it is unclear why we would _want_ to do this.  What do we
> gain by letting the individual services to declare "we are serving
> this!"?  Do we lose an extra fork & process (it does not seem to be
> the case)?

When I was implementing a small git http server, I wanted to delegate
everything to upload-pack and receive-pack. Everything else was fine,
the only thing I was not satisfied with was the need to send an additional
"#service=3D$servername" message when the protocol is v1. To be honest,
the $servername here can only be "git-upload-pack" and "git-receive-pack",
and the git client does not actually do anything extra with this message.
Why not let git upload-pack and git receive-pack do it?

The "--show-service" option is not a functional requirement, it just
simplifies the logic of the git server.
