From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 33/73] gettextize: git-fetch formatting messages
Date: Tue, 22 Feb 2011 23:41:52 +0000
Message-ID: <1298418152-27789-34-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:46:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1w2-0000rs-Nm
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:46:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755407Ab1BVXoK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:44:10 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39209 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755228Ab1BVXoF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:05 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866615bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ALsxk72xcgeEFzNV4k7gpQ+NjytPLLcuQTPxw3pqG4Q=;
        b=oGGfzmWH2EtD6rQXKzABZtCNtbRMd36gjcu1Gj7gpSTQgzqqdxw0hau/lEf9oX+ZbR
         vmQeu3kZ+4deRYdBh4B5tmL8B2q3XvGpsHP8gOo7GF8a1hrfmD/F4IVIayQzyZyTTuWo
         Ou1rpMF4qpSGWlr/EEX3aENClirMZhwSlRdWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=h6+HsKe8t6pylcxP4xm+nb9HfFn66SRxeGIGmkDtVrUUPLx9jcbqXl8J111uOMvC1m
         cQV1JPR7ecR9tKKm6KHI9IPRL9Hfn+cqKVNV8/3hjtS5j2amawyWPMrLaxXRJ+1/EhCo
         zxIqfa7xFSuhhCykvDQQQW9r5VQMrMJiaO8RE=
Received: by 10.204.45.86 with SMTP id d22mr324476bkf.8.1298418244275;
        Tue, 22 Feb 2011 15:44:04 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.03
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:03 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167629>

Translate some of the formatting messages that appear on git-fetch
showing how branches/tags etc. were updated.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/fetch.c             |   20 ++++++++++----------
 t/t5526-fetch-submodules.sh |   40 ++++++++++++++++++++++++++++++++---=
-----
 2 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index c27c3e9..0a73dff 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -242,7 +242,7 @@ static int update_local_ref(struct ref *ref,
 	if (!hashcmp(ref->old_sha1, ref->new_sha1)) {
 		if (verbosity > 0)
 			sprintf(display, "=3D %-*s %-*s -> %s", TRANSPORT_SUMMARY_WIDTH,
-				"[up to date]", REFCOL_WIDTH, remote,
+				_("[up to date]"), REFCOL_WIDTH, remote,
 				pretty_ref);
 		return 0;
 	}
@@ -255,8 +255,8 @@ static int update_local_ref(struct ref *ref,
 		 * If this is the head, and it's not okay to update
 		 * the head, and the old value of the head isn't empty...
 		 */
-		sprintf(display, "! %-*s %-*s -> %s  (can't fetch in current branch)=
",
-			TRANSPORT_SUMMARY_WIDTH, "[rejected]", REFCOL_WIDTH, remote,
+		sprintf(display, _("! %-*s %-*s -> %s  (can't fetch in current branc=
h)"),
+			TRANSPORT_SUMMARY_WIDTH, _("[rejected]"), REFCOL_WIDTH, remote,
 			pretty_ref);
 		return 1;
 	}
@@ -266,8 +266,8 @@ static int update_local_ref(struct ref *ref,
 		int r;
 		r =3D s_update_ref("updating tag", ref, 0);
 		sprintf(display, "%c %-*s %-*s -> %s%s", r ? '!' : '-',
-			TRANSPORT_SUMMARY_WIDTH, "[tag update]", REFCOL_WIDTH, remote,
-			pretty_ref, r ? "  (unable to update local ref)" : "");
+			TRANSPORT_SUMMARY_WIDTH, _("[tag update]"), REFCOL_WIDTH, remote,
+			pretty_ref, r ? _("  (unable to update local ref)") : "");
 		return r;
 	}
=20
@@ -415,7 +415,7 @@ static int store_updated_refs(const char *raw_url, =
const char *remote_name,
 				 REFCOL_WIDTH, *what ? what : "HEAD");
 		if (*note) {
 			if (verbosity >=3D 0 && !shown_url) {
-				fprintf(stderr, "From %.*s\n",
+				fprintf(stderr, _("From %.*s\n"),
 						url_len, url);
 				shown_url =3D 1;
 			}
@@ -524,16 +524,16 @@ static int prune_refs(struct transport *transport=
, struct ref *ref_map)
 	int result =3D 0;
 	struct ref *ref, *stale_refs =3D get_stale_heads(transport->remote, r=
ef_map);
 	const char *dangling_msg =3D dry_run
-		? "   (%s will become dangling)\n"
-		: "   (%s has become dangling)\n";
+		? _("   (%s will become dangling)\n")
+		: _("   (%s has become dangling)\n");
=20
 	for (ref =3D stale_refs; ref; ref =3D ref->next) {
 		if (!dry_run)
 			result |=3D delete_ref(ref->name, NULL, 0);
 		if (verbosity >=3D 0) {
 			fprintf(stderr, " x %-*s %-*s -> %s\n",
-				TRANSPORT_SUMMARY_WIDTH, "[deleted]",
-				REFCOL_WIDTH, "(none)", prettify_refname(ref->name));
+				TRANSPORT_SUMMARY_WIDTH, _("[deleted]"),
+				REFCOL_WIDTH, _("(none)"), prettify_refname(ref->name));
 			warn_dangling_symref(stderr, dangling_msg, ref->name);
 		}
 	}
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index a5f4585..8f12379 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -66,7 +66,10 @@ test_expect_success "fetch --recurse-submodules recu=
rses into submodules" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
-	) &&
+	)
+'
+
+test_expect_success C_LOCALE_OUTPUT "fetch --recurse-submodules recurs=
es into submodules: output" '
 	test_cmp expect.out actual.out &&
 	test_cmp expect.err actual.err
 '
