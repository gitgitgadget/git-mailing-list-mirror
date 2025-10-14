Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6797E270553
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 21:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760477363; cv=none; b=Qyuu4bp0i1BIYSsF3stFwaSVzQNkGRNOV0D6onLack/jyJBXzuyE7HadZjcOwX3g7sKfFvgSUHLw1XWWcJqp2yd7dR7MjOjxwEuHSbof9I68e4VQ8Hfau0U8tSmDoxVXIMiacwZYZG9YNr6o5VrFquaCgqYfWIJQGnVAB+KnNfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760477363; c=relaxed/simple;
	bh=yHCayDA/JqxMxTxrJHrutS9En1bIIIeVJMoYUpPeqoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abROj1xA4jhL/jdWrS8uAmm+vEUuwY/VAVG2XeH9CLrBLYI8D15lq84SLdYK3MzzwbKRMcYyRFGU+RamtYV1gpyFdUgoiD+Ww+kZICj1DaBAK6XTQHYQSdOiCFdwAm2T+DAjsDqQA3WFh7ga0sZe43KvHFzATfJTajSWjCnDJFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=temW5nxL; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="temW5nxL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1760477355;
	bh=yHCayDA/JqxMxTxrJHrutS9En1bIIIeVJMoYUpPeqoc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=temW5nxL/iP5Kyu5IdSEy34QS3GzGZniz5jRlAgt9hAaS5Zk+obt/YrBHomOIxf+c
	 DUKeA7e6x0CZLCI7xdI8iVxjVJtRToXIH1MPb7lI2rINRvXOY3NcByks8U6DmDorWQ
	 sqqNtRN1h7CDNQNfJIEzTUa/B1wNI2zDh3UAxKmD1qgJYrzQFHR01KywWMkVqG5Vb/
	 6BRt6PWfhUTGtvsIh3+w8gm1E4Y2WwJGHfIyBUFgo5SYh8zB80I4bTKHKbuAKLc2Q/
	 gI5+OMydKN9klU5gYsIrDgsdaulBlWxKFRHE5iWNGZXc/pSj4PADXMh0g/ZqRA2mVk
	 2pwSvJ4jSo7dJ8RE3gfN3jCZuOQ0ndVW496fWfBBo1mU2D1M9fJo4eBpEeRuxBB8RP
	 L7XdxBGRTMXlXZ+6shuwfcAsFvDV+R7jwgJW1tLKPKiUSpJniHkUPtwFtza4Q8fP0X
	 KHwHdIbf6QNQuQjUkTf4KQKcd+63TsdmiEKDUrxR9uuA4TU6H7x
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:dfcf:298c:5ecb:a3c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5151B200BA;
	Tue, 14 Oct 2025 21:29:15 +0000 (UTC)
Date: Tue, 14 Oct 2025 21:29:14 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ashlesh Gawande <git@ashlesh.me>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] http.c: prompt for username on 403
Message-ID: <aO7Aqooz-0ppbcMP@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ashlesh Gawande <git@ashlesh.me>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20251014144354.1457818-2-git@ashlesh.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AmGqV5bgu/H3ofeI"
Content-Disposition: inline
In-Reply-To: <20251014144354.1457818-2-git@ashlesh.me>
User-Agent: Mutt/2.2.13 (2024-03-09)


--AmGqV5bgu/H3ofeI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-14 at 14:43:52, Ashlesh Gawande wrote:
> Scenario:
> - There are a few pre-production systems that a lot of testers and
>   developers need to time share because of low availability
> - Devops generates a GitHub token with pull only access
>   and adds it to the netrc file on these systems
>   (Pull only as we don't want testers/others to be able to push)
> - Testers log in and do a git pull for the latest changes
>   (via netrc credentials - though testers may not be aware)
> - Developers login to debug issues and may make fixes to the test repo
> - Now when developers try to push their changes they receive:
>   fatal: unable to access 'https://github.com/<org>/<project>/':
>   The requested URL returned error: 403
> - The developer is not given the chance to supply an authorized token
>   and either needs to comment the netrc file or copy the changes over
>   to their own machine
>=20
> Signed-off-by: Ashlesh Gawande <git@ashlesh.me>
> ---
>  http.c                     |  2 +-
>  t/lib-httpd.sh             |  9 +++++++++
>  t/lib-httpd/apache.conf    |  4 ++++
>  t/lib-httpd/passwd         |  1 +
>  t/t5550-http-fetch-dumb.sh | 24 ++++++++++++++++++++++++
>  5 files changed, 39 insertions(+), 1 deletion(-)
>=20
> diff --git a/http.c b/http.c
> index 7e3af1e72f..18959f63b9 100644
> --- a/http.c
> +++ b/http.c
> @@ -1852,7 +1852,7 @@ static int handle_curl_result(struct slot_results *=
results)
>  		return HTTP_NOMATCHPUBLICKEY;
>  	} else if (missing_target(results))
>  		return HTTP_MISSING_TARGET;
> -	else if (results->http_code =3D=3D 401) {
> +	else if (results->http_code =3D=3D 401 || results->http_code =3D=3D 403=
) {

I don't think this is a good idea.  Existing servers send a 401 when no
credentials are available and 403 if credentials are sent but are not
valid for a repository.  The former case causes credentials to be
erased, but the latter does not.

Your proposal will cause someone's credentials to be erased just because
they don't have access to a repository, which would be bad because it's
not that the credentials are invalid (that would be a 401) but that the
credentials are not usable for that repository or for that operation.

So if I attempt to push to https://github.com/git/git.git, then my
credentials will be erased even though there are no valid credentials
that could possibly grant me access to that repository (because I'm not
Junio).  Then _none_ of my pushes work because my token is gone.

I agree that it's inconvenient that netrc credential override other
credentials, but the proper thing to do would be to (a) not share
working trees among users (since Git's security model doesn't allow for
that), (b) not use netrc for this purpose and use a credential helper,
(c) add functionality to disable netrc via config, or (d) use an SSH
deploy key for automated systems with `GIT_SSH_COMMAND` and `ssh -i` and
have developers forward their SSH agent to push.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--AmGqV5bgu/H3ofeI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaO7AqQAKCRB8DEliiIei
gUzSAQDY2kYbSMdWx4aQWu54FgCNvcUs1LSopVLOeJVtQgFPxQEAxpGFayhX1iTr
VEVD4mSSgvckx55TGA64IV9dnQWeYQU=
=qqj/
-----END PGP SIGNATURE-----

--AmGqV5bgu/H3ofeI--
