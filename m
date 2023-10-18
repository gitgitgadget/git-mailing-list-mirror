Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545518F43
	for <git@vger.kernel.org>; Wed, 18 Oct 2023 05:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mkdk55ZT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j83108Ni"
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5298BA
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 22:35:11 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 0DC223200B3C;
	Wed, 18 Oct 2023 01:35:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 18 Oct 2023 01:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1697607310; x=1697693710; bh=Gn
	ShDaZnENgGK4rT0hfJ9QUT0PufBVYFXRao5LyZgcQ=; b=Mkdk55ZToZ44qPQGye
	hGIY9GZhKWsq/wu7oUu83n4GKmr8b1Zxcr4x8u/6VK/h8RM6/Qsn4/qVNkSwgIEv
	UKtVAursAo/yT2XsLGgJdcbXAfFWIfWuufAZFQ5YzOPMqEcMiU+f4RXRGtg+nrgh
	n8mn/Bq3bYCv/wIqZ9QYTzf6XWmy3A15tnzHrKa8jP4TvxKixXsSkqCEeMCqXxu+
	hJ1LPcaskH3TXmeEVnVeiHjV+fO5NG18nmidUb9aNsL7Jedlh36WTe518F96zlDJ
	DDJojVt3IpIOZeq2NzJvVDNSdjogGrsvL0xPL81SCKFyCrt5PwdLt89PbGZ45VMr
	8THw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1697607310; x=1697693710; bh=GnShDaZnENgGK
	4rT0hfJ9QUT0PufBVYFXRao5LyZgcQ=; b=j83108NiMcJUhwFjUXQcvWhL4v31i
	LML67T12C7idItOkMgz5ixmDVL+zjZ5ti+lm+D5oLICzZM9DYgUdABySm7TdqoyR
	Khgyf2na3wfLOmr1PTBKYMOX5VcAVVtRc439X7k4X8HFtKcIyCyoBrnqmY3ShR3A
	99P0mKRn+ust6dr6nLIwz7duB40vHU00mncPQZqeLAXcxSqYu+DAskhbgCwLKk6A
	n72hbszFTj+tUBPlJD17P9Kmp+HPELtQ74h7Y8tZHyrx3fRTskP4Hvjn5AQKkF6Q
	5klR/oIMScGyXL6cgo1WaEvc+TlorVdD1zipZK+ke6DqCkKS7IObih0JQ==
X-ME-Sender: <xms:jm4vZfj5ICNCXBD8EFovDjs6QnW2anWpDyiOFm_FFppl7L7z7OdRKw>
    <xme:jm4vZcBaNV7GXwFUVa5-UKidjJfNg2x9ZXa1kf_IZMgTJ9RoIb0I87lQ63MdcC2hg
    BlYfJcVvvx2S7RKhA>
X-ME-Received: <xmr:jm4vZfF7oCxJtZ5B92Mjl3ox9lI9d1ohAYAiV-xBRuspBaa8wHGAKZKNH-3dXaSAsXE47a-GYLoVIaDFVLa_sHgZ3UUq1CdPJ3xQHiridJeQAOVe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrjeefgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:jm4vZcS3vrTEv-lvldBPKALA5iaVTRKjvA-heKq1y5oSSZ7qRaCjzA>
    <xmx:jm4vZcwaQusq4VToY5YrEwV0IloRwBW7pTKB7QBeWnRWg45YmH0WvQ>
    <xmx:jm4vZS5NL6zAr6FL8UMmnBDRlpV32YyZH5u-6J8htZAeyGBj5Lacng>
    <xmx:jm4vZSbGzC5BYFTF_HVQVJx2xig9bIVGYIjRbaAf1VnccY_tklAHgg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Oct 2023 01:35:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b8525af4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Oct 2023 05:35:08 +0000 (UTC)
