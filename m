From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 21/21] Rename field "raw" to "_raw" in struct pathspec
Date: Fri, 11 Jan 2013 18:21:15 +0700
Message-ID: <1357903275-16804-22-git-send-email-pclouds@gmail.com>
References: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 12:23:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttchw-0008G9-RI
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 12:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507Ab3AKLXM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jan 2013 06:23:12 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:49548 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754478Ab3AKLXL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 06:23:11 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so733641dak.33
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 03:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=/cMl5UaXkrmZN+BjspWKbxgRNeHmD71sWBBb2z+iZlk=;
        b=pYH2wviAVyFd1wRkdR2ozgC0iVa9sLD7MXDlN8iwfsiFtqylvdIBpUaCORH95dBuY5
         uGq7ZiE2RfXg/OoXBoVLWAAKYpPMNQ5XABhOsgYpyMvuSH9BaWFK/GltkWDtNycmZZEJ
         XETDxRXsi80lKpNff/2lTFVStwN8FCPIGVcn/1ib3iUT3e1t3T+erTMaiR83se4+goVx
         G7NWNkOYJs1qKFnTh4Yo52xzefD2ZVk35OCOCNrTp5wpVPhkRPKNcjbdoAvzUi82tlUq
         POgTNOEoorjAk5BJhVpzIBL2AF+j1DjoF5eXxxwDZXKzNZ3OBFmgoItOxBcpmiDXrGpR
         Ae2A==
X-Received: by 10.68.213.233 with SMTP id nv9mr227078823pbc.155.1357903390479;
        Fri, 11 Jan 2013 03:23:10 -0800 (PST)
Received: from lanh ([115.74.46.148])
        by mx.google.com with ESMTPS id o6sm2933031paw.37.2013.01.11.03.23.07
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 03:23:09 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 11 Jan 2013 18:23:25 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213214>

This patch is essentially no-op. It helps catching new use of this
field though. This field is introduced as an intermediate step for the
pathspec conversion and will be removed eventually. At this stage no
more access sites should be introduced.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 archive.c          |  2 +-
 builtin/add.c      | 20 ++++++++++----------
 builtin/checkout.c |  2 +-
 builtin/commit.c   |  2 +-
 builtin/ls-files.c |  8 ++++----
 builtin/ls-tree.c  |  2 +-
 builtin/rm.c       |  2 +-
 cache.h            |  2 +-
 dir.c              | 22 +++++++++++-----------
 revision.c         |  4 ++--
 setup.c            |  6 +++---
 tree-diff.c        |  8 ++++----
 12 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/archive.c b/archive.c
