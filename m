Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FD8161
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 00:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712880593; cv=none; b=HB8cFsT7JHWDdVR1CZiSXEeA5/MRqoQjDvwpiNdkGCXjv/F49rNv2vBxZpHM4BP67tNaZu3M0SugyRwk6KuXx+VG2fSHmw5EK7P+wybnvsd47xRAYx7jLcP54GHRMO3Z4VYeaHUgBr4WVoSzdsqBQUiwj0xfxsE2r5xWorelfMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712880593; c=relaxed/simple;
	bh=iPsOIyiaPcBcMGAV/AGvhlR27+K8hnegFuOrDuY6EJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvTpgvHia7lehX2R3RqSAVIC0Q8LhVxcYEvOQVT6FzMpp60/Me8GfJsCwB9Yzf/aEhNjcvfWQ9BZKr7gmDkXzt2jG6eGNjcbzriZQHL5LtN1+0Wgw1l6s8VLJ1G7ilTaBQYarIWR1oHYcVTDKReEVV/16GwbM1Rpz6DiuCGo/18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=cpMXs3ME; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="cpMXs3ME"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id A6D715D4D7;
	Fri, 12 Apr 2024 00:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1712880583;
	bh=iPsOIyiaPcBcMGAV/AGvhlR27+K8hnegFuOrDuY6EJc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=cpMXs3MESWG6iGjh1XscAuJ3ar9Dv0XSfXfNj8hhaKajRHSxfI5Yoyn8isrQqOFCR
	 7jAXcBO1SdrNuKCNpA0FytKh0H6oH8i+6LBT+CiZ5mMj7NVkBj22zw3myVBIfQcY6Z
	 6OIyFjbrqOCzG9CWmFCT9N3XC7VjmVXCSBAoCAtEIOAhAwzwdCrseWn3WCYqE9Wwsi
	 yyeow5kJByDga7vGmxRRiwhhj8Bdc3UErN+0SXYbo9/6dgvEWq3NquDKLxlqbVN9sE
	 Tk1eRjHjkySxsTu6e5Q7HBzjMExciL6tQp9eSH5l5k8xyrKf8/7Xs9dYl8/DtoXJD7
	 ZfrVypfTdfhrU/RASkrF0gRzG2xYQU4124k9HIXmg2eKt8vS8V8RPmqSuGrMYuL67l
	 JqjPcA6cJK90wyklh+XrAKlkPqpr5zy37k4GbF4dPfwKSuYgvWN968eLQrCVbZpOVv
	 tLwAvMSWju/GBSNIIqjPbcMzUcxQl3qOxezNn9qpABxKLvSs49u
Date: Fri, 12 Apr 2024 00:09:41 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jackson Toeniskoetter <jackdt@google.com>
Cc: Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH 00/13] Support for arbitrary schemes in credentials
Message-ID: <Zhh7xZ3mVOxqUGL3@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jackson Toeniskoetter <jackdt@google.com>,
	Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
 <20240402222619.2212650-1-calvinwan@google.com>
 <Zg38BLxLe193zYss@tapette.crustytoothpaste.net>
 <CAD0vCJ=4-QoqUovaOuw6gPTfPEa+d6uJBaO_Vq9R9Btn_YXzwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="29DchZvp8Om2yKHu"
Content-Disposition: inline
In-Reply-To: <CAD0vCJ=4-QoqUovaOuw6gPTfPEa+d6uJBaO_Vq9R9Btn_YXzwg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--29DchZvp8Om2yKHu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-04-08 at 18:42:56, Jackson Toeniskoetter wrote:
> Just to clarify, we at Google do not use extraheader to pass along
> credentials. Instead we use the .gitcookies file[1], which iiuc gets
> read by the git process directly. I'm not a security expert but I
> imagine the risk surface of extraheader and .gitcookies is similar.
>=20
> Reading your post on
> https://lore.kernel.org/git/20240324011301.1553072-1-sandals@crustytoothp=
aste.net/,
> it's unclear to me why the credential helper protocol needs to be
> updated. If the goal is to support Bearer tokens, can that not just be
> implemented using extraheader? It seems like the goal of getting
> credentials out of the config file can be accomplished without
> updating the credential helper protocol. So is the bigger goal to
> support more robust and modern auth schemes which require multiple
> steps? That would be useful to Google; multi-step auth would probably
> be a more elegant way for us to stop using .gitcookies than other
> solutions we were considering.

Bearer authentication certainly can be implemented using
http.extraheader and the config file is also not a secure way to store
credentials, which is why the credential helper protocol is being
updated, since then people will be able to store the credentials in a
password manager or other secure store.  Other HTTP schemes will also be
supported as long as they don't require headers other than Authorization
and the credential helper can implement them on behalf of Git.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--29DchZvp8Om2yKHu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZhh7xQAKCRB8DEliiIei
gTiVAQDoD742HC+GUCGJlQ8Z0LzK7rufykGYloFmYKLaTn7lbwD7BW0xRDzkDN1k
iqBkMzFFi4Uwg9SPfjhutsYUvsGl/AQ=
=JFZe
-----END PGP SIGNATURE-----

--29DchZvp8Om2yKHu--
