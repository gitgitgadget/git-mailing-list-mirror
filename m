Received: from mail-24426.protonmail.ch (mail-24426.protonmail.ch [109.224.244.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653B54503B
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 17:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744307386; cv=none; b=SXYqM2BgMDeBft/vXqB0IVP7yt3vJrK1kVDk947crVO9+a5UYJ8JF+aBxnaVaOaLVd5Ifx7mqZy4yNIP8W8oDb5wOi5wdShckXoSLQmOY7OYAdROlJN5fokyNXNw/41npVOnyAbN8iFE+s4swdYuvz4A8RwZ3AJsAEfelYCCDeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744307386; c=relaxed/simple;
	bh=yjAYDuPIhRTVK+2Ozd8a85wJqI+Rx6DpbKtL1zclGbo=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=sd7AZap9n+KihlYa2wMnIN6iQInpP5zfkL9lCs2ZCblZmEOiFH/6394793Z63zBuhDxDx/lvW68A8Dn87PdpSJg52agSDNTVD2H9LSum9V99SLwUMTE4apoW5cDBoJlj9D8m/nO6mzUxiCf9foiVD2mOqW/84SoOr0yl6WnnR44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=How1y+Tj; arc=none smtp.client-ip=109.224.244.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="How1y+Tj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1744307381; x=1744566581;
	bh=AY5E1sBFCixcH7n8WGVWZX7stetKbciRIoaHhRCF08s=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=How1y+TjGFbkpBizU3aotP2+i25pzZVFvYl0JMZVZA8QPTNeNCBYEVBiwwZS/9xzh
	 U6bNO9I5GbHUihkLOpo59UU7OsL08jp6sg5oXHN7KY5AXiRVq/+4bxHCqeI0mz9vJs
	 OW1HC3YhWMAdZBxVcRyg5jnaW2XiwHc7RbMeZWXXzLVApoqIudJCJlF1mHpfoBL/V7
	 naCzQvUnjvhoBeekBz2tCR0Y3b7jxOKf2+BrAq/nN3sNMrDUWAMGqFyl+74rIj4gEq
	 dFXFmQ+YIfpS+zgiqTx34LTUghFPmiXZWgDIHKH2SwiEjH1tneulCnZAmXDR3tmpDM
	 XkjaVHelQbvkA==
Date: Thu, 10 Apr 2025 17:49:23 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: Ross Goldberg <ross.goldberg@proton.me>
Subject: Command whose exit code indicates clean or dirty working directory
Message-ID: <jreR52go49E9pIfAmIdRaoqIgKnVV7uOhR4Mbl9_p2dLG_7mPgO8qsUk7CaWC0nGbJD-2F4nGdQ8X65UtIQ5XOBNQXXzrnHnKbOCLCfEil0=@proton.me>
Feedback-ID: 46060443:user:proton
X-Pm-Message-ID: e336bb4f031bc1649658ff8bdaa6ed3ab0b71472
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------70a19e9da236e2f7b16a7cfd0014147fe46cd139091abacc828a52eb83ebf57e"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------70a19e9da236e2f7b16a7cfd0014147fe46cd139091abacc828a52eb83ebf57e
Content-Type: multipart/mixed;boundary=748ae88c2fa9bd93d0a3350fb71211818112585a

--748ae88c2fa9bd93d0a3350fb71211818112585a
Content-Type: multipart/alternative;boundary=8cc31703eb81af327784ba43c2ef75008c170ffe

--8cc31703eb81af327784ba43c2ef75008c170ffe
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

What is the simplest git command that returns 0 if the working directory is=
 completely clean, or nonzero if it is dirty in any way (staged diff, unsta=
ged diff, file that is both untracked &amp; not ignored, etc.), with nothin=
g printed to stdout or to stderr?
If the simplest such command is complex, is there any feature request to cr=
eate a simple command, possibly with options that specify what is considere=
d dirty (staged diffs, unstaged diffs, untracked &amp; not ignored, etc.)?

 =

 =

 =
  Sent from =
  Proton Mail for iOS

--8cc31703eb81af327784ba43c2ef75008c170ffe
Content-Type: multipart/related;boundary=4c86be8c52caf1090fc0b0c450fc007ec666c456

--4c86be8c52caf1090fc0b0c450fc007ec666c456
Content-Type: text/html;charset=utf-8
Content-Transfer-Encoding: base64

PGh0bWw+PGhlYWQ+PC9oZWFkPjxib2R5PjxkaXYgZGlyPSJhdXRvIj4KIFdoYXQg
aXMgdGhlIHNpbXBsZXN0IGdpdCBjb21tYW5kIHRoYXQgcmV0dXJucyAwIGlmIHRo
ZSB3b3JraW5nIGRpcmVjdG9yeSBpcyBjb21wbGV0ZWx5IGNsZWFuLCBvciBub256
ZXJvIGlmIGl0IGlzIGRpcnR5IGluIGFueSB3YXkgKHN0YWdlZCBkaWZmLCB1bnN0
YWdlZCBkaWZmLCBmaWxlIHRoYXQgaXMgYm90aCB1bnRyYWNrZWQgJmFtcDsgbm90
IGlnbm9yZWQsIGV0Yy4pLCB3aXRoIG5vdGhpbmcgcHJpbnRlZCB0byBzdGRvdXQg
b3IgdG8gc3RkZXJyPzwvZGl2PjxkaXYgZGlyPSJhdXRvIj48YnI+PC9kaXY+PGRp
diBkaXI9ImF1dG8iPklmIHRoZSBzaW1wbGVzdCBzdWNoIGNvbW1hbmQgaXMgY29t
cGxleCwgaXMgdGhlcmUgYW55IGZlYXR1cmUgcmVxdWVzdCB0byBjcmVhdGUgYSBz
aW1wbGUgY29tbWFuZCwgcG9zc2libHkgd2l0aCBvcHRpb25zIHRoYXQgc3BlY2lm
eSB3aGF0IGlzIGNvbnNpZGVyZWQgZGlydHkgKHN0YWdlZCBkaWZmcywgdW5zdGFn
ZWQgZGlmZnMsIHVudHJhY2tlZCAmYW1wOyBub3QgaWdub3JlZCwgZXRjLik/PC9k
aXY+CjxkaXY+CiA8YnI+CjwvZGl2PiAKPGRpdiBpZD0icHJvdG9ubWFpbF9tb2Jp
bGVfc2lnbmF0dXJlX2Jsb2NrIj4KIDxkaXY+CiAgU2VudCBmcm9tIAogIDxhIGhy
ZWY9Imh0dHBzOi8vcHJvdG9uLm1lL21haWwvaG9tZSI+UHJvdG9uIE1haWw8L2E+
IGZvciBpT1MKIDwvZGl2Pgo8L2Rpdj48L2JvZHk+PC9odG1sPg==
--4c86be8c52caf1090fc0b0c450fc007ec666c456--
--8cc31703eb81af327784ba43c2ef75008c170ffe--
--748ae88c2fa9bd93d0a3350fb71211818112585a--
--------70a19e9da236e2f7b16a7cfd0014147fe46cd139091abacc828a52eb83ebf57e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYIACcFAmf4BJMJEGIvlZ3ETyGVFiEED/oUaEUfJG64NHEfYi+VncRP
IZUAAOnoAPwJHt9cLxwU6uGOFqpgWRsEaBe6dhbWDYcNT8i9BAz0LQD+KL7v
VzHkmbIuVnM2Fb9DN1bHiPGhMaEcQJZtGoea5Ag=
=RuHC
-----END PGP SIGNATURE-----


--------70a19e9da236e2f7b16a7cfd0014147fe46cd139091abacc828a52eb83ebf57e--

