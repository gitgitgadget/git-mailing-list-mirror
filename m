Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F302A1FAE2
	for <e@80x24.org>; Tue,  6 Mar 2018 10:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753428AbeCFKmb (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 05:42:31 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33295 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbeCFKm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 05:42:29 -0500
Received: by mail-pf0-f195.google.com with SMTP id q13so8566977pff.0
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 02:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s4RAEv1mglu6AcAfehBk+FkGj0GKYNaLZJclL4dLtuA=;
        b=qvvFBOG/qUWbAuyKnQpsYebQYrFa15SDEceMx8V+iebpCBwhStMKJN1W8WT74YpmFk
         syo3pFwC6c2bwgoDoBU6zsl5uDA6r4LpSckvgNvfXZtkpd+sYe4EcvKNtWkZ2FYB0vX9
         eS2OHNb2ruqZ6VWXmc7cFILXnVKGSDJLbe4fMthLndAXfjo1gqTE8mfYe6CB54NM0dSS
         JVzYnRTu+eRw231mImfDaRVezbgDfSnEsbpwBlEtgCCBr1kFUXS0g2albKJ+OTj2PtLV
         hRJpbOzfo2rquM/xp0G6p1x9NHWO5UjLzpHwIPNYP9th0DPHgxvu3YZz67n/wUhAhURS
         57VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s4RAEv1mglu6AcAfehBk+FkGj0GKYNaLZJclL4dLtuA=;
        b=a4UBJYUZIU9Y6bZ4V4W7RHcVXlJX5Gnq2yiFJBhVo5tXzE5XQSL5QTJnI7or4qCc3x
         l1O1pUfnC/6rNM7clFiTA4GVwPGCYCcx0ZJcNsO0bwZBJOklYqewFybl3V2M7IgLRBsD
         krWzO408IUWs/VWx2poL7XLAdJUaiD54NziWTO8ATcxXRjIk182MtTBDUZIbixpgW3rG
         9Y+TRlj9DttKapwWn20mbkgUj66hTt24TTW2PQNoBPpyUdCzaQNDAxkmRMteg5xadP1r
         526KpMHVK+U5Ev9ctiP7XPTep8g19Cy/cmFkeQBpZi1IHLb70urC9mIczHpPi/r1z3E4
         Lmew==
X-Gm-Message-State: APf1xPBr7ojbWPMZM925NdHSiFNtwv9gmqhCbZj+upvy/c9JtVd6aTqd
        26bqxKpBoWDHxF5NbhQHD18OfA==
X-Google-Smtp-Source: AG47ELvu2t+TpYAsON+QhGsbmFKbcD62D7UWzAA0Dhi54vsDXHVWPhytJr/T1wTcJo6MNS01gF2omg==
X-Received: by 10.99.66.65 with SMTP id p62mr14428567pga.378.1520332949143;
        Tue, 06 Mar 2018 02:42:29 -0800 (PST)
Received: from ash ([27.78.177.129])
        by smtp.gmail.com with ESMTPSA id j13sm30743536pfk.174.2018.03.06.02.42.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Mar 2018 02:42:28 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 06 Mar 2018 17:42:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     e@80x24.org, git@vger.kernel.org, peff@peff.net,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/5] repack: add --keep-pack option
Date:   Tue,  6 Mar 2018 17:41:55 +0700
Message-Id: <20180306104158.6541-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.784.gb291bd247e
In-Reply-To: <20180306104158.6541-1-pclouds@gmail.com>
References: <20180301092046.2769-1-pclouds@gmail.com>
 <20180306104158.6541-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We allow to keep existing packs by having companion .keep files. This
is helpful when a pack is permanently kept. In the next patch, git-gc
just wants to keep a pack temporarily, for one pack-objects
run. git-gc can use --keep-pack for this use case.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-pack-objects.txt |  4 ++++
 Documentation/git-repack.txt       |  4 ++++
 builtin/pack-objects.c             | 31 ++++++++++++++++++++++++++++++
 builtin/repack.c                   | 23 +++++++++++++++++++---
 t/t7700-repack.sh                  | 19 ++++++++++++++++++
 5 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 81bc490ac5..1975477160 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -126,6 +126,10 @@ base-name::
 	has a .keep file to be ignored, even if it would have
 	otherwise been packed.
 
+--keep-pack=<pack name>::
+	Ignore the given pack. This is the equivalent of having
+	`.keep` file on the pack. Implies `--honor-pack-keep`.
+
 --incremental::
 	This flag causes an object already in a pack to be ignored
 	even if it would have otherwise been packed.
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index ae750e9e11..12b073e115 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -133,6 +133,10 @@ other objects in that pack they already have locally.
 	with `-b` or `repack.writeBitmaps`, as it ensures that the
 	bitmapped packfile has the necessary objects.
 
+--keep-pack=<pack name>::
+	Exclude the given pack from repacking. This is the equivalent
+	of having `.keep` file on the pack. Implies `--pack-kept-objects`.
+
 --unpack-unreachable=<when>::
 	When loosening unreachable objects, do not bother loosening any
 	objects older than `<when>`. This can be used to optimize out
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5c674b2843..8e3f870d71 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -28,6 +28,7 @@
 #include "argv-array.h"
 #include "list.h"
 #include "packfile.h"
+#include "dir.h"
 
 static const char *pack_usage[] = {
 	N_("git pack-objects --stdout [<options>...] [< <ref-list> | < <object-list>]"),
@@ -2917,6 +2918,32 @@ static void get_object_list(int ac, const char **av)
 	oid_array_clear(&recent_objects);
 }
 
