Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBFA71F576
	for <e@80x24.org>; Sun, 25 Feb 2018 11:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751638AbeBYLlj (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 06:41:39 -0500
Received: from mail-pl0-f50.google.com ([209.85.160.50]:45338 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbeBYLli (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 06:41:38 -0500
Received: by mail-pl0-f50.google.com with SMTP id v9-v6so5639525plp.12
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 03:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=82gYkrfdwiu85BScfwqpMuMUEeJ594wo1Dlw+IaVHR8=;
        b=nLVm0LES8nfrpwZ3l2Jc8PXhPANwTP0p8jgJnjXPmH8hxxXlSd/rO+jHWSQhUKfx+/
         ZIXo84G0HFDgeXUS+Zmmf+B9mjxPMwm252nnHpijeWpsBng/1pziG0+UD1n+uQP8QQc4
         4E7XC/Tfz64heMjLXDzlm6houMZ5z4E6XcwfHnLZoHfDS41vOKETp9W5NxJKly7WHapT
         yC3GoG1+du/e/CI2EdMm4Q6fpr/rEYZSqJ+mxPgyRolnwAqn3qHP5ku7uGEkmCvwxPd7
         aqhwsbyjIgKLHVWGRzHeDuLACa1Iz6PddHHGO3La1KLZcu06NMAE7761NcQok+Zia0M9
         wkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=82gYkrfdwiu85BScfwqpMuMUEeJ594wo1Dlw+IaVHR8=;
        b=R/dl9VmrMC9yolv9n7IDSRLs8Icyhp4iIdPlaY8kcNbAZohFpL6ejVqMelbIx9DBZs
         BJuS5ffuWSpFweHBHCIyYQkp5HtaLR67P/mB7mpkEKC1+ydz1LylYb+3A37biIi0Hyj5
         p4zgaQ2+xsCxXz6hK3KIlTPmaSwBcKck3CtmlXxi3YJ1J2VeL3E0k+e1K7Hmb8o9x/GH
         3kWeaN5fARgNFf9A9QHFOYpedpF7oT3N40YJB7B7oTBc/bb9AWpRN4NkKnWky98MNOZs
         kaf/Wyv4nhVjE6WeW5RypvR+h0r32P90K2of//26vdWLSLB7VzCl2481F3XFWOW4g/hR
         it8A==
X-Gm-Message-State: APf1xPCjwOqM4sr+z8or9XQQDcTVaiLqfVxToUs/ju8FXmpDft9+IBFp
        OKpAE/wC1II0B3iGoV8Bumo=
X-Google-Smtp-Source: AG47ELs25zXCg1SxU3+uydlxMUXAW9IMYoRueKYQpeqFaAbqYb2sWLJ3ZG95DV7r3zoy6TPcMnbqLg==
X-Received: by 2002:a17:902:bd05:: with SMTP id p5-v6mr2420679pls.137.1519558898327;
        Sun, 25 Feb 2018 03:41:38 -0800 (PST)
Received: from [10.32.248.206] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id b5sm10346582pgc.13.2018.02.25.03.41.35
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 25 Feb 2018 03:41:37 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v8 4/7] utf8: add function to detect a missing UTF-16/32 BOM
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAPig+cSX9uLWi++3pOis+iPGqEbrAL5px70CB-aUjDVGYZqweA@mail.gmail.com>
Date:   Sun, 25 Feb 2018 12:41:34 +0100
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8EE59DC3-69E0-412B-AC50-5D348D6D5BE0@gmail.com>
References: <20180224162801.98860-1-lars.schneider@autodesk.com> <20180224162801.98860-5-lars.schneider@autodesk.com> <CAPig+cSX9uLWi++3pOis+iPGqEbrAL5px70CB-aUjDVGYZqweA@mail.gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 25 Feb 2018, at 04:52, Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>=20
> On Sat, Feb 24, 2018 at 11:27 AM,  <lars.schneider@autodesk.com> =
wrote:
>> If the endianness is not defined in the encoding name, then let's
>> be strict and require a BOM to avoid any encoding confusion. The
>> is_missing_required_utf_bom() function returns true if a required BOM
>> is missing.
>>=20
>> The Unicode standard instructs to assume big-endian if there in no =
BOM
>> for UTF-16/32 [1][2]. However, the W3C/WHATWG encoding standard used
>> in HTML5 recommends to assume little-endian to "deal with deployed
>> content" [3]. Strictly requiring a BOM seems to be the safest option
>> for content in Git.
>>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> diff --git a/utf8.h b/utf8.h
>> @@ -79,4 +79,20 @@ void strbuf_utf8_align(struct strbuf *buf, =
align_type position, unsigned int wid
>> +/*
>> + * If the endianness is not defined in the encoding name, then we
>> + * require a BOM. The function returns true if a required BOM is =
missing.
>> + *
>> + * The Unicode standard instructs to assume big-endian if there
>> + * in no BOM for UTF-16/32 [1][2]. However, the W3C/WHATWG
>> + * encoding standard used in HTML5 recommends to assume
>> + * little-endian to "deal with deployed content" [3].
>=20
> Perhaps you could tack on to the comment here the final bit of
> explanation from the commit message which ties these conflicting
> recommendations together. In particular:
>=20
>    Therefore, strictly requiring a BOM seems to be the
>    safest option for content in Git.

Agreed. I'll change it.

Thanks,
Lars=
