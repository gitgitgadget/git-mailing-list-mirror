Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D2113D521
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 21:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743458050; cv=none; b=AExiQTaw1xVye5EmRmHdL4Txd9dsvjsEMll3G67Zvt9De3XvaYwGWV59UfC99VJHR20J3A8Fma6T7zGbdroVRUtLZtVPYF8q5jFpEjlyb8Ujzw1KomsGq+/sqxN1bJCzNgm5SrVN4v8SEpQ7lmHbka/fwEpdpl1v5HmFO9MEafQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743458050; c=relaxed/simple;
	bh=+Te2kuaoAlp+plpD0s13PjxhJWE5/4nwp1y0o/80r0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eICANUuof4cIGfK+rzdWbhpMY84djvP51Pf2U9TPGba7ZMMzCMvh3tSo2K4mACuQEwNsiWXlJuoTm8fg+Vue760nZrSenGAPS3Zi3imoxplqOIdgU/MFDH/zK+wPe9AyUHanBRJ/x9KiC+G87vtswtE2tIPuqt42fryQep928aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=i63bGzd7; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="i63bGzd7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1743458040;
	bh=+Te2kuaoAlp+plpD0s13PjxhJWE5/4nwp1y0o/80r0c=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=i63bGzd7lIOL/p47TpHqoGfYrhPX1cqlupUKN/HQ/avIsEYjwP+E+TVUdhbB7A5Vy
	 mwSJ9ZPcTtRm5lrujc6KRMoPpgk+XFj3IeRfU0UBtTqwjS1jfBMFa2J3b1AG+jQ68D
	 uogc4M7yztA8mWbTGYt1neIOyqIvvbkEL7hHMIsKxXTgOMn+Ks2Vx5xhsx/XwyodnR
	 +VKmbhhcdoSYvcbveYIkfKKSDBgHXCNobbCWOKK5Swhn5sA++xvPavJuFkJ4XXGa75
	 SvAgD5Bs8DPtk3YVHoiQgyf9JpYu4v+4MgKzNTWPmGp30ujcu6YGTYtYcKxoRDz2LX
	 8dRGpRSU5u8umbBXoIjjNUzy/ZdnKT7vUgCh2ox/OVqZzq4GQcF/VUtYMZyAOCKbOg
	 G3I3KXMa/bobtYLGm226+4XBDLXNtq4kLSUW9JtDFhR1/et2+svYsMm87zL37m+L6l
	 qWGzb54vNzTH7yOd2IcWbXMmmF49+lVNqGfafTVlNqygzegnSZx
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 47CA3200BE;
	Mon, 31 Mar 2025 21:54:00 +0000 (UTC)
Date: Mon, 31 Mar 2025 21:53:58 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] Allow cloning from repositories owned by another user
Message-ID: <Z-sO9gcWAi_xh0tI@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
References: <20241115005404.3747302-1-sandals@crustytoothpaste.net>
 <20241115005404.3747302-2-sandals@crustytoothpaste.net>
 <Z+qVJPQ17urm06QN@szeder.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+yMwcAydBu7dLld2"
Content-Disposition: inline
In-Reply-To: <Z+qVJPQ17urm06QN@szeder.dev>
User-Agent: Mutt/2.2.13 (2024-03-09)


