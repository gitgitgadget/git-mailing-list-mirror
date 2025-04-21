Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53066CA5E
	for <git@vger.kernel.org>; Mon, 21 Apr 2025 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745226062; cv=none; b=AaxeibcODUzFvBilxgImR5+5TrlDMgoM1ksxj2kdIlh1u14uz3ARLeOa0Gfv3mv0Xs4jeDRVxCudSpVA48q32UkJSLkyXBcgtirzee/j5JCOEqQWScqynLNkR/NHFomFylx3MXMGJhNlA29n97fNs8uiDiL1+B7H7GWCU+uHSvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745226062; c=relaxed/simple;
	bh=8+apl/TSTPHKYgBaXGZeiLiTxNLfBJXrigmh50xBXQY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CrF/2DGEjubYPAyKBF7BPk4FdArUeVxhUz6nCQPdXu+KE4CNiR74k0Z2FL4ti2GQUuxfD01+bEWIMDiV8DSPe1gfCL44kokFBz0USOc1QNtpjD4KmdtQdNwUwpnvoEYRoJNYM66uodIT7bZEVMuXivGKljlItpOIFTXiuXcAH2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=Jbbm5kBs; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="Jbbm5kBs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202405; t=1745225773;
	bh=8+apl/TSTPHKYgBaXGZeiLiTxNLfBJXrigmh50xBXQY=;
	h=Date:From:To:Cc:Subject:From;
	b=Jbbm5kBsNAebdbVGTu/wGmcFCnSEFxI7Qa8mfkcEbz8idb+0zwZQR1fl1naBt3KVb
	 cBjLojYHOgYOareFdFN/AEbuSI5BUDaRd1rjPOJvWwFCkxwzhmjGwjLVSXSepl2fSl
	 lcLtAFwNtvKuh1dK/Ivmy8RX3t7/Q+7dd3izvnYJuyF439ktCe+dJPvAVmr3Fh3kLp
	 Sdwz2M3MP5tc6wdvUZrx8JDfGC47MiJ6m3cOEUllraQv4YcHmE/KUqmvotsGbzXBI+
	 e6lCpjCpqj5accFEXD61cYNKSYrI9GOxgPQinQRkf1GxzVQgFdD1APcPsbO/xXkcUK
	 lXZK5x1JP7YCg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id A96DAEBCA;
	Mon, 21 Apr 2025 10:56:13 +0200 (CEST)
Date: Mon, 21 Apr 2025 10:56:13 +0200
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: git@vger.kernel.org
Cc: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>, 
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>, Elijah Newren <newren@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Glen Choo <glencbz@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH] Make remaining usage strings and string tables const
Message-ID: <daj53eijkqzsjy5cvuxchea4qm3pbiu673ehetihfffyvwzhgs@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yflk3tivget6v42x"
Content-Disposition: inline
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--yflk3tivget6v42x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 builtin/blame.c                    | 10 +++++-----
 builtin/commit-graph.c             |  4 ++--
 builtin/fast-export.c              |  2 +-
 builtin/mktree.c                   |  2 +-
 builtin/pack-objects.c             |  2 +-
 builtin/show-branch.c              |  2 +-
 t/helper/test-bloom.c              |  2 +-
 t/helper/test-date.c               |  2 +-
 t/helper/test-find-pack.c          |  2 +-
 t/helper/test-getcwd.c             |  2 +-
 t/helper/test-pack-mtimes.c        |  2 +-
 t/helper/test-proc-receive.c       |  2 +-
 t/helper/test-rot13-filter.c       |  2 +-
 t/helper/test-submodule.c          | 10 +++++-----
 t/helper/test-windows-named-pipe.c |  2 +-
 15 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 9436f70aec..682cb0e77b 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -36,17 +36,17 @@
 #include "tag.h"
 #include "write-or-die.h"
