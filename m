Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IrKIcLVL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="z5nSBCzB"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AD9BE
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 03:34:46 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 1BF213200B33;
	Mon, 11 Dec 2023 06:34:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 11 Dec 2023 06:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm1; t=1702294483; x=1702380883; bh=LJ
	Bw7IBFTPqMkRHRWow1STBptulOUaAmeARjfD7vx+4=; b=IrKIcLVLG8Q1E2iYDk
	IEujC73pLxHxEaxpZS5Cre7oQBwbrqgelZExjlBnSmjIEmhcOPgH37QZp//+3Evd
	izQcYtKyxpb7nA2AtKmqLGXmQpbED182yn4polxNtDIqNAMwYSBtaH2gzkG4FaQU
	CUF/FYjwTHQjkgXWKCeYcEG+Woy5xdm8BMdksPsd6vpX1t2Xkx7m0bfcErcGH125
	DQsSsvwKrWcvqEvPsmyVvqpd3+znD7u3BGkGyMSS0TaHEYEU8SIJuORBjmocdZ9M
	tvk/Ze5F7nb38eVWXHbpw6zx8U37CRQzLDuc7dHey1ZoeZrFKdTdGFxKf4yMBGUq
	HR8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702294483; x=1702380883; bh=LJBw7IBFTPqMk
	RHRWow1STBptulOUaAmeARjfD7vx+4=; b=z5nSBCzBKbt1wZ8AtE/yhjnTbANKS
	9XuvAtsj6O9etynLzgsYM4Xq82VR10GGMKxdrZshDb7QwIWS7hn5+lYzcB84JczI
	At1x/F5NlfVpt6nDzHW3qV6aTa3jIM35Ysv6IpO/lqCrTVvc+3sIvmICE5x3kyx8
	8+G6nRWFkVAubNJdOW1UL2If8n+KjGapHBHOyroTMxDfpDixwKjPojkOBWk1Iqsf
	EI5/JroGcsE6PzD7cIjknE8f5FALomU7rL3GtD/i9tM90YTUu3EkQTo23+kEQf4g
	WabI8ZCzCvwr1AAkNbZ1lxalUiTwbBPObmvJEWi/1cCvz2uBKjFhvbGUw==
X-ME-Sender: <xms:0_N2ZZdH35aenrcVu3uzFjllCXMaLYh87DwMu6hRmkydfgpbSaV9Yw>
    <xme:0_N2ZXNBjRCSBF2j3wC-QQ9hwwPI98VSgKCkEHyF-MY8eVhKTcwY-8RoQaUNjmX9K
    qx4NEvLw7aDFunExw>
X-ME-Received: <xmr:0_N2ZSiIVvxLOYdgJrjWP6rcTg-hoEs6UYfCGn1s72jW0KdYlOAA0VYCbICIaatTt0kV15L1_N5DcbF_xNvpj7vxBgi_GhP7CY0gy2Dts2F4mA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeiffdvffeuuddvvdefkefgffeiudetfe
    fhveegveeiieejueeileeuleefheejjeenucffohhmrghinhephhhtthhpqdhfvghttghh
    qdguuhhmsgdrshhhpdhgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:0_N2ZS9V76gr2cWJavR4JwZ8EbGl3nFbRGxf5dzRvXPmISXXiwItrQ>
    <xmx:0_N2ZVtDB3pHWYpPsPaYN9SxnU1PbcLhIpH2BSevG-o-tgvtWwWc2A>
    <xmx:0_N2ZREMZv48DJb5U8btJPW--TCjQhsRaspBSCidnYIfvxb2UKeHXQ>
    <xmx:0_N2ZWU35Ah_jRU2uETh-vqvjgrkS5EB1r1J8NojUj9hqNrUMEq-NA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 06:34:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 14288bef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Dec 2023 11:33:03 +0000 (UTC)
Date: Mon, 11 Dec 2023 12:34:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 0/7] clone: fix init of refdb with wrong object format
Message-ID: <ZXbzzlyWC3HTUyDA@tanuki>
References: <cover.1701863960.git.ps@pks.im>
 <xmqq7clmn3w1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9zUZdsJB7L7d+VII"
Content-Disposition: inline
In-Reply-To: <xmqq7clmn3w1.fsf@gitster.g>


--9zUZdsJB7L7d+VII
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 09, 2023 at 07:16:30PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > While at it I noticed that this actually fixes a bug with bundle URIs
> > when the object formats diverge in this way.
> > ...
> > This patch series is actually the last incompatibility for the reftable
> > backend that I have found. All tests except for the files-backend
> > specific ones pass now with the current state I have at [1], which is
> > currently at e6f2f592b7 (t: skip tests which are incompatible with
> > reftable, 2023-11-24)
>=20
> An existing test
>=20
>     $ make && cd t && GIT_TEST_DEFAULT_HASH=3Dsha256 sh t5550-http-fetch-=
dumb.sh
>=20
> passes with vanilla Git 2.43, but with these patches applied, it
> fails the "7 - empty dumb HTTP" step.

