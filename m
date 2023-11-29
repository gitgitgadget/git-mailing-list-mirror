Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BYX5S+CA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HpiwY35z"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F49A172E
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 00:14:13 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 75EB95C0213;
	Wed, 29 Nov 2023 03:14:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 29 Nov 2023 03:14:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to;
	 s=fm1; t=1701245652; x=1701332052; bh=Pn/SlI4zTXS1A7eosTrDqlte7
	bieOnW83fkgMdhNQ5k=; b=BYX5S+CAA8bkk9+GviplBLZd/VDi6W02rw0KXj1NY
	etPfMOMvhDOwMVegObrrMiICVtdIo73CdenIFKREOG5meq56t3Cnc1HC7J4I8WnM
	NQ+0Czn1ipECuK5mdFMJXFhFRzGCFY2Chvq6X8VuMBS6Cup+FBYOBqwChsZQgGj9
	JEgVWHnFa7sRr9+UiMmQVgwDFI5JLJCOymt3Cba4wMf3W3PQrxkQsr71jN67ipHT
	MskNMXeYYLR+lzcqQRqFG7GQKR+WfSnt2CygJkzT3s4tNWbT1Gwp7+Ar8XasShy/
	+W8bcGU48ViuBgRF9WW+RESs/EuOuvyupeUGxgy1/jWvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1701245652; x=1701332052; bh=Pn/SlI4zTXS1A7eosTrDqlte7bieOnW83fk
	gMdhNQ5k=; b=HpiwY35zW/ezs9bWSh6eFhB6yx1MfOQ2WDY3vqfoRh6pWJHnpeA
	Iqd04pPXdyTZWHvC7mkX1FS0Tx7vdmpLhgLprsibEq+fLl1Mx9CnHyezEoko78Sy
	PUrTU72pogCb0f+gZ4zK6TdjUzM3fU3reRNcBRe+OFZucSi6/7zmV6kvC2B5pUgr
	oahtT7zJxoA2kgipKXe66sUzGcT/4dXKuyu0EUvraaoyy6V1vQLYk+liU3Yp7v8n
	InSPuhTFGAkxYtr/sIgher+rWkJ5Oz0hLArgyvFcJuVj98kViD+WACCQAC119Ypj
	ivfqLHMR1nZS7CR33CW+CB6BdgmRhoPpLPQ==
X-ME-Sender: <xms:1PJmZc3m1sYLVF5bA2zPTiL49nINgF-VjgD2A9u9gsAS1qkqhs_wGA>
    <xme:1PJmZXGPzo8LI22kLZrYcBaLyJeGz5G71Dry1V3siQsE1OMmga4ZR16iyTdaEG5Rf
    sw20vfZ9tFVCm9yqA>
X-ME-Received: <xmr:1PJmZU7xXgFn0Yf3z4r5Ocl_PG5RXCQPNmiSxFoRVF9WFiGK79tQO3b86Jn3OUcPcnkj11JREkzYx3xI6MEAHnDM5Vi-pVO--GlzXAssW_yHBep8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeigedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkgggtugesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepuefguedtueeiheetleevgedujeekjeehle
    ejjefhhffghfevgfekueekjedtieejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:1PJmZV0-BD89MdOXSTJCEeGAAIBWRl2ZQF3k8parKwdhCnz3xQ2UyA>
    <xmx:1PJmZfHf1QQ0sTiqQvjXk7nIHvDFjfTRwhn7lLrmtyBHiaHt3TMi3Q>
    <xmx:1PJmZe97VScMc-Z9Ksl28tHOlzIXXPzVFMyQfL8OIxAlgFIWJrVWqQ>
    <xmx:1PJmZSOqr5_RiYLoFLafo1Bp-KQRwb7XHtoh0izsKDAx4SlsQSjv7A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Nov 2023 03:14:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 53f5895f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 Nov 2023 08:12:59 +0000 (UTC)
