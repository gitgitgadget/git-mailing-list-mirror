Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067841E5207
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743190773; cv=none; b=sIy6FfSrXdClc8uVcD99NVz2nKfC6AuCr7V4cmxCUKqr+yc3OqO3a51DjpZR4BXxYwRpjAHiQ+9LQpHu4szyAAwhkdLMwIZvRnJBH3zZ6XDFGD9Qjz93ESCPIMuO4LUZpUfjmD+ZPAjdllh4HzUaSklDqVBmgbNHC+Vjm+biOSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743190773; c=relaxed/simple;
	bh=y1N1YDN1minpuR9JxJB+ou+6YBeZKPDOPPXwx6iFpk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBjJRBtCW/z/s0NOHw34qJgb6SdR4uv/XB/eDsfaMQJFfzWnAOxPov11GXn5uGuEs90rb/EVTrIiUUiL9MQl8Xn2N80/i/pADTLndxXnkNiEEJI2L+bzrgmsBPnNyuBTW15gMwbQ2JeJvKglPsxoBmT5MdA1Tg5UgHIJqFMEKnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=j4xwi9H0; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="j4xwi9H0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1743190763;
	bh=y1N1YDN1minpuR9JxJB+ou+6YBeZKPDOPPXwx6iFpk4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=j4xwi9H0En+v7KTdntIRb/2u/gMSBnecpHnbvYW8h3G85IKoNtkc/FlWpK0pDI/pJ
	 yjUikmsnsfT3GLwQlu9IjmCIFiRbaOgu8DYuL3N3mfIJLNOnTwteB/yIjy3wKC2GfS
	 eXni37w5cIa644SyQHaK3+T5oigOxy9X3AuLJPQvgJnioCuWHfE/n6dWtlft4c32M2
	 9cAu0gWVyqu/Ln4QRKKw0ODUqXjt7O34kGyJuVOrW6H6YMwNHdahFgb53SXdgiecCy
	 8ZbfUJ7qkrK5n/On7Uw6PxvrbCV9F0+FunYbOT7PQgQOORZrMvQ3XKwKad73xnTRie
	 t1Ci3KjNFmS3dES+pie4AwV5c4pGuJFDJX5S5J3SpNZ84sOadeejj2MZ8iEgy8916s
	 bkUjdf7YxtSbaUN83XXRtxqSdNXfuTEjvkqKxPau3K35Dik2J9JDPH5H48FMPZjdV6
	 kGg+YtbIAp6gY7tc9TLl0izF3s3FdCwOOixEbsLkNPeNhpnnq78
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d5c6:e1bb:f3a5:7a20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D8232200BE;
	Fri, 28 Mar 2025 19:39:23 +0000 (UTC)
Date: Fri, 28 Mar 2025 19:39:22 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Akash S <akashs@commvault.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Adithya Urugudige <aurugudige@commvault.com>,
	Abhishek Dalmia <adalmia@commvault.com>
Subject: Re: git push --mirror hung indefinitely
Message-ID: <Z-b66vVzQRFFHFK_@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Akash S <akashs@commvault.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Adithya Urugudige <aurugudige@commvault.com>,
	Abhishek Dalmia <adalmia@commvault.com>
References: <SA1PR19MB7013490588962D983094128DC0A02@SA1PR19MB7013.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VgNBXYdifisVg6G/"
Content-Disposition: inline
In-Reply-To: <SA1PR19MB7013490588962D983094128DC0A02@SA1PR19MB7013.namprd19.prod.outlook.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--VgNBXYdifisVg6G/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-03-28 at 10:37:43, Akash S wrote:
> Hi,
>=20
> We are attempting to push a bare repository on our local disk to Azure De=
vOps using the command "git push -mirror <URL>".
>=20
> Git version being used: 2.48.1 and no global git configurations exist in =
the machine.
>=20
> Issue: command progresses for 5-10 mins and then the git processes get hu=
ng after we see the output "Storing index (done)" and remains hung indefini=
tely.
>=20
> Steps to reproduce:
> i) Bare clone open source repo (elasticsearch or node) to local disk.
> ii) Run "git lfs push -mirror" to any repository in an Azure DevOps organ=
ization using PAT authentication.
> iii) Issue happens intermittently, so alternating the push operation betw=
een the local elasticsearch and node repo to the same remote repository sho=
uld help recreate the issue.

