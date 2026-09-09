Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391373921C6
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788983429; cv=none; b=TvS6UvmChRaXIJRrwMoWKYb0pNohTrglbLh83TjkXdSkPpJbL6ZJgeBZzewN6+2IWk+fwY4kvZGvVO20BAfVgrJwc1/r8D0i5b7Zs3qZe93um1zRVhUlb35uBkS30VO/0GqyBH0xs2yMcvEPuHRf5+KGMlLWD0Ah5/DWqaHty1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788983429; c=relaxed/simple;
	bh=CQVXmJoLFNYhzXsV6e/77vLRWqwAX7JbjZuPHG/Q5W0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/q5MqGBrOBpY4lq2rKRqHEvDqmndAOpK6YnGWOeIGW9bgHjPhT9Mp7QLQDoeBPH4RSsPNP5cZ4+EATYeeHa3ZTQiwPJIBrBDCj6gBTGNgHF7/VCaigiaJy4sbivmdUxhpPxmFPwzUIWEg48l8wWdk1NokvsoVTEOB1gyRGYSTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFni0hgs; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFni0hgs"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c293ae2bab5so124294166b.0
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 12:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788983425; x=1789588225; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/+YBdQu5U7+lPDd/XfhWeFG/BzKuRHTKqaxP2F0M4zw=;
        b=VFni0hgsHMgMie/U+E/Wrt2HltV9BSqqcsSIA7T43JzHUPnyLwIaH/wZDnFuPFF81a
         mcbAbWyt0Jk1zLS/axxKwInB7QWSfG4Iiip4Ph5VEhWIce3rRaeTAKrvhuY3bnrK4ThN
         5mcHeCxg2MUTklAnjA0PFSfIsrxldbkcvbUkNWMDGJme2WyOTqYpV77vpeZGlpx2brsd
         RC0MuRn3xlc/3Uh78lcEPVcbSgVTq50za/8QF885O8828RDBTzu9sbUykMo06JvKaOij
         ooeRpo/JKn6ysczpwRUoCzVck7NmobVSD5a8pSccuw97HG5Q+T8pQP5weGJ03+6L1kYC
         CoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788983425; x=1789588225;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/+YBdQu5U7+lPDd/XfhWeFG/BzKuRHTKqaxP2F0M4zw=;
        b=J0Bw0mgxRsk2H6ReN6uEO+CZQIp/uMAIHC1W0IMA3o2iXjEJ+1EwgEOJPAr95DTGKj
         k+DV0R85M97DJvM/6eEo5LK7C0GdsAEyseijr7T4Kj8jQSjUlT3a6G32RGk7hCWBqO4v
         lbXwh/KLJUV+jqR5gEQSd12kttHNdlUWO0hHdv8PR8gbABbOb8zFLPpGGjfCVdOhxlH0
         lkUCM/GAC41XiPTFtS+pB6aJW0vcFeNQ8fj4t24BicVscbqmz2ejRs7XkRBusBbD/WP0
         vuepRL9XqfH0L5Ieo5tPtCeauXkkTMADV9M1NNoDmTkvnui0t+gIHpZJ6IIzC2lB2eq5
         7UrQ==
X-Gm-Message-State: AFuF++lFXPB4inl5cFvcd210XAqUs6dlhJ0j7wKLc9TnDqFRGTd1rk2C
	3Vs5I0fhqUcMIBsAfOsfv6MOdy+B03pzLvJRVQh9TBY7pXnGzKyyX5Dz22IYdQ==
