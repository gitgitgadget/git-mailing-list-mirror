Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D06C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 11:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbhK3L6Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 06:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236669AbhK3L6N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 06:58:13 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0318C061748
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 03:54:53 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p18so17185107wmq.5
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 03:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9Ejg+jt4xVscGt18Qdg892vaZletSiZ1QxqdhJa+MTg=;
        b=CgRD3leWIOJ1OQEDNkVNCmTD5xGPoA26jz/wnJJFXYCD8Baw8svj2iE1dM0A7bHGRy
         MfmKLtY9TIFhazyo/Zl7sLCCpYbs3GHoo9GwdRVF7sMReA3Gul+XY38brpL8Q5TS7eYs
         c9eIbtX5628doGLNuu5N0/wz47IF6NV9+SNGvPpGur5yjyfvQ+Ca16m6Hjvu0cgjHgWw
         vL8MBNh5NVCOk33zL0E6IZb6ZXp5tBw8OsbdqNuxOsgbULyrqwLq7dbhYPhCax5lGGCZ
         z8sE1Fa/ec8RTlEfjopk8OxUdFPVHHNv2PaX7ZPNfPRImXuXviozkxkLdoK5QVSydt8l
         lZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9Ejg+jt4xVscGt18Qdg892vaZletSiZ1QxqdhJa+MTg=;
        b=VvG1GZTpqx2tC6c3LDYpihlfganD1J6bucxwr+IS3CKhKEhiviNfUK7+SvOvz9ucKu
         GI/0qV6PJBQnrK8VmxC+4uWus8aew3ZOcKFZasRbCMunkFC/YItfpqrEGnM5cWRBYrIP
         OixRg7QOkSwVJXbT9lqsBFWBDjm6bFtCgexyRgON6AZwLKBZbc8hSCbpI9UQWJddJ1+r
         75GjrdMBR7fnnaORUyaUCRWJTHQ6v0IMlegQl1dJX/aSvBgvLBn+YQ9oZ4+dUMqwlUXM
         W9OkMfArBqXPu+k0dcAon5hNNGP6mSNrMe30aby5NX3GkqbQM9a/MLIQCdcEu6xdOl9Y
         qb6Q==
X-Gm-Message-State: AOAM530o3bcjAYYSi2vO4SNFckqhifvhf22W652zjezkEjm1a2wbtFj5
        Jjwune2agYRslalBZ2a5exQ6FPo6slI=
X-Google-Smtp-Source: ABdhPJxnIprCS5DXEqYjiJLfVU0npsnj5eeU1EXTscBE4mkQQCiJ+y2lGEcSfE0LBgy2a4Z0xhDa5A==
X-Received: by 2002:a1c:a592:: with SMTP id o140mr4415160wme.10.1638273292337;
        Tue, 30 Nov 2021 03:54:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n7sm15991992wro.68.2021.11.30.03.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 03:54:52 -0800 (PST)
Message-Id: <50160d61a41c182d9b8c6c859975f89415de8482.1638273289.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
References: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
        <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Nov 2021 11:54:34 +0000
