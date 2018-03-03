Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ED861F404
	for <e@80x24.org>; Sat,  3 Mar 2018 15:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932142AbeCCPjZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 10:39:25 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36138 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932136AbeCCPjY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 10:39:24 -0500
Received: by mail-wm0-f66.google.com with SMTP id 188so8069229wme.1
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 07:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=aCSGSPtPoMZmHhweLcycdqdb5lcqlH3lxGeWXHBwNSs=;
        b=EaAzSBlbGntJHCRAJ4w/4QHyXjwfWCIvfaPDPxxl6d0Of2uxEu+GvNyNCG4x9x4hs8
         oObNq/H+BLZwVi0Y9Ehug2Eve7XLU24k/qTtWfxxaDIPJXO9nnjkc7iDW4rHzKcZM5Xt
         t43/vuPYor/+hyRtbAbQAybHxJKPNRi5R5kP6a+3gANH2R6HPdCVvdsdsX6ovnhGyI5F
         gFkjFfR67rfxNlU9BquYaJQ8ggCN7Loe6Z6upfzjaaicgA99+W+nvB5EVHf0JmYO6G+S
         mJxDp3+xd2Jvz0cEh1LHcQwxap6DM6LXAfuOqCat5ejYcNhxt/cvW1ck4YCv1TZi5xw9
         Kvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=aCSGSPtPoMZmHhweLcycdqdb5lcqlH3lxGeWXHBwNSs=;
        b=N4HulbMdd/bscITD2uXLdghSpzTzmf8niegYO0nHtTiPXWSaNcS/gz+NvXU0mKZUCX
         nzBXOHPn2CJD2YeipnUfgWFweQ0sB/ndZ9U1/y+lQtdHn6spu+3Zut0l8wHOZKZE1dDm
         2QgmE2e6LIFToSDvoJOdSGyS276XtpHVQy8rZ/i0jdiqbjBK3c/bP4BDrzo8JwIsloZE
         4Jwq76U0Vnmy2sJd5JoBE/b3nfI81ly31b729Z7Vr0A9Cpb4aXec32rrh6m/fhwWjTB3
         TfSbxGyxM6pV/ehFhPuHhnaTevfksrpg7ExBoQ3qQt9IcnY8GktnlNqBtF92wUfl8KP/
         Ic3g==
X-Gm-Message-State: AElRT7FTMBuLxkxWBB4eswse5+uFS4jDeRO64UwAAU8BFuq2H3Oq2wB4
        Jmb3VQNoZyJlq5UV97AKEH3V5gXL
X-Google-Smtp-Source: AG47ELtszmHU9xWoGIJXrGnmp+ykpHYG5XO4AmnHBp6Xs7Mxrhnlc6wLgO+siHZhNRpaKOTm3QIxhA==
X-Received: by 10.28.116.17 with SMTP id p17mr4406145wmc.137.1520091562429;
        Sat, 03 Mar 2018 07:39:22 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y1sm6899379wrh.80.2018.03.03.07.39.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 07:39:21 -0800 (PST)
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
Subject: [PATCH v3 11/13] perl: move the perl/Git/FromCPAN tree to perl/FromCPAN
Date:   Sat,  3 Mar 2018 15:38:15 +0000
Message-Id: <20180303153817.20270-12-avarab@gmail.com>
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

Move the CPAN modules that have lived under perl/Git/FromCPAN since my
20d2a30f8f ("Makefile: replace perl/Makefile.PL with simple make
rules", 2017-12-10) to perl/FromCPAN.

A subsequent change will teach the Makefile to only install these
copies of CPAN modules if a flag that distro packagers would like to
set isn't set. Due to how the wildcard globbing is being done it's
much easier to accomplish that if they're moved to their own
directory.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                                | 3 +++
 perl/{Git => }/FromCPAN/.gitattributes  | 0
 perl/{Git => }/FromCPAN/Error.pm        | 0
 perl/{Git => }/FromCPAN/Mail/Address.pm | 0
 perl/Git/LoadCPAN.pm                    | 5 ++---
 5 files changed, 5 insertions(+), 3 deletions(-)
 rename perl/{Git => }/FromCPAN/.gitattributes (100%)
 rename perl/{Git => }/FromCPAN/Error.pm (100%)
 rename perl/{Git => }/FromCPAN/Mail/Address.pm (100%)

diff --git a/Makefile b/Makefile
index 5ae9616e0a..026b9fb6d6 100644
--- a/Makefile
+++ b/Makefile
@@ -2302,9 +2302,12 @@ po/build/locale/%/LC_MESSAGES/git.mo: po/%.po
 
 LIB_PERL := $(wildcard perl/Git.pm perl/Git/*.pm perl/Git/*/*.pm perl/Git/*/*/*.pm)
 LIB_PERL_GEN := $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_PERL))
+LIB_CPAN := $(wildcard perl/FromCPAN/*.pm perl/FromCPAN/*/*.pm)
+LIB_CPAN_GEN := $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_CPAN))
 
 ifndef NO_PERL
 all:: $(LIB_PERL_GEN)
+all:: $(LIB_CPAN_GEN)
 endif
 
 perl/build/lib/%.pm: perl/%.pm
diff --git a/perl/Git/FromCPAN/.gitattributes b/perl/FromCPAN/.gitattributes
similarity index 100%
rename from perl/Git/FromCPAN/.gitattributes
rename to perl/FromCPAN/.gitattributes
diff --git a/perl/Git/FromCPAN/Error.pm b/perl/FromCPAN/Error.pm
similarity index 100%
rename from perl/Git/FromCPAN/Error.pm
rename to perl/FromCPAN/Error.pm
diff --git a/perl/Git/FromCPAN/Mail/Address.pm b/perl/FromCPAN/Mail/Address.pm
similarity index 100%
rename from perl/Git/FromCPAN/Mail/Address.pm
rename to perl/FromCPAN/Mail/Address.pm
diff --git a/perl/Git/LoadCPAN.pm b/perl/Git/LoadCPAN.pm
index 1568c177fe..229c1ee87d 100644
--- a/perl/Git/LoadCPAN.pm
+++ b/perl/Git/LoadCPAN.pm
@@ -16,8 +16,7 @@ source.
 Therefore the L<Git::LoadCPAN> namespace shipped with Git contains
 wrapper modules like C<Git::LoadCPAN::Module::Name> that will first
 attempt to load C<Module::Name> from the OS, and if that doesn't work
-will fall back on C<Git::FromCPAN::Module::Name> shipped with Git
-itself.
+will fall back on C<FromCPAN::Module::Name> shipped with Git itself.
 
 Usually distributors will not ship with Git's Git::FromCPAN tree at
 all, preferring to use their own packaging of CPAN modules instead.
@@ -52,7 +51,7 @@ sub import {
 		my $Git_LoadCPAN_pm_root = File::Basename::dirname($Git_LoadCPAN_pm_path) || die "BUG: Can't figure out lib/Git dirname from '$Git_LoadCPAN_pm_path'!";
 
 		require File::Spec;
-		my $Git_pm_FromCPAN_root = File::Spec->catdir($Git_LoadCPAN_pm_root, 'FromCPAN');
+		my $Git_pm_FromCPAN_root = File::Spec->catdir($Git_LoadCPAN_pm_root, '..', 'FromCPAN');
 		die "BUG: '$Git_pm_FromCPAN_root' should be a directory!" unless -d $Git_pm_FromCPAN_root;
 
 		local @INC = ($Git_pm_FromCPAN_root, @INC);
-- 
2.15.1.424.g9478a66081

