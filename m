Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A632737F9
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787505565; cv=none; b=m2IFzXRo+VCXiNvXSi+khR2khkkDDUoiNf2bUgQ6AqZpwmeNE2t8sfw/9c6XG9TYB0UqxGejU8MmxMXetcLJRLU/rzlpe8rvJn8R3mraTkNyH2KHPICzx50/GcFIlPsb1F6QITX43e/AredVKKrlSXnMmsL+vxmZt/COy5j1yK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787505565; c=relaxed/simple;
	bh=r8BzhHLzjiXZkMwkPNEfdukw74jf8shXVaNl7U9ykrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgy3czRY1ldvI9x+Tmb9fjWj8Cz8FIKi2d5KHZkT/RiUSpnvzTfeKm+Fft6qZmv4YszHnosbaPgoyYhf0J+hLgHNxpySrDGgiVxpKobzUUc5wV9wUW3ma3f++aivBFVTR8GkGrHeHzsUpkE4v2IAFF95F9OUvsxOdEpUeutQRAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9wXDSx3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9wXDSx3"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d5655cc850so30890235ad.3
        for <git@vger.kernel.org>; Sun, 23 Aug 2026 10:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787505559; x=1788110359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EbKFuEFgJBaG5hn3Jd+xzPg53O4o8IfcggfcfQP7BXo=;
        b=a9wXDSx3WrBc1IFA8Unky31XhzE3WatXNIWzZqpaEQGt4OG3qJn8XngX9+2YswNqXt
         dyloNpqTdqWeeG3O/EK8ZuyBXFRokISenHCsT4QdCynP6GBX0qZaubE+CxU2ZCV/jXgW
         Lp0kt8pW/OC21ec9An3sc6/X4v512ny4umG4qxgq337d9dZYu+BY0+k4hVs+FgXskvlt
         GBdCGtqwUIfg+cbzofQMVIxICsY+ccfJ0ptwsAG9vxvlW/1ukV/Z/7DZCKM4UePSCUaS
         XFKg+UbGjRuDm6LzsSapkGTmYdHfrKoG2RiuswMb8Wh3k8GIeGjfk8ACGLAKcZSbW/zm
         7rNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787505559; x=1788110359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EbKFuEFgJBaG5hn3Jd+xzPg53O4o8IfcggfcfQP7BXo=;
        b=qwiHjUfuU6O4KJOv2ZGkn3Ntih5eOgc0NvxVdsG7EyooDpaazmNPZrH4VusPpJPBdI
         rgcJCDiNHRQevaTgWnNjFO2H4TndcReRtZWRda4jegmgOt0xMUsL8bvj2+Is8wNMeU2u
         BakhmB1rPfvpHFbjfUs53N0cyVxRulFeRRba8hKxQ39a8jd9k2CRJXfO81yJOFfmtFpv
         R1ZhGnpRBDnfA5rtiUw2iPuHkGn1w4y041VhqlHE3y6UyuMwfMNoLlhg1k1RjtLQUXRM
         TlRKMCKtXaV0cBEDCqP6Yu/ToKXOkSciEjlrXZvD1RVTyS2tcDQMTkDNibf1i02zEEme
         +mIg==
X-Gm-Message-State: AFuF++kZ1PRA9kIeBB3tBZxeW1jvhPk3iuX8r45bwRJq89AWsQjEgc/W
	FdWCnYaPPEZf2dWTSvQUFDH5QxBu7uUd3HztigAplTN8H6O8tEo3bVZXa4MHKA==
X-Gm-Gg: AR+sD10lnZVbHKWvRJeR98zMrLVRqi/4bW6EZTZoxCmBZNrQM4hazLohO6Nv0hmCVcA
	PeNxYzOjxARmjPQoT4M6xl6q/xFVJG8vR6KWZB175kiKO9boGN+o2tiyJdIXPQK2N7Y5a9w3W1S
	UwZBTkYglvAQ+gKAJzVHLLcd9nkwwj7EatUtv53q+OYtDCCejtOTImyH8NW21tDevijcl80CN8o
	iFPn26vPTeazWyPTGiaBkF3A40Ndrwqcfk0AQhU1UAPTxO1S/U2DVJzK47NiCYVIBCYCWDQ+A0D
	PO3d+uddS0aarb19G4ytGKUuOgCEzp4BGaNA71phNl4m7KnZbocM5NPggKPfDjrhu4h7y8QHoFD
	N9BAMPz9Y41LtI141tc3yTwXd/IDPT++ZFkdu2EuR+MfnlzDylP+BAEd5HE0IEn3ZL/IzL/DpPj
	hZzOzuom7wUwkKPvAhvLUawoFtmrLLkWbXm6BoapBSshedgjWc5LdPhPUywFP4rWfuY0CxjuGsZ
	B+Jk2I2fnJvf+NHvg5VJZyezi9xX2526X7V1rv3lhf5YxuE+C2i0ZQyREQHwLvUbyZkTUeJfdGV
	BOb64H9RZLwUEdT+8N69nm33455Mg32Tkw88AFnYne2pdQ==
X-Received: by 2002:a17:903:2b03:b0:2c7:f4bd:91b5 with SMTP id d9443c01a7336-2d64a9b349bmr397038375ad.0.1787505558512;
        Sun, 23 Aug 2026 10:19:18 -0700 (PDT)
