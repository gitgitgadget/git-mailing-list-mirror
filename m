Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123F3ECAAD3
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 16:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbiHaQDY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 12:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiHaQCu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 12:02:50 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDEDCD784
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:02:42 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so11958889wmk.3
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=f4+KVXtYQADQWYr3muKlEl+8wqKMyzhhSgGPvikqpOg=;
        b=f6ieRIUQeR8gWiEpHo+CbkiATzIAPqY9o6kTSBvJK+eETAeCi3lhn1NMRgUYa6yHnK
         v7MnmBBVzYY62zN1L1uUoaJUs5YAQVTFJKQZ1wKxddktZrLT6P4tzaggPTWZNy0ufqLh
         X98P5IYRa+RXYCoU39IDa0sUL7KIulrrWxW9gL8sZpkY/XQdDzpDtQuRIkCI/18DX1ML
         8n00QiNMqRHsXOA5sTkH0MMbhtdjVQNfiDaVu6ZqhFRlTmNVH1eMRGtYFFMPYLXfKktW
         Dvuy81nVVRBDy2sJ4MCGnNwUc84CVzkl+8kTtnyP6DKnk+SFtYAB/abXKwsSuDYSKxK2
         gWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=f4+KVXtYQADQWYr3muKlEl+8wqKMyzhhSgGPvikqpOg=;
        b=kRwxwLHNBpzGF1K8tM/YuiLyP8yM/gSTWTGuCz/yfgKlHjzbYQxwpJelG7w/8cPsTO
         BapDtDl2FSnmUB6itiyovbvosyEXDZaIqbrx//TC7SqN6LlsryzzL7vedfbuPNzM/hvf
         wFUN8xWejAZ+DoeSEEiCGptjaySnxpmZEZ8uEeFOqIY1HNBZUKe3/KEgEuBGfN2nm2Nc
         y3i1O+quRwcDlfHhfa7GWXp8SDRx9FY260rc9w3pOrW+eksvyoatMVLMnuiFq2BtxxXu
         sFTJDCw4hVI5KYE71y76V1RDT+0XA1gIH3pzPwadt2r47xZmlTZIu5Gz3NtvEc3Cf1Jz
         iosA==
X-Gm-Message-State: ACgBeo0ZA1xRtUU7OuS29Y786zswv7P1bywToLY8O/uGbA0+Sd1uNtDi
        2CWTAWDrASCU/OmPqFTFaU/pllGB+a4=
X-Google-Smtp-Source: AA6agR4L5bzR7GtW0HzF7NoarC4pchz4F+9wTYREWX6UF/KEZSuWZ7WJm3o2lpQU0LvitCby8kjUag==
X-Received: by 2002:a7b:c451:0:b0:3a6:829a:6102 with SMTP id l17-20020a7bc451000000b003a6829a6102mr2527670wmi.12.1661961759908;
        Wed, 31 Aug 2022 09:02:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o21-20020a05600c4fd500b003a32297598csm2788480wmq.43.2022.08.31.09.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:02:35 -0700 (PDT)
Message-Id: <4d69e5eaccb8873eece666a3d2bb2b22abdde7ea.1661961746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 31 Aug 2022 16:02:19 +0000
Subject: [PATCH 2/8] scalar: include in standard Git build & installation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        gitster@pobox.com, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Move 'scalar' out of 'contrib/' and into the root of the Git tree. The goal
of this change is to build 'scalar' as part of the standard Git build &
install processes.

This patch includes both the physical move of Scalar's files out of
'contrib/' ('scalar.c', 'scalar.txt', and 't9xxx-scalar.sh'), and the
changes to the build definitions in 'Makefile' and 'CMakelists.txt' to
accommodate the new program.

At a high level, Scalar is built so that:
- there is a 'scalar-objs' target (similar to those created in 029bac01a8
  (Makefile: add {program,xdiff,test,git,fuzz}-objs & objects targets,
  2021-02-23)) for debugging purposes.
- it appears in the root of the install directory (rather than the
  gitexecdir).
