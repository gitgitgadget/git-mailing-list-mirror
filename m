Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6EF1CAA9
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiLcX6ea"
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6FC10CA
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 02:24:21 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c742186a3bso52498781fa.1
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 02:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699871059; x=1700475859; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDNqIUNjpEC1Se9dOL9trQehzBK78wXBxZW8yb4070s=;
        b=SiLcX6ea29QPJ1g/VpO3UUnlXYe3VVMOtA2VjZrZygOVthJCIk9uMCd7AReOtolifv
         j8t8U2SV8Yzbs8/BslqU8womIzdcK4rT0dfTeuwtX7RjnpysHnzYkpGSuhlFVDDVyjzk
         ShFcMVrF2TDTVSORbRz7swNkxYzPqSdsXyht1Eb/IDYg+nGvfTAOXfPqwaYXO4UK6NH8
         wi2sm0whgZa9h+Z57lqjsHJtgpUexVCWdHXCRVlMGYiB1RnkkKlZBYJ0zCYsgDQG4y4t
         I8kopNBi1iKNpPZi8hrazQ9dz6gzVi5NJIF+lqJp3aLkzedbAfACHuJcdqXxfIbxEfs4
         8xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699871059; x=1700475859;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDNqIUNjpEC1Se9dOL9trQehzBK78wXBxZW8yb4070s=;
        b=j3KnDT0XpPr/0dowdYr75mw5qXsrLH4O2MDL+kRlIT20fzM+XeBhtg2qA9yn398OS6
         kXnHm11LXjRMDvgD1EkZbRjbVBCPVJPelb+pSlZsRuZzW2FjWbNuuWOR1+1IeePBubLW
         d8GkKAGBAsFGg6U/GeGJ6vzGZfj1apMEyd/Mttj0QJ5JHKdeFgYGEeOb/CspLnEex5cE
         pyZwUXTwOsacjKZRYN9vglgsgu3e1TcaRu7qZIiPG9cnjb/2cxdO3saX1weF/bkM6POJ
         A6GLR2uHjgFH5TEZxLt5clGksJDsskoU+eQ//sMwj8BaeNYfyorx/V8na4pqnFxtjpTv
         FTmw==
X-Gm-Message-State: AOJu0Yx/clV9osD+5GpcoOWNQqJhizI0P/HHSAqHrKl7QRG83mgPLsLW
	QkipYeDP1Ec/GiamCkuPGoPzP733Flw=
X-Google-Smtp-Source: AGHT+IEzK/wkgIQsON1qG51e3eHI7TsK+CpFrIQoRMIHG8Z66BcvkI71Dwr945fTV7eaHXDD7l1BFg==
X-Received: by 2002:a2e:7803:0:b0:2bc:c28c:a2b8 with SMTP id t3-20020a2e7803000000b002bcc28ca2b8mr3515705ljc.27.1699871058894;
        Mon, 13 Nov 2023 02:24:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j10-20020a05600c300a00b0040773c69fc0sm13143450wmh.11.2023.11.13.02.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 02:24:18 -0800 (PST)
Message-ID: <098b9ca8ece4fdce45a9b48e576b474ed81dced1.1699871056.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
References: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
From: "Haritha D via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 13 Nov 2023 10:24:04 +0000
Subject: [PATCH 02/13] Enable builds for z/OS.
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Haritha  <harithamma.d@ibm.com>,
    Haritha D <harithamma.d@ibm.com>

From: Haritha D <harithamma.d@ibm.com>

This commit enables git to build on z/OS.
It takes advantage of enahanced ASCII
services on z/OS to auto-convert input
files to ASCII
It also adds support for
[platform]-working-tree-encoding.
Platform is substituted with uname_info.sysname,
so it will only apply to the given platform.
Also adds support for scripts that are not in
standard locations so that /bin/env bash
can be specified.

