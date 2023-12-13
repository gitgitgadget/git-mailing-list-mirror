Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qZcTDWWw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mkZAQYhj"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8667E26B7
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 23:07:28 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 22A073200A2B;
	Wed, 13 Dec 2023 02:07:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 13 Dec 2023 02:07:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1702451246; x=1702537646; bh=Y6ZbcgCh8k
	w7U0uIpHuTFYfa2EGqP6Pu+s2Ty1FY1yw=; b=qZcTDWWw1VktjQcEiBh2gqgI9n
	7DRCsh0RsO3Di4BxALeBHQng4i/rziFJ1yJxi6z1cCXnsBXl3uQFAu8Oxp3LMq6w
	rOpUJ7E0x7YGQB8hhhAbiNv2lA/PKnn4npyYiutO4W4QVtndDocSpmMcUVMxo+Qs
	yM1RyZOVZ1PE/Meg/ruzN2wxKAeGbM7w9QW3M9ROy8XAFRvhQVt9izWI2hy7b969
	6tExQwft+MtV3YqTyCwo6M90bGpDJ7XTqLBCZNiFdwL8YIVgFcKUAF3Saoa+7NPH
	HUAAc6RvBcrFpeEQrPIxywuC5ZD9xeRYrTYcTCrTDWeXpVqyb8EADdcibqWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702451246; x=1702537646; bh=Y6ZbcgCh8kw7U0uIpHuTFYfa2EGq
	P6Pu+s2Ty1FY1yw=; b=mkZAQYhjyjLslmsdzBsqJW3INgD9cXFtV2YPlSGyKBD4
	pjIDyZmvjhBTYMIS8LHmkkAbwhTeGTK6IbvdFH1uaRQKx4bZeNdf/HNMSfhXRjru
	n60oliUBUz0V7G4ULHtlVGRcIoxwzhPPwK4rbyhvPaGhOWcYSOd0t3ao4VIlCVuH
	VXni/TA8TY9rm7WDta1aSo5x1SlCMlFIxK0y00iQ6dzb91vcMhArgx4lsArwEBaj
	iWD9r0oYdwIGMxC6zjy/oT/Jhj/0h0Bz9L2KJ2i5hIDUiAFLHzPLSU7R1BlyduGl
	5hLIGNq9EqBIAcz+SSO9xSVmVBG8Iq7r/oPL6a4b6Q==
X-ME-Sender: <xms:Llh5Zf3bJnckW6lPdRwPNnStIUu-nDJ9Qm7zA2wgyRN079n0NoQzUA>
    <xme:Llh5ZeEUYyAmvf68KfPxqvDkTvt-hif_LXE8fNsSNgZDysuI04TF7Ef-4KZWg4SbY
    doB8LnUd3MrzmVGig>
X-ME-Received: <xmr:Llh5Zf5hviPYtCZ2EVgLzMBg4ZYapY4QsXeBoRTheJC0smzrz9e4fy-P8uHltA92HhN5ug7m5b7aJ3w0fmfXGwMXuM-eMHMUbmZM06VJ4ahZog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelhedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Llh5ZU1ZJSOZdV7G1OCdQMe1C_EY44pj4A6NxaD4SFyGU8HHpyOeDA>
    <xmx:Llh5ZSH4Ydp-v-FK669EEXaI073_MNV9CEzfUOMedATsSSjBBYyc0A>
    <xmx:Llh5ZV_o9t0_n6sHEh-ZBiMV4m9o80butU81TceDh97B371psZ9nKQ>
    <xmx:Llh5ZXSITRjNEfmulr9GSHvqrYKHkftL-9JF00igWVSFYRXhnuO3tQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Dec 2023 02:07:25 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 09bbc8aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 13 Dec 2023 07:05:43 +0000 (UTC)
Date: Wed, 13 Dec 2023 08:07:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Carlos =?iso-8859-1?Q?Andr=E9s_Ram=EDrez_Cata=F1o?= <antaigroupltda@gmail.com>
Subject: Re: [PATCH] mailinfo: fix out-of-bounds memory reads in
 unquote_quoted_pair()
Message-ID: <ZXlYIZ0Hb1kN84NU@tanuki>
References: <20231212221243.GA1656116@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3rv8I4XfUAu3wiNT"
Content-Disposition: inline
In-Reply-To: <20231212221243.GA1656116@coredump.intra.peff.net>