- it is included in the 'bin-wrappers/' directory for use in tests.
- it receives a platform-specific executable suffix (e.g., '.exe'), if
  applicable.
- 'scalar.txt' is installed as 'man1' documentation.
- the 'clean' target removes the 'scalar' executable.

Additionally, update the root level '.gitignore' file to ignore the Scalar
executable.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 .gitignore                                    |  1 +
 Documentation/Makefile                        |  1 +
 {contrib/scalar => Documentation}/scalar.txt  |  0
 Makefile                                      | 30 ++++---
 contrib/buildsystems/CMakeLists.txt           |  9 ++-
 contrib/scalar/.gitignore                     |  2 -
 contrib/scalar/Makefile                       | 35 --------
 contrib/scalar/t/Makefile                     | 81 -------------------
 contrib/scalar/scalar.c => scalar.c           |  0
 .../t/t9099-scalar.sh => t/t9210-scalar.sh    | 10 +--
 10 files changed, 28 insertions(+), 141 deletions(-)
 rename {contrib/scalar => Documentation}/scalar.txt (100%)
 delete mode 100644 contrib/scalar/.gitignore
 delete mode 100644 contrib/scalar/Makefile
 delete mode 100644 contrib/scalar/t/Makefile
 rename contrib/scalar/scalar.c => scalar.c (100%)
 rename contrib/scalar/t/t9099-scalar.sh => t/t9210-scalar.sh (96%)

diff --git a/.gitignore b/.gitignore
index 80b530bbed2..3d1b880101e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -185,6 +185,7 @@
 /git-whatchanged
 /git-worktree
 /git-write-tree
+/scalar
 /git-core-*/?*
 /git.res
 /gitweb/GITWEB-BUILD-OPTIONS
diff --git a/Documentation/Makefile b/Documentation/Makefile
index bd6b6fcb930..16c9e062390 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -21,6 +21,7 @@ MAN1_TXT += $(filter-out \
 MAN1_TXT += git.txt
 MAN1_TXT += gitk.txt
 MAN1_TXT += gitweb.txt
+MAN1_TXT += scalar.txt
 
 # man5 / man7 guides (note: new guides should also be added to command-list.txt)
 MAN5_TXT += gitattributes.txt
diff --git a/contrib/scalar/scalar.txt b/Documentation/scalar.txt
similarity index 100%
rename from contrib/scalar/scalar.txt
rename to Documentation/scalar.txt
diff --git a/Makefile b/Makefile
index eac30126e29..66dd3321f57 100644
--- a/Makefile
+++ b/Makefile
@@ -608,7 +608,9 @@ FUZZ_OBJS =
 FUZZ_PROGRAMS =
 GIT_OBJS =
 LIB_OBJS =
+SCALAR_OBJS =
 OBJECTS =
+OTHER_PROGRAMS =
 PROGRAM_OBJS =
 PROGRAMS =
 EXCLUDED_PROGRAMS =
@@ -821,10 +823,12 @@ BUILT_INS += git-switch$X
 BUILT_INS += git-whatchanged$X
 
 # what 'all' will build but not install in gitexecdir
-OTHER_PROGRAMS = git$X
+OTHER_PROGRAMS += git$X
+OTHER_PROGRAMS += scalar$X
 
 # what test wrappers are needed and 'install' will install, in bindir
 BINDIR_PROGRAMS_NEED_X += git
+BINDIR_PROGRAMS_NEED_X += scalar
 BINDIR_PROGRAMS_NEED_X += git-receive-pack
 BINDIR_PROGRAMS_NEED_X += git-shell
 BINDIR_PROGRAMS_NEED_X += git-upload-archive
@@ -2222,7 +2226,7 @@ profile-fast: profile-clean
 
 all:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
 ifneq (,$X)
-	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_COMMANDS_TO_INSTALL) git$X)), test -d '$p' -o '$p' -ef '$p$X' || $(RM) '$p';)
+	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_COMMANDS_TO_INSTALL) $(OTHER_PROGRAMS))), test -d '$p' -o '$p' -ef '$p$X' || $(RM) '$p';)
 endif
 
 all::
