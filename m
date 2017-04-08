Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 273F920970
	for <e@80x24.org>; Sat,  8 Apr 2017 13:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752524AbdDHN0A (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 09:26:00 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34279 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752463AbdDHNZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 09:25:58 -0400
Received: by mail-wr0-f194.google.com with SMTP id u18so15463295wrc.1
        for <git@vger.kernel.org>; Sat, 08 Apr 2017 06:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fFohHaqiJ5ZVn5jOEUW6HQeI9d11gokgGefW9KLTjlY=;
        b=OegQ0iv7nXC0Ln0GDtCfhQSgAkJfRnXLQksIxey4HyWNmPQIf4kZ3jNpimqoDNBZUz
         GnfuCFmCZrfN/M0GuWsgJ/S1SQROI6Sdp4xECZqBaDJjUdQfLXQBGzJ3P2YaqeJklzpo
         lpZ/M1tQsdXc3Jqq9qmXIT5dUdT3255qPWdItP2h+2Tt64V/kveiASrCu1AzJu/RMU2l
         iswkO1tdWv21gpfEs3Tg7hqGk8bx+MOvuLnD2iEgRH8dAnMk5MF9mxArs2t9o2zGFocY
         +Bdr0scq7VhqDoahgFxMhzVSloYqVvx3+E8wwhU08ZkUR2PQUkrgM08M4Byclo10p4Ae
         MATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fFohHaqiJ5ZVn5jOEUW6HQeI9d11gokgGefW9KLTjlY=;
        b=YwI9sVvnEyBTNXXZD2TvnLJQrlpCcAaQwQIiW0HkNsNf7VmLhp62pgX9HK/27bAqvs
         v6zyC7zZbqQChrNcursMqY3YxYRNIcJpi0DKZzOtny77w0k3X33kS2mzTWeDb8KwGU16
         xUULCspzmAvUdh6QWa4gxTILWssln8wtbwXTVCfTbwcHjVy5/gXRXZDyVTYvlSEj4thI
         k9QGR5TtOsXMiF7VAfl8me61/LK29H6HgDc2leIeQEpe4Qo5oaZ2vuXsW5rZagGw6xb3
         tfW2dI6h+iExDq6OzyhbRCNsql/hm4xhI49y2zh1W6FkmQV0sAOdt0Psxvze7hOcW/zo
         Ak8g==
X-Gm-Message-State: AFeK/H0WcEsZTN7VFrKtjFQSEz5pWhC0rGM5pt0bkSsz33UDeQRhTxEzDj8kghRspLuqvw==
X-Received: by 10.223.149.35 with SMTP id 32mr41426778wrs.107.1491657956424;
        Sat, 08 Apr 2017 06:25:56 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v14sm2744864wmv.24.2017.04.08.06.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Apr 2017 06:25:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/12] Makefile & configure: reword outdated comment about PCRE
Date:   Sat,  8 Apr 2017 13:24:57 +0000
Message-Id: <20170408132506.5415-4-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170408132506.5415-1-avarab@gmail.com>
References: <20170408132506.5415-1-avarab@gmail.com>
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

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile     |  6 ++++--
 configure.ac | 12 ++++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 9b36068ac5..23945d87cf 100644
--- a/Makefile
+++ b/Makefile
@@ -24,8 +24,10 @@ all::
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
 # This also implies BLK_SHA1.
 #
-# Define USE_LIBPCRE if you have and want to use libpcre. git-grep will be
-# able to use Perl-compatible regular expressions.
+# Define USE_LIBPCRE if you have and want to use libpcre. Various
+# commands such as like log, grep offer runtime options to use
+# Perl-compatible regular expressions instead of standard or extended
+# POSIX regular expressions.
 #
 # Define LIBPCREDIR=/foo/bar if your libpcre header and library files are in
 # /foo/bar/include and /foo/bar/lib directories.
diff --git a/configure.ac b/configure.ac
index 128165529f..d09a204a7e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -250,8 +250,10 @@ AS_HELP_STRING([--with-openssl],[use OpenSSL library (default is YES)])
 AS_HELP_STRING([],              [ARG can be prefix for openssl library and headers]),
 GIT_PARSE_WITH([openssl]))
 
-# Define USE_LIBPCRE if you have and want to use libpcre. git-grep will be
-# able to use Perl-compatible regular expressions.
+# Define USE_LIBPCRE if you have and want to use libpcre. Various
+# commands such as like log, grep offer runtime options to use
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
+# commands such as like log, grep offer runtime options to use
+# Perl-compatible regular expressions instead of standard or extended
+# POSIX regular expressions.
 #
 
 if test -n "$USE_LIBPCRE"; then
-- 
2.11.0

