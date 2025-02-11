Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7674D272905
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 22:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739313988; cv=none; b=dCtr0K98AkYCodVpKP2zxAqEUo8buz/r6TOeM+1mS+4pbPBPSgxCaszlTw+sAhfwK05JnYJZomXwVjR0nK6astOhiLicR23k3Xp737JOvgshC1ziyPin6cnNTFhyLbzL6fhZO/X3AVeVxEnKiDzBSznPxeFO1/0XUFbarq5UlOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739313988; c=relaxed/simple;
	bh=XbkkKNQTl5S3391yKgm9tAhp82Gj2fyXbydY6DU+Ktw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cm7T9/xd74rYfJPl2GgqzU68scL1pHR6bnNrnGvuT5pZO1+J1N2dwwvLhM8vdTestt+XPsHveMeqyf0m0AwWAST8MVfciLczPZgme1Vu8mCP9DP59Nw6jNtRaq/Ew4Wc6hQ6B//WbL87HNKlZNlqMdNDBX0jyABm6yL6T2UBI+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ddgeKqE1; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ddgeKqE1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1739313977;
	bh=XbkkKNQTl5S3391yKgm9tAhp82Gj2fyXbydY6DU+Ktw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=ddgeKqE1wdPv2UAtdAndq/Y8BUcvcETkmSirY96in8XGPx8ZE5DnueL3klwiR5vuQ
	 xtvrq7U3nMH1UGjJQIo5PfL1QtaxJ/31RnjoeEPO51G2TaP8xkRX+uuEfLBOGm5QOi
	 UZpGDhFxouOFxLIJ/Asn3vziY8ygEBXuSs+QHkWb3xBo5s5zwzwLvK/rH75PkFYagT
	 AheMEajE9EfS0gpO9oGY1yeCXcLjwj+hvWTM1w4TjNs6otOb/YsJHls3YuF0+p9i2J
	 cG8nx782T+71p6IaSyqSoOAejC9RRR0TpqHjr4Aw9B4Rq6AEACQazoqQJ9rq/OzcsN
	 00wp/r2D8bGEEu3RBNYV/or8kDUpE0bRFvQbAPVgIqczGy37yySZBfi6w/GYcC5Udd
	 VqlXedNzvxNvz7+ZuWWkd49VMMWAbgLEDg8q1swe7UzLCEWekxj6aug82ZWvuChgAf
	 F64La8Uvoc8hS8ZYq5fC/lb22ItHrXaOtCIXzbWFbnT1mRwWQHU
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A48E320076;
	Tue, 11 Feb 2025 22:46:16 +0000 (UTC)
Date: Tue, 11 Feb 2025 22:46:13 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jeff King <peff@peff.net>
Cc: "Maloney, Bryan" <bryanhm@amazon.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"Perry, Daniel" <dtperry@amazon.com>,
	"Das, Satabdi" <dsatabdi@amazon.com>,
	"Damojipurapu, Deepika" <deedam@amazon.com>
Subject: Re: [Bug] Git ReadOnly Temp Packfile Causes "Bad file descriptor"
 And -13 Access Error With NFSv4
Message-ID: <Z6vTNW9Dz4jiJvXO@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, "Maloney, Bryan" <bryanhm@amazon.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"Perry, Daniel" <dtperry@amazon.com>,
	"Das, Satabdi" <dsatabdi@amazon.com>,
	"Damojipurapu, Deepika" <deedam@amazon.com>
References: <18589D54-5E7F-434D-A890-B39102ECB293@amazon.com>
 <17DE42DF-D2A3-4E25-9198-5AF3CA516E35@amazon.com>
 <Z6p-eIxzrFepC3py@tapette.crustytoothpaste.net>
 <20250211213940.GB3113114@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0M5kjWIR1AcVzQxo"
Content-Disposition: inline
In-Reply-To: <20250211213940.GB3113114@coredump.intra.peff.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--0M5kjWIR1AcVzQxo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-02-11 at 21:39:40, Jeff King wrote:
> We could probably create and write the tempfile as 0644, and then switch
> it to 0444 before renaming it into place. We already do something
> similar with adjust_shared_perm(), I think.
>=20
> I don't know if it's worth doing it that way or not. It should just work
> even on systems that are happy with the current code, so I think the
> only downside would be a few extra lines of code and an extra chmod()
> syscall.

That may work here for this instance.  My concern is that we'll find
some other weird, hard-to-reproduce behaviour because files are silently
getting reopened and permissions are getting re-checked.  This bug is
much worse than the standard NFS/CIFS implementation bug where open with
O_RDWR and 0444 just fails up front, because it can happen in the middle
of an operation we thought was going to be successful.

I'm not completely opposed to a small workaround here (although, as I
mentioned, a decent amount of other software would also need patching
for such a system, which argues against it), but I don't want us to have
lots of workarounds scattered all over the code to patch one flaky set
of NFS servers, so we'd want to limit it to this one spot, especially
since this won't be easy to test.

I will also mention that this NFS server will also break lots of
proprietary software.  One of my former employers had software that
would do lots of open/fchmod in quick succession (for good and valuable
reasons that are too long to fit in this parenthetical), and I'm pretty
sure that won't work properly on this server based on the described
behaviour.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--0M5kjWIR1AcVzQxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ6vTNQAKCRB8DEliiIei
gU9UAQC9ZL+KjyLZ6CgPNi4M3mGHFQrrvXtbCUi858L8/T+VtAD9H/7kbyQ6thRi
ckVXybD2gl2ziylJHS0tOkVldhSI1QM=
=RNi0
-----END PGP SIGNATURE-----

--0M5kjWIR1AcVzQxo--
