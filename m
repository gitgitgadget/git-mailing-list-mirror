Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F4C11F576
	for <e@80x24.org>; Sun, 25 Feb 2018 11:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbeBYLfl (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 06:35:41 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:37377 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbeBYLfk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 06:35:40 -0500
Received: by mail-pg0-f44.google.com with SMTP id y26so5131836pgv.4
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 03:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+4DbjDP/wVrKSgsSpUCcOp4Ibz6yOQ3+X5DiOWrkWio=;
        b=XaFhy6dmTl5SDaxz5C0eW/R4Ryey0AIGRS5PSb6GN7w5yrm/dka2eUEzAGelw7Mts8
         PpLqPtEy5jR5MVZePUa1x+w5QwkFdky5rUMyQ1cpFW8Ct9eTtsO0Jqrp06vRL51P58OW
         OZEFQMR4QoVL1ifYOK8exGz7qp+v8OArnrWhKHSQoiG5iFvXY4677fLJUtXMMVeTAmXj
         Psdjb4uElsbbJ03e7ru2Up528b97kheAtVtRgPD7FB6VUT8Gqp7LKcvID6dRjM9DkG8U
         DaRRXQkUVySc55UBbA2Uu142XKvQiZ1b9xZFLY3NOXyk3suF1EUgcvJD/cXWBj4wRE6D
         GcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+4DbjDP/wVrKSgsSpUCcOp4Ibz6yOQ3+X5DiOWrkWio=;
        b=EUlK28DwtdWBbFJKCIx/lAkyeg2uzYb0OZViBaMzBjcTHFFsIXAANnN+JLxk0xM0ya
         YTTpALJKvZ+biD4MiFQgFF/g45Z99E6cz49DgBdCwMYJDLZMxqlig9qDJZNtdoQgryTq
         115HGYXHXpggsMKzOI/qGC4IiMosLeehEqrHGLMoCXfvTn4HY+JPoiXreFdydROBPtdp
         d23T5O1mvN5JgsBIn7ab8reNH8/QwJLO+DG0QJnf3NgV32nVvWcQEVnNEVm435W9A6om
         wZMxeIdXUzlWmGi6yCsdiSM3POGY/RKASvH8sdpW9PZMb+W8HLd8frMaxjw1qolPFMR9
         jMJg==
X-Gm-Message-State: APf1xPBjY14yG0ForfYX2Odh/Ql5L31EtRPjtZ/kuSvaoR2A572E1Iwb
        eqVv7H5AgBBVzLf9cqhgQmA=
X-Google-Smtp-Source: AH8x226WZO1cstFlxnymoPse5E+Z4nj9s3WCn19HP4Db5VtkCfRzlNu0K9aWwVKlzkqFGvVQuG6DEA==
X-Received: by 10.99.182.76 with SMTP id v12mr5770432pgt.158.1519558539407;
        Sun, 25 Feb 2018 03:35:39 -0800 (PST)
Received: from [10.32.248.206] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id c1sm13513849pfa.126.2018.02.25.03.35.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 25 Feb 2018 03:35:38 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v8 3/7] utf8: add function to detect prohibited UTF-16/32 BOM
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAPig+cQdoicxSMLRbdCfFGXyXLirbRLVJi2QahCSe1ZesVOKBg@mail.gmail.com>
Date:   Sun, 25 Feb 2018 12:35:35 +0100
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <392C5E11-A3CA-4D65-B9D4-9EE30258C83A@gmail.com>
References: <20180224162801.98860-1-lars.schneider@autodesk.com> <20180224162801.98860-4-lars.schneider@autodesk.com> <CAPig+cQdoicxSMLRbdCfFGXyXLirbRLVJi2QahCSe1ZesVOKBg@mail.gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 25 Feb 2018, at 04:41, Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>=20
> On Sat, Feb 24, 2018 at 11:27 AM,  <lars.schneider@autodesk.com> =
wrote:
>> Whenever a data stream is declared to be UTF-16BE, UTF-16LE, UTF-32BE
>> or UTF-32LE a BOM must not be used [1]. The function returns true if
>> this is the case.
>>=20
>> [1] http://unicode.org/faq/utf_bom.html#bom10
>>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> diff --git a/utf8.c b/utf8.c
>> @@ -538,6 +538,30 @@ char *reencode_string_len(const char *in, int =
insz,
>> +int has_prohibited_utf_bom(const char *enc, const char *data, size_t =
len)
>> +{
>> +       return (
>> +         (!strcmp(enc, "UTF-16BE") || !strcmp(enc, "UTF-16LE")) &&
>> +         (has_bom_prefix(data, len, utf16_be_bom, =
sizeof(utf16_be_bom)) ||
>> +          has_bom_prefix(data, len, utf16_le_bom, =
sizeof(utf16_le_bom)))
>> +       ) || (
>> +         (!strcmp(enc, "UTF-32BE") || !strcmp(enc, "UTF-32LE")) &&
>> +         (has_bom_prefix(data, len, utf32_be_bom, =
sizeof(utf32_be_bom)) ||
>> +          has_bom_prefix(data, len, utf32_le_bom, =
sizeof(utf32_le_bom)))
>> +       );
>> +}
>=20
> Is this interpretation correct? When I read [1], I interpret it as
> saying that no BOM _of any sort_ should be present when the encoding
> is declared as one of UTF-16BE, UTF-16LE, UTF-32BE, or UTF-32LE.

Correct!

> This
> code, on the other hand, only checks for BOMs corresponding to the
> declared size (16 or 32 bits).

Hmm. Interesting thought. You are saying that my code won't complain if
a document declared as UTF-16LE has a UTF32-LE BOM, correct? I would say
this is correct behavior in context of this function. This function =
assumes
that the document is proper UTF-16/UTF-16BE/UTF-16LE but it is wrongly
declared with respect to its BOM in the .gitattributes. Would this
comment make it more clear to you?

	/*
	 * If a data stream is declared as UTF-16BE or UTF-16LE, then a =
UTF-16
	 * BOM must not be used [1]. The same applies for the UTF-32 =
equivalents.
	 * The function returns true if this rule is violated.
	 *
	 * [1] http://unicode.org/faq/utf_bom.html#bom10
	 */


I think what you are referring to is a different class of error and
would therefore warrant its own checker function. Would you agree?


> I suppose the intention of [1] is to detect a mismatch between the
> declared encoding and how the stream is actually encoded. The check
> implemented here will fail to detect a mismatch between, say, declared
> encoding UTF-16BE and actual encoding UTF-32BE.

As stated above the intention is to detect wrong BOMs! I think we cannot=20=

detect the "declared as UTF-16BE but actually UTF-32BE" error.

Consider this:

printf "test" | iconv -f UTF-8 -t UTF-32BE | iconv -f UTF-16BE -t UTF-8 =
| od -c
0000000   \0   t  \0   e  \0   s  \0   t
0000010

In the first step we "encode" the string to UTF-32BE and then we =
"decode" it as
UTF-16BE. The result is valid although not correct. Does this make =
sense?

Thanks,
Lars


