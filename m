Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2993BD535
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jy/gjcHY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BAx9oVKP"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562ECA6
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 01:16:14 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 8CAAE32007E8;
	Tue, 31 Oct 2023 04:16:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 31 Oct 2023 04:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698740173; x=1698826573; bh=RO
	bk9wrFisffIUjCVITWl7B4X92dfVQApKx9F2hcqtw=; b=jy/gjcHY6/TxSGLEKr
	fepy2CRhjGVit7z5iAkmTAl6CicuvZVFq3hvZDR70zKYtj3nnrcorjTPCGaIO7oh
	hqzNrmeWhbFltzjNSHEQRa9JSex7MaLDiGEgnf6at2JoxEeZXJ8ehWvPqZ+E1Ufm
	gnZe8RipCtFjgW4Tb1LHFzhOgEs/8iTBqwP8fTBHImzldLBnoq4mmANEu/emRixr
	ZAJxrK07oRhctRvucsd/tgf5WMX39i8RRSbKTsy5v0YY7O3a5M5shZjw3Aby9VC9
	NFGHP/yfcyiAAYPP+2hTTBw08H5iFjer3Eh8+24DrXfUA7DSzWmYL6lHlJQe8j8o
	JxRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698740173; x=1698826573; bh=RObk9wrFisffI
	UjCVITWl7B4X92dfVQApKx9F2hcqtw=; b=BAx9oVKP1GbeGzAn379+1/tDVUk2G
	xNKAHjc7bi+NKWVS2KZg1CdARX/fzJUjCjN08ECXJYXmIxHClo7QuE94Gm9D8tb0
	prtPGYBOKGdryewB2n2YIE0NTyPK8kHUQsxaoK28+cUGU1ZMh6WOuSZJ1EJQwtPc
	E+V44ebjVxuWMJSd77S8L0XqywHTh3Y6trb7xpFjN2dpRQOVqYlzRvybxgMGkpkV
	vOiNE1hcBlXyoE9AsrMDWAzubfBQUJIX5jKYBs+8DCn0k31N2ZsNlzcqnE2ElWTo
	YwC1wPvP7p42HOMvy843rf/Gi30iyD+R8UEwvW7OhQkP7QPH/EPLjM1sA==
X-ME-Sender: <xms:zLdAZfWQr_G9zxm5xYWiBhOUjqpFttkgnfvQ3jLI4JTCEnF2WBd38Q>
    <xme:zLdAZXnyzgPN94GoT6yxUeCNVV-8vCECPY4n7Bi-Wm7T5nte0qpQI80HSMenqmKWF
    EdvjsBgWd44XWI0qQ>
X-ME-Received: <xmr:zLdAZbZL4vldeauSSl2k7xXya43CoIl0qKUzHrlSV0tu480s4Wj06keaZPjBmlng89OenwdAQJsNtL1dNqkEjy1eGuSLJkiZZSbPrbMjWeCch8YA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:zLdAZaUsC5oh6HRNrIaK2s5hCW_-A-9l-lkNY2BmpBwSohA-pVlqDg>
    <xmx:zLdAZZkEPhvdW5sh1k92U2VEeRxNxeVxSQ6THbdIQE9fjQkusD-pGA>
    <xmx:zLdAZXcHfL3FC8wFIwoYodvrHxwh2XKr1Jr3g-YtPErW5bfNBZrkVA>
    <xmx:zbdAZfhEe1iFKccJdULCcs2PeK9kWzxm374Xhm4ByQFCXmb5I1zmbw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 04:16:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2f675539 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Oct 2023 08:16:02 +0000 (UTC)
Date: Tue, 31 Oct 2023 09:16:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v3 00/12] builtin/show-ref: introduce mode to check for ref
 existence
Message-ID: <cover.1698739941.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NeyFY82BNB4vzlfT"
Content-Disposition: inline
In-Reply-To: <cover.1698152926.git.ps@pks.im>


--NeyFY82BNB4vzlfT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series that introduces a new `git
show-ref --exists` mode to check for reference existence.

Changes compared to v2:

    - Patch 5: Document why we need `exclude_existing_options.enabled`,
      which isn't exactly obvious.

    - Patch 6: Fix a grammar issue in the commit message.

    - Patch 9: Switch to `test_cmp` instead of grep(1).

Thanks!

Patrick

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

 Documentation/git-show-ref.txt |  20 ++-
 builtin/show-ref.c             | 284 ++++++++++++++++++++++-----------
 t/t1403-show-ref.sh            |  70 ++++++++
 t/t1430-bad-ref-name.sh        |  27 ++--
 t/t3200-branch.sh              |  33 ++--
 t/t5521-pull-options.sh        |   4 +-
 t/t5605-clone-local.sh         |   2 +-
 t/test-lib-functions.sh        |  55 +++++++
 8 files changed, 373 insertions(+), 122 deletions(-)

Range-diff against v2:
 1:  78163accbd2 =3D  1:  9570ad63924 builtin/show-ref: convert pattern to =
a local variable
 2:  9a234622d99 =3D  2:  773c6119750 builtin/show-ref: split up different =
subcommands
 3:  bb0d656a0b4 =3D  3:  b6f4c0325bf builtin/show-ref: fix leaking string =
buffer
 4:  87afcee830c =3D  4:  4605c6f0ac9 builtin/show-ref: fix dead code when =