index 3caa31f..c52e525 100644
--- a/archive.c
+++ b/archive.c
@@ -229,7 +229,7 @@ static void parse_pathspec_arg(const char **pathspe=
c,
 {
 	parse_pathspec(&ar_args->pathspec, PATHSPEC_FROMTOP, 0, "", pathspec)=
;
 	if (ar_args->pathspec.nr) {
-		pathspec =3D ar_args->pathspec.raw;
+		pathspec =3D ar_args->pathspec._raw;
 		while (*pathspec) {
 			if (!path_exists(ar_args->tree, *pathspec))
 				die("path not found: %s", *pathspec);
diff --git a/builtin/add.c b/builtin/add.c
index 5d262eb..6b6a72e 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -165,7 +165,7 @@ static void refresh(int verbose, const struct paths=
pec *pathspec)
 		      pathspec, seen, _("Unstaged changes after refreshing the index=
:"));
 	for (i =3D 0; i < pathspec->nr; i++) {
 		if (!seen[i])
-			die(_("pathspec '%s' did not match any files"), pathspec->raw[i]);
+			die(_("pathspec '%s' did not match any files"), pathspec->_raw[i]);
 	}
         free(seen);
 }
@@ -387,7 +387,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 		return 0;
 	}
 	parse_pathspec(&pathspec, PATHSPEC_FROMTOP, 0, prefix, argv);
-	validate_pathspec(pathspec.raw, prefix);
+	validate_pathspec(pathspec._raw, prefix);
=20
 	if (read_cache() < 0)
 		die(_("index file corrupt"));
@@ -406,7 +406,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 		/* This picks up the paths that are not tracked */
 		baselen =3D fill_directory(&dir, &pathspec);
 		if (pathspec.nr)
-			seen =3D prune_directory(&dir, pathspec.raw, baselen);
+			seen =3D prune_directory(&dir, pathspec._raw, baselen);
 	}
=20
 	if (refresh_only) {
@@ -420,17 +420,17 @@ int cmd_add(int argc, const char **argv, const ch=
ar *prefix)
=20
 		path_exclude_check_init(&check, &dir);
 		if (!seen)
-			seen =3D find_used_pathspec(pathspec.raw);
-		for (i =3D 0; pathspec.raw[i]; i++) {
-			if (!seen[i] && pathspec.raw[i][0]
-			    && !file_exists(pathspec.raw[i])) {
+			seen =3D find_used_pathspec(pathspec._raw);
+		for (i =3D 0; pathspec._raw[i]; i++) {
+			if (!seen[i] && pathspec._raw[i][0]
+			    && !file_exists(pathspec._raw[i])) {
 				if (ignore_missing) {
 					int dtype =3D DT_UNKNOWN;
-					if (path_excluded(&check, pathspec.raw[i], -1, &dtype))
-						dir_add_ignored(&dir, pathspec.raw[i], strlen(pathspec.raw[i]));
+					if (path_excluded(&check, pathspec._raw[i], -1, &dtype))
+						dir_add_ignored(&dir, pathspec._raw[i], strlen(pathspec._raw[i])=
);
 				} else
 					die(_("pathspec '%s' did not match any files"),
-					    pathspec.raw[i]);
+					    pathspec._raw[i]);
 			}
 		}
 		free(seen);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 648768e..716a949 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -253,7 +253,7 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
=20
 	if (opts->patch_mode)
 		return run_add_interactive(revision, "--patch=3Dcheckout",
-					   opts->pathspec.raw);
+					   opts->pathspec._raw);
=20
 	lock_file =3D xcalloc(1, sizeof(struct lock_file));
=20
diff --git a/builtin/commit.c b/builtin/commit.c
index d79613d..876916c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -192,7 +192,7 @@ static int list_paths(struct string_list *list, con=
st char *with_tree,
 	m =3D xcalloc(1, pattern->nr);
=20
 	if (with_tree) {
-		char *max_prefix =3D common_prefix(pattern->raw);
+		char *max_prefix =3D common_prefix(pattern->_raw);
 		overlay_tree_on_cache(with_tree, max_prefix ? max_prefix : prefix);
 		free(max_prefix);
 	}
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 79949de..e9caa42 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -367,11 +367,11 @@ int report_path_error(const char *ps_matched,
 		 * twice.  Do not barf on such a mistake.
 		 */
 		for (found_dup =3D other =3D 0;
-		     !found_dup && pathspec->raw[other];
+		     !found_dup && pathspec->_raw[other];
 		     other++) {
 			if (other =3D=3D num || !ps_matched[other])
 				continue;
-			if (!strcmp(pathspec->raw[other], pathspec->raw[num]))
+			if (!strcmp(pathspec->_raw[other], pathspec->_raw[num]))
 				/*
 				 * Ok, we have a match already.
 				 */
@@ -380,7 +380,7 @@ int report_path_error(const char *ps_matched,
 		if (found_dup)
 			continue;
=20
-		name =3D quote_path_relative(pathspec->raw[num], -1, &sb, prefix);
+		name =3D quote_path_relative(pathspec->_raw[num], -1, &sb, prefix);
 		error("pathspec '%s' did not match any file(s) known to git.",
 		      name);
 		errors++;
@@ -540,7 +540,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 	strip_trailing_slash_from_submodules(&pathspec);
=20
 	/* Find common prefix for all pathspec's */
-	max_prefix =3D common_prefix(pathspec.raw);
+	max_prefix =3D common_prefix(pathspec._raw);
 	max_prefix_len =3D max_prefix ? strlen(max_prefix) : 0;
=20
 	/* Treat unmatching pathspec elements as errors */
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index a78ba53..ebb587b 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -35,7 +35,7 @@ static int show_recursive(const char *base, int basel=
en, const char *pathname)
 	if (ls_options & LS_RECURSIVE)
 		return 1;
=20
-	s =3D pathspec.raw;
+	s =3D pathspec._raw;
 	if (!s)
 		return 0;
=20
diff --git a/builtin/rm.c b/builtin/rm.c
index b5edde8..d12311c 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -267,7 +267,7 @@ int cmd_rm(int argc, const char **argv, const char =
*prefix)
 	if (pathspec.nr) {
 		const char *match;
 		int seen_any =3D 0;
-		for (i =3D 0; (match =3D pathspec.raw[i]) !=3D NULL ; i++) {
+		for (i =3D 0; (match =3D pathspec._raw[i]) !=3D NULL ; i++) {
 			if (!seen[i]) {
 				if (!ignore_unmatch) {
 					die(_("pathspec '%s' did not match any files"),
diff --git a/cache.h b/cache.h
index 3e09a61..c5a408f 100644
--- a/cache.h
+++ b/cache.h
@@ -482,7 +482,7 @@ extern int ie_modified(const struct index_state *, =
struct cache_entry *, struct
 #define PATHSPEC_EMPTY_MATCH_ALL (1<<0) /* No args means match everyth=
ing */
=20
 struct pathspec {
-	const char **raw; /* get_pathspec() result, not freed by free_pathspe=
c() */
+	const char **_raw; /* get_pathspec() result, not freed by free_pathsp=
ec() */
 	int nr;
 	unsigned int has_wildcard:1;
 	unsigned int recursive:1;
diff --git a/dir.c b/dir.c
index eb52913..aad180b 100644
--- a/dir.c
+++ b/dir.c
@@ -80,10 +80,10 @@ int fill_directory(struct dir_struct *dir, const st=
ruct pathspec *pathspec)
 	 * Calculate common prefix for the pathspec, and
 	 * use that to optimize the directory walk
 	 */
-	len =3D common_prefix_len(pathspec->raw);
+	len =3D common_prefix_len(pathspec->_raw);
=20
 	/* Read the directory and prune it */
-	read_directory(dir, pathspec->nr ? pathspec->raw[0] : "", len, pathsp=
ec);
+	read_directory(dir, pathspec->nr ? pathspec->_raw[0] : "", len, paths=
pec);
 	return len;
 }
=20
@@ -1218,7 +1218,7 @@ int read_directory(struct dir_struct *dir, const =
char *path, int len, const stru
 	if (has_symlink_leading_path(path, len))
 		return dir->nr;
=20
-	simplify =3D create_simplify(pathspec ? pathspec->raw : NULL);
+	simplify =3D create_simplify(pathspec ? pathspec->_raw : NULL);
 	if (!len || treat_leading_path(dir, path, len, simplify))
 		read_directory_recursive(dir, path, len, 0, simplify);
 	free_simplify(simplify);
@@ -1417,7 +1417,7 @@ int init_pathspec(struct pathspec *pathspec, cons=
t char **paths)
 		return 0;
 	while (*p)
 		p++;
-	pathspec->raw =3D paths;
+	pathspec->_raw =3D paths;
 	pathspec->nr =3D p - paths;
 	if (!pathspec->nr)
 		return 0;
@@ -1444,7 +1444,7 @@ void strip_trailing_slash_from_submodules(struct =
pathspec *pathspec)
 {
 	int i;
 	for (i =3D 0; i < pathspec->nr; i++) {
-		const char *p =3D pathspec->raw[i];
+		const char *p =3D pathspec->_raw[i];
 		int len =3D strlen(p), pos;
=20
 		if (len < 1 || p[len - 1] !=3D '/')
@@ -1452,7 +1452,7 @@ void strip_trailing_slash_from_submodules(struct =
pathspec *pathspec)
 		pos =3D cache_name_pos(p, len - 1);
 		if (pos >=3D 0 && S_ISGITLINK(active_cache[pos]->ce_mode)) {
 			char *path =3D xstrndup(p, len - 1);
-			pathspec->raw[i] =3D path;
+			pathspec->_raw[i] =3D path;
 			pathspec->items[i].match =3D path;
 			pathspec->items[i].len =3D len - 1;
 			pathspec->items[i].nowildcard_len =3D simple_length(path);
@@ -1472,20 +1472,20 @@ void treat_gitlinks(struct pathspec *pathspec)
 			continue;
=20
 		for (j =3D 0; j < pathspec->nr; j++) {
-			int len2 =3D strlen(pathspec->raw[j]);
-			if (len2 <=3D len || pathspec->raw[j][len] !=3D '/' ||
-			    memcmp(ce->name, pathspec->raw[j], len))
+			int len2 =3D strlen(pathspec->_raw[j]);
+			if (len2 <=3D len || pathspec->_raw[j][len] !=3D '/' ||
+			    memcmp(ce->name, pathspec->_raw[j], len))
 				continue;
 			if (len2 =3D=3D len + 1) {
 				/* strip trailing slash */
 				char *path =3D xstrndup(ce->name, len);
-				pathspec->raw[j] =3D path;
+				pathspec->_raw[j] =3D path;
 				pathspec->items[j].match =3D path;
 				pathspec->items[j].len =3D len;
 				pathspec->items[j].nowildcard_len =3D simple_length(path);
 			} else
 				die (_("Path '%s' is in submodule '%.*s'"),
-				     pathspec->raw[j], len, ce->name);
+				     pathspec->_raw[j], len, ce->name);
 		}
 	}
 }
diff --git a/revision.c b/revision.c
index a044242..d89bb22 100644
--- a/revision.c
+++ b/revision.c
@@ -1885,12 +1885,12 @@ int setup_revisions(int argc, const char **argv=
, struct rev_info *revs, struct s
 		revs->limited =3D 1;
=20
 	if (revs->prune_data.nr) {
-		diff_tree_setup_paths(revs->prune_data.raw, &revs->pruning);
+		diff_tree_setup_paths(revs->prune_data._raw, &revs->pruning);
 		/* Can't prune commits with rename following: the paths change.. */
 		if (!DIFF_OPT_TST(&revs->diffopt, FOLLOW_RENAMES))
 			revs->prune =3D 1;
 		if (!revs->full_diff)
-			diff_tree_setup_paths(revs->prune_data.raw, &revs->diffopt);
+			diff_tree_setup_paths(revs->prune_data._raw, &revs->diffopt);
 	}
 	if (revs->combine_merges)
 		revs->ignore_merges =3D 0;
diff --git a/setup.c b/setup.c
index a26b6c0..1182a0a 100644
--- a/setup.c
+++ b/setup.c
@@ -293,7 +293,7 @@ void parse_pathspec(struct pathspec *pathspec,
 		raw[0] =3D prefix;
 		raw[1] =3D NULL;
 		pathspec->nr =3D 1;
-		pathspec->raw =3D raw;
+		pathspec->_raw =3D raw;
 		return;
 	}
=20
@@ -303,7 +303,7 @@ void parse_pathspec(struct pathspec *pathspec,
=20
 	pathspec->nr =3D n;
 	pathspec->items =3D item =3D xmalloc(sizeof(*item) * n);
-	pathspec->raw =3D argv;
+	pathspec->_raw =3D argv;
 	prefixlen =3D prefix ? strlen(prefix) : 0;
=20
 	for (i =3D 0; i < n; i++) {
@@ -327,7 +327,7 @@ const char **get_pathspec(const char *prefix, const=
 char **pathspec)
 {
 	struct pathspec ps;
 	parse_pathspec(&ps, PATHSPEC_FROMTOP, 0, prefix, pathspec);
-	return ps.raw;
+	return ps._raw;
 }
=20
 /*
diff --git a/tree-diff.c b/tree-diff.c
index ba01563..09bddd1 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -207,7 +207,7 @@ static void try_to_follow_renames(struct tree_desc =
*t1, struct tree_desc *t2, co
 	DIFF_OPT_SET(&diff_opts, RECURSIVE);
 	DIFF_OPT_SET(&diff_opts, FIND_COPIES_HARDER);
 	diff_opts.output_format =3D DIFF_FORMAT_NO_OUTPUT;
-	diff_opts.single_follow =3D opt->pathspec.raw[0];
+	diff_opts.single_follow =3D opt->pathspec._raw[0];
 	diff_opts.break_opt =3D opt->break_opt;
 	diff_opts.rename_score =3D opt->rename_score;
 	paths[0] =3D NULL;
@@ -228,15 +228,15 @@ static void try_to_follow_renames(struct tree_des=
c *t1, struct tree_desc *t2, co
 		 * the future!
 		 */
 		if ((p->status =3D=3D 'R' || p->status =3D=3D 'C') &&
-		    !strcmp(p->two->path, opt->pathspec.raw[0])) {
+		    !strcmp(p->two->path, opt->pathspec._raw[0])) {
 			/* Switch the file-pairs around */
 			q->queue[i] =3D choice;
 			choice =3D p;
=20
 			/* Update the path we use from now on.. */
 			diff_tree_release_paths(opt);
-			opt->pathspec.raw[0] =3D xstrdup(p->one->path);
-			diff_tree_setup_paths(opt->pathspec.raw, opt);
+			opt->pathspec._raw[0] =3D xstrdup(p->one->path);
+			diff_tree_setup_paths(opt->pathspec._raw, opt);
=20
 			/*
 			 * The caller expects us to return a set of vanilla
--=20
1.8.0.rc2.23.g1fb49df
