Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A8F92047F
	for <e@80x24.org>; Mon, 24 Jul 2017 02:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752153AbdGXCC4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jul 2017 22:02:56 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:33204 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751782AbdGXCCy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2017 22:02:54 -0400
Received: by mail-qt0-f173.google.com with SMTP id n42so63398786qtn.0
        for <git@vger.kernel.org>; Sun, 23 Jul 2017 19:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JIqhaiG9Zkqb0abuvcEDNbs/mfYrm4EGd/vTLlLzank=;
        b=s4sgiIgTiKwOyOIxkZ21Q3x/aRoCksoH782b5gTD5qOZhoDv28nP0Z17du9XbeqSQq
         DmXaxU3gmGF/wu1JnLLQ3XS5oxQ7Zwxg5InFW74rG+mzq8ayVGzTcl3CUD8MjsOvPb31
         HGhU2lMtYuIWa7VxGBLCecAc25JRCxhaiAZSe/zdWDQfkIzHWhKt51ZUDwOpqzP9PXD0
         rPr9ZHMU4Eh1zOme8jYZFFIzujif0mOyJFmdngCfkmARopQewgAwdC6wXHdNoKJRY3rI
         vGjInW/mOEVlopj8KbNL7kqXxNFmT4WgeRYfP+oRGfKejY26ELecLKvApcRGc4XrAF5g
         Vn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JIqhaiG9Zkqb0abuvcEDNbs/mfYrm4EGd/vTLlLzank=;
        b=uaqJjGp9z1P7sDQ0rou0UCy38r0Y+xX7f6gVR6ZtUjhXHRvAIbbhk1aQN77L+PHn3p
         Z2+Rg8x791qzCyhQIv9EURomVeZD5FAjQvvJ3zhB29xKFlWGTpH8805uHAUmEhWsP3Z2
         s9/k6yHk9uZUWob3err2saZ/BPnCDT3dBna9KNiB5cMlmwk5KpYmLSPFshVrlQ5aTciC
         CAWDnmT5sU0oAURx95yT1MuWWmgBAeCBikf9/7GdYw3knDCfOl2aW3iBcAnI3P78jYo/
         UfaVQsM0KcHzTwLQtQae7OB6wQYHZ5RNxy+qNLd7EwiXVGFE31cLgtJdLsywuYEeK7zZ
         +9vg==
X-Gm-Message-State: AIVw112TlORQW4JZHqP4kLr8bp7zn+0IpWfRG95mLM/U56Yb4jo9dcN3
        zWrrQGyw8gP92RWJfKNyDrXDFJupfQ==
X-Received: by 10.200.0.81 with SMTP id i17mr18021594qtg.5.1500861774249; Sun,
 23 Jul 2017 19:02:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.193.38 with HTTP; Sun, 23 Jul 2017 19:02:53 -0700 (PDT)
In-Reply-To: <2421d5f3-12ee-833b-72d8-de627fbfe26c@scantech.fr>
References: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr> <3ccfa2fb49d471f807d77d9a280e4b7cfe56faea.1500304209.git.worldhello.net@gmail.com>
 <xmqq7ez7htvj.fsf@gitster.mtv.corp.google.com> <CANYiYbEcMrriaor9OT4c2qtfh9Ja5NJ9KBSxa3XhPAuoN0t42A@mail.gmail.com>
 <xmqq60epfy27.fsf@gitster.mtv.corp.google.com> <CANYiYbFROuyXso2ZKuJWDp4cSwpBu=bNAbC-yZtEyDwkbUcAhQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1707191456010.4193@virtualbox> <xmqq8tjkm3ly.fsf@gitster.mtv.corp.google.com>
 <xmqqo9sfkm32.fsf@gitster.mtv.corp.google.com> <CANYiYbGSaaFOq7iw=ON1Oo87bSA96o=zyzym5RDT32kMae7bsw@mail.gmail.com>
 <xmqqvamlfm6s.fsf@gitster.mtv.corp.google.com> <CANYiYbF+XDANNbpZJ-jL7y81QhggW_snBuWeONSCUc4CPn2zMw@mail.gmail.com>
 <xmqqr2x9fjpi.fsf@gitster.mtv.corp.google.com> <CANYiYbGkuGNNYn4OF5w=1+Pqn9hEHWcD+DYVB6AXRs0vFEsY2Q@mail.gmail.com>
 <2421d5f3-12ee-833b-72d8-de627fbfe26c@scantech.fr>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 24 Jul 2017 10:02:53 +0800
Message-ID: <CANYiYbHi2tbRj159LgLpNRb7esMwZWOjetShF2n51rBavGYsGQ@mail.gmail.com>
Subject: Re: [PATCH] PRItime: wrap PRItime for better l10n compatibility
To:     =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jean-noel.avila@scantech.fr>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-07-23 10:33 GMT+08:00 Jean-No=C3=ABl AVILA <jean-noel.avila@scantech.f=
r>:
> Plus, I hope that some day, instead of translators finding afterwards
> that a change broke i18n capabilities, developpers would have some kind
> of sanity check. Requiring special versions of i18n tooling stops this ho=
pe.
>

It would be fun to create some tools to help l10n guys finding l10n
changes on every git commit.


--=20
Jiang Xin