Subject: [PATCH v9 02/17] scalar: create a rudimentary executable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The idea of Scalar (https://github.com/microsoft/scalar), and before
that, of VFS for Git, has always been to prove that Git _can_ scale, and
to upstream whatever strategies have been demonstrated to help.

With this patch, we start the journey from that C# project to move what
is left to Git's own `contrib/` directory, reimplementing it in pure C,
with the intention to facilitate integrating the functionality into core
Git all while maintaining backwards-compatibility for existing Scalar
users (which will be much easier when both live in the same worktree).
It has always been the plan to contribute all of the proven strategies
back to core Git.

For example, while the virtual filesystem provided by VFS for Git helped
the team developing the Windows operating system to move onto Git, while
trying to upstream it we realized that it cannot be done: getting the
virtual filesystem to work (which we only managed to implement fully on
Windows, but not on, say, macOS or Linux), and the required server-side
support for the GVFS protocol, made this not quite feasible.

The Scalar project learned from that and tackled the problem with
different tactics: instead of pretending to Git that the working
directory is fully populated, it _specifically_ teaches Git about
partial clone (which is based on VFS for Git's cache server), about
sparse checkout (which VFS for Git tried to do transparently, in the
file system layer), and regularly runs maintenance tasks to keep the
repository in a healthy state.

With partial clone, sparse checkout and `git maintenance` having been
upstreamed, there is little left that `scalar.exe` does which `git.exe`
cannot do. One such thing is that `scalar clone <url>` will
automatically set up a partial, sparse clone, and configure
known-helpful settings from the start.

So let's bring this convenience into Git's tree.

The idea here is that you can (optionally) build Scalar via

	make -C contrib/scalar/

This will build the `scalar` executable and put it into the
contrib/scalar/ subdirectory.

The slightly awkward addition of the `contrib/scalar/*` bits to the
top-level `Makefile` are actually really required: we want to link to
`libgit.a`, which means that we will need to use the very same `CFLAGS`
and `LDFLAGS` as the rest of Git.

An early development version of this patch tried to replicate all the
conditional code in `contrib/scalar/Makefile` (e.g. `NO_POLL`) just like
`contrib/svn-fe/Makefile` used to do before it was retired. It turned
out to be quite the whack-a-mole game: the SHA-1-related flags, the
flags enabling/disabling `compat/poll/`, `compat/regex/`,
`compat/win32mmap.c` & friends depending on the current platform... To
put it mildly: it was a major mess.

Instead, this patch makes minimal changes to the top-level `Makefile` so
that the bits in `contrib/scalar/` can be compiled and linked, and
adds a `contrib/scalar/Makefile` that uses the top-level `Makefile` in a
most minimal way to do the actual compiling.

Note: With this commit, we only establish the infrastructure, no
Scalar functionality is implemented yet; We will do that incrementally
over the next few commits.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile                  |  9 +++++++++
 contrib/scalar/.gitignore |  2 ++
 contrib/scalar/Makefile   | 34 ++++++++++++++++++++++++++++++++++
 contrib/scalar/scalar.c   | 36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+)
 create mode 100644 contrib/scalar/.gitignore
 create mode 100644 contrib/scalar/Makefile
 create mode 100644 contrib/scalar/scalar.c

diff --git a/Makefile b/Makefile
index 12be39ac497..fe898aeea08 100644
--- a/Makefile
+++ b/Makefile
@@ -2456,6 +2456,11 @@ OBJECTS += $(FUZZ_OBJS)
 ifndef NO_CURL
 	OBJECTS += http.o http-walker.o remote-curl.o
 endif
+
+SCALAR_SOURCES := contrib/scalar/scalar.c
+SCALAR_OBJECTS := $(SCALAR_SOURCES:c=o)
+OBJECTS += $(SCALAR_OBJECTS)
+
 .PHONY: objects
 objects: $(OBJECTS)
 
@@ -2589,6 +2594,10 @@ $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
+contrib/scalar/scalar$X: $(SCALAR_OBJECTS) GIT-LDFLAGS $(GITLIBS)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
+		$(filter %.o,$^) $(LIBS)
+
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
diff --git a/contrib/scalar/.gitignore b/contrib/scalar/.gitignore
new file mode 100644
index 00000000000..ff3d47e84d0
--- /dev/null
+++ b/contrib/scalar/.gitignore
@@ -0,0 +1,2 @@
+/*.exe
+/scalar
diff --git a/contrib/scalar/Makefile b/contrib/scalar/Makefile
new file mode 100644
index 00000000000..f6f0036f0fa
--- /dev/null
+++ b/contrib/scalar/Makefile
@@ -0,0 +1,34 @@
+QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
+QUIET_SUBDIR1  =
+
+ifneq ($(findstring s,$(MAKEFLAGS)),s)
+ifndef V
+	QUIET_SUBDIR0  = +@subdir=
+	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
+			 $(MAKE) $(PRINT_DIR) -C $$subdir
+else
+	export V
+endif
+endif
+
+all:
+
+include ../../config.mak.uname
+-include ../../config.mak.autogen
+-include ../../config.mak
+
+TARGETS = scalar$(X) scalar.o
+GITLIBS = ../../common-main.o ../../libgit.a ../../xdiff/lib.a
+
+all: scalar$(X)
+
+$(GITLIBS):
+	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) $(subst ../../,,$@)
+
+$(TARGETS): $(GITLIBS) scalar.c
+	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) $(patsubst %,contrib/scalar/%,$@)
+
+clean:
+	$(RM) $(TARGETS)
+
+.PHONY: $(GITLIBS) all clean FORCE
diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
new file mode 100644
index 00000000000..7cff29e0fcd
--- /dev/null
+++ b/contrib/scalar/scalar.c
@@ -0,0 +1,36 @@
+/*
+ * The Scalar command-line interface.
+ */
+
+#include "cache.h"
+#include "gettext.h"
+#include "parse-options.h"
+
+static struct {
+	const char *name;
+	int (*fn)(int, const char **);
+} builtins[] = {
+	{ NULL, NULL},
+};
+
+int cmd_main(int argc, const char **argv)
+{
+	struct strbuf scalar_usage = STRBUF_INIT;
+	int i;
+
+	if (argc > 1) {
+		argv++;
+		argc--;
+
+		for (i = 0; builtins[i].name; i++)
+			if (!strcmp(builtins[i].name, argv[0]))
+				return !!builtins[i].fn(argc, argv);
+	}
+
+	strbuf_addstr(&scalar_usage,
+		      N_("scalar <command> [<options>]\n\nCommands:\n"));
+	for (i = 0; builtins[i].name; i++)
+		strbuf_addf(&scalar_usage, "\t%s\n", builtins[i].name);
+
+	usage(scalar_usage.buf);
+}
-- 
gitgitgadget