--3rv8I4XfUAu3wiNT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 05:12:43PM -0500, Jeff King wrote:
> When processing a header like a "From" line, mailinfo uses
> unquote_quoted_pair() to handle double-quotes and rfc822 parenthesized
> comments. It takes a NUL-terminated string on input, and loops over the
> "in" pointer until it sees the NUL. When it finds the start of an
> interesting block, it delegates to helper functions which also increment
> "in", and return the updated pointer.
>=20
> But there's a bug here: the helpers find the NUL with a post-increment
> in the loop condition, like:
>=20
>    while ((c =3D *in++) !=3D 0)
>=20
> So when they do see a NUL (rather than the correct termination of the
> quote or comment section), they return "in" as one _past_ the NUL
> terminator. And thus the outer loop in unquote_quoted_pair() does not
> realize we hit the NUL, and keeps reading past the end of the buffer.
>=20
> We should instead make sure to return "in" positioned at the NUL, so
> that the caller knows to stop their loop, too. A hacky way to do this is
> to return "in - 1" after leaving the inner loop. But a slightly cleaner
> solution is to avoid incrementing "in" until we are sure it contained a
> non-NUL byte (i.e., doing it inside the loop body).
>=20
> The two tests here show off the problem. Since we check the output,
> they'll _usually_ report a failure in a normal build, but it depends on
> what garbage bytes are found after the heap buffer. Building with
> SANITIZE=3Daddress reliably notices the problem. The outcome (both the
> exit code and the exact bytes) are just what Git happens to produce for
> these cases today, and shouldn't be taken as an endorsement. It might be
> reasonable to abort on an unterminated string, for example. The priority
> for this patch is fixing the out-of-bounds memory access.

Makes sense.

> diff --git a/mailinfo.c b/mailinfo.c
> index a07d2da16d..737b9e5e13 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -58,12 +58,12 @@ static void parse_bogus_from(struct mailinfo *mi, con=
st struct strbuf *line)
> =20
>  static const char *unquote_comment(struct strbuf *outbuf, const char *in)
>  {
> -	int c;
>  	int take_next_literally =3D 0;
> =20
>  	strbuf_addch(outbuf, '(');
> =20
> -	while ((c =3D *in++) !=3D 0) {
> +	while (*in) {
> +		int c =3D *in++;
>  		if (take_next_literally =3D=3D 1) {
>  			take_next_literally =3D 0;
>  		} else {
> @@ -88,10 +88,10 @@ static const char *unquote_comment(struct strbuf *out=
buf, const char *in)
> =20
>  static const char *unquote_quoted_string(struct strbuf *outbuf, const ch=
ar *in)
>  {
> -	int c;
>  	int take_next_literally =3D 0;
> =20
> -	while ((c =3D *in++) !=3D 0) {
> +	while (*in) {
> +		int c =3D *in++;
>  		if (take_next_literally =3D=3D 1) {
>  			take_next_literally =3D 0;
>  		} else {

I was wondering whether we want to convert `unquote_quoted_pair()` in
the same way. It's not subject to the same issue because it doesn't
return `in` to its callers. But it would lower the cognitive overhead a
bit by keeping the coding style consistent. But please feel free to
ignore this remark.

Another thing I was wondering about is the recursive nature of these
functions, and whether it can lead to similar issues like we recently
had when parsing revisions with stack exhaustion. I _think_ this should
not be much of a problem in this case though, as we're talking about
mail headers here. While the length of header values isn't restricted
per se (the line length is restricted to 1000, but with Comment Folding
Whitespace values can span multiple lines), but mail provdiers will sure
clamp down on mails with a "From:" header that is megabytes in size.

So taken together, this looks good to me.

Patrick

--3rv8I4XfUAu3wiNT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV5WCkACgkQVbJhu7ck
PpQUtRAAqCrrDz+Bo8u8Xz6XbZsrWC3hwz39Lj6wXTU7Iaed94f78i5m8M2yIty/
ll1ckrGgN91c7Yqv3ANYfT2KRq905+AdOWBlaporr4cvaxBjXFw2s1EHjcQ/vKwC
mBPBkqVkoWFLhR9L0iyLVriYgi/Ygc4MaBEDs8n3zH/Nyp3I5pL22G3utnW9Vzdx
i57Lr0EhvO27CiQhMVawDXCn6i1PvSMWL0xC8grRb+Cd8dJMwzfKDMnIME1eA6GY
GYMLkfsmAc7mqM7/fgkJMz4oQqSCJ7mt7Njx9UdFkEjhD/YWAVU2Vd+h5GdwNIhY
bnBE6GKgqb1m/rbk7HdCn7KPba+L+GhHco4Fc1498yTGdh3czIJhk9ZHKGzJHCxG
o5jPborTzKOyb4/lkdKuOArqhH9vmDLu0g32o0muOAIkbF21Swq2nqNjM4ZLmXTW
HjPBI9vJpMtjb1KmkEKV/31zWuFVb5mo8Qv882eXV0FqOzCdXgYawsRJ7bmVjAq8
4M9VtCkd8zlzNm/tIGq4j4h5TrqMnwzlkP/t4QLCHZx+mgC0KN6ECLw3o7AHCaip
rOqPao08BalfUeMmIeJMGTDgkOy6h0jSyKoWk7wWLmStrWki/+3yV5T2dHryrLPR
QzOmlplz5JzB0KDwJatg2N7MKUeRCvX6WMO3w8q2dY96s+kZsBM=
=Yzar
-----END PGP SIGNATURE-----

--3rv8I4XfUAu3wiNT--
