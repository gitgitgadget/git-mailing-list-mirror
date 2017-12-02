Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 840D320C13
	for <e@80x24.org>; Sat,  2 Dec 2017 15:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbdLBPrf (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 10:47:35 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:33590 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbdLBPrd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 10:47:33 -0500
Received: by mail-qt0-f179.google.com with SMTP id e2so16557480qti.0
        for <git@vger.kernel.org>; Sat, 02 Dec 2017 07:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qkg1FXCjhXZiw5sBMLrof7djMhXzzh3OqMl2w8f3aTY=;
        b=PnpPRg3LGubUSmWiNZ2gznWWMRU37cFvHK/OJsol/Anv0PwVw/14KilxDKepbVuBRZ
         4qZ+eUJVMuWAvA00OQ8sGXelUsMiIPu0TyutdmzCT1wjegnPDzPqx3yKkoS6Ogka9mbM
         EKYs+9c1ruaclSQl0GWTn42t1Os7enRoEPkMIC5IAZKGutTHKVMZyNk6tWNXJaZXVxFe
         B4E4EaqOF3t5wSAwP9boq0VKrmTwT+hQUXG4iK5Nq/SwNVyvMBfdhIPqg+v7V338zPDj
         orG3h1LKvq9o17ykMQWr9XtnQYqrqbyk9XiESDmK46SvYPofXUKvzcS8XK6gTTPLaE6w
         NHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qkg1FXCjhXZiw5sBMLrof7djMhXzzh3OqMl2w8f3aTY=;
        b=pnZFGnDztyZg+vNdvDn0QRfroXchJk6gWxBr+2Et1FTNZRROlN1Rx1/WUqesXQ37PD
         SuQFt2gd7IBK/H7XW4ckwYFl0uGanwBRw/7DC6CbgtAovcHwkDozzEYJfXQWup0Gjqjf
         Q7+ueEoPV6sJIazvFeh3W6s/fR8wOpjIYEXmwLWemd6soEr3nGmGO/wfvkjGCiNCSyR3
         uNkoFZz7SXy7+l0K508Ae+w2zD5XErozBbrWISVJHxdAb6rMQrUkumx88pf16yt2cSLm
         IhaMXAqhdhc2rb7IP8W/lHYu7AXE7XAmsPZhX4BmMN9ofkGmQ03RDm28VxrJ+O8FACpW
         /JAw==
X-Gm-Message-State: AKGB3mJjgDbiaEeh6bTyTANPJoUDRH7701euQEqWMqJW3Qc5OPhigU80
        IziJJIoukulXmuQlVhuNrBj3GQ==
X-Google-Smtp-Source: AGs4zMYKsidnjLSj7Rq1MFrf+pNbiWwLNe1PCvuMyw9rbekgVbIGEe5FwLksJvrBe3vWUKdyVfrHVA==
X-Received: by 10.237.53.200 with SMTP id d8mr13512940qte.32.1512229652405;
        Sat, 02 Dec 2017 07:47:32 -0800 (PST)
Received: from dnj-macbookpro.fios-router.home (pool-108-32-46-175.pitbpa.fios.verizon.net. [108.32.46.175])
        by smtp.gmail.com with ESMTPSA id w56sm6453286qta.60.2017.12.02.07.47.31
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 02 Dec 2017 07:47:31 -0800 (PST)
From:   Dan Jacques <dnj@google.com>
To:     avarab@gmail.com
Cc:     Johannes.Schindelin@gmx.de, dnj@google.com, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v4 3/4] RUNTIME_PREFIX relocatable Git
Date:   Sat,  2 Dec 2017 10:47:30 -0500
Message-Id: <20171202154730.26258-1-dnj@google.com>
X-Mailer: git-send-email 2.15.0.chromium12
In-Reply-To: <87k1y8vlzs.fsf@evledraar.booking.com>
References: <87k1y8vlzs.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My initial set of replies are inline here:
https://public-inbox.org/git/20171129223807.91343-1-dnj@google.com/T/#m1ff5cda787eaea4a4015a8f00a8be5966122c73a

I put together this solution for the I18N module. It exports "localedir" to
the Perl header and injects the correct value into Git::I18N. It also
suppresses the emission of the full ++LOCALEDIR++ when in runtime prefix
mode.

