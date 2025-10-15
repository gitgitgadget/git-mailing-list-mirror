Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8201F1537
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567521; cv=none; b=XkmV9cATvOd98nWd9DWXHpHS85lSYW0rX0m4mrGsMINhJkngoShiewDlPatwI9njtbOrMQCAZ0rFj958WgCnbLIaKPjkwo2M5hMNaPFmVSvnBf3IQS1VavygGRqwvISSbdDO/pMICjLSMHZN8mb6wwc05ZXQ6EjGNLIGrXk7gzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567521; c=relaxed/simple;
	bh=PT96cMjif0060PpuljQaL/KCqN4UxW/SiKj99Dc0sfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmMt0pDXGB9gqsSgF0A/PJe/066cIzj+1PfrPyQkYhOcNiov+eanZSOJLAYJpNxwvXYJynEx2E37lZxOCVnJHAheWDtoE6n6eVksIWBBKCL47OLGHpVBNkbP/eY/hCv877ooPtFMnvqGYwU6Ca3vG8syE9O5lkHhE6ZGK722KW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=eYJjxmq7; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="eYJjxmq7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1760567519;
	bh=PT96cMjif0060PpuljQaL/KCqN4UxW/SiKj99Dc0sfQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=eYJjxmq7o1M9cTU1j+DOND3Lh2dQjDq2dJ6m/tdm53vs3Zu+1RQKJLND8pjqc0bKL
	 +5dfyb8yT2FjP4ZcFLlKoe6wZDzQDw2gjCZMH9v62dbxv3WveO6Dvl0gY/3RkNppw5
	 309sDxe63wG9VdQ1ll3ciIRxlZ01OaF7k/pCA7leMR659Zkfi68JBgxaQ+JIBc/Qhg
	 qAf0jUWT2ADbdO/hak7ncEJyup9pG+KCiO+uoIsA2tAHAS3oQNRWHnR7lFFCyU+WtH
	 DouiA3l1Wsz9AsW32XUmp8HKfaEersTryBVW6/eFrMpNJHTzkHsPK4/Q8QJjblZKO3
	 Yljc8mKhfstUriYIp/4FzNK6OozXJu/gBhmOwxh88SlYb/3CfgUZiMWsNEGrQchAFG
	 ZO+osSaB/JFRy7Iq0Gjrn7Y/iad+7Jmuaz8Kkw4kps9G9BCvJLbiV0A/LTTwArrrzq
	 +0cAPfQ7GwUZ49pMNEMUBAAHd1/1QxUj+cZK61EXbhWWpXYCSLU
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:a1c4:25fc:92db:3a96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 34754200BA;
	Wed, 15 Oct 2025 22:31:59 +0000 (UTC)
Date: Wed, 15 Oct 2025 22:31:58 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ashlesh Gawande <git@ashlesh.me>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] http.c: prompt for username on 403
Message-ID: <aPAg3gYwzA9fHCC3@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ashlesh Gawande <git@ashlesh.me>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20251014144354.1457818-2-git@ashlesh.me>
 <aO7Aqooz-0ppbcMP@fruit.crustytoothpaste.net>
 <30639771-4999-45f4-a8d7-1ed4774ffd8e@ashlesh.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6Wp/iW7EB9z+FS8k"
Content-Disposition: inline
In-Reply-To: <30639771-4999-45f4-a8d7-1ed4774ffd8e@ashlesh.me>
User-Agent: Mutt/2.2.13 (2024-03-09)


--6Wp/iW7EB9z+FS8k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-10-15 at 14:12:09, Ashlesh Gawande wrote:
> Oh I see - yeah don't want to erase the credentials.
> Was trying to figure why 403 was happening instead of a prompt (as I was =
not
> aware of netrc file being used).
> Thanks for the detailed explanation and suggestions Brian!
>=20
> Is it worth it to include the netrc tests in git that I wrote as part of
> this

Yes, I think if you have patches to test our netrc handling, those would
be very welcome.  I was complaining a couple months ago about how we had
no tests for netrc after I accidentally broke the code that makes it
work, so I would very much appreciate any tests we could add to make
that less likely in the future.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--6Wp/iW7EB9z+FS8k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaPAg3QAKCRB8DEliiIei
gYBzAPsESlV4DXDIl7xJOzO646TiXeKigJgdgIaxNhLMEf7XbAEA+VYT/bgRnqPV
WoHr9wUbPnd5ZnlRhGSMo2QAQ924Mg8=
=mTFW
-----END PGP SIGNATURE-----

--6Wp/iW7EB9z+FS8k--
