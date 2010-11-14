From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/4] Makefile: move "Platform specific tweaks" above
 LIB_{H,OBJS}
Date: Sun, 14 Nov 2010 12:51:30 -0600
Message-ID: <20101114185130.GA18385@burratino>
References: <1289745857-16704-1-git-send-email-avarab@gmail.com>
 <1289745857-16704-2-git-send-email-avarab@gmail.com>
 <20101114172331.GA26459@burratino>
 <AANLkTinaDhXQjPC6s1eFb8HwEReW7P-ObmwRn2Hpb=O4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 19:52:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHhgW-0005OI-Jz
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 19:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756836Ab0KNSwJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 13:52:09 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33202 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756779Ab0KNSwH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 13:52:07 -0500
Received: by yxn35 with SMTP id 35so804108yxn.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 10:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=e6IFXcsgkkwZuBQv5CVN6o3u2Z5eue9bJNsPxStjU6I=;
        b=XPmp0VVxGJDkVqo7qqDdvyD5iB38vkO6LyWtayhCiiX2TuByOPsfFmmlKXSNB2h003
         wMHc0BsPXnlZQsG05BNO3oxQ9C2Pd7YRxou7u44PoB3UV9uwW06Jj99Gh6mvwqRGsB+L
         WncbTEmM915rGGLRdNtPxRPXKzaiUIfncWrTE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=PVbU628zsV3aQgW1weCkzlBP6DBjtKeDn8ezwvyzs6cNH5Mt01JUrS9/6RHniRkZgL
         e+yGtqNmYgHi4+lRWqGoUphLgA/v2rWyaKnYQQyC7ComDk7CY5qKAN9925uTFsYwVaq4
         C5Q/h1lrJ4hnvr+O1I3CT9ZhBfRcIx75vYQrI=
Received: by 10.90.231.10 with SMTP id d10mr6594187agh.44.1289760725908;
        Sun, 14 Nov 2010 10:52:05 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id i37sm2792160anh.34.2010.11.14.10.52.03
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 10:52:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTinaDhXQjPC6s1eFb8HwEReW7P-ObmwRn2Hpb=O4@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161431>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> That listing should be in a comment at the start of the
> Makefile. Please submit a patch for that!

How about this?  An annoying piece of GNU makefile syntax makes this
uglier than it needs to be (search for HACK for details).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/Makefile b/Makefile
index 1f1ce04..38edd65 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,8 @@
 # The default target of this Makefile is...
 all::
=20
+outline:: ; @echo "Configuration."
+
 # Define V=3D1 to have a more verbose compile.
 #
 # Define SHELL_PATH to a POSIX shell if your /bin/sh is broken.
@@ -238,6 +240,12 @@ all::
 #
 # Define NATIVE_CRLF if your platform uses CRLF for line endings.
=20
+outline::
+	@echo " Basic configuration section."
+	@echo "  -include GIT-VERSION-FILE and recipe to generate it."
+	@echo "  uname_S and similar variables."
+	@echo "  user-facing compilation variables: CFLAGS, LDFLAGS, STRIP"
+
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
 -include GIT-VERSION-FILE
@@ -263,6 +271,7 @@ ALL_CFLAGS =3D $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS =3D $(LDFLAGS)
 STRIP ?=3D strip
=20
+outline:: ; @echo "  User-facing paths: prefix, bindir_relative, etc."
 # Among the variables below, these:
 #   gitexecdir
 #   template_dir
@@ -301,6 +310,7 @@ pathsep =3D :
=20
 export prefix bindir sharedir sysconfdir gitwebdir
=20
+outline:: ; @echo "  Program names: CC, AR, etc."
 CC =3D gcc
 AR =3D ar
 RM =3D rm -f
@@ -325,6 +335,7 @@ SPARSE_FLAGS =3D -D__BIG_ENDIAN__ -D__powerpc__
=20
 ### --- END CONFIGURATION SECTION ---
