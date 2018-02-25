Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA7FE1F404
	for <e@80x24.org>; Sun, 25 Feb 2018 19:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbeBYTrU (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 14:47:20 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:40853 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751893AbeBYTrO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 14:47:14 -0500
Received: by mail-wm0-f46.google.com with SMTP id t6so5070862wmt.5
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 11:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=DqzVa5/RB1TEjvK9qazSfT71mV2JflaAd0egRPDNf/w=;
        b=Inx+zelyuPT3kbCcS5+lWBqyz9QDU1DLUK8myCx337x7mU5e6FwFdkPrrPHgHS38Fl
         mS27frHx888+VlwrQIsrd9sXKOcOyE1mdzkW+xtxzDQIbdUMk/z7ppSUic4/9ZizcIAg
         ZHio5LpivOAaFEvyxiK69dCEVff1EnMjL1SnsDjY0YpyPzNoBljyehjOheWCocL3PBuk
         RJzad4r117yRypfqahjqh3DnB8nAi9FdY7NkFsK6HKKpsxCNpjb3hBiOMxwO8lBTyWTH
         leWE6zIHhkyq7537EtIZGyewFUgxC8Pj2Ugx3sgilPjElALSJVydkOSzhBU57G+Gf0m3
         Fz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DqzVa5/RB1TEjvK9qazSfT71mV2JflaAd0egRPDNf/w=;
        b=MPg3XNCCnpn/mBFpF08yBr9iXME41Vep13Qyc2/aekYFPuRpNeg+pnuffvxFu/eFUE
         Vm2DFFfJer2L7BOGBnWUU5UX0ycIyXYRvQi4K8K55KP6bMcF72ZVIVeXmA8aI7yj6/VJ
         QaVpKxpBFUVX5JJpyUsJI+VyqMPmpAMUUmpE+1mrLNma6IE6++rjfUc5my7PFxyy25xQ
         SK8oVC+1ykJ2ZVvCHSSxz9GXwGg0ivH5wOJvRHyWccflTVSI8BI9rUzN/Bn7Qcm6kXT+
         BvFvi35/F/A56ZwfRV2HXplh98cNpVIvttZ83qVCMForWSZaFofrnj/SYleK2JpSd7th
         igHQ==
X-Gm-Message-State: APf1xPCB+kirON+II/lJGyPabkCQYRYlsdx9lT1iVKMliaFEq3xGBJzH
        iU+WXlYuFAvk7H4mZn/kW8SutB42
X-Google-Smtp-Source: AG47ELtG7THV4B936H+nIxs5EnaPGEmB5qAPo0wvAzmDNiuw0Eystp1l3JKVVLomFuk9xfU8AP7VvQ==
X-Received: by 10.28.55.72 with SMTP id e69mr2890232wma.86.1519588032749;
        Sun, 25 Feb 2018 11:47:12 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b66sm4394003wmg.28.2018.02.25.11.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Feb 2018 11:47:11 -0800 (PST)
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
Subject: [PATCH v2 09/13] perl: move CPAN loader wrappers to another namespace
Date:   Sun, 25 Feb 2018 19:46:33 +0000
Message-Id: <20180225194637.18630-10-avarab@gmail.com>
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

