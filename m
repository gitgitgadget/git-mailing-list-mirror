Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C64E51F404
	for <e@80x24.org>; Sat,  3 Mar 2018 15:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932139AbeCCPjY (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 10:39:24 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:44528 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932135AbeCCPjV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 10:39:21 -0500
Received: by mail-wr0-f175.google.com with SMTP id v65so12952077wrc.11
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 07:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=qEYY7TEgnFbnHeCcPP22Q1WGuxPGMHLoR1g5AU6LzLw=;
        b=rx+WQ3i0/CFlmsqY2l5kRoF28f3jt33lRHkfY234NGFtzaNhpP8F87RC9jk7WXmWj3
         J5Xd5D5p4Z+1Ps0R7DTuQ696xLmdm/BorEtigalCNAoh5f0C5OfFS9VPBmeIYVTgKX1N
         aUKXgHlCn4SeAt10PXu62wzKv2mMxAZrwCyhTxdaVIfj3qQPj97mTnItT/BOwhDObGTJ
         ErAsUIW4MEpLV/jHBLTxuskK8VXvJMSRDMXMKbrHQtKSK+n6W8SQckN15LjOKniDEoNB
         7djNV3uEcG44OPIMH+JGtApE0usuNWR94a1hHSFjMQJG4OEPf/EFsZRXZ11e1C+dqedm
         PEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qEYY7TEgnFbnHeCcPP22Q1WGuxPGMHLoR1g5AU6LzLw=;
        b=QBmMeFhiH8p+fR0hxBQPDJfNNjrEXFYpxkgBYQyy0t1wIISuviSt4ezJomtYkLS8R+
         x6om1ufTRQmpoXirjLdz26luG9IZ0+LM1oiI/xknVXaOYznbtDS0RTF2hEEu6wYGrWUO
         zEfCip/Bh8aJm9A6SKdofNGCAQWrAq4HLMgyN8E2HeyNLC1vnnB7iEz39jSmth/Uwqzc
         Nt8BDaYNxF9z4LlmNtGNJEI9xRFASDyVoyHbIstIWlJJ9Anlu4JgV12UPz4d99utKzkw
         SEaotrUUVtqYUfDUqtBGopTqYnF8VBnyE3WzCh8TiuR3wFvzbJBWQ1ij/h8iaInTL3F/
         Ul6Q==
X-Gm-Message-State: APf1xPC4V5Nd27kvp5i2InEdg0BaYpuDhXNIvvg29MCa0hZN5jzx8rA7
        u8yPq6S1yH4enDD1lLrkhK2lf79k
X-Google-Smtp-Source: AG47ELvOfsckiBJUUVOdH/58J3xZf/RVokxvCDMTLg92IVBdtfnb7ZaaoWnNC45942StqKkvuwaMYA==
X-Received: by 10.223.161.10 with SMTP id o10mr8423976wro.60.1520091560122;
        Sat, 03 Mar 2018 07:39:20 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y1sm6899379wrh.80.2018.03.03.07.39.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 07:39:19 -0800 (PST)
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
Subject: [PATCH v3 10/13] perl: generalize the Git::LoadCPAN facility
Date:   Sat,  3 Mar 2018 15:38:14 +0000
Message-Id: <20180303153817.20270-11-avarab@gmail.com>
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