passing patterns
 5:  bed2a8a0769 !  5:  b47440089b6 builtin/show-ref: refactor `--exclude-e=
xisting` options
    @@ builtin/show-ref.c: static int add_existing(const char *refname,
      }
     =20
     +struct exclude_existing_options {
    ++	/*
    ++	 * We need an explicit `enabled` field because it is perfectly valid
    ++	 * for `pattern` to be `NULL` even if `--exclude-existing` was given.
    ++	 */
     +	int enabled;
     +	const char *pattern;
     +};
 6:  d52a5e8ced2 !  6:  6172888e465 builtin/show-ref: stop using global var=
iable to count matches
    @@ Commit message
         builtin/show-ref: stop using global variable to count matches
    =20
         When passing patterns to git-show-ref(1) we're checking whether any
    -    reference matches -- if none does, we indicate this condition via =
an
    +    reference matches -- if none do, we indicate this condition via an
         unsuccessful exit code.
    =20
         We're using a global variable to count these matches, which is req=
uired
 7:  63f1dadf4c2 =3D  7:  bc528db7667 builtin/show-ref: stop using global v=
ars for `show_one()`
 8:  88dfeaa4871 =3D  8:  e3882c07dfc builtin/show-ref: refactor options fo=
r patterns subcommand
 9:  5ba566723e8 !  9:  a095decd778 builtin/show-ref: ensure mutual exclusi=
veness of subcommands
    @@ t/t1403-show-ref.sh: test_expect_success 'show-ref --verify with dan=
gling ref' '
      '
     =20
     +test_expect_success 'show-ref sub-modes are mutually exclusive' '
    ++	cat >expect <<-EOF &&
    ++	fatal: only one of ${SQ}--exclude-existing${SQ} or ${SQ}--verify${SQ=
} can be given
    ++	EOF
    ++
     +	test_must_fail git show-ref --verify --exclude-existing 2>err &&
    -+	grep "only one of ${SQ}--exclude-existing${SQ} or ${SQ}--verify${SQ}=
 can be given" err
    ++	test_cmp expect err
     +'
     +
      test_done
10:  b78ccc5f692 =3D 10:  087384fd2fd builtin/show-ref: explicitly spell ou=
t different modes in synopsis
11:  327942b1162 ! 11:  ca5187bb18a builtin/show-ref: add new mode to check=
 for reference existence
    @@ builtin/show-ref.c: int cmd_show_ref(int argc, const char **argv, co=
nst char *pr
    =20
      ## t/t1403-show-ref.sh ##
     @@ t/t1403-show-ref.sh: test_expect_success 'show-ref --verify with da=
ngling ref' '
    - '
     =20
      test_expect_success 'show-ref sub-modes are mutually exclusive' '
    -+	cat >expect <<-EOF &&
    + 	cat >expect <<-EOF &&
    +-	fatal: only one of ${SQ}--exclude-existing${SQ} or ${SQ}--verify${SQ=
} can be given
     +	fatal: only one of ${SQ}--exclude-existing${SQ}, ${SQ}--verify${SQ} =
or ${SQ}--exists${SQ} can be given
    -+	EOF
    -+
    + 	EOF
    +=20
      	test_must_fail git show-ref --verify --exclude-existing 2>err &&
    --	grep "only one of ${SQ}--exclude-existing${SQ} or ${SQ}--verify${SQ}=
 can be given" err
     +	test_cmp expect err &&
     +
     +	test_must_fail git show-ref --verify --exists 2>err &&
    @@ t/t1403-show-ref.sh: test_expect_success 'show-ref --verify with dan=
gling ref' '
     +	error: failed to look up reference: Is a directory
     +	EOF
     +	test_expect_code 1 git show-ref --exists refs/heads 2>err &&
    -+	test_cmp expect err
    + 	test_cmp expect err
      '
     =20
    - test_done
12:  226731c5f18 =3D 12:  ea9919fe899 t: use git-show-ref(1) to check for r=
ef existence

base-commit: a9ecda2788e229afc9b611acaa26d0d9d4da53ed
--=20
2.42.0


--NeyFY82BNB4vzlfT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVAt8cACgkQVbJhu7ck
PpS4fg/+N+WD5Ts2/HvySHiZq+sSsnm9l8T9w7Oa8vIjnrXvKYivhMTsLobw/Gbf
/4nP2jNW+SMh69hQbxJBW+RFEiVuME96YPT6OLwIhVxsLfqXnQol3hSnCRw+fhbJ
LQr6T6QVbcaxv2hgOXbpokHTMNbJjO9oT9cpd9G1Tl2wk4JoCiGVK5Kw3/6KRu/v
KdpcPkd4bJre/iBiVBCczV5yEV801w0wtC4sD8aAZKKbHOLjAD+FccNi9wS2F6eh
1eYxMhoa/ZT9Kwm+vdbGaav8VUR3ZXwLhe+OrK3F24iecWr2BgJ3L6NBjy51xaq1
wfLqY6+rS46m8Xl3f0TAiXeauhmMed6OPiUzGwwkV0qg1XhRD2uCx+dhTpHczDmj
WGT2I1V8n2Ly4jnj9l5djExGejHq8fOuW1Q122oFPOBQv3elYrdunaP04EQibN9G
hItRa1SwcHSEzBcoKiCslivW7FNow14fkI3/4/LWIlF13/Bjjp2V/Vxo4SbSYx0o
f5FLlfwdZ7kJ0gshx99gPRkceBaQeHvdsYsGK61kvpFKAAQu29V1SRtE90GBeEQG
vE5OSwT+G8yx+HZ+4ov9kRyRQyFejwdzRBz8665F19YFwGtKFLWE9ovl2nxsyWnX
qQVsKeN7DLV8e19dBfWIJegGJNQVED+r4AaRqPOMuur0PfPDeZI=
=jQfx
-----END PGP SIGNATURE-----

--NeyFY82BNB4vzlfT--