+static void add_extra_kept_packs(const struct string_list *names)
+{
+	struct packed_git *p;
+
+	if (!names->nr)
+		return;
+
+	prepare_packed_git();
+	for (p = packed_git; p; p = p->next) {
+		const char *name = basename(p->pack_name);
+		int i;
+
+		if (!p->pack_local)
+			continue;
+
+		for (i = 0; i < names->nr; i++) {
+			if (fspathcmp(name, names->items[i].string))
+				continue;
+
+			p->pack_keep = 1;
+			ignore_packed_keep = 1;
+			break;
+		}
+	}
+}
+
 static int option_parse_index_version(const struct option *opt,
 				      const char *arg, int unset)
 {
@@ -2956,6 +2983,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	struct argv_array rp = ARGV_ARRAY_INIT;
 	int rev_list_unpacked = 0, rev_list_all = 0, rev_list_reflog = 0;
 	int rev_list_index = 0;
+	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	struct option pack_objects_options[] = {
 		OPT_SET_INT('q', "quiet", &progress,
 			    N_("do not show progress meter"), 0),
@@ -3022,6 +3050,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("create packs suitable for shallow fetches")),
 		OPT_BOOL(0, "honor-pack-keep", &ignore_packed_keep,
 			 N_("ignore packs that have companion .keep file")),
+		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
+				N_("ignore this pack")),
 		OPT_INTEGER(0, "compression", &pack_compression_level,
 			    N_("pack compression level")),
 		OPT_SET_INT(0, "keep-true-parents", &grafts_replace_parents,
@@ -3150,6 +3180,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		progress = 2;
 
 	prepare_packed_git();
+	add_extra_kept_packs(&keep_pack_list);
 	if (ignore_packed_keep) {
 		struct packed_git *p;
 		for (p = packed_git; p; p = p->next)
diff --git a/builtin/repack.c b/builtin/repack.c
index 7bdb40142f..6a1dade0e1 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -86,7 +86,8 @@ static void remove_pack_on_signal(int signo)
  * have a corresponding .keep or .promisor file. These packs are not to
  * be kept if we are going to pack everything into one file.
  */
-static void get_non_kept_pack_filenames(struct string_list *fname_list)
+static void get_non_kept_pack_filenames(struct string_list *fname_list,
+					const struct string_list *extra_keep)
 {
 	DIR *dir;
 	struct dirent *e;
@@ -97,6 +98,14 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list)
 
 	while ((e = readdir(dir)) != NULL) {
 		size_t len;
+		int i;
+
+		for (i = 0;i < extra_keep->nr; i++)
+			if (!fspathcmp(e->d_name, extra_keep->items[i].string))
+				break;
+		if (extra_keep->nr > 0 && i < extra_keep->nr)
+			continue;
+
 		if (!strip_suffix(e->d_name, ".pack", &len))
 			continue;
 
@@ -148,7 +157,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct string_list rollback = STRING_LIST_INIT_NODUP;
 	struct string_list existing_packs = STRING_LIST_INIT_DUP;
 	struct strbuf line = STRBUF_INIT;
-	int ext, ret, failed;
+	int i, ext, ret, failed;
 	FILE *out;
 
 	/* variables to be filled by option parsing */
@@ -160,6 +169,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	const char *depth = NULL;
 	const char *threads = NULL;
 	const char *max_pack_size = NULL;
+	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	int no_reuse_delta = 0, no_reuse_object = 0;
 	int no_update_server_info = 0;
 	int quiet = 0;
@@ -200,6 +210,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("maximum size of each packfile")),
 		OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
 				N_("repack objects in packs marked with .keep")),
+		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
+				N_("do not repack this pack")),
 		OPT_END()
 	};
 
@@ -215,6 +227,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	    (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE)))
 		die(_("--keep-unreachable and -A are incompatible"));
 
+	if (keep_pack_list.nr && pack_kept_objects > 0)
+		die(_("incompatible --keep-pack and --pack-kept-objects"));
 	if (pack_kept_objects < 0)
 		pack_kept_objects = write_bitmaps;
 
@@ -230,6 +244,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	argv_array_push(&cmd.args, "--keep-true-parents");
 	if (!pack_kept_objects)
 		argv_array_push(&cmd.args, "--honor-pack-keep");
+	for (i = 0; i < keep_pack_list.nr; i++)
+		argv_array_pushf(&cmd.args, "--keep-pack=%s",
+				 keep_pack_list.items[i].string);
 	argv_array_push(&cmd.args, "--non-empty");
 	argv_array_push(&cmd.args, "--all");
 	argv_array_push(&cmd.args, "--reflog");
@@ -254,7 +271,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		argv_array_push(&cmd.args, "--write-bitmap-index");
 
 	if (pack_everything & ALL_INTO_ONE) {
-		get_non_kept_pack_filenames(&existing_packs);
+		get_non_kept_pack_filenames(&existing_packs, &keep_pack_list);
 
 		if (existing_packs.nr && delete_redundant) {
 			if (unpack_unreachable) {
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 38247afbec..553d907d34 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -196,5 +196,24 @@ test_expect_success 'objects made unreachable by grafts only are kept' '
 	git cat-file -t $H1
 '
 
+test_expect_success 'repack --keep-pack' '
+	test_create_repo keep-pack &&
+	(
+		cd keep-pack &&
+		for cmit in one two three four; do
+			test_commit $cmit &&
+			git repack -d
+		done &&
+		( cd .git/objects/pack && ls *.pack ) >pack-list &&
+		test_line_count = 4 pack-list &&
+		KEEP1=`head -n1 pack-list` &&
+		KEEP4=`tail -n1 pack-list` &&
+		git repack -a -d --keep-pack $KEEP1 --keep-pack $KEEP4 &&
+		ls .git/objects/pack/*.pack >new-counts &&
+		test_line_count = 3 new-counts &&
+		git fsck
+	)
+'
+
 test_done
 
-- 
2.16.2.784.gb291bd247e

