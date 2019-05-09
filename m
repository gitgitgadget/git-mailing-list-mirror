Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5DBA1F45F
	for <e@80x24.org>; Thu,  9 May 2019 17:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfEIRkV (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 13:40:21 -0400
Received: from mx0a-00256a01.pphosted.com ([148.163.150.240]:57698 "EHLO
        mx0b-00256a01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726576AbfEIRkV (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 May 2019 13:40:21 -0400
Received: from pps.filterd (m0142700.ppops.net [127.0.0.1])
        by mx0b-00256a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x49HaX6J155612
        for <git@vger.kernel.org>; Thu, 9 May 2019 13:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=20180315; bh=9NUHaVs0xf2j7X8fgyqlMDQuRlZ7aETsFVvfYrkfvAI=;
 b=Pf0/dtE0+xq+jFr8AgZXSArB3SbUFWtRozbsAks7EXeIdyDwMZbyU86ZExh9I+5BPq+x
 DGoKVkb+oR4l1zw+KdZYjfkGEW/HOAlU73IlUFGOE4CDRRnDxjZIV0M0mF9HXHOMcD5Z
 Njnje4Y0/jCPLBTbK6YIoEuDUoTOZmuyFnFQo5a2Ob3draCyDJ5IJPfT9uRDCg5w0/ET
 5bhU9qe1a1P+uzmtd34yA2S7FQRT1XK+xWwe45eg9TjQFpp+UASTJEnRKymvRjrP2k3k
 5b4r+PQ6UFvwM2dBRABfvgOwMqEKNUYYwcRCY1haBjMmROAHQiJGKQ0s4QvS993NTtIt nA== 
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mx0b-00256a01.pphosted.com with ESMTP id 2scg7c9405-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Thu, 09 May 2019 13:40:20 -0400
Received: by mail-qk1-f198.google.com with SMTP id k15so2818681qki.4
        for <git@vger.kernel.org>; Thu, 09 May 2019 10:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9NUHaVs0xf2j7X8fgyqlMDQuRlZ7aETsFVvfYrkfvAI=;
        b=WshRcEIj0y7SR1Ot4D0a32TTjN+FvG1Qfd3p3cGL8qf14K+DkqcRnpyUzAYvnsESgR
         9eRJWNmEeWCBIoRVRK7O0m+fh9na2FePVaB8LlxnBaEtJq0+UEyN1EUmPiRt8Lod7bp4
         T0m0WANG8AssIwiSNiHCX25QSj177S5omX4AduRyaofvOpaJ2DrbCGST6tzTS5WsESUd
         2FbrSSkmIbs2eBubB1MeVOpj9mRwoCpUJ/IFQeOcAjpxnB4Hl0tIp42U/mN/o56qQ06k
         EYR2D6HYFlaBvnunU5h+wYugkLxUTKaxhY5/ikQv49/urPlaTj4eepAzDE7UWhjr2R0x
         kd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9NUHaVs0xf2j7X8fgyqlMDQuRlZ7aETsFVvfYrkfvAI=;
        b=iDWKTZOSx9XXx2GtqUFO6nP5k7E737qp29qgcOZ5OTEqwTISlMG7NKsRdGK/szSFeb
         ExIt0GKc6q9yX59GvqhmSR6iUVOr6edp2hogzeQVDMj7/Vdf/CJuU6cs5q5JVJ+9in0W
         1xXRiZsgCdmrfmqp4cGqTvkB1BjMn4nRfVbpaqEmZYeaAYsmSndWld59UfDcNfj2DB6C
         leOzq+OSgDMntxYX4is8bprAmd7kZiSQr+9SOrBelJCDo0mP7IvJmEdnCmlxbVGyDppR
         1tIV770eH3qvUsJZ2CzZqy9uwjWG8xiSoLNvLhZ61Wz4p4YTN9juOzi4KliEWJByEcJy
         6NHA==
X-Gm-Message-State: APjAAAUy0aV6wI7wG6pYN1p8Yzgv8JVlnvztvUuWuI7WJYXnU5GeL7vI
        3JwI1gY6lKwVBe4rmL3jOQkqNinyQhdLMZp5LgFvrSuU7DGhChLnh25JjzFxu7QdW4O0FMZDdp+
        HbZFBIDI/NGk=
X-Received: by 2002:a37:a289:: with SMTP id l131mr4487621qke.231.1557423618786;
        Thu, 09 May 2019 10:40:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyed3d72DXL05qR52kHoVrBk6T/jXDbWWqP280YfHKQTR1N5UwDWSyJ+Sfk1YegfbVEGlaBcw==
X-Received: by 2002:a37:a289:: with SMTP id l131mr4487610qke.231.1557423618631;
        Thu, 09 May 2019 10:40:18 -0700 (PDT)
Received: from LykOS.localdomain (216-165-95-145.natpool.nyu.edu. [216.165.95.145])
        by smtp.gmail.com with ESMTPSA id d41sm1590425qta.22.2019.05.09.10.40.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 09 May 2019 10:40:18 -0700 (PDT)
Date:   Thu, 9 May 2019 13:40:17 -0400
From:   Santiago Torres Arias <santiago@nyu.edu>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.us,
        walters@verbum.org
Subject: Re: [PATCH 2/2] builtin/verify-tag: do not omit gpg on --format
Message-ID: <20190509174016.us3pvef3bevfe2lb@LykOS.localdomain>
References: <20190427202123.15380-1-santiago@nyu.edu>
 <20190427202123.15380-3-santiago@nyu.edu>
 <20190509074455.GB24493@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o4npkgzgwkmjknru"
Content-Disposition: inline
In-Reply-To: <20190509074455.GB24493@sigill.intra.peff.net>
X-Orig-IP: 209.85.222.198
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=7 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905090101
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--o4npkgzgwkmjknru
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Now this one's VERBOSE handling is a bit interesting. Previously we'd
> set VERBOSE even if we were going to show a format.  And then later we
> just set the OMIT_STATUS bit, leaving VERBOSE in place:
>=20
> > -		flags |=3D GPG_VERIFY_OMIT_STATUS;
>=20
> That _usually_ didn't matter because with OMIT_STATUS, we'd never enter
> print_signature_buffer(), which is where VERBOSE would usually kick in.
> But there's another spot we look at it:
>=20
>   $ grep -nC2 VERBOSE tag.c=20
>   22-
>   23-	if (size =3D=3D payload_size) {
>   24:		if (flags & GPG_VERIFY_VERBOSE)
>   25-			write_in_full(1, buf, payload_size);
>   26-		return error("no signature found");
>=20
> So the code prior to your patch actually had another weird behavior. Try
> this:
>=20
>   $ git verify-tag -v --format=3D'my tag is %(tag)' v2.21.0
>   my tag is v2.21.0
>=20
>   $ git tag -m bar foo
>   $ git verify-tag -v --format=3D'my tag is %(tag)' foo
>   object 66395b630f8ca08705b36c359415af8b25da9a11
>   type commit
>   tag foo
>   tagger Jeff King <peff@peff.net> 1557387618 -0400
>  =20
>   bar
>   error: no signature found
>=20
> The "-v" only kicks in when there's an error. I think what your patch is
> doing (consistently ignoring "-v" when there's a format) makes more
> sense. It may be worth alerting the user when "-v" and "--format" are
> used together (or arguably we should _always_ show "-v" if the user
> really asked for it, but it does not make any sense to me for somebody
> to do so).

Aha! I completely missed this but it is indeed weird. Something
similar happened to me when I was sketching some patches for tag
verification in a downstream project...

> > -	if (format.format) {
> > +	if (format.format)
> >  		if (verify_ref_format(&format))
> >  			usage_with_options(verify_tag_usage,
> >  					   verify_tag_options);
> > -	}
>=20
> This leaves us with a weird doubled conditional (with no braces
> either!). Maybe:
>=20
>   if (format.format && verify_ref_format(&format))
> 	usage_with_options(...);
>=20
> ?

Yes, I think chaining this if here is cleaner/less error prone.

>=20
> Other than that, the patch looks good. I think it could use a test in
> t7030, though.

Let me make a re-roll with these changes included and a test suite for
both t7030 or t7004.

Thanks!
-Santiago.

--o4npkgzgwkmjknru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlzUZgAACgkQRo8SLOgW
IpUidxAAyGhMMdH/gr9r3ao+hbfwA7Ecz7bbabYHZjnK8Af7SgJnaShkR9YVB26l
KZ6/GPR57tIBwvIKcjpcZoBP4kBtM4Acyxxa/6fYzvGR5+Qsn1E5avQWsjN3i1gm
TDCekihJdL4H51+nNjrsTI5njGgxIi8IVIYXcyNUQOrEBexnrCl82/4ZXLHx2vgw
vqaQ9fB/bqxFscoyzlx/bxp8K1qifHkPGKpMfaLvt+gs3VIpBo8TzCF3fz1izwTs
5QcE2a1R9ryAI/lz1/nszSiLrdwdGdKce+iTgbn03/cYPYm9Vh9Ooxn6i3IIf5Bx
jQxtCpjpHwwAwnHVNoUpRPzNn4t5yCH/dJBoZD+UBouzlSQvvEgnq2hoDM/jUrEt
gZvUPdfJc0yAcCs/1vOFjTHdZyY9Njc/TrANW/pOiKL5qEVa1GB0cuRpWrg9XirP
RAKf3US99ptG0tCKd9IGYp0HbNlPtj/srqeb+Jtic6IwJ4hamEJ7TFkSXWMWXAlJ
tqJ/kTX1fR/PU1mXSsBF3sGgkyEyll9GK8EH1b2t5ftTIxWpZ7AVwyBU+rJiw/OJ
uXVaxADUC7gnKIbPeYgJgG3ilWDQh+aM0ywqd55Q6aOo8Q3Es53SxSsEnUjqslxv
QPc7m4N+ZW7bz9tzK2Sa/6OAW7sRUqgxGZUq8iInyg7OR3slxVA=
=Gz+m
-----END PGP SIGNATURE-----

--o4npkgzgwkmjknru--
