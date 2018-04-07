Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94EC51F42D
	for <e@80x24.org>; Sat,  7 Apr 2018 17:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752034AbeDGRDq (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 13:03:46 -0400
Received: from mail-ot0-f182.google.com ([74.125.82.182]:42717 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751975AbeDGRDp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 13:03:45 -0400
Received: by mail-ot0-f182.google.com with SMTP id h55-v6so4434019ote.9
        for <git@vger.kernel.org>; Sat, 07 Apr 2018 10:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eHzOopW5bYllHV3gSn/+OxzB4ZYwLU0rcYDNB841p7k=;
        b=HWQRSLMn4bLJHp7XgxhCHeWQoCUeEY7k+w2Qk5AajjEC8UEm0jREK6sIXBly1mAlP5
         pmcGKOAz0xDwpAOl9FI3xvTYje8or7U8DYVz39IiV+FLeYOZ/4ECsNBOERpKOPHTccET
         shSAYoIvQzBiq7PP7DIOmD4NL/6/mQFxBEtcFffiMUI1P5jYRgzO3hLo27cH9eJgjI/+
         pviLFXEpxrq6AbvoLXaFcIYZbWk9KK/OIZt0rOLh5xJRHHf6Ij9vnHpl3UrlVukM/o01
         UZDNc6XTrWqwXDcGwUgbDPyrEz75UvY4vOPHzF/k218crBJPony70f0jOObMm0jCGGSi
         AVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eHzOopW5bYllHV3gSn/+OxzB4ZYwLU0rcYDNB841p7k=;
        b=pfa0+O73IDNe5W5ymx3UyyuXzYNFh2o2yWpacYWIbt5KDGKQr41FfegxfPSs0o1ldk
         M5TvmiOjBnRhbXyMhm+4id+bCi8ci4IKzk50CqN7fFXo/Y0bj5d7ghSvAeVvDarn56eC
         S8bdn9F35IljhRgoQA+FosZrFlK0XcsvCq+aEmST61VJ1GfST1SmhIGusw1/ko09pXGa
         i/7WABosKI0krBDUXUAwPwvtq+3k9mhCjQWoaSHbK/CK91BZjG3MdDd8b1DytKzGyzJp
         CZmE1fPb9fb7nmPLk637YKogO8rTdc6dmM4yrZZHu7D6MhCB5g2I1rait9vfxM1i8eo6
         v4bA==
X-Gm-Message-State: ALQs6tB51WmsBQSC8CkLPkCy4qxWF+wKZtP4KdGVNIGqfgcF1RqqtxSg
        xerQvX8l3EOM54QJ/GZpJGicLu8IB+yiDsAN6EM=
X-Google-Smtp-Source: AIpwx4+afzcabstv5pC9njYRJ30V+tmfCZGbOmt3YD3BpqSj3KTjhglnkMYEL9RicIx8zOjMyAjDfPNekqbLTXSb8Uw=
X-Received: by 2002:a9d:5e05:: with SMTP id d5-v6mr3002553oti.173.1523120625064;
 Sat, 07 Apr 2018 10:03:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Sat, 7 Apr 2018 10:03:14 -0700 (PDT)
In-Reply-To: <87r2nryz0j.fsf@evledraar.gmail.com>
References: <20180329150322.10722-1-pclouds@gmail.com> <20180331164009.2264-1-avarab@gmail.com>
 <CACsJy8CyB0igY365NMkswSgAi9_rf+XBOMQyJ7XW6iQxQiCEyQ@mail.gmail.com>
 <87woxove8d.fsf@evledraar.gmail.com> <20180403151700.GA24602@duynguyen.home>
 <20180406214236.GF7870@sigill.intra.peff.net> <CACsJy8BOVnu+HXcVbkTKW6YZ8vQnwbAcaF4d2CzUbQLrZjuOJg@mail.gmail.com>
 <87r2nryz0j.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 7 Apr 2018 19:03:14 +0200
Message-ID: <CACsJy8BNmKTweFiUgDtSfor7OYk1akzcPbLxadA7YfSZ56eCJQ@mail.gmail.com>
Subject: Re: [PATCH 4/3] Makefile: untangle DEVELOPER and -Werror
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        ric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 7, 2018 at 2:36 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Anyway, I see you've pushed a new version with DEVOPTS. I'll submit mine
> on top of that once your new version lands (unless you want to try to
> integrate it yourself).

Actually I think I'll just drop both EAGER_DEVELOPER and DEVOTPS.
--=20
Duy