X-Gm-Gg: AYBFou1Dngw0LAFP3UrjnweF13b7q7UMqlSzCswpgRdP/x4RKM3wFwdFJoD7haIvRmt
	+yijZQy1ff6JtyGyHNY2jWPPwPSjPmoWifkhA9yRqz1jgWEVYOqjLw49CwvGukcgGvuJ8yvC7Lo
	8byq1vfLgDgRCLc9Sk2e3vLb4nOazaOH3nSbyru4kSl7hDEyz4Anoknt+08Gg3ETVUoSs8trYqN
	8J9Uo7mjDO0ctNYHEIR494s65CP3M8w9xJmpDEL+qUMdgTfaCL6A/XyBApylE0F6M0RsIc0vH29
	CSk67y6NcNVnG0KQqmS9o9C4IofgVrDXuNRvyYEYnN9QV17+RdDSufFM9WMWvfrGOH/q2Qax3EF
	G2SG39t82EBGn5r1GuR79BuQwLBWcfPl5NRxxfEpKsJblIjT6M5oFCJ+Ltl8L84E6X+OS5EDHEl
	Ri9fnZw+qabAWDAet3ErVmSWDbcHJAo5O6A4ly1/iPe0eqgBFQEbgSej94T/YB0LCAtlKnnMe0M
	wrSt0RhLdJnR1Lcn99LZE6k2331MW5PlzgLov4=
X-Received: by 2002:a17:907:3f87:b0:c25:833d:383e with SMTP id a640c23a62f3a-c260c9e245amr1460990466b.13.1788983425035;
        Wed, 09 Sep 2026 12:50:25 -0700 (PDT)