Date: Wed, 29 Nov 2023 09:14:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: hanwenn@gmail.com
Subject: [PATCH 0/4] refs: improve handling of special refs
Message-ID: <cover.1701243201.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DY5vuTYh2AF+wzzV"
Content-Disposition: inline


--DY5vuTYh2AF+wzzV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

there are a bunch of "special" refs in Git that sometimes behave like a
normal reference and sometimes they don't. These references are written
to directly via the filesystem without going through the reference
backend, but the expectation is that those references can then be read
by things like git-rev-parse(1).

We do not currently have a single source of truth for what those special
refs are, and we also don't have clear rules for how they should be
written to. This works in the context of the files backend, because it
is able to read back such manually-written loose references just fine.
But once the reftable backend lands this will stop working.

This patch series tries to improve this state by doing two things:

    1. We explicitly mark these references as special by introducing a
       new `is_special_ref()` function. This serves as documentation,
       but will also cause us to explicitly read all of these special
       refs via loose files regardless of the actual backend.

    2. We document a new rule around writing refs. Namely, normal
       references are _always_ written via the reference backend,
       whereas special references are _always_ written directly via the
       filesystem. This rule is not enforced anywhere, but at least it's
       now made more explicit.

The last patch fixes one of the instances where we treat a reference
inconsistently by converting it to a normal reference. We can eventually
migrate more of the special refs to become normal refs as we deem fit,
but I consider this to be out of scope for this patch series.

These patches improve compatibility with the new reftable backend.

Patrick

Patrick Steinhardt (4):
  wt-status: read HEAD and ORIG_HEAD via the refdb
  refs: propagate errno when reading special refs fails
  refs: complete list of special refs
  bisect: consistently write BISECT_EXPECTED_REV via the refdb

 bisect.c                    | 25 +++------------
 builtin/bisect.c            |  8 ++---
 refs.c                      | 64 +++++++++++++++++++++++++++++++++++--
 t/t1403-show-ref.sh         |  9 ++++++
 t/t6030-bisect-porcelain.sh |  2 +-
 wt-status.c                 | 17 +++++-----
 6 files changed, 86 insertions(+), 39 deletions(-)

--=20
2.43.0


--DY5vuTYh2AF+wzzV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVm8s4ACgkQVbJhu7ck
PpTQ6w/+LHzHtgFThwd8tW+GsIrYFfFUuKdJzISlQmbRx9tOlPPwN2kscCHrN8jw
dUpEmFxfU/g0sIvCNph0sW8Kjg8w6+LOR9/tOKAxEX4Ufeda/Otc2VbSbTRPmqbn
pu8MvUTDxik+vueeatEysEYBlYFdCYU0261vcN+gdOPDaP6HqarDNSCfCiJOvgoY
nCP6zO9NPXJkRRaNWDqJ5v/ukHr8Vo7MSZsNDtcCszYSWfTFgSPcfy7cJ9Huas6n
BYVrSuwfnqA0Xt78Al5VlHS6T9y2WhiwZWlMyrgNRHj6V8aUaqnOjoY2i5+rM1JO
81RtHngDwq57rRcB/7QEcqdZRqHe+MZhe62dA92lYyx03cWTf5DnZlouqh/Nv9fn
eISWdbcNyKiwwfY3/v+O7Ief6cI6pk1xiKNKLcaA3DDOIQZ6lCqKOkj8vXxhA7nO
zP1F6kdGdERxc2scetk/MbNS3J5bxPszdW7VJ1DjL7X2ixHMm/5u9V9hk9KuT83n
nnqc/a7L47138Ee0IFKuNlxrWakfQiW7Iz1L+/OAxJHJfBYNzqr6DSKN2taA+IVs
Z81ojBRmfWYw5RkwYB/QX5/fgzRIF1x5t+P5KtBDzzjLlfyhOgwmKhrs0Wbn2bVY
gJ1wiSjs+N+wxoovM63t+Eb+XT5ne3mm/1yKhq5kZHeVFBQ10K0=
=PDyc
-----END PGP SIGNATURE-----

--DY5vuTYh2AF+wzzV--