Signed-off-by: Harithamma D <harithamma.d@ibm.com>
---
 Makefile              | 21 +++++++++---
 builtin.h             |  3 ++
 builtin/archive.c     |  6 ++++
 builtin/hash-object.c | 28 +++++++++++++++
 combine-diff.c        |  4 +++
 config.c              |  7 ++++
 configure.ac          |  3 ++
 convert.c             | 44 ++++++++++++++++++++----
 copy.c                |  3 ++
 diff.c                | 11 ++++++
 entry.c               | 26 ++++++++++++++
 environment.c         |  3 ++
 git-compat-util.h     |  8 +++++
 negotiator/default.c  |  4 +--
 negotiator/noop.c     |  4 +--
 negotiator/skipping.c |  4 +--
 object-file.c         | 80 ++++++++++++++++++++++++++++++++++++++++++-
 read-cache.c          |  3 ++
 utf8.c                | 11 ++++++
 19 files changed, 255 insertions(+), 18 deletions(-)

diff --git a/Makefile b/Makefile
index 9c6a2f125f8..30aa76da4f4 100644
--- a/Makefile
+++ b/Makefile
@@ -20,6 +20,8 @@ include shared.mak
 #
 # Define SHELL_PATH to a POSIX shell if your /bin/sh is broken.
 #
+# Define SHELL_PATH_FOR_SCRIPTS to a POSIX shell if your /bin/sh is broken.
+#
 # Define SANE_TOOL_PATH to a colon-separated list of paths to prepend
 # to PATH if your tools in /usr/bin are broken.
 #
@@ -215,6 +217,8 @@ include shared.mak
 #
 # Define PERL_PATH to the path of your Perl binary (usually /usr/bin/perl).
 #
+# Define PERL_PATH_FOR_SCRIPTS to a Perl binary if your /usr/bin/perl is broken.
+#
 # Define NO_PERL if you do not want Perl scripts or libraries at all.
 #
 # Define NO_PERL_CPAN_FALLBACKS if you do not want to install bundled
@@ -903,9 +907,15 @@ BINDIR_PROGRAMS_NO_X += git-cvsserver
 ifndef SHELL_PATH
 	SHELL_PATH = /bin/sh
 endif
+ifndef SHELL_PATH_FOR_SCRIPTS
+	SHELL_PATH_FOR_SCRIPTS = /bin/sh
+endif
 ifndef PERL_PATH
 	PERL_PATH = /usr/bin/perl
 endif
+ifndef PERL_PATH_FOR_SCRIPTS
+	PERL_PATH_FOR_SCRIPTS = /usr/bin/perl
+endif
 ifndef PYTHON_PATH
 	PYTHON_PATH = /usr/bin/python
 endif
@@ -1336,7 +1346,7 @@ THIRD_PARTY_SOURCES += sha1dc/%
 
 # xdiff and reftable libs may in turn depend on what is in libgit.a
 GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
-EXTLIBS =
+EXTLIBS = $(ZOPEN_EXTRA_LIBS)
 
 GIT_USER_AGENT = git/$(GIT_VERSION)
 
@@ -2226,9 +2236,10 @@ perllibdir_relative_SQ = $(subst ','\'',$(perllibdir_relative))
 gitwebdir_SQ = $(subst ','\'',$(gitwebdir))
 gitwebstaticdir_SQ = $(subst ','\'',$(gitwebstaticdir))
 
-SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
+SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH_FOR_SCRIPTS))
 TEST_SHELL_PATH_SQ = $(subst ','\'',$(TEST_SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
+PERL_PATH_FOR_SCRIPTS_SQ = $(subst ','\'',$(PERL_PATH_FOR_SCRIPTS))
 PYTHON_PATH_SQ = $(subst ','\'',$(PYTHON_PATH))
 TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
 DIFF_SQ = $(subst ','\'',$(DIFF))
@@ -2448,7 +2459,7 @@ hook-list.h: generate-hooklist.sh Documentation/githooks.txt
 
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):\
 	$(localedir_SQ):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
-	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(PAGER_ENV):\
+	$(gitwebdir_SQ):$(PERL_PATH_FOR_SCRIPTS_SQ):$(PAGER_ENV):\
 	$(perllibdir_SQ)
 GIT-SCRIPT-DEFINES: FORCE
 	@FLAGS='$(SCRIPT_DEFINES)'; \
@@ -2465,7 +2476,7 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -e 's/@@USE_GETTEXT_SCHEME@@/$(USE_GETTEXT_SCHEME)/g' \
     -e $(BROKEN_PATH_FIX) \
     -e 's|@@GITWEBDIR@@|$(gitwebdir_SQ)|g' \
-    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
+    -e 's|@@PERL@@|$(PERL_PATH_FOR_SCRIPTS_SQ)|g' \
     -e 's|@@PAGER_ENV@@|$(PAGER_ENV_SQ)|g' \
     $@.sh >$@+
 endef
@@ -2519,7 +2530,7 @@ PERL_DEFINES += $(gitexecdir) $(perllibdir) $(localedir)
 $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
 	$(QUIET_GEN) \
 	sed -e '1{' \
-	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
+	    -e '	s|#!.*perl|#!$(PERL_PATH_FOR_SCRIPTS_SQ)|' \
 	    -e '	r GIT-PERL-HEADER' \
 	    -e '	G' \
 	    -e '}' \
diff --git a/builtin.h b/builtin.h
index d560baa6618..806af1a262d 100644
--- a/builtin.h
+++ b/builtin.h
@@ -250,5 +250,8 @@ int cmd_verify_pack(int argc, const char **argv, const char *prefix);
 int cmd_show_ref(int argc, const char **argv, const char *prefix);
 int cmd_pack_refs(int argc, const char **argv, const char *prefix);
 int cmd_replace(int argc, const char **argv, const char *prefix);
+#ifdef __MVS__
+  extern int setbinaryfd(int);
+#endif
 
 #endif
diff --git a/builtin/archive.c b/builtin/archive.c
index 90761fdfee0..53ec794356f 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -14,6 +14,12 @@
 static void create_output_file(const char *output_file)
 {
 	int output_fd = xopen(output_file, O_CREAT | O_WRONLY | O_TRUNC, 0666);
+#ifdef __MVS__
+ #if (__CHARSET_LIB == 1)
+	if (setbinaryfd(output_fd))
+		die_errno(_("could not tag archive file '%s'"), output_file);
+ #endif
+#endif
 	if (output_fd != 1) {
 		if (dup2(output_fd, 1) < 0)
 			die_errno(_("could not redirect output"));
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 5ffec99dcea..b33b32ff977 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -57,11 +57,39 @@ static void hash_fd(int fd, const char *type, const char *path, unsigned flags,
 	maybe_flush_or_die(stdout, "hash to stdout");
 }
 
+#ifdef __MVS__
+#  if (__CHARSET_LIB == 1)
+#  include <stdio.h>
+#  include <stdlib.h>
+
+   int setbinaryfd(int fd)
+   {
+     attrib_t attr;
+     int rc;
+
+     memset(&attr, 0, sizeof(attr));
+     attr.att_filetagchg = 1;
+     attr.att_filetag.ft_ccsid = FT_BINARY;
+     attr.att_filetag.ft_txtflag = 0;
+
+     rc = __fchattr(fd, &attr, sizeof(attr));
+     return rc;
+   }
+#  endif
+#endif
+
+
 static void hash_object(const char *path, const char *type, const char *vpath,
 			unsigned flags, int literally)
 {
 	int fd;
 	fd = xopen(path, O_RDONLY);
+#ifdef __MVS__
+#  if (__CHARSET_LIB == 1)
+  if (setbinaryfd(fd))
+		die_errno("Cannot set to binary '%s'", path);
+#  endif
+#endif
 	hash_fd(fd, type, vpath, flags, literally);
 }
 
diff --git a/combine-diff.c b/combine-diff.c
index f90f4424829..73445a517c7 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1082,6 +1082,10 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			ssize_t done;
 			int is_file, i;
 
+#ifdef __MVS__
+      __disableautocvt(fd);
+#endif
+
 			elem->mode = canon_mode(st.st_mode);
 			/* if symlinks don't work, assume symlink if all parents
 			 * are symlinks
diff --git a/config.c b/config.c
index f9a1cca4e8a..37c124a37c0 100644
--- a/config.c
+++ b/config.c
@@ -1521,6 +1521,13 @@ static int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 
+	#ifdef __MVS__
+	if (!strcmp(var, "core.ignorefiletags")) {
+		ignore_file_tags = git_config_bool(var, value);
+		return 0;
+	}
+	#endif
+
 	if (!strcmp(var, "core.safecrlf")) {
 		int eol_rndtrp_die;
 		if (value && !strcasecmp(value, "warn")) {
diff --git a/configure.ac b/configure.ac
index 276593cd9dd..ed380504be6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -463,6 +463,9 @@ else
             CC_LD_DYNPATH=-Wl,+b,
           else
              CC_LD_DYNPATH=
+             if test "$(uname -s)" = "OS/390"; then
+                CC_LD_DYNPATH=-L
+             fi
              AC_MSG_WARN([linker does not support runtime path to dynamic libraries])
           fi
       fi
diff --git a/convert.c b/convert.c
index a8870baff36..4f14ff6f1ed 100644
--- a/convert.c
+++ b/convert.c
@@ -377,12 +377,15 @@ static int check_roundtrip(const char *enc_name)
 static const char *default_encoding = "UTF-8";
 
 static int encode_to_git(const char *path, const char *src, size_t src_len,
-			 struct strbuf *buf, const char *enc, int conv_flags)
+			 struct strbuf *buf, const char *enc, enum convert_crlf_action attr_action, int conv_flags)
 {
 	char *dst;
 	size_t dst_len;
 	int die_on_error = conv_flags & CONV_WRITE_OBJECT;
 
+  if (attr_action == CRLF_BINARY) {
+    return 0;
+  }
 	/*
 	 * No encoding is specified or there is nothing to encode.
 	 * Tell the caller that the content was not modified.
@@ -403,6 +406,11 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 		return 0;
 
 	trace_encoding("source", path, enc, src, src_len);
+#ifdef __MVS__
+  // Don't convert ISO8859-1 on z/OS
+  if (strcasecmp("ISO8859-1", enc) == 0)
+    return 0;
+#endif
 	dst = reencode_string_len(src, src_len, default_encoding, enc,
 				  &dst_len);
 	if (!dst) {
@@ -468,11 +476,14 @@ static int encode_to_git(const char *path, const char *src, size_t src_len,
 }
 
 static int encode_to_worktree(const char *path, const char *src, size_t src_len,
-			      struct strbuf *buf, const char *enc)
+			      struct strbuf *buf, enum convert_crlf_action attr_action, const char *enc)
 {
 	char *dst;
 	size_t dst_len;
 
+  if (attr_action == CRLF_BINARY) {
+    return 0;
+  }
 	/*
 	 * No encoding is specified or there is nothing to encode.
 	 * Tell the caller that the content was not modified.
@@ -1302,18 +1313,37 @@ static int git_path_check_ident(struct attr_check_item *check)
 
 static struct attr_check *check;
 
+static const char* get_platform() {
+	struct utsname uname_info;
+
+	if (uname(&uname_info))
+		die(_("uname() failed with error '%s' (%d)\n"),
+			    strerror(errno),
+			    errno);
+
+  if (!strcmp(uname_info.sysname, "OS/390"))
+    return "zos";
+  return uname_info.sysname;
+}
+
+
 void convert_attrs(struct index_state *istate,
 		   struct conv_attrs *ca, const char *path)
 {
 	struct attr_check_item *ccheck = NULL;
+  struct strbuf platform_working_tree_encoding = STRBUF_INIT;
+
+	strbuf_addf(&platform_working_tree_encoding, "%s-working-tree-encoding", get_platform());
+
 
 	if (!check) {
 		check = attr_check_initl("crlf", "ident", "filter",
-					 "eol", "text", "working-tree-encoding",
+					 "eol", "text", "working-tree-encoding", platform_working_tree_encoding.buf,
 					 NULL);
 		user_convert_tail = &user_convert;
 		git_config(read_convert_config, NULL);
 	}
+	strbuf_release(&platform_working_tree_encoding);
 
 	git_check_attr(istate, path, check);
 	ccheck = check->items;
@@ -1334,6 +1364,8 @@ void convert_attrs(struct index_state *istate,
 			ca->crlf_action = CRLF_TEXT_CRLF;
 	}
 	ca->working_tree_encoding = git_path_check_encoding(ccheck + 5);
+  if (git_path_check_encoding(ccheck + 6))
+    ca->working_tree_encoding = git_path_check_encoding(ccheck + 6);
 
 	/* Save attr and make a decision for action */
 	ca->attr_action = ca->crlf_action;
@@ -1427,7 +1459,7 @@ int convert_to_git(struct index_state *istate,
 		len = dst->len;
 	}
 
-	ret |= encode_to_git(path, src, len, dst, ca.working_tree_encoding, conv_flags);
+	ret |= encode_to_git(path, src, len, dst, ca.working_tree_encoding, ca.attr_action, conv_flags);
 	if (ret && dst) {
 		src = dst->buf;
 		len = dst->len;
@@ -1455,7 +1487,7 @@ void convert_to_git_filter_fd(struct index_state *istate,
 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN, NULL, NULL))
 		die(_("%s: clean filter '%s' failed"), path, ca.drv->name);
 
-	encode_to_git(path, dst->buf, dst->len, dst, ca.working_tree_encoding, conv_flags);
+	encode_to_git(path, dst->buf, dst->len, dst, ca.working_tree_encoding, ca.attr_action, conv_flags);
 	crlf_to_git(istate, path, dst->buf, dst->len, dst, ca.crlf_action, conv_flags);
 	ident_to_git(dst->buf, dst->len, dst, ca.ident);
 }
@@ -1487,7 +1519,7 @@ static int convert_to_working_tree_ca_internal(const struct conv_attrs *ca,
 		}
 	}
 
-	ret |= encode_to_worktree(path, src, len, dst, ca->working_tree_encoding);
+	ret |= encode_to_worktree(path, src, len, dst, ca->attr_action, ca->working_tree_encoding);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
diff --git a/copy.c b/copy.c
index 23d84c6c1db..63546aecf81 100644
--- a/copy.c
+++ b/copy.c
@@ -14,6 +14,9 @@ int copy_fd(int ifd, int ofd)
 		if (write_in_full(ofd, buffer, len) < 0)
 			return COPY_WRITE_ERROR;
 	}
