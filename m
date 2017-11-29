Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FB1020A40
	for <e@80x24.org>; Wed, 29 Nov 2017 15:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933279AbdK2PfB (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 10:35:01 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:33947 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755284AbdK2Pem (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 10:34:42 -0500
Received: by mail-wm0-f46.google.com with SMTP id y82so36781624wmg.1
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 07:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yQrwjVhyjc31GpY8tXUOpek/JEmPN9PcbSnr58eKxyA=;
        b=a3xm+M4SEG/Em7UsUQtz6D7Sjc/8cwXKE3MAHLHSdkAVkP7/KMfd1AZUsi6EE57ach
         1q+BCfUO5hNpbxrxyCabv+HO8hDSwPITKvM/l4i9Sexi6PeIaMxao6eZ4m2EBtZTrO00
         HpDUUTPv3SKOlzeCAQFkoNeUx5NGMN3lWboUq+oJJMI9mastSDAqSqALnhmJmWxSTmFt
         59AQSyQ9F4AgBh0dI94NNjILa73/YN3sMnzAuJlIC4VpVHzFsrmWv56m4yDJV/1uazTJ
         pNnXJuSe6MZYs7AsdEeDDD4lHEOJ6ii0QuSPtj9/H34i5GvsvfRg4W4nTnHFqib9Qxvv
         zggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yQrwjVhyjc31GpY8tXUOpek/JEmPN9PcbSnr58eKxyA=;
        b=SAzYkmmrhlvQ/QBoWMeQWnR1B9DDSduCw1oag2z5vshKg7XpyV1itackpq0a0womoi
         Hd1OiVXxbISLk+b+lmStn6U6pPiXNqA8ikkaacNK9qppYDDp9sUldTpzcwZ1WKgxfHSI
         Ns3MHz2626oM/TkxxwcSwONNFmiMiBVnvsIsVOGjE8bbNqvjbV67Q4Mndg9D5zoYC+qA
         kpWmviogOa/MfloJdPz3p7zijYLbAfuflD7K8m0XZzPF96J78zMiPekYxEEvQRms8djq
         GVPXKUUCwI+6qqPf5yTohfP1iI9USifKR7PoRXRalhNuVyoUgvSiyJcT7zBwqWILETIJ
         Ra2A==
X-Gm-Message-State: AJaThX6QbKcFYEh4TC5qsEPtRQHwEA81+uhL/hrHviBJ7tRaREEzm3r6
        WNzWu76kEvrtOE+iGTsJybY2bYYy
X-Google-Smtp-Source: AGs4zMYCV+a0BLmx+vD7WcbcXpiue+woRu4hq4jA5cdbsCqLPO4/bsbJvhJRxIPXhaYRynG9DOIseA==
X-Received: by 10.28.172.66 with SMTP id v63mr2675713wme.37.1511969680186;
        Wed, 29 Nov 2017 07:34:40 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m11sm1020766wrf.56.2017.11.29.07.34.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Nov 2017 07:34:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Dan Jacques <dnj@google.com>,
        Alex Riesen <alexander.riesen@cetitec.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Casey <drafnel@gmail.com>, Petr Baudis <pasky@ucw.cz>,
        Gerrit Pape <pape@smarden.org>,
        "martin f . krafft" <madduck@madduck.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH] Makefile: replace the overly complex perl build system with something simple
Date:   Wed, 29 Nov 2017 15:34:36 +0000
Message-Id: <20171129153436.24471-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.0.403.gc27cc4dac6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the history of perl/Makefile.PL reveals the reason we have it in
the first place is because during its initial development the perl
bindings would link to libgit, building such a module with any sanity
requires ExtUtils::MakeMaker and Devel::PPPort.

However, since then this grew into a much simpler problem while
keeping all the complexity of the initial implementation. We just need
to take the files in perl/**.pm, copy them to a build directory while
search/replacing one string (@@LOCALEDIR@@), and have them available
for the likes of git-svn once Git is installed.

This patch is a WIP effort to do that. Trade-offs this makes & other
caveats:

 * This will not always install into perl's idea of its global
   "installsitelib". This only potentially matters for packagers that
   need to expose Git.pm for non-git use, and as explained in the
   INSTALL file there's a trivial workaround.

 * The scripts themselves will 'use lib' the target directory, but if
   INSTLIBDIR is set it overrides it. It doesn't have to be this way,
   but my reading of 0386dd37b1 ("Makefile: add PERLLIB_EXTRA variable
   that adds to default perl path", 2013-11-15) is that this does the
   right thing, but I may be wrong.

 * We don't build the Git(3) Git::I18N(3) etc. man pages from the
   embedded perldoc. I suspect nobody really cares, these are mostly
   internal APIs, and if someone's developing against them they likely
   know enough to issue a "perldoc" against the installed file to get
   the same result.

   But this is a change in how Git is installed now on e.g. CentOS &
   Debian which carry these manpages. They could be added (via
   pod2man) if anyone really cares.

 * Currently the Error.pm fallback doesn't work. This is a TODO item,
   but I didn't have enough time to hack this up.

   I think that whole thing should be changed, we're checking an
   ancient Error.pm version that was released in 2006, we should just
   stop that, then we check *at build time* whether the library is
   there, instead we should call it/load it via e.g. Git::Error which
   would be a small wrapper that would either load Error.pm from the
   system, or use our copy in Git::Error_CPAN.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

So *long* CC list but a lot of people have touched this stuff over the
years. This obviously conflicts with Dan Jacques's patches in a big
way, but I think it's worth it to rebase them on top of this if
there's interest in this, and depending on what people think about the
caveats I've noted about this above.

 INSTALL               | 18 ++++++++++-
 Makefile              | 51 +++++++++++++----------------
 perl/.gitignore       |  9 +-----
 perl/Git/I18N.pm      |  2 +-
 perl/Makefile         | 90 ---------------------------------------------------
 perl/Makefile.PL      | 62 -----------------------------------
 t/perf/aggregate.perl |  2 +-
 t/test-lib.sh         |  2 +-
 wrap-for-bin.sh       |  2 +-
 9 files changed, 45 insertions(+), 193 deletions(-)
 delete mode 100644 perl/Makefile
 delete mode 100644 perl/Makefile.PL

diff --git a/INSTALL b/INSTALL
index ffb071e9f0..e6266a9127 100644
--- a/INSTALL
+++ b/INSTALL
@@ -84,9 +84,25 @@ Issues of note:
 
 	GIT_EXEC_PATH=`pwd`
 	PATH=`pwd`:$PATH
-	GITPERLLIB=`pwd`/perl/blib/lib
+	GITPERLLIB=`pwd`/perl/build
 	export GIT_EXEC_PATH PATH GITPERLLIB
 
+ - By default (unless NO_PERL is provided) Git will ship various perl
+   scripts & libraries it needs. However, for simplicity it doesn't
+   use the ExtUtils::MakeMaker toolchain to decide where to place the
+   perl libraries. Depending on the system this can result in the perl
+   libraries not being where you'd like them if they're expected to be
+   used by things other than Git itself.
+
+   Manually supplying a perllibdir prefix should fix this, if this is
+   a problem you care about, e.g.:
+
+       prefix=/usr perllibdir=/usr/$(/usr/bin/perl -MConfig -wE 'my ($relsite) = $Config{installsitelib} =~ m[^\Q$Config{siteprefixexp}\E/(.+)]s; say $relsite')
+
+   Will result in e.g. perllibdir=/usr/share/perl/5.26.1 on Debian,
+   perllibdir=/usr/share/perl5 (which we'd use by default) on CentOS
+   etc.
+
  - Git is reasonably self-sufficient, but does depend on a few external
    programs and libraries.  Git can be used without most of them by adding
    the approriate "NO_<LIBRARY>=YesPlease" to the make command line or
diff --git a/Makefile b/Makefile
index e53750ca01..6d69a7486b 100644
--- a/Makefile
+++ b/Makefile
@@ -295,9 +295,6 @@ all::
 #
 # Define PERL_PATH to the path of your Perl binary (usually /usr/bin/perl).
 #
-# Define NO_PERL_MAKEMAKER if you cannot use Makefiles generated by perl's
-# MakeMaker (e.g. using ActiveState under Cygwin).
-#
 # Define NO_PERL if you do not want Perl scripts or libraries at all.
 #
 # Define PYTHON_PATH to the path of your Python binary (often /usr/bin/python
@@ -473,6 +470,7 @@ gitexecdir = libexec/git-core
 mergetoolsdir = $(gitexecdir)/mergetools
 sharedir = $(prefix)/share
 gitwebdir = $(sharedir)/gitweb
+perllibdir = $(sharedir)/perl5
 localedir = $(sharedir)/locale
 template_dir = share/git-core/templates
 htmldir = $(prefix)/share/doc/git-doc
@@ -486,7 +484,7 @@ mandir_relative = $(patsubst $(prefix)/%,%,$(mandir))
 infodir_relative = $(patsubst $(prefix)/%,%,$(infodir))
 htmldir_relative = $(patsubst $(prefix)/%,%,$(htmldir))
 
-export prefix bindir sharedir sysconfdir gitwebdir localedir
+export prefix bindir sharedir sysconfdir gitwebdir perllibdir localedir
 
 CC = cc
 AR = ar
@@ -1525,9 +1523,6 @@ ifdef SHA1_MAX_BLOCK_SIZE
 	LIB_OBJS += compat/sha1-chunked.o
 	BASIC_CFLAGS += -DSHA1_MAX_BLOCK_SIZE="$(SHA1_MAX_BLOCK_SIZE)"
 endif
-ifdef NO_PERL_MAKEMAKER
-	export NO_PERL_MAKEMAKER
-endif
 ifdef NO_HSTRERROR
 	COMPAT_CFLAGS += -DNO_HSTRERROR
 	COMPAT_OBJS += compat/hstrerror.o
@@ -1716,6 +1711,7 @@ bindir_SQ = $(subst ','\'',$(bindir))
 bindir_relative_SQ = $(subst ','\'',$(bindir_relative))
 mandir_relative_SQ = $(subst ','\'',$(mandir_relative))
 infodir_relative_SQ = $(subst ','\'',$(infodir_relative))
+perllibdir_SQ = $(subst ','\'',$(perllibdir))
 localedir_SQ = $(subst ','\'',$(localedir))
 gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
 template_dir_SQ = $(subst ','\'',$(template_dir))
@@ -1824,9 +1820,6 @@ all::
 ifndef NO_TCLTK
 	$(QUIET_SUBDIR0)git-gui $(QUIET_SUBDIR1) gitexecdir='$(gitexec_instdir_SQ)' all
 	$(QUIET_SUBDIR0)gitk-git $(QUIET_SUBDIR1) all
-endif
-ifndef NO_PERL
-	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' localedir='$(localedir_SQ)' all
 endif
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) SHELL_PATH='$(SHELL_PATH_SQ)' PERL_PATH='$(PERL_PATH_SQ)'
 
@@ -1907,7 +1900,8 @@ common-cmds.h: $(wildcard Documentation/git-*.txt)
 
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
 	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
-	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP):$(PAGER_ENV)
+	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP):$(PAGER_ENV):\
+	$(perllibdir_SQ)
 define cmd_munge_script
 $(RM) $@ $@+ && \
 sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
@@ -1951,29 +1945,17 @@ git.res: git.rc GIT-VERSION-FILE
 $(SCRIPT_PERL_GEN): GIT-BUILD-OPTIONS
 
 ifndef NO_PERL
-$(SCRIPT_PERL_GEN): perl/perl.mak
-
-perl/perl.mak: perl/PM.stamp
-
-perl/PM.stamp: FORCE
-	@$(FIND) perl -type f -name '*.pm' | sort >$@+ && \
-	$(PERL_PATH) -V >>$@+ && \
-	{ cmp $@+ $@ >/dev/null 2>/dev/null || mv $@+ $@; } && \
-	$(RM) $@+
-
-perl/perl.mak: GIT-CFLAGS GIT-PREFIX perl/Makefile perl/Makefile.PL
-	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' $(@F)
+$(SCRIPT_PERL_GEN):
 
 PERL_DEFINES = $(PERL_PATH_SQ):$(PERLLIB_EXTRA_SQ)
-$(SCRIPT_PERL_GEN): % : %.perl perl/perl.mak GIT-PERL-DEFINES GIT-VERSION-FILE
+$(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-VERSION-FILE
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
 	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
 	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
 	sed -e '1{' \
 	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
 	    -e '	h' \
-	    -e '	s=.*=use lib (split(/$(pathsep)/, $$ENV{GITPERLLIB} || "'"$$INSTLIBDIR"'"));=' \
+	    -e '	s=.*=use lib (split(/$(pathsep)/, $$ENV{GITPERLLIB} || "'"$$INSTLIBDIR"'" || "'"$$perllibdir"'"));=' \
 	    -e '	H' \
 	    -e '	x' \
 	    -e '}' \
@@ -2291,6 +2273,17 @@ endif
 po/build/locale/%/LC_MESSAGES/git.mo: po/%.po
 	$(QUIET_MSGFMT)mkdir -p $(dir $@) && $(MSGFMT) -o $@ $<
 
+PMFILES := $(wildcard perl/*.pm perl/*/*.pm perl/*/*/*.pm perl/*/*/*/*.pm)
+PMCFILES := $(patsubst perl/%.pm,perl/build/%.pmc,$(PMFILES))
+
+ifndef NO_PERL
+all:: $(PMCFILES)
+endif
+
+perl/build/%.pmc: perl/%.pm
+	$(QUIET_GEN)mkdir -p $(dir $@) && \
+	sed -e 's|@@LOCALEDIR@@|$(localedir_SQ)|g' < $< > $@
+
 FIND_SOURCE_FILES = ( \
 	git ls-files \
 		'*.[hcS]' \
@@ -2550,7 +2543,9 @@ ifndef NO_GETTEXT
 	(cd '$(DESTDIR_SQ)$(localedir_SQ)' && umask 022 && $(TAR) xof -)
 endif
 ifndef NO_PERL
-	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perllibdir_SQ)'
+	(cd perl/build && $(TAR) cf - .) | \
+	(cd '$(DESTDIR_SQ)$(perllibdir_SQ)' && umask 022 && $(TAR) xof -)
 	$(MAKE) -C gitweb install
 endif
 ifndef NO_TCLTK
@@ -2697,7 +2692,7 @@ clean: profile-clean coverage-clean
 	$(MAKE) -C Documentation/ clean
 ifndef NO_PERL
 	$(MAKE) -C gitweb clean
-	$(MAKE) -C perl clean
+	$(RM) -r perl/build/
 endif
 	$(MAKE) -C templates/ clean
 	$(MAKE) -C t/ clean
diff --git a/perl/.gitignore b/perl/.gitignore
index 0f1fc27f86..84c048a73c 100644
--- a/perl/.gitignore
+++ b/perl/.gitignore
@@ -1,8 +1 @@
-perl.mak
-perl.mak.old
-MYMETA.json
-MYMETA.yml
-blib
-blibdirs
-pm_to_blib
-PM.stamp
+/build/
diff --git a/perl/Git/I18N.pm b/perl/Git/I18N.pm
index 836a5c2382..dba96fff0a 100644
--- a/perl/Git/I18N.pm
+++ b/perl/Git/I18N.pm
@@ -18,7 +18,7 @@ our @EXPORT_OK = @EXPORT;
 
 sub __bootstrap_locale_messages {
 	our $TEXTDOMAIN = 'git';
-	our $TEXTDOMAINDIR = $ENV{GIT_TEXTDOMAINDIR} || '++LOCALEDIR++';
+	our $TEXTDOMAINDIR = $ENV{GIT_TEXTDOMAINDIR} || '@@LOCALEDIR@@';
 
 	require POSIX;
 	POSIX->import(qw(setlocale));
diff --git a/perl/Makefile b/perl/Makefile
deleted file mode 100644
index f657de20e3..0000000000
--- a/perl/Makefile
+++ /dev/null
@@ -1,90 +0,0 @@
-#
-# Makefile for perl support modules and routine
-#
-makfile:=perl.mak
-modules =
-
-PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
-prefix_SQ = $(subst ','\'',$(prefix))
-localedir_SQ = $(subst ','\'',$(localedir))
-
-ifndef V
-	QUIET = @
-endif
-
-all install instlibdir: $(makfile)
-	$(QUIET)$(MAKE) -f $(makfile) $@
-
-clean:
-	$(QUIET)test -f $(makfile) && $(MAKE) -f $(makfile) $@ || exit 0
-	$(RM) ppport.h
-	$(RM) $(makfile)
-	$(RM) $(makfile).old
-	$(RM) PM.stamp
-
-$(makfile): PM.stamp
-
-ifdef NO_PERL_MAKEMAKER
-instdir_SQ = $(subst ','\'',$(prefix)/lib)
-
-modules += Git
-modules += Git/I18N
-modules += Git/IndexInfo
-modules += Git/Packet
-modules += Git/SVN
-modules += Git/SVN/Memoize/YAML
-modules += Git/SVN/Fetcher
-modules += Git/SVN/Editor
-modules += Git/SVN/GlobSpec
-modules += Git/SVN/Log
-modules += Git/SVN/Migration
-modules += Git/SVN/Prompt
-modules += Git/SVN/Ra
-modules += Git/SVN/Utils
-
-$(makfile): ../GIT-CFLAGS Makefile
-	echo all: private-Error.pm Git.pm Git/I18N.pm > $@
-	set -e; \
-	for i in $(modules); \
-	do \
-		if test $$i = $${i%/*}; \
-		then \
-			subdir=; \
-		else \
-			subdir=/$${i%/*}; \
-		fi; \
-		echo '	$(RM) blib/lib/'$$i'.pm' >> $@; \
-		echo '	mkdir -p blib/lib'$$subdir >> $@; \
-		echo '	cp '$$i'.pm blib/lib/'$$i'.pm' >> $@; \
-	done
-	echo '	$(RM) blib/lib/Error.pm' >> $@
-	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || \
-	echo '	cp private-Error.pm blib/lib/Error.pm' >> $@
-	echo install: >> $@
-	set -e; \
-	for i in $(modules); \
-	do \
-		if test $$i = $${i%/*}; \
-		then \
-			subdir=; \
-		else \
-			subdir=/$${i%/*}; \
-		fi; \
-		echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/'$$i'.pm"' >> $@; \
-		echo '	mkdir -p "$$(DESTDIR)$(instdir_SQ)'$$subdir'"' >> $@; \
-		echo '	cp '$$i'.pm "$$(DESTDIR)$(instdir_SQ)/'$$i'.pm"' >> $@; \
-	done
-	echo '	$(RM) "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> $@
-	'$(PERL_PATH_SQ)' -MError -e 'exit($$Error::VERSION < 0.15009)' || \
-	echo '	cp private-Error.pm "$$(DESTDIR)$(instdir_SQ)/Error.pm"' >> $@
-	echo instlibdir: >> $@
-	echo '	echo $(instdir_SQ)' >> $@
-else
-$(makfile): Makefile.PL ../GIT-CFLAGS
-	$(PERL_PATH) $< PREFIX='$(prefix_SQ)' INSTALL_BASE='' --localedir='$(localedir_SQ)'
-endif
-
-# this is just added comfort for calling make directly in perl dir
-# (even though GIT-CFLAGS aren't used yet. If ever)
-../GIT-CFLAGS:
-	$(MAKE) -C .. GIT-CFLAGS
diff --git a/perl/Makefile.PL b/perl/Makefile.PL
deleted file mode 100644
index 3f29ba98a6..0000000000
--- a/perl/Makefile.PL
+++ /dev/null
@@ -1,62 +0,0 @@
-use strict;
-use warnings;
-use ExtUtils::MakeMaker;
-use Getopt::Long;
-use File::Find;
-
-# Don't forget to update the perl/Makefile, too.
-# Don't forget to test with NO_PERL_MAKEMAKER=YesPlease
-
-# Sanity: die at first unknown option
-Getopt::Long::Configure qw/ pass_through /;
-
-my $localedir = '';
-GetOptions("localedir=s" => \$localedir);
-
-sub MY::postamble {
-	return <<'MAKE_FRAG';
-instlibdir:
-	@echo '$(INSTALLSITELIB)'
-
-ifneq (,$(DESTDIR))
-ifeq (0,$(shell expr '$(MM_VERSION)' '>' 6.10))
-$(error ExtUtils::MakeMaker version "$(MM_VERSION)" is older than 6.11 and so \
-	is likely incompatible with the DESTDIR mechanism.  Try setting \
-	NO_PERL_MAKEMAKER=1 instead)
-endif
-endif
-
-MAKE_FRAG
-}
-
-# Find all the .pm files in "Git/" and Git.pm
-my %pm;
-find sub {
-	return unless /\.pm$/;
-
-	# sometimes File::Find prepends a ./  Strip it.
-	my $pm_path = $File::Find::name;
-	$pm_path =~ s{^\./}{};
-
-	$pm{$pm_path} = '$(INST_LIBDIR)/'.$pm_path;
-}, "Git", "Git.pm";
-
-
-# We come with our own bundled Error.pm. It's not in the set of default
-# Perl modules so install it if it's not available on the system yet.
-if ( !eval { require Error } || $Error::VERSION < 0.15009) {
-	$pm{'private-Error.pm'} = '$(INST_LIBDIR)/Error.pm';
-}
-
-# redirect stdout, otherwise the message "Writing perl.mak for Git"
-# disrupts the output for the target 'instlibdir'
-open STDOUT, ">&STDERR";
-
-WriteMakefile(
-	NAME            => 'Git',
-	VERSION_FROM    => 'Git.pm',
-	PM		=> \%pm,
-	PM_FILTER	=> qq[\$(PERL) -pe "s<\\Q++LOCALEDIR++\\E><$localedir>"],
-	MAKEFILE	=> 'perl.mak',
-	INSTALLSITEMAN3DIR => '$(SITEPREFIX)/share/man/man3'
-);
diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
index 1dbc85b214..0ef5cf1c60 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -1,6 +1,6 @@
 #!/usr/bin/perl
 
-use lib '../../perl/blib/lib';
+use lib '../../perl/build';
 use strict;
 use warnings;
 use Git;
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 116bd6a70c..69d81e1c97 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -919,7 +919,7 @@ then
 	fi
 fi
 
-GITPERLLIB="$GIT_BUILD_DIR"/perl/blib/lib:"$GIT_BUILD_DIR"/perl/blib/arch/auto/Git
+GITPERLLIB="$GIT_BUILD_DIR"/perl/build
 export GITPERLLIB
 test -d "$GIT_BUILD_DIR"/templates/blt || {
 	error "You haven't built things yet, have you?"
diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
index 22b6e4948f..7a8429bcc9 100644
--- a/wrap-for-bin.sh
+++ b/wrap-for-bin.sh
@@ -14,7 +14,7 @@ else
 	GIT_TEMPLATE_DIR='@@BUILD_DIR@@/templates/blt'
 	export GIT_TEMPLATE_DIR
 fi
-GITPERLLIB='@@BUILD_DIR@@/perl/blib/lib'"${GITPERLLIB:+:$GITPERLLIB}"
+GITPERLLIB='@@BUILD_DIR@@/perl/build'"${GITPERLLIB:+:$GITPERLLIB}"
 GIT_TEXTDOMAINDIR='@@BUILD_DIR@@/po/build/locale'
 PATH='@@BUILD_DIR@@/bin-wrappers:'"$PATH"
 
-- 
2.15.0.403.gc27cc4dac6