@@ -2545,7 +2549,12 @@ GIT_OBJS += git.o
 .PHONY: git-objs
 git-objs: $(GIT_OBJS)
 
+SCALAR_OBJS += scalar.o
+.PHONY: scalar-objs
+scalar-objs: $(SCALAR_OBJS)
+
 OBJECTS += $(GIT_OBJS)
+OBJECTS += $(SCALAR_OBJS)
 OBJECTS += $(PROGRAM_OBJS)
 OBJECTS += $(TEST_OBJS)
 OBJECTS += $(XDIFF_OBJS)
@@ -2556,10 +2565,6 @@ ifndef NO_CURL
 	OBJECTS += http.o http-walker.o remote-curl.o
 endif
 
-SCALAR_SOURCES := contrib/scalar/scalar.c
-SCALAR_OBJECTS := $(SCALAR_SOURCES:c=o)
-OBJECTS += $(SCALAR_OBJECTS)
-
 .PHONY: objects
 objects: $(OBJECTS)
 
@@ -2691,7 +2696,7 @@ $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
-contrib/scalar/scalar$X: $(SCALAR_OBJECTS) GIT-LDFLAGS $(GITLIBS)
+scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(LIBS)
 
@@ -2747,7 +2752,7 @@ XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
 XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --language=Perl \
 	--keyword=__ --keyword=N__ --keyword="__n:1,2"
 MSGMERGE_FLAGS = --add-location --backup=off --update
-LOCALIZED_C = $(sort $(FOUND_C_SOURCES) $(FOUND_H_SOURCES) $(SCALAR_SOURCES) \
+LOCALIZED_C = $(sort $(FOUND_C_SOURCES) $(FOUND_H_SOURCES) \
 	        $(GENERATED_H))
 LOCALIZED_SH = $(sort $(SCRIPT_SH) git-sh-setup.sh)
 LOCALIZED_PERL = $(sort $(SCRIPT_PERL))
@@ -3062,7 +3067,7 @@ bin-wrappers/%: wrap-for-bin.sh
 	$(call mkdir_p_parent_template)
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
-	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%$(X),$(@F))$(patsubst git%,$(X),$(filter $(@F),$(BINDIR_PROGRAMS_NEED_X)))|' < $< > $@ && \
+	     -e 's|@@PROG@@|$(patsubst test-%,t/helper/test-%,$(@F))$(if $(filter-out $(BINDIR_PROGRAMS_NO_X),$(@F)),$(X),)|' < $< > $@ && \
 	chmod +x $@
 
 # GNU make supports exporting all variables by "export" without parameters.
@@ -3276,14 +3281,14 @@ ifndef NO_TCLTK
 	$(MAKE) -C git-gui gitexecdir='$(gitexec_instdir_SQ)' install
 endif
 ifneq (,$X)
-	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_COMMANDS_TO_INSTALL) git$X)), test '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p' -ef '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p$X' || $(RM) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p';)
+	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_COMMANDS_TO_INSTALL) $(OTHER_PROGRAMS))), test '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p' -ef '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p$X' || $(RM) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)/$p';)
 endif
 
 	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
 	execdir=$$(cd '$(DESTDIR_SQ)$(gitexec_instdir_SQ)' && pwd) && \
 	destdir_from_execdir_SQ=$$(echo '$(gitexecdir_relative_SQ)' | sed -e 's|[^/][^/]*|..|g') && \
 	{ test "$$bindir/" = "$$execdir/" || \
-	  for p in git$X $(filter $(install_bindir_programs),$(ALL_PROGRAMS)); do \
+	  for p in $(OTHER_PROGRAMS) $(filter $(install_bindir_programs),$(ALL_PROGRAMS)); do \
 		$(RM) "$$execdir/$$p" && \
 		test -n "$(INSTALL_SYMLINKS)" && \
 		ln -s "$$destdir_from_execdir_SQ/$(bindir_relative_SQ)/$$p" "$$execdir/$$p" || \
@@ -3458,7 +3463,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) git.res
 	$(RM) $(OBJECTS)
 	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
