Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gV3BmZsG"
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F25F2
	for <git@vger.kernel.org>; Mon,  4 Dec 2023 06:19:38 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c09f5a7cfso13871725e9.0
        for <git@vger.kernel.org>; Mon, 04 Dec 2023 06:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701699577; x=1702304377; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDCDIDzURiUYjRKLRlgsb3vXOr6geErLjF7pxRHfXw0=;
        b=gV3BmZsGPzhzRJSB3mNb8J80hjUJ0Ql8AWOkaPCXfw2qjmDMGkMtG3EnvSjHv7W+b+
         KMYAXVApPgz8naKlxS1HRp6rzYqwb5Lc4xsDse7+qcOD6+1V++GexuhvoqIKcm06z7wO
         cCvYOjJAGs8DzesvfA96/VXTcQAGGp0xeWWsQuvMi7Tm1Z1ySCOZqE6EuuC5ovPNfkLs
         42oiEnTqb0wG3G5MW2Yp9V1DMnms+Xoe+eU67Knv7MeP1C6rpWcqR1EXvmWvpzAUY1Nb
         1Dmjk84x99CWG+g52Jk/kDfcPUqup+LhLg4lvkky0ds0ILfGKQN6xdTE05bFNwezqnPr
         CJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701699577; x=1702304377;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDCDIDzURiUYjRKLRlgsb3vXOr6geErLjF7pxRHfXw0=;
        b=T2ZChVodRj/WdG1K//SRY8Gb8t6Yj9gow8yLPRROiYnVtGoSmfAEnGA7w9Jr4Xiyrw
         GQNCk/thdyL5HOswHfvaQYdiP7nVFepSIw95I0r7hB2LnJM5/t4QbcCO/LOWQd0V0S9j
         xCifIJjSJOkaeOsvw3CSQ6XISd2sj3nliNdNRef4WMWEdmP3799Os+pIK+m+ELAftzUO
         4gv+/EaP4jMnM6NZdZaN8xWL3+Xk8NkRnLQKnAJPrRCD6E4X6jPhwe9ISL4hwFQAjWf0
         1PaXDXv4DF2MxNQ2iXIDK0eqeeBR6U5NITn9r3t/zSrB5Bm644qzhbX+/nKHV8R42UhN
         AcCg==
X-Gm-Message-State: AOJu0Yz901T7obX/hCero51MJC9dBDUHnWlpRwFq4tbVwOUuMufBoTXP
	qsD5VP24ztSvoGN6M0Ue5sLT37kWWCo=
X-Google-Smtp-Source: AGHT+IHTYARvkqUa1Oa0gPvmTsS81EMW9xUUmXMmyAqTkIWqcp0v0qVeyZub1b4HLj+TUVRHnYHtrA==
X-Received: by 2002:a05:600c:3c95:b0:40b:5e1c:5c24 with SMTP id bg21-20020a05600c3c9500b0040b5e1c5c24mr2779629wmb.57.1701699576546;
        Mon, 04 Dec 2023 06:19:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g3-20020a056000118300b0033340b6d3a7sm5020393wrx.76.2023.12.04.06.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 06:19:36 -0800 (PST)
Message-ID: <pull.1537.v2.git.git.1701699574054.gitgitgadget@gmail.com>
In-Reply-To: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
References: <pull.1537.git.git.1699871056.gitgitgadget@gmail.com>
From: "Haritha  via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 Dec 2023 14:19:33 +0000
Subject: [PATCH v2] This PR enables a successful git build on z/OS.
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Haritha  <harithamma.d@ibm.com>,
    Haritha D <harithamma.d@ibm.com>

From: Haritha D <harithamma.d@ibm.com>

Rename functions like "release" and "fetch"
due to conflict in z/OS standard C libraries.
Also disables autoconversion facility on z/OS
and relies on iconv.
New files created in binary format are also
tagged as binary.

Signed-off-by: Haritha D <harithamma.d@ibm.com>
---
    Enabling z/OS workflow for git
    
    z/OS is an IBM mainframe operating system, also known as OS/390. Our
    team has been actively involved in porting Git to z/OS and we have made
    significant modifications to facilitate this process. The patch below is
    the initial configuration for z/OS. I also have few follow up changes
    and I will send that after these changes are approved. Please let me
    know if there are any concerns.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1537%2FHarithaIBM%2Fenablezos-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1537/HarithaIBM/enablezos-v2
Pull-Request: https://github.com/git/git/pull/1537

