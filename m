Received: from mx2.catap.net (mx2.catap.net [65.21.79.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29AC285CA7
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=65.21.79.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758357411; cv=fail; b=VbkaeTXL3oq43zqED1E2K/l13L+9ykSmWJNmZm6Q8T5/trV+3U31EcRcPDZBLe1Ly2iMzHnLNF248h9zbSveiZVNXkdwV6QAwuTQNjT3xVwIg8rr8ge4ZSNjQoZHy1/ykNInSkJwI9zF4T6YFfq8cWAu37LNmayOXyRA8NBzoXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758357411; c=relaxed/simple;
	bh=djpqWotsZ5ul9vwa+N8ha2CHjn1RKrkUoI9Ix41Fh7g=;
	h=From:Content-Type:Mime-Version:Subject:Date:Message-Id:Cc:To; b=MToprv4/OCmrq9fBsIQC7acZ/1PJgV79JmGhXyCGsqvnIUfn+MCxREA21WwJ5Y6XtHBiVOzgvhCRk4g5ZiJO7bJA6b1/qD5o6AtZjm5/usfA/9D2HplaLPffTcGnLbO1s65tRAApHq9UBPKMxcYZsS/ovtQE9aYAB9SyqNbQ2pQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=macos-powerpc.org; spf=pass smtp.mailfrom=macos-powerpc.org; dkim=pass (2048-bit key) header.d=macos-powerpc.org header.i=@macos-powerpc.org header.b=fxpX1NWJ; dkim=permerror (0-bit key) header.d=macos-powerpc.org header.i=@macos-powerpc.org header.b=tYvgKegE; arc=fail smtp.client-ip=65.21.79.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=macos-powerpc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=macos-powerpc.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=macos-powerpc.org header.i=@macos-powerpc.org header.b="fxpX1NWJ";
	dkim=permerror (0-bit key) header.d=macos-powerpc.org header.i=@macos-powerpc.org header.b="tYvgKegE"
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=D6FIwhs
	0tcs7qgxcs1Ndw0Pgc4g91dRvev42PoJd/NBerTT+sCjjVbHiAsgPEtsnyHLAwIDAKd9Nf
	lPYu2MAAEjWIGG9R5oA16MWWvNZIJeYZlabxowjQ3NHN9NCKzN66jlzxuPyq1Y7Mt1M+8b
	aOcOEuqPabJf4vmb9DOVxcIp1GkNsDRsScFVztOAnrokb2QJwvH8pGXQe7CGcc+n+IbvnU
	vBXngi1KjTo9o6cL+aOnt8CeKloHOaoykJtB6KX7IzlHgb1nPaB3AuqvJvwHQ/nIooumWy
	GqenP5JiWfgn465lei9uheIDlsRj3ib5k/ssn6jAQIF4FZeBtHE95EA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=d
	jpqWotsZ5ul9vwa+N8ha2CHjn1RKrkUoI9Ix41Fh7g=; h=to:cc:date:subject:
	reply-to:from:dkim-signature:dkim-signature; d=mx.catap.net; b=t3Uj5NJ
	t9lxnDvyM+Vudr0AQFIDMZ8fcmYQAWTnqYDi1tN2cVNExOSIzI2Zz6yuBKQEPrEeMyqhup
	9TRIImnqE7qN+M4JEAYlf1vr2VZLDvS/bDyF6EG0q6TIp7dqlsHiF62YRYFlFu1FjDLNuJ
	6Ut95CsZAbumS6nekQI+jyabGe3/t1w3hYs34FNfFHcvGKftiV3ArLthb8ICf/9SrZVDRF
	j7f2RlHu3nzVimeuU8HvFSFft5onXS0YT00+G/kL3G+1I+AHCUmSdK7GIA5z50tmnGpF7K
	kVEXareQGuVkp1liLVpivjWwmSEtR0LR/0FjukG/AvGYPHfROAOz3Eg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
	header.s=20240125rsa header.d=macos-powerpc.org header.a=rsa-sha256 
	header.b=fxpX1NWJ; dkim=pass header.s=20240125ed25519 
	header.d=macos-powerpc.org header.a=ed25519-sha256 header.b=tYvgKegE;
	arc=none; iprev=pass; spf=none smtp.helo=postmaster@smtpclient.apple;
	spf=softfail smtp.mailfrom=barracuda@macos-powerpc.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=djpqWots
	Z5ul9vwa+N8ha2CHjn1RKrkUoI9Ix41Fh7g=; h=to:cc:date:subject:reply-to:
	from; d=macos-powerpc.org; b=fxpX1NWJ2smPoTJGdPjiIy7bWs7YxCgOETmOz8HOR
	ZbAaXyB2+Fid3feSwISwpLqVnccRfwW+YIWEtJ6IMI4S9m8QIHt4IUF7dIX++ZleVKDTZd
	cDTI490yQefIB1Gm4peGZCrD5yjvwUT+aLIlOkTH7fCUmES6Vv5tJFsZDV6ZoNueK6q0tU
	B489VExkpqLJh8x/1j8P6tZM4FJPIpl8dlHiJw7Rk7rlTJL1+R64IIWqF29pz5oLy9Zrct
	/JGLVONgTHdrXTC0iAB0wkOJ9K8ix7licgJbJ6/pZuajjG/BZWK9Le44ojQ46A2utw5jTA
	KhYkHeP8fArNjS7PsAh1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
	bh=djpqWotsZ5ul9vwa+N8ha2CHjn1RKrkUoI9Ix41Fh7g=; h=to:cc:date:subject:
	reply-to:from; d=macos-powerpc.org; b=tYvgKegEWOtclnPvIbsJyJ0LZYQsl9Nx
	8zcnizqRwCApM7fzs68foBPD4BH5qc2Ox5XkMBTbNErhIAmDllLuBQ==
Received: 
	by mx2.catap.net (OpenSMTPD) with ESMTPSA id af7d2625 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
	Sat, 20 Sep 2025 10:30:09 +0200 (CEST)
From: Sergey Fedorov <barracuda@macos-powerpc.org>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Reply-To: CAH=ZcbCUL-rWw5E6p26T0039gs9q-P8iK5fp73-RzTzKiZ0zMQ@mail.gmail.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH RFC 0/3] Introduce Rust and announce that it will become
 mandatorty
Date: Sat, 20 Sep 2025 16:29:47 +0800
Message-Id: <8799E6DB-FC85-4F71-A6C1-363D1AC8ED06@macos-powerpc.org>
Cc: 20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im,
 Johannes.Schindelin@gmx.de,
 ben.knoble@gmail.com,
 cb@256bit.org,
 collin.funk1@gmail.com,
 contact@hacktivis.me,
 eschwartz@gentoo.org,
 git@vger.kernel.org,
 gitster@pobox.com,
 me@ttaylorr.com,
 newren@gmail.com,
 phillip.wood123@gmail.com,
 pierre-emmanuel.patry@embecosm.com,
 ps@pks.im,
 sam@gentoo.org,
 sandals@crustytoothpaste.net
To: ezekielnewren@gmail.com
X-Mailer: Apple Mail (2.3776.700.51.11.1)


> but I'd like to hear what OSes and Architectures you use personally =
and professionally and why adding Rust would be a bad idea.

I am the maintainer of ports for Darwin on PowerPC systems (few past =
years in MacPorts and now in =
https://github.com/macos-powerpc/powerpc-ports fork) and contributor to =
GCC (gfortran). I have added the whole of current R ecosystem into =
MacPorts and a decent support for modern Fortran via FPM.

Those systems are still actively used, and thanks to GCC upstream =
support of powerpc-apple-darwin I have been able to keep our ports =
pretty much on par (occasionally ahead of) what modern macOS has at the =
moment. A lot of work has been done in past two-three years, including =
fixing/restoring support for ppc for several major langs/compilers =
(gfortran, MLton, SBCL, Ruby, OCaml, Idris2 etc.), build systems etc.

Git is essential for the version control, but also for the build systems =
of MacPorts and CMake. Since my powerpc ports rely on MacPorts =
infrastructure (there are 40k+ ports), I need a working Git for my =
workflow.

To be clear, I do not object to adding Rust optionally (as I would not =
against adding optional modules for any language), but making it =
mandatory, while Rust is still broken on a few, admittedly edge case, =
systems, hurts the open-source.

I agree with John Paul Adrian that once gccrs becomes properly usable, =
or otherwise gcc codegen in Rust acquires support for currently =
unsupported platforms, things will change.

P. S. I have contributed to mrustc, so it is not ideological. Though I =
do think that ability to bootstrap from source is strictly required for =
a compiler to be safe, and at the moment bootstrapping of Rust may not =
yet work for all supported platforms (at least it is not well-tested).

References:
https://github.com/rust-lang/rfcs/issues/1312
https://github.com/thepowersgang/mrustc/issues/300

Regards,
Sergey Fedorov
macos-powerpc.org

