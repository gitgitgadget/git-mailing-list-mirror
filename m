Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE52E1F403
	for <e@80x24.org>; Sun, 17 Jun 2018 17:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753832AbeFQRcx (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Jun 2018 13:32:53 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41792 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeFQRcw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jun 2018 13:32:52 -0400
Received: by mail-pg0-f66.google.com with SMTP id l65-v6so6476207pgl.8
        for <git@vger.kernel.org>; Sun, 17 Jun 2018 10:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=Q5dJNT/8mpJnk36pw9YHP1afSrGMrpZBUonBQ12opEw=;
        b=uYUx3bSvvSHl5RICfhCM+BTtttf/mzxwUXlkltxVK0ppwIu4G6QVLxnkw4nhwkAtjZ
         ONSSFKK7jYli1UC12c/jcNaYXhYPj+Zf8WbUYH4gNmclC46/LfnMpQ8U7TGY1shNIP+K
         2nOQs4ucZwks709KfBHba7WBdaFmQV57dQnvTiLmZPVx8fY5FndYKn4ka2dxxVmxiv4/
         rDk9EfsqiAvfT+cI+TsKYF1w/A/wlOd/YHldYyP96Q9H5AAenQ3eFqgUng9i/gTjCjDj
         uxJ/QTUD3A2HciZz4O/6WObThWa/X4cir8lic6Wu+vRxnGe2DfzTieVZTTMr0TbZAcMS
         NZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=Q5dJNT/8mpJnk36pw9YHP1afSrGMrpZBUonBQ12opEw=;
        b=KwsQw/ImTKvj9m9vF8aRpo5QryXLSarv5XZB3p+oNXRnUmQ36NYDh/Tz42C4QyYbh9
         /wn0DTLTlbppwDIFx0lPiUt30gyrjDTJI8aSqmcGcLnmlkTYhZmsUdRbt/e97hrmtPnX
         RNNMQPxCljhI3s2SRVuRYXuTPSVR0X5puG0SJ46dlzm9sxwQWZrMoDL92U7RQczFHheN
         6f1eeSDb9qhfLZriCJRq/xV3MoJYJ7gOz17j/POvj49vuRx7HF30dn1DSvFTg9Mp2VU/
         FhMGRkwAgZoMlxAWf3kT9pKzoiwm3Gv2w8g/aNskzf6YGfCOR95pkgdEKqscXMsuzlE7
         dDSg==
X-Gm-Message-State: APt69E2DpCqw1ZcT8dvigSbgROZte2M4NZze86Y1zmmbZ/alxfmRmWIF
        xqskSxJQbgNcYEZHoGhLLgE=
X-Google-Smtp-Source: ADUXVKJVOr/gNuBF8wSR5aQotp5+L1MozNO4JjB8k3S0wgtSa3d1J+q02VjDWbw4gPVtFe5nWwMUbA==
X-Received: by 2002:aa7:84cf:: with SMTP id x15-v6mr10300449pfn.220.1529256771850;
        Sun, 17 Jun 2018 10:32:51 -0700 (PDT)
Received: from [192.168.206.102] ([117.209.147.247])
        by smtp.gmail.com with ESMTPSA id x8-v6sm26003259pfa.87.2018.06.17.10.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jun 2018 10:32:50 -0700 (PDT)
Subject: Re: [PATCH] Makefile: make NO_ICONV really mean "no iconv"
To:     Eric Sunshine <sunshine@sunshineco.com>, simon@ruderich.org
Cc:     Git List <git@vger.kernel.org>,
        Mahmoud Al-Qudsi <mqudsi@neosmart.net>
References: <CACcTrKePbgyCbXneN5NZ+cS-tiDyYe_dkdwttXpP0CUeEicvHw@mail.gmail.com>
 <20180615022503.34111-1-sunshine@sunshineco.com>
 <20180615065805.GA15146@ruderich.org>
 <CAPig+cQL8rTg+GASp2tSng7PPPYkfeeV2SNyi0D+6-Ep7JKaGg@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kaartic.sivaraam@gmail.com; prefer-encrypt=mutual; keydata=
 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
 IZ7P/DJ/
Message-ID: <a079d636-e70d-f383-ae87-ab890a636441@gmail.com>
Date:   Sun, 17 Jun 2018 23:02:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQL8rTg+GASp2tSng7PPPYkfeeV2SNyi0D+6-Ep7JKaGg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZZeKlixjgVnRn9EpPX1cPI6IOBCRCa3vD"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZZeKlixjgVnRn9EpPX1cPI6IOBCRCa3vD
Content-Type: multipart/mixed; boundary="wWcM6m73JtbEOJgA93TkRPhDevsn8kHhR";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>, simon@ruderich.org
Cc: Git List <git@vger.kernel.org>, Mahmoud Al-Qudsi <mqudsi@neosmart.net>
Message-ID: <a079d636-e70d-f383-ae87-ab890a636441@gmail.com>
Subject: Re: [PATCH] Makefile: make NO_ICONV really mean "no iconv"
References: <CACcTrKePbgyCbXneN5NZ+cS-tiDyYe_dkdwttXpP0CUeEicvHw@mail.gmail.com>
 <20180615022503.34111-1-sunshine@sunshineco.com>
 <20180615065805.GA15146@ruderich.org>
 <CAPig+cQL8rTg+GASp2tSng7PPPYkfeeV2SNyi0D+6-Ep7JKaGg@mail.gmail.com>
In-Reply-To: <CAPig+cQL8rTg+GASp2tSng7PPPYkfeeV2SNyi0D+6-Ep7JKaGg@mail.gmail.com>

--wWcM6m73JtbEOJgA93TkRPhDevsn8kHhR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Friday 15 June 2018 01:13 PM, Eric Sunshine wrote:
> On Fri, Jun 15, 2018 at 2:58 AM Simon Ruderich <simon@ruderich.org> wro=
te:
>> On Thu, Jun 14, 2018 at 10:25:03PM -0400, Eric Sunshine wrote:
>>> This patch is extra noisy due to the indentation change. Viewing it w=
ith
>>> "git diff -w" helps. An alternative to re-indenting would have been t=
o
>>> "undefine NEEDS_LIBICONV", however, 'undefine' was added to GNU make =
in
>>> 3.82 but MacOS is stuck on 3.81 (from 2006) so 'undefine' was avoided=
=2E
>>
>> Should we put the part about MacOS's make into the commit
>> message? Seems like relevant information for future readers.
>=20
> No. The bit of commentary mentioning MacOS's very old 'make' was just
> talking about a possible alternate way of implementing the change.
> That alternative was not chosen, so talking about old 'make' in the
> commit message would be confusing for readers.

Interesting. Documentation/SubmittinPatches reads:

    The body should provide a meaningful commit message, which:
    ...
    <snip>
    ...
    . alternate solutions considered but discarded, if any.

The consensus has changed, maybe? In which case, should we remove that
statement from there?


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


--wWcM6m73JtbEOJgA93TkRPhDevsn8kHhR--

--ZZeKlixjgVnRn9EpPX1cPI6IOBCRCa3vD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlsmmz4ACgkQveda2sPW
GWldzw/8DwfOV6zeuf6ES0vjx049kxHKsk4iF7ac3YvEJBVgRtE9NVLmd8pKMQ4X
D1cwyZQ9VrS6yX3AzLME6ypZE26/9obvUrGMYwDHEz6jylOs50Amzuxf4BCyagNX
RAgbkmJX2csnzlj+NAr4d7YqGKqFukyxzTqmEuqMGIo5KMWVCkUFIS1dljcfCqIW
qR9hq4mtpY121F8StDIaWKXWSU3KUOhYrzE0p7eyYhhXjbQG2O93sWzJDNm4G/Vf
fChsrPvoCMT4xz/jUR/xSR3glFzpDOTwDDc73HkfREmGhGb7cWWftVHHmzhCz7zh
C64sVdefNwSsn4i/CUpV0jWKnQysYWIZNZt2DU2WR0MQF/iJ5A/62EjvlF4yb1Mx
tA1a3BG/1b3Jroo114TfaoiocUQ01Q7DYO6DWj859objg47jdvNbj6Wd7ThYa0ie
p7OrsZIRjqIWyTVMlq6TQc874XL0ws4mnVNQvCkn15NTYtBcy0Jtnd12InJl7EdY
9+sbtrmx053+TwfpwIz9aMWoAoRI0NBXgPF0PO+4Nkf8Q+U2lJgcFqNnoW6mn5CO
gsgBJfG2s/NYijIYWcKparqlCVFypjrsHI3zv1sVM6XfWiSGm9S7bpg5M6/3eqym
GpxeTJGI7SYX1MCm2kORY9MXHxWnOXn7NaI2mhNsVnob43zq5Rw=
=rImu
-----END PGP SIGNATURE-----

--ZZeKlixjgVnRn9EpPX1cPI6IOBCRCa3vD--
