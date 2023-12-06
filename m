Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i/2NvflB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p5EBD5bO"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBF0135
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 04:39:52 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id C530E5C01F3
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 07:39:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 06 Dec 2023 07:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to;
	 s=fm1; t=1701866388; x=1701952788; bh=vwuT5ogr96cGwwxzj9WrYtCyP
	T60TrBa3T+0lAIFEbg=; b=i/2NvflBy7gB48WpT2dn05t0DUThe+OKCYuFmHZx8
	k9a/2sLBCg6o1XDd7Eg2mU3DTF+A79S571JjiRRcWSzwM5sJ9LnG59+kdSciTnPF
	VvVNw37QCX3BJI4/K3ZXMIIE17ek6uDA7EDtY21G9uVm4k5e1Kv+bOFtck+esrfw
	jWQ8xkGZfACVX44/fzWZlThq2Nf5UkldfhG0Ol8gBgY86XBjit6q2z8f81AbA8AY
	wLlY2yBnXA74iAWnqvtMNb6nI5w7iv3vGRdpG4+lRshQ2s3cmwOhY7iXWoyDAuVm
	gOz7w0KuG2YFlyX1qSyNuH+ip5eQzZ6Lc/TU4Yes+h7vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1701866388; x=1701952788; bh=vwuT5ogr96cGwwxzj9WrYtCyPT60TrBa3T+
	0lAIFEbg=; b=p5EBD5bODCN0yoqWZRVfS4u5HO3sSa+F1177A+Wn+rs3OekoY5x
	waurKyzV1+7dZH9OpXQzncT6QQI7asMn+bGZQyUSKRap6HzDQZtuZQL1e0ytOB/j
	oE2/TArlDHVCVPT8ojgZrB/Im5tHn56KFX3UXaxPg/qnpQx9N6KPyq3idh9FpKOr
	oszoDjzf46x0a9hHkb6R5uXmGzcoDcKJTwEUMyY1WqB5LJ7gKP6dys10HaWy4JAS
	z/ey/N6jGfdXJOcX67Wrckq2DkZtGdHciLB2p07JW74iUTzB1D2vnxU8TguAdI8o
	3eDlcQDvyO/FwB8qVRo7DZuUKnGTpOmHzZw==
X-ME-Sender: <xms:lGtwZShz2_oSLronMHYqqIxZyvk1j-K8-tmDJuwDuXC0ClSzf-jJ7Q>
    <xme:lGtwZTAUvBkk0CKEeXtOFzXNq8fU9Hqjj_FQWau_H35bs6HJ1ao5RtCIlOXrftwq1
    mSRrEyEz90a8o7Dnw>
X-ME-Received: <xmr:lGtwZaEQ2CIJIX5j0cP6ox1FbGl_nU7O13xzW-GHfpG_Cx6sfvP2qFNeGJ3aKUiUjmYxeFq4saxYF4Q3Py74ZY9HhyYSm6TAwcjbgINVm5kTT_M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudektddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:lGtwZbQmPyxy2f8itkPE7Oz7i9Iur3l_hrgfQ18-YTa9ttvpIQ7QsQ>
    <xmx:lGtwZfz23JU2VJ76tIot44eRt8pRFD7lGprVJpCSma29fvxmSlkdbg>
    <xmx:lGtwZZ4tMg5zWM65UX9QbGw3zl6YnS3jcghC-cubh8mUMAF3GGa3Hw>
    <xmx:lGtwZQudfEyCBhsL7XpALmOXVWkFy2rUSZEt1eheYZePgnp7xejSow>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Dec 2023 07:39:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 458a79aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Dec 2023 12:38:20 +0000 (UTC)
Date: Wed, 6 Dec 2023 13:39:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/7] clone: fix init of refdb with wrong object format
Message-ID: <cover.1701863960.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FfanTFYFo+XPI7k0"
Content-Disposition: inline


--FfanTFYFo+XPI7k0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

when using git-clone(1), we initialize the complete repository before we
know about the object format used by the remote repository. This means
that we'll potentially create the refdb with the wrong object format in
case the local default object format and remote object format are not
the same.

