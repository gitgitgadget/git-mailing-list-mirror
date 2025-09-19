Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D9D1E3DE5
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 18:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307315; cv=none; b=DATcJKqN8JubYGtJGFX+/4I2/nFVr2bZEXJwXuyQ9bsDfVG0xIMgkrXqqo5YTGJkNADzBXNmxvCJ93i/jIjRwnjnRIG3nOjaOdZvtIAluNloPUjiq+oYfNz+sm7s48muNmOpS3R5b1NkIeFA4siVmTPbK9dwFx6HKqslFrq1MlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307315; c=relaxed/simple;
	bh=UOYvPub1ggynwoMzDpOetT5qZNT0DS3sj1pUWo2QHhA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jNEvZ9AXfah8abXfqClAKqXPFmQ2HFzaAS0pKEtLM3JvHPt7tIkrJ/U9jILnN0lPWmdrzBVrZWzlH8HcEs62V2hYDxzCS9zMVIhpeqXhhalr74u7lmPoXHIVWFnEf0C29fHxrDPmwPjZyyaNQY93mhvoo/UoiwP65zehKsZivSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=ZdstdO7Q; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="ZdstdO7Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=b/djngolxlwgFkRGOCpOqycUvMFudGbES1eEVEoc0fU=; t=1758307311;
	x=1758912111; b=ZdstdO7QPzgkpOFjrPAoO2PGcCjmqT2AejP9Lt/4BUnj++cbMIzD45aPCnLl+
	afNQTmBbE5SbpKgPdsh4ieTs6VbgMUbbRJHPnSQ/jMHY2QbwCUxnxqjUb2TtdidbNcq0Xoz4WvTm+
	YkP/yEvY7N/bpuMMfUEH8zdivEec6ouz+UiDuoErAlyrwX++sq+M8qQmzQeBupJnq5ikW1K2xPHI3
	mc6+LctFe6iF76Jdh98F+CB9GfrFIUifCZbd5gayqt3RH0CBOqG16lV/nZmSkw4YqtbOU8WUI0IzM
	2v89R63eXnM4aRrFJgj0aUYIvYrpq5S+FspcTJ/am77UHyhyQA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uzg3G-00000003BB3-3vR7; Fri, 19 Sep 2025 20:41:46 +0200
Received: from dynamic-093-128-174-248.93.128.pool.telefonica.de ([93.128.174.248] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uzg3G-00000002z71-2sB4; Fri, 19 Sep 2025 20:41:46 +0200
Message-ID: <6674eb07df107d786b747ccd6dce4555d36d5d2c.camel@physik.fu-berlin.de>
Subject: Re: [PATCH RFC 0/3] Introduce Rust and announce that it will become
 mandatorty
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, "brian m. carlson"	
 <sandals@crustytoothpaste.net>, Ben Knoble <ben.knoble@gmail.com>,
 Christian Brabandt <cb@256bit.org>, Collin Funk <collin.funk1@gmail.com>,
 Eli Schwartz <eschwartz@gentoo.org>,  Elijah Newren <newren@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>, Johannes Schindelin	
 <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>, Phillip
 Wood	 <phillip.wood123@gmail.com>, Pierre-Emmanuel Patry	
 <pierre-emmanuel.patry@embecosm.com>, Sam James <sam@gentoo.org>, Taylor
 Blau	 <me@ttaylorr.com>
Date: Fri, 19 Sep 2025 20:41:45 +0200
In-Reply-To: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
References: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hello Patrick,

On Thu, 2025-09-04 at 16:26 +0200, Patrick Steinhardt wrote:
> this small patch series introduces Rust into the core of Git. This patch
> series is designed as a test balloon, similar to how we introduced test
> balloons for C99 features in the past. The goal is threefold:
>=20
>   - Give us some time to experiment with Rust and introduce proper build
>     infrastructure.
>=20
>   - Give distributors time to ease into the new toolchain requirements.
>     Introducing Rust is impossible for some platforms and hard for
>     others.
>=20
>   - Announce that Git 3.0 will make Rust a mandatory part of our build
>     infrastructure.

I'm one of Debian's maintainers in Debian Ports and I maintain Debian unsta=
ble
on older and more obscure architectures such as alpha, hppa, m68k, sh4 and =
sparc64.

Of all the architectures in Debian, there are currently four architectures =
that
don't support rustc. Those are alpha, hppa, m68k and sh4 [1]. For m68k, the
situation is special as both LLVM and rustc already support m68k but with L=
inux
still defaulting to 16-bit alignment on this architecture [2], building LLV=
M and
rustc is currently not possible. I'm working on a switch to 32-bit alignmen=
t
though which is default for NetBSD/m68k and also what specified in the offi=
cial
SysV ELF ABI documentation.

In general, I'm not against introducing Rust support into existing projects=
. However,
I wished projects would be a little more patient until either the GCC codeg=
en in
rustc called rustc_codegen_gcc [3] or the Rust frontend in GCC have become =
ready
for prime time.

My hope would be that more talented Rust developers would help support the =
two
GCC Rust projects so that these become ready for prime time sooner and that=
 one
of the last blockers for introducing the Rust language across a lot of open=
 source
projects would go away.

I'm not an expert with the Non-Stop operating system, but I could imagine t=
hat
a working Rust frontend in GCC would ease porting the Rust language to that
platform as well.

Cheers,
Adrian

> [1] https://buildd.debian.org/status/package.php?p=3Drustc&suite=3Dsid
> [2] https://wiki.debian.org/M68k/Alignment
> [3] https://rust-for-linux.com/rustc_codegen_gcc
> [4] https://rust-for-linux.com/gccrs

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
