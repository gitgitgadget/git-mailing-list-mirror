Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vZDdqDME";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oBefvKgo"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C793A3
	for <git@vger.kernel.org>; Wed, 13 Dec 2023 23:41:28 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id A5F6432009FC;
	Thu, 14 Dec 2023 02:41:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 14 Dec 2023 02:41:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702539685; x=1702626085; bh=SFWNzVPl+H
	4/8MdbMHGGdgjg0l8Zn7mhPK69BMa31jw=; b=vZDdqDMEQkcGzn38/MqYJsvtyz
	3q7zYR8bCXcpPtY54ufC0DOMNEbHg4L/g7PrlbCrDalv3LwwqXGh9cJ6wXtYwB4p
	iKCrwL8NW5HfdO4smmaWkdZ0KdtB+4EKVlzGVZqyZkW10/OBChxbVyXDNTCG7YHJ
	ijziay01Xtvlwws+XK1bPgqmQfMwH68ZgxcKeRbreet/3vFdH9zXrzljhlJ5BDgl
	fzLyXlslCLRQmvW6enLym1jaaWHYkD9mEhtmNbn1reUEiwxh+9hTcxl1U7f2w0Kv
	hqlPrh7aqnZn2ZSbkKpZ9E26xPOuWQEl7DUzUj+92u6iqVkKurEFuItemTpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702539685; x=1702626085; bh=SFWNzVPl+H4/8MdbMHGGdgjg0l8Z
	n7mhPK69BMa31jw=; b=oBefvKgotDhQm8vp1759bXEQM7aH3n4eUY5rQsegmJIE
	PJq26W+k4a8sbxiJE449MpY3zAumr+zyKyQTiMGQSaMVytsNnOCSAHCRo52OPV9u
	QVZRTzi0KzlXgFZ7H+RGluYXYBvhPSjeyxCnYmcodoO95XEPCTf+XohGoZDop9Cm
	5lbNxVXdHCEk8GCPcZZyM0nacMNP4YyYxT1dyii6SOnCwFg9wqZk2IhTIf0pMSIy
	4RzKiuKZvJsPjnQvrzIQvBcHtRAtHESwpgRGd2nfiH6VyUSdJMKRDgdBB0fitGNK
	rsVxOXWigMoqH/VJieYwcbnKjMWDtnENyDaGRBWXAg==
X-ME-Sender: <xms:pLF6ZR5QRRbWZeFWt5uSFzzr2zEhK596mTJ3jWMxBZDP6UVhJ1tFGA>
    <xme:pLF6Ze4sHOndTRm7UAXeO4yhCev3-v2BfwQ-N6EdXce_z13yVU7mGyiIK0bBi-V6c
    twd6EIrgZRtrO-DyQ>
X-ME-Received: <xmr:pLF6ZYdNJVjLglZmP15POy1QtM6HKe7AK9Q0QZxTFDSmWtJq5mlRtbnpnZXb2pTZt1tZXQ2_w-rnD5ybcIf_iPFFsqQXpA51OEBEjOsFVfhdN-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelkedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:pbF6ZaK44NrX2qetCd60g0QycYyu2fD88ZxPILB_9YY5dH_P2BrSOg>
    <xmx:pbF6ZVLtKwXtJFbPl02rcl53jhiXtMTIf4pm9gMzzQBY59t_KQlfEQ>
    <xmx:pbF6ZTxUag95RXOOQYFUbTGMBLxl4vuGMhojOuGWu8AGDq9L9U3WkA>
    <xmx:pbF6ZcWStOoof_dTATlwQ4jUCUSGPOhAvvCfbk_MMZ2ApOARzcCQ_g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Dec 2023 02:41:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6a8bc752 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 14 Dec 2023 07:39:39 +0000 (UTC)
Date: Thu, 14 Dec 2023 08:41:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Carlos =?iso-8859-1?Q?Andr=E9s_Ram=EDrez_Cata=F1o?= <antaigroupltda@gmail.com>
Subject: Re: [PATCH] mailinfo: fix out-of-bounds memory reads in
 unquote_quoted_pair()
Message-ID: <ZXqxoKLFG19tMFpF@tanuki>
References: <20231212221243.GA1656116@coredump.intra.peff.net>
 <ZXlYIZ0Hb1kN84NU@tanuki>
 <20231213082027.GB1684525@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kSA4JDFzND/6PMOO"
Content-Disposition: inline
In-Reply-To: <20231213082027.GB1684525@coredump.intra.peff.net>


