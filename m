Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4882AB57
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n1Q5CbBI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rMEO6iZP"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172D9C1
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 06:11:29 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 482243200998;
	Tue, 24 Oct 2023 09:11:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 24 Oct 2023 09:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698153087; x=1698239487; bh=bc
	k707V/CsZyXnCQfr89GqMdUZnpBV6/h5yw4vkUKOM=; b=n1Q5CbBIGHcRwr7MCD
	yn43gtPhZwxX3WQJVtv+NjUd+toAvO76ykSTaDuE/lX75KCHa4vUzuzxCIzfLLLk
	uzLjcY3KNq0b5tL0rDCd3iBPneuPSFX3ltzrMGZ5gCo+3wJhLBwIGM0Il5vsuIG2
	Uws1cy9Tc84QF9Xr6efU8lLRworikNSduhM6M5dfR6r8iDFU+um0UKYSClocPBLR
	U5ySJHKRDQn8KP7JSmOxbV7mLUKS6IrikwDK6od3IavPA0+lieFXh1mbMGliBiO0
	QF5hIFgyCeWEyAhhCAEQbDt/Ib16UgGoEW5SCyJhhJi5Iqi2KwE4LVviYTzzaRxl
	Y4VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698153087; x=1698239487; bh=bck707V/CsZyX
	nCQfr89GqMdUZnpBV6/h5yw4vkUKOM=; b=rMEO6iZPJlz7dae+9SkQ1NhLNSoP/
	aN2XVhxlKlXOKAbmrjyRs1AOrxLZh6rJLVKPTssKLaTKc8b7ZJo4GIXlDUynwo6j
	/g5OukptVBcO80/kdCTEGHzBG2+zjrMFXJqRzumRz+VX//BRFRxBzJ6o7c9FGpae
	rS0cdw/363CYEeydBTvdp2jxw5DnTgPNhanDayBS393Su4WP3o4cYnJnauS6meQk
	stJt7AAl/rRffnMxu42fGvGb2kg2YwtVfoSPtWNIk8ynEwN5JNPdlCT5qCeC98I/
	tIPkKAac+GWk8XpZRkkA+D+q8jKnMjxeq4SoT9aSvZglTpz09s6NgTyPw==
X-ME-Sender: <xms:f8I3Zcf-Tj-YPZ3U3BbIGVP8_cgAK4O-6LaqCpkH7el9UklTQAo-ug>
    <xme:f8I3ZeNg86bBKIeBll2b4grtiISiNzdWjTl89-ccPM3Blq_xn_COXlDrui1G-jF6S
    yC4_G27yJeGjiOY8A>
X-ME-Received: <xmr:f8I3ZdiKUOGH18hspHe8KKsYJDZfcaie9TS1IaIIwtnHG7n98FWhZduL4JVaM3QfOX10tUDC9CTZwzn2DAX5oPx8rFCRTF7baYERSmdF8Vb3CB8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeekgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:f8I3ZR-aDOCRkgAvaLhKBVbwnjo7LetyhmqJEfWPzX97k4ObZ96QlA>
    <xmx:f8I3ZYs9reqES7HuzksKrqVIua1xX9G8yUqDkoudaGJfjob6w5EIog>
    <xmx:f8I3ZYGyGFjDvXmzSi72KJMync--EJcyLDW5uW-4XESVFjzpnzWg0Q>
    <xmx:f8I3ZR5RcNDwfvTBqZmGXIAsA8DGbzfJozrOOqgcQo0L1uOHL-XaoA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Oct 2023 09:11:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1f441da7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Oct 2023 13:11:21 +0000 (UTC)
Date: Tue, 24 Oct 2023 15:11:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 11/12] builtin/show-ref: add new mode to check for reference
 existence
Message-ID: <2f876e61dd36a8887a1286bb8db9fb6577c55c9b.1698152926.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GQ2AKYwxduX1RlbZ"
Content-Disposition: inline
In-Reply-To: <cover.1698152926.git.ps@pks.im>


