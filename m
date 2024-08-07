Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3581459F6
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 21:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065677; cv=none; b=pdzPWD1074E8BTSWAYGLTHvLbaKmLti7GdVo/1nO7IzBtgZomR0nzBIH5x3upiT1Y8T6HgeJirdKJJSUxh11IRQHzL+D9NEqxZTDNHMZ19Lm7eGBUluZecnPshUqYgHSOYUhPJcew5TOG93qpWB4Q7xGVD6+xGc1nn83LuGU450=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065677; c=relaxed/simple;
	bh=SRx98VzXsN2mxXoZgWE6jOREp56SyPbC60SwosNnpVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dK0MquOnzIU6k6/uFtDvNR4yXQ+c4MgpVryaOUJ+b6gwjSS+VHsMQrVXaHYxDPofzIh4XnMUVRRvHBP4HboHuaLzowrTvT6qeBmqYB2LfPtu5Ive4BegElq274exnK0jMfDi7BDF9GTP/a2o3JmckWW1ifHW8z2iqWD42doeAsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=YUjoPuur; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="YUjoPuur"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1723065667;
	bh=SRx98VzXsN2mxXoZgWE6jOREp56SyPbC60SwosNnpVU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=YUjoPuurjLWuxxg8LmxZi03J1UxIsxEGFGnobFyH8dIyV7y0mm3Bptc9MH+gxrhHr
	 FtiPUYIbKv3w9VKSHagcVzqj1sL2ID6Q/IxctKXSK7QtTWPt8CjtrbtWTVjI484+N1
	 hPYKFLGe3aLVvJqHuWNpiesJEZMrEYkcr6ZGqRdwGDCLtSrXyXdFv7bLjDK5VnmG4I
	 E/FwnaRKhPlgGoldKfHhgcMIGUATVbHjaFADgn3JbYARi3KQfweD2qxJ7erwx9jBHM
	 /xhyX7/kyGNkZjzfnjb3NUKQwtCe/ysm4VrSszF0k10lTwmEgg1HO11Edw4OWGeFEJ
	 IAzeJFjD6bLWtMGZ37+Y06zx/jR6me2Ze101IoapCvNZdiWBZII4SJyPXGk9UvIMZ0
	 xmYzQo9nonjntlPTXGklOX3XqpCISiKVdRNxYg5A9TmvpVr522QiDnaNbwzI6cETUn
	 Tw3hcicJ02dZapDhuVCkqSfNG2+nhuCM6YxHZ5oMqv1ZtVXspUs
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 35DD8209BD;
	Wed,  7 Aug 2024 21:21:07 +0000 (UTC)
Date: Wed, 7 Aug 2024 21:21:05 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, calvinwan@google.com, spectral@google.com,
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 3/6] contrib/cgit-rs: introduce Rust wrapper for
 libgit.a
Message-ID: <ZrPlQRAGQDMnVGjo@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com,
	emrass@google.com, rsbecker@nexbridge.com
References: <cover.1723054623.git.steadmon@google.com>
 <9a846c17c891e17566a9907b3627210a6a08ea76.1723054623.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="waHZb/hlUzcSHUrW"
Content-Disposition: inline
In-Reply-To: <9a846c17c891e17566a9907b3627210a6a08ea76.1723054623.git.steadmon@google.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--waHZb/hlUzcSHUrW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-08-07 at 18:21:28, Josh Steadmon wrote:
> Introduce cgit-rs, a Rust wrapper crate that allows Rust code to call
> functions in libgit.a. This initial patch defines build rules and an
> interface that exposes user agent string getter functions as a proof of
> concept. A proof-of-concept library consumer is provided in
> contrib/cgit-rs/src/main.rs. This executable can be run with `cargo run`
>=20
> Symbols in cgit can collide with symbols from other libraries such as
> libgit2. We avoid this by first exposing library symbols in
> public_symbol_export.[ch]. These symbols are prepended with "libgit_" to
> avoid collisions and set to visible using a visibility pragma. In
> build.rs, Rust builds contrib/cgit-rs/libcgit.a, which also contains
> libgit.a and other dependent libraries, with -fvisibility=3Dhidden to hide
> all symbols within those libraries that haven't been exposed with a
> visibility pragma.

I think this is a good idea.  It's optional and it allows us to add
functionality as we go along.  Platforms that don't have Rust can just
omit building it.

> +[dependencies]
> +libc =3D "0.2.155"

I don't love that we're using libc here.  It would be better to use
rustix because that provides safe APIs that are compatible with POSIX,
but I think for now we need this because rustix doesn't offer memory
management like free(3).  I'd really prefer that we didn't have to do
memory management in Rust, but maybe that can come in with a future
series.

libc also comes with the downside that it calls the actual libc
functions, so you have to write things like stat64 on Linux if you want
a 64-bit stat, but that doesn't exist on some of the BSDs, so you have
to write something else and compile it conditionally, and all of that
makes the portability of it worse than with C.

In any event, I have the intention to send a patch to replace libc with
rustix in the future if this series lands.

> diff --git a/contrib/cgit-rs/public_symbol_export.c b/contrib/cgit-rs/pub=
lic_symbol_export.c
> new file mode 100644
> index 0000000000..3d1cd6cc4f
> --- /dev/null
> +++ b/contrib/cgit-rs/public_symbol_export.c
> @@ -0,0 +1,20 @@
> +// Shim to publicly export Git symbols. These must be renamed so that the
> +// original symbols can be hidden. Renaming these with a "libgit_" prefi=
x also
> +// avoid conflicts with other libraries such as libgit2.
> +
> +#include "contrib/cgit-rs/public_symbol_export.h"
> +#include "version.h"
> +
> +#pragma GCC visibility push(default)

I assume this also works in clang?
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--waHZb/hlUzcSHUrW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZrPlQQAKCRB8DEliiIei
gamrAQCfRR3G0/buFhslcLtFoECNa3BYI4gc4YtBCIK7RcJlpgD/bspn6T7zQX6s
cUcU6Pp7xm9sPR1LWgjTMmAbXE7RXgw=
=U9kf
-----END PGP SIGNATURE-----

--waHZb/hlUzcSHUrW--
