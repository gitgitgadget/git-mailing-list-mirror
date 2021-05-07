Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CC9C433B4
	for <git@archiver.kernel.org>; Fri,  7 May 2021 23:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF6C160FEA
	for <git@archiver.kernel.org>; Fri,  7 May 2021 23:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhEGX7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 19:59:14 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49848 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230252AbhEGX7M (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 May 2021 19:59:12 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 36C186041F;
        Fri,  7 May 2021 23:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1620431860;
        bh=sYEA7rloy9wboY88iPnW0K9A5fy9MgJPqmlIwEKmUK4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=jght35kq2dEYs2TC4KHAAm8YT07dfi1r+a3cHs1jN38ZaFrir6ON7zfvzB5uxN/DQ
         zI0IbYuaMU98NFZC4a84XTp9pgPjSZU2VUcdcF7RQYcKE3n+tf6Jw4mxWapWWQnh1e
         7gqQWtPvD7Ka42OIgiLJnAvGhDq3ul70rdYrKZMP7NGQ6Qt5wtR8fv2Z+FaZmeodfW
         neSan2Wi1b6kD1jr/V066cfDItMND0WqHXPee1+MPMHeOMGP4uq3Gi6UGehCxrIUtf
         IOZ/7EMwB2lmXDsDjcck116DmK39CK95wtY+ODCzWbXwWHuJFNiYEEPBcj683PfPlS
         cWTE7/8WRA9Cir4NTEhXzA4g4CSoCe5XU6xjNILCwHAbLN9J7EqvpIMBUAds1uKHqh
         hUqyjRQ/nUYYDA9oBRZoWJ5z3qEzp5EXjECx0dcGoLS5PbGn0hhiD9/fWsJLdmvUpv
         b/wAqYxG2uEo2KjX/dU76hakBBSbsNl1zfUCagxLvHlLvgWc0qn
Date:   Fri, 7 May 2021 23:57:32 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
Message-ID: <YJXT7AaqCeCV4WcZ@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
 <YJWiQH2nf0B14Zy7@camp.crustytoothpaste.net>
 <6095ceb984401_cfc7208b9@natae.notmuch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XCjbgYtqC1vB01sf"
Content-Disposition: inline
In-Reply-To: <6095ceb984401_cfc7208b9@natae.notmuch>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--XCjbgYtqC1vB01sf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-07 at 23:35:21, Felipe Contreras wrote:
> I don't think it would be that complicated.
>=20
> This patch seems to do the trick here:
>=20
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index c2baad0bd8..8fa4896d22 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -189,6 +189,7 @@ ASCIIDOC_EXTRA +=3D -alitdd=3D'&\#x2d;&\#x2d;'
>  DBLATEX_COMMON =3D
>  XMLTO_EXTRA +=3D --skip-validation
>  XMLTO_EXTRA +=3D -x manpage.xsl
> +TXT_TO_MAN =3D $(ASCIIDOC_COMMON) -b manpage
>  endif
> =20
>  SHELL_PATH ?=3D $(SHELL)
> @@ -360,9 +361,16 @@ $(OBSOLETE_HTML): %.html : %.txto asciidoc.conf asci=
idoctor-extensions.rb GIT-AS
>  manpage-base-url.xsl: manpage-base-url.xsl.in
>  	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
> =20
> +ifdef TXT_TO_MAN
> +%.1 %.5 %.7 : %.txt asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOC=
FLAGS
> +	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
> +	$(TXT_TO_MAN) -o $@+ $< && \
> +	mv $@+ $@
> +else
>  %.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
>  	$(QUIET_XMLTO)$(RM) $@ && \
>  	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
> +endif
> =20
>  %.xml : %.txt asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
>  	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
>=20
> I'm sure this can be improved with some knowledge about intermediary
> rules.

It's not quite that simple.  It requires changes to
asciidoctor-extensions.rb and we also need to consider
NO_MAN_BOLD_LITERAL and GNU_ROFF.  The latter especially is likely to be
inconvenient, since according to the Makefile, it's impossible to write
man output that works across troff versions.

We will also want to preserve the ability to use xmlto because we
currently have doc-diff which helps us find divergences in the behavior
of AsciiDoc and Asciidoctor, many of which affect all formats, and that
will be completely useless if we use two different rendering toolchains.

So, yes, this is a good start, but it's not quite as trivial as it seems.

> > It also doesn't help if you're generating more than just the manual
> > pages, since generating the PDFs will definitely require xmlto and
> > either dblatex or fop.  I personally prefer fop over dblatex, but folks
> > have different opinions.
>=20
> Huh? user-manual.pdf seems to require DBLATEX, not XMLTO.

Ah, yes, because we do it manually instead of using xmlto.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--XCjbgYtqC1vB01sf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYJXT6wAKCRB8DEliiIei
gQSwAP9Qbg82bhZkQwCPULFSSAFP3aLgWLFsfTKRvwKsmFTuSQD+PhI33NxxetlT
AFtXoMhP7wmuxNsQBNptMisjkl0QTws=
=wGtq
-----END PGP SIGNATURE-----

--XCjbgYtqC1vB01sf--