--GQ2AKYwxduX1RlbZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While we have multiple ways to show the value of a given reference, we
do not have any way to check whether a reference exists at all. While
commands like git-rev-parse(1) or git-show-ref(1) can be used to check
for reference existence in case the reference resolves to something
sane, neither of them can be used to check for existence in some other
scenarios where the reference does not resolve cleanly:

    - References which have an invalid name cannot be resolved.

    - References to nonexistent objects cannot be resolved.

    - Dangling symrefs can be resolved via git-symbolic-ref(1), but this
      requires the caller to special case existence checks depending on
      whteher or not a reference is symbolic or direct.

Furthermore, git-rev-list(1) and other commands do not let the caller
distinguish easily between an actually missing reference and a generic
error.

Taken together, this gseems like sufficient motivation to introduce a
separate plumbing command to explicitly check for the existence of a
reference without trying to resolve its contents.

This new command comes in the form of `git show-ref --exists`. This
new mode will exit successfully when the reference exists, with a
specific error code of 2 when it does not exist, or with 1 when there
has been a generic error.

Note that the only way to properly implement this command is by using
the internal `refs_read_raw_ref()` function. While the public function
`refs_resolve_ref_unsafe()` can be made to behave in the same way by
passing various flags, it does not provide any way to obtain the errno
with which the reference backend failed when reading the reference. As
such, it becomes impossible for us to distinguish generic errors from
the explicit case where the reference wasn't found.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-show-ref.txt | 11 ++++++
 builtin/show-ref.c             | 47 ++++++++++++++++++++++--
 t/t1403-show-ref.sh            | 67 +++++++++++++++++++++++++++++++++-
 3 files changed, 120 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index ab23e0b62e1..a7e9374bc2b 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 	     [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]]
 	     [--] [<ref>...]
 'git show-ref' --exclude-existing[=3D<pattern>]
+'git show-ref' --exists <ref>
=20
 DESCRIPTION
 -----------
@@ -30,6 +31,10 @@ The `--exclude-existing` form is a filter that does the =
inverse. It reads
 refs from stdin, one ref per line, and shows those that don't exist in
 the local repository.
=20
+The `--exists` form can be used to check for the existence of a single
+references. This form does not verify whether the reference resolves to an
+actual object.
+
 Use of this utility is encouraged in favor of directly accessing files und=
er
 the `.git` directory.
=20
@@ -65,6 +70,12 @@ OPTIONS
 	Aside from returning an error code of 1, it will also print an error
 	message if `--quiet` was not specified.
=20
+--exists::
+
+	Check whether the given reference exists. Returns an error code of 0 if
+	it does, 2 if it is missing, and 128 in case looking up the reference
+	failed with an error other than the reference being missing.
+
 --abbrev[=3D<n>]::
=20
 	Abbreviate the object name.  When using `--hash`, you do
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index d0a32d07404..617e754bbed 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -2,7 +2,7 @@
 #include "config.h"
 #include "gettext.h"
 #include "hex.h"
-#include "refs.h"
+#include "refs/refs-internal.h"
 #include "object-name.h"
 #include "object-store-ll.h"
 #include "object.h"
@@ -18,6 +18,7 @@ static const char * const show_ref_usage[] =3D {
 	   "             [-s | --hash[=3D<n>]] [--abbrev[=3D<n>]]\n"
 	   "             [--] [<ref>...]"),
 	N_("git show-ref --exclude-existing[=3D<pattern>]"),
+	N_("git show-ref --exists <ref>"),
 	NULL
 };
=20
@@ -214,6 +215,41 @@ static int cmd_show_ref__patterns(const struct pattern=
s_options *opts,
 	return 0;
 }
