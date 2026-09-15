Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CE81FB1
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 06:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789452627; cv=none; b=Qp+pnNWQxgicVQEypB9JI5CuWKPWziCuqmUu6RgUWyoAmszEibmjHUDerktRO98x9NNawfah2hcfNdNI9ztwEa6SZtd/K6osa8OdakPu2vk4mF0bAz2xKyM+j3PmpPMuv38qvlfgwTfI6L8sDsG1QtdiyiDhs3x16otnT+Xxs7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789452627; c=relaxed/simple;
	bh=9vzq1YqMbjCRK6FNCuA2A6h+jJp1ewT2JIulsjT9MuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gw8xpEwnVNDkh7YGiKvAwn3f1y2y0VNPxFl2vjtpzF1Wy6vfXqQBIQ/TKopjqDmhTjXCcF61oUnB7xU3qGJmIDhrlhUh3HL8qqtH5vIgK+Xw//rsOVpI+WLFlWqTf/F5XcBEDEs3SDvfxIQNwl4+XMjAfEatDFoDs6r//LxXbKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwpB8Ogj; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwpB8Ogj"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6063d7daaso4486891a12.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 23:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789452624; x=1790057424; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z797o/cPrtzlsPCV4fOVjj1gboacfVxUP2vBmOg8nPE=;
        b=TwpB8Ogj8JLvv2I63xvxSJBaBgNe4kAKCkIaAzezmQSKzRWQHGpgTP/DdINxzBYk6a
         WImhGlYLVy2RwMnaRyylRNbrTejdtmzQ3vwqEmW5ydHgC+gigx3tb2S0M99bkYWkD8DV
         SOgDw8q90KFG/bOx798oVOOptQ1o8e7eJpGllQrFNPh8nhUC9479NdhuziVCb/1tGyKc
         0KEyRWxQPIxUmd8Vk1843FBIq/nAuxcxvMms2ypuG3Nu1CWgulV/qBY6zJUqdBG59ruS
         BHDXPjO9UF+oc+wKvZUqFZ1iI5p/vODgiVeuQfee3aZ3DuOotYVwAKjnzTn0pX4eDG3C
         c5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789452624; x=1790057424;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z797o/cPrtzlsPCV4fOVjj1gboacfVxUP2vBmOg8nPE=;
        b=aBR3NjR+xb6d8Gn9caxWsgeekB4wyqcxZ6QPhOQHAXc8qk3x8h8Wtx+mXm+NWNX55+
         ASh4pMhur6Flm8XIKiHK5oy5GX9ysXabo1o8QWfGSxahupxNQ0le9NoFMzvM73gcQCiw
         xhTGtNm0fKS8O7LfGLgGBW+O1R75QPN2ezMcnD1VgS83Dx7RsB1LTNlfQBjFi5OTbKmm
         +Q2A6SSx586wuZKmOhfY7kzuRAIOuweBGwZbchGhiC6KzB5y+9axQLIh1F+nyPiUMYgL
         4s1nShAtY1G0fyErpik5wIL7JIJmKOlzHelhnEax3UT+PhGNDycdLp9DLf+Ap3Ws3YIy
         uWWA==
X-Gm-Message-State: AFuF++nQWFheSJh9CLNwmisCiMT4tatcGj27Qjxi5wcmy4ZqGUjFgGqA
	Yj50UySLy4gcfyV7n4r9zuzjKjbFv0Zcy6rZ5ds+gO3txdAsIIDj+o/xysliJA==
X-Gm-Gg: AYBFou0FYvahgndlqbM8uiRir41q6WafYTd0Zxn0msCQUFdObOIB0cEt1AHx1s54Mey
	X/cjf7gzVyarRAhBoPTmT5MUNnLiRw7Pm2uqzaDtcDyDDQ+jX2PgKaEIXoxHgYR+H0QyP1Bkccc
	TIloX/5A/OMbTRnyt8Oa2rGjHuWSVQVJCkRtzSbgGEYSUjFMmEfXEGykJ6C08TYQqA1kY+ocpmq
	nrVAhQ4fP3pp0XTu4vy2xQwGCjtpZ2LUtSiB5nrb15S75NJ+hxxQBlUetdKktnQ6XDuZGan2eHE
	UOIdS4xQs7e96aYEPZpKJ9E8T81lVN8Zn/RZWJtE5LVBcKx+CD1gLWdTyWN9eP9O6qxyu88Ayjo
	zyHlJtd40Wz89JHrT6BiWmKRUe/yQso6fLbJEzTjVmwejLsPVHkn7jeo5ChZrTgq/KYgAs8Z7ds
	SZqfsM2Yl7LyH8Fg7lpZU97cWCq82CKMWZVZ8q0UYQzJ6XeTxVt4RvJ7kjoa9j2TMsOx9AdGoh1
	9x2iiEQbmBBNY1hwFhpWDohk5pn
X-Received: by 2002:a05:6402:28ca:b0:6a4:21c6:1d14 with SMTP id 4fb4d7f45d1cf-6a9f6158395mr7442177a12.0.1789452623299;
        Mon, 14 Sep 2026 23:10:23 -0700 (PDT)
Received: from localhost (78-131-17-112.pool.digikabel.hu. [78.131.17.112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a9b5920f4asm5054267a12.16.2026.09.14.23.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 23:10:21 -0700 (PDT)
From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 4/4] Makefile: precompile "git-compat-util.h"
Date: Tue, 15 Sep 2026 08:09:52 +0200
Message-ID: <20260915060952.569535-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.56.0.rc0.467.ge054dd0dd6
In-Reply-To: <20260915060952.569535-1-szeder.dev@gmail.com>
References: <20260909195006.2179119-1-szeder.dev@gmail.com>
 <20260915060952.569535-1-szeder.dev@gmail.com>
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
2.56.0.rc0.467.ge054dd0dd6

