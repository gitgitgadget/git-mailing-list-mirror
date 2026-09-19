Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9DF33F5B3
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789830617; cv=none; b=HR4HLf6b3+Mi/iTL0Lcm8g5icY+hIwRbaCbFK53A91q27eG4VTQn3G58uumn56p7Ies2lkgOcNqRLkpu72Dm2N4wfUOGtdZ9t64nzHNv3nM+N1boeLqIP3MQCJ89M5R0hBgE9v4Zkxy/3Hjpw3kwarLtijGZ0KPUxJzwRdOYRSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789830617; c=relaxed/simple;
	bh=BED5GNUvMovGw1PNMoL+WzqAEZBPvdcYhP0deYvIUxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZU1AuGptyGMWkLS5oAVWimquWk9kY97hcfLgc2eGg38hcXGxxUuxgPg6jzqlQrKTOZqmBRF9XEKG7TfF7iOdiTIfwkZwydq76fG7XZzfUJCk82xq8FDojAWGwsfBAJVR47SOJ9TAdfULWXe9za6GpeEonPi2SKdr1Hoip+gv+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=muyoY+gH; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="muyoY+gH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1789830137;
	bh=BED5GNUvMovGw1PNMoL+WzqAEZBPvdcYhP0deYvIUxE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=muyoY+gHixSMJbgPW1AKb6toL611rFzqTqZ1JchDHfUXKgpY3KNlHv9bL/670LX0m
	 gxJ1CHs3RZ/vZHnmyY2I+MRgpICKZIFqajWdh8C4GVw733zycorfPEA7q3f3jXt39p
	 uf+dSbl0dgOZV8arMcNYEsg+vEV0OzjTPGvXIpsJJ0E8RFAZnoGWzaX2tBMgmQOfOB
	 fjKYoYYiqLGW6zN2jBMBinrLtoFm5Nmn/NOmNl+OzqIPzD+PY9o6n0Rn/pPQGY2d98
	 nVJAHUXEgZw4c3ZCZTerfbBawZcmm/Tz54MGmKMIcXoQeZVJ9IMwWy4Hf8ZJyeFVxt
	 HHL67ipEBp6cz/a7+XcIKt6iF+e27ojJxye+oDw+tF/fR9xKaIIXxpYpW3rkzyQaXB
	 Do7cnQ9f2m/5yeGwXTmN6+t7qcsVsSBUAYde3DS2GyeO776ZNBQsvnWDgbhyoWk6xf
	 R4RgSIi5mRnCBjPIEEWc0oOF7UwCGsgbPm/u23/U4jFfRwSfqZx
Received: from fruit.crustytoothpaste.net (unknown [205.220.129.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8F57F2011E;
	Sat, 19 Sep 2026 15:02:12 +0000 (UTC)
Date: Sat, 19 Sep 2026 15:01:48 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Yashwanth Sai via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Yashwanth Sai <ysaimuppineni789@gmail.com>
Subject: Re: [PATCH/RFC] commit: warn when a new commit is dated before its
 parent
Message-ID: <aq6j2yg16L2iNHoR@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Yashwanth Sai via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Yashwanth Sai <ysaimuppineni789@gmail.com>
References: <pull.2226.git.1789826665188.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cYWdDetLuqQQp69Q"
Content-Disposition: inline
In-Reply-To: <pull.2226.git.1789826665188.gitgitgadget@gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--cYWdDetLuqQQp69Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-09-19 at 14:04:25, Yashwanth Sai via GitGitGadget wrote:
> From: Yashwanth Sai <ysaimuppineni789@gmail.com>
>=20
> Git writes whatever the clock says into the commit object and validates
> nothing: a commit dated years in the future, or earlier than its own
> parent, is accepted silently. "git fsck --strict" does not object either,
> since fsck's badDate and badDateOverflow checks are purely syntactic.
>=20
> That would be harmless if history traversal did not assume commit dates
> are non-decreasing, but it does. "git log --since" stops walking at the
> first commit older than the cutoff, so a single out-of-order date hides
> every commit behind it:
>=20
> 	$ git log --pretty=3D'%cd %s' --date=3Dshort
> 	2026-09-25 C3 - inside the window
> 	2026-09-01 C2 - outside the window
> 	2026-09-20 C1 - inside the window
>=20
> 	$ git log --pretty=3D'%cd %s' --date=3Dshort --since=3D2026-09-13
> 	2026-09-25 C3 - inside the window
>=20
> C1 is inside the window and silently missing. This is understood --
> 96697781e0 (revision: add "--since-as-filter" option, 2022-07-19) added
> an opt-in traversal mode for it -- but nothing tells the person whose
> clock caused it, at the moment they could still fix it cheaply.
>=20
> Warn at commit time when the new commit's date precedes a parent's, gated
> on a new advice.clockSkew setting. Warning rather than refusing is
> deliberate: only the committer can tell whether their clock or the
> parent's is the wrong one. Once the commit is published the date is part
> of its object name, and correcting it means rewriting every descendant,
> so the warning is worth little later and quite a lot now.

I think such a change is useful and it certainly has been discussed on
the list quite a bit.

> Co-authored-by: Claude Opus 5 (1M context) <noreply@anthropic.com>

I don't think this is allowed by the `ai` section of
`Documentation/SubmittingPatches`. I wouldn't be opposed to seeing such
a patch if it were not produced in any way by AI, though.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--cYWdDetLuqQQp69Q
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmquo9sJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ4auOFmcboUZXtlvLkZzSviMknqrss2lsrA8ReZavroB
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAHHHAQDH3N58+ZV3s/1bLKN98VcNdsPA
4vC6WyPH0B4e1KMAYQD8C0ZqS4wsRVYPVISzl1AElymzGyokRYqkNmtbGymB4QE=
=MefL
-----END PGP SIGNATURE-----

--cYWdDetLuqQQp69Q--
