Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C87D1DE2A3;
	Wed,  6 Nov 2024 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890809; cv=none; b=CpBjhq9mGpgSK1/JyP1/GsAz2xgFnycQlw+6a8psk2kORAgAVyN7FeXIvxFgEkl9se/vu7YoJ7o4Rh032Bq6N5wogvc8jU/iBli3dhtR47TCxGblMsMq/HqfBnebSoFQ/IbmZ/+8TQ81KkkEyHd8nE+Rk++324wVDc3w2evqOLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890809; c=relaxed/simple;
	bh=1Q0/6L+orPd3CIKPBSbg7iBE2QDqKCO3jFRd8P7qQtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWKdzijZM7IO+sCiXYntbxAbXTunP9aTP1XUxOyjgt8/2Oj9jnKEThQlyPSYI49yqyy8/X8ITGC9yh9/ZwkY24PGxz11dBfngQfbmwytvCz4ZDXTRrkEzrRoSq3QzXvDRRiiAbuEk6jbGIQWMBlUud92RXfCsQ64M7Zv+7O4vj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAHtn0U5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAHtn0U5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C80C4CECD;
	Wed,  6 Nov 2024 11:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730890808;
	bh=1Q0/6L+orPd3CIKPBSbg7iBE2QDqKCO3jFRd8P7qQtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DAHtn0U5z1IGh7huksg3s96zpfMOA1fE6ACMxenKhBWJ9KPzvAQCCJwU+MAl/Cu09
	 bluNfckBufg8cQ5KukSY4sanDnMgER0LVydFJm/GjRcNs9MAsyUQmbPo9LOLWKXmDS
	 Vw5cIJN+z6B5QyEgi9/ygOBoZngy4RMI9ErlVWcaGd3rwxJ0g3mA6D8dcJFO6Wc+TK
	 Ql7lFBuqBXaT6eY71Usume0hAFj7vfJKfs3euZ6swYUB+acZ41Pf1ou7b/IndFnDuF
	 wlVtd9VaBApxA2FNfsdnN53k+4us/cS4YW7z6ChrtZ9dBQi55K6op2F+vOsguf3tCL
	 eJS16yC4r7iYg==
Date: Wed, 6 Nov 2024 12:00:05 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Philipp Takacs <philipp@bureaucracy.de>, git@vger.kernel.org
Cc: linux-man@vger.kernel.org
Subject: diff-algorithm to work better with color-moved, and issue with
 am.messageid (was: [PATCH] bind.2: move EADDRNOTAVAIL to general errors)
Message-ID: <imng4gsmiins23rrpb7zppeambm4wdwfvyhgp4rbzqkc5dyjah@3bckcsvdg42r>
References: <eee2fe5c6c3d6203e1e528a998b0de2c.philipp@bureaucracy.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xwp7c4fc74ox7cxx"
Content-Disposition: inline
In-Reply-To: <eee2fe5c6c3d6203e1e528a998b0de2c.philipp@bureaucracy.de>


--xwp7c4fc74ox7cxx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Philipp Takacs <philipp@bureaucracy.de>, git@vger.kernel.org
Cc: linux-man@vger.kernel.org
Subject: diff-algorithm to work better with color-moved, and issue with
 am.messageid (was: [PATCH] bind.2: move EADDRNOTAVAIL to general errors)
References: <eee2fe5c6c3d6203e1e528a998b0de2c.philipp@bureaucracy.de>
MIME-Version: 1.0
In-Reply-To: <eee2fe5c6c3d6203e1e528a998b0de2c.philipp@bureaucracy.de>

[To +=3D git@, to report some issue with git(1)]

Hi Philipp, git people,

On Wed, Nov 06, 2024 at 10:53:47AM GMT, Philipp Takacs wrote:
> EADDRNOTAVAIL is not a socket specific error

Thanks!  I've applied the patch.

> ---
>  man/man2/bind.2 | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/man/man2/bind.2 b/man/man2/bind.2
> index a59ac16f9..330a808b7 100644
> --- a/man/man2/bind.2
> +++ b/man/man2/bind.2
> @@ -147,6 +147,10 @@ .SH ERRORS

Wow, thanks for configuring git(1) for that!  :)

>  The file descriptor
>  .I sockfd
>  does not refer to a socket.
> +.TP
> +.B EADDRNOTAVAIL
> +A nonexistent interface was requested or the requested
> +address was not local.
>  .P
>  The following errors are specific to UNIX domain
>  .RB ( AF_UNIX )
> @@ -157,10 +161,6 @@ .SH ERRORS
>  (See also
>  .BR path_resolution (7).)
>  .TP
> -.B EADDRNOTAVAIL
> -A nonexistent interface was requested or the requested
> -address was not local.
> -.TP

