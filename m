Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F141514A4C6
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 23:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742252457; cv=none; b=JULVVlfkLd0BvfwunDjO31l+yyKE+uqiYRmodvTY3WJAZHeAVVLnJjTR74tZYsRJKNsF1+s8SRpXSVG0mYaYItSA/uV+f5hjOrrWxpgM4/i1BOETb/6xaqSJtyQHSaEbpyg8LiSHp8Z52jpjCtwLrno08ybcuCcOI7WDKbp1X2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742252457; c=relaxed/simple;
	bh=a0Dx1WWmN7aqwxVMwr+GKizkAHjFResu9b+bCUEn94I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6wk747nlzuMbRozIHCx5RKI6R+/2Q//tqV5oLsUQcZZnK5Y3agC39AszEkIfkG2WvaTkpw5fjZVNxTAO+GxfU8T2R/xTbc3jIrVe+YWvkale9iXNfjEvaf/0b9XkqDs9saB0pLhrF+KegcU/Y3mFHW5dJdWNPmJr/KK9Jq9QM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=x9eT5RQh; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="x9eT5RQh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1742252448;
	bh=a0Dx1WWmN7aqwxVMwr+GKizkAHjFResu9b+bCUEn94I=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=x9eT5RQhthTZ+9qnXnyB4Em84opMoED+UAO3VPCf1SU3Qj+a7y50AlAF+BUYtGLYX
	 EpXvvMIXBK7F6lzMmZx1sVo4iZw4sJ0wbFcIExC5Vqmb/BaNBZZGNkQsWMGhpQHGo6
	 pF9tIf5i8LQvJgTbF7Sy7kvljbGnXCe8nSiPtp7qLET9otAs+52ZdRKqVY84QfEsUF
	 Ppxb/XeemBMe2DuyF124KEZOgvwnKLl0StTiTOUApdUKtpcGqulWJRHCC8e8UWg/Tl
	 OKnFxm5qM9Kr9uhAizaLwhvJlOduJV/jbaO4TZ0SulF2e7NNGDHDukorhyDkRqB2x9
	 IyPKVNGTunxgbzMcbfkqXrUJSlEsH7JZuRQcEIVCMPRmqMJu4KCs5H6PpFLbRYIs6K
	 sPCScVU3oX/Yh2tnrQg2QP9kJL1ysIXTzspooq9SKgEqjMRdZqp3jlQnaXKbAy4Wef
	 6bM1C54yPQORlie6DeicfCp/NGQIBAdEE0l3JdK49t61YGKytYC
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 73E7D200C0;
	Mon, 17 Mar 2025 23:00:48 +0000 (UTC)
Date: Mon, 17 Mar 2025 23:00:47 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Yissachar Radcliffe <yissachar@block.xyz>
Cc: git@vger.kernel.org
Subject: Re: Slow git add . performance in large repo
Message-ID: <Z9ipn_-J-ZKbnVQh@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Yissachar Radcliffe <yissachar@block.xyz>, git@vger.kernel.org
References: <CAOHNGAW7ucD+xqvEuvq2GHMc42+WdKJX44XGguadK_y=pMf0Vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YHugw+UGx0UvHawv"
Content-Disposition: inline
In-Reply-To: <CAOHNGAW7ucD+xqvEuvq2GHMc42+WdKJX44XGguadK_y=pMf0Vg@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--YHugw+UGx0UvHawv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-03-17 at 18:53:10, Yissachar Radcliffe wrote:
> We have a relatively large git repo and have noticed that `git add .`
> operations are slow (~1.5-2s). We have core.fsmonitor and
> core.untrackedCache set to true and `git status` executes in ~300ms.
> When I turn on trace2 I can see that almost all the time is spent in
> read_directo and it's visiting 26960 directories and 77989 paths.
>=20
> I can use `git add <foo>` or `git add -u .` to speed things up but
> `git add .` is the most convenient for us. I created a small script to
> pipe the results of `git status` to `git add` and that runs in <500ms.
> This leaves me confused as to why the built-in performance is so slow.

What you're asking for with those commands is different.  `git add -u .`
says, "Please enumerate only those files that are in the index, and if
they are modified or removed, update the index."  `git add .` says,
"Please enumerate every file in the working tree recursively and
determine if there are any non-ignored changes, and then update the
index."  (Note that a file that matches an ignore pattern but is already
tracked is not ignored, which affects the performance here.)

Notably, the former does not add new files that are untracked, but the
latter does.  That means that the code needs to know if there are any
new untracked files.  The untracked cache is not used when you specify
a pathspec on the command line because in the general case, it doesn't
have to be just `.` and it could be something like a match on an
attribute or a glob pattern, which would make the code very complex in
dealing with that case.  It is, however, used when you _don't_ specify a
pathspec (such as `git add -u`), as well as for `git status`, since
those operate on the whole tree without any pathspecs.

When you pipe the results of `git status` to `git add`, you are
effectively using the `-u` option, since that will only ever list files
that are tracked.

I realize `git add .` is very convenient, but it does ask to do
substantially more work than `git add -u` (which I use quite
frequently), and so it can definitely perform worse, especially in
large repositories.  You can, of course, continue to use it, but you
can't expect them to perform identically.  My recommendation would be to
use `git add -u` unless you need to add new files, since that's going to
perform better.  Once you get used to it, it's pretty easy to use.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--YHugw+UGx0UvHawv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ9ipngAKCRB8DEliiIei
gcr8AQDfScBiV0g0eUFWBjFveePEAQoLBq8NfeyOWTdRMa5qbQEAtNgEYZtzp7yj
ww9zPbn5KzJoYyPHRjwLRZK96AhbpQ0=
=Pvr8
-----END PGP SIGNATURE-----

--YHugw+UGx0UvHawv--