Received: from localhost (78-131-17-112.pool.digikabel.hu. [78.131.17.112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a9882a8510sm1668874a12.21.2026.09.09.12.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:50:23 -0700 (PDT)
From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 4/4] Makefile: precompile "git-compat-util.h"
Date: Wed,  9 Sep 2026 21:50:06 +0200
Message-ID: <20260909195006.2179119-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.55.0.1193.g1b994e35de
In-Reply-To: <20260909195006.2179119-1-szeder.dev@gmail.com>
References: <20260909195006.2179119-1-szeder.dev@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch follows the idea of 671df48df8 (meson: precompile
"git-compat-util.h", 2026-03-19) to make it faster to build Git using
"make".  The notable differences are the boilerplate needed to wire up
the precompiled header with "make", and the selection of object files
that are built using the precompiled header:

  - Add a new rule to precompile "tools/precompiled.h" into
    "tools/precompiled.h.gch".

    This rule and its dependencies are basically the same as our
    existing rule and its dependencies for compiling object files from
    our source files and, except that in this rule we don't use the
    EXTRA_CPPFLAGS target-specific variable.  This is partly because
    any compiler flags in that target-specific variable can't possibly
    make sense for the project-wide "git-compat-util.h", and partly
    because it could run afoul of "make"'s quirks with target-specific
    variables and GCC's "-Winvalid-pch" compiler option [1].

    Our Makefile always writes object files next to the source files
    they were compiled from.  Since a precompiled header is in many
    ways similar to an object file, let's follow suit and write it
    next to the header file it was created from as well.  671df48df8
    doesn't mention why "precompiled.h" was placed in "tools/".

    Use the ".gch" suffix for the precompiled header file, because
    that's the only suffix GCC looks for when searching for a
    precompiled header.  Clang apparently looks for both ".pch" and
    ".gch" suffixes.  If we ever encounter a compiler which only
    supports a different precompiled header suffix, then we might make
    the suffix configurable via a Makefile knob; but until then it
    remains hard-coded for the sake of simplicity.

  - Declare the precompiled header's dependencies, so it gets rebuilt
    when any of our header files it includes is modified.

    When using computed header dependencies, then the compiler can
    generate the Makefile snippet containing the header files inlcuded
    by the precompiled header, just like when compiling a C source
    file into an object file.

    When not using computed header dependencies, then make the
    precompiled header depend on the same header files that our object
    files depend on, i.e. those listed in LIB_H and GENERATED_H.  This
    is not ideal, because the precompiled header will be rebuilt even
    when a header file it doesn't actually depend on changes; but in
    that case all object files will be rebuilt as well anyway.

  - List the object files that are built using the precompiled header
    in the PRECOMPILED_HEADER_USERS variable:

    - The precompiled header should not change what actually gets
      compiled.  Therefore, use the precompiled header only when
      compiling source files that start with including
      "git-compat-util.h" (directly or indirectly, e.g. via
      "builtin.h"), or its inclusion is only preceeded by #define
      directives that don't influence "git-compat-util.h" between its
      include guards [2] (currently DISABLE_SIGN_COMPARE_WARNINGS,
      USE_THE_REPOSITORY_VARIABLE or GIT_TEST_PROGRESS_ONLY). [3]

      Several (but not all) object or source files listed in the
      COMPAT_OBJS, REFTABLE_OBJS and THIRD_PARTY_SOURCES variables
      don't include "git-compat-util.h", therefore, for the sake of
      simplicity, none of the files listed in these variables are
      built with the precompiled header. [4]

      Since 671df48df8 the Meson build uses the precompiled header
      even when compiling those reftable source files that don't
      include "git-compat-util.h" at all, although this change is not
      mentioned in the commit message.

    - But other than that, use the precompiled header when compiling
      all other source files, including e.g. source files for
      standalone executables (e.g. "daemon.c" for "git-daemon"), or
      those in the directories "t/helper/" and "t/unit-tests/" as
      well.

      The Meson build, however, only uses the precompiled header for
      compiling objects in "libgit_sources" and "builtin_sources",
      despite 671df48df8 giving the impression that the precompiled
      header is included in all compilation units.

    - In short, PRECOMPILED_HEADER_USERS contains all object files
      listed in OBJECTS, except those that are listed in COMPAT_OBJS,
      REFTABLE_OBJS or THIRD_PARTY_SOURCES as well.

  - Add a new rule to build object files listed in
    PRECOMPILED_HEADER_USERS with the precompiled header.

    This rule and its dependencies are basically the same as our
    existing rule and its dependencies compiling object files from our
    source files, except:

    - This rule depends on the precompiled header as well, to make
      sure that it's built before it is used.

    - Use the "-include tools/precompiled.h" option to make the
      precompiled header the first header in the compilation unit,
      because only then is it used to speed things up.

    - Use the "-Winvalid-pch" option to catch any issues when the
      precompiled header is present but can't be used for whatever
      reason.  While being unable to use the precompiled header would
      normally only result in a slower build, it is probably better
      that developers are made aware that simething is not quite
      right.  Meson uses this option as well when compiling a source
      file using the precompiled header.

      Note, that in case of such an issue with "-Winvalid-pch" we
      would get a warning for each object file that is build using the
      precompiled header, but together with "-Werror" (e.g. with
      DEVELOPER=1) it would fail the build.

    Object files not listed in PRECOMPILED_HEADER_USERS are built with
    the existing (and unchanged) rule for object files.

  - This way the precompiled header is compiled only once during
    the whole build process.

    The Meson build, however, currently compiles the precompiled
    header twice: once for "libgit_sources" and once for
    "builtin_sources", despite 671df48df8 giving the impression that
    it's compiled only once.  And, by the looks of it, it would have
    to be compiled once more for each new library or executable where
    we declare the use of the precompiled header.

  - Add the Makefile knob NO_PRECOMPILED_HEADER to make it possible to
    build without using the precompiled header for testing purposes,
    or for any compiler that might be out there that doesn't support
    the "-Winvalid-pch" option.

    Note, that when this knob is set then we merely leave
    PRECOMPILED_HEADER_USERS empty: this way nothing is built with the
    precompiled header, but "make clean NO_PRECOMPILED_HEADER=1" would
    still remove a leftover precompiled header file.

With this patch series on top of v2.55.0 I got the following build
time improvement:

  Benchmark 1: make -j12 (rev = v2.55.0)
    Time (mean ± σ):     29.414 s ±  0.031 s    [User: 254.786 s, System: 47.447 s]
    Range (min … max):   29.370 s … 29.470 s    10 runs

  Benchmark 2: make -j12 (rev = precompile)
    Time (mean ± σ):     21.725 s ±  0.047 s    [User: 186.047 s, System: 35.109 s]
    Range (min … max):   21.643 s … 21.768 s    10 runs

  Summary
    'make -j12 (rev = precompile)' ran
      1.35 ± 0.00 times faster than 'make -j12 (rev = v2.55.0)'

[1] "make" applies target-specific variables to the first target's
    dependencies as well.  So, if the rule creating the precompiled
    header included $(EXTRA_CPPFLAGS) as well, then we could get this:

      $ make -s clean
      $ make V=1 git
      gcc -o tools/precompiled.h.gch -c -MF [...] -DSHELL_PATH='"/bin/sh"' '-DGIT_HTML_PATH="share/doc/git-doc"' '-DGIT_MAN_PATH="share/man"' '-DGIT_INFO_PATH="share/info"' tools/precompiled.h
      gcc -o git.o -c -include tools/precompiled.h -Winvalid-pch -MF [...] -DSHELL_PATH='"/bin/sh"' '-DGIT_HTML_PATH="share/doc/git-doc"' '-DGIT_MAN_PATH="share/man"' '-DGIT_INFO_PATH="share/info"' git.c
      gcc -o builtin/add.o -c -include tools/precompiled.h -Winvalid-pch -MF [...] -DSHELL_PATH='"/bin/sh"'  builtin/add.c
      cc1: error: ./tools/precompiled.h.gch: not used because `GIT_MAN_PATH' not defined [-Werror=invalid-pch]
      cc1: all warnings being treated as errors
      make: *** [Makefile:2940: builtin/add.o] Error 1

    So in this case "git.o" is the first object file to be build, and
    since it has a target-specific EXTRA_CPPFLAGS and since it depends
    on the precompiled header, the precompiled header is built with
    the same EXTRA_CPPFLAGS as well.  But then "builtin/add.o" is
    built with empty EXTRA_CPPFLAGS, and GCC's sanity checks for the
    -Winvalid-pch option complain.  Clang apparently doesn't consider
    this to be an issue, and builds "git" just fine.

    Note, however, that if the first object file to be built is not
    "git.o" (or one of the other object files with target-specific
    EXTRA_CPPFLAGS), which is usually the case with e.g. "make all",
    then the precompiled header is built with empty EXTRA_CPPFLAGS,
    and then all is well.  Weird.  We already had issues with "make"
    and target-specific variables in the past, see a673cfede6
    (Makefile: Fix occasional GIT-CFLAGS breakage, 2010-03-19).
    The Meson build doesn't use target-specific variables, and the
    whole project needs to be rebuilt when e.g. "mandir" is changed,
    although this is not mentioned in 904339edbd (Introduce support
    for the Meson build system, 2024-12-06).

[2] See baa61e46da (git-compat-util.h: move warning infra to prepare
    for PCHs, 2026-03-19).

[3] This can be verified by simply scanning through the output of:

    {
            printf '%s\n' 'print-%:'
            printf '\t%s\n' '@printf "%s\n" $($*)'
    } >/tmp/printvars.mak
    for f in $(make -f /tmp/printvars.mak -f Makefile print-PRECOMPILED_HEADER_USERS)
    do
            f="${f%o}c"
            sed -n -E -e "s%# *(define|include).*%&    $f%p" -e '/# *include/q' "$f"
    done | sort

[4] "make"'s flexibility would allow us to separately list those
    object files that don't include "git-compat-util.h", but then on
    my (I assume fairly typical) Linux box the number of object files
    built using the precompiled header increases only by 9 (from 536
    to 545), which reduces the build time by about 1% (0.2s).
    Therefore, I don't think it's worth the churn.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 .gitignore |  1 +
 Makefile   | 26 +++++++++++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/.gitignore b/.gitignore
index 4da58c6754..0209bd16f2 100644
--- a/.gitignore
+++ b/.gitignore
@@ -233,6 +233,7 @@
 /.vscode/
 /tags
 /TAGS
+/tools/precompiled.h.gch
 /cscope*
 /compile_commands.json
 /.cache/
diff --git a/Makefile b/Makefile
index 2c4d6f4d4a..02162719db 100644
--- a/Makefile
+++ b/Makefile
@@ -321,6 +321,9 @@ include shared.mak
 # dependency rules.  The default is "auto", which means to use computed header
 # dependencies if your compiler is detected to support it.
 #
+# Define NO_PRECOMPILED_HEADER if you want to build Git without precompiling
+# "git-compat-util.h".
+#
 # Define NATIVE_CRLF if your platform uses CRLF for line endings.
 #
 # Define GIT_USER_AGENT if you want to change how git identifies itself during
@@ -2905,8 +2908,15 @@ endif
 .PHONY: objects
 objects: $(OBJECTS)
 
-dep_files := $(foreach f,$(OBJECTS),$(dir $f).depend/$(notdir $f).d)
-dep_dirs := $(addsuffix .depend,$(sort $(dir $(OBJECTS))))
+PRECOMPILED_HEADER := tools/precompiled.h
+PRECOMPILED_HEADER_GCH := $(addsuffix .gch,$(PRECOMPILED_HEADER))
+
+ifndef NO_PRECOMPILED_HEADER
+PRECOMPILED_HEADER_USERS := $(filter-out $(COMPAT_OBJS) $(REFTABLE_OBJS) $(patsubst %.c,%.o,$(THIRD_PARTY_SOURCES)),$(OBJECTS))
+endif
+
+dep_files := $(foreach f,$(OBJECTS) $(PRECOMPILED_HEADER_GCH),$(dir $f).depend/$(notdir $f).d)
+dep_dirs := $(addsuffix .depend,$(sort $(dir $(OBJECTS) $(PRECOMPILED_HEADER_GCH))))
 
 ifeq ($(uname_S),Darwin)
 	dep_dirs += $(addsuffix .depend,$(sort $(dir contrib/credential/osxkeychain/git-credential-osxkeychain.o)))
@@ -2940,7 +2950,13 @@ missing_compdb_dir =
 compdb_args =
 endif
 
-$(OBJECTS): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
+$(PRECOMPILED_HEADER_GCH): %.gch: % GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
+	$(QUIET_CC)$(CC) -o $@ -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $<
+
+$(PRECOMPILED_HEADER_USERS): %.o: %.c $(PRECOMPILED_HEADER_GCH) GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
+	$(QUIET_CC)$(CC) -o $*.o -c -include $(PRECOMPILED_HEADER) -Winvalid-pch $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
+
+$(filter-out $(PRECOMPILED_HEADER_USERS),$(OBJECTS)): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
 	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
 
 %.s: %.c GIT-CFLAGS FORCE
@@ -2954,7 +2970,7 @@ ifneq ($(dep_files_present),)
 include $(dep_files_present)
 endif
 else
-$(OBJECTS): $(LIB_H) $(GENERATED_H)
+$(OBJECTS) $(PRECOMPILED_HEADER_GCH): $(LIB_H) $(GENERATED_H)
 endif
 
 ifeq ($(GENERATE_COMPILATION_DATABASE),yes)
@@ -3908,7 +3924,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) GIT-TEST-SUITES
 	$(RM) po/git.pot po/git-core.pot
 	$(RM) git.rc git.res
-	$(RM) $(OBJECTS)
+	$(RM) $(OBJECTS) $(PRECOMPILED_HEADER_GCH)
 	$(RM) headless-git.o
 	$(RM) $(LIB_FILE)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS)
-- 
2.55.0.1193.g1b994e35de

