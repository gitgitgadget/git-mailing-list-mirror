Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACC85258
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 20:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726517579; cv=none; b=DDtwPYumn60Y1KCFslyfqYHjHesG8xMz8Hl+ZStYkQhE45z8/5rOhitnhUtwlTNlndnNHLUyOU+mTa8hziVFb7K6ycZg1Ce/yOaEBEVj0B8QsAa8DyVqd7tIlGYDILWKOf+HRubu/IqG4ACTeT8aHhwrmpuwQbnSZrEryhldVC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726517579; c=relaxed/simple;
	bh=iQzKox8aQULZ1tww0JHEPK64W3frbCC587U1dIH4OGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYgPrPVU/f8T59Ci9no/O1YRw+Dfkym83MK2FEUsldH88ne7cDN7HcYep5uF20Kub8p7xVEnPKgCmHAiffwkCse6/OWl+nDrBUOsCgkobqO+X1rqXRuFYGz8qBClsjDWfZgxI18/okidA7L7HzTOQIN/pEKxyTQ8B8ErNqqoTBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=SA4Thj3R; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="SA4Thj3R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1726517569;
	bh=iQzKox8aQULZ1tww0JHEPK64W3frbCC587U1dIH4OGk=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=SA4Thj3R+fLjN6Sp6niNGbQaOY+vGFv01jkZsf/qaPQQXciqlDQhrpV9XjAg8JTkx
	 FIyvFx8ShZ45s3yGYsV94+sVJ/9/2btlEdu6JwhjPOzlKiQhZrKJuorAORf2b938Zj
	 Vkq2LBLI68zjJrIPgKTNOzsEvzF356tx19D804deiZCerO+clcPHGnohegVOQw3Ate
	 p0eIaqOW4KpRsbHUXr5YplOdfkuc9xtJSJpHgBlD/ZkKNpePg8W09mIqj+DXCM2reD
	 e5QTLVZXyH3fi9J6iRw1qM/a7sbSHeu6i2JiDOazNnLCEfEIX5kj4iVgHOPpjXpsXY
	 f/q6fdEkmuAWzM47P6YKxRlWsvR/3KvpGWzf/9T63dJ0Z2ZVojZX4az0f1X4/+oEwo
	 YCGtXK8/OiMNcToEbQQi0vHs6AnomtWrAYR8m9mTWB55AMXrMrq0QHgfMZRzLPX1kc
	 Xq8PBkQsTBksb+N/XCXaHIgHiUVTUtAx5IDYQTn14YJfxNFF4GM
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id C8F5820067;
	Mon, 16 Sep 2024 20:12:49 +0000 (UTC)
Date: Mon, 16 Sep 2024 20:12:48 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Git Mailing <gitmailing3@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: get file watcher is keeping lock on files for a long time
Message-ID: <ZuiRQFVHgN98qBfS@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Git Mailing <gitmailing3@gmail.com>, git@vger.kernel.org
References: <CAHmn3WWZ+vHT33z5_bQ07yTM0apY5gLDtErk_2fuLeGw509JPw@mail.gmail.com>
 <CAHmn3WVakAs4XPtmvBYB4inKah0WPYACaXJGScerbVMTi4D4eA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fJc4H4Ysyo/MNoGC"
Content-Disposition: inline
In-Reply-To: <CAHmn3WVakAs4XPtmvBYB4inKah0WPYACaXJGScerbVMTi4D4eA@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--fJc4H4Ysyo/MNoGC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-09-16 at 19:00:17, Git Mailing wrote:
> I'm not able to delete a folder minutes after the last git operation
> as the git process keeps running in the background and won't stop.
>=20
> How can I have git stop after, say, 30 secs. of non-operation?

There's not enough information here for us to give you any useful
advice.  First, we need to know what operating system and version you're
using, since the advice we give will depend on what OS you have.  For
example, it's well known that Windows has a design flaw that prevents
most files from being removed while they're being used.

Second, we need to know the exact command line of the process that's
running in the background.  For example, if the process that's running
is git gc, then there's an option to disable that and let you repack on
your own terms.  It could also be that there's a process being invoked
by your editor, for example, that you might need to adjust in your
editor.  Determining this should be possible with `ps auxf` on Linux and
it should show the processes in a tree format which will also indicate
the parent process (such as an editor).

As for the request to stop after 30 seconds, there is no such option.
Git isn't actually doing nothing in most cases, or it would have exited
already, and it would be very undesirable to have most Git operations
(such as a clone) spontaneously abort after 30 seconds.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--fJc4H4Ysyo/MNoGC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZuiRPwAKCRB8DEliiIei
gW0TAP4xyEvJmjLNrN8FdmT/kGYeSUoM/m5zUtZLzYLjTnQ7ugD/SUF14NKr5mMn
3xDJFieouzqN0DDgXChV66ZNaVFnwQA=
=Wgur
-----END PGP SIGNATURE-----

--fJc4H4Ysyo/MNoGC--
