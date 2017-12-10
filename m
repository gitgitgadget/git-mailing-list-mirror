Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9EC11F419
	for <e@80x24.org>; Sun, 10 Dec 2017 21:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751242AbdLJVNs (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Dec 2017 16:13:48 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:45526 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751100AbdLJVNq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Dec 2017 16:13:46 -0500
Received: by mail-wr0-f175.google.com with SMTP id h1so15574849wre.12
        for <git@vger.kernel.org>; Sun, 10 Dec 2017 13:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BhukQQqxRSk8fpzM/pIxsGoMrr4qDlz3ZV9HWqeiy/Y=;
        b=mZX0wvGU5kJ6Zjd2BLaZqyKg9UOqPYEPraV8bo/WtAXUl99dLpLyDXfWjpdj4TyTcD
         ExpeEkEJqS+idsJ892Ii/7Bw5JNomatChXuaG8qte9atiGsATj7jCXOV7AocbFaWK9vU
         vnClFselryMGSYL3u/a3oKLwfWEgJDAxEy7iKXjgqCh5dzbpeEx1OtihRiBYeBq6iu4B
         bJZe4esZvwRZDKS4MeXpIwIaV6HVOHru5q3S89i3+laetyG8y2d220+iWTTTYMqrKQao
         RT5+rf7tXwrxFTyht1zhhkFt1eFujwJr6H8nKkfk0mYi3bmwF0GF2WTuvGl4+llX/XGz
         Ieyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BhukQQqxRSk8fpzM/pIxsGoMrr4qDlz3ZV9HWqeiy/Y=;
        b=U7ap8ziE8DxYqk3Cp84sd3g5gwzvOHhdfDMxzCiCanLvd8+r79OYP1zbDh3iPOZi8W
         1NbrS/NXuzOcnDrwzD8KQMqJtjGxEHJCGlpzEiHwmel32gHWVr2jbmWCE7ffg8CJEWSK
         Ll+szw7H3XqgeRvOtAWAXigZ3ddAU1rr99KRGcwfQ4WWyKIfm3Br8zisISOsjIkOMd1+
         vFB6sEHblfGnFHvIn9vxkzg/9Cu1XHl2PIbMT1Sq8TVXzagU/fMOZSxAYu98tuzzZ1fY
         yuKc4OnXtm0DR8gUKljEHAE/kk+llF58bwuFrUn6xBO6a6ykGzHsWH6+dEaFeZDakk61
         xIYw==
X-Gm-Message-State: AJaThX7rsEiRnxrPVx5+IMZ8t9USeEQLHFc6yI5bAbq1ADVdsN2AlN5J
        svB7Fz3wGebgQpE6d+oJ6sAB7zZJ
X-Google-Smtp-Source: AGs4zMbTrACIedG6Ul7Nknl7qxUnkXkdbctBtBYNsEUn/RwEbHwlvGK/Z9QshTeHg4JRrgAJ281wCA==
X-Received: by 10.223.129.3 with SMTP id 3mr35056250wrm.90.1512940424172;
        Sun, 10 Dec 2017 13:13:44 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id m11sm14427666wrf.56.2017.12.10.13.13.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Dec 2017 13:13:43 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Dan Jacques <dnj@google.com>,
        Alex Riesen <alexander.riesen@cetitec.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Casey <drafnel@gmail.com>, Petr Baudis <pasky@ucw.cz>,
        Gerrit Pape <pape@smarden.org>,
        "martin f . krafft" <madduck@madduck.net>, Eric Wong <e@80x24.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3] Makefile: replace perl/Makefile.PL with simple make rules
Date:   Sun, 10 Dec 2017 21:13:33 +0000
Message-Id: <20171210211333.9820-1-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20171129195430.10069-1-avarab@gmail.com>
References: <20171129195430.10069-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the perl/Makefile.PL and the fallback perl/Makefile used under
NO_PERL_MAKEMAKER=NoThanks with a much simpler implementation heavily
inspired by how the i18n infrastructure's build process works[1].

