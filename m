Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E572DBF78
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 22:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677672; cv=none; b=Ry26Mh+R9SCxEdjCjGY/MPT55XotIFO+7ZRU0smf3MM8chbn33s9zvU9ALxLsl6uN4eyVrEZSlDtA5kIN8MVrfPAECNNJlYF3y75gaVPqtpPjxixK1ymO9WYG65Y0bK4iI0d7PdQjAmEEe9X9oA2ZATl7WUj9nYt/mCXk4Mivdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677672; c=relaxed/simple;
	bh=mWOaUrwzKcVVAOZwZrSGDidSIuPyKg/FiuQvuFR4Hdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeGIM8BC9PX07+7XEG9jcuESwd1zhH1dxj9cl0spd4y3ONytXszSwE20Dw0ugpOUj9WGaUBuCnGwDdviNeGx5Xehav4IYNn+B7zfJTb8TQCqz4mU/xFEvQWyAWyluVjE5p+QtD4VNo0F0PsZkyNzDILVCa4DaGJrFINl9o4mFhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ROpilIBs; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ROpilIBs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1763677668;
	bh=mWOaUrwzKcVVAOZwZrSGDidSIuPyKg/FiuQvuFR4Hdk=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=ROpilIBsMdq6wDjT7zqIZhQEicEVla5IsZb5F228pGzx8j7JZkPRSVr0vwURD6cy6
	 +kn6LwVQXM1WgofKJb6vQMKRjbkl+xQRq/oyzz1jIdecuM4mnx6v6VUx8iHwxwMw+o
	 ojp9weuAnivSLiXYTsqVbCUpyg4vg4PoCK2jxOuEmxXNTTtPSu2InWV0aUB8SaF1pf
	 5SdCZCpbZ9sAcUK6taV1J4f9vXyoZArpLlKuOvEuFvSwF3jG7GkSA9N8xzUqezwAud
	 6U83T7gbOyIRn6HFmcCRyk37J517+Hd9WiWCv1ovkbDAXbbEpLijmXcpEHsKGtiTq0
	 /YgEMrA3KBaMwJu6MRZ0OHsaDWWjUKb4LQwRXLRE6qHKT3IcZqeUOFQ/oBilg3YTaB
	 gGyof2gsCVM/sC7mX+iicXq+3fn3qK3xB3x+n+YBfFnYJP1vC9bptU8anmWqPNKgFn
	 vYOVkqfkkEh+m0PvauPgWCsUq8f5ShAPvCPFGdD+8cb8ZJydM0h
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ae5c:878c:d4d7:64f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 5CD6820065;
	Thu, 20 Nov 2025 22:27:48 +0000 (UTC)
Date: Thu, 20 Nov 2025 22:27:47 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] config: mark otherise unused function as file-scope
 static
Message-ID: <aR-V45lWv6kYSe5b@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqtsyo7b4y.fsf@gitster.g>
 <e67ee4f6-9516-4561-b9f4-06e9049ff2ba@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4ZbUYgTr8DAUC9ON"
Content-Disposition: inline
In-Reply-To: <e67ee4f6-9516-4561-b9f4-06e9049ff2ba@ramsayjones.plus.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--4ZbUYgTr8DAUC9ON
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-11-20 at 21:15:57, Ramsay Jones wrote:
>   $ diff nsc ssc
>   0a1,2
>   > add-interactive.o	- clear_add_i_state
>   > add-interactive.o	- init_add_i_state
>   38a41,44
>   > hash.o	- git_hash_alloc
>   > hash.o	- git_hash_free
>   > hash.o	- git_hash_init
>   > hash.o	- hash_algo_ptr_by_number

These are called from Rust code so they must be public.  They may not be
used elsewhere in your branch if you have not compiled with Rust,
though.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--4ZbUYgTr8DAUC9ON
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaR+V4gAKCRB8DEliiIei
gV54AQC46Zu3d6CW0Gz79Mz7HM/J4XLAak7t1j9Ru6HSsUMiGQD/eTWhMJsyPaUH
3ScdsT+4mk35rvOGZXnFAC6pno3ipwI=
=KrMN
-----END PGP SIGNATURE-----

--4ZbUYgTr8DAUC9ON--
