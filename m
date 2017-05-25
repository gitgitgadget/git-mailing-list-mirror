Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0D3520284
	for <e@80x24.org>; Thu, 25 May 2017 19:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030354AbdEYTqB (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 15:46:01 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36118 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936850AbdEYTp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 15:45:57 -0400
Received: by mail-wm0-f65.google.com with SMTP id k15so54290263wmh.3
        for <git@vger.kernel.org>; Thu, 25 May 2017 12:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lf2/dNfz089P1nvhuylmjIiIPZDdlFmoMXdV21HYhG8=;
        b=K2tKZ7uAAnEQ19lOrOwMFndg5ndHudvlbShlzCvoOC/fCcwa4U9uQ8ZsuNTqgI4xPH
         0tvy+HXgso6nQMe8YOZAzCz96+9XkQpTJAPFs3plZmp9VZ2ytFcKZyciYijCrLBLcS3k
         tNVi8wjEM+WyslEO3z90DkpP5nt6+guOXgOCmUm9mOaoddhhYXo1w484fkRVkR82rnCZ
         u1VUBU1+aNAI8pC14DVR/jAAXOOoUIBqEoKcUIeQj+C4imju4ogUXjD2nymrP319s7g5
         earX+Iy2wudcKR2u0Q7i2v0u0Xw8/GfQolh1yDumpt0njq2/DKB0oQxAN45VmGM9k9wE
         MNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lf2/dNfz089P1nvhuylmjIiIPZDdlFmoMXdV21HYhG8=;
        b=Wyx+VxRTMoeKyvquTxwi6JrdbEw+o7mEDkdRr4OqM2q8dAn4dttnH8kFynCM+X4oXQ
         48MexMa+HVp3PKf1YdylRzi8vuU+l08/F5W/AXAUjHd/auL+wpclnRcEWA0zBolaJ3pC
         o1my9elQ995XIVJuFJKJPs//8qKI4Ou6F6t/8Jw53t8QDx3sujMOrO2bTHwirY7tHQSB
         PbBHjsQPZDBYe7vQ/BrBdHI6e0QD5E3lzsu/TcT0YHpK1FD/94RLOxC5CwasGyDKjmf1
         AmQx/UEnWE2CB6pITh4H+iBo8TuMNiX/KCS/twCFUHy6C6RkPE2h0ixGva3XQxOVLpDT
         k/kg==
X-Gm-Message-State: AODbwcB6nv51JFUMGGpvwI/SWEkwG4+eIsrL3oEWP5BhrTAgN0fy7kNx
        2GBUT2keGUA6kQ==
X-Received: by 10.28.128.202 with SMTP id b193mr11620216wmd.53.1495741555383;
        Thu, 25 May 2017 12:45:55 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q203sm8387273wme.0.2017.05.25.12.45.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 12:45:54 -0700 (PDT)
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
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 01/31] Makefile & configure: reword inaccurate comment about PCRE
Date:   Thu, 25 May 2017 19:45:05 +0000
Message-Id: <20170525194535.9324-2-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170525194535.9324-1-avarab@gmail.com>
References: <20170525194535.9324-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reword an outdated & inaccurate comment which suggests that only
git-grep can use PCRE.

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
for the Makefile to configure.ac where they make less sense is the
pattern everything else follows in that file. I'm not going to war
against that as part of this change, just following the existing
pattern.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile     |  6 ++++--
 configure.ac | 12 ++++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index e35542e631..eedadb8056 100644
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
2.13.0.303.g4ebf302169

