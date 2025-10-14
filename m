Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3512C1590
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 21:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760476727; cv=none; b=tEF8NG0qtlJFAHgPP0tJ5i8bVZFBFpMy76Drqq0U6S9y3W7xXBcvkeRH5IhPnWRWW+ArDqBSa6KLX2N0B7USp0QJ/gSL3AntO8Nf1NZ3Iob7aUsOCuYqCo3LmWRZ5EUA5OB4j9ZlGfTWOQUAoNAhXF+0YwxIy+4d66FEHw1VBzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760476727; c=relaxed/simple;
	bh=W5/WsQ+h9hu5q5nJjkZ91CUP3w91qbLdYyhHlBjWUD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5W0p7+wuTBUiIerciQ+bGa5knMQcTiukCiP5revVF7xRQY0sirsA8Fet0iJ0XMDxg3YLaUBanYFBxGhuVV+I2y3o2tQnn9zGXo7NEnX9VVv5hmOh2MFVSLB6TisO9vjRqWb932BdVwC2Gwz+lz+bUIOLnDhQBth5hQevLQniWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=oQgpXqoI; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="oQgpXqoI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1760476718;
	bh=W5/WsQ+h9hu5q5nJjkZ91CUP3w91qbLdYyhHlBjWUD4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=oQgpXqoIi/KGXn1tSzrCLin69ReTHAwrhhqtG5jzT1PIe8lOhrYwITZJx/0IKhw+W
	 cMTUoPL5RomIvrXEmJZwAHqIBibElpdQkVeIjb0HCxtw6O6CZpbOn6wbLUVHGt3fKn
	 XdleYRaJaPoE01wRnnn63uYQ8sgQQ9Bh+ySOBaRqTxGh702Si5TrgaaHrQy4eXoZUL
	 pD9TQF2SF9aJnUoeQfN4PcPtXSS93cCnZeAardy2GAzRcYlZlkFydCFBEFdRp1Qamc
	 dn0VyczvX7SQ9sa0gFAKdXeAwNJ8H33huBgZXYjAJIp/9sHAoV8J8Z5P1R8BxCa+zN
	 YWAqgH1xCNvvw9Srr/c7vgOAo6F5Dy4BZlJCDLcg1TflSSZaNDMI9gqRmmbhPYtYwo
	 tFEWjIYGoWuh7gc7aMbuyGKzxTNxUuE0mdqX6c5mxNHcM0hqkVEdArScIB1jwHnORn
	 ryMlscyuyEBV4i9jTvhYtZiX1Q0IVuxgzFPZgs5aFqTdRk7p1Oz
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:dfcf:298c:5ecb:a3c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 194D3200BA;
	Tue, 14 Oct 2025 21:18:38 +0000 (UTC)
Date: Tue, 14 Oct 2025 21:18:36 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] [PATCH] [Outreachy] builtin/patch-id.c: clarify SHA1
 usage for patch IDs
Message-ID: <aO6-LBqhW87GWD-5@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>, git@vger.kernel.org
References: <20251013174658.236940-1-okhuomonajayi54@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="frNJ4OlTNQd3WYIi"
Content-Disposition: inline
In-Reply-To: <20251013174658.236940-1-okhuomonajayi54@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--frNJ4OlTNQd3WYIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-13 at 17:46:58, Okhuomon Ajayi wrote:
> Patch IDs in Git must always use SHA1, regardless of the repository's
> object hash. Previously, the code relied on `the_hash_algo` which could
> vary depending on the repository, and included a NEEDSWORK comment
> suggesting this should be fixed.
>=20
> This patch updates the comment to clearly state that SHA1 is required
> for patch IDs and sets the hash algorithm to SHA1 if it is not already
> set. This ensures consistent computation of patch IDs in accordance
> with git-patch-id(1).
>=20
> No functional behavior is changed, but misleading comments are removed
> and the code now explicitly enforces correct SHA1 usage for patch IDs.
>=20
> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
> ---
>  builtin/patch-id.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>=20
> diff --git a/builtin/patch-id.c b/builtin/patch-id.c
> index d26e9d0c1e..d47b6f5a3f 100644
> --- a/builtin/patch-id.c
> +++ b/builtin/patch-id.c
> @@ -246,16 +246,11 @@ int cmd_patch_id(int argc,
>  			     patch_id_usage, 0);
> =20
>  	/*
> -	 * We rely on `the_hash_algo` to compute patch IDs. This is dubious as
> -	 * it means that the hash algorithm now depends on the object hash of
> -	 * the repository, even though git-patch-id(1) clearly defines that
> -	 * patch IDs always use SHA1.
> -	 *
> -	 * NEEDSWORK: This hack should be removed in favor of converting
> -	 * the code that computes patch IDs to always use SHA1.
> +	 * Patch IDs must always use SHA1, regardless of the repository's
> +	 * object hash, See git-patch-id(1) for details.=20
>  	 */
>  	if (!the_hash_algo)
> -		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
> +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);

Hmmm.  If I run git patch-id in a SHA-256 repository, then I get a
SHA-256 output here and it's worked this way since Git 2.29.

I know the comment says what it says, but I personally disagree with
this approach.  There will be a point in time where SHA-1 is so weak as
to be useless and people will want to build a Git version without it.
For instance, many government agencies around the world have a 2030
deadline for completely stopping all use of SHA-1.  If we continue to
use SHA-1 here, then this will have to change anyway in a few years, so
we'd be better off keeping the default algorithm for now and adding an
option to control which hash is used.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--frNJ4OlTNQd3WYIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaO6+LAAKCRB8DEliiIei
gXzXAQCGeU5gpuu6UDsRnIsUea5UUzfjnSBScaOH01DQQZzVhgD6Aj1fNTyGWjbC
h87IDWBGLAG2MMmQ1BRTTTtNHMiF6wg=
=R9oN
-----END PGP SIGNATURE-----

--frNJ4OlTNQd3WYIi--
