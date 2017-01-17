Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 336B220756
	for <e@80x24.org>; Tue, 17 Jan 2017 17:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751345AbdAQRli (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 12:41:38 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34145 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751341AbdAQRlg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 12:41:36 -0500
Received: by mail-qt0-f194.google.com with SMTP id a29so23115810qtb.1
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 09:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zVjVtCVkJYwGpcEoTAOBYYn9/XAjBJxFbr/jZgDQ8o0=;
        b=x1CR9yjdlo+Io+SgtVV27tteO6PA0jjH5cZx3TPnpP7SY0Xkk+OZhXxUnLYkgLFmiM
         8gF4RH0nciNClJRxR/bGF1vuDP3GzATr17yyUkYrwnZbKY/7c74SIKWVxOfY8owVf5iw
         uoy64PhZ2lWtcPhzOCjfDkiQX/6Qab5R6MRasAQhlqne6UkRt1JCdruBuuOYAtsERbx6
         QKLmpFary7Mt0KWscc3PWLMa0PpF+o3gkSplI1lcr0P3BhmRkzhg/ZxoKbbTE/QkWxe8
         aVxX1vieKgF2ZyxCB7GDglKw+cjeNOnAkEfd80D14rLv4biozl1ScB2g6kk4QIEdwmTf
         LLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zVjVtCVkJYwGpcEoTAOBYYn9/XAjBJxFbr/jZgDQ8o0=;
        b=oym7R7bdhovqcKPE5AT6j+8YdEXTzTbjqRws/0UWEifjLEeJy9z7owobhdeKhxXuyq
         V6r4i9B+K4AfDNSlmcO1OqoO31enj7DII0YVfjIbzyjhDV9VH/SUDq6W/3B54I8hC0ye
         aeLmThOozVpZKR8KdO0nrEl/O7G7IU1fnzhv2K5e3u/LorZkiuN612mK1/5TffRUNbjQ
         bWL5TLm9JjOv8o42AZ9KKyVPb4MPoAaa+kaXmkk46xF0qVNlxssSb6GJKHB4nuJEC1Py
         ZRdMcJUnZFmadOLbvMQ5OuSiF/Hx/yJKU0Es6hubV6NCLSV9SotPw+Qk/TZO7NllIHkW
         z7ug==
X-Gm-Message-State: AIkVDXKkA7YF5+sN6oR0yAjQwtzyaIKro8rxoA8R4YA4skTAzBero0hO/YSJmOIGITdNdmQ6
X-Received: by 10.55.8.12 with SMTP id 12mr39379356qki.74.1484674427682;
        Tue, 17 Jan 2017 09:33:47 -0800 (PST)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-17.NATPOOL.NYU.EDU. [216.165.95.6])
        by smtp.gmail.com with ESMTPSA id 34sm3369404qtx.16.2017.01.17.09.33.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jan 2017 09:33:47 -0800 (PST)
Date:   Tue, 17 Jan 2017 12:33:46 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH v5 3/7] tag: add format specifier to gpg_verify_tag
Message-ID: <20170117173346.paqrsroauoskxpn6@LykOS.localdomain>
References: <20170115184705.10376-1-santiago@nyu.edu>
 <20170115184705.10376-4-santiago@nyu.edu>
 <20170117152455.k6zkeclsyawzpl2n@sigill.intra.peff.net>
 <20170117153019.gujiruwghkwfklgv@sigill.intra.peff.net>
 <20170117165724.2hbyfdzrhrmro54b@LykOS.localdomain>
 <20170117172531.bahjekbj3om43gtq@sigill.intra.peff.net>
 <20170117173003.sgipqc2cijpdrukb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ereilp4mgsdjoj5m"
Content-Disposition: inline
In-Reply-To: <20170117173003.sgipqc2cijpdrukb@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ereilp4mgsdjoj5m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yeah, this actually looks more cleaner.

Let me give it a go.

Thanks!
-Santiago.

