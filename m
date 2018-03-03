Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DCE71F404
	for <e@80x24.org>; Sat,  3 Mar 2018 15:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752104AbeCCPjc (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 10:39:32 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33291 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932140AbeCCPja (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 10:39:30 -0500
Received: by mail-wr0-f195.google.com with SMTP id v18so12325250wrv.0
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 07:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=R4jF6nj03RQ6yeEUpPgPdY7LseoPGsegcORYxnTLO+Y=;
        b=ENDL7GcVI/Ia46f+uueL7b0HtDQ1gN+Z6/56gLAQMFCbRViueeZLJ+FzKER5NUJViS
         ceZFeVYgs/eRqBtoFiQqelaVcWPG1sTkODuwjZ8mxMosMiMW1VEzWTryKE9AY9urQ+p9
         ASN06gsjMpK1eqEhOUzWFWp12+sy8mHzo18Ye/3YoZM3w8uUnXp8yjyZuZm4kkc5EtPJ
         m4VLLJjjJpfER4VqBYULG8C0Uz5uKEQnptVdyZ/vQk79g0Qu8T8QtnmOq/cL4z37zMTW
         vz3eTirqaZqOwy5k52aoQxPWUcch5Vua5SA+htYJIjoqlzDiB7pjQ2/wdMlSTSYYcIwn
         cosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=R4jF6nj03RQ6yeEUpPgPdY7LseoPGsegcORYxnTLO+Y=;
        b=qCGDMNUElxEiW+LIud5MES0SIdg338bya5uxsrSLXxTmpiWLQBiheYkMPWrOke7pHa
         8Qr0dn3Hw4i25jn8+Nl4F3Q0pUSj9LYupQ38EI4ZuUXUIuVIYcjD+7Kl/h8Oaoz41EPz
         mKOGt5p09dqy1IpIRTQgo6dXrBB5E3bS7s2N/imMfqL4RU8M3prTsJcRQwW+hYv5dkAa
         M4gTOzNb54JUKVVQ/gZCaOSpiyPwEqY/I0xckPEygupFp7EwT+yjLgsORCa/WoubtkiG
         qJbjTMJbJeXZMilMtUnPn051nmNMjYZ1a9SAZIVfh0Rs2MDA+0SzTzMkkfVIqxEHLgI9
         CXKw==
X-Gm-Message-State: APf1xPBftAlpFQur56mQtSAd8tQf5QqKGmJ6i4GsZHt1v3VYfDKVqPHR
        3Bgt827LmiDL5sGY9mZPm7qZWs7t
X-Google-Smtp-Source: AG47ELtiEEWm8ZsqFzFje57s8gHlg9C9LIyzrvR+qUKThinEHJpQqmDj2lC0hkLtGR5u/KktUoCmqA==
X-Received: by 10.223.170.153 with SMTP id h25mr7709377wrc.236.1520091568123;
        Sat, 03 Mar 2018 07:39:28 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y1sm6899379wrh.80.2018.03.03.07.39.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 07:39:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Todd Zullinger <tmz@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 13/13] perl Git::LoadCPAN: emit better errors under NO_PERL_CPAN_FALLBACKS
Date:   Sat,  3 Mar 2018 15:38:17 +0000
Message-Id: <20180303153817.20270-14-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180303153817.20270-1-avarab@gmail.com>
References: <20180303153817.20270-1-avarab@gmail.com>
In-Reply-To: <20180225194637.18630-1-avarab@gmail.com>
References: <20180225194637.18630-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before my 20d2a30f8f ("Makefile: replace perl/Makefile.PL with simple
make rules", 2017-12-10) on an OS package that removed the
private-Error.pm copy we carried around manually removing the OS's
Error.pm would yield:

    $ git add -p
    Can't locate Error.pm in @INC (you may need to install the Error module) [...]

Now, before this change we'll instead emit this more cryptic error:

    $ git add -p
    BUG: '/usr/share/perl5/Git/FromCPAN' should be a directory! at /usr/share/perl5/Git/Error.pm line 36.

This is a confusing error. Now if the new NO_PERL_CPAN_FALLBACKS
option is specified and we can't find the module we'll instead emit:

    $ /tmp/git/bin/git add -p
    BUG: The 'Error' module is not here, but NO_PERL_CPAN_FALLBACKS was set!

    [...]

Where [...] is the lengthy explanation seen in the change below, which
explains what the potential breakage is, and how to fix it.

The reason for checking @@NO_PERL_CPAN_FALLBACKS@@] against the empty
string in Perl is as opposed to checking for a boolean value is that
that's (as far as I can tell) make's idea of a string that's set, and
e.g. NO_PERL_CPAN_FALLBACKS=0 is enough to set NO_PERL_CPAN_FALLBACKS.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 INSTALL              | 11 ++++++++---
 Makefile             |  5 ++++-
 perl/Git/LoadCPAN.pm | 33 ++++++++++++++++++++++++++++++++-
 3 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/INSTALL b/INSTALL
index 808e07b659..60e515eaf7 100644
--- a/INSTALL
+++ b/INSTALL
@@ -88,9 +88,9 @@ Issues of note:
 	export GIT_EXEC_PATH PATH GITPERLLIB
 
  - By default (unless NO_PERL is provided) Git will ship various perl
-   scripts & libraries it needs. However, for simplicity it doesn't
-   use the ExtUtils::MakeMaker toolchain to decide where to place the
-   perl libraries. Depending on the system this can result in the perl
+   scripts. However, for simplicity it doesn't use the
+   ExtUtils::MakeMaker toolchain to decide where to place the perl
+   libraries. Depending on the system this can result in the perl
    libraries not being where you'd like them if they're expected to be
    used by things other than Git itself.
 
@@ -102,6 +102,11 @@ Issues of note:
    Will result in e.g. perllibdir=/usr/share/perl/5.26.1 on Debian,
    perllibdir=/usr/share/perl5 (which we'd use by default) on CentOS.
 
+ - Unless NO_PERL is provided Git will ship various perl libraries it
+   needs. Distributors of Git will usually want to set
+   NO_PERL_CPAN_FALLBACKS if NO_PERL is not provided to use their own
+   copies of the CPAN modules Git needs.
+
  - Git is reasonably self-sufficient, but does depend on a few external
    programs and libraries.  Git can be used without most of them by adding
    the approriate "NO_<LIBRARY>=YesPlease" to the make command line or
diff --git a/Makefile b/Makefile
index cbf0bc2344..56fc2d6f08 100644
--- a/Makefile
+++ b/Makefile
@@ -2316,11 +2316,14 @@ all:: $(LIB_PERL_GEN)
 ifndef NO_PERL_CPAN_FALLBACKS
 all:: $(LIB_CPAN_GEN)
 endif
+NO_PERL_CPAN_FALLBACKS_SQ = $(subst ','\'',$(NO_PERL_CPAN_FALLBACKS))
 endif
 
 perl/build/lib/%.pm: perl/%.pm
 	$(QUIET_GEN)mkdir -p $(dir $@) && \
-	sed -e 's|@@LOCALEDIR@@|$(localedir_SQ)|g' < $< > $@
+	sed -e 's|@@LOCALEDIR@@|$(localedir_SQ)|g' \
+	    -e 's|@@NO_PERL_CPAN_FALLBACKS@@|$(NO_PERL_CPAN_FALLBACKS_SQ)|g' \
+	< $< > $@
 
 perl/build/man/man3/Git.3pm: perl/Git.pm
 	$(QUIET_GEN)mkdir -p $(dir $@) && \
diff --git a/perl/Git/LoadCPAN.pm b/perl/Git/LoadCPAN.pm
index 229c1ee87d..e5585e75e8 100644
--- a/perl/Git/LoadCPAN.pm
+++ b/perl/Git/LoadCPAN.pm
@@ -19,13 +19,25 @@ attempt to load C<Module::Name> from the OS, and if that doesn't work
 will fall back on C<FromCPAN::Module::Name> shipped with Git itself.
 
 Usually distributors will not ship with Git's Git::FromCPAN tree at
-all, preferring to use their own packaging of CPAN modules instead.
+all via the C<NO_PERL_CPAN_FALLBACKS> option, preferring to use their
+own packaging of CPAN modules instead.
 
 This module is only intended to be used for code shipping in the
 C<git.git> repository. Use it for anything else at your peril!
 
 =cut
 
+# NO_PERL_CPAN_FALLBACKS_STR evades the sed search-replace from the
+# Makefile, and allows for detecting whether the module is loaded from
+# perl/Git as opposed to perl/build/Git, which is useful for one-off
+# testing without having Error.pm et al installed.
+use constant NO_PERL_CPAN_FALLBACKS_STR => '@@' . 'NO_PERL_CPAN_FALLBACKS' . '@@';
+use constant NO_PERL_CPAN_FALLBACKS => (
+	q[@@NO_PERL_CPAN_FALLBACKS@@] ne ''
+	and
+	q[@@NO_PERL_CPAN_FALLBACKS@@] ne NO_PERL_CPAN_FALLBACKS_STR
+);
+
 sub import {
 	shift;
 	my $caller = caller;
@@ -45,6 +57,25 @@ sub import {
 	} or do {
 		my $error = $@ || "Zombie Error";
 
+		if (NO_PERL_CPAN_FALLBACKS) {
+			chomp(my $error = sprintf <<'THEY_PROMISED', $module);
+BUG: The '%s' module is not here, but NO_PERL_CPAN_FALLBACKS was set!
+
+Git needs this Perl module from the CPAN, and will by default ship
+with a copy of it. This Git was built with NO_PERL_CPAN_FALLBACKS,
+meaning that whoever built it promised to provide this module.
+
+You're seeing this error because they broke that promise, and we can't
+load our fallback version, since we were asked not to install it.
+
+If you're seeing this error and didn't package Git yourself the
+package you're using is broken, or your system is broken. This error
+won't appear if Git is built without NO_PERL_CPAN_FALLBACKS (instead
+we'll use our fallback version of the module).
+THEY_PROMISED
+			die $error;
+		}
+
 		my $Git_LoadCPAN_pm_path = $INC{"Git/LoadCPAN.pm"} || die "BUG: Should have our own path from %INC!";
 
 		require File::Basename;
-- 
2.15.1.424.g9478a66081

