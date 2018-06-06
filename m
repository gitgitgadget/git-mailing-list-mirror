Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 881A31F403
	for <e@80x24.org>; Wed,  6 Jun 2018 18:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752778AbeFFSck (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 14:32:40 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33599 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752559AbeFFScj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 14:32:39 -0400
Received: by mail-pf0-f182.google.com with SMTP id b17-v6so3561928pfi.0
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 11:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=/bcPHZh8DUTK+D2O14xhy2QIrjG43L3nGbKp3bqX2gY=;
        b=DTSjIOmaWWvm5xHmIR/qkce+5yF6r1rcEcOKlZgLELtLI1yHLQ4qrWU32BplsK//Ms
         UV5EFxnLVpz7anhXKIGeOmhtnP2FlXWkfjdZpElT6uLNGpeutXXKHlUNbFOIc9OFNVTC
         IMkp5tnFqK8IuF4hJhbNtCRSPyGO4kXSZOArbsiWH9ccQ9z92UtvNzcwKSehKAZ2vqUf
         ZRr/3caC4hikDShhGCKNw2H48+UHZ+vzbp0x2UFcOovWJ+xV8dVrevbfoRmF6H7L2xl8
         dcyPfHKk79VexAhlmLWJC4y7UbdXJrk+5/H48gB3/FLm2NevnN7obMzb+NifglwpABLr
         zwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=/bcPHZh8DUTK+D2O14xhy2QIrjG43L3nGbKp3bqX2gY=;
        b=QkeqlcvxtcAbbL5H+4qRqv6HHWUV4TUSsaAp5wDrHHEa35FswdOqdLPAipjN2hyQpi
         oRNUcj2JJje996og69uk4HIXHCm+eB80lgZ0QRc9yt1hPgaW7ov8G4BgyglmqTbPVkkB
         2AvvOyzrQdGdgnHFX/6WmSc9r0R8VRrR/6hNgsPu1F3yVXDSIiefOHVd54JAfZN8l1Qn
         xIOaxLWdJUHMoyWYbhD/XF1uu63v/nJCfBGBRFgDFR6IhSTB2InEjon+UzC9t78y2bkP
         yvhAYr0uufwD9b9lVPVfXlgC5RHIUBLgrYAOPMKR4d5M0YF2JEoMJnPGxpIldAVbQ70F
         3PlA==
X-Gm-Message-State: APt69E2uS/zYM5mvRiiwo4+v6YP+IRFVmCS7nu0UCiFaqNvfihkuhBPi
        wlptXCyvE7AA9uSfnWSooieajI/0
X-Google-Smtp-Source: ADUXVKJz949DBtAaIsWQadbjgPT54nRThrmJDDr7cpIFRSAsIJczbishfbPCcVIeByTlXqv0fTXAQQ==
X-Received: by 2002:a63:7f4e:: with SMTP id p14-v6mr3435709pgn.27.1528309958911;
        Wed, 06 Jun 2018 11:32:38 -0700 (PDT)
Received: from [192.168.206.100] ([117.242.90.192])
        by smtp.gmail.com with ESMTPSA id a7-v6sm76129274pgc.68.2018.06.06.11.32.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 11:32:37 -0700 (PDT)
Subject: Re: BUG: submodule code prints '(null)'
To:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CACsJy8CNrQ-CKoJ+1NCR1rsO+v0ZNZ9CVAFsJpmcRWZY6HUtKw@mail.gmail.com>
Cc:     Stefan Beller <sbeller@google.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kaartic.sivaraam@gmail.com; prefer-encrypt=mutual; keydata=
 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
 IZ7P/DJ/
Message-ID: <91ba2ec1-ba0f-e7ff-6533-ee3e2aa7ddd4@gmail.com>
Date:   Thu, 7 Jun 2018 00:02:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8CNrQ-CKoJ+1NCR1rsO+v0ZNZ9CVAFsJpmcRWZY6HUtKw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jVxk7wuC6ORclLFwo0whdu0DKsdE4oYp2"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jVxk7wuC6ORclLFwo0whdu0DKsdE4oYp2
Content-Type: multipart/mixed; boundary="cGElOmSsv3W8N47Sawcjzz7Paf6vZ3Zgj";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>, Git Mailing List <git@vger.kernel.org>
Cc: Stefan Beller <sbeller@google.com>
Message-ID: <91ba2ec1-ba0f-e7ff-6533-ee3e2aa7ddd4@gmail.com>
Subject: Re: BUG: submodule code prints '(null)'
References: <CACsJy8CNrQ-CKoJ+1NCR1rsO+v0ZNZ9CVAFsJpmcRWZY6HUtKw@mail.gmail.com>
In-Reply-To: <CACsJy8CNrQ-CKoJ+1NCR1rsO+v0ZNZ9CVAFsJpmcRWZY6HUtKw@mail.gmail.com>

--cGElOmSsv3W8N47Sawcjzz7Paf6vZ3Zgj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Tuesday 05 June 2018 09:01 PM, Duy Nguyen wrote:
> I'll leave it to submodule people to fix this :)
>=20

I'm Ccing the only one I know to gain attention.


--=20
Sivaraam

QUOTE:

=E2=80=9CThe three principal virtues of a programmer are Laziness, Impati=
ence,
and Hubris.=E2=80=9D

	- Camel book

Sivaraam?

You possibly might have noticed that my signature recently changed from
'Kaartic' to 'Sivaraam' both of which are parts of my name. I find the
new signature to be better for several reasons one of which is that the
former signature has a lot of ambiguities in the place I live as it is a
common name (NOTE: it's not a common spelling, just a common name). So,
I switched signatures before it's too late.

That said, I won't mind you calling me 'Kaartic' if you like it [of
course ;-)]. You can always call me using either of the names.


