Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 109BE207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 21:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030888AbdDTVYg (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 17:24:36 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:36002 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S947792AbdDTVYf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 17:24:35 -0400
Received: by mail-wr0-f182.google.com with SMTP id c55so43640005wrc.3
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 14:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QBmTVGhb4s7H8FrRL8K0jpzJaVcUfxAC8OIaeFmjApc=;
        b=GVuKZKRhCrmvFZXCoy+P32lD6l1HKkvcZrYjka0VSdIHWm/UCOCnjzEzFXGPEy8fDM
         WSeo4ZGI3USRoyD54nPlk4FKjR1wOcEaVs6e9aeoWA33AWgKe9DX+yyH1RvESf8WeEZ+
         c6s4mRXKXDveBPRiOLRNkeH9lmGSn1gDrTe1B05fZWGJQ0+Zbue1LIXH1P3MAxm+frss
         3IHYjr8Dhsgc3lHUTSqZEpPA0EXcrzS6wYpyN4a41IZ5vQp0vOwNX0lEPakhS4anjK1G
         AYBtWqeoLh8prY0FGzCvOoxplHX9/++BGwzeP+gisYr0GiX7EGCTJxCFEEyyyZdgbEbV
         jEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QBmTVGhb4s7H8FrRL8K0jpzJaVcUfxAC8OIaeFmjApc=;
        b=HwbfwM8A9pIepI4BvXzIf168pvSvqcNO+2LtNEyiSEl8Oo+qTV7mcezDvyRAzuWy0y
         bOTA0VRFziHduoGtjjt8Aw9UVhoeXNqTsJzrKbnHEqcDlTfTWAkOBSkqSs9juNcxgpXN
         F2Mtd5w+jB0vOrilNpMCRN45hA7oj+FAiZQXziHFgFTNpF8A2qXCbFoizPHTR48eoHhx
         PEJhtw2ZWacHBaZSgLTv5CoAEQgfvHoRpmBPYrGoIZ8ge8IzzpzC7hp0glMUvt+O88QN
         7/2In8lDcNDbLAV7XAkROnkdqhwYMeu/j7dJRdy7H4NTguAZ5DvBgYOEJFBYeuvTTYvx
         qmUg==
X-Gm-Message-State: AN3rC/7xaS016pBLjX0RILUCPLfq5ipzx9EjQcqjOZIsHdhSbwcUlvgK
        nxbV13qdCnR7cQ==
X-Received: by 10.223.178.68 with SMTP id y4mr10365978wra.88.1492723468751;
        Thu, 20 Apr 2017 14:24:28 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k63sm442322wmf.9.2017.04.20.14.24.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 14:24:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        =?UTF-8?q?Zolt=C3=A1n=20Herczeg?= <hzmester@freemail.hu>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 05/18] Makefile & configure: reword outdated comment about PCRE
Date:   Thu, 20 Apr 2017 21:23:32 +0000
Message-Id: <20170420212345.7408-6-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170420212345.7408-1-avarab@gmail.com>
References: <20170420212345.7408-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reword an outdated comment which suggests that only git-grep can use
PCRE.

This comment was added back when PCRE support was initially added in
commit 63e7e9d8b6 ("git-grep: Learn PCRE", 2011-05-09), and was true
at the time.

It hasn't been telling the full truth since git-log learned to use
PCRE with --grep in commit 727b6fc3ed ("log --grep: accept
--basic-regexp and --perl-regexp", 2012-10-03), and more importantly
is likely to get more inaccurate over time as more use is made of PCRE
in other areas.

Reword it to be more future-proof, and to more clearly explain that
this enables user-initiated runtime behavior.

Copy/pasting this so much in configure.ac is lame, these Makefile-like
flags aren't even used by autoconf, just the corresponding
--with[out]-* options. But copy/pasting the comments that make sense
for the Makefile to configure.ac where they make less sence is the
pattern everything else follows in that file. I'm not going to war
against that as part of this change, just following the existing
pattern.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile     |  6 ++++--
 configure.ac | 12 ++++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index eb1a1a7cff..2e63b1cfcc 100644
--- a/Makefile
+++ b/Makefile
@@ -24,8 +24,10 @@ all::
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
 # This also implies BLK_SHA1.
 #
-# Define USE_LIBPCRE if you have and want to use libpcre. git-grep will be
-# able to use Perl-compatible regular expressions.
+# Define USE_LIBPCRE if you have and want to use libpcre. Various
+# commands such as log and grep offer runtime options to use
+# Perl-compatible regular expressions instead of standard or extended
+# POSIX regular expressions.
 #
 # Define LIBPCREDIR=/foo/bar if your libpcre header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.
diff --git a/configure.ac b/configure.ac
index 128165529f..deeb968daa 100644
--- a/configure.ac
+++ b/configure.ac
@@ -250,8 +250,10 @@ AS_HELP_STRING([--with-openssl],[use OpenSSL library (default is YES)])
 AS_HELP_STRING([],              [ARG can be prefix for openssl library and headers]),
 GIT_PARSE_WITH([openssl]))
 
-# Define USE_LIBPCRE if you have and want to use libpcre. git-grep will be
-# able to use Perl-compatible regular expressions.
+# Define USE_LIBPCRE if you have and want to use libpcre. Various
+# commands such as log and grep offer runtime options to use
+# Perl-compatible regular expressions instead of standard or extended
+# POSIX regular expressions.
 #
 # Define LIBPCREDIR=/foo/bar if your libpcre header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.
@@ -499,8 +501,10 @@ GIT_CONF_SUBST([NEEDS_SSL_WITH_CRYPTO])
 GIT_CONF_SUBST([NO_OPENSSL])
 
 #
-# Define USE_LIBPCRE if you have and want to use libpcre. git-grep will be
-# able to use Perl-compatible regular expressions.
+# Define USE_LIBPCRE if you have and want to use libpcre. Various
+# commands such as log and grep offer runtime options to use
+# Perl-compatible regular expressions instead of standard or extended
+# POSIX regular expressions.
 #
 
 if test -n "$USE_LIBPCRE"; then
-- 
2.11.0

