Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C445E20C2E
	for <e@80x24.org>; Wed, 18 Jan 2017 18:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752997AbdARSha (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 13:37:30 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34551 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752993AbdARSh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 13:37:29 -0500
Received: by mail-qt0-f194.google.com with SMTP id a29so3131248qtb.1
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 10:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XNjkvq4pUV0Tcb0C137xiNSI9Y353LIQWLvwWUjpctQ=;
        b=TrDiVwQp7Gx6mwzm9/O8xn2Z5KyBloAwoTlOxhivOBVCsZgY75bCXulbdCe88oj88X
         GMsNHGtKpZ18Et69jwzC8+tBAx6bagNiQG/t81DkF24/oWZVs3xi9QdZADR0H6BavTiO
         k0HZxjq9UgxrYKbFCP7x7FLsi/n5ouyVxvUuwu9Np6scyqFfAigfxfRPkXYKp+yUWX6Q
         yZD25T1a5A8EqiDr2xh/Soo20vcSc0SfcnWKEHIp5LLWta269OEkW7c1kdSMygtAX/3L
         ZWF0ahjJy2bJP4Mbuw2ppUTAF4sTVJEDAxk+BtwRZUrBI6YwT8XNBoBDiVF/7zCAhU6f
         tJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XNjkvq4pUV0Tcb0C137xiNSI9Y353LIQWLvwWUjpctQ=;
        b=V9kq/JIoOpC9uzJqgNT4Mbb2tyAClxQ00J+FdBXVM5uQIPjtRsHTlhnGYM/aAjwqIh
         JgRbVsZNEwS5Gxuft6yIoMgiAE9X22Z04bos2Ne+I1odsOYvx8CAO7dTNmtjnalD0sZn
         IuP17p3wNVFd3QET+hROBMmn9+0HFXVqlQJWVkojahokVfnHPjPDP+KBsu8MzMoA/qmj
         gs874VKHb3Eu79KeefeSFzpCkGWY/1KZ+iT+M3c9GJkCaJxq9T3E76HKh+Z4wah6grns
         tgT9o01wI7/AbfATD08fA9adNo+5NhY2lATmqZwVaxld+3cz1aqNBK1HQSP0CjshXnXT
         ceJA==
X-Gm-Message-State: AIkVDXLm2gxfZBsHruXW04FmimCaGIgdikfBKXNLb0GriPs5nL906t4efWb/OJgtxSi1qssP
X-Received: by 10.237.43.36 with SMTP id p33mr3868624qtd.199.1484764113287;
        Wed, 18 Jan 2017 10:28:33 -0800 (PST)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-15.NATPOOL.NYU.EDU. [216.165.95.4])
        by smtp.gmail.com with ESMTPSA id x40sm878757qtx.12.2017.01.18.10.28.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jan 2017 10:28:32 -0800 (PST)
Date:   Wed, 18 Jan 2017 13:28:32 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH v6 4/6] builtin/tag: add --format argument for tag -v
Message-ID: <20170118182831.pkhqu2np3bh2puei@LykOS.localdomain>
References: <20170117233723.23897-1-santiago@nyu.edu>
 <20170117233723.23897-5-santiago@nyu.edu>
 <xmqqmvepb4oj.fsf@gitster.mtv.corp.google.com>
 <xmqqh94wb4y0.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r24xguofrazenjwe"
Content-Disposition: inline
In-Reply-To: <xmqqh94wb4y0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--r24xguofrazenjwe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2017 at 10:25:59AM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > santiago@nyu.edu writes:
> >
> >> @@ -428,9 +443,12 @@ int cmd_tag(int argc, const char **argv, const ch=
ar *prefix)
> >>  	if (filter.merge_commit)
> >>  		die(_("--merged and --no-merged option are only allowed with -l"));
> >>  	if (cmdmode =3D=3D 'd')
> >> -		return for_each_tag_name(argv, delete_tag);
> >> -	if (cmdmode =3D=3D 'v')
> >> -		return for_each_tag_name(argv, verify_tag);
> >> +		return for_each_tag_name(argv, delete_tag, NULL);
> >> +	if (cmdmode =3D=3D 'v') {
> >> +		if (format)
> >> +			verify_ref_format(format);
> >> +		return for_each_tag_name(argv, verify_tag, format);
> >> +	}
> >
> > This triggers:
> >
> >     builtin/tag.c: In function 'cmd_tag':
> >     builtin/tag.c:451:3: error: passing argument 3 of
> >     'for_each_tag_name' discards 'const' qualifier from pointer target =
type [-Werror]
> >        return for_each_tag_name(argv, verify_tag, format);
> >
> > Either for-each-tag-name's new parameter needs to be typed
> > correctly, or the type of the "format" variable needs to be updated.
>=20
> Squashing the following into this commit solves this issue with the
> former approach.  The lines it touches are all from 4/6 and I view
> all of it as general improvement, including type correctness and
> code formatting.

Thanks!

Should I re-roll this really quick? Or would you rather apply this on
your tree directly?=20

-Santiago.

--r24xguofrazenjwe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlh/s80ACgkQRo8SLOgW
IpXzvw//UkeS+Rf6GeYX6pmQgmL1rNucyQ/3Zhwvb2AWB4QrqrwdiU7s9XQmLAE4
/lPown5yAjhynglX2XgAP5GknTOFYEFcqSpfOKdQvKPyakVaXXQJtcGcM89L6bL/
MzZ18XwW1jPT1BWpxPaLMYH3YmbVhA58pnSsOt5lZLWz1tK9USMOsZKDaam3dwm+
ngpenP/bU9wgweehEu4oRnNsqyEgG/nXbG4RHz0KT4mU3eVHcKebMRfVPrAXqJ2h
v6G/rDgN/XzkkQYsBWBBKeoMu+NKMhck1NJ1m/iwQnKSBAOKZEHnehTD+0YHhzqE
5J8PPSRvW80TBkay3zeGOHzuqkPCHTrVtbIJBYqC2bEvAgQwI3/a6d5i4fjMSaJr
+3YClW4f7tyjFkKCq1YUYLeoxJZo9HGLlKlKHq8X6TeswQjzslYwjEpzeEdtYwmm
IsliEYdaDZqThgtq79SomSIyHQzsk9G7UILQOZM85rlqYQMqK7s5Lq2wRpgqgZcR
yR41GCqAk+H3WXdmZBCMZUUjtLsQQL7+ApQk9K6NnKGlePnvTm4ewY11EplKBf7m
ecR0FpNTDhJSfctFvw6nc3L9Kn1WSCbrZ58dYSYyy3k16DOVgQXdUD0GDUBcAf5w
F0R3Z1BpLdg421nYDjGldmvOtUjFR5rit8Vc/9XKFyCfZW/5b1w=
=7wIb
-----END PGP SIGNATURE-----

--r24xguofrazenjwe--
