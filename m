Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1A7377AA2
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787091192; cv=none; b=Ii2L2Jbj2r5tYQ5vAkMD+dbN5KSlGabRg9f+7NnzflqSeQqTLlJcJmC74xdRtERnnl0ZWqhRImBApdpalDUrmFkzREHvYsyseXRh/BQfb5X8Nj69zknlRVZlVPlKCUhFT7FDUcmgZ7EIqVbOLElbm2C+ZB0z7/20su1bNURvV28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787091192; c=relaxed/simple;
	bh=f6vtSrgGUMYijbbEx0rFA07AMn1pWPGEKbyg+GfbFzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d12S1GA+1/fhLdh328mXk4UH/tWFFW8/+inaamG6N6tkxw/QVAqf+53K1j6kO3XKtzD/7OGoj3THc4aFwrgr6vtR2S4MdFD8NhWsQL+PejNhU0lxNCcNkEPULfmOZ1XMy8b2JI/Og3AtUnc9TX4iOZlmZLxcx+yBTTa5iyLYIuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=MLqcCuCk; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="MLqcCuCk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1787091181;
	bh=f6vtSrgGUMYijbbEx0rFA07AMn1pWPGEKbyg+GfbFzg=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=MLqcCuCkwS0P26YUjZLOo+m6IoXR3snqBqfqtrRenhYg06uKFlfa0eT6rgqFqgkg/
	 vE58WH9NGMtCiDzwnRmIIW6PsrGRMTiJgfrJi8SOYrfd6aVEfqVpHdmlFaJXONpiSe
	 9mn9oAMr3OHWOi5pUHTMvTeHfwUUSzFokT15ZZh9B3IDLBwa/tK41MqIPC2lnvAHLt
	 6hbG8BlYZ9QxKB31XC9k0/0f0hCXTmUIyjrJvKIMhup3MNe8l1T5T6TVDN4SQXT7Db
	 pIHzdnivchnQwX668QO8IGhpUzv++Lfzn1mXDTb3zwlshLOBy/EhMc/chioPLugjh2
	 gJ2KVAelocN7jn0W9wXh77+5CEIKEIavbJLmICSDr0X8jzd1xbGSYbPN3bFQb0rJjf
	 1f8lzZ7YLaOHGlrTRCS5paGDQIis4FyNOn4y27XZPMRba8c40A8ss3yo47NQGBxfug
	 6Rv0dVmEL/zy+dWHevSqrzuYFL9YtSykzHVIWq9FqyrEhTnOlPK
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:4d9a:3753:e4c2:1e0f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 2AB6620101;
	Tue, 18 Aug 2026 22:13:01 +0000 (UTC)
Date: Tue, 18 Aug 2026 22:12:59 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, Kenneth Lorber <keni@his.com>,
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [RFC PATCH 0/1] config: surface editor failure in exit code
Message-ID: <aoTY6_wfcroOwrob@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Kenneth Lorber <keni@his.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
References: <20260817211936.2943278-1-keni@his.com>
 <xmqqse4c2wyu.fsf@gitster.g>
 <CAOLa=ZTykwSDcFaEmEJJ1PTnX5L9=2t+tkCWhF+hV4J9EPBwWg@mail.gmail.com>
 <xmqqecfv33h2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9tJB/FFR5l+bkuzd"
Content-Disposition: inline
In-Reply-To: <xmqqecfv33h2.fsf@gitster.g>
User-Agent: Mutt/2.4.1 (2026-07-04)

--9tJB/FFR5l+bkuzd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-08-18 at 14:31:05, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>=20
> > Wouldn't it be better to notify the user that something went wrong
> > rather than simply brush it off?
>=20
> If we were adding 'git config -e' today, absolutely.  The issue is
> not the comparison between signaling with an exit code and not
> doing so.  The question is whether the benefit or conceptual
> correctness outweighs any possible downside of changing the
> behavior existing users have grown accustomed to.
>=20
> Having said that, 'git config -e' is relatively new, introduced in
> commit 3cbace5ee0 (builtin/config: introduce "edit" subcommand,
> 2024-05-06).  The folks who may be affected are those who used
> 'git config -e' in their scripts and carefully checked the exit
> status (or rather, lazily used 'set -e'), and did so in the past
> two years.  So the fallout might not be so great.

I think we should propagate the error code.  Other than ed(1) and POSIX
vi(1) implementations, editors only exit nonzero when there's an error.
If someone's scripting, then most of the major programming languages
should not exit nonzero unless something seriously went wrong or the
user requested a nonzero exit code, in which case they wanted the
process to abort.

I would actually argue that people might be ignoring errors with `set
-e` that they intended to catch just because they're not getting a
nonzero status code.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--9tJB/FFR5l+bkuzd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmqE2OsJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ0bPTfijG0H53ez0NKpsb7+RgHuCZ/m7zSIvaFfiRAbo
FiEECCzmip28ZfuD0cORfAxJYoiHooEAACFNAP9EQdepr3EiimYuCyarylGTkffV
egpyA5hxR+YTVgghCwD+JWrols6hnMuRDh1WYxJMBvUz91jQeKdNDV5XPSkRyA0=
=OzYp
-----END PGP SIGNATURE-----

--9tJB/FFR5l+bkuzd--
