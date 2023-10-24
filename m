Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07022219ED
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 13:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tsM3OvRm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R/dqwCSw"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EF810E9
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 06:10:44 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 035F13200A22;
	Tue, 24 Oct 2023 09:10:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 24 Oct 2023 09:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to;
	 s=fm3; t=1698153041; x=1698239441; bh=Lw3nLXoVp57DTp7fdpRdISTo8
	U/6T+g3/nAmEUT5R3I=; b=tsM3OvRmLkU9BApoEYU9SpStruIB5sFc+fbmfSRzn
	McEIzF961QH7fGFg5lKd2J9DSQ305U92t4L5sHOzgDxjv63ZlX7Qj86QvUIeAs6K
	YtX83jXpPrHUxomVF247oTSp6z7Bjpm9IFGE/W3Hu9yzBvQ3uslysS5S7gqDLGJ7
	NIhHiQoDM35EhPsyyYiyukJeDbVY9fL+vbgwkcwiiqljWauaMSuemwgB+vHAZtcO
	0cGVkHD3LjjehplGVujJ3P01JVV2UqxrFDfEmey56Zab8Eg/8X5s9IU8Ct8lKtp5
	UTMCvGXN9umjQhue96PBeXzjXo+jD8kH33xNosDVxcMzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1698153041; x=1698239441; bh=Lw3nLXoVp57DTp7fdpRdISTo8U/6T+g3/nA
	mEUT5R3I=; b=R/dqwCSw4y4cR+gf6wnfDXYZ/NDMrvqNgeyaEvTUQZIaDR+KiWz
	X5GtrSUbGB8G0FSeIhg5UuBOw17UFNZ04R/lALSTYdBlRvtIUTt7Y+IMc1tVPn5F
	Yxc9iw4U3Gxv9jDUsJwQjmsEG6UFgqeasy447Juq6c5IngKdfpPAzgXZZe36pVM7
	scNNq6bCQHOddCNqq06p2ah/lzpAGnp0ZWvldQfoIWOuu2ROU4sALc1Uvk3Mv7kb
	mlskrxQARapPn03qGx1OWdjBSOVOwRq3zGNiF1VJXJWfv/OMhVzpmAq1T1Wgnp2O
	irPHgnGJoTdB55SVEONMlFKrOHy93N1BjWQ==
X-ME-Sender: <xms:UMI3ZU7YO6zQpgqpbHhC_ZOeNJgHuVse4ctq6ch4Jfx9M4NROuy0ag>
    <xme:UMI3ZV5Jr2269GMwOPmJi1vfZ5EnftfkaZlN3tqEe9ckyP_zmk2LIGAIFhNympr-b
    ZfTt1VXB9WTQ5M3jg>
X-ME-Received: <xmr:UMI3ZTcJlU0QzxX0gIVgZysSZdJ2QK6_5WGou1Sbog9wxr5o46fnBZsnYXoNmXiQYHqmbcQ1hpZfCGbBNaU6-VQsMwYmW27KYRM5PRFMeUrZl2Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeekgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfggtggusehgtderredttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    efveetlefhhedvgfelgeehkeejkeegveduveffgeejudduueevhfetgefhkeelleenucff
    ohhmrghinhepphhkshdrihhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:UMI3ZZLCU2TCRfPMi7XzcKpLa3WAUS9adN_bFPBADYGTdk-72s_MDA>
    <xmx:UMI3ZYLIVC_HertaeQgwhmQ9X8aAYLOUiD70a9SQW9AJXj64Y1fskQ>
    <xmx:UMI3ZazH_Gfx5pdHbha5YHKrQzv2Hp_27V_Au9PnUJof1QMsd84qKw>
    <xmx:UcI3ZfWjCzhv5JLHByDKDpOki4vwa2dG5XrK41-sMA37Qwz8skhLlQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Oct 2023 09:10:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dbc63736 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Oct 2023 13:10:32 +0000 (UTC)
Date: Tue, 24 Oct 2023 15:10:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 00/12] show-ref: introduce mode to check for ref existence
Message-ID: <cover.1698152926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ef0ocYEVgqoXO7Sj"
Content-Disposition: inline


--ef0ocYEVgqoXO7Sj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch series introduces a new `--exists` mode to git-show-ref(1) to
explicitly check for the existence of a reference, only. It tries to
address a gap in our plumbing tools: while we have a plethora of tools
to resolve revisions and thus also references, we do not have any tool
that can generically check for the existence of both direct and symoblic
references without resolving its contents.

