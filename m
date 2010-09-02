From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 06/25] gettextize: git-fetch formatting messages
Date: Thu,  2 Sep 2010 19:40:27 +0000
Message-ID: <1283456446-22577-7-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 02 21:41:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrFfX-00061i-Ij
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 21:41:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756555Ab0IBTlj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 15:41:39 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62423 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756249Ab0IBTli (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 15:41:38 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so1282223wwj.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 12:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=l+FnbmUUxYOr6uScZGzh/IJwQwl9JJgyFtwX37CiPdE=;
        b=hMa01pw8rR2ZEfvVe/x/EpQlVIs9nDOfSDak9zRFCHzEJuFfnHxWEW5CYcC59MMAPn
         9UVu7DlVfnoRLBZQb7u6anYY7vGAOdNTS+irsxNje+VonJJFqWWfOPjHpNmRC2o+pbQj
         sUhCrLTDXvMzdRmim1bUEy7h+mem9IeDIBI+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=jSB39JP1TNigq6scWB7pAcgrCNSYwE21jgDbsTkxW8Rt7hazRBxva0YNFpT/CWMWWN
         e7GAPa1z6XxVt3knkBeL2wUH4/b3ywDjZFKPj5GtQz8Y1K3JFxoz1NxM+4sCIAmDlhBX
         RfwUNJkLaAVxLB9ofLkWbB9zxNdUQv2C+71ak=
Received: by 10.227.146.147 with SMTP id h19mr579090wbv.222.1283456483256;
        Thu, 02 Sep 2010 12:41:23 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm701885wbe.17.2010.09.02.12.41.20
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 12:41:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.614.g1dc9
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155167>

Translate some of the formatting messages that appear on git-fetch
showing how branches/tags etc. were updated.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/fetch.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4c90fc5..38bb51d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -236,7 +236,7 @@ static int update_local_ref(struct ref *ref,
 	if (!hashcmp(ref->old_sha1, ref->new_sha1)) {
 		if (verbosity > 0)
 			sprintf(display, "=3D %-*s %-*s -> %s", TRANSPORT_SUMMARY_WIDTH,
-				"[up to date]", REFCOL_WIDTH, remote,
+				_("[up to date]"), REFCOL_WIDTH, remote,
 				pretty_ref);
 		return 0;
 	}
@@ -249,8 +249,8 @@ static int update_local_ref(struct ref *ref,
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
@@ -260,8 +260,8 @@ static int update_local_ref(struct ref *ref,
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
@@ -357,15 +357,15 @@ static int store_updated_refs(const char *raw_url=
, const char *remote_name,
 			what =3D "";
 		}
 		else if (!prefixcmp(rm->name, "refs/heads/")) {
-			kind =3D "branch";
+			kind =3D _("branch");
 			what =3D rm->name + 11;
 		}
 		else if (!prefixcmp(rm->name, "refs/tags/")) {
-			kind =3D "tag";
+			kind =3D _("tag");
 			what =3D rm->name + 10;
 		}
 		else if (!prefixcmp(rm->name, "refs/remotes/")) {
-			kind =3D "remote branch";
+			kind =3D _("remote branch");
 			what =3D rm->name + 13;
 		}
 		else {
@@ -405,11 +405,11 @@ static int store_updated_refs(const char *raw_url=
, const char *remote_name,
 			free(ref);
 		} else
 			sprintf(note, "* %-*s %-*s -> FETCH_HEAD",
-				TRANSPORT_SUMMARY_WIDTH, *kind ? kind : "branch",
+				TRANSPORT_SUMMARY_WIDTH, *kind ? kind : _("branch"),
 				 REFCOL_WIDTH, *what ? what : "HEAD");
 		if (*note) {
 			if (verbosity >=3D 0 && !shown_url) {
-				fprintf(stderr, "From %.*s\n",
+				fprintf(stderr, _("From %.*s\n"),
 						url_len, url);
 				shown_url =3D 1;
 			}
@@ -518,16 +518,16 @@ static int prune_refs(struct transport *transport=
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
--=20
1.7.2.2.614.g1dc9