One downside of this approach is that, since the point of resolution happens
at the beginning of the script execution, external users of the runtime
prefix Git::I18N module will not be able to resolve the locale directory.
I think this is okay, though, since RUNTIME_PREFIX_PERL is decidedly *not*
intended for system installation and is not trying to offer system module
import portability.

After looking a bit at your $ENV{GIT_EXEC_PATH} optimization suggestion, I
ended up favoring the current usage of FindBin::Bin for a few reasons:

- Encoding the relative GITEXECDIR into the script is more consistent with
  how "exec_cmd.c" does its own self-resolution.
- The resolution code is a bit more readable, both in terms of what it's
  doing and where it starts from.
- It makes the scripts individually executable, rather than having to go
  through the Git wrapper. This is, minimally, useful for testing.

I admittedly don't know much about FindBin, so if it has a downside that
could outweigh this I'm more than happy to reevaluate.

With respect to testing, I did find "GIT_TEST_INSTALLED". Unfortunately,
it doesn't seem to work against the full test suite even on master, and
individual tests, especially Perl and locale, set their own path
expectations. I think including installation-relative testing here would
take a fair amount of work.

Note that this is a replacement for [PATCH v4 3/4], so if you're trying to
apply it, you will need to build it on top of the preceding patches.

Many thanks,
-Dan

---
 Makefile                               | 59 +++++++++++++++++++++++++++++++---
 perl/Git/I18N.pm                       |  2 +-
 perl/Makefile                          | 17 ++++++----
 perl/header_runtime_prefix.pl.template | 31 ++++++++++++++++++
 t/test-lib.sh                          | 13 +++++---
 5 files changed, 107 insertions(+), 15 deletions(-)
 create mode 100644 perl/header_runtime_prefix.pl.template

diff --git a/Makefile b/Makefile
index 80904f8b0..558bd3ebb 100644
--- a/Makefile
+++ b/Makefile
@@ -425,6 +425,10 @@ all::
 #
 # to say "export LESS=FRX (and LV=-c) if the environment variable
 # LESS (and LV) is not set, respectively".
+#
+# Define RUNTIME_PREFIX_PERL to configure Git's PERL commands to locate Git
+# support libraries relative to their filesystem path instead of hard-coding
+# it.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -462,6 +466,7 @@ ARFLAGS = rcs
 #   mandir
 #   infodir
 #   htmldir
+#   localedir
 #   perllibdir
 # This can help installing the suite in a relocatable way.
 
@@ -483,9 +488,12 @@ lib = lib
 # DESTDIR =
 pathsep = :
 
+gitexecdir_relative = $(patsubst $(prefix)/%,%,$(gitexecdir))
 mandir_relative = $(patsubst $(prefix)/%,%,$(mandir))
 infodir_relative = $(patsubst $(prefix)/%,%,$(infodir))
+localedir_relative = $(patsubst $(prefix)/%,%,$(localedir))
 htmldir_relative = $(patsubst $(prefix)/%,%,$(htmldir))
+perllibdir_relative = $(patsubst $(prefix)/%,%,$(perllibdir))
 
 export prefix bindir sharedir sysconfdir gitwebdir localedir
 
@@ -1718,11 +1726,13 @@ bindir_relative_SQ = $(subst ','\'',$(bindir_relative))
 mandir_relative_SQ = $(subst ','\'',$(mandir_relative))
 infodir_relative_SQ = $(subst ','\'',$(infodir_relative))
 localedir_SQ = $(subst ','\'',$(localedir))
+localedir_relative_SQ = $(subst ','\'',$(localedir_relative))
 gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
+gitexecdir_relative_SQ = $(subst ','\'',$(gitexecdir_relative))
 template_dir_SQ = $(subst ','\'',$(template_dir))
 htmldir_relative_SQ = $(subst ','\'',$(htmldir_relative))
 prefix_SQ = $(subst ','\'',$(prefix))
