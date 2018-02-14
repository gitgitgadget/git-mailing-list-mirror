Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C29F1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 22:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031782AbeBNWWP (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 17:22:15 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38637 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031727AbeBNWWK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 17:22:10 -0500
Received: by mail-wr0-f193.google.com with SMTP id n7so1490645wrn.5
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 14:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dDGLq2w9n0TaUPGSJMrmqk0wy5mCTXSiw3IgfXUGXsE=;
        b=ivz5rROOALrxNzz0IedtYj2uvvXrs4sXzKcPYDBwV+9RhB9d+KyJmlRQDDDrAMLxIm
         ItGSOjFwRzC7abZ0boMPhIAlLE7yxcr8v/+AHk7QFGDlwLgWQGdvicxSyJrZzJcQSTqa
         kcuCZWrd+HmorSBEmU09svYiKvAlacEb4HRBbb6Q0HeI3hcJykbVJ+7+wSAGG7U09ExN
         jKUOv2VrqssMBJoOyaGs79yeY01MDCFFs+1luMpl3r8mYR6AyWFd/lQgRNfBcrtYrsdN
         ISF7IEn66mR/28VENPI9ile+cOnHP1Q4t10cqJQciYVvE6hTp5mwB3GbN8TuAiXejOA8
         Bbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dDGLq2w9n0TaUPGSJMrmqk0wy5mCTXSiw3IgfXUGXsE=;
        b=rTtCVwF4PjZ2UWpbciPIpN7jSd407/5paI+TSSCfanuD7gUdxG9gFRswtbUhYk60nD
         obZqrLgyQCg2YrvjIdluhdYHLExzBVbYFM66XPzisKB9WHv8iIJS6N1TV7QImYg2lhq3
         lol374TMdHX5tCuWCBAYoNNIVgfC7TZy8b1B8axpvAQLsBBfNvHwPWABDNS/U8S7xRMr
         mkLy97O8foGPMdASyKCtDhuivgheNrzCsnZgtBziu+ewM62m+okw7iJtSDtTKilux65u
         W01B9AssdL6ftmQDyr1VjF7sTrZkdwM/X44nL8OU9NBcXW7MhwU2540z0W6aH67k8rp/
         MoLA==
X-Gm-Message-State: APf1xPAj50qVls1k+zGRBW2qGGayA65iX6j0wD0qO7aFKnQq+kKUR2CW
        tCmfrQJL6CCPLQLmbco0/x5ZL+9h
X-Google-Smtp-Source: AH8x2278gXqBgvaXio0uKYe0wXbP4nq0c4X9WHi2rSnTMPnNTKZMfwEQ2k5GxOWkh5wKG3xQu557Eg==
X-Received: by 10.223.175.44 with SMTP id z41mr536627wrc.129.1518646928795;
        Wed, 14 Feb 2018 14:22:08 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a14sm13191356wrf.22.2018.02.14.14.22.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Feb 2018 14:22:07 -0800 (PST)
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
Subject: [PATCH 3/8] perl: generalize the Git::LoadCPAN facility
Date:   Wed, 14 Feb 2018 22:21:41 +0000
Message-Id: <20180214222146.10655-4-avarab@gmail.com>
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

Change the two wrappers to load from CPAN (local OS) or our own copy
to do so via the same codepath.

I added the Error.pm wrapper in 20d2a30f8f ("Makefile: replace
perl/Makefile.PL with simple make rules", 2017-12-10), and shortly
afterwards Matthieu Moy added a wrapper for Mail::Address in
bd869f67b9 ("send-email: add and use a local copy of Mail::Address",
2018-01-05).

His was simpler since Mail::Address doesn't have an "import" method,
but didn't do the same sanity checking, e.g. a missing FromCPAN
directory (which OS packages are likely not to have) wouldn't be
explicitly warned about.

Now both use a modification of the previously Error.pm-specific
codepath, which has been amended to take the module to load as
parameter, as well as whether or not that module has an import method.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 perl/Git/LoadCPAN.pm              | 74 +++++++++++++++++++++++++++++++++++++++
 perl/Git/LoadCPAN/Error.pm        | 44 +++--------------------
 perl/Git/LoadCPAN/Mail/Address.pm | 22 +++---------
 3 files changed, 82 insertions(+), 58 deletions(-)
 create mode 100644 perl/Git/LoadCPAN.pm

diff --git a/perl/Git/LoadCPAN.pm b/perl/Git/LoadCPAN.pm
new file mode 100644
index 0000000000..2262812654
--- /dev/null
+++ b/perl/Git/LoadCPAN.pm
@@ -0,0 +1,74 @@
+package Git::LoadCPAN;
+use 5.008;
+use strict;
+use warnings;
+
+=head1 NAME
+
+Git::LoadCPAN - Wrapper for loading modules from the CPAN (OS) or Git's own copy
+
+=head1 DESCRIPTION
+
+The Perl code in Git depends on some modules from the CPAN, but we
+don't want to make those a hard requirement for anyone building from
+source.
+
+Therefore the L<Git::LoadCPAN> namespace shipped with Git contains
+wrapper modules like C<Git::LoadCPAN::Module::Name> that will first
+attempt to load C<Module::Name> from the OS, and if that doesn't work
+will fall back on C<Git::FromCPAN::Module::Name> shipped with Git
+itself.
+
+Usually OS's will not ship with Git's Git::FromCPAN tree at all,
+preferring to use their own packaging of CPAN modules instead.
+
+This module is only intended to be used for code shipping in the
+C<git.git> repository. Use it for anything else at your peril!
+
+=cut
+
+sub import {
+    shift;
+    my $caller = caller;
+    my %args = @_;
+    my $module = exists $args{module} ? delete $args{module} : die "BUG: Expected 'module' parameter!";
+    my $import = exists $args{import} ? delete $args{import} : die "BUG: Expected 'import' parameter!";
+    die "BUG: Too many arguments!" if keys %args;
+
+    # Foo::Bar to Foo/Bar.pm
+    my $package_pm = $module;
+    $package_pm =~ s[::][/]g;
+    $package_pm .= '.pm';
+
+    eval {
+	require $package_pm;
+	1;
+    } or do {
+	my $error = $@ || "Zombie Error";
+
+	my $Git_LoadCPAN_pm_path = $INC{"Git/LoadCPAN.pm"} || die "BUG: Should have our own path from %INC!";
+
+	require File::Basename;
+	my $Git_LoadCPAN_pm_root = File::Basename::dirname($Git_LoadCPAN_pm_path) || die "BUG: Can't figure out lib/Git dirname from '$Git_LoadCPAN_pm_path'!";
+
+	require File::Spec;
+	my $Git_pm_FromCPAN_root = File::Spec->catdir($Git_LoadCPAN_pm_root, 'FromCPAN');
+	die "BUG: '$Git_pm_FromCPAN_root' should be a directory!" unless -d $Git_pm_FromCPAN_root;
+
+	local @INC = ($Git_pm_FromCPAN_root, @INC);
+	require $package_pm;
+    };
+
+    if ($import) {
+	no strict 'refs';
+	*{"${caller}::import"}= sub {
+	    shift;
+	    use strict 'refs';
+	    unshift @_, $module;
+	    goto &{"${module}::import"};
+	};
+	use strict 'refs';
+    }
+}
+
+1;
diff --git a/perl/Git/LoadCPAN/Error.pm b/perl/Git/LoadCPAN/Error.pm
index 3513fe745b..9ba53cccf2 100644
--- a/perl/Git/LoadCPAN/Error.pm
+++ b/perl/Git/LoadCPAN/Error.pm
@@ -2,45 +2,9 @@ package Git::LoadCPAN::Error;
 use 5.008;
 use strict;
 use warnings;
-
-=head1 NAME
-
-Git::LoadCPAN::Error - Wrapper for the L<Error> module, in case it's not installed
-
-=head1 DESCRIPTION
-
-Wraps the import function for the L<Error> module.
-
-This module is only intended to be used for code shipping in the
-C<git.git> repository. Use it for anything else at your peril!
-
-=cut
-
-sub import {
-    shift;
-    my $caller = caller;
-
-    eval {
-	require Error;
-	1;
-    } or do {
-	my $error = $@ || "Zombie Error";
-
-	my $Git_Error_pm_path = $INC{"Git/LoadCPAN/Error.pm"} || die "BUG: Should have our own path from %INC!";
-
-	require File::Basename;
-	my $Git_Error_pm_root = File::Basename::dirname($Git_Error_pm_path) || die "BUG: Can't figure out lib/Git dirname from '$Git_Error_pm_path'!";
-
-	require File::Spec;
-	my $Git_pm_FromCPAN_root = File::Spec->catdir($Git_Error_pm_root, '..', 'FromCPAN');
-	die "BUG: '$Git_pm_FromCPAN_root' should be a directory!" unless -d $Git_pm_FromCPAN_root;
-
-	local @INC = ($Git_pm_FromCPAN_root, @INC);
-	require Error;
-    };
-
-    unshift @_, $caller;
-    goto &Error::import;
-}
+use Git::LoadCPAN (
+    module => 'Error',
+    import => 1,
+);
 
 1;
diff --git a/perl/Git/LoadCPAN/Mail/Address.pm b/perl/Git/LoadCPAN/Mail/Address.pm
index 879c2f5cd1..a13f0e58cf 100644
--- a/perl/Git/LoadCPAN/Mail/Address.pm
+++ b/perl/Git/LoadCPAN/Mail/Address.pm
@@ -2,23 +2,9 @@ package Git::LoadCPAN::Mail::Address;
 use 5.008;
 use strict;
 use warnings;
-
-=head1 NAME
-
-Git::LoadCPAN::Mail::Address - Wrapper for the L<Mail::Address> module, in case it's not installed
-
-=head1 DESCRIPTION
-
-This module is only intended to be used for code shipping in the
-C<git.git> repository. Use it for anything else at your peril!
-
-=cut
-
-eval {
-    require Mail::Address;
-    1;
-} or do {
-    require Git::FromCPAN::Mail::Address;
-};
+use Git::LoadCPAN (
+    module => 'Mail::Address',
+    import => 0,
+);
 
 1;
-- 
2.15.1.424.g9478a66081

