Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3598C1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 22:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031821AbeBNWWY (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 17:22:24 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43478 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031771AbeBNWWS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 17:22:18 -0500
Received: by mail-wr0-f194.google.com with SMTP id b52so1473021wrd.10
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 14:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I2HJYySh49rid5N0NmufAMX5CQW9xOauIAghmPk6sO0=;
        b=qH4HOgzYxFrG/vEakalfg8VdEgmdK78jJARg49PfHcQLkdCNJQnTeoL21lji1653Xe
         3CE+rc/L+Gn9IvzqbgmC3UZWDoybYUKv9t9yL1kJdwcoL6F1fIVjhUxhI2dF4PY3Rp3e
         mfwgUzOdv9zUv5qf4JnOcVcHBhtIglUimYyuhALUIVGP6QLJT62eA6QNyH5Q/sGHsvGW
         MdxVf5f7wtc2IL3ApJ27QGx0EeIOhmzIH6B61aKYRgc/nIW9lf3dkhW2A7KIBkHLSw7G
         Djo/oTPgT+D/+qbR78jYM77ixX1IuElpzov9yiQuhocJx0OFNj9IgB6UYoqSIA0HOn2G
         +ALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I2HJYySh49rid5N0NmufAMX5CQW9xOauIAghmPk6sO0=;
        b=Ny3lRVQaw8T8rPXBcJhvOrYhvZVsY6Clx0aDyAlIGrJ/1xqm3c0Ysm9QjuFo3H4dtr
         5l78QoC4doWE4c/t8rifl5eqEUilUsjqMTb7OZdP+RNwQdL6Ku2IHxTSw2P7LK6X4PAr
         9282JdKpy1IccNgA5ijNJrM4N6Fmf06rj9Ya0c1qGKz9iCXhmUG9/+iwpU10FxgQMymU
         bSEHOXVriFDBVGmghB/NStUfQ/BQowYbqa2VMGqiTW8RXiqQs59kfLV03WQMjRZcarVf
         p55Q8IqPOIcWp+bQFMJr8aMY51ngNXzLHxP6YEWGZy71/fiBsIEGMHx2yUzaT8Zc/dBl
         wKBA==
X-Gm-Message-State: APf1xPDmEEOQgu6MwhJuvjsM7I7h/9vEJeFRRgdXhP4zXqHzNeNVxoOp
        hyxOWkSIdbuDvjDfUzch9C2prpiG
X-Google-Smtp-Source: AH8x2267IjX8OHfa1Gsoy7nBMX6xy0qvUIVTy7CgyC7mTp9LLts2z+eYOXFyoTYRm86wjhlmwuQkBw==
X-Received: by 10.223.139.197 with SMTP id w5mr577142wra.186.1518646936767;
        Wed, 14 Feb 2018 14:22:16 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a14sm13191356wrf.22.2018.02.14.14.22.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Feb 2018 14:22:15 -0800 (PST)
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
Subject: [PATCH 7/8] gitweb: hard-depend on the Digest::MD5 5.8 module
Date:   Wed, 14 Feb 2018 22:21:45 +0000
Message-Id: <20180214222146.10655-8-avarab@gmail.com>
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

Since my d48b284183 ("perl: bump the required Perl version to 5.8 from
5.6.[21]", 2010-09-24), we've depended on 5.8, so there's no reason to
conditionally require Digest::MD5 anymore. It was released with perl
v5.7.3.

The initial introduction of the dependency in
e9fdd74e53 ("gitweb: (gr)avatar support", 2009-06-30) says as much,
this also undoes part of the later 2e9c8789b7 ("gitweb: Mention
optional Perl modules in INSTALL", 2011-02-04) since gitweb will
always be run on at least 5.8, so there's no need to mention
Digest::MD5 as a required module in the documentation, let's instead
say that we require perl 5.8.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 gitweb/INSTALL     |  3 +--
 gitweb/gitweb.perl | 17 +++++------------
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 408f2859d3..a58e6b3c44 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -29,12 +29,11 @@ Requirements
 ------------
 
  - Core git tools
- - Perl
+ - Perl 5.8
  - Perl modules: CGI, Encode, Fcntl, File::Find, File::Basename.
  - web server
 
 The following optional Perl modules are required for extra features
- - Digest::MD5 - for gravatar support
  - CGI::Fast and FCGI - for running gitweb as FastCGI script
  - HTML::TagCloud - for fancy tag cloud in project list view
  - HTTP::Date or Time::ParseDate - to support If-Modified-Since for feeds
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2417057f2b..8f48e3c02e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -490,7 +490,6 @@ our %feature = (
 	# Currently available providers are gravatar and picon.
 	# If an unknown provider is specified, the feature is disabled.
 
-	# Gravatar depends on Digest::MD5.
 	# Picon currently relies on the indiana.edu database.
 
 	# To enable system wide have in $GITWEB_CONFIG
@@ -1166,18 +1165,11 @@ sub configure_gitweb_features {
 	our @snapshot_fmts = gitweb_get_feature('snapshot');
 	@snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
 
-	# check that the avatar feature is set to a known provider name,
-	# and for each provider check if the dependencies are satisfied.
-	# if the provider name is invalid or the dependencies are not met,
-	# reset $git_avatar to the empty string.
+	# check that the avatar feature is set to a known provider
+	# name, if the provider name is invalid, reset $git_avatar to
+	# the empty string.
 	our ($git_avatar) = gitweb_get_feature('avatar');
-	if ($git_avatar eq 'gravatar') {
-		$git_avatar = '' unless (eval { require Digest::MD5; 1; });
-	} elsif ($git_avatar eq 'picon') {
-		# no dependencies
-	} else {
-		$git_avatar = '';
-	}
+	$git_avatar = '' unless $git_avatar =~ /^(?:gravatar|picon)$/s;
 
 	our @extra_branch_refs = gitweb_get_feature('extra-branch-refs');
 	@extra_branch_refs = filter_and_validate_refs (@extra_branch_refs);
@@ -2165,6 +2157,7 @@ sub picon_url {
 sub gravatar_url {
 	my $email = lc shift;
 	my $size = shift;
+	require Digest::MD5;
 	$avatar_cache{$email} ||=
 		"//www.gravatar.com/avatar/" .
 			Digest::MD5::md5_hex($email) . "?s=";
-- 
2.15.1.424.g9478a66081

