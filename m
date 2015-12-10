From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] Makefile: add missing phony target
Date: Thu, 10 Dec 2015 15:24:54 +0000
Message-ID: <1449761094-37915-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 10 16:25:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a735g-0005xy-2v
	for gcvg-git-2@plane.gmane.org; Thu, 10 Dec 2015 16:25:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974AbbLJPZC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 10:25:02 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37838 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbbLJPZB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 10:25:01 -0500
Received: by wmww144 with SMTP id w144so29378162wmw.0
        for <git@vger.kernel.org>; Thu, 10 Dec 2015 07:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=IJ9BLVAzxjZjSfheh/dBMyDGdVXwrvTyPOGCreKj7xo=;
        b=Rx7ZolO7BEPDqCcvukjIcIRDtvHW+sTndlYsRXoGEtlDF9U2Y1e5vp8efgeU95nQkB
         tw7qR0V26X+myvSEnpxwXpRfl7VTm9nE6ExEc+8h1zT0Dol0phpiDHg70pR9Fyzrlu9k
         WOwAY5MH0IQwBBuKs+5er2EgDkZkN1y2CYHTLPdHQF/bRYMXh7KAR1dOlKx6HmdE4oCC
         6FY44eSVrqUw76JfVfdSSfqrG2urgiWf2cTXm+TeqmkhRz++TFkUt11LJdrOCQhLsLdk
         SheOMboIbicBMy5wGST2waANVHyoTkFZrMDpUhCPLmwq/+E6cGnHpGo+R1kvtp09H+tx
         NC7g==
X-Received: by 10.194.6.225 with SMTP id e1mr12893935wja.67.1449761099276;
        Thu, 10 Dec 2015 07:24:59 -0800 (PST)
Received: from ubuntu2pinto.pd5x2phgis1evm2itoce0l41ib.ax.internal.cloudapp.net ([40.113.119.92])
        by smtp.gmail.com with ESMTPSA id w4sm12871008wje.49.2015.12.10.07.24.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Dec 2015 07:24:58 -0800 (PST)
X-Mailer: git-send-email 2.6.3.444.gfd13a2e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282217>

Add some missing phony target to Makefile. Also put the .PHONY
declaration immediately before the target declaration, where necessary,
for a better readability and a uniform style.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 Makefile | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/Makefile b/Makefile
index 43ceeb9..a5fab53 100644
--- a/Makefile
+++ b/Makefile
@@ -522,11 +522,11 @@ SCRIPT_PYTHON_INS = $(filter-out $(NO_INSTALL),$(SCRIPT_PYTHON_GEN))
 # "make -C ../.. SCRIPT_PERL=contrib/foo/bar.perl build-perl-script"
 # from subdirectories like contrib/*/
 .PHONY: build-perl-script build-sh-script build-python-script
+.PHONY: install-perl-script install-sh-script install-python-script
 build-perl-script: $(SCRIPT_PERL_GEN)
 build-sh-script: $(SCRIPT_SH_GEN)
 build-python-script: $(SCRIPT_PYTHON_GEN)
 
-.PHONY: install-perl-script install-sh-script install-python-script
 install-sh-script: $(SCRIPT_SH_INS)
 	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 install-perl-script: $(SCRIPT_PERL_INS)
@@ -534,7 +534,7 @@ install-perl-script: $(SCRIPT_PERL_INS)
 install-python-script: $(SCRIPT_PYTHON_INS)
 	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 
-.PHONY: clean-perl-script clean-sh-script clean-python-script
+.PHONY: clean-sh-script clean-perl-script  clean-python-script
 clean-sh-script:
 	$(RM) $(SCRIPT_SH_GEN)
 clean-perl-script:
@@ -546,7 +546,6 @@ SCRIPTS = $(SCRIPT_SH_INS) \
 	  $(SCRIPT_PERL_INS) \
 	  $(SCRIPT_PYTHON_INS) \
 	  git-instaweb
-
 ETAGS_TARGET = TAGS
 
 # Empty...
@@ -1644,6 +1643,9 @@ shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
 strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $^
 
+.PHONY: all profile profile-fast
+.PHONY: please_set_SHELL_PATH_to_a_more_modern_shell shell_compatibility_test strip
+
 ### Target-specific flags and dependencies
 
 # The generic compilation pattern rule and automatically
@@ -1792,7 +1794,7 @@ GIT-PERL-DEFINES: FORCE
 	    fi
 
 
