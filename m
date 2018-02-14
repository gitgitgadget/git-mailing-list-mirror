Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85FF91F404
	for <e@80x24.org>; Wed, 14 Feb 2018 13:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967842AbeBNNWU (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 08:22:20 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:39743 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967798AbeBNNWT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 08:22:19 -0500
Received: by mail-pg0-f48.google.com with SMTP id w17so1922665pgv.6
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 05:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zWjtV8UlZg8GYrGFIXBUpxKRFP7DNZhbjd4nyEicMhA=;
        b=NdeS2JYfYqV5UGlkQUtU7oVp72GtyxE7jAfjnQAJwAFzr7woFP9PjVSEQORpZkpM/T
         Sh4dX8Rq6iFslSrXeIDh52Qq85ZlprdfHc8IHHD2WoEAIrvClqXdn1quSpPTwocd0mtj
         hYceMK1Fe0fFie2WmAsCDBp4Xk/QgMYyAK8hgcKBffYUYohmv4tPhpPp/U5m5IWLRZAd
         SwFSXNcSpbiOgwiDKCImw6ta/CqKvgS7qChsBGbJ2YjLfEAsQW+Tl1+/BCDY00FojWXO
         lQrD99xqnLsbtdsbuBVsF9s5z5isBCk6w2VsWlgf5fLLBfHhdoSab4Vx9WrbrcnAEF4i
         1rOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zWjtV8UlZg8GYrGFIXBUpxKRFP7DNZhbjd4nyEicMhA=;
        b=TcBb3Uofyt4AQZuncdMUJOz1+dVSHPvcKmJWH1XyczncGV4eQ9f025lu1+9BPCVRx3
         TjW1opw97+65t89yJBkrgEA8oBawk6VMfyqFL2q6t9DQO20j01ISVwRJXBNHU170fqTA
         4gR4gJ3odz3s2HBwNVBJTPSaSzKtytSCnCx4SZtRYrD4ljgyHG5tJrgUdm8jhGlNq0nU
         BWxeiL9HMl9Ep/fBa7w9vy/Ut/jtVH1I+aaVWg6bPwn4EEHYzHElKRwAGI9huyXDMx5T
         GugaJlZ7bAd+Q8o/V43Qer/qc9lOEfYQCztmCZf2uK6x0/+8lNa5fWXYikohoQsH+b8/
         rITQ==
X-Gm-Message-State: APf1xPAXxZ9ImTgoOQ4A1wCKBQ5dl14w0NNHjqZv5fhgFbmqLE1SfGkx
        6KnTGVxpUhUJSfD0rbOAd4E=
X-Google-Smtp-Source: AH8x225esH6v/EAM8BBZHH6lrTY8cxZ+xDDFaL+GY4V7ZIkDz7QPkcKkLS1xq7VLelfeEAu/YdviFQ==
X-Received: by 10.98.36.81 with SMTP id r78mr4757155pfj.196.1518614538571;
        Wed, 14 Feb 2018 05:22:18 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id x8sm35718653pfk.123.2018.02.14.05.22.15
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Feb 2018 05:22:18 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v6 5/7] convert: add 'working-tree-encoding' attribute
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180210094852.GB11525@tor.lan>
Date:   Wed, 14 Feb 2018 14:22:13 +0100
Cc:     Lars Schneider <lars.schneider@autodesk.com>, git@vger.kernel.org,
        gitster@pobox.com, j6t@kdbg.org, sunshine@sunshineco.com,
        peff@peff.net, ramsay@ramsayjones.plus.com,
        Johannes.Schindelin@gmx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <E13489D5-5BED-4C30-A153-4146822C3DC6@gmail.com>
References: <20180209132830.55385-1-lars.schneider@autodesk.com> <20180209132830.55385-6-lars.schneider@autodesk.com> <20180210094852.GB11525@tor.lan>
To:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 10 Feb 2018, at 10:48, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
>=20
> On Fri, Feb 09, 2018 at 02:28:28PM +0100, lars.schneider@autodesk.com =
wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> ...
>>=20
>> +Please note that using the `working-tree-encoding` attribute may =
have a
>> +number of pitfalls:
>> +
>> +- Git clients that do not support the `working-tree-encoding` =
attribute
>=20
> A client to Git ?
> Or may be "third party Git implementations"

OK, I'll go with "Third party Git implementations".


>>=20
>> +As an example, use the following attributes if your '*.proj' files =
are
>> +UTF-16 encoded with byte order mark (BOM) and you want Git to =
perform
>> +automatic line ending conversion based on your platform.
>> +
>> +------------------------
>> +*.proj		text working-tree-encoding=3DUTF-16
>> +------------------------
>> +
>> +Use the following attributes if your '*.proj' files are UTF-16 =
little
>> +endian encoded without BOM and you want Git to use Windows line =
endings
>> +in the working directory. Please note, it is highly recommended to
>> +explicitly define the line endings with `eol` if the =
`working-tree-encoding`
>> +attribute is used to avoid ambiguity.
>> +
>> +------------------------
>> +*.proj 		working-tree-encoding=3DUTF-16LE text eol=3DCRLF
>> +------------------------
>> +
>> +You can get a list of all available encodings on your platform with =
the
>> +following command:
>=20
> One question:
> +*.proj		text working-tree-encoding=3DUTF-16
> vs
> *.proj 		working-tree-encoding=3DUTF-16LE text eol=3DCRLF
>=20
> Technically the order of attributes doesn't matter, but that is not =
what we
> want to demonstrate here and now.
> I would probably move the "text" attribute to the end of the line.
> So that readers don't start to wonder if the order is important.

I agree in general. However, I would move "text" to the beginning to be
consistent with the gitattribute pattern above. OK?


>>=20
>> +	if (has_prohibited_utf_bom(enc->name, src, src_len)) {
>> +		const char *error_msg =3D _(
>> +			"BOM is prohibited for '%s' if encoded as %s");
>> +		const char *advise_msg =3D _(
>> +			"You told Git to treat '%s' as %s. A byte order =
mark "
>> +			"(BOM) is prohibited with this encoding. Either =
use "
>> +			"%.6s as working tree encoding or remove the BOM =
from the "
>> +			"file.");
>=20
> "You told Git" is probly right from Gits point of view, and advises =
are really helpfull.
> But what should the user do about it ?
> Could we give a better advise ?
>=20
>=20
> "A byte order mark (BOM) is prohibited with %s.
> Please remove the BOM from the file %s=20
> or use "%s as working-tree-encoding"
>=20
> I would probably suspect that a tool wrote the BOM, and that is
> good and can or should not be changed by a user.
>=20
> So a simply message like this could be the preferred (and only)
> solution for a user:
> "A byte order mark (BOM) is prohibited with %s.
> Please use "%s as working-tree-encoding"

OK. I like the last one!


> (And why %.6s and not simply %s ?)

The encodings is UTF-16LE, UTF-16BE, UTF-32LE, or UTF-32BE.
I just use the first 6 characters to print the encoding that
allows BOMs (UTF-16 or UTF-32). I'll add a comment to explain=20
the trickery in the code!

Thanks,
Lars=
