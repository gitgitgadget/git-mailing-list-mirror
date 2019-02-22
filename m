Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBDF620248
	for <e@80x24.org>; Fri, 22 Feb 2019 21:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfBVV7Y (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 16:59:24 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38762 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfBVV7X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 16:59:23 -0500
Received: by mail-ed1-f68.google.com with SMTP id h58so3053637edb.5
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 13:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=S2df41MYopqFSHqTuNqvei4znT+XOrEfAls+NrKik64=;
        b=LJFpvf4zv/XfpVvEM+zxR7gj8MFMIU+1yjn6zFRtoeHJUZnglgIcN42nUldVt4/TFM
         Q8fMBt2NidvNVqTimCembMmOrVzwZ5eUNZXda7gGCKaEttVuTbfroldQEnQMKNEGDpoh
         dUl9uvmZ0Hx0by2C01pFyEaF8K4GyDw2FH8EKVaVJKuWCmxL0GbhfvwI5y2khc7C/DCG
         z9LTDWVsvRhNbF5SWchQ41Ej2Wh08Mkaq/By053G1R1en3meFGYzqyXZwJhPMRYtjoY+
         NY5MkDyuorNJDh5Zhhs5i7X+AFXA+E7W6Nra4rMva6J16IQ2z4Vv8uk599+Qm6mz5Mg0
         0X/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=S2df41MYopqFSHqTuNqvei4znT+XOrEfAls+NrKik64=;
        b=H2mLDxPmvhjaorfOpnlFdqDvH+RE7FO7HfpBtliqmCl8Xe1ggWirqvrNmcrP246zI6
         GDMbnaVl99VK0IRTmIu0C1VY78P3c3VlHG4n5gz5EfJns2mg2Pq+2yPbZVqmDpNl8eIo
         mNfAGIyBftAVnaXmObxbGWgaroX2rb8IIN6RoHQrX43xvKGyNYP2XrfgJHmEDHonf/2w
         IVEZViu5fdNgMD/mkoTOw+nKAN7Te8xx93+uDfBWtKCjvz8fugT5UZxEwIMzq7MBFVXK
         Up7jrzvoOr4gPihwtdzAasM84Ct0EsjGntI6oGb5mGidW8BHXZkcr2uyf1HYzQpo94mL
         vFHg==
X-Gm-Message-State: AHQUAubi5xIwPP6E6k2xCYZgeMasRRk7QQZWZuJDw/D+a7e8R35IGbmO
        DNSgBJjmg+BLKXeokBWN8GU=
X-Google-Smtp-Source: AHgI3IYx6RJJQR7fI5Xv3pJMhb9+XeCxVXJiWkrnYtc2QjnejXoenxbFsE3NvjMmSzQZLeKPqfxThg==
X-Received: by 2002:a50:8fc2:: with SMTP id y60mr4886730edy.78.1550872761791;
        Fri, 22 Feb 2019 13:59:21 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id k8sm680462ede.65.2019.02.22.13.59.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 13:59:20 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Lars Schneider <larsxschneider@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: [PATCH v2 0/6] Makefile: allow for combining DEVELOPER= and CFLAGS="..."
References: <20190222105658.26831-1-avarab@gmail.com> <20190222144127.32248-1-avarab@gmail.com> <20190222151607.GD5090@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190222151607.GD5090@sigill.intra.peff.net>
Date:   Fri, 22 Feb 2019 22:59:20 +0100
Message-ID: <87zhqn4h8n.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 22 2019, Jeff King wrote:

> On Fri, Feb 22, 2019 at 03:41:21PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> This fixes a long-standing annoyance of mine of not being able to set
>> my own CFLAGS combined with DEVELOPER=3D"...".
>
> I already do this, via my config.mak. Are you passing these on the
> command-line (and thus your CFLAGS=3D prevents DEVELOPER=3D from adding
> anything to it)? That does seem worth fixing.

Yes. I'll make this clearer in v2. I never use config.mak, so I didn't
even know that worked. Having refreshed on the docs[1], it's because
command-line arguments are "override variables".

> My personal complaint is that you cannot override DEVELOPER flags via
> config.mak, because of the ordering. But it looks like your patch 6
> specifically addresses that (yay!).

Do you mean DEVOPTS? That works for me.

    $ cat config.mak
    CFLAGS =3D -blah
    DEVELOPER =3D 1
    DEVOPTS =3D pedantic
    $ make V=3D1
    [...] cc [...]  -blah -Werror -pedantic [...]

But then of course:

    $ rm config.mak
    $ CFLAGS=3D-cmd DEVELOPER=3D1 DEVOPTS=3Dpedantic V=3D1

Only includes the flags, and ignores DEVELOPER & DEVOPTS.

1. https://www.gnu.org/software/make/manual/html_node/Overriding.html
