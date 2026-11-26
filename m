Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795690142;
	b=hTPhoa92Hfr4Ktm5S/A9AA+Qtqh5/CKbnR1fUoNMc8d+yjLa/a/thnHkqRjyq837YeV+
	 ZN8eFjjwULmjMMuDHzcdA957DaZttQDuLF+wq4G5i6hOls4EQhsgEBzN67nzFV3DprEka
	 dJo1zZL/ffVo70+DhsH0Qafwq+LI7u/ghJmhpON3ElLMYVKKQR2BcpS3n5Xw5qK0/R6yC
	 QPPncKXy06eoPks05xqYGLnqIqJfp6/wq+KTFciGfj9Hz02OVdNvJIbLcKoKoaFww6iuR
	 kgOmak2Yls7lQWOjWCAbK6SU03EG7qNUBKOXk73/puvZy4nSE3Ygo141AwGdv5YyP4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795690142;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type;
	bh=+j43dBbbqpP/FEG3jicw374fyjWjBmMbELD2muPvD6s=;
	b=DCL8d/2MkcqbJoDTEO/QFAkIu83VvNHKl0xs8g5ZZxRhhQ4Hh0e28t7O5H2LXEyAW47T
	 z49X7qbLDF75QVV4eTRPTE9vZl9iXqur6CSB7QLt5tNY4qKCgntKlIf30JDSJDFUTkLVM
	 GfQpt/i4o2eyP9BQDVNQPsJ+8C6yjNKx+YiAdc7IQL/+LTi66tPU+4sDO42mzo9ABHi0T
	 cT6ETy8/bZ8FYXp+JwC8ZfLxJifDMDnN6hciOoA1JPIXZJHWRd3Rl4l8to2K3PR6IOBCk
	 uGxKFm1/ASErdhI6RYYuZflTP9LRTZXYg7tyQdn7pDgWtTyjQ/mmlHk/LI2L4Rok/ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=jIfbIaLv;
	arc=none smtp.remote-ip=109.224.244.25
Received: from mail-24425.protonmail.ch (mail-24425.protonmail.ch [109.224.244.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981AA606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 10:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 981AA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=jIfbIaLv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1795690137; x=1795949337;
	bh=+j43dBbbqpP/FEG3jicw374fyjWjBmMbELD2muPvD6s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=jIfbIaLv7wq4KDIQ9ObMAo9x6qcMvjM8urrtgF5zOZ1i8gleJm/DIxfSjenEgl3ef
	 Kw4qBwusGW4nJ9f/C7I8KxOj94wVAXJqc28Mu1G4RqP9dnpqKa088t77ij18MODvYl
	 ffOTg6hUmtTa93KFkgtmo5bfN9NDQ08DOYHnZ0kuX6kyhi2OY/A5oPetGK/G9BfjbH
	 Xh9BNkED62Xgw2bngz/PjqrnBngt5nvw85Zmog97X8RyqUHEIUhYU+8x9myPP9f+VD
	 o0qWqVvEo8UOpitGcxxuytgwr79K+uob7o+JoJzq9Zr1hjPG8giCjU96OP/cmxIVsx
	 QUeNYukCKy9MA==
Date: Thu, 26 Nov 2026 10:48:54 +0000
To: Junio C Hamano <gitster@pobox.com>
From: ATTILIO ALESSIO <attilio.alessio@protonmail.com>
Cc: Alessio Attilio via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] pack-objects: handle missing promisor objects
Message-ID: <pRWo4Tw9YFIfXYAp-9Mj2dktr8BL5TIZT3pKYwIljnb4WujAajPZVrpdTLivqm0YZ-ydfpq1WY5gqara_1l9T7h1Ml5BR7E0SJQs6Rn9-jo=@protonmail.com>
In-Reply-To: <xmqqpkvsv1mi.fsf@gitster.g>
References: <pull.2333.git.1795635624820.gitgitgadget@gmail.com> <pull.2333.v3.git.1795648282594.gitgitgadget@gmail.com> <xmqqpkvsv1mi.fsf@gitster.g>
Feedback-ID: 158305026:user:proton
X-Pm-Message-ID: 34f5062c1dbe450a22a4e94a0f6875d10ff6c49b
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------1b20548ba7f20059aa5dbd3632bbbc8bb2a39d8f3c0e8ebefffe5ca9aea0d312"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------1b20548ba7f20059aa5dbd3632bbbc8bb2a39d8f3c0e8ebefffe5ca9aea0d312
Content-Type: multipart/mixed;boundary=---------------------b546aa6693a591ede5ea3dc7b7c7e452

-----------------------b546aa6693a591ede5ea3dc7b7c7e452
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8


Junio C Hamano gitster@pobox.com writes:

> It is not considered good manners to send a new iteration before
> first finishing the discussion on the reviews you received on your
> previous iteration. You respond to reviews, saying =E2=80=9CI will fix t=
his
> point=E2=80=9D, =E2=80=9CI think this one is fine as-is because...=E2=80=
=9D, and so forth,
> wait for responses to your response, and eventually come to an
> agreement with those in the discussion, so both sides know what the
> next iteration should look like before you start working on it.
>
> Only after finishing all of that do you prepare and send a new
> iteration.

Understood, and thank you for pointing me to that section of
Documentation/SubmittingPatches. I apologize for rushing out v5
before replying to your v4 review and allowing time for others to
weigh in.

Going forward, I will make sure to respond to review comments on the
thread first and wait for consensus before sending a new iteration.

Since v5 is already on the list with the updated commit message and
in-code comment addressing your v4 feedback, I will leave it as-is
for now and wait for any further comments from you and other
reviewers.

Thanks,
Alessio
-----------------------b546aa6693a591ede5ea3dc7b7c7e452--

--------1b20548ba7f20059aa5dbd3632bbbc8bb2a39d8f3c0e8ebefffe5ca9aea0d312
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

wrsEARYKAG0FgmsIDocJEChTxUkNXp/XRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmcpLMax7ynJZN4dYUdMTpKslcyc2OH4IOrfRV/B
XnLj0BYhBFac0FsKMyEPbw2vTShTxUkNXp/XAAAeIQD/V1C4kYHSQr92Dkdf
x6vr3xKH9J89LbW19CdMUrU12hQA/iscSLViobr2OO+2a7xgWEYjQI8hqZ5j
Itglu3ocDtYM
=oDG3
-----END PGP SIGNATURE-----


--------1b20548ba7f20059aa5dbd3632bbbc8bb2a39d8f3c0e8ebefffe5ca9aea0d312--