-perllibdir_SQ = $(subst ','\'',$(perllibdir))
+perllibdir_relative_SQ = $(subst ','\'',$(perllibdir_relative))
 gitwebdir_SQ = $(subst ','\'',$(gitwebdir))
 
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
@@ -1965,14 +1975,52 @@ perl/PM.stamp: GIT-PERL-DEFINES FORCE
 	$(RM) $@+
 
 PERL_HEADER_TEMPLATE = perl/header_fixed_prefix.pl.template
+perl_localedir = $(localedir)
 
 PERL_DEFINES := $(PERL_PATH_SQ) $(PERLLIB_EXTRA_SQ)
-PERL_DEFINES += $(NO_PERL_MAKEMAKER)
-PERL_DEFINES += $(perllibdir)
+PERL_DEFINES += $(NO_PERL_MAKEMAKER) $(RUNTIME_PREFIX_PERL)
+
+# Support Perl runtime prefix. In this mode, a different header is installed
+# into Perl scripts. This header expects both the scripts and their support
+# library to be installed relative to $(prefix), and resolves the path to
+# the Perl libraries (perllibdir) from the executable's current path
+# (gitexecdir).
+#
+# This configuration requires both $(perllibdir) and $(gitexecdir) to be
+# relative paths, and will error if this is not the case.
+ifdef RUNTIME_PREFIX_PERL
+
+PERL_HEADER_TEMPLATE = perl/header_runtime_prefix.pl.template
+
+# RUNTIME_PREFIX_PERL requires a $(perllibdir) value.
+ifeq ($(perllibdir),)
+perllibdir = $(sharedir)/perl5
+endif
+
+ifneq ($(filter /%,$(firstword $(perllibdir_relative))),)
+$(error RUNTIME_PREFIX_PERL requires a relative perllibdir, not: $(perllibdir))
+endif
+
+ifneq ($(filter /%,$(firstword $(gitexecdir_relative))),)
+$(error RUNTIME_PREFIX_PERL requires a relative gitexecdir, not: $(gitexecdir))
+endif
+
+ifneq ($(filter /%,$(firstword $(localedir_relative))),)
+$(error RUNTIME_PREFIX_PERL requires a prefix-relative localedir, not: $(localedir))
+endif
+
+# Don't need to export a locale directory to Perl scripts, since the runtime
+# header will resolve it.
+perl_localedir =
+
+endif
+
+PERL_DEFINES += $(gitexecdir) $(perllibdir) $(localedir)
+export perl_localedir
 
 perl/perl.mak: GIT-CFLAGS GIT-PREFIX perl/Makefile perl/Makefile.PL
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' \
-	  prefix='$(prefix_SQ)' perllibdir='$(perllibdir_SQ)' $(@F)
+	  prefix='$(prefix_SQ)' perllibdir='$(perllibdir_relative_SQ)' $(@F)
 
 $(SCRIPT_PERL_GEN): % : %.perl perl/perl.mak GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
 	$(QUIET_GEN)$(RM) $@ $@+ && \
@@ -2001,6 +2049,9 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES perl/perl.mak Makefile
 	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
 	sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
 	    -e 's=@@INSTLIBDIR@@='$$INSTLIBDIR'=g' \
+	    -e 's=@@GITEXECDIR@@=$(gitexecdir_relative_SQ)=g' \
+	    -e 's=@@PERLLIBDIR@@=$(perllibdir_relative_SQ)=g' \
+	    -e 's=@@LOCALEDIR@@=$(localedir_relative_SQ)=g' \
 	    $< >$@+ && \
 	mv $@+ $@
 