--kSA4JDFzND/6PMOO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 03:20:27AM -0500, Jeff King wrote:
> On Wed, Dec 13, 2023 at 08:07:21AM +0100, Patrick Steinhardt wrote:
[snip]
> > Another thing I was wondering about is the recursive nature of these
> > functions, and whether it can lead to similar issues like we recently
> > had when parsing revisions with stack exhaustion. I _think_ this should
> > not be much of a problem in this case though, as we're talking about
> > mail headers here. While the length of header values isn't restricted
> > per se (the line length is restricted to 1000, but with Comment Folding
> > Whitespace values can span multiple lines), but mail provdiers will sure
> > clamp down on mails with a "From:" header that is megabytes in size.
>=20
> It's just unquote_comment() that is recursive, but yeah, there is
> nothing to stop it from recursing forever on "((((((...". The stack
> requirements are pretty small, though. I needed between 2^17 and 2^18
> bytes to segfault on my machine using:
>=20
>   perl -e 'print "From: ", "(" x 2**18;' |
>   git mailinfo /dev/null /dev/null
>=20
> Absurdly big for an email, but maybe within the realm of possibility? I
> think it might be possible to drop the recursion and just use a depth
> counter, like this:

It's definitely not as large as I'd have expected it to be, we're only
talking about kilobytes of data. Feels like it might be in the realm of
possibility to get transferred by a mail provider.

> diff --git a/mailinfo.c b/mailinfo.c
> index 737b9e5e13..db236f9f9f 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -59,6 +59,7 @@ static void parse_bogus_from(struct mailinfo *mi, const=
 struct strbuf *line)
>  static const char *unquote_comment(struct strbuf *outbuf, const char *in)
>  {
>  	int take_next_literally =3D 0;
> +	int depth =3D 1;
> =20
>  	strbuf_addch(outbuf, '(');
> =20
> @@ -72,11 +73,14 @@ static const char *unquote_comment(struct strbuf *out=
buf, const char *in)
>  				take_next_literally =3D 1;
>  				continue;
>  			case '(':
> -				in =3D unquote_comment(outbuf, in);
> +				strbuf_addch(outbuf, '(');
> +				depth++;
>  				continue;
>  			case ')':
>  				strbuf_addch(outbuf, ')');
> -				return in;
> +				if (!--depth)
> +					return in;
> +				continue;
>  			}
>  		}
> =20
> I doubt it's a big deal either way, but if it's that easy to do it might
> be worth it.

Isn't this only protecting against unbalanced braces? That might be a
sensible check to do regardless, but does it protect against recursion
blowing the stack if you just happen to have many opening braces?

Might be I'm missing something.

Patrick

--kSA4JDFzND/6PMOO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV6sZsACgkQVbJhu7ck
PpRVvQ//VQDk8i+b4uwXRiaQ/KR5HRDstCylCsFFWMzW4KOhZIZ+A4gJl6pgAfct
FdzgiT5JxKQfym7zLpZamN7FK4RuWS0/s7ZWy1H0t/KLagyDssZ7UjSjnNsEdvkk
cEJ1ZMQDVD4uSbCAg3W9zyi0wMCZQc5kWnOLYD03HJtnyjwS0JT//GWqyM3SiWPr
4QjRh4nQcz/HiTIEgjCfpykgTC//jTN1NNqGhkG/h/XYMZGbpk6HVodMMYPLrJQ3
a/bNUltKg7JvP96hffoZk13mWsZQhk8rmBEOM3YZqvR34HVaJUJMC18834sLCj5E
F+7bpRZaeZv5UIR3GiCxxwrLBjAi4qLXh6j8+6mU25na3n9w7HaRmYJalQLb54R0
H2oCyi6SkfI/3TSip97Jp/fi2ihINKByZlFSfJjT/K+ufAJ6v9rtRO4n0vzrd2Wc
pu4H9n/5FtC6HlGcE/uS79yHSXavq7xyE4DRcAzwRlaDR8MQd2Ok8tnkYi8pPksw
dGgzhEPQ/qZDbsu3EzgDeqXrf3+Nr1p4EkPcpeEadMX7b9CUI7TDLPfEjMOWNoO9
ggNzC6NYwwQv/tc93F87giAufJ+JU+pYiAvXxEUA9fHup0F55pMO9jjBdE1/cbnu
ZToMCvqvMrRd4IiWcoEe3SWFIU/W0rrZCUpdjOlIwdwQvzQbljg=
=87oh
-----END PGP SIGNATURE-----

--kSA4JDFzND/6PMOO--