KIND NOTE TO THE NATIVE ENGLISH SPEAKER:

As I'm not a native English speaker myself, there might be mistaeks in
my usage of English. I apologise for any mistakes that I make.

It would be "helpful" if you take the time to point out the mistakes.

It would be "super helpful" if you could provide suggestions about how
to correct those mistakes.

Thanks in advance!


--cGElOmSsv3W8N47Sawcjzz7Paf6vZ3Zgj--

--jVxk7wuC6ORclLFwo0whdu0DKsdE4oYp2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlsYKMEACgkQveda2sPW
GWlzURAAmPg4Iu8CJpKK8xY64ZsIFH8OwDIiZuvwTflSKxxlPJRoe14Il81RlGRx
NYdkTPcHiv6A/SNbHBMsCbreDGWFg/6lIpwYhYIoV7ZdOp0yU/RQ8lw9Z+6gcch7
0hhaB5fZ2tbXZ7c2Z7/8zI9tbl37Yn4MbC2+MZlE1gWgoVdT3NotvuSSB0xaK9Eq
SQtlpKiWrmWe2IIbEp5hzFkT8w20KaKA9zkjisRZQ9gJgPb/K1ZAWkY++lUPbSpL
Ue+DhTynq/TucZRoCMdxRmcjKvINLHwgK9Mo51CW6d6y4IgddinrFjd6j+ARrMw5
zFloEl+y3LTpb3OzXHBGyFvpeodIUpBL1Qj7cbUUGwUWmWh7dLyt6LPL9roU+295
4ih8ZUkxu90L5yjOGRTdGN5LFLzGGAipD7oZXslTI5q64IXPqbQZNBNdtqqPtoqx
nmAj8YBChVD/BjNMr5a2qWo4dMgV4RGnC8NzvHcNzJQ2/8nHVxdRt5IPjXklGg8w
b5FKs+9qxoC/lhU2njSdR3dPZP2o08FCRw+kSgcOY+EtAZOxk8VwHRVcwpbp8kaz
6NI7su+ki8P12e3Mnq6ceKH+Fe9qoBr0Qwh17yCu+UYz2fU+PdF4W5aKjindp/WC
f63SZOkJWEOpk4odsyO9TYpbqwy8qI0ApEPKtX8qDmoI7VoZiGg=
=KLQT
-----END PGP SIGNATURE-----

--jVxk7wuC6ORclLFwo0whdu0DKsdE4oYp2--