+#ifdef __MVS__
+  __copyfdccsid(ifd, ofd);
+#endif
 	return 0;
 }
 
diff --git a/diff.c b/diff.c
index 2c602df10a3..28b96d53dbc 100644
--- a/diff.c
+++ b/diff.c
@@ -4083,6 +4083,9 @@ int diff_populate_filespec(struct repository *r,
 	int check_binary = options ? options->check_binary : 0;
 	int err = 0;
 	int conv_flags = global_conv_flags_eol;
+#ifdef __MVS__
+	int autocvtToASCII;
+#endif
 	/*
 	 * demote FAIL to WARN to allow inspecting the situation
 	 * instead of refusing.
@@ -4155,9 +4158,17 @@ int diff_populate_filespec(struct repository *r,
 			s->is_binary = 1;
 			return 0;
 		}
+#ifdef __MVS__
+    validate_codeset(r->index, s->path, &autocvtToASCII);
+#endif
 		fd = open(s->path, O_RDONLY);
 		if (fd < 0)
 			goto err_empty;
+
+#ifdef __MVS__
+    if (!autocvtToASCII)
+      __disableautocvt(fd);
+#endif
 		s->data = xmmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
 		close(fd);
 		s->should_munmap = 1;
diff --git a/entry.c b/entry.c
index 076e97eb89c..df6feb2234b 100644
--- a/entry.c
+++ b/entry.c
@@ -126,6 +126,24 @@ int fstat_checkout_output(int fd, const struct checkout *state, struct stat *st)
 	return 0;
 }
 
+#ifdef __MVS__
+void tag_file_as_working_tree_encoding(struct index_state *istate, char* path, int fd) {
+	struct conv_attrs ca;
+	convert_attrs(istate, &ca, path);
+  if (ca.attr_action != CRLF_BINARY) {
+    if (ca.working_tree_encoding)
+      __chgfdcodeset(fd, ca.working_tree_encoding);
+    else
+      __setfdtext(fd);
+  }
+  else {
+    __setfdbinary(fd);
+  }
+
+  __disableautocvt(fd);
+}
+#endif
+
 static int streaming_write_entry(const struct cache_entry *ce, char *path,
 				 struct stream_filter *filter,
 				 const struct checkout *state, int to_tempfile,
@@ -138,6 +156,10 @@ static int streaming_write_entry(const struct cache_entry *ce, char *path,
 	if (fd < 0)
 		return -1;
 
+#ifdef __MVS__
+  tag_file_as_working_tree_encoding(state->istate, path, fd);
+#endif
+
 	result |= stream_blob_to_fd(fd, &ce->oid, filter, 1);
 	*fstat_done = fstat_checkout_output(fd, state, statbuf);
 	result |= close(fd);
@@ -374,6 +396,10 @@ static int write_entry(struct cache_entry *ce, char *path, struct conv_attrs *ca
 			return error_errno("unable to create file %s", path);
 		}
 
+#ifdef __MVS__
+    tag_file_as_working_tree_encoding(state->istate, path, fd);
+#endif
+
 		wrote = write_in_full(fd, new_blob, size);
 		if (!to_tempfile)
 			fstat_done = fstat_checkout_output(fd, state, &st);
diff --git a/environment.c b/environment.c
index bb3c2a96a33..2e4d3a1e058 100644
--- a/environment.c
+++ b/environment.c
@@ -51,6 +51,9 @@ const char *git_hooks_path;
 int zlib_compression_level = Z_BEST_SPEED;
 int pack_compression_level = Z_DEFAULT_COMPRESSION;
 int fsync_object_files = -1;
+#ifdef __MVS__
+int ignore_file_tags = 0;
+#endif
 int use_fsync = -1;
 enum fsync_method fsync_method = FSYNC_METHOD_DEFAULT;
 enum fsync_component fsync_components = FSYNC_COMPONENTS_DEFAULT;
diff --git a/git-compat-util.h b/git-compat-util.h
index 3e7a59b5ff1..66e0abec24b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -223,7 +223,15 @@ struct strbuf;
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <stddef.h>
+#ifdef __MVS__
+#define release stdlib_release
+#define fetch stdlib_fetch
+#endif
 #include <stdlib.h>
+#ifdef __MVS__
+#undef fetch
+#undef release
+#endif
 #include <stdarg.h>
 #include <string.h>
 #ifdef HAVE_STRINGS_H
diff --git a/negotiator/default.c b/negotiator/default.c
index 9a5b6963272..b1f9f153372 100644
--- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -174,7 +174,7 @@ static int ack(struct fetch_negotiator *n, struct commit *c)
 	return known_to_be_common;
 }
 
-static void release(struct fetch_negotiator *n)
+static void release_negotiator(struct fetch_negotiator *n)
 {
 	clear_prio_queue(&((struct negotiation_state *)n->data)->rev_list);
 	FREE_AND_NULL(n->data);
@@ -187,7 +187,7 @@ void default_negotiator_init(struct fetch_negotiator *negotiator)
 	negotiator->add_tip = add_tip;
 	negotiator->next = next;
 	negotiator->ack = ack;
-	negotiator->release = release;
+	negotiator->release_negotiator = release_negotiator;
 	negotiator->data = CALLOC_ARRAY(ns, 1);
 	ns->rev_list.compare = compare_commits_by_commit_date;
 
diff --git a/negotiator/noop.c b/negotiator/noop.c
index de39028ab7f..82089654d8b 100644
--- a/negotiator/noop.c
+++ b/negotiator/noop.c
@@ -30,7 +30,7 @@ static int ack(struct fetch_negotiator *n UNUSED, struct commit *c UNUSED)
 	return 0;
 }
 
-static void release(struct fetch_negotiator *n UNUSED)
+static void release_negotiator(struct fetch_negotiator *n UNUSED)
 {
 	/* nothing to release */
 }
