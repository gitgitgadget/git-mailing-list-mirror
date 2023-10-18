Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00EA8C1A
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 05:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jibU228D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mPhyfpLA"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F04EBA
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 22:39:56 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 755D13200B1E;
	Wed, 18 Oct 2023 01:39:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 18 Oct 2023 01:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1697607594; x=1697693994; bh=9L
	0qX+rTu9b3CN6gBzLyMBI52fUJ0SGdysCQN9Waiwk=; b=jibU228Du16ohSCWDw
	jSlBbwrpkDy1gtgFp90tBbvghpbFuTQklgwqMPWFztMW+7NXNnlLIXbpzy7hl3yU
	r54svomnzyrCGpsB8j1FEHszxQ4W1a7b3lN2tY7iy/XfZCVWdEnlsdo5lHopMtb+
	J6NtU+5/o1GE0UieUtEtYJvJ3IAUoqkaVyuNP9PEtBVh3YvRhDKax7H9eAdAlend
	hssjTtJ/jB73Xz0Py6/UWp2yzxCaiwZK5OfGMsMecxiw1NSrazNY2bVNZPj8g41M
	y5kfKhkll83G07KNl6XqjVN26EOvEZ8wGAayKxZguxiqb7Av0xy0kC74IxapCYLN
	QR2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697607594; x=1697693994; bh=9L0qX+rTu9b3C
	N6gBzLyMBI52fUJ0SGdysCQN9Waiwk=; b=mPhyfpLAh24nxujkAPlpmIfiKBSaW
	3rf8vaiAZ4My1FBRSngEf+4YlaAZhnn+UZcLvqWt2PrB1FCBzSCRoUyHvvQ/e51U
	uT3azC5ShtN3eYfIt1xe4RahQLBCWkQxswxJIMuyjqnySPp36hGqiMCEni3Bkvwg
	LJ24RCB4nuFFduLrlAGbr5sz22BPNlWqjS3K6I1mnfzYTc+8NW2SEZp4hPvHmkOK
	LVsyduI2ndU6ZLu43YeXHX0nJ+o6IxTkL/oDddXHUC4IZaMNlQy2bUkUBWvHl/6h
	nc/7yAFTmrNosFLCNo2vyXynVMYtV3Fmn0xP43/X33vXDHzVSxbZRRiTg==
X-ME-Sender: <xms:qm8vZV3po1jSz9A1wzMhpJHuAG37cF71OoVtED0-t2gnnapt3IaWiw>
    <xme:qm8vZcEGJhE_dy9kDdIzx8HVq2KyJpsWavAhishYaJ5bZzeg17ZwZfRzISZeCDnEX
    _OVYE7pWYDXSs7Ddg>
X-ME-Received: <xmr:qm8vZV6ejgblXfsupHe2MoREHpYmc4tDAPARi1IqFw2itgk5yumd3fw7CqRZDTZBdkmsNy_81-Uhw6hvCvA6DvBCpMx_xFRLhOYe-ccF7sRNzwGj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeefgdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:qm8vZS1OjbS0_7Cf4slrlUSlJWALRddCUuv185OS7o33HI7f2UwQPA>
    <xmx:qm8vZYF7Jiid9EsmxrvsbAdJrXfOPEoZtbogxCSVjJUz3402ssDrvA>
    <xmx:qm8vZT8YK-UNWX6wKR4UcJsAeZab6c2IMx8AtJAwU0xAWV8nECQo4w>
    <xmx:qm8vZTPpodqJoVARuqxVwR-SIoabgp3St98Ov6f2lwEU-D4klVf3aA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Oct 2023 01:39:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 574c7382 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Oct 2023 05:39:52 +0000 (UTC)
Date: Wed, 18 Oct 2023 07:39:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 00/11] t: reduce direct disk access to data structures
Message-ID: <ZS9vp9dnoVVUsMIt@tanuki>
References: <cover.1697607222.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lYtZmW9Lgno/ehyv"
Content-Disposition: inline
In-Reply-To: <cover.1697607222.git.ps@pks.im>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--lYtZmW9Lgno/ehyv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 07:35:03AM +0200, Patrick Steinhardt wrote:
> Hi,
>=20
> this patch series refactors a bunch of our tests to perform less direct
> disk access to on-disk data structures. Instead, the tests are converted
> to use Git tools or our test-tool to access data to the best extent
> possible. This serves two benefits:
>=20
>     - We increase test coverage of our own code base.
>=20
>     - We become less dependent on the actual on-disk format.
>=20
> The main motivation for this patch series was the second bullet point as
> it is preparatory work to get the reftable backend upstreamed. My intent
> is to get rid of many or even most of the current blockers in the Git
> project before trying to send the reftable implementation upstream.
> While this will be a lot of up-front work that is going to span over a
> long time period, I think this approach will make everyones live easier
> by doing comparatively small and incremental improvements to the Git
> project. Ultimately, the final patch series should in the best case only
> contain the new backend as well as testing infrastructure, but not much
> else.
>=20
> Patrick