-	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
+	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS)
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) $(FUZZ_PROGRAMS)
 	$(RM) $(SP_OBJ)
@@ -3509,6 +3514,7 @@ ALL_COMMANDS += git-citool
 ALL_COMMANDS += git-gui
 ALL_COMMANDS += gitk
 ALL_COMMANDS += gitweb
+ALL_COMMANDS += scalar
 
 .PHONY: check-docs
 check-docs::
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 2237109b57f..bae203c1fb9 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -610,7 +610,7 @@ unset(CMAKE_REQUIRED_INCLUDES)
 #programs
 set(PROGRAMS_BUILT
 	git git-daemon git-http-backend git-sh-i18n--envsubst
-	git-shell)
+	git-shell scalar)
 
 if(NOT CURL_FOUND)
 	list(APPEND excluded_progs git-http-fetch git-http-push)
@@ -757,6 +757,9 @@ target_link_libraries(git-sh-i18n--envsubst common-main)
 add_executable(git-shell ${CMAKE_SOURCE_DIR}/shell.c)
 target_link_libraries(git-shell common-main)
 
+add_executable(scalar ${CMAKE_SOURCE_DIR}/scalar.c)
+target_link_libraries(scalar common-main)
+
 if(CURL_FOUND)
 	add_library(http_obj OBJECT ${CMAKE_SOURCE_DIR}/http.c)
 
@@ -903,7 +906,7 @@ list(TRANSFORM git_perl_scripts PREPEND "${CMAKE_BINARY_DIR}/")
 
 #install
 foreach(program ${PROGRAMS_BUILT})
-if(program STREQUAL "git" OR program STREQUAL "git-shell")
+if(program MATCHES "^(git|git-shell|scalar)$")
 install(TARGETS ${program}
 	RUNTIME DESTINATION bin)
 else()
@@ -977,7 +980,7 @@ endif()
 
 #wrapper scripts
 set(wrapper_scripts
-	git git-upload-pack git-receive-pack git-upload-archive git-shell git-remote-ext)
+	git git-upload-pack git-receive-pack git-upload-archive git-shell git-remote-ext scalar)
 
 set(wrapper_test_scripts
 	test-fake-ssh test-tool)
