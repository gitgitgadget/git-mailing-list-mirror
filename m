Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3606222597
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767555626; cv=none; b=qdC07QXSQEenodqUqAs8K4kLnLT89VEf7FsQ9Kkwk9ViMA2Jb/xaxMhIVrheQJ9KkWO0u1oPgb0paY3QczH3agWxgZeIbGSqN8ndA5LP3vhzKzFMXfBi6r9GM0EpmKT/KdDf46EwkmYOKe+ESKYlo0LwIYU3nZs/vSx4dgLv4ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767555626; c=relaxed/simple;
	bh=2u8tWEZTnftOupvJ8Ws7Q5LzJsVEWEbdLI7zZwJkdpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPa/nfGeMaJXxSebCgge1Lcx7di/UwXX4Rpjc4fpJj2m8g4phEvq9fKmJ4ViqdvszlcCXGW2zhwE8rY/0V6cQ2WOweuzFzGOIMWDrMa8qNBE9nnp9GUqT0N821gWNCq2CqAvm2vKS9RgKOJF98StXsVY8n6SngaP+8DtQpYzwj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=uwItlGWC; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uwItlGWC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1767555616;
	bh=2u8tWEZTnftOupvJ8Ws7Q5LzJsVEWEbdLI7zZwJkdpc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=uwItlGWC5QmcmgbvUUth4i6mFsyYoA1TzzTFHFh7I4WOoqZRY4hjXlDi5DUXQS+FJ
	 F7Ww35eqp51Mv6EJgbFe9QBJt4pU9GZQok+6yxbiebEclyoGfbq66d54f8zhzUEbLz
	 xR1HoLFxiht+zN/YllA1iVkb11Eflta1C4Ys+w72LMapv670sCuuSrz9CFlf5dgJep
	 Ph5z8LAG+/HpKYXmo4cNJDyjMYv15aGvP23Hpwy4hG1KcrXk9hCjvRlAseHPwHUQ7i
	 ZjVFwrXKRoV7msFg0iSwdWU56jUg39PoRFZ5IMzg1nbkgvvxFDv7cBb+f5i4ZavpDf
	 TWO3y6n/FrKmym73BC1UBpkQKa9rgqkdpEIBhCGVfOO+PXX/3vZ84UEGYixjsPPBKp
	 s/hnaPdte2dHNIcyjcE/ulWYzDmafpCvPOWTleeQAGcZ0Wk+c0vqoJjfKcPaDSTGBE
	 1s/0xiuVkyXeH3NTWyY36utoq18mBcRs0cz9hpElymTskC5dvk+
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d4c0:104f:6ae5:8a31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8216B200B5;
	Sun,  4 Jan 2026 19:40:16 +0000 (UTC)
Date: Sun, 4 Jan 2026 19:40:14 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Matthieu Beauchamp-Boulay via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Matheus Tavares <matheus.tavb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Matthieu Beauchamp-Boulay <matthieu.beauchamp.boulay@gmail.com>
Subject: Re: [PATCH] ignores: handle non UTF-8 exclude files
Message-ID: <aVrCHr_NRDqNjPn0@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Matthieu Beauchamp-Boulay via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Matheus Tavares <matheus.tavb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Matthieu Beauchamp-Boulay <matthieu.beauchamp.boulay@gmail.com>
References: <pull.2157.git.git.1767478617198.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/e7rKvfowdzGRJQi"
Content-Disposition: inline
In-Reply-To: <pull.2157.git.git.1767478617198.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--/e7rKvfowdzGRJQi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-01-03 at 22:16:57, Matthieu Beauchamp-Boulay via GitGitGadget wrote:
> When reading exclude files, git assumes it is encoded in UTF-8 and will
> fail to apply patterns if it isn't. This is a silent failure as no warning
> or errors are shown to the users. This is a problem that can take a while
> to diagnose as many users will not think of checking the encoding of their
> file and may believe their patterns are wrong instead. Users may also
> accidentally commit undesired files.

This isn't actually true.  Git allows arbitrary byte sequences in the
file because Git allows filenames to have arbitrary byte sequences, just
like Unix.

> On Windows, this happens if a user uses Windows PowerShell to create the
> file, which results in a UTF-16LE file with a BOM. This issue was discuss=
ed
> here https://github.com/git-for-windows/git/issues/3329. An example of
> where a user was confused that his exclude file was not working is cited
> https://github.com/git-for-windows/git/issues/3227.

Ah, yes, here's the problem.  UTF-16LE is used on Windows, and on
Windows, Git stores pathnames as if they were converted into UTF-8, so
you do need to write the filenames in UTF-8 in the ignore file.

> A minimal fix should at least warn the user if git cannot properly decode
> the exclude file. Ideally, git would handle any given Unicode file.

As I mentioned, the file isn't necessarily in UTF-8 or Unicode.  Here's
an example shell script to demonstrate (requires a non-macOS Unix):

----
#!/bin/sh

rm -fr test-repo
git init --object-format=3Dsha256 test-repo
cd test-repo
touch abc.txt
touch "$(printf '\220')"
printf '\220\n' >.gitignore
git add .
git status
git ls-files -io --exclude-standard
----

I'll point out that all of this is also true for things like config
files (which are also used in `.gitmodules`) and `.gitattributes` files.
If we wanted to make a change, we would be wise to make it everywhere.

However, if we wanted to force `.gitignore` to UTF-8, we'd need to have
an escape mechanism to write non-UTF-8 sequences, and as far as I know,
we don't.

> First, check if a BOM is present. If it is, decode the file to UTF-8.
> If no BOM is detected, then try to parse the file as UTF-8. If that fails,
> attempt to decode the file using the working tree encoding of the file,
> if any. If that fails, print a warning to tell the user that the exclude
> file could not be decoded and skip the file.

We do not accept and strip BOMs in UTF-8 files elsewhere (including in
things like `git diff` output), so we should not do so here, either.
For Unicode files, if there is no BOM, then the standard is that it's
assumed to automatically be UTF-8, so a BOM is superfluous and not
recommended.

> diff --git a/t/lib-encoding.sh b/t/lib-encoding.sh
> index 2dabc8c73e..1b1cc357ba 100644
> --- a/t/lib-encoding.sh
> +++ b/t/lib-encoding.sh
> @@ -23,3 +23,11 @@ write_utf32 () {
>  	fi &&
>  	iconv -f UTF-8 -t UTF-32
>  }
> +
> +write_encoded () {
> +  iconv -f UTF-8 -t "$1"
> +}
> +
> +write_bom () {
> +  echo "$@" | perl -pe 's/\s+//g; $_=3Dpack("H*", $_)'
> +}
> \ No newline at end of file

We place newlines at the end of our text files unless there's a good
reason no to.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--/e7rKvfowdzGRJQi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaVrCHgAKCRB8DEliiIei
gZHFAP927ZWl81iKkLIuu+HDN+JT4zPXTi1UcDhtORPIdN6fZgD/aBdjwyf5hRka
IYJIWgG1WKt7RDFPrKskP2GCxLQTYAs=
=dRDY
-----END PGP SIGNATURE-----

--/e7rKvfowdzGRJQi--
