Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBD619450
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 08:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="yp458iTE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MqQJ5Vea"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71864DF
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 01:16:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id AC80F3200905;
	Tue, 31 Oct 2023 04:16:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 31 Oct 2023 04:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1698740218; x=1698826618; bh=lT
	/ust/vfpctKY/9IaZILIiE1YoOur5APIfBpFYGA8M=; b=yp458iTEG65Nglj9y/
	TjD/so+lLCXRZfcWnOwsEeSz4QqQISjVYSipAVoKsrCkl4npT2DC/pTe+69ue4Qp
	Dt+S5xDSESZKhMdvCGHYXX2/QVpzTRJBYd33OUgmFuM0QdHUc0ojjHyykda278ye
	9gcssFZKdELDOuXXTjkazfQC8gC6DsjbU1MZxcdyaDeEmNNz5HE6MFQKOfHEW7Rr
	2LgFybUnBPIDU6oVFoYr1k1VL8BtpGJBKtnK+HognNWkR+aKaAEzLZUYPxKfAfFi
	k9fFHhinT+QGxSdJK05hFfA/h4F/kImNBgNxyIgSjc+a+L9ZPzSN0p8svZAOf+oO
	nJpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698740218; x=1698826618; bh=lT/ust/vfpctK
	Y/9IaZILIiE1YoOur5APIfBpFYGA8M=; b=MqQJ5VeasIqG6KPHknLgpb/xEQMfl
	YK9dykBWK+hOrTq4V2Th51SBV/4/1K1MQfFl8mG3dwjGFMstshgWAbSf19qONn5j
	Mx9O8Eyj53xiu+iiw80NYXQcz5b+MUhDvoJ0//yDseh2ndZ00Y7YlQABsP7xyO1k
	NRnCSoxKXt2DyppG61ncq/SwuV3orvrVqiDo3G/dkqJhibFF1PNxnBsvYgmC+x4f
	92eWm+zJgZJDs3H0Z1avjFERtEGS/nYlGlIMyMQajYzUUxoUvtoyeiGoqZpa5ECc
	bF5KS+R9hdd0Jp75BeOsoEpmhMPcoakHPiUJNyiBgKy0hbiEiOIUB4X1g==
X-ME-Sender: <xms:-rdAZSWdMRaalyJwzC9PcL4xEfKNCLuNfkd-8HLTisjZL5y2J91kxA>
    <xme:-rdAZelCYULbpp8YfhIHmCWOrK0uMOGQURGjEePcyAWy4WXBEN-6RDMnpqqU_sta6
    U03bv02mhnwsP1D9g>
X-ME-Received: <xmr:-rdAZWYrs1k978Eb5caveQkitIEQLKNODemrCY4lPfttjzPnT2LALRcTuPCLBVl-7i7eo9_d93b3io8oq8GIBS8HdRihnrlKNOpsRS-nAf4GeiXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:-rdAZZWKMuVYkx_QOdmllYXQ9qG9-Yl5VHaLT1h6lY0NIe1ibg81WQ>
    <xmx:-rdAZcmjpjL3Hq_pmltHzSPDxRWxHvkeZzumHW68nlvF1I8J-FqrGw>
    <xmx:-rdAZefuTBTWgv2HfqERr_ryaDfIi5zRfC57VJlw-D1nY9esSCM0OA>
    <xmx:-rdAZWiqV0xWfvHEl-yZiCK_Jn8WjQAB7GoRgl_s8N7Ib4QbLDsrJA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 04:16:56 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 071ff43a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Oct 2023 08:16:49 +0000 (UTC)
Date: Tue, 31 Oct 2023 09:16:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v3 11/12] builtin/show-ref: add new mode to check for
 reference existence
Message-ID: <ca5187bb18af9aa37835d2e6b6c17e024fbe6dbf.1698739941.git.ps@pks.im>
References: <cover.1698152926.git.ps@pks.im>
 <cover.1698739941.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P4u8w27bZKz3qgDr"
Content-Disposition: inline
In-Reply-To: <cover.1698739941.git.ps@pks.im>


--P4u8w27bZKz3qgDr
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
      whether or not a reference is symbolic or direct.

Furthermore, git-rev-list(1) and other commands do not let the caller
distinguish easily between an actually missing reference and a generic
error.

Taken together, this seems like sufficient motivation to introduce a
separate plumbing command to explicitly check for the existence of a
reference without trying to resolve its contents.

