From: Phil Hord <hordp@cisco.com>
Subject: [PATCHv2] fix "builtin-*" references to be "builtin/*"
Date: Tue, 18 Jun 2013 13:44:58 -0400
Message-ID: <1371577498-7928-1-git-send-email-hordp@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: phil.hord@gmail.com, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Phil Hord <hordp@cisco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 18 19:45:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uozy5-0002ce-Mj
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 19:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933300Ab3FRRpK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jun 2013 13:45:10 -0400
Received: from rcdn-iport-7.cisco.com ([173.37.86.78]:59137 "EHLO
	rcdn-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933252Ab3FRRpH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 13:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=7200; q=dns/txt; s=iport;
  t=1371577507; x=1372787107;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8wmQFMY1bjeHGHkT8nljYKFy7oQRElDuYLBlgs1v3aY=;
  b=Ro/q3JUpUS7Y6c3kNQhMitktaXHFAmTj5UUrRJsBwAB7SNZPJyFdDKbA
   A2ftuzMsQhTkdkzIzHkfFe9pW483nnrMc/wmiHG1etlHQHSf0fRnuiL3z
   9QQ2SXyIfKmZ8xkZXBl6BR5Ish+SlB5pMV9ldhPLJpycVzkxYFesqBFk7
   c=;
X-IronPort-AV: E=Sophos;i="4.87,890,1363132800"; 
   d="scan'208";a="224356094"
Received: from rcdn-core2-6.cisco.com ([173.37.113.193])
  by rcdn-iport-7.cisco.com with ESMTP; 18 Jun 2013 17:45:06 +0000
Received: from ipsn-lnx-hordp.cisco.com (dhcp-64-100-104-84.cisco.com [64.100.104.84])
	by rcdn-core2-6.cisco.com (8.14.5/8.14.5) with ESMTP id r5IHj6m3007861;
	Tue, 18 Jun 2013 17:45:06 GMT
X-Mailer: git-send-email 1.8.3.1.560.gb7ca476.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228287>

Documentation and some comments still refer to files in builtin/
as 'builtin-*.[cho]'.  Update these to show the correct location.

Signed-off-by: Phil Hord <hordp@cisco.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Assisted-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-log.txt                     |  4 ++--
 Documentation/technical/api-builtin.txt       |  2 +-
 Documentation/technical/api-parse-options.txt | 12 ++++++------
 Documentation/user-manual.txt                 | 13 +++++++------
 builtin/help.c                                |  2 --
 builtin/notes.c                               |  2 +-
 builtin/replace.c                             |  2 +-
 transport.c                                   |  2 +-
 transport.h                                   |  2 +-
 9 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 4687fe8..2ea79ba 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -128,9 +128,9 @@ Examples
 	in the "release" branch, along with the list of paths
 	each commit modifies.
=20
-`git log --follow builtin-rev-list.c`::
+`git log --follow builtin/rev-list.c`::
=20
-	Shows the commits that changed builtin-rev-list.c, including
+	Shows the commits that changed builtin/rev-list.c, including
 	those commits that occurred before the file was given its
 	present name.
=20
diff --git a/Documentation/technical/api-builtin.txt b/Documentation/te=
chnical/api-builtin.txt
index 4a4228b..f3c1357 100644
--- a/Documentation/technical/api-builtin.txt
+++ b/Documentation/technical/api-builtin.txt
@@ -39,7 +39,7 @@ where options is the bitwise-or of:
 	on bare repositories.
 	This only makes sense when `RUN_SETUP` is also set.
=20
-. Add `builtin-foo.o` to `BUILTIN_OBJS` in `Makefile`.
+. Add `builtin/foo.o` to `BUILTIN_OBJS` in `Makefile`.
=20
 Additionally, if `foo` is a new command, there are 3 more things to do=
:
=20
diff --git a/Documentation/technical/api-parse-options.txt b/Documentat=
ion/technical/api-parse-options.txt
index 1317db4..0be2b51 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -275,10 +275,10 @@ Examples
 --------
=20
 See `test-parse-options.c` and
-`builtin-add.c`,
-`builtin-clone.c`,
-`builtin-commit.c`,
-`builtin-fetch.c`,
-`builtin-fsck.c`,
-`builtin-rm.c`
+`builtin/add.c`,
+`builtin/clone.c`,
+`builtin/commit.c`,
+`builtin/fetch.c`,
+`builtin/fsck.c`,
+`builtin/rm.c`
 for real-world examples.
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.=
txt
index e831cc2..2436124 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -4256,15 +4256,16 @@ no longer need to call `setup_pager()` directly=
).
 Nowadays, `git log` is a builtin, which means that it is _contained_ i=
n the
 command `git`.  The source side of a builtin is
