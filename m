Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB12381BD
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xrIHbnt5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rlKDSJVs"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85A3ED
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 01:45:17 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id D0AC23200AB2;
	Tue, 17 Oct 2023 04:45:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 17 Oct 2023 04:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1697532316; x=1697618716; bh=A8
	+Jxs/NhpmlcMxx4GnjZXt6feGPkjNbTobd1w+/QXk=; b=xrIHbnt5HwSfI4IJUR
	yJuWaCwsJ9RHELfBzsRET43xErrab6lfe84W1DbPxTh300Dav2Hvo6rBfWRlFY9T
	wDy8d72mxpnYaMQCWMltaxvVuOk66y8mcWs+p1FRz8k8mLNhrKWBbeNLW3Hz8jcu
	f8Ag07T8DoqatvYglyG9xchfpip+v6secOsKodnxlPzNwJjPgSC7+RJ80XTPy5kt
	b1iyOGMiaRqdOVlDJg3G1+TIXQ0aA3hVqok2iuWV700QqCQi1j+SqAJ3AxW9xtJs
	tietnhXtBjLNw4XzL7Oub7z32OTjR2actCf9ph9BBjJ2twprhC/GQ9b7U603HSb3
	8imw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697532316; x=1697618716; bh=A8+Jxs/Nhpmlc
	Mxx4GnjZXt6feGPkjNbTobd1w+/QXk=; b=rlKDSJVscvsaPKqGfXpJrERvoop9X
	QYZ/zY7AqiIU9mtLi7f+vV6719UCGE5pjZZth3VEmRK1ZnzDpCOtwJxFRwJsKlOX
	HfApJQjKeOQK2TJw4dJFoKyVOmpJRKXDOjMxm3m33rW5YbmyJfxTBWoAqdi2W7s0
	DYac68oJ4QQRx5f1sck3mn7LrOhBfA862bNp4vZ4sb+eqvfBu8yLIYk9pa9uVQaH
	B2LbBhRsJ5FWKvgwTlTGE1SuiLnar5fa8IlDHvRE68PvsprjAchuIccuPwZqKvbI
	lizHg8LVjwYEhqJGPL1l2po6nnbLCyjIwnew2M2FJ2VNK5cFk6EFI05NQ==
X-ME-Sender: <xms:nEkuZd9F6rPyMuWFV6hrl-sggJ6tBsggFrf8M2PKaeZelIwlSjGfzw>
    <xme:nEkuZRs2ECmkpPNxRbCZzYPOPZJ-kMnU_x389b190nOjTaaZwsmMuKwyKu7OCERLv
    tvP1KndF86AdXg_uA>
X-ME-Received: <xmr:nEkuZbCjx07CiLy0Ca8xCDyOMVdezF9nYrafRURwL_Q8_zmfO7SsnQsATT8c7DYxT3O2gEmtkl7JEKf9_si43pXTuDE5xtxFCbgkiBQthBKfPQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjedvgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:nEkuZRc-NLM-4m-k7PibScWmOkmAEZFR2YVAZXzzAnqi3r1LvPOx8Q>
    <xmx:nEkuZSPefqh2TqsBy8Jg3pxQ4G0M7Gcr1qhs6W9sWYd6ZJBpl4bNjA>
    <xmx:nEkuZTmjwlw93KnaVig7kw0Qu5Q-LsL6Pu24nY0ro3YkRvnzbcb6lg>
    <xmx:nEkuZfrDt2_KovTaDzPvasze0OvmM2oU919qzNlxNlJ_zbPnYBFx_Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Oct 2023 04:45:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4c8176f5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Oct 2023 08:45:14 +0000 (UTC)
Date: Tue, 17 Oct 2023 10:45:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 08/17] t4216: test changed path filters with high bit
 paths
Message-ID: <ZS5JmQib3onjirC6@tanuki>
References: <cover.1692654233.git.me@ttaylorr.com>
 <cover.1696969994.git.me@ttaylorr.com>
 <cba766f224b0d2b4fd952b11bef8068c07dfcf88.1696969994.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0ZA3vlnw3NKd6fiP"
Content-Disposition: inline
In-Reply-To: <cba766f224b0d2b4fd952b11bef8068c07dfcf88.1696969994.git.me@ttaylorr.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--0ZA3vlnw3NKd6fiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2023 at 04:33:42PM -0400, Taylor Blau wrote:
> From: Jonathan Tan <jonathantanmy@google.com>
>=20
> Subsequent commits will teach Git another version of changed path
> filter that has different behavior with paths that contain at least
> one character with its high bit set, so test the existing behavior as
> a baseline.
>=20
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>