And here goes some question to git@ people.  Here, either the .TP from
below or above the rest of the removed text is correct for a diff.
However, when you ask git to --color-moved, it will think the .TP was
not moved, as it's in a different position.   Maybe some diffing
algorithm could have this in mind and favor when in doubt a line that
makes the removed part consistent with the added part, so that more text
is considered to have been moved.  What do you think?  Would that be
doable, or is it easier said than done?  :)


Below is a reproducer.

BTW, now I've noticed that the Message-ID line was written in the wrong
position, next to the commit message body, and not in the trailer
signature fields.  That's the first time I see that happening.  It might
be interesting to check that.  I can consistently reproduce it when
applying this patch.  It might be interesting to investigate why it
happens.


Have a lovely day!
Alex

alx@debian:~$ cd /tmp/
alx@debian:/tmp$ git clone https://git.kernel.org/pub/scm/docs/man-pages/ma=
n-pages.git
Cloning into 'man-pages'...
remote: Enumerating objects: 172347, done.
remote: Counting objects: 100% (358/358), done.
remote: Compressing objects: 100% (332/332), done.
remote: Total 172347 (delta 180), reused 0 (delta 0), pack-reused 171989
Receiving objects: 100% (172347/172347), 33.72 MiB | 17.49 MiB/s, done.
Resolving deltas: 100% (141272/141272), done.
alx@debian:/tmp$ cd man-pages/
alx@debian:/tmp/man-pages$ git show --color-moved 577251dfb1d2
commit 577251dfb1d2c63d8022944d12ed567d8409c17a (HEAD -> master, origin/mas=
ter, origin/HEAD)
Author: Philipp Takacs <philipp@bureaucracy.de>
Date:   Wed Nov 6 10:53:47 2024 +0100

    bind.2: move EADDRNOTAVAIL to general errors
   =20
    EADDRNOTAVAIL is not a socket specific error
    Message-ID: <eee2fe5c6c3d6203e1e528a998b0de2c.philipp@bureaucracy.de>
   =20
    Signed-off-by: Alejandro Colomar <alx@kernel.org>

diff --git a/man/man2/bind.2 b/man/man2/bind.2
index a59ac16f9..330a808b7 100644
--- a/man/man2/bind.2
+++ b/man/man2/bind.2
@@ -147,6 +147,10 @@ .SH ERRORS
 The file descriptor
 .I sockfd
 does not refer to a socket.
+.TP
+.B EADDRNOTAVAIL
+A nonexistent interface was requested or the requested
+address was not local.
 .P
 The following errors are specific to UNIX domain
 .RB ( AF_UNIX )
@@ -157,10 +161,6 @@ .SH ERRORS
 (See also
 .BR path_resolution (7).)
 .TP
-.B EADDRNOTAVAIL
-A nonexistent interface was requested or the requested
-address was not local.
-.TP
 .B EFAULT
 .I addr
 points outside the user's accessible address space.

>  .B EFAULT
>  .I addr
>  points outside the user's accessible address space.
> --=20
> 2.39.5
>=20

--=20
<https://www.alejandro-colomar.es/>

--xwp7c4fc74ox7cxx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmcrTDUACgkQnowa+77/
2zKNNQ//dG45vs1IluQZkQGDaIdh2qAXh8o/hwWEZ1cOOfT6gyYl0eaOUJc7mvCT
uG1Z9tEryRC/vm7gSPDG0NP4rHboN1tMu/k+eP3cHf1f4yiwy77eiYw98iifhb8b
Qkyx8W1j5kMvkdJaYGB+MIH7mZe9Ev9WVL8NXW3eDdYMgWAKWjzZe2asQcH0S32I
wPSQAoP+0+oK0y6clcP56mDFpZiOaO8rg8gGIolW6b6cviDUFZjIf4gHH3qa1Sxw
uT8ywKOvIeKCwxThucj3I0JPP3IFK8nKuhD2nHlGCjC9k6K8I5fnQbDwsiYF4WXS
ZSPA8fEZusRDe5ZAcguSV+aWBewNI5dYYZOqJZlh5vieFrro8eq6sXR4VNwm2t5b
ZKZMObSWSlRwUP0GEpRErO2BWlKL+HXRqgigaW/5JY01jhnG1q0rsXAiLK6FYrs/
gaU2bYSiivTK983rybb+rZbCK6mdp72F2WlIwwCn9YGWjYI/u+RaoN9bafGF3G1H
9zMdngztoOUOz1ztSqQY1JHKNz0rRLTy4h+YUZ17R0sTekN8XxUIzmtFBKl/UlHm
mDV+upYS5XXFfLovrHIea0X357Z7LprHluLVUTPBAApjm+Pe6X5HVjUyoN6SxnfU
EgHjxrCJrP8sPBaIywN6L7HEo0Mhc7JmG+hZf/OB5XkwrszVaXw=
=64GG
-----END PGP SIGNATURE-----

--xwp7c4fc74ox7cxx--