diff --git a/perl/Git/I18N.pm b/perl/Git/I18N.pm
index 836a5c238..25141d27d 100644
--- a/perl/Git/I18N.pm
+++ b/perl/Git/I18N.pm
@@ -18,7 +18,7 @@ our @EXPORT_OK = @EXPORT;
 
 sub __bootstrap_locale_messages {
 	our $TEXTDOMAIN = 'git';
-	our $TEXTDOMAINDIR = $ENV{GIT_TEXTDOMAINDIR} || '++LOCALEDIR++';
+	our $TEXTDOMAINDIR ||= $ENV{GIT_TEXTDOMAINDIR} || '++LOCALEDIR++';
 
 	require POSIX;
 	POSIX->import(qw(setlocale));
diff --git a/perl/Makefile b/perl/Makefile
index b2aeeb0d8..14bdda99d 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -8,7 +8,7 @@
 #
 # prefix must be defined as the Git installation prefix.
 #
-# localedir must be defined as the path to the locale data.
+# perl_localedir must be defined as the path to the locale data.
 #
 # perllibdir may be optionally defined to override the default Perl module
 # installation directory, which is relative to prefix. If perllibdir is not
@@ -22,7 +22,7 @@ modules =
 
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
 prefix_SQ = $(subst ','\'',$(prefix))
-localedir_SQ = $(subst ','\'',$(localedir))
+localedir_SQ = $(subst ','\'',$(perl_localedir))
 
 ifndef V
 	QUIET = @
@@ -116,11 +116,16 @@ else
 # This may be empty if perllibdir was empty.
 instdir_SQ = $(subst ','\'',$(perllib_instdir))
 
+MAKEMAKER_PARAMS = PREFIX='$(prefix_SQ)' INSTALL_BASE=''
+ifneq ($(instdir_SQ),)
+MAKEMAKER_PARAMS += LIB='$(instdir_SQ)'
+endif
+ifneq ($(localedir_SQ),)
+MAKEMAKER_PARAMS += --localedir='$(localedir_SQ)'
+endif
+
 $(makfile): Makefile.PL ../GIT-CFLAGS ../GIT-PERL-DEFINES
-	$(PERL_PATH) $< \
-	  PREFIX='$(prefix_SQ)' INSTALL_BASE='' \
-	  LIB='$(instdir_SQ)' \
-	  --localedir='$(localedir_SQ)'
+	$(PERL_PATH) $< $(MAKEMAKER_PARAMS)
 
 endif
 
diff --git a/perl/header_runtime_prefix.pl.template b/perl/header_runtime_prefix.pl.template
new file mode 100644
index 000000000..9cc63cfb6
--- /dev/null
+++ b/perl/header_runtime_prefix.pl.template
@@ -0,0 +1,31 @@
+# BEGIN RUNTIME_PREFIX_PERL generated code.
+#
+# This finds our Git::* libraries relative to the script's runtime path.
+sub __git_system_path {
+	my ($relpath) = @_;
+	my $gitexecdir_relative = '@@GITEXECDIR@@';
+
+	require FindBin;
+	require File::Spec;
+	($FindBin::Bin =~ m=${gitexecdir_relative}$=) || die('Unrecognized runtime path.');
+	my $prefix = substr($FindBin::Bin, 0, -length($gitexecdir_relative));
+	return File::Spec->catdir($prefix, $relpath);
+}
+
+BEGIN {
+	use lib split /@@PATHSEP@@/,
+	(
+		$ENV{GITPERLLIB} ||
+		do {
+			my $perllibdir = __git_system_path('@@PERLLIBDIR@@');
+			(-e $perllibdir) || die("Invalid system path ($relpath): $path");
+			$perllibdir;
+		}
+	);
+
+	# Export the system locale directory to the I18N module. The locale directory
+	# is only installed if NO_GETTEXT is set.
+	$Git::I18N::TEXTDOMAINDIR = __git_system_path('@@LOCALEDIR@@');
+}
+
+# END RUNTIME_PREFIX_PERL generated code.
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 116bd6a70..d6ea423af 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -919,11 +919,16 @@ then
 	fi
 fi
 
-GITPERLLIB="$GIT_BUILD_DIR"/perl/blib/lib:"$GIT_BUILD_DIR"/perl/blib/arch/auto/Git
+if test -n "$GIT_TEST_PERLLIB"
+then
+  GITPERLLIB="$GIT_TEST_PERLLIB"
+else
+	GITPERLLIB="$GIT_BUILD_DIR"/perl/blib/lib:"$GIT_BUILD_DIR"/perl/blib/arch/auto/Git
+	test -d "$GIT_BUILD_DIR"/templates/blt || {
+		error "You haven't built things yet, have you?"
+	}
+fi
 export GITPERLLIB
-test -d "$GIT_BUILD_DIR"/templates/blt || {
-	error "You haven't built things yet, have you?"
-}
 
 if ! test -x "$GIT_BUILD_DIR"/t/helper/test-chmtime
 then
-- 
2.15.0.chromium12

