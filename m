Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ccqqe/EK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V0Rq2nI9"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCFE110
	for <git@vger.kernel.org>; Thu,  7 Dec 2023 00:14:52 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id C0DFD3200AB7;
	Thu,  7 Dec 2023 03:14:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 07 Dec 2023 03:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1701936891; x=1702023291; bh=+Z
	KS0uO1QxE+uxhYCpDYNKRut4AXPRAHb3MbxMsoxsE=; b=Ccqqe/EKHW1ClH+C5q
	QlIMw9Q1fLknkYcRa3RuRe2xjEFuLoiDlC84XZjvy6an2HApvmrv2lKwInyyY4ph
	3HbGra8guMICczhsN+2ESsNcr6+SLzv0QaHev6Cky7L0726FprSsm7Q8lOBlS31y
	qdhDk4MsIOv/S09+gRABrJeDZ7/Aliqc2eDCMnk0Z920ToaMU3c2QKqo8A3VjUtR
	GVzu1751i3lFZY0Jf/Wehvt4OOTTZNSIYpQRIJCWhgRZ9d3abUSKEWnP69O1twHk
	0zewYtSTBDous5fq/hNk1VlkHxO+5NHf0NdIT3Ue0j1+uoHMJ/pzVv8FeoM//N1p
	t6rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701936891; x=1702023291; bh=+ZKS0uO1QxE+u
	xhYCpDYNKRut4AXPRAHb3MbxMsoxsE=; b=V0Rq2nI9nvRmIAkduOWOPY5N6HUrY
	8/yNkAW1kvum6kUUnpQwiV2/7luw9oO5KNJfc2s1YjiD+89nB9g1IsvnuYn6HS1S
	hC38MdLWcMZkjpWGsU5H9YvZR3mzLl1JqJSXOiywH+lXe+obUPpzJxozhNHQMdVQ
	f/jVD/agu2VlQXZ0yCkmeyG/pvCuNuZBOt1gAPbI3IKVKjlilhAywzDPir4GlmYj
	R1+9myeYJbkzJkRxdfR6t6Jgi776rWTTlgf2bKpCoxfkP8tcIJc0dg/QxSkPfn0y
	84STAoaPwHnGyDKgLLJ9qNGphp6jYSvBa94XAjysMZKWF1gGh7HDqzarQ==
X-ME-Sender: <xms:-35xZWzOQSZQIKKa_BZNNLi_lv4kN5SzaLSRh6n4UcSYNDs0CQg3Ow>
    <xme:-35xZSQIAKWbXTJ-YlVwSfkeWcn9CaBeG3cZHeJIouNNWjTk_xZBe2LZhwzcsBPc4
    B0kRbXYxUp53g8HKg>
X-ME-Received: <xmr:-35xZYUn5Pgi4ZV4kOVlbpM2xFq4W2f4xiWSLbJVo9hrMmVfOMoRz-dOkEdlNa5McFH42uXX6PVBVXmk3bhnkyGnnJrAx-E7StSqKoaF4MqJx38>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekuddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:-35xZci9Jf43QoYM4wUqYl_9sWr0eDGVzn1ON8K5nr0q05vMamzS6A>
    <xmx:-35xZYBCN7-nX1TD16hjZvZyrWNhuOtmbfx6dsDy0E1wB2Hh52vc7g>
    <xmx:-35xZdLsLN_hgIM75XCm-eTBWpb0K3fJQtvLnLILvv3u9K6iSGzNhA>
    <xmx:-35xZR66-_TpSLT1ogMwhiOzLw7oPZnjCkhh9lykYrx0dSpZb1C6PA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 03:14:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4dcda236 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Dec 2023 08:13:22 +0000 (UTC)
Date: Thu, 7 Dec 2023 09:14:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,
	Carlos =?iso-8859-1?Q?Andr=E9s_Ram=EDrez_Cata=F1o?= <antaigroupltda@gmail.com>
