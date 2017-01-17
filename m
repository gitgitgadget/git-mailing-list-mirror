Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92C6120756
	for <e@80x24.org>; Tue, 17 Jan 2017 16:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751030AbdAQQ52 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 11:57:28 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35211 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbdAQQ51 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 11:57:27 -0500
Received: by mail-qt0-f195.google.com with SMTP id f4so22876320qte.2
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 08:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K05SZqggVzK6aMu9Eg9urRz8T2lFE9qxpWelrcts2iA=;
        b=TaZ9y0Q2A6znFHIeK9U3FSdQq53hD4fwiJL6V7DkPCEKzOrR/6pTepIqTxiixrdd5e
         3iviT2irBeZTSTl1x0vXDAPRi40Cv/Xe+6MgxUJP8Frao5J2KvrfwgmQn76qSa5oN1zE
         8wpqD+txHSolIZYNrQqtbEvEUMsZ7lRmLh1HtOScX+bryfT03zLDxrFeTarMKtXGM4kr
         YSfE3VPFF5yCYkrUYPzp+B1eOzMYGjbvG/xLpi5uIsCjgb+2mCiCGSWGxual6xiBUI5n
         oGvrn0vzM8lgNGK+6o+hkQTQ1zYJOLSMnC2w4139HoMAkpvr2j2QSOS6VUcGolE/uNgi
         k/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K05SZqggVzK6aMu9Eg9urRz8T2lFE9qxpWelrcts2iA=;
        b=r9B/+JSXBTNI92Nj4Ma5DsZ0CBbN2Ms8HCfayctRZ/u1RJxt5+Bqp1xfNwrtWONBd/
         EzOj08GKOT+QhlX4JwEXqRx+TicPU5bQWZ2SlaPznEYVsgfGaHEHZKR370wtjwSUzhUN
         orl1KfNx9xV8l8xOxWn8xiE0tni7uTCwEhFpf7jWoFO/MocEVH8RgfwASKLd1ncBRHnc
         Ux3+LpgTycMljT0UVZ5KBKqflc3kSSZ4hwPQfkpFJWSoNt4LiiJDCULE35828NyvdvRH
         Sxbcr+XoL8AykyOyYcvdzqQEaGbml7i/iq4eCg5ATSHwWz1dA6vLZAgStoPrsomgFf14
         Iwag==
X-Gm-Message-State: AIkVDXLuSui8bJrfVqtIpZHQ2ad6UO6rmHVcT/oWTT5tHmAHJ1N9HYuQ6zB8u9Mc+e3Dy8zM
X-Received: by 10.200.47.100 with SMTP id k33mr33406418qta.241.1484672246435;
        Tue, 17 Jan 2017 08:57:26 -0800 (PST)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-17.NATPOOL.NYU.EDU. [216.165.95.6])
        by smtp.gmail.com with ESMTPSA id q88sm19341774qkq.21.2017.01.17.08.57.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jan 2017 08:57:25 -0800 (PST)
Date:   Tue, 17 Jan 2017 11:57:25 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH v5 3/7] tag: add format specifier to gpg_verify_tag
Message-ID: <20170117165724.2hbyfdzrhrmro54b@LykOS.localdomain>
References: <20170115184705.10376-1-santiago@nyu.edu>
 <20170115184705.10376-4-santiago@nyu.edu>
 <20170117152455.k6zkeclsyawzpl2n@sigill.intra.peff.net>
 <20170117153019.gujiruwghkwfklgv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="otiegmmlpu5pslfh"
Content-Disposition: inline
In-Reply-To: <20170117153019.gujiruwghkwfklgv@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--otiegmmlpu5pslfh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > Hrm. Maybe I am missing something, but what does:
> >=20
> >   verify_and_format_tag(sha1, name, fmt, flags);
> >=20
> > get you over:
> >=20
> >   gpg_verify_tag(sha1, name, flags);
> >   pretty_print_ref(name, sha1, fmt);
> >=20
> > ? The latter seems much more flexible, and I do not see how the
> > verification step impacts the printing at all (or vice versa).
> >=20
> > I could understand it more if there were patches later in the series
> > that somehow used the format and verification results together. But I
> > didn't see that.
>=20
> Having read through the rest of the series, it looks like you'd
> sometimes have to do:

IIRC, we did this to make the diff "simpler". It also feeds odd that the
call chain is the following:

    verify_and_format_tag()
    gpg_verify_tag()
    run_gpg_verification()

I'm afraid that adding yet another wrapper would further convolute the
call chain. If you think this is not an issue, I could easily do it. Do
you have any suggested name for the wrapper?

Thanks!
-Santiago

--otiegmmlpu5pslfh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlh+TPIACgkQRo8SLOgW
IpUA0g/8CppnQYHYbJgw5BWzcPYLIQpAGvk5J/PKekPFJd4jSaLtPFO7u1yHWjrl
66euaCciXL1tBX3X1CV92j+GkST1ud2lsliGKpMPQXFG8sMPtIl3o8sGEma0Eqyy
CMBaS5mbbOhE7+uXl8T1E96zQMvVlmdfaP1cBk0caTyYm3o6J9OOvDi+XPXA+Sxt
LvTn3Yt3fWU4CwkL2SbQv8LGeeA/tG7+8rJtcYgkTJjR6R2HjMpy1b3XpTEs/Udt
eIT/Tjmw/NOdQ3/EBtFv5ZLgj+vAA6jE+jjetVT81nnaMLvP5onT7qEixw5buFez
1Z63o+AmR9kYiXIChU1kU87kDzNZfTyScD6v4RCyyM5Yg22d8Aw/XmjViUzBGfcJ
3UODvfdOwT9WvKt67AEBlZuB0o3917hEczgAM8KC372T6Hg+fxueOON5OaTFw3AO
x0KOdJn88aviAF1QJuBt4Pj8gZ8kKYGsn8B+c1kK6sZ7/b8CAimN67SOxEmSNhxJ
6R4EWMLTGo/Wy5XueQTGG5GXEokt1J15Y2qXa2Lj5GQgKb82AbRgELPNVpF0P+vR
QfbYy5LTHg6B2+uc4giYjpBTe1FGRERpxaEyaCUbGtJjUxChAp3ag2KtUDuPGnAO
QGfm8V1e4Ijo/6o+5dsFYtnFhqhLFbTCzxLQIFl4Ct8ZNs3VA2o=
=ZMfV
-----END PGP SIGNATURE-----

--otiegmmlpu5pslfh--