=20
-static char blame_usage[] =3D N_("git blame [<options>] [<rev-opts>] [<rev=
>] [--] <file>");
-static char annotate_usage[] =3D N_("git annotate [<options>] [<rev-opts>]=
 [<rev>] [--] <file>");
+static const char blame_usage[] =3D N_("git blame [<options>] [<rev-opts>]=
 [<rev>] [--] <file>");
+static const char annotate_usage[] =3D N_("git annotate [<options>] [<rev-=
opts>] [<rev>] [--] <file>");
=20
-static const char *blame_opt_usage[] =3D {
+static const char *const blame_opt_usage[] =3D {
 	blame_usage,
 	"",
 	N_("<rev-opts> are documented in git-rev-list(1)"),
 	NULL
 };
=20
-static const char *annotate_opt_usage[] =3D {
+static const char *const annotate_opt_usage[] =3D {
 	annotate_usage,
 	"",
 	N_("<rev-opts> are documented in git-rev-list(1)"),
@@ -944,7 +944,7 @@ int cmd_blame(int argc,
 	long anchor;
 	long num_lines =3D 0;
 	const char *str_usage =3D cmd_is_annotate ? annotate_usage : blame_usage;
-	const char **opt_usage =3D cmd_is_annotate ? annotate_opt_usage : blame_o=
pt_usage;
+	const char *const *opt_usage =3D cmd_is_annotate ? annotate_opt_usage : b=
lame_opt_usage;
=20
 	setup_default_color_by_age();
 	git_config(git_blame_config, &output_option);
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 8ca75262c5..a1c1af7f3f 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -22,12 +22,12 @@
 	   "                       [--changed-paths] [--[no-]max-new-filters <n>]=
 [--[no-]progress]\n" \
 	   "                       <split-options>")
=20
-static const char * builtin_commit_graph_verify_usage[] =3D {
+static const char * const builtin_commit_graph_verify_usage[] =3D {
 	BUILTIN_COMMIT_GRAPH_VERIFY_USAGE,
 	NULL
 };
=20
-static const char * builtin_commit_graph_write_usage[] =3D {
+static const char * const builtin_commit_graph_write_usage[] =3D {
 	BUILTIN_COMMIT_GRAPH_WRITE_USAGE,
 	NULL
 };
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 170126d41a..f2f7586418 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -30,7 +30,7 @@
 #include "remote.h"
 #include "blob.h"
=20
-static const char *fast_export_usage[] =3D {
+static const char *const fast_export_usage[] =3D {
 	N_("git fast-export [<rev-list-opts>]"),
 	NULL
 };
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 3c16faa40e..22486963af 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -66,7 +66,7 @@ static void write_tree(struct object_id *oid)
 	strbuf_release(&buf);
 }
=20
-static const char *mktree_usage[] =3D {
+static const char *const mktree_usage[] =3D {
 	"git mktree [-z] [--missing] [--batch]",
 	NULL
 };
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3973267e9e..91bb1260e9 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -183,7 +183,7 @@ static inline void oe_set_delta_size(struct packing_dat=
a *pack,
 #define SET_DELTA_CHILD(obj, val) oe_set_delta_child(&to_pack, obj, val)
 #define SET_DELTA_SIBLING(obj, val) oe_set_delta_sibling(&to_pack, obj, va=
l)
=20
-static const char *pack_usage[] =3D {
+static const char *const pack_usage[] =3D {
 	N_("git pack-objects --stdout [<options>] [< <ref-list> | < <object-list>=
]"),
 	N_("git pack-objects [<options>] <base-name> [< <ref-list> | < <object-li=
st>]"),
 	NULL
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index fce6b404e9..c74b4df7ec 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -19,7 +19,7 @@
 #include "date.h"
 #include "wildmatch.h"
=20
-static const char* show_branch_usage[] =3D {
+static const char*const show_branch_usage[] =3D {
     N_("git show-branch [-a | --all] [-r | --remotes] [--topo-order | --da=
te-order]\n"
        "                [--current] [--color[=3D<when>] | --no-color] [--s=
parse]\n"
        "                [--more=3D<n> | --list | --independent | --merge-b=
ase]\n"
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index 14e075c1a1..9aa2c5a592 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -44,7 +44,7 @@ static void get_bloom_filter_for_commit(const struct obje=
ct_id *commit_oid)
 	print_bloom_filter(filter);
 }
=20
-static const char *bloom_usage =3D "\n"
+static const char *const bloom_usage =3D "\n"
 "  test-tool bloom get_murmur3 <string>\n"
 "  test-tool bloom get_murmur3_seven_highbit\n"
 "  test-tool bloom generate_filter <string> [<string>...]\n"
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index f25512de9a..87d2ad6fca 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -2,7 +2,7 @@
 #include "date.h"
 #include "trace.h"
=20
-static const char *usage_msg =3D "\n"
+static const char *const usage_msg =3D "\n"
 "  test-tool date relative [time_t]...\n"
 "  test-tool date human [time_t]...\n"
 "  test-tool date show:<format> [time_t]...\n"
diff --git a/t/helper/test-find-pack.c b/t/helper/test-find-pack.c
index 85a69a4e55..76c2f4eba8 100644
--- a/t/helper/test-find-pack.c
+++ b/t/helper/test-find-pack.c
@@ -15,7 +15,7 @@
  * packfiles containing the object is not <n>.
  */
=20
-static const char *find_pack_usage[] =3D {
+static const char *const find_pack_usage[] =3D {
 	"test-tool find-pack [--check-count <n>] <object>",
 	NULL
 };
diff --git a/t/helper/test-getcwd.c b/t/helper/test-getcwd.c
index d680038a78..cd4d424079 100644
--- a/t/helper/test-getcwd.c
+++ b/t/helper/test-getcwd.c
@@ -2,7 +2,7 @@
 #include "git-compat-util.h"
 #include "parse-options.h"
=20
-static const char *getcwd_usage[] =3D {
+static const char *const getcwd_usage[] =3D {
 	"test-tool getcwd",
 	NULL
 };
diff --git a/t/helper/test-pack-mtimes.c b/t/helper/test-pack-mtimes.c
index f8f9afbb5b..fb8d919f6b 100644
--- a/t/helper/test-pack-mtimes.c
+++ b/t/helper/test-pack-mtimes.c
@@ -24,7 +24,7 @@ static void dump_mtimes(struct packed_git *p)
 	}
 }
=20
-static const char *pack_mtimes_usage =3D "\n"
+static const char *const pack_mtimes_usage =3D "\n"
 "  test-tool pack-mtimes <pack-name.mtimes>";
=20
 int cmd__pack_mtimes(int argc, const char **argv)
diff --git a/t/helper/test-proc-receive.c b/t/helper/test-proc-receive.c
index 3703f734f3..8eccc34216 100644
--- a/t/helper/test-proc-receive.c
+++ b/t/helper/test-proc-receive.c
@@ -6,7 +6,7 @@
 #include "sigchain.h"
 #include "string-list.h"
=20
-static const char *proc_receive_usage[] =3D {
+static const char *const proc_receive_usage[] =3D {
 	"test-tool proc-receive [<options>]",
 	NULL
 };
diff --git a/t/helper/test-rot13-filter.c b/t/helper/test-rot13-filter.c
index 722b1cbe77..ad37e10034 100644
--- a/t/helper/test-rot13-filter.c
+++ b/t/helper/test-rot13-filter.c
@@ -324,7 +324,7 @@ static void packet_initialize(void)
 	packet_flush(1);
 }
=20
-static const char *rot13_usage[] =3D {
+static const char *const rot13_usage[] =3D {
 	"test-tool rot13-filter [--always-delay] --log=3D<path> <capabilities>",
 	NULL
 };
diff --git a/t/helper/test-submodule.c b/t/helper/test-submodule.c
index 22e518d229..0133852e1e 100644
--- a/t/helper/test-submodule.c
+++ b/t/helper/test-submodule.c
@@ -12,33 +12,33 @@
=20
 #define TEST_TOOL_CHECK_NAME_USAGE \
 	"test-tool submodule check-name"
-static const char *submodule_check_name_usage[] =3D {
+static const char *const submodule_check_name_usage[] =3D {
 	TEST_TOOL_CHECK_NAME_USAGE,
 	NULL
 };
=20
 #define TEST_TOOL_CHECK_URL_USAGE \
 	"test-tool submodule check-url"
-static const char *submodule_check_url_usage[] =3D {
+static const char *const submodule_check_url_usage[] =3D {
 	TEST_TOOL_CHECK_URL_USAGE,
 	NULL
 };
=20
 #define TEST_TOOL_IS_ACTIVE_USAGE \
 	"test-tool submodule is-active <name>"
-static const char *submodule_is_active_usage[] =3D {
+static const char *const submodule_is_active_usage[] =3D {
 	TEST_TOOL_IS_ACTIVE_USAGE,
 	NULL
 };
=20
 #define TEST_TOOL_RESOLVE_RELATIVE_URL_USAGE \
 	"test-tool submodule resolve-relative-url <up_path> <remoteurl> <url>"
-static const char *submodule_resolve_relative_url_usage[] =3D {
+static const char *const submodule_resolve_relative_url_usage[] =3D {
 	TEST_TOOL_RESOLVE_RELATIVE_URL_USAGE,
 	NULL,
 };
=20
-static const char *submodule_usage[] =3D {
+static const char *const submodule_usage[] =3D {
 	TEST_TOOL_CHECK_NAME_USAGE,
 	TEST_TOOL_CHECK_URL_USAGE,
 	TEST_TOOL_IS_ACTIVE_USAGE,
diff --git a/t/helper/test-windows-named-pipe.c b/t/helper/test-windows-nam=
ed-pipe.c
index ae52183e63..bd73784ceb 100644
--- a/t/helper/test-windows-named-pipe.c
+++ b/t/helper/test-windows-named-pipe.c
@@ -3,7 +3,7 @@
 #include "strbuf.h"
=20
 #ifdef GIT_WINDOWS_NATIVE
-static const char *usage_string =3D "<pipe-filename>";
+static const char *const usage_string =3D "<pipe-filename>";
=20
 #define TEST_BUFSIZE (4096)
=20
--=20
2.39.5

--yflk3tivget6v42x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmgGCCkACgkQvP0LAY0m
WPHhBRAAlDYn0We4Z94S/EzUccElYzOIf9MWCRPKfmrsBrCDUarVZtE0N4tGx0cb
CGFduQyWK/oZJsLdZJanQEeyQGDnQ30KPvvvcVcoNDEf75OChCjLjJwT8N6uvqcM
U3bfZJ4j6x7OD0dSc0F2K0eW0DIsFS6Fej6o7hTcdnKxP/QWEbylFgwSDzNZnuwG
ZoQ0b8OjEEfE9THQtBrUO4xoZJLexH33PI3G5cDfrMzH4DHtr7Sn6KNE3U9xxj5d
fP3T6hTBB5K29zTS1dzDt+eJ+lxMZSo2KlLkY0OVC6wVwIKVKtICeu2kGqRFHrsP
225hwYG2SGcx2N7Lhn03nL1nElJS6jsP0x97y6nw1ungXyyRqV/VB7AJcYQd7Kry
yZ0TPpXIkMWR2j/BTBX2E0sjmb8fGtHdzbptVm/ktrXGM6Zd6ZRAuZwV9ks27Edq
QSImwHp/hm6sGvPPL/9h3f+3G8YatcQ9oZJSBex77cOsypJbnl7zyHf9TEIUHDZc
+nElsGQL3XD6S7+dZpMXj7Xylr8YkIsG1ULyVgougnh8tKp53m3r7gzk0x9JKsjV
rIY12YxVYYDzdrnW0OGkq7sNO2CGDOpMZxJ9RNUJxLy1YfHARspX0oZr7ouDS1QF
Tmtg3IXLmpVjBJ6X62dq+5q7K729yUQUiosg0lbxczmbljuJ2Qg=
=VK+g
-----END PGP SIGNATURE-----

--yflk3tivget6v42x--
