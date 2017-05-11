Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EE4D1FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754911AbdEKJS7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:18:59 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33050 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754823AbdEKJS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:18:56 -0400
Received: by mail-wm0-f66.google.com with SMTP id y10so5500189wmh.0
        for <git@vger.kernel.org>; Thu, 11 May 2017 02:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v1qkCRm/Z3LtU5uwjIY+qewmLtUUzJLKe11tVGGlik8=;
        b=oMAVWXeax3aKJv9rl6MBM+STAAGGctY/BSEv2W0REbM0c2o/jIKkd2tbr8KF0hRbDo
         BBgcsBwkyYOKzdFENfb14njlp5kTG12DA8y/oy/1Vuf8FWUJjdazyX1/2iylhlreCcsL
         PQoC855GRodfjwuO45DKju0mZCRGSrgP35iqQHy1G1hzQi+6nV/UDqv/HR567yKGU7DN
         wHReNx9bAWcyUI3l0CNvGmutwzWU/Ksegz2/RiwyMTOuxofcds8JIbsFe5VDf6XQfUu3
         16PchT0dHzqiBcsKaHKB8rBSVQPwaFqKZEBfR0zPdLPzGwQenQMMs9vczDkFurLjZPZe
         J3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v1qkCRm/Z3LtU5uwjIY+qewmLtUUzJLKe11tVGGlik8=;
        b=I1KgpBWrhzvnd+zCHfDjUsrWogysNMjrRPofL8PRiwvI+HWIzez04CvQAiq4KhfeK+
         ti4mfkHX846A0zOn+/jO3WAZf72F39zwpOuz2grnPsbqonZ+BjdXFweM/PLk8MADm/Iq
         VZHBqSgfCzPxhNWFKcni/A4KZqiaFHVwD9FIlHnZziiRFeOMcggip4LvA1xhvAHzME0P
         Z3e5vPp5RoUadilxqbv8em50yVEyHQdPeptz5Llg1x+Bi+Y0GCpRxiOLle/btn+dzzFR
         kmXBl5EqBW5JJPDO6kdbu3TEqf8CjVpNSNP2jPmwPOkqPjAbR7XKtyJZW6hO/FlCImm9
         9SBw==
X-Gm-Message-State: AODbwcCs2EDQZkRd50nHiNcEUBzpJugAkBHQnqOgHaZ9Fidg8fOkmTWD
        OqD9Qmq10h62LA==
X-Received: by 10.80.194.138 with SMTP id o10mr33658edf.94.1494494329808;
        Thu, 11 May 2017 02:18:49 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b3sm8341ede.9.2017.05.11.02.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 02:18:48 -0700 (PDT)
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
Subject: [PATCH 01/29] Makefile & configure: reword inaccurate comment about PCRE
Date:   Thu, 11 May 2017 09:18:01 +0000
Message-Id: <20170511091829.5634-2-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170511091829.5634-1-avarab@gmail.com>
References: <20170511091829.5634-1-avarab@gmail.com>
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
2.11.0

