Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB88C4430
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 04:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728273711; cv=none; b=pVYJscTww/epdcQZq5d2nBdTgawr5D6EIZD2JWT1nf+RyUmZG7aiLoBs5ccnN2mhUhDgdBIcR1o7GMrnwNZ6AD2jpGp01KPq/dWTRoyfBB4dgue1WOrhLps16LFN8VAcnNZxt3CKZKObkCH+RteLqXWcuYgRBtNn0lLynHJ1UJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728273711; c=relaxed/simple;
	bh=+s+cnd0DILl8fFSZs9Dqwo9OpUn5B0L5Ljolz0EtGyk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVBUaV1duDy93C5MMRDSBw6+xmKuOvHxJ18KEQ4+SJljvzD9RYwJ3HH8nh3FVR9GYfnh4Qmo3FfGQ31yKWj/zHd5o9ND4O+ROSHJsfMdlvYuIZYiLbf13+zTesaso0uvJVvITuZDRqQyz1b5mIYVrPW3NOgxnIabZD2BpYt3GF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=X9GoxhUU; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="X9GoxhUU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728273707; x=1728532907;
	bh=femaD9AXQsABDcEealY5Yh+KDYbknDklzSan7zlUXBw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=X9GoxhUUJJbkPeut4iFLO1HWBffiFmPTs1R27NDxwGGiA5BZhC8MVpi84RLhmOdyB
	 xBmaK/sVrkXUDTxRYRss80zdp4B5VoxE00ykFWbn2rolOnzxDCrDALVeS5c4+md0Hi
	 xDNiDd/dxWVNClH4zzuifEB0I/idDZ3y627FI/R6ajatznozbMNjcTWsq8ac7iNRHZ
	 GEu36VzD+qNRFBylbn6dg6I1UPwjY2DBHsBEFxknXShsyRdCQdtcNxkW1jmAm6eBQu
	 MxBQPADf3tAcaJUMjKXB9tJfAdvDTPYtryWHqQtufx0fR1JySP8jo7c9sIpKnfBg0v
	 MWVMTjs8bECcA==
Date: Mon, 07 Oct 2024 04:01:43 +0000
To: shejialuo <shejialuo@gmail.com>
From: Caleb White <cdwhite3@pm.me>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/4] worktree: refactor infer_backlink() to use *strbuf
Message-ID: <7HnZc9JpxZXOAZFD6AO0MdhWccomQBZJmS_IzwiA_-YpmFlQPAjeMJBvP9uBI_6s6-crP3SXWZTrErwj918xIuOAo7TmzqEZek8FV0IMhrg=@pm.me>
In-Reply-To: <ZwNb5Aabrub4tW5O@ArchLinux>
References: <20241006060017.171788-1-cdwhite3@pm.me> <20241006060017.171788-2-cdwhite3@pm.me> <ZwKoNg-HYGaohvCd@ArchLinux> <CAPig+cQC45_Pofw31h2RSydj_CjqpfajLLa5O_sR9m0AQh5OVw@mail.gmail.com> <ZwNb5Aabrub4tW5O@ArchLinux>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: d9cc749e9f6c2fedc23a8532eb464ad63694936c
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------08fcf7496c933bea8f9e0a39eb734bdbd4e2c3c19dd193700607543e93570c47"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------08fcf7496c933bea8f9e0a39eb734bdbd4e2c3c19dd193700607543e93570c47
Content-Type: multipart/mixed;boundary=---------------------5c608126c13948765ed49c3db7261d9f

-----------------------5c608126c13948765ed49c3db7261d9f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Sunday, October 6th, 2024 at 22:56, shejialuo <shejialuo@gmail.com> wro=
te:
> The reason why I don't think we need to check the "err" variable is that
> the "git_contents" and "err" is relevant. If "git_contents" is not NULL,
> the "err" must be zero unless there are bugs in "read_gitfile_gently".
> So, if we already check "git_contents", why do we need to check again
> for "err"?

There are two other error conditions we check, and one of them we try
to find the inferred backlink (so it is not a failure path):

```
} else if (err =3D=3D READ_GITFILE_ERR_NOT_A_FILE) {
	fn(1, realdotgit.buf, _("unable to locate repository; .git is not a file"=
), cb_data);
	goto done;
} else if (err =3D=3D READ_GITFILE_ERR_NOT_A_REPO) {
	if (!infer_backlink(realdotgit.buf, &backlink)) {
		fn(1, realdotgit.buf, _("unable to locate repository; .git file does not=
 reference a repository"), cb_data);
		goto done;
	}
} else if (err) {
	fn(1, realdotgit.buf, _("unable to locate repository; .git file broken"),=
 cb_data);
	goto done;
}

```
-----------------------5c608126c13948765ed49c3db7261d9f--

--------08fcf7496c933bea8f9e0a39eb734bdbd4e2c3c19dd193700607543e93570c47
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnA10YCZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAAD0TAf6Aif8SF8P72x9wqGcw0ZxEzY7Zm0himm9tig41NvL6/iE48es
YxeDQQf7DTXuNn9kLhuCZAadobZTJFg0V1JzC3S2LjgUfIcHi4smxnrSA9We
KTyEYX3eFsUGqULPOjDFFPnRH/riVLaogdplqPNOUrpyMdGcRo2t1OeLNmsW
GORcNEkOHqpp0Cvx6qwGyaeokgkKRu4t4JreIN/w1TLtP/+WnGb0DpNKO6JG
e4GXqEwy0DPK2lmHU7JhbIaZL4GNKpi7C2nJVSddB3SBbW0POyrKY33szsdZ
cEqbeklu4tdAcTmbBkypGS6AqReA0FrWdF2oOT5GH6b9V2Puh/gSMg==
=Q2A7
-----END PGP SIGNATURE-----


--------08fcf7496c933bea8f9e0a39eb734bdbd4e2c3c19dd193700607543e93570c47--

