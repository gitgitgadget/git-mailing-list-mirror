Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521AA8F41
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 05:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Up23TKNy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LA4vHK4X"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6495AB0
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 22:35:11 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 44E643200B3A;
	Wed, 18 Oct 2023 01:35:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 18 Oct 2023 01:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to;
	 s=fm3; t=1697607307; x=1697693707; bh=mCfX9a4ExBdYEGGlK5z71V4/Z
	UbR53NxXTpATnG3KH8=; b=Up23TKNyaWc+jAw0UcRCM3UcDc8Q6ZNhf871vZJ2E
	OjC1zFQweDxvTOq4FuwjU5Le428hJkZaZr9+XuzukKTHYC9AjT0Z+XG6kcYRLk61
	6W1rExpUn5fARqAYrTpj4Q5YybM3jpMPaB60IPhKD7KBa42YEVjHyEvif8/TMg7F
	A5jMa7eK5JhBKGezm9EvtUGRrIkFlq0npGJM3ajqtDG92/D91VhP8ZW/FfwfrblF
	sNZaR53xJEo/Km0kc4m1FIg4BKHb6n/WSlt7WR5rX3PQEayTXpi4rdunKDGp8vIV
	T1kh4cRAqNrQEou7vcl8srF3FFEj822xv6rrn5+jU4xlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1697607307; x=1697693707; bh=mCfX9a4ExBdYEGGlK5z71V4/ZUbR53NxXTp
	ATnG3KH8=; b=LA4vHK4XIxlw6cP3ox4AcOM8w7vLpG5+UBlUHgIGL8cmQ1N2rhZ
	BnA2/XT0LMH+fvWEGGge4GKsiRO4FOBx1ay9XmZtd7Ptn6WBLuxZOXh7THUpY5KP
	0iRl2ncnc0ZxXR+9eLNJ+Ap4Mrpec8D1SUdPwYTW0vof/yARQN/vr8lD/d6Es4oc
	VJ4ZW/GQmfsG1va1t8IHlcz4s8frX9kyFmthTidqab/qT7Tbl+zXYr4vciHqJi4E
	RZ3MP+9RCNazZWsQ2CgmDjzgBvvi5GGZ6pcWzdhhFaOnSZmklAAEfZQLc3MWdegR
	Bd4R9+MUvhnfIKmGnQ3DvBhizyINGTD6ngg==
X-ME-Sender: <xms:i24vZXYnlJf6uEgwtH-JA_oQgUCcDzRs3t6uwG3jR49Ho_OEtSqElw>
    <xme:i24vZWbtRqL4J4MaO1ePg-6by-psnInaeIy8nx1BUPyiKloevsOOpe0dm6V9JA8xa
    l5iRvn8CXSA5wFN_w>
X-ME-Received: <xmr:i24vZZ8Q5RYVqFHkh8u-cKYaVpShvaiPNzMPThsBylnMB7FUXdfLLTajzLJNRR7wMvPpjeGmkMfJdQ6QuhX9esaQEH-EMPLNM5GBC25J54ddkv65>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeefgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfggtggusehgtderredttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    eugfeutdeuieehteelveegudejkeejheeljeejhffhgffhvefgkeeukeejtdeijeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:i24vZdpZ7gXw1KXbHTYl8pfoy_4T4iVNS9zFbCXGB0qZsEYz3-I3BA>
    <xmx:i24vZSricciVrBtwR2lcqMc3g8mjUd_LRu3z_rorSZ6tqClqzFkUYw>
    <xmx:i24vZTSkTRUTxU0OrAsgSKwwkr5nA_fdMRN8tXlax0xxNe6W8_5Ynw>
    <xmx:i24vZZQCIomEcCn0GzF9e4O2Tpf2yMx0HK4K3d4geJYDuJ9T3ns5hw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Oct 2023 01:35:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id df9a98c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Oct 2023 05:35:03 +0000 (UTC)
Date: Wed, 18 Oct 2023 07:35:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 00/11] t: reduce direct disk access to data structures
Message-ID: <cover.1697607222.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jUW6VLJSO0cqAXZi"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--jUW6VLJSO0cqAXZi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this patch series refactors a bunch of our tests to perform less direct
disk access to on-disk data structures. Instead, the tests are converted
to use Git tools or our test-tool to access data to the best extent
possible. This serves two benefits:

    - We increase test coverage of our own code base.

    - We become less dependent on the actual on-disk format.

