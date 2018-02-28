Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 196B71F404
	for <e@80x24.org>; Wed, 28 Feb 2018 21:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935033AbeB1VeY (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 16:34:24 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:41198 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932597AbeB1VeX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 16:34:23 -0500
Received: by mail-pg0-f43.google.com with SMTP id q27so1449835pgn.8
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 13:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Yu420sJ4hWVh3l0M4/SzlrillrDD7k+tbTv8IvJXNOk=;
        b=g1i2n0E1D95rbPnbFkw4vgDymCqqT8cF1HiVwJb08OL9Zp5kgdj+mgVb6qkAG9qSeU
         3iCqJyd9CDHGNWvEbwc7FXaSDda0GmwcOOAA3/g2ngzcTkf9mdM6D0LcIlLz44oDgxfJ
         Y7gBjSr0nN1bNdWbs/ogvjyVWsvUbSkOSpGEm9pDMa+xI2q9mycLfj/2PyrI9kkY0Uf9
         82IcHcGc1XRRPB5qmmorGMutq9Fpzdo+sktOFd94JdIYCrxmdT6P5xd+9AUj2UIOj839
         YEaE+TJFVEB/8FGWKjWqdqw4sz34EcLBRHszZXcZhESGYHpBtV5cZQVR8FUhydquZnWN
         4D6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Yu420sJ4hWVh3l0M4/SzlrillrDD7k+tbTv8IvJXNOk=;
        b=mTfPAXDU1u6Lpzr7Uqe6x/ppZttrU4mOWMrs/86+rUzbo/WLP5XYXuzVHdksD27Jke
         dRFNCFm77GgAGPjNMu/PY6WKAIkjNh2PhxUs96LynEpXBg4b4Et/b+7y7h49hf/UlK1h
         M6eec4iJo5EGXx2IcSdRzXTtRitBbV6dtDOwtN5cerT0TKbUkGiXNudsHvGnF7fLjTaz
         eHJj18X6qThkiMkwsgJDynaB+uoqv889aH31iuc27ABCkg9kvU2kAe9mjxE168wM7hoh
         kh1NJ2thoYqrT6rk6RwmhDFO5kgxWsGJY8KENwriFwDSbqz5d5ORm2u5JA0CTbvSt26k
         RY2w==
X-Gm-Message-State: APf1xPDxMITEDUNLriIkbCvJBowFAUjTHBxPdJnn6Rt0UuvXYWVCZnR3
        Os3n29RXIYAXwNw8deoCqrcX43qa
X-Google-Smtp-Source: AG47ELsMGFMTZXZwRnW2VUj7YNEcO2YcmbEAa+NC6q9EGHlrP4DJc8SPUSwHDyuGEpJHkYnaFxsBsA==
X-Received: by 10.101.67.137 with SMTP id m9mr5563209pgp.301.1519853662811;
        Wed, 28 Feb 2018 13:34:22 -0800 (PST)
Received: from shfh2bkyy1.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id a138sm5438641pfd.47.2018.02.28.13.34.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Feb 2018 13:34:21 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v8 3/7] utf8: add function to detect prohibited UTF-16/32 BOM
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAPig+cSh6YVK_KbinEv+1fwU1Wo4BErfYBZ76KKdhu9dM1D5Dg@mail.gmail.com>
Date:   Wed, 28 Feb 2018 22:34:17 +0100
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DF6F3855-EFE7-4C13-AA53-819AAE0DEF7A@gmail.com>
References: <20180224162801.98860-1-lars.schneider@autodesk.com> <20180224162801.98860-4-lars.schneider@autodesk.com> <CAPig+cQdoicxSMLRbdCfFGXyXLirbRLVJi2QahCSe1ZesVOKBg@mail.gmail.com> <392C5E11-A3CA-4D65-B9D4-9EE30258C83A@gmail.com> <CAPig+cSh6YVK_KbinEv+1fwU1Wo4BErfYBZ76KKdhu9dM1D5Dg@mail.gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 27 Feb 2018, at 06:17, Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>=20
> On Sun, Feb 25, 2018 at 6:35 AM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>>> On 25 Feb 2018, at 04:41, Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>>> Is this interpretation correct? When I read [1], I interpret it as
>>> saying that no BOM _of any sort_ should be present when the encoding
>>> is declared as one of UTF-16BE, UTF-16LE, UTF-32BE, or UTF-32LE.
>>=20
>> Correct!
>>=20
>>> This code, on the other hand, only checks for BOMs corresponding
>>> to the declared size (16 or 32 bits).
>>=20
>> Hmm. Interesting thought. You are saying that my code won't complain =
if
>> a document declared as UTF-16LE has a UTF32-LE BOM, correct?
>=20
> Well, not specifically that case since UTF-16LE BOM is a subset of =
UTF32-LE BOM.

Correct - bad example on my part!


> My observation was more general in that [1] seems to say that there
> should be _no_ BOM whatsoever if one of UTF-16BE, UTF-16LE, UTF-32BE,
> or UTF-32LE is declared.

You are saying that a document declared as UTF-16LE must not start=20
with 0000feff (UTF-32BE BOM)? I interpreted that situation as a "feff"
in the middle of a file and therefore the BOM should be treated as
ZWNBSP as explained here: http://unicode.org/faq/utf_bom.html#bom6

Plus, if "_no_ BOM whatsoever" is allowed then wouldn't we need to check
for UTF-1, UTF-7, and UTF-8 BOM's too?

I dunno.


>> I would say
>> this is correct behavior in context of this function. This function =
assumes
>> that the document is proper UTF-16/UTF-16BE/UTF-16LE but it is =
wrongly
>> declared with respect to its BOM in the .gitattributes. Would this
>> comment make it more clear to you?
>>        /*
>>         * If a data stream is declared as UTF-16BE or UTF-16LE, then =
a UTF-16
>>         * BOM must not be used [1]. The same applies for the UTF-32 =
equivalents.
>>         * The function returns true if this rule is violated.
>>         *
>>         * [1] http://unicode.org/faq/utf_bom.html#bom10
>>         */
>> I think what you are referring to is a different class of error and
>> would therefore warrant its own checker function. Would you agree?
>=20
> I don't understand to what different class of error you refer. The
> FAQ[1] seems pretty clear to me in that if one of those declarations
> is used explicitly, then there should be _no_ BOM, period. It doesn't
> say anything about allowing a BOM for a differently-sized encoding (16
> vs 32).
>=20
> If I squint very hard, I _guess_ I can see how you interpret [1] with
> the more narrow meaning of the restriction applying only to a BOM of
> the same size as the declared encoding, though reading it that way
> doesn't come easily to me.

For me it is somewhat the other way around :-)
Since I am not sure what is right, I decided to ask the Internet:
=
https://stackoverflow.com/questions/49038872/is-a-utf-32be-bom-valid-in-an=
-utf-16le-declared-data-stream

Let's see if someone has a good answer.

- Lars