Received: from localhost (192-184-169-91.fiber.dynamic.sonic.net. [192.184.169.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f91d37cesm20925886eec.15.2026.08.23.10.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:19:17 -0700 (PDT)
From: Michael Montalbo <mmontalbo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <pks@pks.im>
Subject: [RFC PATCH 01/14] organize: add the git organize builtin
Date: Sun, 23 Aug 2026 10:18:45 -0700
Message-ID: <20260823171915.2662373-2-mmontalbo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260823171915.2662373-1-mmontalbo@gmail.com>
References: <20260823171915.2662373-1-mmontalbo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "git organize", a builtin that reconciles a source tree against a
layout the project declares. A project records where each file belongs,
and git organize reports the files that sit elsewhere and, on request,
moves them into place. As .gitignore declares what stays untracked and
.mailmap declares canonical author names, git organize adds .gitorganize,
which declares the directory a file belongs in.

.gitorganize has three sections. [scope] lists the pathspecs of the files
in scope, one per line; with no [scope] section nothing is in scope.
[layout] is the project's placement map, hand-authored: ordered
"label:value = directory" rules, and a file takes the directory of the
first rule its labels satisfy, so rule order matters. Git lists
role:public = . and role:program = . ahead of the component rules, so an
interface header or a program that also matches a component stays at root.
[labels] records each file's labels, one line per source in scope with its
key=value labels.

"git organize status" reads [labels] and reports the files that sit outside
their directory, the backlog, and a recorded path that no longer exists. It
runs nothing and changes nothing.

"git organize apply" moves each out-of-place file into its directory as one
git apply --index transaction; a content-identical rename lets git log
--follow and git blame track the file. It stages the result and repoints
each moved file's [labels] line to its new path.

The .gitorganize reader and writer live in organize/gitorganize-format.c;
the engine that plans and applies the moves lives in organize/organize.c.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 .gitignore                      |   1 +
 Documentation/git-organize.adoc |  82 ++++++++
 Documentation/meson.build       |   1 +
 Makefile                        |   3 +
 builtin.h                       |   1 +
 builtin/organize.c              | 110 +++++++++++
 command-list.txt                |   1 +
 git.c                           |   1 +
 meson.build                     |   3 +
 organize/gitorganize-format.c   | 261 ++++++++++++++++++++++++++
 organize/gitorganize-format.h   |  38 ++++
 organize/organize.c             | 320 ++++++++++++++++++++++++++++++++
 organize/organize.h             |  77 ++++++++
 t/meson.build                   |   1 +
 t/t0096-organize.sh             | 185 ++++++++++++++++++
 15 files changed, 1085 insertions(+)
 create mode 100644 Documentation/git-organize.adoc
 create mode 100644 builtin/organize.c
 create mode 100644 organize/gitorganize-format.c
 create mode 100644 organize/gitorganize-format.h
 create mode 100644 organize/organize.c
 create mode 100644 organize/organize.h
 create mode 100755 t/t0096-organize.sh

diff --git a/.gitignore b/.gitignore
index 4da58c6754..b85ce2b13a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -118,6 +118,7 @@
 /git-mv
 /git-name-rev
 /git-notes
+/git-organize
 /git-p4
 /git-pack-redundant
 /git-pack-objects
diff --git a/Documentation/git-organize.adoc b/Documentation/git-organize.adoc
new file mode 100644
index 0000000000..4ff76f5c13
--- /dev/null
+++ b/Documentation/git-organize.adoc
@@ -0,0 +1,82 @@
+git-organize(1)
+===============
+
+NAME
+----
+git-organize - Reconcile a source tree against a declared layout
+
+
+SYNOPSIS
+--------
+[verse]
+'git organize status'
+'git organize apply'
+
+
+DESCRIPTION
+-----------
+A project declares where each of its files belongs, and git organize
+reports the files that sit elsewhere and, on request, moves them into
+place. As `.gitignore` declares what stays untracked and `.mailmap`
+declares canonical author names, `.gitorganize` declares the directory a
+file belongs in.
+
+`.gitorganize` at the repository root has three sections. `[scope]` names
+the files in scope, one pathspec per line; with no `[scope]` section
+nothing is in scope. `[layout]` is the project's placement map, authored by
+hand: ordered `<label>:<value> = <directory>` rules (`.` is the repository
+root). A file's labels are matched against the rules in order, and the first
+rule it satisfies places it; a file matching no rule is the backlog.
+`[labels]` holds the recorded labels, one line per
+source in scope, `<path> <key>=<value> ...`, with every label the project
+defines. A placed file is listed too, so its `[labels]` line records its
+labels, independently of the directory name. Only a label named in a rule
+places a file.
+
+`git organize status` reads `[labels]` and reports the out-of-place files,
+the backlog, a file in scope that `[labels]` does not record, and a
+recorded path that no longer exists. It runs nothing and
+changes nothing.
+
+`git organize apply` reconciles the tree. It moves each out-of-place file
+into its directory. A move is a content-identical rename, so `git log
+--follow` and `git blame` track the file exactly. apply stages the result
+and repoints each carved file's `[labels]` line to its new path, carrying
+its labels. It commits nothing. apply requires a clean worktree.
+
+
+COMMANDS
+--------
+
+status::
+	Report the files whose placement value names a directory they are not
+	in (the moves), the backlog (recorded files with no matching
+	rule), a file in scope that `[labels]` does not record, and a recorded
+	path that no longer exists. Changes nothing.
+
+apply::
+	Move each out-of-place file into its directory as a content-identical
+	rename, repoint each carved file's `[labels]` line to its new path, and
+	stage the result. apply requires a clean worktree, so the change can be
+	discarded as a whole.
+
+
+FILES
+-----
+`.gitorganize`::
+	The declaration, at the repository root, in three sections. `[scope]`
+	names the files in scope, one pathspec per line; with no `[scope]`
+	section nothing is in scope. `[layout]` is the project's placement map:
+	ordered `<label>:<value> = <directory>` rules (`.` is the root), where a
+	file takes the directory of the first rule its labels satisfy, and a
+	file matching no rule is the backlog. `[labels]` holds the recorded
+	labels, one `<path> <key>=<value> ...` line per source in scope,
+	including placed files. The project writes `[scope]` and `[layout]`; the
+	move apply repoints a carved file's line. A `#` line is a comment; git
+	organize rewrites the file whole, keeping the hand-authored `[scope]`
+	and `[layout]` verbatim.
+
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/meson.build b/Documentation/meson.build
index f4854f802d..8793c927b5 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -98,6 +98,7 @@ manpages = {
   'git-mv.adoc' : 1,
   'git-name-rev.adoc' : 1,
   'git-notes.adoc' : 1,
+  'git-organize.adoc' : 1,
   'git-p4.adoc' : 1,
   'git-pack-objects.adoc' : 1,
   'git-pack-refs.adoc' : 1,
diff --git a/Makefile b/Makefile
index d4b775953d..da7c4df7d3 100644
--- a/Makefile
+++ b/Makefile
@@ -1237,6 +1237,8 @@ LIB_OBJS += oid-array.o
 LIB_OBJS += oidmap.o
 LIB_OBJS += oidset.o
 LIB_OBJS += oidtree.o
+LIB_OBJS += organize/gitorganize-format.o
+LIB_OBJS += organize/organize.o
 LIB_OBJS += pack-bitmap-write.o
 LIB_OBJS += pack-bitmap.o
 LIB_OBJS += pack-check.o
@@ -1465,6 +1467,7 @@ BUILTIN_OBJS += builtin/multi-pack-index.o
 BUILTIN_OBJS += builtin/mv.o
 BUILTIN_OBJS += builtin/name-rev.o
 BUILTIN_OBJS += builtin/notes.o
+BUILTIN_OBJS += builtin/organize.o
 BUILTIN_OBJS += builtin/pack-objects.o
 ifndef WITH_BREAKING_CHANGES
 BUILTIN_OBJS += builtin/pack-redundant.o
diff --git a/builtin.h b/builtin.h
index 4e47a4ebd3..0ac855e534 100644
--- a/builtin.h
+++ b/builtin.h
@@ -224,6 +224,7 @@ int cmd_multi_pack_index(int argc, const char **argv, const char *prefix, struct
 int cmd_mv(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_name_rev(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_notes(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_organize(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_pack_objects(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_pack_redundant(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_patch_id(int argc, const char **argv, const char *prefix, struct repository *repo);
diff --git a/builtin/organize.c b/builtin/organize.c
new file mode 100644
index 0000000000..9462d8687f
--- /dev/null
+++ b/builtin/organize.c
@@ -0,0 +1,110 @@
+/*
+ * "git organize": reconcile a source tree against a declared layout.
+ *
+ * cmd_organize parses arguments and drives the organize engine (organize.c).
+ * status reports the files in scope whose matching rule names a directory they
+ * are not in yet (the moves), the backlog (files with no matching rule), and a
+ * declared path that no longer exists. apply moves the misplaced files and
+ * stages the result.
+ */
+#include "builtin.h"
+#include "gettext.h"
+#include "organize/organize.h"
+#include "parse-options.h"
+#include "repository.h"
+
+static const char *const organize_usage[] = {
+	"git organize status",
+	"git organize apply",
+	NULL
+};
+
+static int organize_status(struct repository *repo)
+{
+	struct organize_plan plan = ORGANIZE_PLAN_INIT;
+	int to_move, backlog, unrecorded, orphans;
+
+	organize_plan_build(repo, &plan);
+	to_move = (int)plan.moves_nr;
+	backlog = (int)plan.backlog.nr;
+	unrecorded = (int)plan.unrecorded.nr;
+	orphans = (int)plan.orphans.nr;
+
+	/*
+	 * A summary over the files in scope: how many are already in place,
+	 * how many move, and how many match no rule.
+	 */
+	if (plan.in_scope)
+		printf(_("organize: %d in scope (%d in place, %d to move, "
+			 "%d backlog)\n"),
+		       plan.in_scope, plan.in_place, to_move, backlog);
+
+	if (to_move) {
+		printf(_("to move:\n"));
+		for (size_t i = 0; i < plan.moves_nr; i++)
+			printf("  %-32s -> %s\n", plan.moves[i].src,
+			       plan.moves[i].dst);
+		printf(_("%d file(s) would move\n"), to_move);
+	} else {
+		printf(_("in place; nothing to move\n"));
+	}
+	if (backlog) {
+		printf(_("backlog:\n"));
+		for (size_t i = 0; i < plan.backlog.nr; i++)
+			printf("  %s\n", plan.backlog.items[i].string);
+	}
+	if (unrecorded) {
+		printf(_("in scope but unrecorded:\n"));
+		for (size_t i = 0; i < plan.unrecorded.nr; i++)
+			printf("  %s\n", plan.unrecorded.items[i].string);
+	}
+	if (orphans) {
+		printf(_("declared but missing:\n"));
+		for (size_t i = 0; i < plan.orphans.nr; i++)
+			printf("  %s\n", plan.orphans.items[i].string);
+	}
+
+	organize_plan_release(&plan);
+	return 0;
+}
+
+static int organize_apply(struct repository *repo)
+{
+	struct organize_plan plan = ORGANIZE_PLAN_INIT;
+
+	organize_plan_build(repo, &plan);
+	if (!plan.moves_nr) {
+		printf(_("organize apply: nothing to do\n"));
+		organize_plan_release(&plan);
+		return 0;
+	}
+
+	organize_plan_apply(repo, &plan);
+
+	printf(_("organize apply: %d move(s).\n"), (int)plan.moves_nr);
+	printf(_("organize apply: the result is staged; nothing is committed.\n"));
+
+	organize_plan_release(&plan);
+	return 0;
+}
+
+int cmd_organize(int argc,
+		 const char **argv,
+		 const char *prefix,
+		 struct repository *repo)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+	const char *subcmd;
+
+	argc = parse_options(argc, argv, prefix, options, organize_usage, 0);
+	subcmd = argc ? argv[0] : "status";
+	if (argc > 1)
+		die(_("git organize: too many arguments"));
+	if (!strcmp(subcmd, "status"))
+		return organize_status(repo);
+	else if (!strcmp(subcmd, "apply"))
+		return organize_apply(repo);
+	die(_("git organize: unknown subcommand '%s'"), subcmd);
+}
diff --git a/command-list.txt b/command-list.txt
index 21b802c420..c9892258f2 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -147,6 +147,7 @@ git-multi-pack-index                    plumbingmanipulators
 git-mv                                  mainporcelain           worktree
 git-name-rev                            plumbinginterrogators
 git-notes                               mainporcelain
+git-organize                            ancillarymanipulators           complete
 git-p4                                  foreignscminterface
 git-pack-objects                        plumbingmanipulators
 git-pack-redundant                      plumbinginterrogators
diff --git a/git.c b/git.c
index e5f1811b6b..cd2d325585 100644
--- a/git.c
+++ b/git.c
@@ -617,6 +617,7 @@ static struct cmd_struct commands[] = {
 	{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
 	{ "name-rev", cmd_name_rev, RUN_SETUP },
 	{ "notes", cmd_notes, RUN_SETUP },
+	{ "organize", cmd_organize, RUN_SETUP | NEED_WORK_TREE },
 	{ "pack-objects", cmd_pack_objects, RUN_SETUP },
 #ifndef WITH_BREAKING_CHANGES
 	{ "pack-redundant", cmd_pack_redundant, RUN_SETUP | NO_PARSEOPT | DEPRECATED },
diff --git a/meson.build b/meson.build
index d86f2acd2b..a2d987b124 100644
--- a/meson.build
+++ b/meson.build
@@ -442,6 +442,8 @@ libgit_sources = [
   'oidmap.c',
   'oidset.c',
   'oidtree.c',
+  'organize/gitorganize-format.c',
+  'organize/organize.c',
   'pack-bitmap-write.c',
   'pack-bitmap.c',
   'pack-check.c',
@@ -677,6 +679,7 @@ builtin_sources = [
   'builtin/mv.c',
   'builtin/name-rev.c',
   'builtin/notes.c',
+  'builtin/organize.c',
   'builtin/pack-objects.c',
   'builtin/pack-refs.c',
   'builtin/patch-id.c',
diff --git a/organize/gitorganize-format.c b/organize/gitorganize-format.c
new file mode 100644
index 0000000000..cdade12f5b
--- /dev/null
+++ b/organize/gitorganize-format.c
@@ -0,0 +1,261 @@
+#include "git-compat-util.h"
+#include "gitorganize-format.h"
+#include "gettext.h"
+#include "quote.h"
+#include "read-cache-ll.h"
+#include "strbuf.h"
+#include "string-list.h"
+#include "wrapper.h"
+
+void gitorganize_clear(struct gitorganize *g)
+{
+	for (size_t i = 0; i < g->rules_nr; i++) {
+		free(g->rules[i].label);
+		free(g->rules[i].value);
+		free(g->rules[i].dir);
+	}
+	FREE_AND_NULL(g->rules);
+	g->rules_nr = g->rules_alloc = 0;
+	strbuf_release(&g->header);
+	string_list_clear(&g->scope, 0);
+	string_list_clear(&g->records, 1);	/* util is an xstrdup'd string */
+}
+
+static void layout_add(struct gitorganize *g, const char *label,
+		       const char *value, const char *dir)
+{
+	struct layout_rule *rule;
+
+	ALLOC_GROW(g->rules, g->rules_nr + 1, g->rules_alloc);
+	rule = &g->rules[g->rules_nr++];
+	rule->label = xstrdup(label);
+	rule->value = xstrdup(value);
+	rule->dir = xstrdup(dir);
+}
+
+/* Read a path token (C-quoted or bare) at `p` into `out`; return its end. */
+const char *read_path_token(const char *p, struct strbuf *out)
+{
+	size_t len;
+
+	strbuf_reset(out);
+	if (*p == '"') {
+		const char *endp;
+		if (unquote_c_style(out, p, &endp))
+			die(_("organize: malformed quoted path"));
+		return endp;
+	}
+	len = strcspn(p, " \t\n");
+	strbuf_add(out, p, len);
+	return p + len;
+}
+
+/*
+ * Copy the value of `key` from the space-separated "k=value ..." string
+ * `labels` into `out`. Return out->buf, or NULL when `key` is absent.
+ */
+static const char *label_value(const char *labels, const char *key,
+			struct strbuf *out)
+{
+	size_t keylen = strlen(key);
+
+	while (*labels) {
+		const char *end = strchrnul(labels, ' ');	/* this token is [labels, end) */
+
+		if (!strncmp(labels, key, keylen) && labels[keylen] == '=') {
+			const char *value = labels + keylen + 1;	/* just past "key=" */
+
+			strbuf_reset(out);
+			strbuf_add(out, value, end - value);
+			return out->buf;
+		}
+		if (!*end)
+			break;		/* that was the last token */
+		labels = end + 1;	/* step over the space to the next */
+	}
+	return NULL;
+}
+
+/*
+ * The first rule a file's labels satisfy, or NULL (the backlog). Rules are
+ * tried in order, so an earlier rule takes precedence.
+ */
+struct layout_rule *layout_match(struct gitorganize *g, const char *labels,
+				 struct strbuf *value_buf)
+{
+	for (size_t i = 0; i < g->rules_nr; i++) {
+		struct layout_rule *rule = &g->rules[i];
+		const char *value = label_value(labels, rule->label, value_buf);
+
+		if (value && !strcmp(value, rule->value))
+			return rule;
+	}
+	return NULL;
+}
+
+/*
+ * Parse a `label:value = directory` [layout] rule and add it to `g`; die on a
+ * malformed rule or an unsafe directory. `line` is the original text, for
+ * error messages.
+ */
+static void parse_layout_rule(struct gitorganize *g, const char *trimmed,
+			      const char *line)
+{
+	const char *equals = strchr(trimmed, '='), *colon;
+	struct strbuf left = STRBUF_INIT, dir = STRBUF_INIT;
+	struct strbuf label = STRBUF_INIT, value = STRBUF_INIT;
+
+	if (!equals)
+		die(_("organize: .gitorganize: [layout] requires "
+		      "'label:value = directory' in: %s"), line);
+	strbuf_add(&left, trimmed, equals - trimmed);
+	strbuf_trim(&left);
+	strbuf_addstr(&dir, equals + 1);
+	strbuf_trim(&dir);
+	while (dir.len && dir.buf[dir.len - 1] == '/')
+		strbuf_setlen(&dir, dir.len - 1);	/* tolerate a trailing slash */
+	colon = strchr(left.buf, ':');
+	if (!colon)
+		die(_("organize: .gitorganize: [layout] requires "
+		      "'label:value = directory' in: %s"), line);
+	strbuf_add(&label, left.buf, colon - left.buf);
+	strbuf_trim(&label);
+	strbuf_addstr(&value, colon + 1);
+	strbuf_trim(&value);
+	if (!label.len || !value.len || !dir.len)
+		die(_("organize: .gitorganize: [layout] requires "
+		      "'label:value = directory' in: %s"), line);
+	if (strcmp(dir.buf, ".") && !verify_path(dir.buf, 0))
+		die(_("organize: .gitorganize: [layout] directory "
+		      "must be inside the tree: %s"), dir.buf);
+	layout_add(g, label.buf, value.buf, dir.buf);
+	strbuf_release(&left);
+	strbuf_release(&dir);
+	strbuf_release(&label);
+	strbuf_release(&value);
+}
+
+/*
+ * Parse .gitorganize into `g`: the [scope] pathspecs (g->scope), the [layout]
+ * rules (g->rules), the verbatim [scope] and [layout] header (g->header, kept
+ * for round-tripping on write), and the [labels] records (g->records, each
+ * path -> its "k=value k=value" string in util). A missing file leaves `g`
+ * empty.
+ */
+void gitorganize_read(struct gitorganize *g)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list lines = STRING_LIST_INIT_NODUP;
+	struct strbuf path = STRBUF_INIT;
+	enum { NONE, SCOPE, LAYOUT, LABELS } section = NONE;
+
+	if (strbuf_read_file(&buf, ".gitorganize", 0) < 0) {
+		strbuf_release(&buf);
+		return;
+	}
+	string_list_split_in_place(&lines, buf.buf, "\n", -1);
+	for (size_t i = 0; i < lines.nr; i++) {
+		char *line = lines.items[i].string;
+		size_t len = strlen(line);
+		const char *trimmed;
+
+		if (len && line[len - 1] == '\r')
+			line[len - 1] = '\0';	/* tolerate CRLF line endings */
+		if (!*line && i + 1 == lines.nr)
+			continue;	/* trailing empty from the final newline */
+		trimmed = line + strspn(line, " \t");
+
+		if (!strcmp(trimmed, "[scope]")) {
+			section = SCOPE;
+			strbuf_addf(&g->header, "%s\n", line);
+			continue;
+		}
+		if (!strcmp(trimmed, "[layout]")) {
+			section = LAYOUT;
+			strbuf_addf(&g->header, "%s\n", line);
+			continue;
+		}
+		if (!strcmp(trimmed, "[labels]")) {
+			section = LABELS;
+			continue;
+		}
+
+		/*
+		 * [scope] and [layout] are hand-authored and round-tripped, so
+		 * every line (comments and blanks included) is kept in the
+		 * header; only a content line feeds the parsed rules.
+		 */
+		if (section == SCOPE || section == LAYOUT) {
+			strbuf_addf(&g->header, "%s\n", line);
+			if (!*trimmed || *trimmed == '#')
+				continue;
+			if (section == SCOPE)
+				string_list_append(&g->scope, trimmed);
+			else
+				parse_layout_rule(g, trimmed, line);
+			continue;
+		}
+
+		if (section == LABELS) {
+			const char *p;
+
+			if (!*trimmed || *trimmed == '#')
+				continue;
+			p = read_path_token(trimmed, &path);
+			if (!path.len)
+				die(_("organize: .gitorganize: [labels] line has "
+				      "no path: %s"), line);
+			/*
+			 * A quoted path token can end mid-line ("a"junk); a
+			 * label list must be set off by whitespace, so require
+			 * whitespace or end-of-line after the path.
+			 */
+			if (*p && *p != ' ' && *p != '\t' && *p != '\n')
+				die(_("organize: .gitorganize: trailing text "
+				      "after path: %s"), line);
+			p += strspn(p, " \t");
+			if (string_list_has_string(&g->records, path.buf))
+				die(_("organize: .gitorganize: '%s' listed twice"),
+				    path.buf);
+			string_list_insert(&g->records, path.buf)->util =
+				xstrdup(p);
+			continue;
+		}
+
+		if (*trimmed && *trimmed != '#')
+			die(_("organize: .gitorganize: line outside "
+			      "[scope]/[layout]/[labels]: %s"), line);
+	}
+	string_list_clear(&lines, 0);
+	strbuf_release(&path);
+	strbuf_release(&buf);
+}
+
+/*
+ * Write .gitorganize from `g`: its verbatim [scope] and [layout] header
+ * (g->header), then the [labels] records (g->records, each path -> its
+ * "k=value k=value" string in util), one `<path> <k=value ...>` line per entry
+ * in the list's sorted order. A path that needs it is C-quoted.
+ */
+void gitorganize_write(struct gitorganize *g)
+{
+	struct strbuf out = STRBUF_INIT;
+
+	if (g->header.len)
+		strbuf_addbuf(&out, &g->header);
+	else
+		strbuf_addstr(&out, "[layout]\n");
+	strbuf_addstr(&out, "[labels]\n");
+	for (size_t i = 0; i < g->records.nr; i++) {
+		const char *labels = g->records.items[i].util;
+
+		quote_c_style(g->records.items[i].string, &out, NULL, 0);
+		if (labels && *labels) {
+			strbuf_addch(&out, ' ');
+			strbuf_addstr(&out, labels);
+		}
+		strbuf_addch(&out, '\n');
+	}
+	write_file_buf(".gitorganize", out.buf, out.len);
+	strbuf_release(&out);
+}
diff --git a/organize/gitorganize-format.h b/organize/gitorganize-format.h
new file mode 100644
index 0000000000..d499545a25
--- /dev/null
+++ b/organize/gitorganize-format.h
@@ -0,0 +1,38 @@
+#ifndef GITORGANIZE_FORMAT_H
+#define GITORGANIZE_FORMAT_H
+
+#include "strbuf.h"
+#include "string-list.h"
+
+struct layout_rule {
+	char *label;
+	char *value;
+	char *dir;
+};
+
+/*
+ * The parsed .gitorganize file: the [scope] pathspecs, the [layout] rules, the
+ * verbatim [scope] and [layout] header (round-tripped on write), and the
+ * [labels] records (each path -> its "k=value ..." string in util).
+ */
+struct gitorganize {
+	struct string_list scope;
+	struct layout_rule *rules;
+	size_t rules_nr, rules_alloc;
+	struct strbuf header;
+	struct string_list records;
+};
+#define GITORGANIZE_INIT { \
+	.scope = STRING_LIST_INIT_DUP, \
+	.header = STRBUF_INIT, \
+	.records = STRING_LIST_INIT_DUP, \
+}
+
+void gitorganize_clear(struct gitorganize *g);
+const char *read_path_token(const char *p, struct strbuf *out);
+struct layout_rule *layout_match(struct gitorganize *g, const char *labels,
+				 struct strbuf *value_buf);
+void gitorganize_read(struct gitorganize *g);
+void gitorganize_write(struct gitorganize *g);
+
+#endif /* GITORGANIZE_FORMAT_H */
diff --git a/organize/organize.c b/organize/organize.c
new file mode 100644
index 0000000000..0d9850dfc0
--- /dev/null
+++ b/organize/organize.c
@@ -0,0 +1,320 @@
+#include "git-compat-util.h"
+#include "organize.h"
+#include "gitorganize-format.h"
+#include "gettext.h"
+#include "pathspec.h"
+#include "quote.h"
+#include "read-cache-ll.h"
+#include "repository.h"
+#include "run-command.h"
+#include "strbuf.h"
+#include "string-list.h"
+#include "strvec.h"
+#include "wrapper.h"
+#include "wt-status.h"
+
+/*
+ * The [layout] rule whose directory equals `path`'s directory, or NULL when
+ * `path` is a root file or its directory matches no rule. A file in a [layout]
+ * directory is in place, whatever its recorded label; its directory alone
+ * tells git organize it is in place.
+ */
+static struct layout_rule *layout_dir_rule(struct gitorganize *g,
+					   const char *path)
+{
+	const char *slash = strrchr(path, '/');
+	size_t dirlen;
+
+	if (!slash)
+		return NULL;		/* a root file */
+	dirlen = slash - path;
+	for (size_t i = 0; i < g->rules_nr; i++) {
+		struct layout_rule *r = &g->rules[i];
+
+		if (strcmp(r->dir, ".") && strlen(r->dir) == dirlen &&
+		    !strncmp(path, r->dir, dirlen))
+			return r;
+	}
+	return NULL;
+}
+
+/*
+ * Read the index once into two lists: every tracked file in `tracked_files`,
+ * and the governed subset in `scoped_files`. A file is governed when it matches
+ * the [scope] pathspecs (a candidate to label and move) or when it already sits
+ * in a [layout] directory (kept in scope so a file added under a carved
+ * directory does not slip in ungoverned). With no [scope] pathspecs and no
+ * [layout] rules, no file is governed.
+ */
+static void collect_index(struct repository *repo, struct gitorganize *g,
+			  struct string_list *scoped_files,
+			  struct string_list *tracked_files)
+{
+	struct pathspec pathspec;
+	struct strvec specs = STRVEC_INIT;
+
+	for (size_t i = 0; i < g->scope.nr; i++)
+		strvec_push(&specs, g->scope.items[i].string);
+	parse_pathspec(&pathspec, 0, PATHSPEC_PREFER_FULL, "", specs.v);
+
+	if (repo_read_index(repo) < 0)
+		die(_("organize: could not read the index"));
+	for (size_t i = 0; i < repo->index->cache_nr; i++) {
+		const char *name = repo->index->cache[i]->name;
+
+		string_list_insert(tracked_files, name);
+		if (g->scope.nr &&
+		    match_pathspec(repo->index, &pathspec, name,
+				   strlen(name), 0, NULL, 0))
+			string_list_insert(scoped_files, name);
+		else if (layout_dir_rule(g, name))
+			string_list_insert(scoped_files, name);
+	}
+	clear_pathspec(&pathspec);
+	strvec_clear(&specs);
+}
+
+/*
+ * The parsed .gitorganize (gitorg) and the tree state that status, apply, and
+ * labeling all read: the files in scope (scoped_files) and every tracked_files
+ * file.
+ */
+struct organize_ctx {
+	struct gitorganize gitorg;
+	struct string_list scoped_files;
+	struct string_list tracked_files;
+};
+#define ORGANIZE_CTX_INIT { \
+	.gitorg = GITORGANIZE_INIT, \
+	.scoped_files = STRING_LIST_INIT_DUP, \
+	.tracked_files = STRING_LIST_INIT_DUP, \
+}
+
+static void organize_ctx_load(struct repository *repo, struct organize_ctx *ctx)
+{
+	gitorganize_read(&ctx->gitorg);
+	collect_index(repo, &ctx->gitorg, &ctx->scoped_files,
+		      &ctx->tracked_files);
+}
+
+static void organize_ctx_release(struct organize_ctx *ctx)
+{
+	gitorganize_clear(&ctx->gitorg);
+	string_list_clear(&ctx->scoped_files, 0);
+	string_list_clear(&ctx->tracked_files, 0);
+}
+
+static void add_move(struct organize_plan *plan, const char *src,
+		     char *dst, const char *value)
+{
+	struct organize_move *m;
+
+	ALLOC_GROW(plan->moves, plan->moves_nr + 1, plan->moves_alloc);
+	m = &plan->moves[plan->moves_nr++];
+	m->src = xstrdup(src);
+	m->dst = dst;
+	m->rule_value = xstrdup(value);
+}
+
+void organize_plan_build(struct repository *repo, struct organize_plan *plan)
+{
+	struct organize_ctx ctx = ORGANIZE_CTX_INIT;
+	struct string_list seen = STRING_LIST_INIT_DUP;
+	struct strbuf value_buf = STRBUF_INIT;
+
+	organize_ctx_load(repo, &ctx);
+
+	/*
+	 * Classify each recorded entry by the rule its labels match. A file
+	 * already in the rule's directory is in place. A file in another
+	 * directory is a move. A file whose labels match no rule is backlog.
+	 */
+	for (size_t i = 0; i < ctx.gitorg.records.nr; i++) {
+		const char *path = ctx.gitorg.records.items[i].string;
+		const char *labels = ctx.gitorg.records.items[i].util;
+		const char *base, *target, *slash;
+		struct layout_rule *rule;
+		struct strbuf dst = STRBUF_INIT;
+
+		if (!string_list_has_string(&ctx.tracked_files, path))
+			continue;	/* an orphan, handled below */
+		string_list_insert(&seen, path);
+		plan->in_scope++;
+
+		rule = layout_match(&ctx.gitorg, labels, &value_buf);
+		if (!rule) {
+			string_list_append(&plan->backlog, path);
+			continue;
+		}
+		target = rule->dir;
+
+		/* the path the rule names: dir/base, or base at the root */
+		slash = strrchr(path, '/');
+		base = slash ? slash + 1 : path;
+		if (!strcmp(target, "."))
+			strbuf_addstr(&dst, base);
+		else
+			strbuf_addf(&dst, "%s/%s", target, base);
+
+		if (!strcmp(dst.buf, path))
+			plan->in_place++;	/* already in place */
+		else
+			add_move(plan, path, strbuf_detach(&dst, NULL), rule->value);
+		strbuf_release(&dst);
+	}
+
+	/*
+	 * The loop above covered every file with a [labels] line. A file in scope
+	 * with no such line falls into one of two groups. A file already in a
+	 * [layout] directory is in place; the tree is truth, so it needs no
+	 * [labels] line. A root file with no line is unrecorded; it is a mismatch
+	 * between the tree and [labels] and does not count toward in_scope, like
+	 * an orphan.
+	 */
+	for (size_t i = 0; i < ctx.scoped_files.nr; i++) {
+		const char *path = ctx.scoped_files.items[i].string;
+
+		if (string_list_has_string(&seen, path))
+			continue;
+		if (layout_dir_rule(&ctx.gitorg, path)) {
+			plan->in_scope++;
+			plan->in_place++;
+		} else {
+			string_list_append(&plan->unrecorded, path);
+		}
+	}
+
+	/* A recorded path that is no longer a tracked_files file is an orphan. */
+	for (size_t i = 0; i < ctx.gitorg.records.nr; i++)
+		if (!string_list_has_string(&ctx.tracked_files, ctx.gitorg.records.items[i].string))
+			string_list_append(&plan->orphans, ctx.gitorg.records.items[i].string);
+
+	organize_ctx_release(&ctx);
+	string_list_clear(&seen, 0);
+	strbuf_release(&value_buf);
+}
+
+/* Whether the worktree has staged or unstaged changes to any tracked file. */
+static int worktree_dirty(struct repository *repo)
+{
+	if (repo_read_index(repo) < 0)
+		die(_("organize: could not read the index"));
+	return has_unstaged_changes(repo, 0) || has_uncommitted_changes(repo, 0);
+}
+
+/* Map each move's src to its dst, in `dst_of`. */
+static void plan_dst_map(struct organize_plan *plan, struct string_list *dst_of)
+{
+	for (size_t i = 0; i < plan->moves_nr; i++)
+		string_list_insert(dst_of, plan->moves[i].src)->util =
+			plan->moves[i].dst;
+}
+
+/* A content-identical rename entry per move. */
+static void build_rename_patch(struct organize_plan *plan, struct strbuf *out)
+{
+	for (size_t i = 0; i < plan->moves_nr; i++) {
+		struct organize_move *m = &plan->moves[i];
+
+		/* These are tracked_files source paths, which need no quoting. */
+		strbuf_addf(out, "diff --git a/%s b/%s\n", m->src, m->dst);
+		strbuf_addstr(out, "similarity index 100%\n");
+		strbuf_addf(out, "rename from %s\n", m->src);
+		strbuf_addf(out, "rename to %s\n", m->dst);
+	}
+}
+
+static int git_apply_index(const char *patch, size_t len)
+{
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	cp.git_cmd = 1;
+	strvec_pushl(&cp.args, "apply", "--index", NULL);
+	return pipe_command(&cp, patch, len, NULL, 0, NULL, 0);
+}
+
+/*
+ * Repoint each carved file's [labels] line to its new path, carrying its labels
+ * unchanged: only its location changes. Returns nonzero when [labels] changed.
+ */
+static int repoint_moved_declarations(struct organize_plan *plan)
+{
+	struct gitorganize g = GITORGANIZE_INIT;
+	struct string_list dst_of = STRING_LIST_INIT_NODUP;
+	struct string_list new_records = STRING_LIST_INIT_DUP;
+	int changed = 0;
+
+	plan_dst_map(plan, &dst_of);
+	gitorganize_read(&g);
+
+	/*
+	 * Rewrite [labels]: an entry whose file moved (found in dst_of) takes
+	 * its new path (dst_of's util) and keeps its labels (the record's util).
+	 */
+	for (size_t i = 0; i < g.records.nr; i++) {
+		const char *path = g.records.items[i].string;
+		const char *labels = g.records.items[i].util;
+		struct string_list_item *moved =
+			string_list_lookup(&dst_of, path);
+
+		if (moved) {
+			path = moved->util;
+			changed = 1;
+		}
+		string_list_insert(&new_records, path)->util = xstrdup(labels);
+	}
+
+	/* Install the rewritten [labels]; gitorganize_clear frees it below. */
+	string_list_clear(&g.records, 1);
+	g.records = new_records;
+	if (changed)
+		gitorganize_write(&g);
+
+	gitorganize_clear(&g);
+	string_list_clear(&dst_of, 0);
+	return changed;
+}
+
+void organize_plan_apply(struct repository *repo, struct organize_plan *plan)
+{
+	struct strbuf patch = STRBUF_INIT;
+
+	if (worktree_dirty(repo))
+		die(_("organize apply: the worktree has uncommitted changes; "
+		      "commit or stash first"));
+
+	/*
+	 * Content-identical renames for every move, applied as one
+	 * git apply --index transaction, so a failure leaves the tree untouched.
+	 */
+	build_rename_patch(plan, &patch);
+	if (patch.len && git_apply_index(patch.buf, patch.len))
+		die(_("organize apply: the change does not apply cleanly; "
+		      "nothing was changed"));
+
+	if (repoint_moved_declarations(plan)) {
+		struct child_process add = CHILD_PROCESS_INIT;
+
+		add.git_cmd = 1;
+		strvec_pushl(&add.args, "add", ".gitorganize", NULL);
+		if (run_command(&add))
+			die(_("organize apply: staging .gitorganize failed; "
+			      "restore with git reset --hard"));
+	}
+
+	strbuf_release(&patch);
+}
+
+void organize_plan_release(struct organize_plan *plan)
+{
+	for (size_t i = 0; i < plan->moves_nr; i++) {
+		free(plan->moves[i].src);
+		free(plan->moves[i].dst);
+		free(plan->moves[i].rule_value);
+	}
+	FREE_AND_NULL(plan->moves);
+	plan->moves_nr = plan->moves_alloc = 0;
+	string_list_clear(&plan->backlog, 0);
+	string_list_clear(&plan->unrecorded, 0);
+	string_list_clear(&plan->orphans, 0);
+}
diff --git a/organize/organize.h b/organize/organize.h
new file mode 100644
index 0000000000..c26453d2be
--- /dev/null
+++ b/organize/organize.h
@@ -0,0 +1,77 @@
+#ifndef ORGANIZE_H
+#define ORGANIZE_H
+
+#include "string-list.h"
+
+struct repository;
+
+/*
+ * The git organize engine. A project declares where each file belongs, and
+ * git organize reconciles the tree against that declaration.
+ *
+ * The committed declaration lives in .gitorganize, a file organize owns, in
+ * three sections:
+ *
+ *   [scope]    the scope pathspecs, one per line; no [scope] section means
+ *     nothing is in scope.
+ *
+ *   [layout]   the project's placement map, hand-authored: ordered
+ *     `<label>:<value> = <directory>` rules (`.` is the root). A file's labels
+ *     are matched against the rules in order, and the first rule it satisfies
+ *     places it; a file matching no rule is backlog. Only a label named in
+ *     a rule places a file.
+ *
+ *   [labels]   the recorded labels, one line per source in scope, `<path> <key>=
+ *     <value> ...`, with every label the project defines. Placed files are listed
+ *     too, so a placed file's [labels] line records its labels, independently of
+ *     the directory name.
+ *
+ *   status  Read [labels] and report the files in scope whose matching rule
+ *     names a directory they are not in yet (the moves), the backlog, and a
+ *     recorded path that no longer exists.
+ *
+ *   apply   Perform the moves. A move is a content-identical rename, applied as
+ *     one git apply --index transaction. A carved file's [labels] line is
+ *     repointed to its new path, carrying its labels.
+ */
+
+struct organize_move {
+	char *src;	/* current path */
+	char *dst;	/* declared path */
+	char *rule_value;	/* the matched rule's value */
+};
+
+struct organize_plan {
+	struct organize_move *moves;
+	size_t moves_nr, moves_alloc;
+	struct string_list backlog;	/* recorded files that match no rule */
+	struct string_list unrecorded;	/* scope files with no [labels] record */
+	struct string_list orphans;	/* declared paths that no longer exist */
+	int in_scope;			/* files in scope */
+	int in_place;			/* files in scope already at their declared location */
+};
+
+#define ORGANIZE_PLAN_INIT { \
+	.backlog = STRING_LIST_INIT_DUP, \
+	.unrecorded = STRING_LIST_INIT_DUP, \
+	.orphans = STRING_LIST_INIT_DUP, \
+}
+
+/*
+ * Read the .gitorganize declaration and record every file whose matching
+ * rule names a directory it is not in as a move. Also record the backlog
+ * (recorded files that match no rule), the unrecorded files (in scope,
+ * no [labels] line), and the orphans (declared paths
+ * that no longer exist).
+ */
+void organize_plan_build(struct repository *repo, struct organize_plan *plan);
+
+/*
+ * Perform the plan: apply the moves as one content-identical-rename
+ * transaction; the result is staged. Requires a clean worktree.
+ */
+void organize_plan_apply(struct repository *repo, struct organize_plan *plan);
+
+void organize_plan_release(struct organize_plan *plan);
+
+#endif /* ORGANIZE_H */
diff --git a/t/meson.build b/t/meson.build
index 2133c840da..fba20fc069 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -127,6 +127,7 @@ integration_tests = [
   't0092-diagnose.sh',
   't0093-verify-cache-df-gap.sh',
   't0095-bloom.sh',
+  't0096-organize.sh',
   't0100-previous.sh',
   't0101-at-syntax.sh',
   't0200-gettext-basic.sh',
diff --git a/t/t0096-organize.sh b/t/t0096-organize.sh
new file mode 100755
index 0000000000..a352a1c7d1
--- /dev/null
+++ b/t/t0096-organize.sh
@@ -0,0 +1,185 @@
+#!/bin/sh
+
+test_description='git organize reconciles a tree against a declared layout'
+
+. ./test-lib.sh
+
+# There is no labeler yet, so tests write .gitorganize by hand: root *.c/*.h in
+# scope, odb/refs components, and a [labels] census.
+write_declaration () {
+	cat >.gitorganize <<-\EOF
+	[scope]
+	:(glob)*.c
+	:(glob)*.h
+	[layout]
+	role:public = .
+	role:program = .
+	component:odb = odb
+	component:refs = refs
+	[labels]
+	blob.c component=odb role=lib
+	header.h component=? role=public
+	refs.c component=refs role=lib
+	EOF
+}
+
+test_expect_success 'setup a tree and a declaration' '
+	echo blob >blob.c &&
+	echo refs >refs.c &&
+	echo header >header.h &&
+	git add . &&
+	git commit -m init &&
+	write_declaration &&
+	git add .gitorganize &&
+	git commit -m declare
+'
+
+test_expect_success 'status reports the files to move' '
+	git organize status >actual &&
+	# header.h is public (in place at root); blob.c and refs.c move next
+	test_grep "organize: 3 in scope (1 in place, 2 to move, 0 backlog)" actual &&
+	test_grep "blob.c  *-> odb/blob.c" actual &&
+	test_grep "refs.c  *-> refs/refs.c" actual &&
+	test_grep ! header.h actual &&
+	test_grep "2 file(s) would move" actual
+'
+
+test_expect_success 'apply moves files as content-identical renames and repoints [labels]' '
+	git organize apply &&
+	git diff --cached -M --name-status >actual &&
+	test_grep "^R100.*blob.c.*odb/blob.c" actual &&
+	test_grep "^R100.*refs.c.*refs/refs.c" actual &&
+	test_path_is_file odb/blob.c &&
+	test_path_is_file refs/refs.c &&
+	test_path_is_file header.h &&
+	test_path_is_missing blob.c &&
+	test_path_is_missing refs.c &&
+	git diff --cached --name-only >staged &&
+	test_grep "^.gitorganize$" staged &&
+	git commit -m reconciled &&
+	git organize status >actual &&
+	test_grep "nothing to move" actual &&
+	test_grep "^odb/blob.c component=odb" .gitorganize &&
+	test_grep "^refs/refs.c component=refs" .gitorganize &&
+	test_grep ! "^blob.c " .gitorganize &&
+	test_grep ! "^refs.c " .gitorganize &&
+	test_grep "^header.h component=? role=public" .gitorganize
+'
+
+test_expect_success 'apply refuses a dirty worktree' '
+	git init dirty &&
+	(
+		cd dirty &&
+		echo blob >blob.c &&
+		echo other >other.c &&
+		git add . &&
+		git commit -m init &&
+		cat >.gitorganize <<-\EOF &&
+		[scope]
+		:(glob)*.c
+		[layout]
+		component:odb = odb
+		[labels]
+		blob.c component=odb
+		other.c component=?
+		EOF
+		git add .gitorganize &&
+		git commit -m declare &&
+		echo dirty >>other.c &&
+		test_must_fail git organize apply 2>err &&
+		test_grep "uncommitted changes" err
+	)
+'
+
+test_expect_success 'a file in scope with no matching rule is backlog' '
+	git init backlog &&
+	(
+		cd backlog &&
+		echo a >a.c &&
+		git add . &&
+		git commit -m init &&
+		cat >.gitorganize <<-\EOF &&
+		[scope]
+		:(glob)*.c
+		[layout]
+		component:odb = odb
+		[labels]
+		a.c component=?
+		EOF
+		git add .gitorganize &&
+		git commit -m declare &&
+		git organize status >actual &&
+		test_grep "backlog" actual &&
+		test_grep "^  a.c$" actual
+	)
+'
+
+test_expect_success 'status reports a declared path that no longer exists' '
+	git init orphan &&
+	(
+		cd orphan &&
+		echo a >a.c &&
+		echo b >b.c &&
+		git add . &&
+		git commit -m init &&
+		cat >.gitorganize <<-\EOF &&
+		[scope]
+		:(glob)*.c
+		[layout]
+		role:public = .
+		[labels]
+		a.c role=public
+		b.c role=public
+		EOF
+		git add .gitorganize &&
+		git commit -m declare &&
+		git rm -q b.c &&
+		git commit -m drop-b &&
+		git organize status >actual &&
+		test_grep "declared but missing" actual &&
+		test_grep "  b.c" actual
+	)
+'
+
+test_expect_success 'status rejects a malformed .gitorganize' '
+	git init bad &&
+	(
+		cd bad &&
+		echo a >a.c &&
+		git add . &&
+		git commit -m init &&
+		cat >.gitorganize <<-\EOF &&
+		[layout]
+		component:odb = odb
+		[labels]
+		a.c component=odb
+		a.c component=odb
+		EOF
+		test_must_fail git organize status 2>err &&
+		test_grep "listed twice" err &&
+		cat >.gitorganize <<-\EOF &&
+		[layout]
+		nocolon = .
+		EOF
+		test_must_fail git organize status 2>err &&
+		test_grep "label:value = directory" err &&
+		cat >.gitorganize <<-\EOF &&
+		[layout]
+		component:x = ../evil
+		EOF
+		test_must_fail git organize status 2>err &&
+		test_grep "must be inside the tree" err &&
+		cat >.gitorganize <<-\EOF &&
+		stray line
+		EOF
+		test_must_fail git organize status 2>err &&
+		test_grep "line outside" err
+	)
+'
+
+test_expect_success 'a subcommand rejects extra operands' '
+	test_must_fail git -C bad organize status junk 2>err &&
+	test_grep "too many arguments" err
+'
+
+test_done
-- 
2.54.0

