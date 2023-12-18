Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C5AF9E4
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n4Qmw0ic";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="8OdoBT4k"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 416875C010A;
	Mon, 18 Dec 2023 03:14:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 18 Dec 2023 03:14:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1702887296; x=1702973696; bh=wHxhJIB47Q
	ZkPd0B8UsgDAQH1isigC6LThDYYy7ZbbI=; b=n4Qmw0icGYTNDvMKCoGeTmtDtP
	W6QDoxuRkc/CiElCpGok+M0QZPn49QR0uNEwRZU4q6d0WimUpGL8+s2BjhfBWpGV
	UfXuKE6QZjuU/nxLok/qihiVhzpI7dNpx3B/AaLVv8innjENISo/Yqsrpp26v+EJ
	hoyj+3DWCrOhTvJ2HckMloMZ9SXeLSnipyMq0wnnPdynsL2pKyljvcYiVn/nP5N4
	QfyrzxtvhbIpwlCyn6wmsd5czrRfrTO7JbLibs2PWI3ACtWYlO0tAS7rp6bPUiwx
	Om4a85PcHsy28V1FDPxQYLh+RSvpqSmpR5QNi0xYF+faUOkn03lR+zxIKuKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702887296; x=1702973696; bh=wHxhJIB47QZkPd0B8UsgDAQH1isi
	gC6LThDYYy7ZbbI=; b=8OdoBT4k9ixV0sWvEa3RnYx7vJ3TqGkg4QNJ8+FPRjYz
	ZRepQcLM8cisuilKU+RN4Y43CFPoCqmauKVlhuMGcoKxUKelOnV3nYmpd54YQUTB
	FrZatt9/8CrYrAywJMFnDPR+GsSta21TVIq4pI/szyG0j7qPOt2EV7cv3/WHcGx1
	xL5D6M0D3Sn/fo4+YiknwEI8nNs8dQu0BisfHhjw1amWqlsDB2QfUcpezPQrNWrm
	mlZYw5jhxMPutO+9Y2YUrGrzAgKD8e7l+mTuUxzOHRDdK48ctadiT6yBWW9hBjCD
	/PhJ2+lXRwmc9TWg2c9XRmHWzvqW1LfVgRoGk2eqHQ==
X-ME-Sender: <xms:f_9_ZebE9otwtsvDqRMZNx3cmWsunJV5bbXAfQpEQWQ-KHvcMQj3IQ>
    <xme:f_9_ZRaW9oxc-xpAVv8xMNR7iGL3NU6a9j4c1t2K_j9B5AhLD6kz5b2PnT0k41rtY
    JfFxGGu3-iRkrseTg>
X-ME-Received: <xmr:f_9_ZY8Dfvc-cz0aPtdPqNHmUPzSNopF2ZJT1lrGwK0lgsBqC0BtLclHmF-DtG8XyByORaozz8GNvFCHqXkpTY8wlwYp87z_HIahPHHrBnsssP0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtjedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:f_9_ZQpqkSa1V1LeBw1tEeCur4TEVuHMBKVjB6gX5YtPgsDHgy3_0g>
    <xmx:f_9_ZZrmqrrNBRKqGKFwYC3oVWxidhHbXKRxyv-Bgz0S0h5aBtK-Kg>
    <xmx:f_9_ZeQn0ah7tyNVbDiDfWrEvApXkpniBxhhgIItsE5JRznujW32Mg>
    <xmx:gP9_ZQ1tTux6ImdK2zb4aiCL8NP_h1m9S_ssDMNHBYCoz8XzY8U2Xg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Dec 2023 03:14:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e5ea69f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Dec 2023 08:13:02 +0000 (UTC)
Date: Mon, 18 Dec 2023 09:14:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v3 0/2] fix fetch atomic error message
Message-ID: <ZX__e7VjyLXIl-uV@tanuki>
References: <cover.1702556642.git.zhiyou.jx@alibaba-inc.com>
 <cover.1702821462.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zfLpTqpVS4yGx0qT"
Content-Disposition: inline
In-Reply-To: <cover.1702821462.git.zhiyou.jx@alibaba-inc.com>


--zfLpTqpVS4yGx0qT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 10:11:32PM +0800, Jiang Xin wrote:
> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>=20
> # Changes since v2:
>=20
> Changed the patches with help from Patrick.
>=20

Thanks, this version looks good to me!

Patrick

--zfLpTqpVS4yGx0qT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmV//3oACgkQVbJhu7ck
PpRVSg//YN/Hz7PSHsm0awI7tqhTlqg9urN0Ea0jAMLgw2Xii2yZE0stMNhEC9WW
ED8lzTulSIVRdk/f+63zQKB8QwqYfp3ejKfbR9Dox2qc8GwJeSz7+gL2GZu8rnF9
tC5MPho3B96FwDPyHrv18up/uMY3fNGyDPY3TOvY/GZLcADbIQAHyoQl84HCDJi4
7M6QfTChnEl96pLISs1V9GH2IdcNj+C27TbUI4kXxuS1towD0ElpaBvC95MzV+b5
hQlgeyKhVCtDKTiwWxMMZqjMbXS7DX8rIZhVc5Q/utR6TtNKLiYLhNPzX47CXpEi
dgtctgxo6VyQs0hnnYoBMwYaFhNpjEIA9S3NJpAfyUrkf/7jBlSd4PpuCmbrQPmj
F1yuDDNenqb/POUh75QVFaVmpk9hbwRXJVvqCR8HWEP4LlY6dnniNBIq6NCFvBVU
D0H5vy6oWO9V13uavC20HDMDhl6TLbFgJtEhD7ywzgnAdj+lQ3/f49pF6i+IowXD
VpawoNB2PD21T9j4VOeiCy6ylJsdQXe2saa+aYkT/z16Mk2QJSMWxAY0OAXDbfzd
pA3zUFTsbj4glOMl9MZVzimHFBpeiU1++jpy6n1o3a4ZvhKahfFh5d+WlusUBFgM
sVU/OD47/cKo77QTE9iFzs2KlDCfV7hasRfomSDg6B5xAx+FG8g=
=siIB
-----END PGP SIGNATURE-----

--zfLpTqpVS4yGx0qT--