The reason for having the Makefile.PL in the first place is that it
was initially[2] building a perl C binding to interface with libgit,
this functionality, that was removed[3] before Git.pm ever made it to
the master branch.

We've since since started maintaining a fallback perl/Makefile, as
MakeMaker wouldn't work on some platforms[4]. That's just the tip of
the iceberg. We have the PM.stamp hack in the top-level Makefile[5] to
detect whether we need to regenerate the perl/perl.mak, which I fixed
just recently to deal with issues like the perl version changing from
under us[6].

There is absolutely no reason for why this needs to be so complex
anymore. All we're getting out of this elaborate Rube Goldberg machine
was copying perl/* to perl/blib/* as we do a string-replacement on
the *.pm files to hardcode @@LOCALEDIR@@ in the source, as well as
pod2man-ing Git.pm & friends.

So replace the whole thing with something that's pretty much a copy of
how we generate po/build/**.mo from po/*.po, just with a small sed(1)
command instead of msgfmt. As that's being done rename the files
from *.pm to *.pmc just to indicate that they're generated (see
"perldoc -f require").

While I'm at it, change the fallback for Error.pm from being something
where we'll ship our own Error.pm if one doesn't exist at build time
to one where we just use a Git::Error wrapper that'll always prefer
the system-wide Error.pm, only falling back to our own copy if it
really doesn't exist at runtime. It's now shipped as
Git::FromCPAN::Error, making it easy to add other modules to
Git::FromCPAN::* in the future if that's needed.

Functional changes:

 * This will not always install into perl's idea of its global
   "installsitelib". This only potentially matters for packagers that
   need to expose Git.pm for non-git use, and as explained in the
   INSTALL file there's a trivial workaround.

 * The scripts themselves will 'use lib' the target directory, but if
   INSTLIBDIR is set it overrides it. It doesn't have to be this way,
   it could be set in addition to INSTLIBDIR, but my reading of [7] is
   that this is the desired behavior.

 * We don't build man pages for all of the perl modules as we used to,
   only Git(3pm). As discussed on-list[8] that we were building
   installed manpages for purely internal APIs like Git::I18N or
   private-Error.pm was always a bug anyway, and all the Git::SVN::*
   ones say they're internal APIs.

   There are apparently external users of Git.pm, but I don't expect
   there to be any of the others.

   As a side-effect of these general changes the perl documentation
   now only installed by install-{doc,man}, not a mere "install" as
   before.

1. 5e9637c629 ("i18n: add infrastructure for translating Git with
   gettext", 2011-11-18)

2. b1edc53d06 ("Introduce Git.pm (v4)", 2006-06-24)

3. 18b0fc1ce1 ("Git.pm: Kill Git.xs for now", 2006-09-23)

4. f848718a69 ("Make perl/ build procedure ActiveState friendly.",
   2006-12-04)

5. ee9be06770 ("perl: detect new files in MakeMaker builds",
   2012-07-27)

6. c59c4939c2 ("perl: regenerate perl.mak if perl -V changes",
   2017-03-29)

7. 0386dd37b1 ("Makefile: add PERLLIB_EXTRA variable that adds to
   default perl path", 2013-11-15)

8. 87bmjjv1pu.fsf@evledraar.booking.com ("Re: [PATCH] Makefile:
   replace perl/Makefile.PL with simple make rules"

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

This fixes the test failure we had on 32 bit Linux due to v2. That
error had nothing to do with 32 bit per-se, it was just a logic error
in the fallback logic if the system didn't have an Error.pm, and
evidently the 32 bit environment doesn't have that installed.

This also incorporates Junio's typo/grammar fixes of my commit
message, tbdiff with v2:

    @@ -27,7 +27,7 @@
         So replace the whole thing with something that's pretty much a copy of
         how we generate po/build/**.mo from po/*.po, just with a small sed(1)
         command instead of msgfmt. As that's being done rename the files
    -    from *.pm to *.pmc just to indicate that they're genreated (see
    +    from *.pm to *.pmc just to indicate that they're generated (see
         "perldoc -f require").
         
         While I'm at it, change the fallback for Error.pm from being something
    @@ -50,9 +50,9 @@
            it could be set in addition to INSTLIBDIR, but my reading of [7] is
            that this is the desired behavior.
         
    -     * We don't man pages for all of the perl modules as we used t, only
    -       Git(3pm). As discussed on-list[8] that we were building installed
    -       manpages for purely internal APIs like Git::I18N or
    +     * We don't build man pages for all of the perl modules as we used to,
    +       only Git(3pm). As discussed on-list[8] that we were building
    +       installed manpages for purely internal APIs like Git::I18N or
            private-Error.pm was always a bug anyway, and all the Git::SVN::*
            ones say they're internal APIs.
         
    @@ -354,8 +354,7 @@
     +
     +=head1 DESCRIPTION
     +
    -+Wraps the import function for the L<Error> module. The L<Git> module
    -+must be imported first.
    ++Wraps the import function for the L<Error> module.
     +
     +This module is only intended to be used for code shipping in the
     +C<git.git> repository. Use it for anything else at your peril!
    @@ -372,13 +371,13 @@
     +    } or do {
     +  my $error = $@ || "Zombie Error";
     +
    -+  my $Git_pm_path = $INC{"Git.pm"} || die "BUG: Should have loaded the Git module first!";
    ++  my $Git_Error_pm_path = $INC{"Git/Error.pm"} || die "BUG: Should have our own path from %INC!";
     +
     +  require File::Basename;
    -+  my $Git_pm_root = File::Basename::dirname($Git_pm_path) || die "BUG: Can't figure out dirname from '$Git_pm_path'!";
    ++  my $Git_Error_pm_root = File::Basename::dirname($Git_Error_pm_path) || die "BUG: Can't figure out lib/Git dirname from '$Git_Error_pm_path'!";
     +
     +  require File::Spec;
    -+  my $Git_pm_FromCPAN_root = File::Spec->catdir($Git_pm_root, qw(Git FromCPAN));
    ++  my $Git_pm_FromCPAN_root = File::Spec->catdir($Git_Error_pm_root, 'FromCPAN');
     +  die "BUG: '$Git_pm_FromCPAN_root' should be a directory!" unless -d $Git_pm_FromCPAN_root;
     +
     +  local @INC = ($Git_pm_FromCPAN_root, @INC);

So the issue is that we had some things (like git-send-email) which
would load Git::Error without first loading Git.pm.

There's no actual reason for why we can't just find the path relative
to Git::Error.pm instead of Git.pm.

I don't know what I was thinking when I wrote this, but this logic
should be fully robust, and I've confirmed that all tests pass
with/without an Error.pm installed globally.

 INSTALL                                          | 17 ++++-
 Makefile                                         | 67 ++++++++++--------
 contrib/examples/git-difftool.perl               |  2 +-
 git-send-email.perl                              |  2 +-
 perl/.gitignore                                  |  9 +--
 perl/Git.pm                                      |  2 +-
 perl/Git/Error.pm                                | 46 ++++++++++++
 perl/{private-Error.pm => Git/FromCPAN/Error.pm} |  0
 perl/Git/I18N.pm                                 |  2 +-
 perl/Makefile                                    | 90 ------------------------
 perl/Makefile.PL                                 | 62 ----------------
 t/perf/aggregate.perl                            |  2 +-
 t/test-lib.sh                                    |  2 +-
 wrap-for-bin.sh                                  |  2 +-
 14 files changed, 106 insertions(+), 199 deletions(-)
 create mode 100644 perl/Git/Error.pm
 rename perl/{private-Error.pm => Git/FromCPAN/Error.pm} (100%)
 delete mode 100644 perl/Makefile
 delete mode 100644 perl/Makefile.PL

diff --git a/INSTALL b/INSTALL
index ffb071e9f0..808e07b659 100644
--- a/INSTALL
+++ b/INSTALL
@@ -84,9 +84,24 @@ Issues of note:
 
 	GIT_EXEC_PATH=`pwd`
 	PATH=`pwd`:$PATH
-	GITPERLLIB=`pwd`/perl/blib/lib
+	GITPERLLIB=`pwd`/perl/build/lib
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
+       prefix=/usr perllibdir=/usr/$(/usr/bin/perl -MConfig -wle 'print substr $Config{installsitelib}, 1 + length $Config{siteprefixexp}')
+
+   Will result in e.g. perllibdir=/usr/share/perl/5.26.1 on Debian,
+   perllibdir=/usr/share/perl5 (which we'd use by default) on CentOS.
+
  - Git is reasonably self-sufficient, but does depend on a few external
    programs and libraries.  Git can be used without most of them by adding
    the approriate "NO_<LIBRARY>=YesPlease" to the make command line or
diff --git a/Makefile b/Makefile
index fef9c8d272..5c0490d757 100644
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
@@ -1526,9 +1524,6 @@ ifdef SHA1_MAX_BLOCK_SIZE
 	LIB_OBJS += compat/sha1-chunked.o
 	BASIC_CFLAGS += -DSHA1_MAX_BLOCK_SIZE="$(SHA1_MAX_BLOCK_SIZE)"
 endif
-ifdef NO_PERL_MAKEMAKER
-	export NO_PERL_MAKEMAKER
-endif
 ifdef NO_HSTRERROR
 	COMPAT_CFLAGS += -DNO_HSTRERROR
 	COMPAT_OBJS += compat/hstrerror.o
@@ -1715,8 +1710,10 @@ ETC_GITATTRIBUTES_SQ = $(subst ','\'',$(ETC_GITATTRIBUTES))
 DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
 bindir_SQ = $(subst ','\'',$(bindir))
 bindir_relative_SQ = $(subst ','\'',$(bindir_relative))
+mandir_SQ = $(subst ','\'',$(mandir))
 mandir_relative_SQ = $(subst ','\'',$(mandir_relative))
 infodir_relative_SQ = $(subst ','\'',$(infodir_relative))
+perllibdir_SQ = $(subst ','\'',$(perllibdir))
 localedir_SQ = $(subst ','\'',$(localedir))
 gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
 template_dir_SQ = $(subst ','\'',$(template_dir))
@@ -1825,9 +1822,6 @@ all::
 ifndef NO_TCLTK
 	$(QUIET_SUBDIR0)git-gui $(QUIET_SUBDIR1) gitexecdir='$(gitexec_instdir_SQ)' all
 	$(QUIET_SUBDIR0)gitk-git $(QUIET_SUBDIR1) all
-endif
-ifndef NO_PERL
-	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' localedir='$(localedir_SQ)' all
 endif
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) SHELL_PATH='$(SHELL_PATH_SQ)' PERL_PATH='$(PERL_PATH_SQ)'
 
@@ -1908,7 +1902,8 @@ common-cmds.h: $(wildcard Documentation/git-*.txt)
 
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
 	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
-	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP):$(PAGER_ENV)
+	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP):$(PAGER_ENV):\
+	$(perllibdir_SQ)
 define cmd_munge_script
 $(RM) $@ $@+ && \
 sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
@@ -1952,29 +1947,17 @@ git.res: git.rc GIT-VERSION-FILE
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
 
-PERL_DEFINES = $(PERL_PATH_SQ):$(PERLLIB_EXTRA_SQ)
-$(SCRIPT_PERL_GEN): % : %.perl perl/perl.mak GIT-PERL-DEFINES GIT-VERSION-FILE
+PERL_DEFINES = $(PERL_PATH_SQ):$(PERLLIB_EXTRA_SQ):$(perllibdir_SQ)
+$(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-VERSION-FILE
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
 	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
 	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
 	sed -e '1{' \
 	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
 	    -e '	h' \
-	    -e '	s=.*=use lib (split(/$(pathsep)/, $$ENV{GITPERLLIB} || "'"$$INSTLIBDIR"'"));=' \
+	    -e '	s=.*=use lib (split(/$(pathsep)/, $$ENV{GITPERLLIB} || "'"$$INSTLIBDIR"'" || "'"$(perllibdir_SQ)"'"));=' \
 	    -e '	H' \
 	    -e '	x' \
 	    -e '}' \
@@ -2292,6 +2275,21 @@ endif
 po/build/locale/%/LC_MESSAGES/git.mo: po/%.po
 	$(QUIET_MSGFMT)mkdir -p $(dir $@) && $(MSGFMT) -o $@ $<
 
+PMFILES := $(wildcard perl/*.pm perl/*/*.pm perl/*/*/*.pm perl/*/*/*/*.pm)
+PMCFILES := $(patsubst perl/%.pm,perl/build/lib/%.pmc,$(PMFILES))
+
+ifndef NO_PERL
+all:: $(PMCFILES)
+endif
+
+perl/build/lib/%.pmc: perl/%.pm
+	$(QUIET_GEN)mkdir -p $(dir $@) && \
+	sed -e 's|@@LOCALEDIR@@|$(localedir_SQ)|g' < $< > $@
+
+perl/build/man/man3/Git.3pm: perl/Git.pm
+	$(QUIET_GEN)mkdir -p $(dir $@) && \
+	pod2man $< $@
+
 FIND_SOURCE_FILES = ( \
 	git ls-files \
 		'*.[hcS]' \
@@ -2551,7 +2549,9 @@ ifndef NO_GETTEXT
 	(cd '$(DESTDIR_SQ)$(localedir_SQ)' && umask 022 && $(TAR) xof -)
 endif
 ifndef NO_PERL
-	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perllibdir_SQ)'
+	(cd perl/build/lib && $(TAR) cf - .) | \
+	(cd '$(DESTDIR_SQ)$(perllibdir_SQ)' && umask 022 && $(TAR) xof -)
 	$(MAKE) -C gitweb install
 endif
 ifndef NO_TCLTK
@@ -2601,12 +2601,17 @@ endif
 install-gitweb:
 	$(MAKE) -C gitweb install
 
-install-doc:
+install-doc: install-man-perl
 	$(MAKE) -C Documentation install
 
-install-man:
+install-man: install-man-perl
 	$(MAKE) -C Documentation install-man
 
+install-man-perl: perl/build/man/man3/Git.3pm
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mandir_SQ)/man3'
+	(cd perl/build/man/man3 && $(TAR) cf - .) | \
+	(cd '$(DESTDIR_SQ)$(mandir_SQ)/man3' && umask 022 && $(TAR) xof -)
+
 install-html:
 	$(MAKE) -C Documentation install-html
 
@@ -2698,7 +2703,7 @@ clean: profile-clean coverage-clean
 	$(MAKE) -C Documentation/ clean
 ifndef NO_PERL
 	$(MAKE) -C gitweb clean
-	$(MAKE) -C perl clean
+	$(RM) -r perl/build/
 endif
 	$(MAKE) -C templates/ clean
 	$(MAKE) -C t/ clean
diff --git a/contrib/examples/git-difftool.perl b/contrib/examples/git-difftool.perl
index df59bdfe97..fb0fd0b84b 100755
--- a/contrib/examples/git-difftool.perl
+++ b/contrib/examples/git-difftool.perl
@@ -13,7 +13,7 @@
 use 5.008;
 use strict;
 use warnings;
-use Error qw(:try);
+use Git::Error qw(:try);
 use File::Basename qw(dirname);
 use File::Copy;
 use File::Find;
diff --git a/git-send-email.perl b/git-send-email.perl
index 2208dcc213..88a0edcd7d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -26,7 +26,7 @@ use Text::ParseWords;
 use Term::ANSIColor;
 use File::Temp qw/ tempdir tempfile /;
 use File::Spec::Functions qw(catdir catfile);
-use Error qw(:try);
+use Git::Error qw(:try);
 use Cwd qw(abs_path cwd);
 use Git;
 use Git::I18N;
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
diff --git a/perl/Git.pm b/perl/Git.pm
index ffa09ace92..02a3871e94 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -101,7 +101,7 @@ increase notwithstanding).
 
 
 use Carp qw(carp croak); # but croak is bad - throw instead
-use Error qw(:try);
+use Git::Error qw(:try);
 use Cwd qw(abs_path cwd);
 use IPC::Open2 qw(open2);
 use Fcntl qw(SEEK_SET SEEK_CUR);
diff --git a/perl/Git/Error.pm b/perl/Git/Error.pm
new file mode 100644
index 0000000000..5874672150
--- /dev/null
+++ b/perl/Git/Error.pm
@@ -0,0 +1,46 @@
+package Git::Error;
+use 5.008;
+use strict;
+use warnings;
+
+=head1 NAME
+
+Git::Error - Wrapper for the L<Error> module, in case it's not installed
+
+=head1 DESCRIPTION
+
+Wraps the import function for the L<Error> module.
+
+This module is only intended to be used for code shipping in the
+C<git.git> repository. Use it for anything else at your peril!
+
+=cut
+
+sub import {
+    shift;
+    my $caller = caller;
+
+    eval {
+	require Error;
+	1;
+    } or do {
+	my $error = $@ || "Zombie Error";
+
+	my $Git_Error_pm_path = $INC{"Git/Error.pm"} || die "BUG: Should have our own path from %INC!";
+
+	require File::Basename;
+	my $Git_Error_pm_root = File::Basename::dirname($Git_Error_pm_path) || die "BUG: Can't figure out lib/Git dirname from '$Git_Error_pm_path'!";
+
+	require File::Spec;
+	my $Git_pm_FromCPAN_root = File::Spec->catdir($Git_Error_pm_root, 'FromCPAN');
+	die "BUG: '$Git_pm_FromCPAN_root' should be a directory!" unless -d $Git_pm_FromCPAN_root;
+
+	local @INC = ($Git_pm_FromCPAN_root, @INC);
+	require Error;
+    };
+
+    local @_ = ($caller, @_);
+    goto &Error::import;
+}
+
+1;
diff --git a/perl/private-Error.pm b/perl/Git/FromCPAN/Error.pm
similarity index 100%
rename from perl/private-Error.pm
rename to perl/Git/FromCPAN/Error.pm
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
index e401208488..3096f4ec77 100755
--- a/t/perf/aggregate.perl
+++ b/t/perf/aggregate.perl
@@ -1,6 +1,6 @@
 #!/usr/bin/perl
 
-use lib '../../perl/blib/lib';
+use lib '../../perl/build/lib';
 use strict;
 use warnings;
 use Git;
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 116bd6a70c..85a0fabb47 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -919,7 +919,7 @@ then
 	fi
 fi
 
-GITPERLLIB="$GIT_BUILD_DIR"/perl/blib/lib:"$GIT_BUILD_DIR"/perl/blib/arch/auto/Git
+GITPERLLIB="$GIT_BUILD_DIR"/perl/build/lib
 export GITPERLLIB
 test -d "$GIT_BUILD_DIR"/templates/blt || {
 	error "You haven't built things yet, have you?"
diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
index 22b6e4948f..5842408817 100644
--- a/wrap-for-bin.sh
+++ b/wrap-for-bin.sh
@@ -14,7 +14,7 @@ else
 	GIT_TEMPLATE_DIR='@@BUILD_DIR@@/templates/blt'
 	export GIT_TEMPLATE_DIR
 fi
-GITPERLLIB='@@BUILD_DIR@@/perl/blib/lib'"${GITPERLLIB:+:$GITPERLLIB}"
+GITPERLLIB='@@BUILD_DIR@@/perl/build/lib'"${GITPERLLIB:+:$GITPERLLIB}"
 GIT_TEXTDOMAINDIR='@@BUILD_DIR@@/po/build/locale'
 PATH='@@BUILD_DIR@@/bin-wrappers:'"$PATH"
 
-- 
2.15.1.424.g9478a66081

