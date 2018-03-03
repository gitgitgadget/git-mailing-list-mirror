Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B8101F404
	for <e@80x24.org>; Sat,  3 Mar 2018 15:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeCCPjH (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 10:39:07 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33186 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752164AbeCCPjF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 10:39:05 -0500
Received: by mail-wm0-f65.google.com with SMTP id s206so6990428wme.0
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 07:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=DNx2I8VkoHLk4LWzK1P04B3P1TzquMaPIXfXm9s6dGI=;
        b=QNaJ5qgPNd/73aF+aXwmP8Srmv7E3fYmc7iHe/pgIU8wp16stbUlu4nmuChLX+WwFD
         GnAVXeQEaRAF2vGDN2UJKDxa7W8oAUodiPpE3Yn430WCwkuAmwwgHCXvGZbdu5889r5V
         RfXr3/M5BJOCIXhewfq8/Q4Cu3APcL4vxxMHNas3uoCw1VIzpKpap87fdM1vLiNJwt/+
         j7V6cl4Ys4I2oU6y3/jQ3TJPLlvyIt0yzhYpbmPOXbXOqXUkMJprgR3e1AkYBqIPN8xs
         C2uD8m4SyFrRlwJgjKFpz9NL1G7Sd5v3dPKn0fHZY8t4mK9fBfsZ29YpFUVe2A1sX5JM
         Gn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DNx2I8VkoHLk4LWzK1P04B3P1TzquMaPIXfXm9s6dGI=;
        b=HrqBDADMK7nL8G3wkMe+VTe+BiKU2BMGz2MePvY3gpL7Jv2Mv1sBnj1C0PjxU3iulm
         Tg7PQkC7bYgfimCFKyNif8I0AR2NF4OPk1+0tIVzIwS26TfV9fLKttUM4FIgWgw9tSZU
         ycCGsACU6FRih+XJKjKfRnUypUdV5Hg4YOP2HRSciLVEZeEjdPEN3Xinnikp7fSUDq2k
         eN4bW370Utho2kJxFwZIIOxg6spMp3SJXMQ5y+qKvqyLjGuR2oeixthvwQ6dTXUPaXig
         LgyXfxsrg3hxM+rImjg4EOwaTlN0f9Gx3ZQn72JXRCWhzt3VRvAwNwFsnqvYiPkJ1CcM
         SsCA==
X-Gm-Message-State: AElRT7FxQgmEd/aPonN5LaYkGRw8dQbnum8p4TH2oAeOpUcbYiRvPNPy
        ZzX7RY6cxa1YRZyM1Vny7fmgsv91
X-Google-Smtp-Source: AG47ELufoqzB+UlXTgvqlMMRgkFV2f0oARJ9Rhxxrqe91usijV6+qFK1F9pc3E9yaPusuJ40BKJ3XQ==
X-Received: by 10.28.92.17 with SMTP id q17mr3845267wmb.97.1520091543396;
        Sat, 03 Mar 2018 07:39:03 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y1sm6899379wrh.80.2018.03.03.07.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 07:39:02 -0800 (PST)
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
Subject: [PATCH v3 04/13] gitweb: hard-depend on the Digest::MD5 5.8 module
Date:   Sat,  3 Mar 2018 15:38:08 +0000
Message-Id: <20180303153817.20270-5-avarab@gmail.com>
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

Since my d48b284183 ("perl: bump the required Perl version to 5.8 from
5.6.[21]", 2010-09-24), we've depended on 5.8, so there's no reason to
conditionally require Digest::MD5 anymore. It was released with perl
v5.7.3[1]

The initial introduction of the dependency in
e9fdd74e53 ("gitweb: (gr)avatar support", 2009-06-30) says as much,
this also undoes part of the later 2e9c8789b7 ("gitweb: Mention
optional Perl modules in INSTALL", 2011-02-04) since gitweb will
always be run on at least 5.8, so there's no need to mention
Digest::MD5 as a required module in the documentation, let's instead
say that we require perl 5.8.

1. $ corelist Digest::MD5
   Data for 2015-02-14
   Digest::MD5 was first released with perl v5.7.3

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 gitweb/INSTALL     |  3 +--
 gitweb/gitweb.perl | 17 ++++-------------
 2 files changed, 5 insertions(+), 15 deletions(-)

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
index 2417057f2b..2594a4badb 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -20,6 +20,8 @@ use Fcntl ':mode';
 use File::Find qw();
 use File::Basename qw(basename);
 use Time::HiRes qw(gettimeofday tv_interval);
+use Digest::MD5 qw(md5_hex);
+
 binmode STDOUT, ':utf8';
 
 if (!defined($CGI::VERSION) || $CGI::VERSION < 4.08) {
@@ -490,7 +492,6 @@ our %feature = (
 	# Currently available providers are gravatar and picon.
 	# If an unknown provider is specified, the feature is disabled.
 
-	# Gravatar depends on Digest::MD5.
 	# Picon currently relies on the indiana.edu database.
 
 	# To enable system wide have in $GITWEB_CONFIG
@@ -1166,18 +1167,8 @@ sub configure_gitweb_features {
 	our @snapshot_fmts = gitweb_get_feature('snapshot');
 	@snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
 
-	# check that the avatar feature is set to a known provider name,
-	# and for each provider check if the dependencies are satisfied.
-	# if the provider name is invalid or the dependencies are not met,
-	# reset $git_avatar to the empty string.
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
@@ -2167,7 +2158,7 @@ sub gravatar_url {
 	my $size = shift;
 	$avatar_cache{$email} ||=
 		"//www.gravatar.com/avatar/" .
-			Digest::MD5::md5_hex($email) . "?s=";
+			md5_hex($email) . "?s=";
 	return $avatar_cache{$email} . $size;
 }
 
-- 
2.15.1.424.g9478a66081

