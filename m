From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] i18n: mark all progress lines for translation
Date: Fri, 21 Feb 2014 19:50:18 +0700
Message-ID: <1392987018-16598-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 21 14:47:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGqRy-0007qT-Tj
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 14:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932814AbaBUNqh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Feb 2014 08:46:37 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:40820 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932195AbaBUMuN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 07:50:13 -0500
Received: by mail-pb0-f44.google.com with SMTP id rq2so3432793pbb.3
        for <git@vger.kernel.org>; Fri, 21 Feb 2014 04:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=8C/8iQBkkvje9l8rTNA7uXPd9BnbUFArqg+4Wqzv7pI=;
        b=o9vszY9m0LIPOxuYs2Ik4xAwSOqyxygdgPi/VtuSrgH6EPwyNxHWyTnWol1TMuU+TY
         vnd7Zo24sGFosdqf6F/Efp/ScvyWlnUKqLvrbAj/rwm45qAw8zSuhvfQvJUWW2wX3ECu
         BKB0wuhkqY2I9U17TJu990eGcKxnBAO+ifqqkeP63nSpK5R28hCP5uLkfhKHEF16fu5n
         CJFrPsieDaU9GOjZ3R3+XQDgX5dcUqyiOzHxUrlm5Iy0MhsiCFaV7bAQcYXst04whG6z
         1/iXJSI5U57/jBytXPNrfectLVC60GP17sgdP84Pzv19vbMeigtQNPaY90YQx5FK/ORl
         1rKw==
X-Received: by 10.68.130.169 with SMTP id of9mr8927292pbb.79.1392987012162;
        Fri, 21 Feb 2014 04:50:12 -0800 (PST)
Received: from lanh ([115.73.201.165])
        by mx.google.com with ESMTPSA id it4sm21102466pbc.39.2014.02.21.04.50.09
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Feb 2014 04:50:11 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 21 Feb 2014 19:50:29 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242463>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I can't think of any case that progress lines are for machine. It
 started because of the only local untranslated line in "git clone".
 But I think we should do all at once.

 builtin/fsck.c           | 6 +++---
 builtin/pack-objects.c   | 6 +++---
 builtin/prune-packed.c   | 2 +-
 builtin/prune.c          | 2 +-
 builtin/unpack-objects.c | 2 +-
 diffcore-rename.c        | 2 +-
 progress.c               | 3 ++-
 unpack-trees.c           | 2 +-
 8 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 1affdd5..73afedd 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -144,7 +144,7 @@ static int traverse_reachable(void)
 	unsigned int nr =3D 0;
 	int result =3D 0;
 	if (show_progress)