--+yMwcAydBu7dLld2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-03-31 at 13:14:12, SZEDER G=C3=A1bor wrote:
> This test succeeds without checking everything it is supposed to:
>=20
>   + git clone --upload-pack=3DGIT_TEST_ASSUME_DIFFERENT_OWNER=3Dtrue git-=
upload-pack --no-local a nonlocal-otheruser
>   + repo_is_hardlinked nonlocal-otheruser
>   + find nonlocal-otheruser/objects -type f -links 1
>   find: 'nonlocal-otheruser/objects': No such file or directory
>   + git -C nonlocal-otheruser rev-parse --show-toplevel
>   /home/szeder/src/git/t/trash directory.t5605-clone-local/nonlocal-other=
user
>   + test_grep detected dubious ownership err
>   error: 'grep detected dubious ownership err' didn't find a match in:
>   Cloning into 'nonlocal-otheruser'...
>   warning: remote HEAD refers to nonexistent ref, unable to checkout
>   ok 21 - cloning a local path with --no-local from a different user succ=
eeds
>=20
> The 'repo_is_hardlinked' helper function expects the path to the .git
> directory as parameter, but in this case it gets the top-level path of
> the repository instead, which results in 'find' rightfully complaining
> about the non-existing 'objects' directory.  Thanks to the &&-chain in
> 'repo_is_hardlinked' this error then causes the helper function to
> return with non-zero error code, just what this test case expected.
>=20
> All other tests using this helper function create bare clones, and
> they all pass the right path as parameter.
>=20
> The trivial fix would be to either use a bare clone in this test as
> well, or to pass the right path to 'repo_is_hardlinked', i.e. the path
> to the '.git' directory.
>=20
> The right fix, in my opinion, is to teach 'repo_is_hardlinked' a
> negation parameter, so tests expecting the repo to be not hardlinked
> could invoke it as 'repo_is_hardlinked ! <path>'.  An error from
> 'find' within the helper function should then always result in an
> error of the helper function, i.e. both with and without that '!'
> parameter.
>=20
> Furthermore, this test should use 'test_grep ! ...' instead of '!
> test_grep ...', so we don't get that misleading error message in the
> test's output.
>=20
> And there is a stray empty line at the end of the test as well.

Thanks for the report.  I've opted not to teach `repo_is_hardlinked` a
negation parameter, but I have fixed the three items you've mentioned.
Here's a patch.

-- >% --
Subject: [PATCH] t5605: fix test for cloning from a different user

This test currently passes, but for the wrong reason.  The
repo_is_hardlinked function expects a .git directory or a bare
repository and currently fails because it cannot find the objects
directory.

One solution is to use the --bare argument, but then --show-toplevel
won't work.  We could change that, but there's no need to, so just add
the missing .git directory.

In addition, use the built-in negation functionality of test_grep to
avoid mishandling real errors (such as a missing file) and, as a final
fix, remove the extra newline.

Reported-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5605-clone-local.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t5605-clone-local.sh b/t/t5605-clone-local.sh
index 4605703496..2397f8fa61 100755
--- a/t/t5605-clone-local.sh
+++ b/t/t5605-clone-local.sh
@@ -156,11 +156,10 @@ test_expect_success 'cloning a local path with --no-l=
ocal does not hardlink' '
 test_expect_success 'cloning a local path with --no-local from a different=
 user succeeds' '
 	git clone --upload-pack=3D"GIT_TEST_ASSUME_DIFFERENT_OWNER=3Dtrue git-upl=
oad-pack" \
 		--no-local a nonlocal-otheruser 2>err &&
-	! repo_is_hardlinked nonlocal-otheruser &&
+	! repo_is_hardlinked nonlocal-otheruser/.git &&
 	# Verify that this is a git repository.
 	git -C nonlocal-otheruser rev-parse --show-toplevel &&
-	! test_grep "detected dubious ownership" err
-
+	test_grep ! "detected dubious ownership" err
 '
=20
 test_expect_success 'cloning locally respects "-u" for fetching refs' '
--=20
2.49.0.395.g12beb8f557c
-- >% --

--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--+yMwcAydBu7dLld2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ+sO9gAKCRB8DEliiIei
gVlUAQC7Fx6UDGokgZqcnC0eMl51pta2JY4aQFMod2UTx+6yBwEA+pBuX3nJAgWz
6xyRUNoLATdV9pwH206dhlICrpPICAw=
=fEhj
-----END PGP SIGNATURE-----

--+yMwcAydBu7dLld2--