Nit: the signoffs are still funny here.

> ---
>  t/t4216-log-bloom.sh | 52 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>=20
> diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
> index f49a8f2fbf..da67c40134 100755
> --- a/t/t4216-log-bloom.sh
> +++ b/t/t4216-log-bloom.sh
> @@ -484,4 +484,56 @@ test_expect_success 'merge graph layers with incompa=
tible Bloom settings' '
>  	! grep "disabling Bloom filters" err
>  '
> =20
> +get_first_changed_path_filter () {
> +	test-tool read-graph bloom-filters >filters.dat &&
> +	head -n 1 filters.dat
> +}
> +
> +# chosen to be the same under all Unicode normalization forms
> +CENT=3D$(printf "\302\242")
> +
> +test_expect_success 'set up repo with high bit path, version 1 changed-p=
ath' '
> +	git init highbit1 &&
> +	test_commit -C highbit1 c1 "$CENT" &&
> +	git -C highbit1 commit-graph write --reachable --changed-paths
> +'
> +
> +test_expect_success 'setup check value of version 1 changed-path' '
> +	(
> +		cd highbit1 &&
> +		echo "52a9" >expect &&
> +		get_first_changed_path_filter >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +# expect will not match actual if char is unsigned by default. Write the=
 test
> +# in this way, so that a user running this test script can still see if =
the two
> +# files match. (It will appear as an ordinary success if they match, and=
 a skip
> +# if not.)
> +if test_cmp highbit1/expect highbit1/actual
> +then
> +	test_set_prereq SIGNED_CHAR_BY_DEFAULT
> +fi
> +test_expect_success SIGNED_CHAR_BY_DEFAULT 'check value of version 1 cha=
nged-path' '
> +	# Only the prereq matters for this test.
> +	true
> +'

Doesn't this mean that the preceding test where we `test_cmp expect
actual` can fail on some platforms depending on the signedness of
`char`?

Patrick

> +test_expect_success 'setup make another commit' '
> +	# "git log" does not use Bloom filters for root commits - see how, in
> +	# revision.c, rev_compare_tree() (the only code path that eventually ca=
lls
> +	# get_bloom_filter()) is only called by try_to_simplify_commit() when t=
he commit
> +	# has one parent. Therefore, make another commit so that we perform the=
 tests on
> +	# a non-root commit.
> +	test_commit -C highbit1 anotherc1 "another$CENT"
> +'
> +
> +test_expect_success 'version 1 changed-path used when version 1 requeste=
d' '
> +	(
> +		cd highbit1 &&
> +		test_bloom_filters_used "-- another$CENT"
> +	)
> +'
> +
>  test_done
> --=20
> 2.42.0.342.g8bb3a896ee
>=20

--0ZA3vlnw3NKd6fiP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUuSZgACgkQVbJhu7ck
PpR1bg/+ONL86DjSvCRTChsOB0Cxg2OoCiafr4Bu456Fa4Z+ZQ4yPZ+P+RZU7fqk
CwF14ZKM0vK9bq4Gg3CjpIFHlChnM4t4doz3Enx7m3VgpFGdGelzouLubrSXLMhX
/qW/u3Sc31paRnZJWqf/hBoRVNkooxW/MEuX3pmb9PmVnj17NeT2mzRsv+1jFho2
n8t1r9dqzSGFNi7johkfqZt3UIGcjeHVlYeMfP688xjLyejVY5ODmfm8SlEQ1EWX
4fJLK9QGQEdkXrECJBYI3E/Erpqb4xNFglrhNYpttkJCJlVlWwvFCTEWokY0adGZ
PMrUajWzWkYfx1BYuxh+vD1cIakgOCuFTL+VU7eHLEesBqmHWbzVC37tu6UTR8lB
HPpFDYdC0jzjv/q6v+8D8wUWVdSk8fJHGKC//FxGYQqSZQLFAv85ljBeit+X9pKV
jaXjV7bzMDbmybMB9J7/cy0JxcEWnsQqwgxKYRiDYvmRCm7oez3c/T06b86F3DPv
rAWRY6agVbEeq+w7c4BOX2ogB86cZqyvX5rkybx7wBlsJO51kR6YWDSWuwCSE9FX
bRPsBWy/4Oa8Ss2JMe57JmpJk7gLcppcWq0BaseeybIeX5WMxswJI/qrqOQna2xN
jymykK8Wm3IuK1CWdwrjxaCRMap9VwQ+53XyGyS6NohDuD5YJQM=
=53uo
-----END PGP SIGNATURE-----

--0ZA3vlnw3NKd6fiP--