This isn't much of a problem in the context of the files backend, which
never records the object format anyway. But it is a problem for the
reftable backend, which indeed records the object format in the on-disk
data structures. The result is thus a reftable with wrong object format.

This patch series aims to solve this issue by initializing the refdb at
a later point after we have learned about the remote object format. This
requires some careful reordering of code. Unfortunately, the end result
is not easily verifiable and thus I didn't add tests here. But it does
fix cloning of SHA256 repositories with the in-progress state of the
reftable backend.

While at it I noticed that this actually fixes a bug with bundle URIs
when the object formats diverge in this way.

The series is layed out as follows:

  - Patch 1 + 2: split out a function to create the refdb and make it
    possible to skip its initialization in `init_db()`.

  - Patch 3: allows git-remote-curl(1) to work with repos that get
    initialized during its lifetime.

  - Patch 4 - 6: address various corner cases where we access the refdb
    before we learned about the object format.

  - Patch 7: move initialization of the refdb to happen after we have
    learned about the object format.

This patch series is actually the last incompatibility for the reftable
backend that I have found. All tests except for the files-backend
specific ones pass now with the current state I have at [1], which is
currently at e6f2f592b7 (t: skip tests which are incompatible with
reftable, 2023-11-24)

Thanks in advance for your reviews!

Patrick

Patrick Steinhardt (7):
  setup: extract function to create the refdb
  setup: allow skipping creation of the refdb
  remote-curl: rediscover repository when fetching refs
  builtin/clone: fix bundle URIs with mismatching object formats
  builtin/clone: set up sparse checkout later
  builtin/clone: skip reading HEAD when retrieving remote
  builtin/clone: create the refdb with the correct object format

 builtin/clone.c             |  65 ++++++++++++----------
 remote-curl.c               |   7 ++-
 remote.c                    |  26 +++++----
 remote.h                    |   1 +
 setup.c                     | 106 +++++++++++++++++++++---------------
 setup.h                     |   6 +-
 t/t5558-clone-bundle-uri.sh |  18 ++++++
 7 files changed, 140 insertions(+), 89 deletions(-)

--=20
2.43.0


--FfanTFYFo+XPI7k0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVwa4sACgkQVbJhu7ck
PpQq+w/9EPGqGt2Ac7TRxdaBLKbh4r/Rcam4rwFP7McMXF1UqbU+KfjihHAf8LZM
fMbZFVvr+mdCzxdcpROIy5iZVrEOCLL8s+F+2OcfEO2SynnzlIsPPxdjP69J2uMu
4ToZo/qT6W9ri5C/36gBHrPE6pKt5t6Mw0mV0Rjqphxl+10PvAX1okW7nRb6+Bsd
yZ/WMYrHgdXycsFzz/IfiljluAmTncktjfB611wHAXkhWWrkxD/9/V3Y6DDIC3XA
nHv1SHZLHCJ7tTwDfzwMOwZJnZqJBu13OQPzZdHytEYYnkOlCd3NYEfa6Q3G43/P
vDPZNdOqmU1PgT6UCFvIXDfTzG2o6dvYBdgJ7jJ6EKhQtBsFgJuwwqTUBWAW8Pdj
Q//abHCT3X4gdV5I+ZCRitvEXHTkjJQd9YgrG4BmVKFcYtS+XsjMxWMNpj7Ew3aS
rdMoUdciP+JrmSRDWDLtJfRPuyX4qo+gBCMNERI4QerI4SzhoMxhcdB5V2HoRdP3
caqk0u2qqEF1bqlC5131pmOYE0VzAYZw22IM+QEa2UYzVEOUnxBfObvKbadNG0bI
CpfSKl7plJwHaBxaggOnXF6IKj5V0ljjVVrp+QYSYGk6Q7nc9HPNYQYayZy047Yz
pCVmW0aTkfYhITVL7H46HZTvN0lyt9wqk1Xf2woGWIDuiFs3xbU=
=6OjP
-----END PGP SIGNATURE-----

--FfanTFYFo+XPI7k0--