=20
+outline:: ; @echo " Basic cflags and ldflags (almost configurable)"
 # Those must not be GNU-specific; they are shared with perl/ which may
 # be built by a different compiler. (Note that this is an artifact now
 # but it still might be nice to keep that distinction.)
@@ -353,6 +364,11 @@ TEST_PROGRAMS_NEED_X =3D
 # interactive shell sessions without exporting it.
 unexport CDPATH
=20
+outline::
+	@echo " Main list of program targets:"
+	@echo "  SCRIPTS, PROGRAMS, TEST_PROGRAMS, BUILT_INS,"
+	@echo "  OTHER_PROGRAMS, BINDIR_PROGRAMS"
+
 SCRIPT_SH +=3D git-am.sh
 SCRIPT_SH +=3D git-bisect.sh
 SCRIPT_SH +=3D git-difftool--helper.sh
@@ -465,6 +481,10 @@ BINDIR_PROGRAMS_NEED_X +=3D git-shell
=20
 BINDIR_PROGRAMS_NO_X +=3D git-cvsserver
=20
+outline:: ; @echo " Defaults for SHELL_PATH, PERL_PATH, PYTHON_PATH"
+# HACK: end of outline recipe
+reset =3D
+
 # Set paths to tools early so that they can be used for version tests.
 ifndef SHELL_PATH
 	SHELL_PATH =3D /bin/sh
@@ -479,6 +499,9 @@ endif
 export PERL_PATH
 export PYTHON_PATH
=20
+outline::
+	@echo " Main list of library targets:"
+	@echo "  LIB_FILE, XDIFF_LIB, LIB_H, LIB_OBJS, BUILTIN_OBJS"
 LIB_FILE=3Dlibgit.a
 XDIFF_LIB=3Dxdiff/lib.a
 VCSSVN_LIB=3Dvcs-svn/lib.a
@@ -758,9 +781,12 @@ GITLIBS =3D $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS =3D
=20
 #
-# Platform specific tweaks
+outline:: ; @echo " Platform specific tweaks"
 #
=20
+# HACK: end of outline recipe
+reset =3D
+
 # We choose to avoid "if .. else if .. else .. endif endif"
 # because maintaining the nesting to match is a pain.  If
 # we had "elif" things would have been much nicer...
@@ -1147,9 +1173,14 @@ else
 endif
 endif
=20
+outline:: ; @echo " -include config.mak and config.mak.autogen"
 -include config.mak.autogen
 -include config.mak
=20
+#
+outline:: ; @echo "Preparations"
+#
+
 ifdef CHECK_HEADER_DEPENDENCIES
 COMPUTE_HEADER_DEPENDENCIES =3D
 USE_COMPUTED_HEADER_DEPENDENCIES =3D
@@ -1159,6 +1190,12 @@ ifdef COMPUTE_HEADER_DEPENDENCIES
 USE_COMPUTED_HEADER_DEPENDENCIES =3D YesPlease
 endif
=20
+outline::
+	@echo " Handling of the various NO_THIS_OR_THAT options"
+	@echo "  This affects BASIC_CFLAGS, COMPAT_CFLAGS,"
+	@echo "  COMPAT_OBJS, PROGRAMS, EXTLIBS, LIB_OBJ, LIB_H, etc"
+reset =3D
+
 ifdef SANE_TOOL_PATH
 SANE_TOOL_PATH_SQ =3D $(subst ','\'',$(SANE_TOOL_PATH))
 BROKEN_PATH_FIX =3D 's|^\# @@BROKEN_PATH_FIX@@$$|git_broken_path_fix $=
(SANE_TOOL_PATH_SQ)|'
@@ -1491,6 +1528,7 @@ ifeq ($(PYTHON_PATH),)
 NO_PYTHON=3DNoThanks
 endif
