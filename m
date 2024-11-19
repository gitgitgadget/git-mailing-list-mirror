Received: from mail-4027.protonmail.ch (mail-4027.protonmail.ch [185.70.40.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004861D2794
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 20:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732049382; cv=none; b=CkgQvS3Ou53wt+8GeIJgKen3GPCp+dnllB2YI5BPm3PaHHfgLDYrogyGJxABUgMnw+2pvnkFh4uSBUeo3RlUtRLgQjIfezKrKIDN2FwhGH7qRURHy5HTlsAKvcvEeO7Jzh8WXMXuNYD3aVu5rx/dsOQSKCT1IIlqJJPYHKLOY6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732049382; c=relaxed/simple;
	bh=tNOEt0IIcSROTTCwDRzvOo7xzKEFYNKCdsGAopzFoOc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j75h6s8schELUaZL7deEgFosFVS+AEkxv1pPhQIQEmpD+2hmrwjvHOche+eWR0gNmDAuRJcdqk1tH+HhEP/5hYwAxka+23GQnAO8r9v00UxMiVPOO0GAn+QxS0y9/vuPpBgaSDtsE6JZpy1f4xHjrxGAKYhRwLYBAYkixzuPxhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=WuwxDc5l; arc=none smtp.client-ip=185.70.40.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="WuwxDc5l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1732049372; x=1732308572;
	bh=xI8LdG9pe8O7NMdOYVXmUUak96D5T6Q1UkPrfyGYX70=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=WuwxDc5luILX8SFaNyaDoE8HtGNxwLgcL9t5LuPntNhqHiCuYzX2hvvHu60mlxBIt
	 MQzP9g0laeHSoo5i0p/DokSGswpJrAVefptPlf+cZGVt0aq6Dnam3eswflZCuezGd1
	 nFISYr3VVAQVo9d8wG1NAg3+0nkTx4O1elcZ3fi2f2qa9VSEL28TL1TWQwnH5NeTd3
	 57Xc/wlKVHtNwseuuW9iPD9xZcjwDzF4R3aOaDgBX9v7NB68Oa5Ctu01RqsQTPKl+1
	 U1vK2kznlHDaNQBovdbeUOrL2LDIu6OfmUYwjpblM/HeAmyP8WVZpiGE3lb/gzuiDR
	 HmlJTnx6VwYsg==
Date: Tue, 19 Nov 2024 20:49:29 +0000
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
From: A bughunter <A_bughunter@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: How do you undo an add
Message-ID: <gEGJ85bqla-NTL4ZJ1yt-zAAIaIYhp0s7hy3EJNmb5rF08NptfrexXMHZO6p4vZ7i6atRVsB09dlJ2z4hEXtOhH8MlqVpSg_8GlBDn6GiGM=@proton.me>
In-Reply-To: <89DnJJL6nbYjQW9N8CtejlqbnzPDiH7iKd-3zKFY8oQezk1rRYbjH5WkKdrVPYPQQsKPhMpd3IcBet7ZBD4U3HSSoXk6rVXIMWPaG4hAj1g=@proton.me>
References: <4hiTc8Kx5yNhYuN8abv3QFJBuptM6VWZ9OKvkdZFlSI5y0zoK-lN_VHf-QCSEjllmSWvu9V-tbrvFOx17_P0Nq8UKxEcK3Rs2d02FjbYuUc=@proton.me> <MBCJkxhVnx5AhlKkq15aTn5FYI6cG-wdqqwQ84mVH9zjf-YehSrRWPgd-UwdTMrYhS2Sgofbyn2bS7iMlANyyYf_Z6b6_e3FH0hRm5VYciU=@proton.me> <022f01db3a10$7fe28140$7fa783c0$@nexbridge.com> <271da43e-22d8-4f67-952e-72d2af8f6b1b@app.fastmail.com> <89DnJJL6nbYjQW9N8CtejlqbnzPDiH7iKd-3zKFY8oQezk1rRYbjH5WkKdrVPYPQQsKPhMpd3IcBet7ZBD4U3HSSoXk6rVXIMWPaG4hAj1g=@proton.me>
Feedback-ID: 120910843:user:proton
X-Pm-Message-ID: cd6902e19817279759729e7d575a95f5dc9ee79e
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1=_4DZdeqq409lkT5Ro67s580dvBpPIRpeTfCXazm8A"

--b1=_4DZdeqq409lkT5Ro67s580dvBpPIRpeTfCXazm8A
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

After looking into filter-branch here is what I found out. from the docs:

WARNING
git filter-branch has a plethora of pitfalls that can produce non-obvious m=
anglings of the intended history rewrite (and can leave you with little tim=
e to investigate such problems since it has such abysmal performance). Thes=
e safety and performance issues cannot be backward compatibly fixed and as =
such, its use is not recommended. Please use an alternative history filteri=
ng tool such as git filter-repo. If you still need to use git filter-branch=
, please carefully read SAFETY (and PERFORMANCE) to learn about the land mi=
nes of filter-branch, and then vigilantly avoid as many of the hazards list=
ed there as reasonably possible. ( https://git-scm.com/docs/git-filter-bran=
ch )

So here a git beginner, myself is cornered into navigating a "minefield". I=
lluminated language that git is full of undocumented known bugs. I see now =
what this facade of rejecting bugreports is about: it  seem's about the bug=
report recievers do dance around the jargon term "bug" in favor of various =
possibly more accurate 'illuminations' however as I have put in plain engli=
sh a bug is a defect.=20
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKACcFgmc8+dYJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu
8pkAAAxwAP9ISjq2ja8Oc+BzmVTd39zFQ7G/fIuqRPvPhEoK9w5uIAD+Jtia
wSnZYAEkEIPi7wAFU1wBhsgp6eU0Z5OMZhQM0Aw=3D
=3D2LbM
-----END PGP SIGNATURE-----

--b1=_4DZdeqq409lkT5Ro67s580dvBpPIRpeTfCXazm8A
Content-Type: application/pgp-keys; name="publickey - A_bughunter@proton.me - 0x66540805.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWnUwWDF4WUpLd1lCQkFI
YVJ3OEJBUWRBSDBJNDdqRHNQWjZndmIrWVVHQm5BeDdKeWYxNEFWT0gKeGE4eTArZG1ONWJOTFVG
ZlluVm5hSFZ1ZEdWeVFIQnliM1J2Ymk1dFpTQThRVjlpZFdkb2RXNTBaWEpBCmNISnZkRzl1TG0x
bFBzS01CQkFXQ2dBK0JZSm03UmZYQkFzSkJ3Z0prS2tXWlRsUXJ2S1pBeFVJQ2dRVwpBQUlCQWhr
QkFwc0RBaDRCRmlFRVpsUUlCY0F5Y1oybE85ejJxUlpsT1ZDdThwa0FBRDlGQVA5L2RkVDYKNTZH
a2E5TnRNdm1kb1k1a3ROZ3FiWTVYYmQ5Zng2a1BFNS80dFFEL1hpaWFsS1FIam13QXRiY1NlMVEr
CjNjeFlMeE5oalU3bXluUXNwdjlkeEFET09BUm03UmZYRWdvckJnRUVBWmRWQVFVQkFRZEFuZnAv
ejJGdwpSa3B2VWdmN21xWUk5UktuVFZhZHdHZmdhUUxobXdnM0x4TURBUWdId25nRUdCWUtBQ29G
Z21idEY5Y0oKa0trV1pUbFFydktaQXBzTUZpRUVabFFJQmNBeWNaMmxPOXoycVJabE9WQ3U4cGtB
QUppOEFRQytmbk9tCjRWajlRbUg0SDBHVnQ3UnVPUUsrd09RMVBSdnB5bVNqZXlCSk93RDlHWXV2
eE9BVks4aUF1cEorcHB3TQpyMzZWdWtJZTFwWHVIbzlSaGp2ZUF3MD0KPUZRRncKLS0tLS1FTkQg
UEdQIFBVQkxJQyBLRVkgQkxPQ0stLS0tLQo=

--b1=_4DZdeqq409lkT5Ro67s580dvBpPIRpeTfCXazm8A
Content-Type: application/pgp-signature; name="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - A_bughunter@proton.me - 0x66540805.asc.sig"

wnUEABYKACcFgmc8+dYJkKkWZTlQrvKZFiEEZlQIBcAycZ2lO9z2qRZlOVCu8pkAAHNbAP9c1PCs
KP5869QlfDlW1cIxwVh8VgGJ31tna46+p6lxqQEAhkRM20VCSHCPdG/R5TZBZusHYmsfasmzx5Ht
336kQQM=

--b1=_4DZdeqq409lkT5Ro67s580dvBpPIRpeTfCXazm8A--