@@ -41,6 +41,6 @@ void noop_negotiator_init(struct fetch_negotiator *negotiator)
 	negotiator->add_tip = add_tip;
 	negotiator->next = next;
 	negotiator->ack = ack;
-	negotiator->release = release;
+	negotiator->release_negotiator = release_negotiator;
 	negotiator->data = NULL;
 }
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index 5b91520430c..783b3f27e63 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -243,7 +243,7 @@ static int ack(struct fetch_negotiator *n, struct commit *c)
 	return known_to_be_common;
 }
 
-static void release(struct fetch_negotiator *n)
+static void release_negotiator(struct fetch_negotiator *n)
 {
 	clear_prio_queue(&((struct data *)n->data)->rev_list);
 	FREE_AND_NULL(n->data);
@@ -256,7 +256,7 @@ void skipping_negotiator_init(struct fetch_negotiator *negotiator)
 	negotiator->add_tip = add_tip;
 	negotiator->next = next;
 	negotiator->ack = ack;
-	negotiator->release = release;
+	negotiator->release_negotiator = release_negotiator;
 	negotiator->data = CALLOC_ARRAY(data, 1);
 	data->rev_list.compare = compare;
 
diff --git a/object-file.c b/object-file.c
index 7c7afe57936..28e69ed1e33 100644
--- a/object-file.c
+++ b/object-file.c
@@ -43,7 +43,9 @@
 #include "setup.h"
 #include "submodule.h"
 #include "fsck.h"
-
+#ifdef __MVS__
+#include <_Ccsid.h>
+#endif
 /* The maximum size for an object header. */
 #define MAX_HEADER_LEN 32
 
@@ -2478,6 +2480,68 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 	return ret;
 }
 