=20
-- a function called `cmd_<bla>`, typically defined in `builtin-<bla>.c=
`,
-  and declared in `builtin.h`,
+- a function called `cmd_<bla>`, typically defined in `builtin/<bla.c>=
`
+  (note that older versions of Git used to have it in `builtin-<bla>.c=
`
+  instead), and declared in `builtin.h`.
=20
 - an entry in the `commands[]` array in `git.c`, and
=20
 - an entry in `BUILTIN_OBJECTS` in the `Makefile`.
=20
 Sometimes, more than one builtin is contained in one source file.  For
-example, `cmd_whatchanged()` and `cmd_log()` both reside in `builtin-l=
og.c`,
+example, `cmd_whatchanged()` and `cmd_log()` both reside in `builtin/l=
og.c`,
 since they share quite a bit of code.  In that case, the commands whic=
h are
 _not_ named like the `.c` file in which they live have to be listed in
 `BUILT_INS` in the `Makefile`.
@@ -4287,10 +4288,10 @@ For the sake of clarity, let's stay with `git c=
at-file`, because it
 - is plumbing, and
=20
 - was around even in the initial commit (it literally went only throug=
h
-  some 20 revisions as `cat-file.c`, was renamed to `builtin-cat-file.=
c`
+  some 20 revisions as `cat-file.c`, was renamed to `builtin/cat-file.=
c`
   when made a builtin, and then saw less than 10 versions).
=20
-So, look into `builtin-cat-file.c`, search for `cmd_cat_file()` and lo=
ok what
+So, look into `builtin/cat-file.c`, search for `cmd_cat_file()` and lo=
ok what
 it does.
=20
 ------------------------------------------------------------------
@@ -4366,7 +4367,7 @@ Another example: Find out what to do in order to =
make some script a
 builtin:
=20
 -------------------------------------------------
-$ git log --no-merges --diff-filter=3DA builtin-*.c
+$ git log --no-merges --diff-filter=3DA builtin/*.c
 -------------------------------------------------
=20
 You see, Git is actually the best tool to find out about the source of=
 Git
diff --git a/builtin/help.c b/builtin/help.c
index 062957f..f1e236b 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -1,6 +1,4 @@
 /*
- * builtin-help.c
- *
  * Builtin help command
  */
 #include "cache.h"
diff --git a/builtin/notes.c b/builtin/notes.c
index 57748a6..d9a67d9 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2010 Johan Herland <johan@herland.net>
  *
  * Based on git-notes.sh by Johannes Schindelin,
- * and builtin-tag.c by Kristian H=C3=B8gsberg and Carlos Rica.
+ * and builtin/tag.c by Kristian H=C3=B8gsberg and Carlos Rica.
  */
=20
 #include "cache.h"
diff --git a/builtin/replace.c b/builtin/replace.c
index 398ccd5..59d3115 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2008 Christian Couder <chriscool@tuxfamily.org>
  *
- * Based on builtin-tag.c by Kristian H=C3=B8gsberg <krh@redhat.com>
+ * Based on builtin/tag.c by Kristian H=C3=B8gsberg <krh@redhat.com>
  * and Carlos Rica <jasampler@gmail.com> that was itself based on
  * git-tag.sh and mktag.c by Linus Torvalds.
  */
diff --git a/transport.c b/transport.c
index 359a671..e15db98 100644
--- a/transport.c
+++ b/transport.c
@@ -1232,7 +1232,7 @@ int transport_fetch_refs(struct transport *transp=
ort, struct ref *refs)
 		 * then local and remote refs are likely to still be equal.
 		 * Just feed them all to the fetch method in that case.
 		 * This condition shouldn't be met in a non-deepening fetch
-		 * (see builtin-fetch.c:quickfetch()).
+		 * (see builtin/fetch.c:quickfetch()).
 		 */
 		heads =3D xmalloc(nr_refs * sizeof(*heads));
 		for (rm =3D refs; rm; rm =3D rm->next)
diff --git a/transport.h b/transport.h
index 4edebc5..ea70ea7 100644
--- a/transport.h
+++ b/transport.h
@@ -170,7 +170,7 @@ int transport_connect(struct transport *transport, =
const char *name,
 int transport_helper_init(struct transport *transport, const char *nam=
e);
 int bidirectional_transfer_loop(int input, int output);
=20
-/* common methods used by transport.c and builtin-send-pack.c */
+/* common methods used by transport.c and builtin/send-pack.c */
 void transport_verify_remote_names(int nr_heads, const char **heads);
=20
 void transport_update_tracking_ref(struct remote *remote, struct ref *=
ref, int verbose);
--=20
1.8.3.1.560.gb7ca476.dirty
