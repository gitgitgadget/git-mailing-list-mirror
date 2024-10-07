Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A17412B64
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 04:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728274769; cv=none; b=tUaljViiuA3Nblfw49Z0DF7bkM097SH+kX6VEO2vavE9RKdKMnvO+tD8E52cRNUi4wzFvwMHxf8ITWXCVkg+olLK4FYW5kfWm0qLL9pm8kcYtK6WWSgfj1dP9TkyiRbDEIlhVejD8pJKYwFXPn5EhWLLJKLQ7whGHxLha74s/z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728274769; c=relaxed/simple;
	bh=IBvB0jzMUrGRLBzwvp5Oq16bLBH93qi2NoGnrsRuDk4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LOdVu3IEsfzkPk1YiYVOYxL+NkaU3ESGQVPASvQhH9PCoHHeQPa4bhd40P69BXyWrbGewmMrsLoGIFJXY9mka13r+5slCn/WSfQsH52ut5SQUvru/81d/AZcMvul/Cv8HX5xQ0h3VJFm9DGmxBxpLP8F4RJhxcj4qbLE92avppk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=VVNLx6Lo; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="VVNLx6Lo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728274766; x=1728533966;
	bh=VygC9BxK3Y3Fq9okUPuGl/zVHy24plK/xiFC5kNaT+Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VVNLx6LoKF9kup4PZMVsWtGuyRmLlF/wNMR6QoVpMyHt13mZ42OxmMxigzD9nmAHU
	 89WouodMIB1EWQvGFt2HoqksNybhryX2SLs457VPfutstwCqiyMXouMD3+/UhqhbNR
	 Ag/AupRZ1TWZZ3qVvEOu5bjaUZyHKKH86HKW1NL3lPYV08P2C+sPccHqV0/c3pbvFr
	 xDtK6kW26rAFDer1aYGFv4jlpkbcWo8cB3FkV3rDxAxwKrT32Q1i5WyN67uNELAWZg
	 jwwurZV2X+uGzhw8/dAazspwk6Q649Octp6n3lHy4z5o1F606yHy/6ZU0Cclm+5f9y
	 uxeB9og96uWJw==
Date: Mon, 07 Oct 2024 04:19:22 +0000
To: shejialuo <shejialuo@gmail.com>
From: Caleb White <cdwhite3@pm.me>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/4] worktree: refactor infer_backlink() to use *strbuf
Message-ID: <XzNC1BXk2OaIGmgas_MWKZ_ubpeR_kA19hNxmF76FLtgI_WfYrMOGEDEr5uqOETNPHTI_bA3qJE0R0eah4UTPXZUgeRjG7psN6ncDOdPXNA=@pm.me>
In-Reply-To: <ZwNfuLoVn4aU4mgQ@ArchLinux>
References: <20241006060017.171788-1-cdwhite3@pm.me> <20241006060017.171788-2-cdwhite3@pm.me> <ZwKoNg-HYGaohvCd@ArchLinux> <CAPig+cQC45_Pofw31h2RSydj_CjqpfajLLa5O_sR9m0AQh5OVw@mail.gmail.com> <o7jQV4JUYr2iQtErKFhCrjCySiGn7_I18gmdInKbOC9TAsvqazG0O_fPUtiWZ5UfiGLr25OZ5xvqIhfOIwCG-s1RGgri-BJIdHqiokIw4z0=@pm.me> <ZwNfuLoVn4aU4mgQ@ArchLinux>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: aedd8eddf1b65b80ee79b4bd211746c22330fa17
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------33a6b5aaa197d80e2e105930e1411566516fb8092ee65d6aafcf94e48d06f6cc"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------33a6b5aaa197d80e2e105930e1411566516fb8092ee65d6aafcf94e48d06f6cc
Content-Type: multipart/mixed;boundary=---------------------bdba7e212184b57fbcf3a287643eb5cb

-----------------------bdba7e212184b57fbcf3a287643eb5cb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Sunday, October 6th, 2024 at 23:12, shejialuo <shejialuo@gmail.com> wro=
te:
> That's not correct. It is true that the contents can be NULL and
> `backlink` could be filled with the infer_backlink. But do you notice
> that if `backlink` was filled with the infer_backlink, it will jump
> to the "done" label.

This is not correct, if backlink is filled with `infer_backlink` it
continues on with the processing. I have made this more clear:

    dotgit_contents =3D xstrdup_or_null(read_gitfile_gently(realdotgit.buf=
, &err));
    if (dotgit_contents) {
	if (is_absolute_path(dotgit_contents)) {
	    strbuf_addstr(&backlink, dotgit_contents);
        } else {
	    strbuf_addbuf(&backlink, &realdotgit);
	    strbuf_strip_suffix(&backlink, ".git");
	    strbuf_addstr(&backlink, dotgit_contents);
        }
    } else if (err =3D=3D READ_GITFILE_ERR_NOT_A_FILE) {
	fn(1, realdotgit.buf, _("unable to locate repository; .git is not a file"=
), cb_data);
	goto done;
    } else if (err =3D=3D READ_GITFILE_ERR_NOT_A_REPO) {
	if (!infer_backlink(realdotgit.buf, &backlink)) {
	    fn(1, realdotgit.buf, _("unable to locate repository; .git file does =
not reference a repository"), cb_data);
	    goto done;
        }
    } else if (err) {
        fn(1, realdotgit.buf, _("unable to locate repository; .git file br=
oken"), cb_data);
        goto done;
    }



-----------------------bdba7e212184b57fbcf3a287643eb5cb--

--------33a6b5aaa197d80e2e105930e1411566516fb8092ee65d6aafcf94e48d06f6cc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnA2E6CZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAABv1QgAiWrpNdOKwtwn8jSTmEbNgDbzfqGEN53A7xUCKwTjKFbrvodc
j6ZBubct+9300ZmweSod2VDeh6f5ULXtki8mOzmRTLFAwaukAVvJ9RJ/EpsI
AD3KQC4MIn5suVPHrIW9q25u7tZocaSI41dnFqTXk6k9CQfH75XzUkSoXX1l
XC2yZ0/kNpyB8omqBdCG9PBoKQaRl4WyboLVfsJUju5wXFK856E33bKS5MWI
hSQglMWOCIumbDNm2aZwUna0jwpMQ5kE+Avp+Ayh11coUms9nblxBezvXM4J
HBgO8/pziFlGPrL+QWmSQSaY1vB/Y9R9/fhsX3cO4QrKb7jN2X0sGw==
=y20z
-----END PGP SIGNATURE-----


--------33a6b5aaa197d80e2e105930e1411566516fb8092ee65d6aafcf94e48d06f6cc--