This new command comes in the form of `git show-ref --exists`. This
new mode will exit successfully when the reference exists, with a
specific exit code of 2 when it does not exist, or with 1 when there
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
 builtin/show-ref.c             | 49 +++++++++++++++++++++++---
 t/t1403-show-ref.sh            | 63 +++++++++++++++++++++++++++++++++-
 3 files changed, 117 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 22f5ebc6a92..8fecc9e80f6 100644
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
+	Check whether the given reference exists. Returns an exit code of 0 if
+	it does, 2 if it is missing, and 1 in case looking up the reference
+	failed with an error other than the reference being missing.
+
 --abbrev[=3D<n>]::
=20
 	Abbreviate the object name.  When using `--hash`, you do
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 460f238a62d..7aac525a878 100644
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
@@ -220,6 +221,41 @@ static int cmd_show_ref__patterns(const struct pattern=
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
+	int ret =3D 0;
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
+			errno =3D failure_errno;
+			error_errno(_("failed to look up reference"));
+			ret =3D 1;
+		}
+
+		goto out;
+	}
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
@@ -249,10 +285,11 @@ int cmd_show_ref(int argc, const char **argv, const c=
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
@@ -278,14 +315,16 @@ int cmd_show_ref(int argc, const char **argv, const c=
har *prefix)
 	argc =3D parse_options(argc, argv, prefix, show_ref_options,
 			     show_ref_usage, 0);
=20
-	if ((!!exclude_existing_opts.enabled + !!verify) > 1)
-		die(_("only one of '%s' or '%s' can be given"),
-		    "--exclude-existing", "--verify");
+	if ((!!exclude_existing_opts.enabled + !!verify + !!exists) > 1)
+		die(_("only one of '%s', '%s' or '%s' can be given"),
+		    "--exclude-existing", "--verify", "--exists");
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
index f1e0388324e..b50ae6fcf11 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -198,10 +198,71 @@ test_expect_success 'show-ref --verify with dangling =
ref' '
=20
 test_expect_success 'show-ref sub-modes are mutually exclusive' '
 	cat >expect <<-EOF &&
-	fatal: only one of ${SQ}--exclude-existing${SQ} or ${SQ}--verify${SQ} can=
 be given
+	fatal: only one of ${SQ}--exclude-existing${SQ}, ${SQ}--verify${SQ} or ${=
SQ}--exists${SQ} can be given
 	EOF
=20
 	test_must_fail git show-ref --verify --exclude-existing 2>err &&
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
 	test_cmp expect err
 '
=20
--=20
2.42.0


--P4u8w27bZKz3qgDr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmVAt/UACgkQVbJhu7ck
PpSjMg/+IO7e+dyL4kpTgk6i92Fl9ECziugt+upuyQZLLEiU+JomaOf9wG7+gDUq
NseR9x+UH5GkVuw8/ioynK6aU+s5TUwsD+GgDVbjhY5U9O0j3W24qRPwcDWkapp/
H7OD6wFS36gsKdOcDuFZfORiIaP7oKCtefcOmknx1LmG2Rez8Po9w5nRNgc072FV
8d91Q7ICRdqwaBOr1VY5sJLzUXQSbhnPoP8jh66IQWfJd0jZS4txZgWnNlXf2i6x
A/dyHQtKG/rESV/tosXQqkeDPkQanllY8mg6VF8qZ88RVupbJUiKi1CSQliCOi/S
1/fzsuUjpMgsKfGPhz6XGSkPkSiDULrZQAK8FYZm3qgw5ZVrvJ+ZUQ1jnjM94kQL
EvGBwya+2hiwKNHiRRwD5z4lUXPNkVz23kYqtQ0jccruACXtSTVj2IeEPFYyE/qw
ZuZAH96pejqrUwhzhmD4YTRYDanF/tLIbfgv9VINW2cPGJ6GEJzQ5H/tYFNb2HLT
OFsYX2+HwvC29AxG66PEsh3fhzXTSnNUqmY+eNb5uByMI0aTHF5FFX/AonB55G2I
AsuZY/130GvWuxfdP3zwlI0gW6E2fKroCjoUQeNpKmm7CiXqBRi1vzldYVMA8412
r+//xE/hHbkqdFo+oEDWg6aQ4tEb9B6T4PYwnDScPae07T9f2O8=
=p7fI
-----END PGP SIGNATURE-----

--P4u8w27bZKz3qgDr--