+#ifdef __MVS__
+void validate_codeset(struct index_state *istate, const char *path, int* autoconvertToASCII) {
+       struct conv_attrs ca;
+  struct stat st;
+  unsigned short attr_ccsid;
+  unsigned short file_ccsid;
+
+  if (ignore_file_tags)
+   return;
+
+  *autoconvertToASCII = 0;
+       convert_attrs(istate, &ca, path);
+  if (ca.attr_action == CRLF_BINARY) {
+    attr_ccsid = FT_BINARY;
+  }
+  else if (ca.working_tree_encoding) {
+    attr_ccsid = __toCcsid(ca.working_tree_encoding);
+  }
+  else
+    attr_ccsid = 819;
+
+  if (stat(path, &st) < 0)
+    return;
+
+  file_ccsid = st.st_tag.ft_ccsid;
+
+  if (file_ccsid == FT_UNTAGGED) {
+    die("File %s is untagged, set the correct file tag (using the chtag command).", path);
+  }
+
+  if (attr_ccsid != file_ccsid) {
+    if (file_ccsid == 1047 && attr_ccsid == 819) {
+      *autoconvertToASCII = 1;
+      return;
+    }
+    // Allow tag mixing of 819 and 1208
+    if ((file_ccsid == 819 || file_ccsid == 1208) && (attr_ccsid == 1208 || attr_ccsid == 819)) {
+      return;
+    }
+    // Don't check for binary files, just add them
+    if (attr_ccsid == FT_BINARY)
+      return;
+
+    char attr_csname[_XOPEN_PATH_MAX] = {0};
+    char file_csname[_XOPEN_PATH_MAX] = {0};
+    if (attr_ccsid != FT_BINARY) {
+      __toCSName(attr_ccsid, attr_csname);
+    } else {
+      snprintf(attr_csname, _XOPEN_PATH_MAX, "%s", "binary");
+    }
+    if (file_ccsid != FT_BINARY) {
+      __toCSName(file_ccsid, file_csname);
+    } else {
+      snprintf(file_csname, _XOPEN_PATH_MAX, "%s", "binary");
+    }
+    die("%s added file: file tag (%s) does not match working-tree-encoding (%s)", path, file_csname, attr_csname);
+  }
+}
+#endif
+
+
+
 int index_path(struct index_state *istate, struct object_id *oid,
 	       const char *path, struct stat *st, unsigned flags)
 {
@@ -2485,11 +2549,25 @@ int index_path(struct index_state *istate, struct object_id *oid,
 	struct strbuf sb = STRBUF_INIT;
 	int rc = 0;
 
+#ifdef __MVS__
+	struct conv_attrs ca;
+	int autocvtToASCII;
+#endif
+
 	switch (st->st_mode & S_IFMT) {
 	case S_IFREG:
+#ifdef __MVS__
+    validate_codeset(istate, path, &autocvtToASCII);
+#endif
 		fd = open(path, O_RDONLY);
 		if (fd < 0)
 			return error_errno("open(\"%s\")", path);
+
+#ifdef __MVS__
+   if (!autocvtToASCII)
+     __disableautocvt(fd);
+#endif
+
 		if (index_fd(istate, oid, fd, st, OBJ_BLOB, path, flags) < 0)
 			return error(_("%s: failed to insert into database"),
 				     path);
diff --git a/read-cache.c b/read-cache.c
index 080bd39713b..75c06121302 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -205,6 +205,9 @@ static int ce_compare_data(struct index_state *istate,
 	int fd = git_open_cloexec(ce->name, O_RDONLY);
 
 	if (fd >= 0) {
+#ifdef __MVS__
+    __disableautocvt(fd);
+#endif
 		struct object_id oid;
 		if (!index_fd(istate, &oid, fd, st, OBJ_BLOB, ce->name, 0))
 			match = !oideq(&oid, &ce->oid);
diff --git a/utf8.c b/utf8.c
index 6a0dd25b0fe..b9cb56abf14 100644
--- a/utf8.c
+++ b/utf8.c
@@ -590,6 +590,17 @@ char *reencode_string_len(const char *in, size_t insz,
 #endif
 	}
 
+#ifdef __MVS__
+  //HACK: For backwards compat, ISO8859-1 really means utf-8 in the z/OS world
+  if (strcasecmp("ISO8859-1", in_encoding) == 0) {
+    in_encoding = "UTF-8";
+    out_encoding = "UTF-8";
+  }
+  if (strcasecmp("ISO8859-1", out_encoding) == 0) {
+    in_encoding = "UTF-8";
+    out_encoding = "UTF-8";
+  }
+#endif
 	conv = iconv_open(out_encoding, in_encoding);
 	if (conv == (iconv_t) -1) {
 		in_encoding = fallback_encoding(in_encoding);
-- 
gitgitgadget

