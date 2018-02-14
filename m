Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75E0A1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 22:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031776AbeBNWWN (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 17:22:13 -0500
Received: from mail-wr0-f182.google.com ([209.85.128.182]:44536 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031527AbeBNWWI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 17:22:08 -0500
Received: by mail-wr0-f182.google.com with SMTP id v65so1479303wrc.11
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 14:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LkwBeGp36tSWSRPObO4/78ev3qfhC1/x/V6CxwU5VKg=;
        b=dWFIsN2QlDua6Gr7HD3pD2a6KhMhPBcf1mfcCTtM2fsV3hTLDlO126RXGsAa44ttTh
         ZXDMRKyqKomsnVMMyrzGJZR6kGS9uOu27HiiVTmSn15MSpM07n2jurRsHIV2cVN3DbS5
         Z8eaVsw/aiKncpjZcxsRfcUt1RsrY8lqy7GXRRzSBmAPSGSiwI27Hv7cmeMyIwRHLJKZ
         KJSRKI1fjghPvNJlRQWlrxsnB+skqjd9LH05ebuHEXWBtf2X9hWefwvCeJOVh846i4FS
         mDu4kqPsiTyICyK3vzaZUu97WaS9BCKNaCLQ967N75mxz2EgT1Ioh+i7hlj2RbSfrY6R
         EF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LkwBeGp36tSWSRPObO4/78ev3qfhC1/x/V6CxwU5VKg=;
        b=XGRG2L3Kef/MQUZfpoct4+f+zO7TEhz76hSqkESN4518mzKh4sfVpQMD0hMO6xj10K
         3EbNUsXDN3XzkoJNUiPeAAVZbaNCAo56gQOr139ifP4ACyxhpo0pm2Ime65jFXniBfHT
         jSVOpqbJ1amF/h7Xt9wtws7GlhfF1dBKabwKAtpdKMxWXHias+XTcCSmWJ/2C296lfXi
         diqFRyMzJ6v/+yVAwokj1fYOQPtxR0LVTZbV/Z+Mb9O8LOVpiO+pggjVEjZqSE7X301m
         A9Y0g/v1nYN9O3TzwWORMPhR1mnQBzFYSjOcv+DLHThUTcZ+WJ1wM9ZoFEnbGlvW/BDa
         /BFg==
X-Gm-Message-State: APf1xPDHDLmjsUJ7+ZKjlCED8fCcoBVT6Kxgl9mJAkrgdtwoOgstyhAH
        +t6SnJT5OaKFwacrAVFgDL05Fxpb
X-Google-Smtp-Source: AH8x226HpJPftBtb9DCMhFtzLwnpILRUin6b0eRV69optpW3lEaWGkcs4tfqoav6VY3tT0XTpp5C5g==
X-Received: by 10.223.162.144 with SMTP id s16mr575412wra.173.1518646926825;
        Wed, 14 Feb 2018 14:22:06 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a14sm13191356wrf.22.2018.02.14.14.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Feb 2018 14:22:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@slb.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Marcus Griep <marcus@griep.us>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/8] perl: move CPAN loader wrappers to another namespace
Date:   Wed, 14 Feb 2018 22:21:40 +0000
Message-Id: <20180214222146.10655-3-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180214222146.10655-1-avarab@gmail.com>
References: <20180214222146.10655-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the Git::Error and Git::Mail::Address wrappers to the
Git::LoadCPAN::Loader::* namespace, e.g. Git::LoadCPAN::Error, that
module will then either load Error from CPAN (if installed on the OS),
or use Git::FromCPAN::Error.

When I added the Error wrapper in 20d2a30f8f ("Makefile: replace
perl/Makefile.PL with simple make rules", 2017-12-10) I didn't think
about how confusing it would be to have these modules sitting in the
same tree as our normal modules. Let's put these all into
Git::{Load,From}CPAN::* to clearly distinguish them from the rest.

This also makes things a bit less confusing since there was already a
Git::Error namespace ever since 8b9150e3e3 ("Git.pm: Handle failed
commands' output", 2006-06-24).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/examples/git-difftool.perl      | 2 +-
 git-send-email.perl                     | 4 ++--
 perl/Git.pm                             | 2 +-
 perl/Git/{ => LoadCPAN}/Error.pm        | 8 ++++----
 perl/Git/{ => LoadCPAN}/Mail/Address.pm | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)
 rename perl/Git/{ => LoadCPAN}/Error.pm (78%)
 rename perl/Git/{ => LoadCPAN}/Mail/Address.pm (69%)

diff --git a/contrib/examples/git-difftool.perl b/contrib/examples/git-difftool.perl
index fb0fd0b84b..b2ea80f9ed 100755
--- a/contrib/examples/git-difftool.perl
+++ b/contrib/examples/git-difftool.perl
@@ -13,7 +13,7 @@
 use 5.008;
 use strict;
 use warnings;
-use Git::Error qw(:try);
+use Git::LoadCPAN::Error qw(:try);
 use File::Basename qw(dirname);
 use File::Copy;
 use File::Find;
diff --git a/git-send-email.perl b/git-send-email.perl
index bbf4deaa0d..85bb6482f2 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -26,11 +26,11 @@ use Text::ParseWords;
 use Term::ANSIColor;
 use File::Temp qw/ tempdir tempfile /;
 use File::Spec::Functions qw(catdir catfile);
-use Git::Error qw(:try);
+use Git::LoadCPAN::Error qw(:try);
 use Cwd qw(abs_path cwd);
 use Git;
 use Git::I18N;
-use Git::Mail::Address;
+use Git::LoadCPAN::Mail::Address;
 
 Getopt::Long::Configure qw/ pass_through /;
 
diff --git a/perl/Git.pm b/perl/Git.pm
index 9d60d7948b..8e02ee2cca 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -101,7 +101,7 @@ increase notwithstanding).
 
 
 use Carp qw(carp croak); # but croak is bad - throw instead
-use Git::Error qw(:try);
+use Git::LoadCPAN::Error qw(:try);
 use Cwd qw(abs_path cwd);
 use IPC::Open2 qw(open2);
 use Fcntl qw(SEEK_SET SEEK_CUR);
diff --git a/perl/Git/Error.pm b/perl/Git/LoadCPAN/Error.pm
similarity index 78%
rename from perl/Git/Error.pm
rename to perl/Git/LoadCPAN/Error.pm
index 09bbc97390..3513fe745b 100644
--- a/perl/Git/Error.pm
+++ b/perl/Git/LoadCPAN/Error.pm
@@ -1,11 +1,11 @@
-package Git::Error;
+package Git::LoadCPAN::Error;
 use 5.008;
 use strict;
 use warnings;
 
 =head1 NAME
 
-Git::Error - Wrapper for the L<Error> module, in case it's not installed
+Git::LoadCPAN::Error - Wrapper for the L<Error> module, in case it's not installed
 
 =head1 DESCRIPTION
 
@@ -26,13 +26,13 @@ sub import {
     } or do {
 	my $error = $@ || "Zombie Error";
 
-	my $Git_Error_pm_path = $INC{"Git/Error.pm"} || die "BUG: Should have our own path from %INC!";
+	my $Git_Error_pm_path = $INC{"Git/LoadCPAN/Error.pm"} || die "BUG: Should have our own path from %INC!";
 
 	require File::Basename;
 	my $Git_Error_pm_root = File::Basename::dirname($Git_Error_pm_path) || die "BUG: Can't figure out lib/Git dirname from '$Git_Error_pm_path'!";
 
 	require File::Spec;
-	my $Git_pm_FromCPAN_root = File::Spec->catdir($Git_Error_pm_root, 'FromCPAN');
+	my $Git_pm_FromCPAN_root = File::Spec->catdir($Git_Error_pm_root, '..', 'FromCPAN');
 	die "BUG: '$Git_pm_FromCPAN_root' should be a directory!" unless -d $Git_pm_FromCPAN_root;
 
 	local @INC = ($Git_pm_FromCPAN_root, @INC);
diff --git a/perl/Git/Mail/Address.pm b/perl/Git/LoadCPAN/Mail/Address.pm
similarity index 69%
rename from perl/Git/Mail/Address.pm
rename to perl/Git/LoadCPAN/Mail/Address.pm
index 2ce3e84670..879c2f5cd1 100644
--- a/perl/Git/Mail/Address.pm
+++ b/perl/Git/LoadCPAN/Mail/Address.pm
@@ -1,11 +1,11 @@
-package Git::Mail::Address;
+package Git::LoadCPAN::Mail::Address;
 use 5.008;
 use strict;
 use warnings;
 
 =head1 NAME
 
-Git::Mail::Address - Wrapper for the L<Mail::Address> module, in case it's not installed
+Git::LoadCPAN::Mail::Address - Wrapper for the L<Mail::Address> module, in case it's not installed
 
 =head1 DESCRIPTION
 
-- 
2.15.1.424.g9478a66081