diff --git a/contrib/scalar/.gitignore b/contrib/scalar/.gitignore
deleted file mode 100644
index ff3d47e84d0..00000000000
--- a/contrib/scalar/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-/*.exe
-/scalar
diff --git a/contrib/scalar/Makefile b/contrib/scalar/Makefile
deleted file mode 100644
index 37f283f35d7..00000000000
--- a/contrib/scalar/Makefile
+++ /dev/null
@@ -1,35 +0,0 @@
-# The default target of this Makefile is...
-all::
-
-# Import tree-wide shared Makefile behavior and libraries
-include ../../shared.mak
-
-include ../../config.mak.uname
--include ../../config.mak.autogen
--include ../../config.mak
-
-TARGETS = scalar$(X) scalar.o
-GITLIBS = ../../common-main.o ../../libgit.a ../../xdiff/lib.a
-
-all:: scalar$(X) ../../bin-wrappers/scalar
-
-$(GITLIBS):
-	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) $(subst ../../,,$@)
-
-$(TARGETS): $(GITLIBS) scalar.c
-	$(QUIET_SUBDIR0)../.. $(QUIET_SUBDIR1) $(patsubst %,contrib/scalar/%,$@)
-
-clean:
-	$(RM) $(TARGETS) ../../bin-wrappers/scalar
-
-../../bin-wrappers/scalar: ../../wrap-for-bin.sh Makefile
-	@mkdir -p ../../bin-wrappers
-	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
-	     -e 's|@@BUILD_DIR@@|$(shell cd ../.. && pwd)|' \
-	     -e 's|@@PROG@@|contrib/scalar/scalar$(X)|' < $< > $@ && \
-	chmod +x $@
-
-test: all
-	$(MAKE) -C t
-
-.PHONY: $(GITLIBS) all clean test FORCE
diff --git a/contrib/scalar/t/Makefile b/contrib/scalar/t/Makefile
deleted file mode 100644
index 1ed174a8cf3..00000000000
--- a/contrib/scalar/t/Makefile
+++ /dev/null
@@ -1,81 +0,0 @@
-# Import tree-wide shared Makefile behavior and libraries
-include ../../../shared.mak
-
-# Run scalar tests
-#
-# Copyright (c) 2005,2021 Junio C Hamano, Johannes Schindelin
-#
-
--include ../../../config.mak.autogen
--include ../../../config.mak
-
-SHELL_PATH ?= $(SHELL)
-PERL_PATH ?= /usr/bin/perl
-RM ?= rm -f
-PROVE ?= prove
-DEFAULT_TEST_TARGET ?= test
-TEST_LINT ?= test-lint
-
-ifdef TEST_OUTPUT_DIRECTORY
-TEST_RESULTS_DIRECTORY = $(TEST_OUTPUT_DIRECTORY)/test-results
-else
-TEST_RESULTS_DIRECTORY = ../../../t/test-results
-endif
-
-# Shell quote;
-SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
-PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
-TEST_RESULTS_DIRECTORY_SQ = $(subst ','\'',$(TEST_RESULTS_DIRECTORY))
-
-T = $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))
-
-all: $(DEFAULT_TEST_TARGET)
-
-test: $(TEST_LINT)
-	$(MAKE) aggregate-results-and-cleanup
-
-prove: $(TEST_LINT)
-	@echo "*** prove ***"; GIT_CONFIG=.git/config $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
-	$(MAKE) clean-except-prove-cache
-
-$(T):
-	@echo "*** $@ ***"; GIT_CONFIG=.git/config '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
-
-clean-except-prove-cache:
-	$(RM) -r 'trash directory'.*
-	$(RM) -r valgrind/bin
-
-clean: clean-except-prove-cache
-	$(RM) .prove
-
-test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax
-
-test-lint-duplicates:
-	@dups=`echo $(T) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` && \
-		test -z "$$dups" || { \
-		echo >&2 "duplicate test numbers:" $$dups; exit 1; }
-
-test-lint-executable:
-	@bad=`for i in $(T); do test -x "$$i" || echo $$i; done` && \
-		test -z "$$bad" || { \
-		echo >&2 "non-executable tests:" $$bad; exit 1; }
-
-test-lint-shell-syntax:
-	@'$(PERL_PATH_SQ)' ../../../t/check-non-portable-shell.pl $(T)
-
-aggregate-results-and-cleanup: $(T)
-	$(MAKE) aggregate-results
-	$(MAKE) clean
-
-aggregate-results:
-	for f in '$(TEST_RESULTS_DIRECTORY_SQ)'/t*-*.counts; do \
-		echo "$$f"; \
-	done | '$(SHELL_PATH_SQ)' ../../../t/aggregate-results.sh
-
-valgrind:
-	$(MAKE) GIT_TEST_OPTS="$(GIT_TEST_OPTS) --valgrind"
-
-test-results:
-	mkdir -p test-results
-
-.PHONY: $(T) aggregate-results clean valgrind
diff --git a/contrib/scalar/scalar.c b/scalar.c
similarity index 100%
rename from contrib/scalar/scalar.c
rename to scalar.c
diff --git a/contrib/scalar/t/t9099-scalar.sh b/t/t9210-scalar.sh
similarity index 96%
rename from contrib/scalar/t/t9099-scalar.sh
rename to t/t9210-scalar.sh
index dfb949f52ee..14ca575a214 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -2,15 +2,9 @@
 
 test_description='test the `scalar` command'
 
-TEST_DIRECTORY=$PWD/../../../t
-export TEST_DIRECTORY
+. ./test-lib.sh
 
-# Make it work with --no-bin-wrappers
-PATH=$PWD/..:$PATH
-
-. ../../../t/test-lib.sh
-
-GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab ../cron.txt,launchctl:true,schtasks:true"
+GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt,launchctl:true,schtasks:true"
 export GIT_TEST_MAINT_SCHEDULER
 
 test_expect_success 'scalar shows a usage' '
-- 
gitgitgadget