On Tue, Jan 17, 2017 at 12:30:04PM -0500, Jeff King wrote:
> On Tue, Jan 17, 2017 at 12:25:31PM -0500, Jeff King wrote:
>=20
> > Actually, looking at the callsites, I think they are fine to just call
> > pretty_print_ref() themselves, and I don't think it actually matters if
> > it happens before or after the verification.
>=20
> Oh, sorry, I misread it. We do indeed early-return from the verification
> and skip the printing in that case. So it'd be more like:
>=20
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 9da11e0c2..068f392b6 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -114,7 +114,11 @@ static int verify_tag(const char *name, const char *=
ref,
>  	if (fmt_pretty)
>  		flags =3D GPG_VERIFY_QUIET;
> =20
> -	return verify_and_format_tag(sha1, ref, fmt_pretty, flags);
> +	if (gpg_verify_tag(sha1, ref, flags))
> +		return -1;
> +
> +	pretty_print_ref(name, sha1, fmt_pretty);
> +	return 0;
>  }
> =20
>  static int do_sign(struct strbuf *buffer)
> diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
> index 212449f47..b3f08f705 100644
> --- a/builtin/verify-tag.c
> +++ b/builtin/verify-tag.c
> @@ -58,10 +58,19 @@ int cmd_verify_tag(int argc, const char **argv, const=
 char *prefix)
>  	while (i < argc) {
>  		unsigned char sha1[20];
>  		const char *name =3D argv[i++];
> -		if (get_sha1(name, sha1))
> +
> +		if (get_sha1(name, sha1)) {
>  			had_error =3D !!error("tag '%s' not found.", name);
> -		else if (verify_and_format_tag(sha1, name, fmt_pretty, flags))
> +			continue;
> +		}
> +
> +		if (gpg_verify_tag(sha1, name, flags)) {
>  			had_error =3D 1;
> +			continue;
> +		}
> +
> +		if (fmt_pretty)
> +			pretty_print_ref(name, sha1, fmt_pretty);
>  	}
>  	return had_error;
>  }
>=20
> which I think is still an improvement (the printing, rather than being
> an obscure parameter to the overloaded verify_and_format_tag()
> function, is clearly a first-class operation).
>=20
> -Peff

--ereilp4mgsdjoj5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlh+VXgACgkQRo8SLOgW
IpU2WQ//Xcs09JZpOSJ/eSfhQBI8nKrdZ1FF0TwFkKgDMbcL4lap/vWdKXMw1vPt
3gvnfcAl/iuh8VqY2OoiMqmCyB9HNpQB06jQvSvjN+nrYtSG1NRV+T4Of+i1JCYQ
RRwef3fXY0sNaF/BK3Mgk6pDjxsauTTaEPVDpePekiKnuYxyD3QTnKsIi7C6xvaU
pnQtJ7xkPVVJssy60p4EWEIPLMPxlx3hZvYPdUArhxP6XbCzothWOg2ITLBbR7ev
wCS3viVl7U9hSl8uu1f2PtifpmpWZMy0E6AHXM4773rX5z2h8Rsd8b4yd9X97ZUu
Xw57Om1r3egOhu7+RMSMhFdKfLXO4LWLEhDqs3ABgSf/H8/H/v5FF2iBlTKj7IL+
5TfRePdBEEpSJqnuMRX9ZWdzAQ/iAoavxPcHT+/CoUBqYrp2yT9SZEFdacYHiRqp
tpLNVb/gz7Ll3lmY5wkUC69Ib5muWAzY2Ys1MN7fOi1CDc5s4S2KsEFqiyHcnYlq
Ti851vfIXLn1PgBk8jKtzU6/s3QDWREzsFQDgj7c04Q7A0RDK0z9cCF+umsfJUcj
PxwKHr8bywN57CzQpkZiNcfAAAIgK9ld6ypSmJRWH54zYoOkRXYBsfilYaxgKOTB
QJw0Q5idRVJ7j7XUhoJW+SUZ3MggEzotdKSu3AoxuWE7bbhE/H8=
=ITEL
-----END PGP SIGNATURE-----

--ereilp4mgsdjoj5m--
