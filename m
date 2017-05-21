Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BB94201CF
	for <e@80x24.org>; Sun, 21 May 2017 20:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756921AbdEUU0D (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 May 2017 16:26:03 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38311 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756855AbdEUU0C (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 May 2017 16:26:02 -0400
Received: by mail-wm0-f54.google.com with SMTP id e127so13231569wmg.1
        for <git@vger.kernel.org>; Sun, 21 May 2017 13:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hmNjV3vpJHv6CElFk86LqyYPQKEO9lGPsP6+iiWycJ0=;
        b=h99LgLPJjCfN/GWdAYcXA39Uxd25QqxM9+pxmfBr9WaXrjPakML5Rj1XoST4GLBmRC
         2IIqrA4hsChZt4yatMvX/B3DWS/y4R8ZadT5090qL6Kkg6N4uJxt/MocC4cd+xDGruW7
         jIq4cV/gdRCLjefj2KCKfi+IWWIZlzSTodFwFQmX30ATjRlOQ0Wmx4Ziji7lnEuHgQBe
         gudL6eEBxkG+fM8R/KswtxT9Wk5PexK17D7qLc8+brFo6+D+kdV8RhZ1iNQEgy1qwyu5
         nKwxrtZpSaxtNNIxJbBQLOiL5H59Giwnd08jfBa1oQU+JI7xmxT1fDekal+ai4xaRqdb
         8xEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=hmNjV3vpJHv6CElFk86LqyYPQKEO9lGPsP6+iiWycJ0=;
        b=IpRV+dsZBP55nN/G4QE2FhLt/KztzzxxGvqRijAVxfzygBTDwZrfRfn6SvmtFNlaBz
         KnpYmF285z8ye8PHgHEXjJDjB0nAduW5RYL5EaJG2J05xqwdNh7il09jCBPaT3AxZeqe
         UfItSk+aEiqAcERBo5DvafniASMkF2cKXrQnt4EJ6tLK5Ep80Z8rNLLIvFcf2klqwSqk
         3suDYXu8FvDP66ggPyLBv1yZj1dGmu5hGg42UhJYARmQ3HYwyFUuNWha2GLI0PRYCZWm
         ZZ3Ok9fuPBVNXxohzeFr9inN9Zr6SLz8qZ5Sqk30K9OdGh3TqyFwNIhtY3Ig7RLtV2GY
         W+7w==
X-Gm-Message-State: AODbwcAQrggDig3/sN/WLTRWY8Nm5rGkzUtpL4ll1NPMdMiyMbSGIZe/
        yeIhu3saihYu0g==
X-Received: by 10.223.143.13 with SMTP id p13mr9315334wrb.3.1495398360886;
        Sun, 21 May 2017 13:26:00 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4043.dip0.t-ipconnect.de. [93.219.64.67])
        by smtp.gmail.com with ESMTPSA id v7sm11232392wme.5.2017.05.21.13.25.59
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 May 2017 13:25:59 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 4/4] convert: add "status=delayed" to filter process protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <48d9e7f0-15bf-ce0e-aae8-4c3ebd5c07cf@web.de>
Date:   Sun, 21 May 2017 22:25:58 +0200
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net, e@80x24.org,
        ttaylorr@github.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <7D282F93-6131-4A1E-BCFD-62EA9DDD7F9F@gmail.com>
References: <20170409191107.20547-1-larsxschneider@gmail.com> <20170409191107.20547-5-larsxschneider@gmail.com> <a7fd3bef-49b2-0b0a-8ca4-89e41a402661@web.de> <388C3F2A-AC77-499F-9C74-216F5DC00FD8@gmail.com> <106c2be9-c558-edcc-2d97-5091c15010d1@web.de> <638E6914-6B66-4C66-996F-F04A285A2129@gmail.com> <48d9e7f0-15bf-ce0e-aae8-4c3ebd5c07cf@web.de>
To:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 19 Apr 2017, at 20:55, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
>=20
>=20
>>> (Back to the roots)
>>> Which criteria do you have in mind: When should a filter process the =
blob
>>> and return it immediately, and when would it respond "delayed" ?
>>=20
>> See above: it's up to the filter. In case of Git LFS: delay if a =
network call is required.
>>=20
> That make sense.
> I try to understand the big picture, and from here try to review
> the details.
> Does it make sense to mention "git lfs" in the commit message,
> and/or add some test code ?

I'll mention Git LFS in the commit message. The test code =
(t/t0021/rot13-filter.pl)
should mimic the behavior of Git LFS already.

Thanks,
Lars=
