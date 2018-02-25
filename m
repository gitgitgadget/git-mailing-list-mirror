Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56D6D1F404
	for <e@80x24.org>; Sun, 25 Feb 2018 19:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751954AbeBYTr3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 14:47:29 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:40861 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751938AbeBYTrR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 14:47:17 -0500
Received: by mail-wm0-f51.google.com with SMTP id t6so5070987wmt.5
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 11:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=qEYY7TEgnFbnHeCcPP22Q1WGuxPGMHLoR1g5AU6LzLw=;
        b=fegFFwGkniPbl94D4LyPAe9PxObnRSgO16VQqBRoNvU403xgVp8O6ERNEwaemZE0MB
         ARccazlKK+cQHO5EYLUDMoPGf6r+A9yZdIoebQd8de5419QD4KnMxLWouP7teY7kahEG
         jMdeGM8x8xzD4UEfJAmVoefkpUsUV7igniCMGr+z4ewfKjmy4ZivvXECeeK09EIlR28j
         +3LSl49zVHIqTkSHSz4ybZ/OZv/1EVHABQl9JKkRBegu78a//x8Laapwiu2ATMzV3S6/
         5qEmSmFqBRJJqtBa0S6HStzSJ57d3IpvQAvEheqGOmTEKcaZR28qHQjzelJxBffpKt1e
         hD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qEYY7TEgnFbnHeCcPP22Q1WGuxPGMHLoR1g5AU6LzLw=;
        b=GtXhWgzuAsyPAo9eXz2MbQTPCV9IGa4wKpeRjco26h/QsmBsE5Msy8H1VW4XvA1DV8
         IcHGmYGBCmfmeG34EyqeWMb9ER6TQcz/A/O14Vx7VtGf2n2jgLi2SjEB6w8EkWoUpkAT
         P4KMs3pcJ6jjqsXPaLouQtL5L0SKCBkdiGhWdiw6dV03AfTVQL7LlwU3tIF4uB57gLAW
         KdPhEThEwN0krbmSdeydi7C7ViAvAn7lY17D51IqFf5dECgYHAvkoMIgoz6N7nF883/B
         SSoFX1vFzkzs/ce0eRq3+gzo13TxfzudiUvzrb5rP9mEdzY+DD2hQ3R/ZfNfR+lrk4Uo
         Gqcw==
X-Gm-Message-State: APf1xPDOekkYr2qU0VudF10vPKMFmmtup94K/A3/R41AtAZqcG2XysGl
        Hn8Q4R8ERYMuL8y4RpVXO7Oe2nsd
X-Google-Smtp-Source: AG47ELvnGuSXHXYqoWzcQyLVT3GDz2x/0OuF0VZwqasLvjC4yVNZlPtvzCpKzQnDN9TVmVVEYo3AGA==
X-Received: by 10.28.18.2 with SMTP id 2mr1645953wms.108.1519588035177;
        Sun, 25 Feb 2018 11:47:15 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b66sm4394003wmg.28.2018.02.25.11.47.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Feb 2018 11:47:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@slb.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Todd Zullinger <tmz@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/13] perl: generalize the Git::LoadCPAN facility
Date:   Sun, 25 Feb 2018 19:46:34 +0000
Message-Id: <20180225194637.18630-11-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180225194637.18630-1-avarab@gmail.com>
References: <20180225194637.18630-1-avarab@gmail.com>
In-Reply-To: <20180214222146.10655-1-avarab@gmail.com>
References: <20180214222146.10655-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the two wrappers that load from CPAN (local OS) or our own copy
to do so via the same codepath.

I added the Error.pm wrapper in 20d2a30f8f ("Makefile: replace
perl/Makefile.PL with simple make rules", 2017-12-10), and shortly
afterwards Matthieu Moy added a wrapper for Mail::Address in
bd869f67b9 ("send-email: add and use a local copy of Mail::Address",
2018-01-05).

His loader was simpler since Mail::Address doesn't have an "import"
method, but didn't do the same sanity checking; For example, a missing
FromCPAN directory (which OS packages are likely not to have) wouldn't
be explicitly warned about as a "BUG: ...".

Update both to use a common implementation based on the previous
Error.pm loader. Which has been amended to take the module to load as
parameter, as well as whether or not that module has an import
method.

This loader should be generic enough to handle almost all CPAN modules
out there, some use some crazy loading magic and wouldn't like being
wrapped like this, but that would be immediately obvious, and we'd
find out right away since the module wouldn't work at all.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 perl/Git/LoadCPAN.pm              | 74 +++++++++++++++++++++++++++++++++++++++
 perl/Git/LoadCPAN/Error.pm        | 44 +++--------------------
 perl/Git/LoadCPAN/Mail/Address.pm | 22 +++---------
 3 files changed, 82 insertions(+), 58 deletions(-)
 create mode 100644 perl/Git/LoadCPAN.pm

diff --git a/perl/Git/LoadCPAN.pm b/perl/Git/LoadCPAN.pm
new file mode 100644
index 0000000000..1568c177fe
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
+Usually distributors will not ship with Git's Git::FromCPAN tree at
+all, preferring to use their own packaging of CPAN modules instead.
+
+This module is only intended to be used for code shipping in the
+C<git.git> repository. Use it for anything else at your peril!
+
+=cut
+
+sub import {
+	shift;
+	my $caller = caller;
+	my %args = @_;
+	my $module = exists $args{module} ? delete $args{module} : die "BUG: Expected 'module' parameter!";
+	my $import = exists $args{import} ? delete $args{import} : die "BUG: Expected 'import' parameter!";
+	die "BUG: Too many arguments!" if keys %args;
+
+	# Foo::Bar to Foo/Bar.pm
+	my $package_pm = $module;
+	$package_pm =~ s[::][/]g;
+	$package_pm .= '.pm';
+
+	eval {
+		require $package_pm;
+		1;
+	} or do {
+		my $error = $@ || "Zombie Error";
+
+		my $Git_LoadCPAN_pm_path = $INC{"Git/LoadCPAN.pm"} || die "BUG: Should have our own path from %INC!";
+
+		require File::Basename;
+		my $Git_LoadCPAN_pm_root = File::Basename::dirname($Git_LoadCPAN_pm_path) || die "BUG: Can't figure out lib/Git dirname from '$Git_LoadCPAN_pm_path'!";
+
+		require File::Spec;
+		my $Git_pm_FromCPAN_root = File::Spec->catdir($Git_LoadCPAN_pm_root, 'FromCPAN');
+		die "BUG: '$Git_pm_FromCPAN_root' should be a directory!" unless -d $Git_pm_FromCPAN_root;
+
+		local @INC = ($Git_pm_FromCPAN_root, @INC);
+		require $package_pm;
+	};
+
+	if ($import) {
+		no strict 'refs';
+		*{"${caller}::import"} = sub {
+			shift;
+			use strict 'refs';
+			unshift @_, $module;
+			goto &{"${module}::import"};
+		};
+		use strict 'refs';
+	}
+}
+
+1;
diff --git a/perl/Git/LoadCPAN/Error.pm b/perl/Git/LoadCPAN/Error.pm
index 3513fe745b..c6d2c45d80 100644
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
+	module => 'Error',
+	import => 1,
+);
 
 1;
diff --git a/perl/Git/LoadCPAN/Mail/Address.pm b/perl/Git/LoadCPAN/Mail/Address.pm
index 879c2f5cd1..f70a4f064c 100644
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
+	module => 'Mail::Address',
+	import => 0,
+);
 
 1;
-- 
2.15.1.424.g9478a66081