Date: Wed, 18 Oct 2023 07:35:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH 01/11] t: add helpers to test for reference existence
Message-ID: <e947feb1c77f7e9f3c7f983bbe47137fbce42367.1697607222.git.ps@pks.im>
References: <cover.1697607222.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qc1dUeCxbeJYscUd"
Content-Disposition: inline
In-Reply-To: <cover.1697607222.git.ps@pks.im>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--Qc1dUeCxbeJYscUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are two major ways to check for the existence of a reference in
our tests:

    - `git rev-parse --verify` can be used to check for existence of a
      reference. This only works in the case where the reference is well
      formed though and resolves to an actual object ID. This does not
      work with malformed reference names or invalid contents.

    - `test_path_is_file` can be used to check for existence of a loose
      reference if it is known to not resolve to an actual object ID. It
      by necessity reaches into implementation details of the reference
      backend though.

Similarly, there are two equivalent ways to check for the absence of a
reference:

    - `test_must_fail git rev-parse` can be used to check for the
      absence of a reference. It could fail due to a number of reasons
      though, and all of these reasons will be thrown into the same bag
      as an absent reference.

    - `test_path_is_missing` can be used to check explicitly for the
      absence of a loose reference, but again reaches into internal
      implementation details of the reference backend.

So both our tooling to check for the presence and for the absence of
references in tests is lacking as either failure cases are thrown into
the same bag or we need to reach into internal implementation details of
the respective reference backend.

Introduce a new subcommand for our ref-store test helper that explicitly
checks only for the presence or absence of a reference. This addresses
these limitations:

    - We can check for the presence of references with malformed names.

    - We can check for the presence of references that don't resolve.

    - We can explicitly handle the case where a reference is missing by
      special-casing ENOENT errors.

    - We don't need to reach into implementation details of the backend,
      which would allow us to use this helper for the future reftable
      backend.

Next to this subcommand we also provide two wrappers `test_ref_exists`
and `test_ref_missing` that make the helper easier to use.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/README                  |  9 ++++++
 t/helper/test-ref-store.c | 27 +++++++++++++++-
 t/test-lib-functions.sh   | 66 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/t/README b/t/README
index 61080859899..779f7e7dd86 100644
--- a/t/README
+++ b/t/README
@@ -928,6 +928,15 @@ see test-lib-functions.sh for the full list and their =
options.
    committer times to defined state.  Subsequent calls will
    advance the times by a fixed amount.
=20
+ - test_ref_exists <ref>, test_ref_missing <ref>
+
+   Check whether a reference exists or is missing. In contrast to
+   git-rev-parse(1), these helpers also work with invalid reference
+   names and references whose contents are unresolvable. The latter
+   function also distinguishes generic errors from the case where a
+   reference explicitly doesn't exist and is thus safer to use than
+   `test_must_fail git rev-parse`.
+
  - test_commit <message> [<filename> [<contents>]]
=20
    Creates a commit with the given message, committing the given
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 48552e6a9e0..7400f560ab6 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -1,6 +1,6 @@
 #include "test-tool.h"
 #include "hex.h"
-#include "refs.h"
+#include "refs/refs-internal.h"
 #include "setup.h"
 #include "worktree.h"
 #include "object-store-ll.h"
@@ -221,6 +221,30 @@ static int cmd_verify_ref(struct ref_store *refs, cons=
t char **argv)
 	return ret;
 }
