Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356171A3164
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 22:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755209789; cv=none; b=B027uJcN8SyH3BWT0GjNCQ6EAIrkEkmvhuA4X9xQGIj7G06XOLeQ43wyEtO1Qiy5YnKx88thBWpSd2AebKCk5nUwAmV3BwbfeG5l/TrwR0PxWyPIL4P+/eudh0++7G/skNC/uH0T9XRl7u3E2ZoeFijtrp/kO2Uv9f4eXzYuxgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755209789; c=relaxed/simple;
	bh=dkCmgnMz2GvQtGqM3VdNMnySrsRkNk2EJxpYIM2nobE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2vx3j8msbV8s/JAeWpFWuv9+WmBWCMOXzU076jBaK51DUiE43MBgk4Q3Ka1mwaJ8Nj+yR2C0vmjnWCW6k3/VR6Dct/bL0AySyXzOXUzw7QFn4P0NeiF2TwJcauBSJtKcelKu73N0pJGrvypSEp8J/HlOs2JiJ6iqii6Ffg3/T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=uYkiWP/h; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uYkiWP/h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1755209785;
	bh=dkCmgnMz2GvQtGqM3VdNMnySrsRkNk2EJxpYIM2nobE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=uYkiWP/hyN+6/f4E7rUmjbf8ZRXnVcGJe792JzGZasUi8EgTHX9AAPUedQnFPY+Go
	 kREIwDA74l+S9KBVX8tPCxBSJH1vuvy5OmuLe8FMJpFReUVgtggJdLa02MkDIozVNc
	 TwELIFat/fltR8ZN8Z0zupcYMrDUgZ+kBaOVV08xI92uePptblpaIzTV0bXSE6ZKvp
	 U6EddcuEeoNkHgvAqTaVns6+liITZDJsJhSduz8SU+EYYxjVyJ3yee4RGxCg5I4F6r
	 88wkqirXQjHgvtznPrYf06Noyr6PMRDOPt9CdsEjfPwMg0aJdV21vmKuvmnCyD0VEN
	 u0g3swrcac9ojDv0VQlP3VQhyInLs2zxSon/JVnEEdOH4K0Drt/Afk5Yhb92viFiN0
	 3MOYE5x+Rdl1h2kfeI9ivA4d++hb79ow32KK9UUzUVA7UZPpsacQOoeitCGFQ5WOK0
	 u4Kzy4LVEeImUqKVt8QC3yMYOhG+391SYDU9dBxVM6aVZ88tZZg
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:8756:2fa2:aa23:19b4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id DE72A200B4;
	Thu, 14 Aug 2025 22:16:25 +0000 (UTC)
Date: Thu, 14 Aug 2025 22:16:24 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Michael Schroeder <mls@suse.de>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] submodule: truncate the oid when fetchig commits
Message-ID: <aJ5gOPQ9oologqj-@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Michael Schroeder <mls@suse.de>, git@vger.kernel.org,
	gitster@pobox.com
References: <aJ37eHEGMw6RgmZC@suse.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ruAOxFXUC4GxhLDD"
Content-Disposition: inline
In-Reply-To: <aJ37eHEGMw6RgmZC@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)


--ruAOxFXUC4GxhLDD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-08-14 at 15:06:32, Michael Schroeder wrote:
> If a submodule uses a different hash algorithm than used in
> the main repository, the recorded submodule commit is padded
> with zeros. This is usually not a problem as the default is to
> do submodule clones non-shallow and the commit can be found
> in the local objects.

This should not even work at all.  It may currently behave as you
suggest when the main repository is SHA-256 and the submodule is SHA-1,
but it will corrupt the data if the submodule is SHA-256 and the main
repository is SHA-1, since then the data will be truncated.

The proper way for this to work is that the SHA-1 version of the
repository stores submodules in their SHA-1 states and the SHA-256
version of the repository stores submodules in their SHA-256 states.
Yes, this means that you have to convert submodules to the same
algorithm, but that's required because trees are binary and not text.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--ruAOxFXUC4GxhLDD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaJ5gOAAKCRB8DEliiIei
gSEGAQDlpQwnuIukqxeucA61ps8Mh23aZ20eaCsAnKzH3V7U0gEAxr2pXA5hLPwA
/5TluSCXIrCDl4e4/aXY0xsOgfAUoQo=
=2OUC
-----END PGP SIGNATURE-----

--ruAOxFXUC4GxhLDD--
