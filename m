Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0D751F404
	for <e@80x24.org>; Tue,  6 Mar 2018 22:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754228AbeCFWjW (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 17:39:22 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39162 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754209AbeCFWjW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 17:39:22 -0500
Received: by mail-pg0-f68.google.com with SMTP id e3so111775pga.6
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 14:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aesyozrVGZW7yzaFyAUhU98NxK6tie0WIUV5WkcyAYk=;
        b=G7+nkpYvpxfNsRWMXpFMiqmWeu1dZCcTfAfQ/vFWTJQ0/f5D3e0Sa0h+xaB5gaXOqt
         SW4kGSxf/y6vn2jGwjhOi5/lksnV/YkMcoQnsdyMEoppSmdcEV7ASatoDVBPqbCo0R4f
         EsQEjbWItxp2Ri60BOoqSzosBV5jduVaCtktdKMR5Hgnlfy3NMCku3ltipyuj6TGMP53
         Nx4VR8gZHZZIQXfLiP7Gq2mX7rP/SWazjqxZCBZL6gXrFvZYWGrlLbD9y2eu5soX7bPC
         +AlTrqk+qPJnmrpgJ3kYsO5FE1WMnhOCZkIGnrRS2ZyDCr3ujwfTuVCItH8KJEKmBSaN
         kyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aesyozrVGZW7yzaFyAUhU98NxK6tie0WIUV5WkcyAYk=;
        b=LdW/uvhqTvAuJObWc1WpizPb+ZsHFZ6nsjoUnevJgRKqhHO8gKtm8pW3e/W6k2t4YK
         G784/ho8LDGZipcFDEyEQiVlNlu2BdOVwzoAhpuUVbQWC9IejZhuHN/AOCag503HI8GR
         y5Eum8NsvAWNZKNjwGj7BeF17LD1ccVreYfINu4Y37RYm0fseJfyhH5eRpqV55VX9jV/
         FzuudMTwaAj5DL3bnhNZ8G8WtZYhpH59GpeIBHdwyM8d5s0/DQuEaNvtnWYk75RHn4g0
         zhObQKVCHAGsSMfAis7rW8k4iwLnVh7jRR5ClThSYKgNsEXSOtEkxeaoALCwB7XQ11ZC
         v7Kw==
X-Gm-Message-State: APf1xPAPyZXbMoQHxrv7kV6lFrtXdkXMHa1Mznr6ctpY4mZFr0A/SueV
        t1Dx0k+pgfSmGiqok6o1IbG6x6Zf
X-Google-Smtp-Source: AG47ELsv27k0u/z7w4WG8qWkr5X1oHYeLurG1CsGd1rhDX+/uRtS3UvG76b6JSMal6F+XdAjIRoRjw==
X-Received: by 10.98.237.12 with SMTP id u12mr20265851pfh.72.1520375961693;
        Tue, 06 Mar 2018 14:39:21 -0800 (PST)
Received: from neu8r3hm32.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id n26sm2012140pfk.94.2018.03.06.14.39.18
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Mar 2018 14:39:21 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v9 4/8] utf8: add function to detect a missing UTF-16/32 BOM
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqvae92ajv.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 6 Mar 2018 23:39:16 +0100
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org, tboegi@web.de,
        j6t@kdbg.org, sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <0DCED348-C6DB-49B2-8C0A-E4E1F485B255@gmail.com>
References: <20180304201418.60958-1-lars.schneider@autodesk.com> <20180304201418.60958-5-lars.schneider@autodesk.com> <xmqqvae92ajv.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 06 Mar 2018, at 21:50, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> lars.schneider@autodesk.com writes:
>=20
>> +int is_missing_required_utf_bom(const char *enc, const char *data, =
size_t len)
>> +{
>> +	return (
>> +	   !strcmp(enc, "UTF-16") &&
>> +	   !(has_bom_prefix(data, len, utf16_be_bom, =
sizeof(utf16_be_bom)) ||
>> +	     has_bom_prefix(data, len, utf16_le_bom, =
sizeof(utf16_le_bom)))
>> +	) || (
>> +	   !strcmp(enc, "UTF-32") &&
>> +	   !(has_bom_prefix(data, len, utf32_be_bom, =
sizeof(utf32_be_bom)) ||
>> +	     has_bom_prefix(data, len, utf32_le_bom, =
sizeof(utf32_le_bom)))
>> +	);
>> +}
>=20
> These strcmp() calls seem inconsistent with the principle embodied
> by utf8.c::fallback_encoding(), i.e. "be lenient to what we accept",
> and make the interface uneven. I am wondering if we also want to
> complain when the user gave us "utf16" and there is no byte order
> mark in the contents, for example?

Well, if I use stricmp() then I don't need to call and cleanup
xstrdup_toupper() as discussed with Eric [1]. Is there a case
insensitive starts_with() method?

[1] =
https://public-inbox.org/git/CAPig+cQE0pKs-AMvh4GndyCXBMnx=3D70jPpDM6K4jJT=
e-74FecQ@mail.gmail.com/


>  Also "UTF16" or other spelling
> the platform may support but this code fails to recognise will go
> unchecked.

That is true. However, I would assume all iconv implementations use the
same encoding names for UTF encodings, no? That means UTF16 would never =
be
valid. Would you agree?

- Lars=
