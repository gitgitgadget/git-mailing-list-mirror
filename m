Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62AF61F404
	for <e@80x24.org>; Sat,  3 Mar 2018 15:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbeCCPjK (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 10:39:10 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40503 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752125AbeCCPjH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 10:39:07 -0500
Received: by mail-wr0-f194.google.com with SMTP id o76so12967597wrb.7
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 07:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=SFjbhLghepNk/okzcY6yQ+AAqxxXqjwiJemTpnh9hME=;
        b=bQXfwqHW/ZCMdl9tLAQOW31SvhQ1ZjcEMOaaxF1aSPfqCkRqVXsfEKLs8xZnN0D1fV
         M1Oey03p0Q8DUY3J983pjXuLPkZ27l45ZAZNmz8aC/AvnXj3f0qXN6SpcarA97Cs5kFt
         H95wrPOvFrwu1ryJatvRqaIjpscjVmkiQ17nEeu7Bru478Wx4d5d2Fxah29BHeB4uwj3
         k+lbRY4qCP/UtYcqz7VFIQ6WT8vpPJiiNbKfT6AN4b/p+wExANGQ4YUbxIMjHh3OlHP0
         6a+E0Dz3epl3bvumfr7spQ7w9sEYMV48kPPcX9bol2wWOL/uRkg5HGTSvjcjguShr4rO
         QH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SFjbhLghepNk/okzcY6yQ+AAqxxXqjwiJemTpnh9hME=;
        b=bwpBo4SUAAsWU7Xde54Dhk2g1u0uytztQ70C4VTbHElts+vda9lTT0TrQOsAflO+di
         lbZ3+lvJiH4kkWEOOp/A0IjwRnTIJrz7mu9voII2GjRAegOPCVnf5swAgqVJv77ZUAJK
         ilBXXm6sq0ZK7neTrPW+p1J8FtoYupdDNmbFB5uMQoI3j6+Y+SVg1Sl/YX/RvudWzSpX
         +s/noWvCl3GtVHShtPABm0+/F4nqzh7tBETGeXIn6EjsgWzg+W28lPWa3ke+4SXrfzjh
         XDgEyonueufFQIj0AFCFfIRLlCgo3XN5qhv3foOZVjwzoAYuzm7x+Qgl1DMbMa6wL++X
         ObGw==
X-Gm-Message-State: APf1xPAKZRsb976gilyI+hT9UR9DwWI4tYtg++tQYYql6TnHPWwdOvL7
        ZWlCvxpJ+YeIRLBcUtgG2WSXNyyE
X-Google-Smtp-Source: AG47ELvPbNwaKNAyRedVDdJnwuxd4v0xuZ4bn9L3SeRP33uqL0ixIhwcAYc6vkEjqx7DK1So4DZ1mw==
X-Received: by 10.223.149.70 with SMTP id 64mr7716954wrs.76.1520091546091;
        Sat, 03 Mar 2018 07:39:06 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y1sm6899379wrh.80.2018.03.03.07.39.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 07:39:04 -0800 (PST)
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
Subject: [PATCH v3 05/13] Git.pm: hard-depend on the File::{Temp,Spec} modules
Date:   Sat,  3 Mar 2018 15:38:09 +0000
Message-Id: <20180303153817.20270-6-avarab@gmail.com>
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
conditionally require File::Temp and File::Spec anymore. They were
first released with perl versions v5.6.1 and 5.00405, respectively.

This code was originally added in c14c8ceb13 ("Git.pm: Make File::Spec
and File::Temp requirement lazy", 2008-08-15), presumably to make
Git.pm work on 5.6.0.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 perl/Git.pm | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 7ec16e6dde..151b0e7144 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -11,6 +11,8 @@ use 5.008;
 use strict;
 use warnings;
 
+use File::Temp ();
+use File::Spec ();
 
 BEGIN {
 
@@ -190,7 +192,6 @@ sub repository {
 		};
 
 		if ($dir) {
-			_verify_require();
 			File::Spec->file_name_is_absolute($dir) or $dir = $opts{Directory} . '/' . $dir;
 			$opts{Repository} = abs_path($dir);
 
@@ -1289,8 +1290,6 @@ sub temp_release {
 sub _temp_cache {
 	my ($self, $name) = _maybe_self(@_);
 
-	_verify_require();
-
 	my $temp_fd = \$TEMP_FILEMAP{$name};
 	if (defined $$temp_fd and $$temp_fd->opened) {
 		if ($TEMP_FILES{$$temp_fd}{locked}) {
@@ -1324,11 +1323,6 @@ sub _temp_cache {
 	$$temp_fd;
 }
 
-sub _verify_require {
-	eval { require File::Temp; require File::Spec; };
-	$@ and throw Error::Simple($@);
-}
-
 =item temp_reset ( FILEHANDLE )
 
 Truncates and resets the position of the C<FILEHANDLE>.
-- 
2.15.1.424.g9478a66081