Subject: Re: [PATCH 5/7] submodule: handle NULL value when parsing
 submodule.*.branch
Message-ID: <ZXF--AxCOOOjyOMc@tanuki>
References: <20231207071030.GA1275835@coredump.intra.peff.net>
 <20231207071129.GE1276005@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Br3rImgaTsO/kUx0"
Content-Disposition: inline
In-Reply-To: <20231207071129.GE1276005@coredump.intra.peff.net>


--Br3rImgaTsO/kUx0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 02:11:29AM -0500, Jeff King wrote:
> We record the submodule branch config value as a string, so config that
> uses an implicit bool like:
>=20
>   [submodule "foo"]
>   branch
>=20
> will cause us to segfault. Note that unlike most other config-parsing
> bugs of this class, this can be triggered by parsing a bogus .gitmodules
> file (which we might do after cloning a malicious repository).
>=20
> I don't think the security implications are important, though. It's
> always a strict NULL dereference, not an out-of-bounds read or write. So
> we should reliably kill the process. That may be annoying, but the
> impact is limited to the attacker preventing the victim from
> successfully using "git clone --recurse-submodules", etc, on the
> malicious repo.
>=20
> The "branch" entry is the only one with this problem; other strings like
> "path" and "url" already check for NULL.
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  submodule-config.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/submodule-config.c b/submodule-config.c
> index 6a48fd12f6..f4dd482abc 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -516,7 +516,9 @@ static int parse_config(const char *var, const char *=
value,
>  			submodule->recommend_shallow =3D
>  				git_config_bool(var, value);
>  	} else if (!strcmp(item.buf, "branch")) {
> -		if (!me->overwrite && submodule->branch)
> +		if (!value)
> +			ret =3D config_error_nonbool(var);
> +		else if (!me->overwrite && submodule->branch)
>  			warn_multiple_config(me->treeish_name, submodule->name,
>  					     "branch");
>  		else {

I was about to say that I'd rather expect us to handle this gracefully
so that Git doesn't die when parsing an invalid gitmodules file. But
there are other cases where we already fail in the same way, so this
looks good to me.

Patrick

--Br3rImgaTsO/kUx0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVxfvcACgkQVbJhu7ck
PpQNcRAAmGyVrpPZCz+3TczOG3EKl0pZZsr1w7C29gBuNPPWmcmePUhEHOVdqREm
HocOHBzjE7MbJUW27ZSZZ/zcsjGtafqArfqFZVaot1ytZnaltTpUGOzLOcMyUwb3
SwQiyfMKcm//P9N2qQTgKuUs/HS9BEiyeoVqAdayvDgMing9NISxg6amy92sM8UQ
3aBytwwyJSsjxLBr+Leodxk0c8ZZa9x4RXH2Qup11raRAielvWInu5YWuFo02lO0
d96JdWMdphfdqowmRYIWd/XeV05+5+wpwR31eZe6K6Ce+TKfA6YkCmVQz6Y3Oiw9
AsT3oIiy/G7zr+BZNEuck/fVAzTjG8twjL6zqndNy3ReIfW4hY7oLG0u3vTEQN1M
kVRnQmnprTBb6AJFWcG/r/J+MbCfeBaSFQt3C8HO5SDebaH4rlcxl7sAa493anqu
nxRvZJWjt71O5Pzb6uINeeTGroPjW/tDEf6dXZcCY6VqUyxsZ/ZgrdD5YmXSLZB2
/aiqhfeYZW8Re4TYonqgn1cQIYxpgvP9XBgygK385wezPwDhLsmeIFNEYKZDRBnk
QD5bsklmqwRpxl+eiIcLjMaWsEgRVAcvTSZydyW9Kh3guNWuru+tU2tqTBl8f9ks
dupW2mMQLBrfNSUYLevYVD7OmzO+OSY+vS2FNFZnq55Xf80MW+w=
=J3kA
-----END PGP SIGNATURE-----

--Br3rImgaTsO/kUx0--