The main motivation for this patch series was the second bullet point as
it is preparatory work to get the reftable backend upstreamed. My intent
is to get rid of many or even most of the current blockers in the Git
project before trying to send the reftable implementation upstream.
While this will be a lot of up-front work that is going to span over a
long time period, I think this approach will make everyones live easier
by doing comparatively small and incremental improvements to the Git
project. Ultimately, the final patch series should in the best case only
contain the new backend as well as testing infrastructure, but not much
else.

Patrick

Patrick Steinhardt (11):
  t: add helpers to test for reference existence
  t: allow skipping expected object ID in `ref-store update-ref`
  t: convert tests to use helpers for reference existence
  t: convert tests to not write references via the filesystem
  t: convert tests to not access symrefs via the filesystem
  t: convert tests to not access reflog via the filesystem
  t1450: convert tests to remove worktrees via git-worktree(1)
  t4207: delete replace references via git-update-ref(1)
  t7300: assert exact states of repo
  t7900: assert the absence of refs via git-for-each-ref(1)
  t: mark several tests that assume the files backend with REFFILES

 t/README                           |  9 ++++
 t/helper/test-ref-store.c          | 38 +++++++++++++--
 t/t1400-update-ref.sh              | 49 ++++++++++----------
 t/t1430-bad-ref-name.sh            | 39 ++++++++++------
 t/t1450-fsck.sh                    | 46 ++++++++++---------
 t/t2011-checkout-invalid-head.sh   | 16 +++----
 t/t3200-branch.sh                  | 74 ++++++++++++++++--------------
 t/t3400-rebase.sh                  |  2 +-
 t/t3404-rebase-interactive.sh      |  2 +-
 t/t4013-diff-various.sh            |  2 +-
 t/t4202-log.sh                     |  2 +-
 t/t4207-log-decoration-colors.sh   |  4 +-
 t/t5521-pull-options.sh            |  4 +-
 t/t5526-fetch-submodules.sh        |  2 +-
 t/t5605-clone-local.sh             |  6 +--
 t/t5702-protocol-v2.sh             | 24 +++++++---
 t/t7300-clean.sh                   | 23 ++++++----
 t/t7900-maintenance.sh             |  3 +-
 t/t9133-git-svn-nested-git-repo.sh |  2 +-
 t/test-lib-functions.sh            | 66 ++++++++++++++++++++++++++
 20 files changed, 277 insertions(+), 136 deletions(-)

--=20
2.42.0


--jUW6VLJSO0cqAXZi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUvboEACgkQVbJhu7ck
PpTaHA/8CcaM02dCuuTU7+mU44iHIt5dGfeQeRPWYgs/TZPRW27WH9hVPPBgcDUA
bx7eIkWZY/7puBXJNdFIiWG6QVY8yGnYWsy3ajwXF5XCV627qr2fDXjx52V89Ob3
us8Vb3RMzQUpyJRUZ0evUaZDpVWHHBC5y2tL8/NhdCQjgAYXKGxvr9gsUsigmmdB
y9IEjYO2gSVmhJxLBFkRpjyRT/Fg2SVrQtQQt3BhwpPHDvzBEjowCEeYoz+MNrrm
8eRWiiu5AQUAuqCKaD2Qwk5sxwbkI7xeRqo75GNynAUQSZuXQsTy9+PmIHjy5mbC
FwTYSfLJ1lJvyHARANGrC5VzQz0twYkkwBpnNdNz33Qdv7hzaRwmmriBP3CBhGn2
G3jtXkNmpf9ya4DS1RARc+7+VRl+4xixTsO8H8WzgFtNka9sDDcKyAAJDgmGSqcj
BLxunAGCrrKjZuf/6uwPu/6+qIzpRXjmE08DkMrNB54SZEYJQpv6pCevOrp2/Hq9
bx2ux380W8Uf6/QrFoXQF6OQYuoBJNM82NbKwAwNiBjqWgGgLtOcSIXScyCORKPu
qJ1hHJYcMeVprXCMQ5SFoFpLP5/4jnxfkQD4+32uo75JvwrSIFC4sxg2nyrD9VGz
xAXaGUxTAkW3ZMgNNOhtWtq0ORve1J9LKV0pgiimuEQ+2/h5IK0=
=puna
-----END PGP SIGNATURE-----

--jUW6VLJSO0cqAXZi--