Range-diff vs v1:

  1:  712eb3712f1 <  -:  ----------- Enabling z/OS workflow for git
  2:  098b9ca8ece !  1:  b9882d90c5d Enable builds for z/OS.
     @@ Metadata
      Author: Haritha D <harithamma.d@ibm.com>
      
       ## Commit message ##
     -    Enable builds for z/OS.
     +    This PR enables a successful git build on z/OS.
      
     -    This commit enables git to build on z/OS.
     -    It takes advantage of enahanced ASCII
     -    services on z/OS to auto-convert input
     -    files to ASCII
     -    It also adds support for
     -    [platform]-working-tree-encoding.
     -    Platform is substituted with uname_info.sysname,
     -    so it will only apply to the given platform.
     -    Also adds support for scripts that are not in
     -    standard locations so that /bin/env bash
     -    can be specified.
     +    Rename functions like "release" and "fetch"
     +    due to conflict in z/OS standard C libraries.
     +    Also disables autoconversion facility on z/OS
     +    and relies on iconv.
     +    New files created in binary format are also
     +    tagged as binary.
      
     -    Signed-off-by: Harithamma D <harithamma.d@ibm.com>
     -
     - ## Makefile ##
     -@@ Makefile: include shared.mak
     - #
     - # Define SHELL_PATH to a POSIX shell if your /bin/sh is broken.
     - #
     -+# Define SHELL_PATH_FOR_SCRIPTS to a POSIX shell if your /bin/sh is broken.
     -+#
     - # Define SANE_TOOL_PATH to a colon-separated list of paths to prepend
     - # to PATH if your tools in /usr/bin are broken.
     - #
     -@@ Makefile: include shared.mak
     - #
     - # Define PERL_PATH to the path of your Perl binary (usually /usr/bin/perl).
     - #
     -+# Define PERL_PATH_FOR_SCRIPTS to a Perl binary if your /usr/bin/perl is broken.
     -+#
     - # Define NO_PERL if you do not want Perl scripts or libraries at all.
     - #
     - # Define NO_PERL_CPAN_FALLBACKS if you do not want to install bundled
     -@@ Makefile: BINDIR_PROGRAMS_NO_X += git-cvsserver
     - ifndef SHELL_PATH
     - 	SHELL_PATH = /bin/sh
     - endif
     -+ifndef SHELL_PATH_FOR_SCRIPTS
     -+	SHELL_PATH_FOR_SCRIPTS = /bin/sh
     -+endif
     - ifndef PERL_PATH
     - 	PERL_PATH = /usr/bin/perl
     - endif
     -+ifndef PERL_PATH_FOR_SCRIPTS
     -+	PERL_PATH_FOR_SCRIPTS = /usr/bin/perl
     -+endif
     - ifndef PYTHON_PATH
     - 	PYTHON_PATH = /usr/bin/python
     - endif
     -@@ Makefile: THIRD_PARTY_SOURCES += sha1dc/%
     - 
     - # xdiff and reftable libs may in turn depend on what is in libgit.a
     - GITLIBS = common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(LIB_FILE)
     --EXTLIBS =
     -+EXTLIBS = $(ZOPEN_EXTRA_LIBS)
     - 
     - GIT_USER_AGENT = git/$(GIT_VERSION)
     - 
     -@@ Makefile: perllibdir_relative_SQ = $(subst ','\'',$(perllibdir_relative))
     - gitwebdir_SQ = $(subst ','\'',$(gitwebdir))
     - gitwebstaticdir_SQ = $(subst ','\'',$(gitwebstaticdir))
     - 
     --SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
     -+SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH_FOR_SCRIPTS))
     - TEST_SHELL_PATH_SQ = $(subst ','\'',$(TEST_SHELL_PATH))
     - PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
     -+PERL_PATH_FOR_SCRIPTS_SQ = $(subst ','\'',$(PERL_PATH_FOR_SCRIPTS))
     - PYTHON_PATH_SQ = $(subst ','\'',$(PYTHON_PATH))
     - TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
     - DIFF_SQ = $(subst ','\'',$(DIFF))
     -@@ Makefile: hook-list.h: generate-hooklist.sh Documentation/githooks.txt
     - 
     - SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):\
     - 	$(localedir_SQ):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
     --	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(PAGER_ENV):\
     -+	$(gitwebdir_SQ):$(PERL_PATH_FOR_SCRIPTS_SQ):$(PAGER_ENV):\
     - 	$(perllibdir_SQ)
     - GIT-SCRIPT-DEFINES: FORCE
     - 	@FLAGS='$(SCRIPT_DEFINES)'; \
     -@@ Makefile: sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
     -     -e 's/@@USE_GETTEXT_SCHEME@@/$(USE_GETTEXT_SCHEME)/g' \
     -     -e $(BROKEN_PATH_FIX) \
     -     -e 's|@@GITWEBDIR@@|$(gitwebdir_SQ)|g' \
     --    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
     -+    -e 's|@@PERL@@|$(PERL_PATH_FOR_SCRIPTS_SQ)|g' \
     -     -e 's|@@PAGER_ENV@@|$(PAGER_ENV_SQ)|g' \
     -     $@.sh >$@+
     - endef
     -@@ Makefile: PERL_DEFINES += $(gitexecdir) $(perllibdir) $(localedir)
     - $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
     - 	$(QUIET_GEN) \
     - 	sed -e '1{' \
     --	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
     -+	    -e '	s|#!.*perl|#!$(PERL_PATH_FOR_SCRIPTS_SQ)|' \
     - 	    -e '	r GIT-PERL-HEADER' \
     - 	    -e '	G' \
     - 	    -e '}' \
     -
     - ## builtin.h ##
     -@@ builtin.h: int cmd_verify_pack(int argc, const char **argv, const char *prefix);
     - int cmd_show_ref(int argc, const char **argv, const char *prefix);
     - int cmd_pack_refs(int argc, const char **argv, const char *prefix);
     - int cmd_replace(int argc, const char **argv, const char *prefix);
     -+#ifdef __MVS__
     -+  extern int setbinaryfd(int);
     -+#endif
     - 
     - #endif
     +    Signed-off-by: Haritha D <harithamma.d@ibm.com>
      
       ## builtin/archive.c ##
      @@
     @@ builtin/archive.c
       {
       	int output_fd = xopen(output_file, O_CREAT | O_WRONLY | O_TRUNC, 0666);
      +#ifdef __MVS__
     -+ #if (__CHARSET_LIB == 1)
     -+	if (setbinaryfd(output_fd))
     ++	/*
     ++	 * Since the data is in binary format,
     ++	 * we need to set the z/OS file tag
     ++	 * to binary to disable autoconversion
     ++	 */
     ++	if (__setfdbinary(output_fd))
      +		die_errno(_("could not tag archive file '%s'"), output_file);
     -+ #endif
      +#endif
       	if (output_fd != 1) {
       		if (dup2(output_fd, 1) < 0)
       			die_errno(_("could not redirect output"));
      
       ## builtin/hash-object.c ##
     -@@ builtin/hash-object.c: static void hash_fd(int fd, const char *type, const char *path, unsigned flags,
     - 	maybe_flush_or_die(stdout, "hash to stdout");
     - }
     - 
     -+#ifdef __MVS__
     -+#  if (__CHARSET_LIB == 1)
     -+#  include <stdio.h>
     -+#  include <stdlib.h>
     -+
     -+   int setbinaryfd(int fd)
     -+   {
     -+     attrib_t attr;
     -+     int rc;
     -+
     -+     memset(&attr, 0, sizeof(attr));
     -+     attr.att_filetagchg = 1;
     -+     attr.att_filetag.ft_ccsid = FT_BINARY;
     -+     attr.att_filetag.ft_txtflag = 0;
     -+
     -+     rc = __fchattr(fd, &attr, sizeof(attr));
     -+     return rc;
     -+   }
     -+#  endif
     -+#endif
     -+
     -+
     - static void hash_object(const char *path, const char *type, const char *vpath,
     - 			unsigned flags, int literally)
     +@@ builtin/hash-object.c: static void hash_object(const char *path, const char *type, const char *vpath,
       {
       	int fd;
       	fd = xopen(path, O_RDONLY);
      +#ifdef __MVS__
     -+#  if (__CHARSET_LIB == 1)
     -+  if (setbinaryfd(fd))
     ++	/*
     ++	 * Since the data being read is in binary format,
     ++	 * we need to disable autoconversion for z/OS
     ++	 */
     ++	if (__setfdbinary(fd))
      +		die_errno("Cannot set to binary '%s'", path);
     -+#  endif
      +#endif
       	hash_fd(fd, type, vpath, flags, literally);
       }
     @@ combine-diff.c: static void show_patch_diff(struct combine_diff_path *elem, int
       			ssize_t done;
       			int is_file, i;
       
     -+#ifdef __MVS__
     -+      __disableautocvt(fd);
     -+#endif
     ++		#ifdef __MVS__
     ++			/*
     ++			 * Disable implicit autconversion on z/os,
     ++			 * rely on conversion from iconv
     ++			 */
     ++			__disableautocvt(fd);
     ++		#endif
      +
       			elem->mode = canon_mode(st.st_mode);
       			/* if symlinks don't work, assume symlink if all parents
       			 * are symlinks
      
     - ## config.c ##
     -@@ config.c: static int git_default_core_config(const char *var, const char *value,
     - 		return 0;
     - 	}
     - 
     -+	#ifdef __MVS__
     -+	if (!strcmp(var, "core.ignorefiletags")) {
     -+		ignore_file_tags = git_config_bool(var, value);
     -+		return 0;
     -+	}
     -+	#endif
     -+
     - 	if (!strcmp(var, "core.safecrlf")) {
     - 		int eol_rndtrp_die;
     - 		if (value && !strcasecmp(value, "warn")) {
     -
     - ## configure.ac ##
     -@@ configure.ac: else
     -             CC_LD_DYNPATH=-Wl,+b,
     -           else
     -              CC_LD_DYNPATH=
     -+             if test "$(uname -s)" = "OS/390"; then
     -+                CC_LD_DYNPATH=-L
     -+             fi
     -              AC_MSG_WARN([linker does not support runtime path to dynamic libraries])
     -           fi
     -       fi
     -
     - ## convert.c ##
     -@@ convert.c: static int check_roundtrip(const char *enc_name)
     - static const char *default_encoding = "UTF-8";
     - 
     - static int encode_to_git(const char *path, const char *src, size_t src_len,
     --			 struct strbuf *buf, const char *enc, int conv_flags)
     -+			 struct strbuf *buf, const char *enc, enum convert_crlf_action attr_action, int conv_flags)
     - {
     - 	char *dst;
     - 	size_t dst_len;
     - 	int die_on_error = conv_flags & CONV_WRITE_OBJECT;
     - 
     -+  if (attr_action == CRLF_BINARY) {
     -+    return 0;
     -+  }
     - 	/*
     - 	 * No encoding is specified or there is nothing to encode.
     - 	 * Tell the caller that the content was not modified.
     -@@ convert.c: static int encode_to_git(const char *path, const char *src, size_t src_len,
     - 		return 0;
     - 
     - 	trace_encoding("source", path, enc, src, src_len);
     -+#ifdef __MVS__
     -+  // Don't convert ISO8859-1 on z/OS
     -+  if (strcasecmp("ISO8859-1", enc) == 0)
     -+    return 0;
     -+#endif
     - 	dst = reencode_string_len(src, src_len, default_encoding, enc,
     - 				  &dst_len);
     - 	if (!dst) {
     -@@ convert.c: static int encode_to_git(const char *path, const char *src, size_t src_len,
     - }
     - 
     - static int encode_to_worktree(const char *path, const char *src, size_t src_len,
     --			      struct strbuf *buf, const char *enc)
     -+			      struct strbuf *buf, enum convert_crlf_action attr_action, const char *enc)
     - {
     - 	char *dst;
     - 	size_t dst_len;
     - 
     -+  if (attr_action == CRLF_BINARY) {
     -+    return 0;
     -+  }
     - 	/*
     - 	 * No encoding is specified or there is nothing to encode.
     - 	 * Tell the caller that the content was not modified.
     -@@ convert.c: static int git_path_check_ident(struct attr_check_item *check)
     - 
     - static struct attr_check *check;
     - 
     -+static const char* get_platform() {
     -+	struct utsname uname_info;
     -+
     -+	if (uname(&uname_info))
     -+		die(_("uname() failed with error '%s' (%d)\n"),
     -+			    strerror(errno),
     -+			    errno);
     -+
     -+  if (!strcmp(uname_info.sysname, "OS/390"))
     -+    return "zos";
     -+  return uname_info.sysname;
     -+}
     -+
     -+
     - void convert_attrs(struct index_state *istate,
     - 		   struct conv_attrs *ca, const char *path)
     - {
     - 	struct attr_check_item *ccheck = NULL;
     -+  struct strbuf platform_working_tree_encoding = STRBUF_INIT;
     -+
     -+	strbuf_addf(&platform_working_tree_encoding, "%s-working-tree-encoding", get_platform());
     -+
     - 
     - 	if (!check) {
     - 		check = attr_check_initl("crlf", "ident", "filter",
     --					 "eol", "text", "working-tree-encoding",
     -+					 "eol", "text", "working-tree-encoding", platform_working_tree_encoding.buf,
     - 					 NULL);
     - 		user_convert_tail = &user_convert;
     - 		git_config(read_convert_config, NULL);
     - 	}
     -+	strbuf_release(&platform_working_tree_encoding);
     - 
     - 	git_check_attr(istate, path, check);
     - 	ccheck = check->items;
     -@@ convert.c: void convert_attrs(struct index_state *istate,
     - 			ca->crlf_action = CRLF_TEXT_CRLF;
     - 	}
     - 	ca->working_tree_encoding = git_path_check_encoding(ccheck + 5);
     -+  if (git_path_check_encoding(ccheck + 6))
     -+    ca->working_tree_encoding = git_path_check_encoding(ccheck + 6);
     - 
     - 	/* Save attr and make a decision for action */
     - 	ca->attr_action = ca->crlf_action;
     -@@ convert.c: int convert_to_git(struct index_state *istate,
     - 		len = dst->len;
     - 	}
     - 
     --	ret |= encode_to_git(path, src, len, dst, ca.working_tree_encoding, conv_flags);
     -+	ret |= encode_to_git(path, src, len, dst, ca.working_tree_encoding, ca.attr_action, conv_flags);
     - 	if (ret && dst) {
     - 		src = dst->buf;
     - 		len = dst->len;
     -@@ convert.c: void convert_to_git_filter_fd(struct index_state *istate,
     - 	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN, NULL, NULL))
     - 		die(_("%s: clean filter '%s' failed"), path, ca.drv->name);
     - 
     --	encode_to_git(path, dst->buf, dst->len, dst, ca.working_tree_encoding, conv_flags);
     -+	encode_to_git(path, dst->buf, dst->len, dst, ca.working_tree_encoding, ca.attr_action, conv_flags);
     - 	crlf_to_git(istate, path, dst->buf, dst->len, dst, ca.crlf_action, conv_flags);
     - 	ident_to_git(dst->buf, dst->len, dst, ca.ident);
     - }
     -@@ convert.c: static int convert_to_working_tree_ca_internal(const struct conv_attrs *ca,
     - 		}
     - 	}
     - 
     --	ret |= encode_to_worktree(path, src, len, dst, ca->working_tree_encoding);
     -+	ret |= encode_to_worktree(path, src, len, dst, ca->attr_action, ca->working_tree_encoding);
     - 	if (ret) {
     - 		src = dst->buf;
     - 		len = dst->len;
     -
       ## copy.c ##
      @@ copy.c: int copy_fd(int ifd, int ofd)
       		if (write_in_full(ofd, buffer, len) < 0)
       			return COPY_WRITE_ERROR;
       	}
     -+#ifdef __MVS__
     -+  __copyfdccsid(ifd, ofd);
     -+#endif
     ++	#ifdef __MVS__
     ++		/*
     ++		 * This is to ensure that file tags are copied
     ++		 * from source to destination
     ++		 */
     ++		__copyfdccsid(ifd, ofd);
     ++	#endif
       	return 0;
       }
       
      
     - ## diff.c ##
     -@@ diff.c: int diff_populate_filespec(struct repository *r,
     - 	int check_binary = options ? options->check_binary : 0;
     - 	int err = 0;
     - 	int conv_flags = global_conv_flags_eol;
     -+#ifdef __MVS__
     -+	int autocvtToASCII;
     -+#endif
     - 	/*
     - 	 * demote FAIL to WARN to allow inspecting the situation
     - 	 * instead of refusing.
     -@@ diff.c: int diff_populate_filespec(struct repository *r,
     - 			s->is_binary = 1;
     - 			return 0;
     - 		}
     -+#ifdef __MVS__
     -+    validate_codeset(r->index, s->path, &autocvtToASCII);
     -+#endif
     - 		fd = open(s->path, O_RDONLY);
     - 		if (fd < 0)
     - 			goto err_empty;
     -+
     -+#ifdef __MVS__
     -+    if (!autocvtToASCII)
     -+      __disableautocvt(fd);
     -+#endif
     - 		s->data = xmmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
     - 		close(fd);
     - 		s->should_munmap = 1;
     -
     - ## entry.c ##
     -@@ entry.c: int fstat_checkout_output(int fd, const struct checkout *state, struct stat *st)
     - 	return 0;
     + ## fetch-negotiator.h ##
     +@@ fetch-negotiator.h: struct repository;
     +  * Then, when "have" lines are required, call next(). Call ack() to report what
     +  * the server tells us.
     +  *
     +- * Once negotiation is done, call release(). The negotiator then cannot be used
     ++ * Once negotiation is done, call release_negotiator(). The negotiator then cannot be used
     +  * (unless reinitialized with fetch_negotiator_init()).
     +  */
     + struct fetch_negotiator {
     +@@ fetch-negotiator.h: struct fetch_negotiator {
     + 	 */
     + 	int (*ack)(struct fetch_negotiator *, struct commit *);
     + 
     +-	void (*release)(struct fetch_negotiator *);
     ++	void (*release_negotiator)(struct fetch_negotiator *);
     + 
     + 	/* internal use */
     + 	void *data;
     +
     + ## fetch-pack.c ##
     +@@ fetch-pack.c: static struct ref *do_fetch_pack(struct fetch_pack_args *args,
     + 
     +  all_done:
     + 	if (negotiator)
     +-		negotiator->release(negotiator);
     ++		negotiator->release_negotiator(negotiator);
     + 	return ref;
       }
       
     -+#ifdef __MVS__
     -+void tag_file_as_working_tree_encoding(struct index_state *istate, char* path, int fd) {
     -+	struct conv_attrs ca;
     -+	convert_attrs(istate, &ca, path);
     -+  if (ca.attr_action != CRLF_BINARY) {
     -+    if (ca.working_tree_encoding)
     -+      __chgfdcodeset(fd, ca.working_tree_encoding);
     -+    else
     -+      __setfdtext(fd);
     -+  }
     -+  else {
     -+    __setfdbinary(fd);
     -+  }
     -+
     -+  __disableautocvt(fd);
     -+}
     -+#endif
     -+
     - static int streaming_write_entry(const struct cache_entry *ce, char *path,
     - 				 struct stream_filter *filter,
     - 				 const struct checkout *state, int to_tempfile,
     -@@ entry.c: static int streaming_write_entry(const struct cache_entry *ce, char *path,
     - 	if (fd < 0)
     - 		return -1;
     +@@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
     + 		die("fsck failed");
       
     -+#ifdef __MVS__
     -+  tag_file_as_working_tree_encoding(state->istate, path, fd);
     -+#endif
     -+
     - 	result |= stream_blob_to_fd(fd, &ce->oid, filter, 1);
     - 	*fstat_done = fstat_checkout_output(fd, state, statbuf);
     - 	result |= close(fd);
     -@@ entry.c: static int write_entry(struct cache_entry *ce, char *path, struct conv_attrs *ca
     - 			return error_errno("unable to create file %s", path);
     - 		}
     + 	if (negotiator)
     +-		negotiator->release(negotiator);
     ++		negotiator->release_negotiator(negotiator);
       
     -+#ifdef __MVS__
     -+    tag_file_as_working_tree_encoding(state->istate, path, fd);
     -+#endif
     -+
     - 		wrote = write_in_full(fd, new_blob, size);
     - 		if (!to_tempfile)
     - 			fstat_done = fstat_checkout_output(fd, state, &st);
     -
     - ## environment.c ##
     -@@ environment.c: const char *git_hooks_path;
     - int zlib_compression_level = Z_BEST_SPEED;
     - int pack_compression_level = Z_DEFAULT_COMPRESSION;
     - int fsync_object_files = -1;
     -+#ifdef __MVS__
     -+int ignore_file_tags = 0;
     -+#endif
     - int use_fsync = -1;
     - enum fsync_method fsync_method = FSYNC_METHOD_DEFAULT;
     - enum fsync_component fsync_components = FSYNC_COMPONENTS_DEFAULT;
     + 	oidset_clear(&common);
     + 	return ref;
      
       ## git-compat-util.h ##
      @@ git-compat-util.h: struct strbuf;
     @@ git-compat-util.h: struct strbuf;
       #include <fcntl.h>
       #include <stddef.h>
      +#ifdef __MVS__
     -+#define release stdlib_release
     -+#define fetch stdlib_fetch
     ++	#define release stdlib_release
     ++	#define fetch stdlib_fetch
      +#endif
       #include <stdlib.h>
      +#ifdef __MVS__
     -+#undef fetch
     -+#undef release
     ++	#undef fetch
     ++	#undef release
      +#endif
       #include <stdarg.h>
       #include <string.h>
     @@ negotiator/noop.c: static int ack(struct fetch_negotiator *n UNUSED, struct comm
       }
       
      -static void release(struct fetch_negotiator *n UNUSED)
     -+static void release_negotiator(struct fetch_negotiator *n UNUSED)
     ++static void release_negotiator (struct fetch_negotiator *n UNUSED)
       {
       	/* nothing to release */
       }
     @@ negotiator/skipping.c: void skipping_negotiator_init(struct fetch_negotiator *ne
       	data->rev_list.compare = compare;
       
      
     - ## object-file.c ##
     -@@
     - #include "setup.h"
     - #include "submodule.h"
     - #include "fsck.h"
     --
     -+#ifdef __MVS__
     -+#include <_Ccsid.h>
     -+#endif
     - /* The maximum size for an object header. */
     - #define MAX_HEADER_LEN 32
     - 
     -@@ object-file.c: int index_fd(struct index_state *istate, struct object_id *oid,
     - 	return ret;
     - }
     - 
     -+#ifdef __MVS__
     -+void validate_codeset(struct index_state *istate, const char *path, int* autoconvertToASCII) {
     -+       struct conv_attrs ca;
     -+  struct stat st;
     -+  unsigned short attr_ccsid;
     -+  unsigned short file_ccsid;
     -+
     -+  if (ignore_file_tags)
     -+   return;
     -+
     -+  *autoconvertToASCII = 0;
     -+       convert_attrs(istate, &ca, path);
     -+  if (ca.attr_action == CRLF_BINARY) {
     -+    attr_ccsid = FT_BINARY;
     -+  }
     -+  else if (ca.working_tree_encoding) {
     -+    attr_ccsid = __toCcsid(ca.working_tree_encoding);
     -+  }
     -+  else
     -+    attr_ccsid = 819;
     -+
     -+  if (stat(path, &st) < 0)
     -+    return;
     -+
     -+  file_ccsid = st.st_tag.ft_ccsid;
     -+
     -+  if (file_ccsid == FT_UNTAGGED) {
     -+    die("File %s is untagged, set the correct file tag (using the chtag command).", path);
     -+  }
     -+
     -+  if (attr_ccsid != file_ccsid) {
     -+    if (file_ccsid == 1047 && attr_ccsid == 819) {
     -+      *autoconvertToASCII = 1;
     -+      return;
     -+    }
     -+    // Allow tag mixing of 819 and 1208
     -+    if ((file_ccsid == 819 || file_ccsid == 1208) && (attr_ccsid == 1208 || attr_ccsid == 819)) {
     -+      return;
     -+    }
     -+    // Don't check for binary files, just add them
     -+    if (attr_ccsid == FT_BINARY)
     -+      return;
     -+
     -+    char attr_csname[_XOPEN_PATH_MAX] = {0};
     -+    char file_csname[_XOPEN_PATH_MAX] = {0};
     -+    if (attr_ccsid != FT_BINARY) {
     -+      __toCSName(attr_ccsid, attr_csname);
     -+    } else {
     -+      snprintf(attr_csname, _XOPEN_PATH_MAX, "%s", "binary");
     -+    }
     -+    if (file_ccsid != FT_BINARY) {
     -+      __toCSName(file_ccsid, file_csname);
     -+    } else {
     -+      snprintf(file_csname, _XOPEN_PATH_MAX, "%s", "binary");
     -+    }
     -+    die("%s added file: file tag (%s) does not match working-tree-encoding (%s)", path, file_csname, attr_csname);
     -+  }
     -+}
     -+#endif
     -+
     -+
     -+
     - int index_path(struct index_state *istate, struct object_id *oid,
     - 	       const char *path, struct stat *st, unsigned flags)
     - {
     -@@ object-file.c: int index_path(struct index_state *istate, struct object_id *oid,
     - 	struct strbuf sb = STRBUF_INIT;
     - 	int rc = 0;
     - 
     -+#ifdef __MVS__
     -+	struct conv_attrs ca;
     -+	int autocvtToASCII;
     -+#endif
     -+
     - 	switch (st->st_mode & S_IFMT) {
     - 	case S_IFREG:
     -+#ifdef __MVS__
     -+    validate_codeset(istate, path, &autocvtToASCII);
     -+#endif
     - 		fd = open(path, O_RDONLY);
     - 		if (fd < 0)
     - 			return error_errno("open(\"%s\")", path);
     -+
     -+#ifdef __MVS__
     -+   if (!autocvtToASCII)
     -+     __disableautocvt(fd);
     -+#endif
     -+
     - 		if (index_fd(istate, oid, fd, st, OBJ_BLOB, path, flags) < 0)
     - 			return error(_("%s: failed to insert into database"),
     - 				     path);
     -
       ## read-cache.c ##
      @@ read-cache.c: static int ce_compare_data(struct index_state *istate,
       	int fd = git_open_cloexec(ce->name, O_RDONLY);
       
       	if (fd >= 0) {
     -+#ifdef __MVS__
     -+    __disableautocvt(fd);
     -+#endif
     ++	#ifdef __MVS__
     ++		/*
     ++		 * Since the data is in binary format,
     ++		 * we need to set the z/OS file tag to
     ++		 * binary to disable autoconversion
     ++		 */
     ++		__disableautocvt(fd);
     ++	#endif
       		struct object_id oid;
       		if (!index_fd(istate, &oid, fd, st, OBJ_BLOB, ce->name, 0))
       			match = !oideq(&oid, &ce->oid);
     -
     - ## utf8.c ##
     -@@ utf8.c: char *reencode_string_len(const char *in, size_t insz,
     - #endif
     - 	}
     - 
     -+#ifdef __MVS__
     -+  //HACK: For backwards compat, ISO8859-1 really means utf-8 in the z/OS world
     -+  if (strcasecmp("ISO8859-1", in_encoding) == 0) {
     -+    in_encoding = "UTF-8";
     -+    out_encoding = "UTF-8";
     -+  }
     -+  if (strcasecmp("ISO8859-1", out_encoding) == 0) {
     -+    in_encoding = "UTF-8";
     -+    out_encoding = "UTF-8";
     -+  }
     -+#endif
     - 	conv = iconv_open(out_encoding, in_encoding);
     - 	if (conv == (iconv_t) -1) {
     - 		in_encoding = fallback_encoding(in_encoding);
  3:  e31be0d764f <  -:  ----------- spaces and errors fix Handled git pipeline errors
  4:  7bace397b4a <  -:  ----------- fixes for build errors Handled git pipeline errorse
  5:  3b6d1f80668 <  -:  ----------- fixes for build errors
  6:  3c9b02e18d2 <  -:  ----------- spaces and errors fix Handled git pipeline errors
  7:  8165196f869 <  -:  ----------- spaces and errors fix Handled git pipeline errors
  8:  9fb74d92e3f <  -:  ----------- platform_name fix Handled git pipeline errors
  9:  8fa15ac45f7 <  -:  ----------- strncpy fix Handled git pipeline errors
 10:  63479fe3696 <  -:  ----------- strncpy fix Handled git pipeline errors
 11:  25271363e57 <  -:  ----------- strncpy fix Handled git pipeline errors
 12:  06658ebad10 <  -:  ----------- Handled git pipeline errors - Memory leak
 13:  804624950ae <  -:  ----------- Handled git pipeline errors - z/OS enable


 builtin/archive.c     | 9 +++++++++
 builtin/hash-object.c | 8 ++++++++
 combine-diff.c        | 8 ++++++++
 copy.c                | 7 +++++++
 fetch-negotiator.h    | 4 ++--
 fetch-pack.c          | 4 ++--
 git-compat-util.h     | 8 ++++++++
 negotiator/default.c  | 4 ++--
 negotiator/noop.c     | 4 ++--
 negotiator/skipping.c | 4 ++--
 read-cache.c          | 8 ++++++++
 11 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index 90761fdfee0..3b1b258e383 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -14,6 +14,15 @@
 static void create_output_file(const char *output_file)
 {
 	int output_fd = xopen(output_file, O_CREAT | O_WRONLY | O_TRUNC, 0666);
+#ifdef __MVS__
+	/*
+	 * Since the data is in binary format,
+	 * we need to set the z/OS file tag
+	 * to binary to disable autoconversion
+	 */
+	if (__setfdbinary(output_fd))
+		die_errno(_("could not tag archive file '%s'"), output_file);
+#endif
 	if (output_fd != 1) {
 		if (dup2(output_fd, 1) < 0)
 			die_errno(_("could not redirect output"));
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 5ffec99dcea..f43450db02d 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -62,6 +62,14 @@ static void hash_object(const char *path, const char *type, const char *vpath,
 {
 	int fd;
 	fd = xopen(path, O_RDONLY);
+#ifdef __MVS__
+	/*
+	 * Since the data being read is in binary format,
+	 * we need to disable autoconversion for z/OS
+	 */
+	if (__setfdbinary(fd))
+		die_errno("Cannot set to binary '%s'", path);
+#endif
 	hash_fd(fd, type, vpath, flags, literally);
 }
 
diff --git a/combine-diff.c b/combine-diff.c
index f90f4424829..3230b660371 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1082,6 +1082,14 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			ssize_t done;
 			int is_file, i;
 
+		#ifdef __MVS__
+			/*
+			 * Disable implicit autconversion on z/os,
+			 * rely on conversion from iconv
+			 */
+			__disableautocvt(fd);
+		#endif
+
 			elem->mode = canon_mode(st.st_mode);
 			/* if symlinks don't work, assume symlink if all parents
 			 * are symlinks
diff --git a/copy.c b/copy.c
index 23d84c6c1db..f5b9828b1c9 100644
--- a/copy.c
+++ b/copy.c
@@ -14,6 +14,13 @@ int copy_fd(int ifd, int ofd)
 		if (write_in_full(ofd, buffer, len) < 0)
 			return COPY_WRITE_ERROR;
 	}
+	#ifdef __MVS__
+		/*
+		 * This is to ensure that file tags are copied
+		 * from source to destination
+		 */
+		__copyfdccsid(ifd, ofd);
+	#endif
 	return 0;
 }
 
diff --git a/fetch-negotiator.h b/fetch-negotiator.h
index e348905a1f0..71d44102fdc 100644
--- a/fetch-negotiator.h
+++ b/fetch-negotiator.h
@@ -14,7 +14,7 @@ struct repository;
  * Then, when "have" lines are required, call next(). Call ack() to report what
  * the server tells us.
  *
- * Once negotiation is done, call release(). The negotiator then cannot be used
+ * Once negotiation is done, call release_negotiator(). The negotiator then cannot be used
  * (unless reinitialized with fetch_negotiator_init()).
  */
 struct fetch_negotiator {
@@ -47,7 +47,7 @@ struct fetch_negotiator {
 	 */
 	int (*ack)(struct fetch_negotiator *, struct commit *);
 
-	void (*release)(struct fetch_negotiator *);
+	void (*release_negotiator)(struct fetch_negotiator *);
 
 	/* internal use */
 	void *data;
diff --git a/fetch-pack.c b/fetch-pack.c
index 26999e3b659..c1f2e714f8e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1232,7 +1232,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 
  all_done:
 	if (negotiator)
-		negotiator->release(negotiator);
+		negotiator->release_negotiator(negotiator);
 	return ref;
 }
 
@@ -1853,7 +1853,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		die("fsck failed");
 
 	if (negotiator)
-		negotiator->release(negotiator);
+		negotiator->release_negotiator(negotiator);
 
 	oidset_clear(&common);
 	return ref;
diff --git a/git-compat-util.h b/git-compat-util.h
index 3e7a59b5ff1..be4516fa64e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -223,7 +223,15 @@ struct strbuf;
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <stddef.h>
+#ifdef __MVS__
+	#define release stdlib_release
+	#define fetch stdlib_fetch
+#endif
 #include <stdlib.h>
+#ifdef __MVS__
+	#undef fetch
+	#undef release
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
index de39028ab7f..b2d555e0fec 100644
--- a/negotiator/noop.c
+++ b/negotiator/noop.c
@@ -30,7 +30,7 @@ static int ack(struct fetch_negotiator *n UNUSED, struct commit *c UNUSED)
 	return 0;
 }
 
-static void release(struct fetch_negotiator *n UNUSED)
+static void release_negotiator (struct fetch_negotiator *n UNUSED)
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
 
diff --git a/read-cache.c b/read-cache.c
index 080bd39713b..b7189c58144 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -205,6 +205,14 @@ static int ce_compare_data(struct index_state *istate,
 	int fd = git_open_cloexec(ce->name, O_RDONLY);
 
 	if (fd >= 0) {
+	#ifdef __MVS__
+		/*
+		 * Since the data is in binary format,
+		 * we need to set the z/OS file tag to
+		 * binary to disable autoconversion
+		 */
+		__disableautocvt(fd);
+	#endif
 		struct object_id oid;
 		if (!index_fd(istate, &oid, fd, st, OBJ_BLOB, ce->name, 0))
 			match = !oideq(&oid, &ce->oid);

base-commit: 564d0252ca632e0264ed670534a51d18a689ef5d
-- 
gitgitgadget
