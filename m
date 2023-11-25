Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from outbound.soverin.net (outbound.soverin.net [IPv6:2a10:de80:1:4091:b9e9:2214:0:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA2E10CA
	for <git@vger.kernel.org>; Sat, 25 Nov 2023 01:45:52 -0800 (PST)
Received: from smtp.freedom.nl (c04cst-smtp-frd02.int.sover.in [10.10.4.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4Scn670BVSzS0;
	Sat, 25 Nov 2023 09:45:51 +0000 (UTC)
Received: from smtp.freedom.nl (smtp.freedom.nl [10.10.4.108]) by freedom.nl (Postfix) with ESMTPSA id 4Scn660ZGCz2xCS;
	Sat, 25 Nov 2023 09:45:50 +0000 (UTC)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freedom.nl;
	s=default; t=1700905550;
	h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g7Xud2rGfP88EhkWyMun1RHkdgrwcIqq1HYEtms4QhQ=;
	b=iE8R2glMmXFZgJ8Z3LOIPVM/xKcSubyYfDuBVTWwGr3sM6Q/unmeNYkkl+vxJEl3jkBxGk
	zidXMJ1ryu8GLQMdwUPPfLZXoXNVJBpVXpxmdDZhEf0sAefGEOm3eM+CZVmNRlmbQPseYF
	2kDGrx5T1Z+oVYpYt1fnGA/jAd6iMaY=
ARC-Authentication-Results: i=1;
	smtp.freedom.nl;
	auth=pass smtp.mailfrom=linux@tux.freedom.nl
ARC-Seal: i=1; s=default; d=freedom.nl; t=1700905550; a=rsa-sha256;
	cv=none;
	b=sXg4ob1zfuxweK70U/BcMb/vGWYWeVCONi06ReQxl09mWaHeDjLhnRwyN4uAEOP+o2MsmD
	nieFaIw+Z3zAjXYqS0wRxntAYbINAhX32zvi9YFTc1q3HWLwQJCsKroOnL/m0UjiZpqBTF
	YMHIcaPfo0qi6mhhR+Fg1sfqSxluaYc=
Date: Sat, 25 Nov 2023 10:45:22 +0100
X-Soverin-Authenticated: true
From: "H.Merijn Brand" <linux@tux.freedom.nl>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Git Mailing List
 <git@vger.kernel.org>
Subject: Re: Fix git-send-email.perl w.r.t. recent Getopt::Long update
Message-ID: <20231125104211.5b7fe0be@pc09>
In-Reply-To: <ZWFaZcgzwEP13geI@archie.me>
References: <20231124103932.31ca7688@pc09>
	<ZWFaZcgzwEP13geI@archie.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mlTJDGx_mE8hFSl6o/hsqoP";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/mlTJDGx_mE8hFSl6o/hsqoP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 25 Nov 2023 09:22:29 +0700, Bagas Sanjaya <bagasdotme@gmail.com> wr=
ote:

> On Fri, Nov 24, 2023 at 10:39:32AM +0100, H.Merijn Brand wrote:
> > Patch attached =20
>=20
> Do not send patches as attachments; send them inline instead. See
> Documentation/SubmittingPatches for more info (hint: send patches
> with git-send-email(1)).

As I am used to PR's by now on all OSS projects I am involved in, or
use git commits or merges directly on the repo, I *never* use
format-patch and/or send-email.

These docs - yes I read them - do not offer a concise cut-n-paste
example for people like me. In order to have my relative simple patch
submitted (I already had the PR ready, but that came with a huge
warning that PR's are not accepted) I did it the way I did it. Now I
need to read and learn two new commands> I don't think that is very
user-friendly, but that might be just me.

Ironically, this patch is about the mail part of git.

I suggest adding a small example like

 # Create the patch basics
 $ git format-patch --cover-letter -M origin/master -o outgoing
 # Fix the subject
 $ $VISUAL outgoing/0000-cover-letter.patch
 # Send the mail
 $ git send-email --to=3Dgit@vger.kernel.org outgoing/*

> Thanks.

--=20
H.Merijn Brand  https://tux.nl   Perl Monger   http://amsterdam.pm.org/
using perl5.00307 .. 5.37        porting perl5 on HP-UX, AIX, and Linux
https://tux.nl/email.html http://qa.perl.org https://www.test-smoke.org
                          =20

--Sig_/mlTJDGx_mE8hFSl6o/hsqoP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEGolmczWuFi3lJEbAA6FHoT5dwJgFAmVhwjIACgkQA6FHoT5d
wJiaAQf+LDekzJ7mpHTx6VALAaaQew/4tRFPhITkXwfpd97v+3OfsHJ2Vj3eSvrx
AnEIc4kiPjYUz76cPzkPhq6zqEbF525ysz/RWSD6TcK6AtRpINFfL+C/MHg2qQ+w
qIyFlqsvcKPlJqGrQVNeUMedALt6VzH2Hrm5vogU/YHFyoAIRMJef2Yq0tS2BXHL
XjR46E6NMSqHXuyMYWM4DdRwdDwKdSZFm+Dl5uoUOp6lCFdQ5kd1COOdzoK/HfiE
JdJtLJQQS6TqBBUdFOIeCuyRXo0OPb9q4qK1YrNpCZDVgg4xcd4AgAxF795eIkIa
PEQBFcWtv7qaXN6OqdojfwMuxKQ4Rw==
=cNLW
-----END PGP SIGNATURE-----

--Sig_/mlTJDGx_mE8hFSl6o/hsqoP--