=20
+static int cmd_ref_exists(struct ref_store *refs, const char **argv)
+{
+	const char *refname =3D notnull(*argv++, "refname");
+	struct strbuf unused_referent =3D STRBUF_INIT;
+	struct object_id unused_oid;
+	unsigned int unused_type;
+	int failure_errno;
+
+	if (refs_read_raw_ref(refs, refname, &unused_oid, &unused_referent,
+			      &unused_type, &failure_errno)) {
+		/*
+		 * We handle ENOENT separately here such that it is possible to
+		 * distinguish actually-missing references from any kind of
+		 * generic error.
+		 */
+		if (failure_errno =3D=3D ENOENT)
+			return 17;
+		return -1;
+	}
+
+	strbuf_release(&unused_referent);
+	return 0;
+}
+
 static int cmd_for_each_reflog(struct ref_store *refs,
 			       const char **argv UNUSED)
 {
@@ -325,6 +349,7 @@ static struct command commands[] =3D {
 	{ "for-each-ref--exclude", cmd_for_each_ref__exclude },
 	{ "resolve-ref", cmd_resolve_ref },
 	{ "verify-ref", cmd_verify_ref },
+	{ "ref-exists", cmd_ref_exists },
 	{ "for-each-reflog", cmd_for_each_reflog },
 	{ "for-each-reflog-ent", cmd_for_each_reflog_ent },
 	{ "for-each-reflog-ent-reverse", cmd_for_each_reflog_ent_reverse },
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 2f8868caa17..212fddffa96 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -251,6 +251,72 @@ debug () {
 	done
 }
=20
+# Usage: test_ref_exists [options] <ref>
+#   -C <dir>:
+#	Run all git commands in directory <dir>
+#   --refdb <refdb>:
+#	The reference database to run in. One of:
+#		- "main", the main reference database (default).
+#		- "submodule:<submodule>", the reference database of a
+#		  submodule.
+#		- "worktree:<worktree>", the reference database for a
+#		  worktree's per-worktree references.
+#
+# This helper function checks whether a reference exists. Symrefs will not=
 be
+# resolved. Can be used to check references with bad names.
+test_ref_exists () {
+	local indir=3D
+	local refdb=3Dmain
+
+	while test $# !=3D 0
+	do
+		case "$1" in
+		-C)
+			indir=3D"$2"
+			shift
+			;;
+		--refdb)
+			refdb=3D"$2"
+			shift
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done &&
+
+	indir=3D${indir:+"$indir"/} &&
+
+	if test "$#" !=3D 1
+	then
+		BUG "expected exactly one reference"
+	fi &&
+
+	test-tool ${indir:+ -C "$indir"} ref-store "${refdb}" ref-exists "$1"
+}
+
+# Behaves the same as test_ref_exists, except that it checks for the absen=
ce of
+# a reference. This is preferable to `! test_ref_exists` as this function =
is
+# able to distinguish actually-missing references from other, generic erro=
rs.
+test_ref_missing () {
+	test_ref_exists "$@"
+	case "$?" in
+	17)
+		# This is the good case.
+		return 0
+		;;
+	0)
+		echo >&4 "test_ref_missing: reference exists"
+		return 1
+		;;
+	*)
+		echo >&4 "test_ref_missing: generic error"
+		return 1
+		;;
+	esac
+}
+
 # Usage: test_commit [options] <message> [<file> [<contents> [<tag>]]]
 #   -C <dir>:
 #	Run all git commands in directory <dir>
--=20
2.42.0


--Qc1dUeCxbeJYscUd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUvbooACgkQVbJhu7ck
PpRvrw//UuKPwNfhumDXUXQRdqpkau6KEAoqCdaKrmzUkfyL6W00T0Yzg7pSDNYa
jqhjnF4o9Q6qTbGqY+S0lO0mvWP+P/OH+wETyD+4ZdbVk/MpPRVBfAEig1mf8jE4
mFDeBhj3ukdRM3YoMW3bMj742Y68dGAMAy+tk+DLFPClLwnfTXBLFBwKrc9fXHyo
1CXtjgUhV7hHzre5l3rGcn5vFgWRclKx2rCy7sY/gnkrDNIkzbVyJWmJGzXRatar
7zaQ4vQxs66cFdsUSGwH+uJGrigAqzNxDxkvrtoZ/wlxbol72wV04dGIC0tuRQxE
xYXrhhV/pf0cn4XwE0XmPoWb04vXXUcJxRk7n2KS06AHKx94fvrsUPRt1JFnBzwk
rHtr+iRzozxp2ZU6NMGTjhMDSU/ntzgu++2ZGawfJvnesZQr4dzPHsKSRQ2FZSlP
9Fr31yMK5TrAFdaVpyzEENz+wwZC/KGkfibyGQAuDF3gRgQHv4y7+eTaMpXvKQCb
ih23DtmCtG5hhXCXENxO0t8ugurv49aUG8tJ2Lb/njz0Ztm1E9qAK+n7eGShSFcM
mTFcdlSFQuwo5RV9pR7bseGtN03HgJOl+hdVLc/WeyBFIjTxhNlCIIdx+kTTu+eL
WM+fwV+suayIGIuE0NmYn66czx3tuTFIgHQi+pm2MO3qXC/0PIY=
=JN/h
-----END PGP SIGNATURE-----

--Qc1dUeCxbeJYscUd--