Indeed -- now that the GitLab CI definitions have landed in your master
branch I can also see this failure as part of our CI job [1]. And with
the NixOS httpd refactorings I'm actually able to run these tests in the
first place. Really happy to see that things come together like this, as
it means that we'll detect such issues before we send the series to the
mailing list from now on.

Anyway, regarding the test itself. I think the refactorings in this
patch series uncover a preexisting and already-known issue with empty
repositories when using the dumb HTTP protocol: there is no proper way
to know about the hash function that the remote repository uses [2].

Before my refactorings we used to fall back to the local default hash
format with which we've already initialized the repository, which is
wrong. Now we use the hash format we detected via the remote, which we
cannot detect because the remote is empty and does not advertise the
hash function, so we fall back to SHA1 and thus also do the wrong thing.
The only correct thing here would be to use the actual hash function
that the remote repository uses, but we have no to do so. So we're kind
of stuck here and can only choose between two different wrong ways to
pick the hash function.

We can restore the previous wrong behaviour by honoring GIT_DEFAULT_HASH
in git-remote-curl(1) in the case where we do not have a repository set
up yet. So something similar in spirit to the following:

```
diff --git a/remote-curl.c b/remote-curl.c
index fc29757b65..7e97c9c2e9 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -27,6 +27,7 @@
 static struct remote *remote;
 /* always ends with a trailing slash */
 static struct strbuf url =3D STRBUF_INIT;
+static int nongit;
=20
 struct options {
 	int verbosity;
@@ -275,8 +276,30 @@ static const struct git_hash_algo *detect_hash_algo(st=
ruct discovery *heads)
 {
 	const char *p =3D memchr(heads->buf, '\t', heads->len);
 	int algo;
-	if (!p)
-		return the_hash_algo;
+
+	if (!p) {
+		const char *env;
+
+		if (!nongit)
+			return the_hash_algo;
+
+		/*
+		 * In case the remote neither advertises the hash format nor
+		 * any references we have no way to detect the correct hash
+		 * format. We can thus only guess what the remote is using,
+		 * where the best guess is to fall back to the default hash.
+		 */
+		env =3D getenv("GIT_DEFAULT_HASH");
+		if (env) {
+			algo =3D hash_algo_by_name(env);
+			if (algo =3D=3D GIT_HASH_UNKNOWN)
+				die(_("unknown hash algorithm '%s'"), env);
+		} else {
+			algo =3D GIT_HASH_SHA1;
+		}
+
+		return &hash_algos[algo];
+	}
=20
 	algo =3D hash_algo_by_length((p - heads->buf) / 2);
 	if (algo =3D=3D GIT_HASH_UNKNOWN)
@@ -1521,7 +1544,6 @@ static int stateless_connect(const char *service_name)
 int cmd_main(int argc, const char **argv)
 {
 	struct strbuf buf =3D STRBUF_INIT;
-	int nongit;
 	int ret =3D 1;
=20
 	setup_git_directory_gently(&nongit);
```

+Cc brian, as he's the author of [2].

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/jobs/5723052108
[2]: ac093d0790 (remote-curl: detect algorithm for dumb HTTP by size, 2020-=
06-19)

--9zUZdsJB7L7d+VII
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV2880ACgkQVbJhu7ck
PpSe9A//YWAECBxMB+1ubE+bZ9T56b9Eej/M2YItDXL7u4KSV5RANQEUMEb6PA+l
DW9A469HBomdOXo01dk3++PHxcTJcSHqkXrvflIvo+X6egx16YpDq2pQdviUNnKa
TmRZMGfGKBZwYaoG3fM1bXoC3a4tn+7wepbCcxKUgg+Uya+F7evIrhlIwXh3eP9c
CSFAl/rS8AYgMVpttDROotZetLW6QU7qt2cKxYZSJZ+srIvI3FAP8K9XYBrMuLkJ
MLADBmqVkNhZHc/nV54MRdJoYNKeUJb49WfJ7owF7rI3FGmhZ9zYsc3WnuaDb9yS
n6L9PhT8ESPgnEZY8d/sE8pSdsViVBF2k97Jn61mUx8DB86cqlfacIfIkTJk348x
XsWqOmT+URUQOu7hT5NEhkz+RPUaR+eEsv5FRA48DP2lpZPSpQIgLf3Gu0CWpKH4
jibr/O3WcAvYJ7tAinaCNJ0OQK0Bhsj0+mmp8wMsCjAsWZJd3IQbvlM3vdYmPxct
RVEPHU4S93yTaFN1e+So4YEeRg/J0ZoBzOA13XhSo+GRRKFBSVaU2QvX/7Ctj/WC
N5iXgQ7GktH9aVQOHTVWCIcf7oOU5Hsa+qZw4xmKIAEQl+k2Kw+xPziDpbG7U1me
hxdsxfH27i6uKxxJgJ36Ym+S7vUnKA6g+PfL/ejB3/pYFEC0PwA=
=8zZu
-----END PGP SIGNATURE-----

--9zUZdsJB7L7d+VII--