=20
+outline:: ; @echo " Machinery for non-noisy build"
 QUIET_SUBDIR0  =3D +$(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1  =3D
=20
@@ -1522,7 +1560,8 @@ ifdef ASCIIDOC8
 	export ASCIIDOC8
 endif
=20
-# Shell quote (do not use $(call) to accommodate ancient setups);
+outline:: ; @echo " Shell-quoted and C-quoted variables"
+# Do not use $(call) to accommodate ancient setups.
=20
 SHA1_HEADER_SQ =3D $(subst ','\'',$(SHA1_HEADER))
 ETC_GITCONFIG_SQ =3D $(subst ','\'',$(ETC_GITCONFIG))
@@ -1545,12 +1584,6 @@ PYTHON_PATH_SQ =3D $(subst ','\'',$(PYTHON_PATH)=
)
 TCLTK_PATH_SQ =3D $(subst ','\'',$(TCLTK_PATH))
 DIFF_SQ =3D $(subst ','\'',$(DIFF))
=20
-LIBS =3D $(GITLIBS) $(EXTLIBS)
-
-BASIC_CFLAGS +=3D -DSHA1_HEADER=3D'$(SHA1_HEADER_SQ)' \
-	$(COMPAT_CFLAGS)
-LIB_OBJS +=3D $(COMPAT_OBJS)
-
 # Quote for C
=20
 ifdef DEFAULT_EDITOR
@@ -1567,16 +1600,25 @@ DEFAULT_PAGER_CQ_SQ =3D $(subst ','\'',$(DEFAUL=
T_PAGER_CQ))
 BASIC_CFLAGS +=3D -DDEFAULT_PAGER=3D'$(DEFAULT_PAGER_CQ_SQ)'
 endif
=20
+outline:: ; @echo " ALL_CFLAGS, ALL_LDFLAGS"
+LIBS =3D $(GITLIBS) $(EXTLIBS)
+
+BASIC_CFLAGS +=3D -DSHA1_HEADER=3D'$(SHA1_HEADER_SQ)' \
+	$(COMPAT_CFLAGS)
+LIB_OBJS +=3D $(COMPAT_OBJS)
+
 ALL_CFLAGS +=3D $(BASIC_CFLAGS)
 ALL_LDFLAGS +=3D $(BASIC_LDFLAGS)
=20
 export DIFF TAR INSTALL DESTDIR SHELL_PATH
=20
-
-### Build rules
+#
+outline:: ; @echo "Main build rules"
+#
=20
 SHELL =3D $(SHELL_PATH)
=20
+outline:: ; @echo " all:: targets for the main build, subdirs"
 all:: shell_compatibility_test $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_I=
NS) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
 ifneq (,$X)
 	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROG=
RAMS) $(BUILT_INS) git$X)), test -d '$p' -o '$p' -ef '$p$X' || $(RM) '$=
p';)
@@ -1598,11 +1640,13 @@ endif
 please_set_SHELL_PATH_to_a_more_modern_shell:
 	@$$(:)
=20
+outline:: ; @echo " Shell sanity check"
 shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
=20
 strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) git$X
=20
+outline:: ; @echo " Git binary and built-ins"
 git.o: common-cmds.h
 git.s git.o: EXTRA_CPPFLAGS =3D -DGIT_VERSION=3D'"$(GIT_VERSION)"' \
 	'-DGIT_HTML_PATH=3D"$(htmldir_SQ)"'
@@ -1628,6 +1672,7 @@ common-cmds.h: ./generate-cmdlist.sh command-list=
=2Etxt
 common-cmds.h: $(wildcard Documentation/git-*.txt)
 	$(QUIET_GEN)./generate-cmdlist.sh > $@+ && mv $@+ $@
=20
+outline:: ; @echo " Scripts and gitweb"
 define cmd_munge_script
 $(RM) $@ $@+ && \
 sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
@@ -1743,6 +1788,7 @@ $(patsubst %.py,%,$(SCRIPT_PYTHON)): % : unimplem=
ented.sh
 	mv $@+ $@
 endif # NO_PYTHON