This series has been split out of my other patch series that refactors
our test suite to reduce direct access to on-disk data structures. It is
structured as follows:

    - Patches 1-8 refactor the code to stop relying on global variables,
      addressing some smaller issues that surface. Furthermore, the
      different modes that git-show-ref(1) has are made more explicit
      such that the command becomes more extensible.

    - Patch 9 ensures that the user does not request mutually exclusive
      modes.

    - Patch 10 updates the documentation to better reflect how the modes
      are to be used.

    - Patch 11 introduces the new `--exists` mode as well as a bunch of
      tests for it.

    - Patch 12 introduces two test helpers `test_ref_exists` and
      `test_ref_missing` and updates many of our tests to use those
      instead.

I admittedly may have went a bit overboard with this series. But I had a
hard time understanding git-show-ref(1) and how the global state affects
the different modes.

Patrick

[1]: <cover.1697607222.git.ps@pks.im>

Patrick Steinhardt (12):
  builtin/show-ref: convert pattern to a local variable
  builtin/show-ref: split up different subcommands
  builtin/show-ref: fix leaking string buffer
  builtin/show-ref: fix dead code when passing patterns
  builtin/show-ref: refactor `--exclude-existing` options
  builtin/show-ref: stop using global variable to count matches
  builtin/show-ref: stop using global vars for `show_one()`
  builtin/show-ref: refactor options for patterns subcommand
  builtin/show-ref: ensure mutual exclusiveness of subcommands
  builtin/show-ref: explicitly spell out different modes in synopsis
  builtin/show-ref: add new mode to check for reference existence
  t: use git-show-ref(1) to check for ref existence

 Documentation/git-show-ref.txt |  16 +-
 builtin/show-ref.c             | 275 ++++++++++++++++++++++-----------
 t/t1403-show-ref.sh            |  70 +++++++++
 t/t1430-bad-ref-name.sh        |  27 ++--
 t/t3200-branch.sh              |  33 ++--
 t/t5521-pull-options.sh        |   4 +-
 t/t5605-clone-local.sh         |   2 +-
 t/test-lib-functions.sh        |  55 +++++++
 8 files changed, 363 insertions(+), 119 deletions(-)


base-commit: a9ecda2788e229afc9b611acaa26d0d9d4da53ed
--=20
2.42.0


--ef0ocYEVgqoXO7Sj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU3wkcACgkQVbJhu7ck
PpQz8BAAlMxHyKghmXXCuvTAj+cZAyvst+r8vjxfCsdg1J4IHifekSpdc3DSSCpp
nIokxoeCl0wffaLievu+boVmf7UL2zFfYbaJQVAqMKxj9qptsYvvHi4fqURjICEn
527rmrmcn1o+iXqXQBWNVlBhCQjJfOSyvC1E6L1dY7M1ypsNlANxR9xkDOcJul7f
cN+oNZdbbNQLY0CPDDnXSAYB9iTnDuQs4vBDY9yAks84XX0urH1/StxKyW/TDEYQ
9tsz9uTxRljmSZyUElJFfiDl05LC6sA58NbLBjXUuch5/w1Fi7wa0XfnsiMLrncu
qaMEOFQ83iYt1W9gVoZuzGaSpcReXGcPUfqEUg5RnmfsWct8DHcGMTXGV3gcSWcL
L2LF7pXNbOjVNIklv9HCYEHJEusADw6KvmMc8rxCabx2ap4llERjrPB7N3psvJrQ
eOvufnYwgt1rNYdpEkKXqC5KrWaCeXMj4Br4SaiBmCDaDSd+Gs4IfKH0j4ALu5Mm
kDEpYXQdslDeEObZuiDA30Dw8Dtzqm9i+UBP3xz+wlTdNk77SmM2HzXJEpiLLdzm
Yl+l75qQg8rX4wH5dL0gqEkgw4ayYha9QQ1upF+7exdoOp1QXAmczUIEiROKt7U5
2tNm3a8e0JAqtZE5piLu10mW6VG4LN3k8AXWabunWDSeMlxf7zE=
=u33C
-----END PGP SIGNATURE-----

--ef0ocYEVgqoXO7Sj--
