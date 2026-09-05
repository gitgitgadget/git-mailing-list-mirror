Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A854B0C88
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788625788; cv=none; b=WACSKz/ypdYuSRRvk30Oq2iAZ36MOTmwKQJ3ISNG7PaXBprpPrnvwLBK0fCVPkhddXuYQpDz83/jKIJCSM762NOCV44EnEjVY4hqlD4kPFgOcZ3y3AgZQKPMaPIWuEA/6J4BA6xF/j9ybXduR+Ao0mObRDtLphADToqv+tOP++E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788625788; c=relaxed/simple;
	bh=fIsxRzmvN11APklAXhRsCqp0u4+aBSjUMY1aqSIlWfc=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=a9PY9gZeGU6SwdPgQ9ZcCK2EAFapPtPPyNpVSVJv+8CFv6qKYuzf5pfutg1ScJ91YZ1DdhIr66sAjU/dtLHY5c0SpWTwlkJqHPcqFcIs2RSTRVc2L2vTI4KJnzp4ES5kawzAZ9q6ryx3p63xjsc+HRBZjNJ56ZXTP4E8t66JSzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=HtMdQEal; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="HtMdQEal"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=qb2ensrm4narvgaayrcabsqlje.protonmail; t=1788625777; x=1788884977;
	bh=1MgBCcINdTp5fQZKrd7bBfLzNajbz6QrMcJ3adPaFko=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=HtMdQEalkNPv4KiyczTUxonsOlRWX7uvqMkTqXT+xYAljQPGmc+0rCrCFO+RmRbIT
	 3P16Q5gYWFAiDlyPhhQ6suevTVR6M3b4l54BIkEXYFBG9gpzf6lLnpSRhbzazg6ZIv
	 mdmGmePk7Bk/x4utTeolP5gnYOYuwvWtG/u61nvL1ZXbtQfY13+BLaBToZ2YY7IEdl
	 VvpboC8Wgm48QeBzJD8dk57F1C19GP1AAPkDGvkOgRccLD3OyerqLSoSHCdFX9PmFM
	 KaopHbaAEYhua9wBwCd+YZR9p/Tb5i/MGG9B2pWBJMrddWFSDXdtO68+QbIfXjZgY4
	 0NQUBwQ5DBPZQ==
Date: Sat, 05 Sep 2026 16:29:34 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: Fabian Kratz <fabian.kratz@proton.me>
Subject: Typo in man page for git-merge
Message-ID: <T7GtKqbLStRVv4G9RYr5tCWEEkfQ5s-KzbS0OeeKfVArboamsIObGafTbl_XHsXRcCP3XjsR0xEqOsU3OzGVIurZWLGOnsUO9ZUn9UG0XHo=@proton.me>
Feedback-ID: 45245405:user:proton
X-Pm-Message-ID: 159642a2a94953668c4efd40281257c829c6cc1d
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------59d16bf9cc81210badc150ff4ca34bf96a327306264a1a49eabc6eac30adc046"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------59d16bf9cc81210badc150ff4ca34bf96a327306264a1a49eabc6eac30adc046
Content-Type: multipart/mixed;boundary=---------------------f4b45e6003859c6936854fefc8e66074

-----------------------f4b45e6003859c6936854fefc8e66074
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hi, I just read the git man page git-merge and believe that I found a typo=
/error in an example. I don't know if this is the right place to post this=
, but this is the section:

> Assume the following history exists and the current branch is "master":
>
>               A---B---C topic
>              /
>         D---E---F---G master
>
> Then "git merge topic" will replay the changes made on the topic branch =
since it diverged from master (i.e.,
> E) until its current commit (C) on top of master, and record the result =
in a new commit along with the names
> of the two parent commits and a log message from the user describing the=
 changes. Before the operation,
> ORIG_HEAD is set to the tip of the current branch (C).

I believe ORIG_HEAD is actually set to G here, not C. My own experiments s=
upport this and it's what I would expect after reading the explanation.
-----------------------f4b45e6003859c6936854fefc8e66074--

--------59d16bf9cc81210badc150ff4ca34bf96a327306264a1a49eabc6eac30adc046
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmqcQ18JEAxaWVVkaq6BRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmfvzR01tOIHVniMv+P1JwztM/poSHDEK2Wf9/Bc
0lmYDhYhBAV+4qdo7VnPymClHQxaWVVkaq6BAAAyqwD9GVB2V7ySwU7GMV/u
WBuE+ggAhrpAc3sCyDyjSNZPwB0A/j1KemZu1jaXGVRyf9V5dIDC1kEtEJjr
AbkQxMlL+tEB
=8xJx
-----END PGP SIGNATURE-----


--------59d16bf9cc81210badc150ff4ca34bf96a327306264a1a49eabc6eac30adc046--

