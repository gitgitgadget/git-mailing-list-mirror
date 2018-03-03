Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 207971F404
	for <e@80x24.org>; Sat,  3 Mar 2018 15:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752219AbeCCPjr (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 10:39:47 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:35622 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752208AbeCCPjT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 10:39:19 -0500
Received: by mail-wr0-f174.google.com with SMTP id l43so12995003wrc.2
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 07:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=DqzVa5/RB1TEjvK9qazSfT71mV2JflaAd0egRPDNf/w=;
        b=kIrWYGDcvbB1Y9gZT0GYWcpauzZvbXBrqCBwPGdq77bbZjKz5MP0GIYjRVSv3y9DKc
         m6ldj/sKiXCjBNmlIoUPOaajgZfU9kzhxozpoFXGl2xl15VwpXZ/K5FldAKrb/MtsPyv
         c7Dhn/1SxChJIaptdHmLNXsCPl+a918RBh05OCkcWIIljnxtomjENRmKTIdRMtDz6Vab
         jA27q8qB/fXxk6R2v83SWwBpKhzaZhmUwc+EqT7Ju1rgcvlF5lTAYh0j8/GUTqgRw9Lx
         qulO5/gMDL5hKzcTv3nD33bv0ucop3ZhUqNPz/bVb202k+858zRLotodYSXGw/Sy7v4A
         /HvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DqzVa5/RB1TEjvK9qazSfT71mV2JflaAd0egRPDNf/w=;
        b=k7jpNBUj9tdfuHUCWCzxGsnNSSkElTl0kow/12yNwTkOzU5BqaP3SuGgPCJaxBkh9r
         5REHzqNVi0eHdktywPYQ17Rv87tA6VbT3qkKMc1cpQn9sSI3G+4heJgRUxdyJsjXv7xC
         RoM6re0uU1WkA6p9qHGKgZ+jtL8mx9KJptSWg4Lm6Q6ydH4+/9hCgGDtVEZ5L73E2Stn
         bQPkrtBapBFXU//Xeprl2tCFG+7FRzPwBBVpi52FwIO9XPEeyExg/IHZJ2YDtqCBkh+w
         X/hY4lPaFUenPvttJDfc9h/SAblN0vJTsaiAaVydJVpDKSjhI9GySc5YQuPSNMjg6eCS
         yiUg==
X-Gm-Message-State: APf1xPBxqQO6yU+x4a2DDmI8e//m5QKBvesTN3IRChsIqjHL9Sgtirj5
        NYZiFTkt7T9ZhOdxf1gFbLM0Qgiz
X-Google-Smtp-Source: AG47ELv+Q4aVwaGPUU6ZGyI3oU2aDdyNKk9wVzWad06//4Y2zcQkFZUcHShbPExqmPlqMcfjnbcgog==
X-Received: by 10.223.187.147 with SMTP id q19mr7471742wrg.150.1520091557662;
        Sat, 03 Mar 2018 07:39:17 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y1sm6899379wrh.80.2018.03.03.07.39.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 07:39:16 -0800 (PST)
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
Subject: [PATCH v3 09/13] perl: move CPAN loader wrappers to another namespace
Date:   Sat,  3 Mar 2018 15:38:13 +0000
Message-Id: <20180303153817.20270-10-avarab@gmail.com>
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

Move the Git::Error and Git::Mail::Address wrappers to the
Git::LoadCPAN::Loader::* namespace, e.g. Git::LoadCPAN::Error. That
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
index d5a4826a1c..1ec22c5ef3 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -26,13 +26,13 @@ use Text::ParseWords;
 use Term::ANSIColor;
 use File::Temp qw/ tempdir tempfile /;
 use File::Spec::Functions qw(catdir catfile);
-use Git::Error qw(:try);
+use Git::LoadCPAN::Error qw(:try);
 use Cwd qw(abs_path cwd);
 use Git;
 use Git::I18N;
-use Git::Mail::Address;
 use Net::Domain ();
 use Net::SMTP ();
+use Git::LoadCPAN::Mail::Address;
 
 Getopt::Long::Configure qw/ pass_through /;
 
diff --git a/perl/Git.pm b/perl/Git.pm
index 151b0e7144..9f246c7988 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -104,7 +104,7 @@ increase notwithstanding).
 
 
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