=20
+outline:: ; @echo " Autoconf"
 configure: configure.ac
 	$(QUIET_GEN)$(RM) $@ $<+ && \
 	sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
@@ -1756,6 +1802,10 @@ git.o git.spec \
 	$(patsubst %.perl,%,$(SCRIPT_PERL)) \
 	: GIT-VERSION-FILE
=20
+outline::
+	@echo " Building objects"
+	@echo "  %.o: %.c rule, header deps, dependency checking"
+
 TEST_OBJS :=3D $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
 GIT_OBJS :=3D $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS)=
 \
 	git.o
@@ -1895,6 +1945,7 @@ $(VCSSVN_OBJS): \
 	vcs-svn/svndump.h
 endif
=20
+outline:: ; @echo "  Target-specific -D flags"
 exec_cmd.s exec_cmd.o: EXTRA_CPPFLAGS =3D \
 	'-DGIT_EXEC_PATH=3D"$(gitexecdir_SQ)"' \
 	'-DBINDIR=3D"$(bindir_relative_SQ)"' \
@@ -1922,6 +1973,7 @@ compat/nedmalloc/nedmalloc.o: EXTRA_CPPFLAGS =3D =
\
 	-DNDEBUG -DOVERRIDE_STRDUP -DREPLACE_SYSTEM_ALLOCATOR
 endif
=20
+outline:: ; @echo " Non-builtin programs, remote-curl"
 git-%$X: %.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) $(LIBS)
=20
@@ -1946,6 +1998,7 @@ $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http=
-walker.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^=
) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
=20
+outline:: ; @echo " Libraries"
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIB_OBJS)
=20
@@ -1955,6 +2008,7 @@ $(XDIFF_LIB): $(XDIFF_OBJS)
 $(VCSSVN_LIB): $(VCSSVN_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(VCSSVN_OBJS)
=20
+outline:: ; @echo " Subdirs"
 doc:
 	$(MAKE) -C Documentation all
=20
@@ -1982,6 +2036,10 @@ cscope:
 	$(RM) cscope*
 	$(FIND) . -name '*.[hcS]' -print | xargs cscope -b
=20
+#
+outline:: ; @echo "GIT-CFLAGS, GIT-BUILD-OPTIONS, GIT-GUI-VARS"
+#
+
 ### Detect prefix changes
 TRACK_CFLAGS =3D $(CC):$(subst ','\'',$(ALL_CFLAGS)):\
              $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix=
_SQ)
@@ -2024,6 +2082,9 @@ GIT-GUI-VARS: FORCE
             fi
 endif
=20
+#
+outline:: ; @echo "Wrappers for running built git in place"
+#
 test_bindir_programs :=3D $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAM=
S_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
=20
 all:: $(TEST_PROGRAMS) $(test_bindir_programs)
@@ -2041,8 +2102,9 @@ bin-wrappers/%: wrap-for-bin.sh
=20
 export NO_SVN_TESTS
=20
-### Testing rules
-
+#
+outline:: ; @echo "Testing rules"
+#
 test: all
 	$(MAKE) -C t/ all
=20
@@ -2083,7 +2145,9 @@ check: common-cmds.h
 remove-dashes:
 	./fixup-builtins $(BUILT_INS) $(PROGRAMS) $(SCRIPTS)
=20
-### Installation rules
+#
+outline:: ; @echo "Installation rules"
+#
=20
 ifneq ($(filter /%,$(firstword $(template_dir))),)
 template_instdir =3D $(template_dir)
@@ -2183,8 +2247,9 @@ quick-install-html:
 	$(MAKE) -C Documentation quick-install-html
=20
=20
-
-### Maintainer's dist rules
+#
+outline:: ; @echo "Maintainer's dist rules, check-doc, coverage testin=
g"
+#
=20
 git.spec: git.spec.in
 	sed -e 's/@@VERSION@@/$(GIT_VERSION)/g' < $< > $@+