As usual, I forgot to mention that this applies on top of current
master, which is at a9ecda2788 (The eighteenth batch, 2023-10-13) at the
time of writing. I look forward to the day where I remember to include
this information in the cover letter...

Patrick

> Patrick Steinhardt (11):
>   t: add helpers to test for reference existence
>   t: allow skipping expected object ID in `ref-store update-ref`
>   t: convert tests to use helpers for reference existence
>   t: convert tests to not write references via the filesystem
>   t: convert tests to not access symrefs via the filesystem
>   t: convert tests to not access reflog via the filesystem
>   t1450: convert tests to remove worktrees via git-worktree(1)
>   t4207: delete replace references via git-update-ref(1)
>   t7300: assert exact states of repo
>   t7900: assert the absence of refs via git-for-each-ref(1)
>   t: mark several tests that assume the files backend with REFFILES
>=20
>  t/README                           |  9 ++++
>  t/helper/test-ref-store.c          | 38 +++++++++++++--
>  t/t1400-update-ref.sh              | 49 ++++++++++----------
>  t/t1430-bad-ref-name.sh            | 39 ++++++++++------
>  t/t1450-fsck.sh                    | 46 ++++++++++---------
>  t/t2011-checkout-invalid-head.sh   | 16 +++----
>  t/t3200-branch.sh                  | 74 ++++++++++++++++--------------
>  t/t3400-rebase.sh                  |  2 +-
>  t/t3404-rebase-interactive.sh      |  2 +-
>  t/t4013-diff-various.sh            |  2 +-
>  t/t4202-log.sh                     |  2 +-
>  t/t4207-log-decoration-colors.sh   |  4 +-
>  t/t5521-pull-options.sh            |  4 +-
>  t/t5526-fetch-submodules.sh        |  2 +-
>  t/t5605-clone-local.sh             |  6 +--
>  t/t5702-protocol-v2.sh             | 24 +++++++---
>  t/t7300-clean.sh                   | 23 ++++++----
>  t/t7900-maintenance.sh             |  3 +-
>  t/t9133-git-svn-nested-git-repo.sh |  2 +-
>  t/test-lib-functions.sh            | 66 ++++++++++++++++++++++++++
>  20 files changed, 277 insertions(+), 136 deletions(-)
>=20
> --=20
> 2.42.0
>=20



--lYtZmW9Lgno/ehyv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUvb6YACgkQVbJhu7ck
PpTUnA/7B1VbV18BWVo0ClTRDB3ra919qv/1Pv65q9cG2eujsxRkY7q2Tr/Wfcgl
QY2E7cmvm2nXkVez+Vm/6GgUsLsFbnoeRo4tIJtnkPOtcnGNDqWKER/cn1kq5V5H
N3pCU6Dt/SxjMs5LVUB8HcE54B8feQt0yp4ryQhLcIP+jnL2naffzVOJQXKeTANE
yTW/yCfCS7cqpMWISVLQiqVj6Hn5laxrqRffQnofuZb8LxbRbbB454EwyBzdZXK2
s/5RYYzZ49ZpjZ9VdVJToNTT9LWxYYifegGMxEp7bTwfdGVwwGMhw93M00H2WWQQ
50xL8LFLUbAtAvV+7nYJFV9fWdjekxyvsEyQDjyOCmSeOU4fOMDuBudUQbFmKr+k
VOP345VNnsNk2wxPKP4kmxps9r2JNAn6uWaBAvirKdhE3v3dSeLoiF8uGbykW+FL
oLMVrxKGHwGynysQYp2poJQqnXlRYuAL8ggrN5vDn8sOeXOk2zxzus7uBxzPA79B
8WE0fqSPGyFQXqMbX/yAdMutXsgtDJn8PJ4Xtr0yxi9wHkH+TZJ151Rclkj3xdRi
RVHIlOw2aqKyFFNjp4/2wAAsVxYbUYsqsJZP3D4j59G7QcYTTLYKlA1TtIV1Tp2f
A+jKu8c3PBqqh+jj7QgMbprwKXSiztP7cd/Ge10sDaOdT1eFICM=
=tOuI
-----END PGP SIGNATURE-----

--lYtZmW9Lgno/ehyv--