-.PHONY: gitweb
+.PHONY: gitweb git-instaweb
 gitweb:
 	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) all
 
@@ -2011,6 +2013,7 @@ $(VCSSVN_LIB): $(VCSSVN_OBJS)
 
 export DEFAULT_EDITOR DEFAULT_PAGER
 
+.PHONY: doc man html info pdf
 doc:
 	$(MAKE) -C Documentation all
 
@@ -2054,6 +2057,7 @@ po/git.pot: $(GENERATED_H) FORCE
 		$(LOCALIZED_PERL)
 	mv $@+ $@
 
+.PHONY: pot
 pot: po/git.pot
 
 POFILES := $(wildcard po/*.po)
@@ -2074,6 +2078,7 @@ $(ETAGS_TARGET): FORCE
 	$(RM) $(ETAGS_TARGET)
 	$(FIND_SOURCE_FILES) | xargs etags -a -o $(ETAGS_TARGET)
 
+.PHONY: tags cscope FORCE
 tags: FORCE
 	$(RM) tags
 	$(FIND_SOURCE_FILES) | xargs ctags -a
@@ -2189,6 +2194,7 @@ export NO_SVN_TESTS
 export TEST_NO_MALLOC_CHECK
 
 ### Testing rules
+.PHONY: test perf
 
 test: all
 	$(MAKE) -C t/ all
@@ -2196,7 +2202,6 @@ test: all
 perf: all
 	$(MAKE) -C t/perf/ all
 
-.PHONY: test perf
 
 test-ctype$X: ctype.o
 
@@ -2215,6 +2220,7 @@ test-svn-fe$X: vcs-svn/lib.a
 test-%$X: test-%.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
+.PHONY: check_sha1 $(SP_OBJ) sparse check check-sha1
 check-sha1:: test-sha1$X
 	./test-sha1.sh
 
@@ -2224,7 +2230,6 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
 	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
 		$(SPARSE_FLAGS) $<
 
-.PHONY: sparse $(SP_OBJ)
 sparse: $(SP_OBJ)
 
 check: common-cmds.h
@@ -2237,6 +2242,7 @@ check: common-cmds.h
 		exit 1; \
 	fi
 
+
 ### Installation rules
 
 ifneq ($(filter /%,$(firstword $(template_dir))),)
@@ -2263,6 +2269,7 @@ mergetools_instdir_SQ = $(subst ','\'',$(mergetools_instdir))
 
 install_bindir_programs := $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X)) $(BINDIR_PROGRAMS_NO_X)
 
+.PHONY: profile-install profile-fast-install install
 profile-install: profile
 	$(MAKE) install
 
@@ -2329,6 +2336,8 @@ endif
 	done && \
 	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
 
+.PHONY: install-gitweb install-man install-html install-info install-pdf
+.PHONY: quick-install-doc quick-install-man quick-install-html
 install-gitweb:
 	$(MAKE) -C gitweb install
 
@@ -2365,6 +2374,8 @@ git.spec: git.spec.in GIT-VERSION-FILE
 	mv $@+ $@
 
 GIT_TARNAME = git-$(GIT_VERSION)
+
+.PHONY: dist rpm dist-doc  distclean profile-clean clean
 dist: git.spec git-archive$(X) configure
 	./git-archive --format=tar \
 		--prefix=$(GIT_TARNAME)/ HEAD^{tree} > $(GIT_TARNAME).tar
@@ -2445,9 +2456,6 @@ endif
 	$(RM) GIT-USER-AGENT GIT-PREFIX
 	$(RM) GIT-SCRIPT-DEFINES GIT-PERL-DEFINES GIT-PYTHON-VARS
 
-.PHONY: all install profile-clean clean strip
-.PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
-.PHONY: FORCE cscope
 
 ### Check documentation
 #
@@ -2499,9 +2507,9 @@ check-builtins::
 
 ### Test suite coverage testing
 #
-.PHONY: coverage coverage-clean coverage-compile coverage-test coverage-report
-.PHONY: coverage-clean-results
 
+.PHONY: coverage coverage-clean coverage-compile coverage-test coverage-report
+.PHONY: coverage-clean-results coverage-untested-functions cover_db cover_db_html
 coverage:
 	$(MAKE) coverage-test
 	$(MAKE) coverage-untested-functions
@@ -2543,4 +2551,3 @@ cover_db: coverage-report
 
 cover_db_html: cover_db
 	cover -report html -outputdir cover_db_html cover_db
-
-- 
2.5.0
