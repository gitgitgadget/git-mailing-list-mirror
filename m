Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0824C1F404
	for <e@80x24.org>; Sun, 25 Feb 2018 19:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeBYTrE (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 14:47:04 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35881 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751895AbeBYTrB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 14:47:01 -0500
Received: by mail-wm0-f68.google.com with SMTP id 188so12867089wme.1
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 11:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ary++scGnP8C/TbaNGI6Lt9ZrohtuAoHPg8pEs9dOTs=;
        b=A9XuIXiu1qC5OLU8Q0bwakh6CdM0cA3nnh6CDbEnMOZXJYfUbUMG2IEeohbUHcJZ3S
         afZhEgM12y0tzTo7yyt+8Gocih2XFYgHIBOkF4TMJBxXhML7vbQdsRvyBlYqu4CmeF5Z
         rIi//Tnz904X4Wbs7ZmLTQ/LOjs8TAGVYh3P9icQXa3K9AeY8BsPmCl5s8+VSKfOr2OS
         BGHiumO01duVkfa2WDKGf0pcWYJYf7bVEJfsvcm25Lu7ncQuMp5Mr19X/p5DNb6QX7DN
         Ed+0L9pWpSeaRIHQ7ldT+/KqYWSQ78H70a+PWRjbH2b1OBuMwTUFaqV1LP3J02WkREEX
         F4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ary++scGnP8C/TbaNGI6Lt9ZrohtuAoHPg8pEs9dOTs=;
        b=EDW1dh/pQkd/aw7aHTl8rOCSbDX5CSaZdrTa5hAMie0gwJc9Fe9YVRn0ys9b9tps7O
         yor3o8p/JesxTr7ExICBr9iNm3l98gEdsJUddDsjGOih7LESI8maVq3CIhwmp3SweFZ2
         xMG+lmt6dtTJdVCMDDcQXYFUqXSUc/XEalEVLA6kPvZQ2Yljaha06rRAnBlGS42725Qa
         zVkJ7lJyBpzP3P0xbsVEryX+t7/zCXblF81d1F4ie6i+BK+kfipnxtcca/2g5QNKVqtG
         R1BvgY0nTeUXHW0WMVcbp8yxsgOadvcdDJJG/9EJPXgDgiPfAink3PtIOCbq7+SpRpsT
         h47g==
X-Gm-Message-State: APf1xPDDsWqS373nm4iKtKV7PTwoJGAo8VII3TU4grrJwmxONw1xQc89
        zpCjxGXqQn1v2N8CGJn9QrrHNBki
X-Google-Smtp-Source: AG47ELu8OU85y/FSleQGAj9Udk1OygzgLClKIWEnIYl6UOFVpqVVJ+5BHbHVakUZcjrw8om8fam+gg==
X-Received: by 10.28.91.3 with SMTP id p3mr1743500wmb.30.1519588019664;
        Sun, 25 Feb 2018 11:46:59 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b66sm4394003wmg.28.2018.02.25.11.46.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Feb 2018 11:46:58 -0800 (PST)
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
Subject: [PATCH v2 04/13] gitweb: hard-depend on the Digest::MD5 5.8 module
Date:   Sun, 25 Feb 2018 19:46:28 +0000
Message-Id: <20180225194637.18630-5-avarab@gmail.com>
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

As with the preceding Net::{SMTP,Domain} change we now unconditionally
"use" the module instead.

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