-		progress =3D start_progress_delay("Checking connectivity", 0, 0, 2);
+		progress =3D start_progress_delay(_("Checking connectivity"), 0, 0, =
2);
 	while (pending.nr) {
 		struct object_array_entry *entry;
 		struct object *obj;
@@ -541,7 +541,7 @@ static void fsck_object_dir(const char *path)
 		fprintf(stderr, "Checking object directory\n");
=20
 	if (show_progress)
-		progress =3D start_progress("Checking object directories", 256);
+		progress =3D start_progress(_("Checking object directories"), 256);
 	for (i =3D 0; i < 256; i++) {
 		static char dir[4096];
 		sprintf(dir, "%s/%02x", path, i);
@@ -670,7 +670,7 @@ int cmd_fsck(int argc, const char **argv, const cha=
r *prefix)
 				total +=3D p->num_objects;
 			}
=20
-			progress =3D start_progress("Checking objects", total);
+			progress =3D start_progress(_("Checking objects"), total);
 		}
 		for (p =3D packed_git; p; p =3D p->next) {
 			/* verify gives error messages itself */
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 541667f..91b8612 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -723,7 +723,7 @@ static void write_pack_file(void)
 	struct object_entry **write_order;
=20
 	if (progress > pack_to_stdout)
-		progress_state =3D start_progress("Writing objects", nr_result);
+		progress_state =3D start_progress(_("Writing objects"), nr_result);
 	written_list =3D xmalloc(nr_objects * sizeof(*written_list));
 	write_order =3D compute_write_order();
=20
@@ -2097,7 +2097,7 @@ static void prepare_pack(int window, int depth)
 	if (nr_deltas && n > 1) {
 		unsigned nr_done =3D 0;
 		if (progress)
-			progress_state =3D start_progress("Compressing objects",
+			progress_state =3D start_progress(_("Compressing objects"),
 							nr_deltas);
 		qsort(delta_list, n, sizeof(*delta_list), type_size_sort);
 		ll_find_deltas(delta_list, n, window+1, depth, &nr_done);
@@ -2576,7 +2576,7 @@ int cmd_pack_objects(int argc, const char **argv,=
 const char *prefix)
 	prepare_packed_git();
=20
 	if (progress)
-		progress_state =3D start_progress("Counting objects", 0);
+		progress_state =3D start_progress(_("Counting objects"), 0);
 	if (!use_internal_rev_list)
 		read_object_list_from_stdin();
 	else {
diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index fcf5fb6..6879468 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -46,7 +46,7 @@ void prune_packed_objects(int opts)
=20
 	strbuf_addstr(&pathname, dir);
 	if (opts & PRUNE_PACKED_VERBOSE)
-		progress =3D start_progress_delay("Removing duplicate objects",
+		progress =3D start_progress_delay(_("Removing duplicate objects"),
 			256, 95, 2);
=20
 	if (pathname.len && pathname.buf[pathname.len - 1] !=3D '/')
diff --git a/builtin/prune.c b/builtin/prune.c
index de43b26..25f1477 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -169,7 +169,7 @@ int cmd_prune(int argc, const char **argv, const ch=
ar *prefix)
 	if (show_progress =3D=3D -1)
 		show_progress =3D isatty(2);
 	if (show_progress)
-		progress =3D start_progress_delay("Checking connectivity", 0, 0, 2);
+		progress =3D start_progress_delay(_("Checking connectivity"), 0, 0, =
2);
=20
 	mark_reachable_objects(&revs, 1, progress);
 	stop_progress(&progress);
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 62ff673..e6856f1 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -480,7 +480,7 @@ static void unpack_all(void)
 	use(sizeof(struct pack_header));
=20
 	if (!quiet)
-		progress =3D start_progress("Unpacking objects", nr_objects);
+		progress =3D start_progress(_("Unpacking objects"), nr_objects);
 	obj_list =3D xcalloc(nr_objects, sizeof(*obj_list));
 	for (i =3D 0; i < nr_objects; i++) {
 		unpack_one(i);
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 6c7a72f..20a5c5d 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -579,7 +579,7 @@ void diffcore_rename(struct diff_options *options)
=20
 	if (options->show_rename_progress) {
 		progress =3D start_progress_delay(
-				"Performing inexact rename detection",
+				_("Performing inexact rename detection"),
 				rename_dst_nr * rename_src_nr, 50, 1);
 	}
=20
diff --git a/progress.c b/progress.c
index 10652b1..261314e 100644
--- a/progress.c
+++ b/progress.c
@@ -9,6 +9,7 @@
  */
=20
 #include "git-compat-util.h"
+#include "gettext.h"
 #include "progress.h"
 #include "strbuf.h"
=20
@@ -220,7 +221,7 @@ struct progress *start_progress(const char *title, =
unsigned total)
=20
 void stop_progress(struct progress **p_progress)
 {
-	stop_progress_msg(p_progress, "done");
+	stop_progress_msg(p_progress, _("done"));
 }
=20
 void stop_progress_msg(struct progress **p_progress, const char *msg)
diff --git a/unpack-trees.c b/unpack-trees.c
index 164354d..9535793 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -204,7 +204,7 @@ static int check_updates(struct unpack_trees_option=
s *o)
 				total++;
 		}
=20
-		progress =3D start_progress_delay("Checking out files",
+		progress =3D start_progress_delay(_("Checking out files"),
 						total, 50, 1);
 		cnt =3D 0;
 	}
--=20
1.9.0.40.gaa8c3ea