@@ -95,7 +98,10 @@ test_expect_success "using fetchRecurseSubmodules=3D=
true in .gitmodules recurses i
 		cd downstream &&
 		git config -f .gitmodules submodule.submodule.fetchRecurseSubmodules=
 true &&
 		git fetch >../actual.out 2>../actual.err
-	) &&
+	)
+'
+
+test_expect_success C_LOCALE_OUTPUT "using fetchRecurseSubmodules=3Dtr=
ue in .gitmodules recurses into submodules" '
 	test_cmp expect.out actual.out &&
 	test_cmp expect.err actual.err
 '
@@ -126,7 +132,10 @@ test_expect_success "--recurse-submodules override=
s fetchRecurseSubmodules setti
 		git fetch --recurse-submodules >../actual.out 2>../actual.err &&
 		git config --unset -f .gitmodules submodule.submodule.fetchRecurseSu=
bmodules &&
 		git config --unset submodule.submodule.fetchRecurseSubmodules
-	) &&
+	)
+'
+
+test_expect_success C_LOCALE_OUTPUT "--recurse-submodules overrides fe=
tchRecurseSubmodules setting from .git/config: output" '
 	test_cmp expect.out actual.out &&
 	test_cmp expect.err actual.err
 '
@@ -145,13 +154,22 @@ test_expect_success "--dry-run propagates to subm=
odules" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules --dry-run >../actual.out 2>../actual.=
err
-	) &&
+	)
+'
+
+test_expect_success C_LOCALE_OUTPUT "--dry-run propagates to submodule=
s: output" '
 	test_cmp expect.out actual.out &&
-	test_cmp expect.err actual.err &&
+	test_cmp expect.err actual.err
+'
+
+test_expect_success "Without --dry-run propagates to submodules" '
 	(
 		cd downstream &&
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
-	) &&
+	)
+'
+
+test_expect_success C_LOCALE_OUTPUT "Without --dry-run propagates to s=
ubmodules: output" '
 	test_cmp expect.out actual.out &&
 	test_cmp expect.err actual.err
 '
@@ -162,7 +180,10 @@ test_expect_success "recurseSubmodules=3Dtrue prop=
agates into submodules" '
 		cd downstream &&
 		git config fetch.recurseSubmodules true
 		git fetch >../actual.out 2>../actual.err
-	) &&
+	)
+'
+
+test_expect_success C_LOCALE_OUTPUT "recurseSubmodules=3Dtrue propagat=
es into submodules: output" '
 	test_cmp expect.out actual.out &&
 	test_cmp expect.err actual.err
 '
@@ -176,7 +197,10 @@ test_expect_success "--recurse-submodules override=
s config in submodule" '
 			git config fetch.recurseSubmodules false
 		) &&
 		git fetch --recurse-submodules >../actual.out 2>../actual.err
-	) &&
+	)
+'
+
+test_expect_success C_LOCALE_OUTPUT "--recurse-submodules overrides co=
nfig in submodule: output" '
 	test_cmp expect.out actual.out &&
 	test_cmp expect.err actual.err
 '
--=20
1.7.2.3