=20
+static int cmd_show_ref__exists(const char **refs)
+{
+	struct strbuf unused_referent =3D STRBUF_INIT;
+	struct object_id unused_oid;
+	unsigned int unused_type;
+	int failure_errno =3D 0;
+	const char *ref;
+	int ret =3D 1;
+
+	if (!refs || !*refs)
+		die("--exists requires a reference");
+	ref =3D *refs++;
+	if (*refs)
+		die("--exists requires exactly one reference");
+
+	if (refs_read_raw_ref(get_main_ref_store(the_repository), ref,
+			      &unused_oid, &unused_referent, &unused_type,
+			      &failure_errno)) {
+		if (failure_errno =3D=3D ENOENT) {
+			error(_("reference does not exist"));
+			ret =3D 2;
+		} else {
+			error(_("failed to look up reference: %s"), strerror(failure_errno));
+		}
+
+		goto out;
+	}
+
+	ret =3D 0;
+
+out:
+	strbuf_release(&unused_referent);
+	return ret;
+}
+
 static int hash_callback(const struct option *opt, const char *arg, int un=
set)
 {
 	struct show_one_options *opts =3D opt->value;
@@ -243,10 +279,11 @@ int cmd_show_ref(int argc, const char **argv, const c=
har *prefix)
 	struct exclude_existing_options exclude_existing_opts =3D {0};
 	struct patterns_options patterns_opts =3D {0};
 	struct show_one_options show_one_opts =3D {0};
-	int verify =3D 0;
+	int verify =3D 0, exists =3D 0;
 	const struct option show_ref_options[] =3D {
 		OPT_BOOL(0, "tags", &patterns_opts.tags_only, N_("only show tags (can be=
 combined with heads)")),
 		OPT_BOOL(0, "heads", &patterns_opts.heads_only, N_("only show heads (can=
 be combined with tags)")),
+		OPT_BOOL(0, "exists", &exists, N_("check for reference existence without=
 resolving")),
 		OPT_BOOL(0, "verify", &verify, N_("stricter reference checking, "
 			    "requires exact ref path")),
 		OPT_HIDDEN_BOOL('h', NULL, &patterns_opts.show_head,
@@ -272,13 +309,15 @@ int cmd_show_ref(int argc, const char **argv, const c=
har *prefix)
 	argc =3D parse_options(argc, argv, prefix, show_ref_options,
 			     show_ref_usage, 0);
=20
-	if ((!!exclude_existing_opts.enabled + !!verify) > 1)
-		die(_("only one of --exclude-existing or --verify can be given"));
+	if ((!!exclude_existing_opts.enabled + !!verify + !!exists) > 1)
+		die(_("only one of --exclude-existing, --exists or --verify can be given=
"));
=20
 	if (exclude_existing_opts.enabled)
 		return cmd_show_ref__exclude_existing(&exclude_existing_opts);
 	else if (verify)
 		return cmd_show_ref__verify(&show_one_opts, argv);
+	else if (exists)
+		return cmd_show_ref__exists(argv);
 	else
 		return cmd_show_ref__patterns(&patterns_opts, &show_one_opts, argv);
 }
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 3a312c8b27c..17eba350ce5 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -197,8 +197,73 @@ test_expect_success 'show-ref --verify with dangling r=
ef' '
 '
=20
 test_expect_success 'show-ref sub-modes are mutually exclusive' '
+	cat >expect <<-EOF &&
+	fatal: only one of --exclude-existing, --exists or --verify can be given
+	EOF
+
 	test_must_fail git show-ref --verify --exclude-existing 2>err &&
-	grep "only one of --exclude-existing or --verify can be given" err
+	test_cmp expect err &&
+
+	test_must_fail git show-ref --verify --exists 2>err &&
+	test_cmp expect err &&
+
+	test_must_fail git show-ref --exclude-existing --exists 2>err &&
+	test_cmp expect err
+'
+
+test_expect_success '--exists with existing reference' '
+	git show-ref --exists refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+'
+
+test_expect_success '--exists with missing reference' '
+	test_expect_code 2 git show-ref --exists refs/heads/does-not-exist
+'
+
+test_expect_success '--exists does not use DWIM' '
+	test_expect_code 2 git show-ref --exists $GIT_TEST_DEFAULT_INITIAL_BRANCH=
_NAME 2>err &&
+	grep "reference does not exist" err
+'
+
+test_expect_success '--exists with HEAD' '
+	git show-ref --exists HEAD
+'
+
+test_expect_success '--exists with bad reference name' '
+	test_when_finished "git update-ref -d refs/heads/bad...name" &&
+	new_oid=3D$(git rev-parse HEAD) &&
+	test-tool ref-store main update-ref msg refs/heads/bad...name $new_oid $Z=
ERO_OID REF_SKIP_REFNAME_VERIFICATION &&
+	git show-ref --exists refs/heads/bad...name
+'
+
+test_expect_success '--exists with arbitrary symref' '
+	test_when_finished "git symbolic-ref -d refs/symref" &&
+	git symbolic-ref refs/symref refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_=
NAME &&
+	git show-ref --exists refs/symref
+'
+
+test_expect_success '--exists with dangling symref' '
+	test_when_finished "git symbolic-ref -d refs/heads/dangling" &&
+	git symbolic-ref refs/heads/dangling refs/heads/does-not-exist &&
+	git show-ref --exists refs/heads/dangling
+'
+
+test_expect_success '--exists with nonexistent object ID' '
+	test-tool ref-store main update-ref msg refs/heads/missing-oid $(test_oid=
 001) $ZERO_OID REF_SKIP_OID_VERIFICATION &&
+	git show-ref --exists refs/heads/missing-oid
+'
+
+test_expect_success '--exists with non-commit object' '
+	tree_oid=3D$(git rev-parse HEAD^{tree}) &&
+	test-tool ref-store main update-ref msg refs/heads/tree ${tree_oid} $ZERO=
_OID REF_SKIP_OID_VERIFICATION &&
+	git show-ref --exists refs/heads/tree
+'
+
+test_expect_success '--exists with directory fails with generic error' '
+	cat >expect <<-EOF &&
+	error: failed to look up reference: Is a directory
+	EOF
+	test_expect_code 1 git show-ref --exists refs/heads 2>err &&
+	test_cmp expect err
 '
=20
 test_done
--=20
2.42.0


--GQ2AKYwxduX1RlbZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmU3wnsACgkQVbJhu7ck
PpRxDg//WcTDzH6ZkD9GSAeWlf4c7n0vFyILISV9aRFNIKqbsgfFCBQkxlFnSVOY
AyCH57nzH+1dSQjAzh/F7NE9lDt+v02ntMMBow405EP47KEsSzneNihykujZnOJu
1Y577DPXgHmQhWPHOOquBCskCXEICtO5ELKJ0GZAP1c5b2EY3HoNzkG9i6ctSCTp
nntxFR1Jq0Ojqv2FXnGWPFmNEpESnNTYwyQ99vnBpNEZOSmQmbm0BPVwxGXiPARn
f8VgVEtyHJ9QvqUB/mNJcb2oLgCKs+43Dj9A1g6g7rdC8vw29u2SdGlOphwyNN9b
vEf44h8liDAyMNEmudR9Vh/qO2xtJYqtrc8+BpiawhGPEZfLuCJubgcJmcGlET2v
kGux3nmcNPqwnWujSEYJRE5yjJyTEA7tXjc+mk7sfRw0JauYS9Hpv+lrCilbhll2
1JSU4uHzDVcdkkc2/TdkHmfdoVj/BPrXSUjBAhnOGL7yvTr9JeUBPVuQ5ePL/suo
HmouxVVHkesDDiWbhxKKGXln7tOMrwphOqjbr2z1mEQqy8m/CySISqOl9+czYg/Q
NgU64vNg0gJh6coQZS3db7GgsniwwTCV49SVLUPOCL02mls1gO0qU0MByK6TZaV2
Ij7t0DrcOr0MRKWh0+0b5aFZZ4ZCaqPthCPOSUwXHFjgVu9p7Tg=
=O7Yj
-----END PGP SIGNATURE-----

--GQ2AKYwxduX1RlbZ--
