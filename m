Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EE4381AE3
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791278191; cv=none; b=Efypn/DjnyoAH4QdFV4gADv+4XHXo6qirff9+z9xijixbuFWIx+1buy7KO6H3OfOImXyOip+OkVKMTfKK+c4W2VXRmdQ4KA/FmXocg6rA7oQMrItEro2FX27beMOQjgq0qUQrsOrFhHQQXZCvk0GI+BCFIHPj0JS9MdzjsQW2bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791278191; c=relaxed/simple;
	bh=YVeNy6K59J4PeyChtt9KmvPDNb4d0sCdictrDVYcbwo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gFFMI3uiSfOlAJj6yIb0T1e34U8sQjuv/IAv6KSOK6KlLCSrcwBKrSvQUzQXcqKm7ndj8FhijJg2VYEZtAlmtIYi+QoC03p20KbE4/dlLlqzsUuPO/J1JpIVgMQ3WAHf9LqtQSn9UopNcz9HD09rUTfqwrg7PoL8bYwdPfvxkdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=s+AZr8rF; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="s+AZr8rF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1791278187; x=1791882987;
	i=johannes.schindelin@gmx.de;
	bh=uCow+i22/T0APeyjZOdC30bALHAj2NjEBVlcztEvPKU=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=s+AZr8rFe+/PGXYJvn+hGnT+OdKLm8ErArpnhVCwnnRI88dG8gx5ztGeSRztIFAH
	 GKed0a7iP1bcokJpB9Wjza2yLveOkdcvnKD90WR2vV9Aeju/BVSvaSiw2CWnAEKHX
	 FckYnabLx5WPBbS9SVnHOinK4eFWh6Y0xFXt/hJhj5e+MMRB9lpgGXAAhQJ7iWRG7
	 C1U4CChTF0yaV5ekJ3aF4c8avQtFcgNawC48VNdp7h3TqSeuc4k/jnAxWgtSk33S6
	 xm9jdJzrItbEmBjVKhww/npVd0b+2BpRWmZn92gisGp6TgefQriLd0hhl+Gry554b
	 sD5CoVAcb17uFop2XQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdNY2-1wegX50x6W-00laB0; Tue, 06
 Oct 2026 11:16:27 +0200
Date: Tue, 6 Oct 2026 11:16:25 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] t5551: fix quoting in curl version bug prereq
In-Reply-To: <20261006034331.GA1325722@coredump.intra.peff.net>
Message-ID: <4526e397-734e-d378-bb1d-31dd969c90ea@gmx.de>
References: <pull.2236.git.1790118373340.gitgitgadget@gmail.com> <pull.2236.v2.git.1790283229626.gitgitgadget@gmail.com> <20261006034331.GA1325722@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:fs+QaZv+CBd12LoEeNMQHBP7wmC4XmIwTa8AFbS4WIAkULbgTvj
 Hj1Xn1Z//uvtpvJchIxsd9Yzm2kdCp0N00yZmECWRaUUztsh28RA3/DEkbe0K0HkpZIymZi
 VKClTTjzQN7WgEtwiJLBNArDH9KWvNWa4GXDC/kxSg2DKiThlkTOJe6HITbUCuy37Yzwcx/
 UX9HN+bKvIhqsncJG5u8Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:62Qa6XZWiMY=;ORShbBVz2Te3FfNfmXNV2qxukKb
 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
 UjU0HHeIYnzHi7RiWvfMzYVd7ni0M=
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Mon, 5 Oct 2026, Jeff King wrote:

> On Thu, Sep 24, 2026 at 08:53:49PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>=20
> > +# The cURL version which Debian 12 ships (v7.88.1) can fail to retry
> > +# authentication after an early HTTP/2 response. This bug was introdu=
ced
> > +# in cURL v7.88.0 (8c762f5998 (http2: minor buffer and error path fix=
es,
> > +# 2023-02-08)) and fixed in v8.3.0 (https://github.com/curl/curl/pull=
/11756).
> > +test_lazy_prereq HAVE_CURL_HTTP2_BUG "
> > +	test_have_prereq HTTP2 &&
> > +	build_option libcurl |
> > +	awk -F. '
> > +		($1 =3D=3D 7 && $2 >=3D 88) || ($1 =3D=3D 8 && $2 < 3) { broken =3D=
 1 }
> > +		END { exit !broken }
> > +	'
> > +"
>=20
> Doh, this is totally broken. The prereq snippet is in double-quotes, so
> the $1, etc in the awk invocation are interpolated before we even eval
> it.

True, I'm sorry.

> [...]
>=20
> Since I know we both used GPT to work on this, I was curious if this
> slipped past it. Doesn't look like it from what I sent (which used
> option 2 above). I wonder if your agent flipped it, or if you saw how
> ugly it was and flipped it yourself. Not blaming, but it's just a funny
> and interesting data point if a human second-guessing the AI output
> introduced a bug.

I introduced that bug; I meant to double-check the quoting, saw the
single-quote characters, and that's where I stopped.

FWIW my preference would have been to move the entire code into its own
shell function, like so:

=2D- snip --
curl_has_http2_bug () {
	test_have_prereq HTTP2 &&
	build_option libcurl |
	awk -F. '
		($1 =3D=3D 7 && $2 >=3D 88) || ($1 =3D=3D 8 && $2 < 3) { broken =3D 1 }
		END { exit !broken }
	'
}
test_lazy_prereq HAVE_CURL_HTTP2_BUG curl_has_http2_bug
=2D- snap --

Ciao,
Johannes

>=20
>  t/t5551-http-fetch-smart.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index f66d7ce7ac..cb681e644f 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -21,14 +21,14 @@ start_httpd
>  # authentication after an early HTTP/2 response. This bug was introduce=
d
>  # in cURL v7.88.0 (8c762f5998 (http2: minor buffer and error path fixes=
,
>  # 2023-02-08)) and fixed in v8.3.0 (https://github.com/curl/curl/pull/1=
1756).
> -test_lazy_prereq HAVE_CURL_HTTP2_BUG "
> +test_lazy_prereq HAVE_CURL_HTTP2_BUG '
>  	test_have_prereq HTTP2 &&
>  	build_option libcurl |
> -	awk -F. '
> +	awk -F. '\''
>  		($1 =3D=3D 7 && $2 >=3D 88) || ($1 =3D=3D 8 && $2 < 3) { broken =3D 1=
 }
>  		END { exit !broken }
> -	'
> -"
> +	'\''
> +'
> =20
>  test_expect_success HTTP2 'enable client-side http/2' '
>  	git config --global http.version HTTP/2
> --=20
> 2.56.0.399.g9e0ddc9b37
>=20
>=20
>=20