Does this happen if you push it to a different server?  From what it
looks like here, it might be the server not sending anything back in
time.

Also, do you have anything intercepting TLS, like a non-default
antivirus or firewall or any sort of proxy?  Sometimes such tools buffer
the output of the request, which can break things[0].  If you do, you
should either uninstall the software completely and reboot (since
disabling it is often not sufficient) or change networks if there's a
proxy or TLS MITM device on the network and see if it's fixed.

> Workaround steps taken by us to not face this issue:
>=20
> i) Since our repository is quite large (1.5 GB), we set http.postBuffer t=
o 50 MB, it did not help in resolving the issue.

`http.postBuffer` simply sets the value below which the entire body is
sent with a content-length instead of using chunked transfer encoding.
As outlined in the Git FAQ[1], this option doesn't need to be set unless
you have a server or proxy which doesn't handle HTTP/1.1 properly, and
in general those are rare (because a lot of stuff would be broken).  I'm
sure Azure DevOps is not broken in that way.

Since it almost certainly isn't needed, I'd remove it, since it just
tends to waste a lot of memory if you don't need it.

> Thread 2 (Thread 0x7fa246a18700 (LWP 1043384)):
> #0=C2=A0 0x00007fa24ce568e4 in read () from /lib64/libpthread.so.0
> #1=C2=A0 0x000000000066a07e in xread (fd=3Dfd@entry=3D0, buf=3Dbuf@entry=
=3D0x7fa246a07d7c, len=3Dlen@entry=3D4) at wrapper.c:234
> #2=C2=A0 0x000000000066a1eb in read_in_full (fd=3D0, buf=3Dbuf@entry=3D0x=
7fa246a07d7c, count=3Dcount@entry=3D4) at wrapper.c:292
> #3=C2=A0 0x00000000005c4d32 in get_packet_data (fd=3Dfd@entry=3D0, src_bu=
f=3Dsrc_buf@entry=3D0x0, src_size=3Dsrc_size@entry=3D0x0, dst=3Ddst@entry=
=3D0x7fa246a07d7c, size=3Dsize@entry=3D4, options=3Doptions@entry=3D1) at p=
kt-line.c:354
> #4=C2=A0 0x00000000005c5827 in packet_read_with_status (fd=3Dfd@entry=3D0=
, src_buffer=3Dsrc_buffer@entry=3D0x0, src_len=3Dsrc_len@entry=3D0x0, buffe=
r=3Dbuffer@entry=3D0x7fa246a07e20 "\001\060\060\061aok refs/tags/v0.10.45\n=
", size=3Dsize@entry=3D65520, pktlen=3Dpktlen@entry=3D0x7fa246a07df8, optio=
ns=3D1) at pkt-line.c:422
> #5=C2=A0 0x00000000005c5fa9 in recv_sideband (me=3Dme@entry=3D0x6e35ea "s=
end-pack", in_stream=3D0, out=3Dout@entry=3D5) at pkt-line.c:586

This looks like it's waiting to read a pkt-line header, which should be
sent periodically by the server, so my guess is that this is particular
to the server that you're using, or, as I mentioned above, that you have
something in the middle that's intercepting the data.

[0] https://git-scm.com/docs/gitfaq#proxy
[1] https://git-scm.com/docs/gitfaq#http-postbuffer
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--VgNBXYdifisVg6G/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ+b66gAKCRB8DEliiIei
gdMyAQDzEIFF7+cmt1eM5smOGY+3c+Cz6uFo+97XT1fTjbHNdQEAvhmatqrjC7xf
Wr5pwrjESbWw6MKRAPseGmssv1+tmgE=
=AV2T
-----END PGP SIGNATURE-----

--VgNBXYdifisVg6G/--
