Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31508201A7
	for <e@80x24.org>; Sat, 20 May 2017 21:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932369AbdETVoG (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 17:44:06 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33734 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932359AbdETVoC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 17:44:02 -0400
Received: by mail-wr0-f196.google.com with SMTP id w50so5751309wrc.0
        for <git@vger.kernel.org>; Sat, 20 May 2017 14:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IOdPOVqbU2O7qXGUrrPr2KaMG71tuheUu+tYitAMihs=;
        b=j0ybA1JcHeg3wFOltSGq8Yq5cgtSDYZI172qUcDL0j8VFEeVuvWS2iTency2tkXg3r
         vUWxdnDaiwctW/glE6GDpfKCtATnvj1meRg0lYyurXpJxKFTKqcfEFys9bFQtwsLnj6D
         zWHeQKOwXPvkH559N+OYC4DZS2oRoxLmYWJnG9/v3qAjFneHsq3aa//jSkeVD/pM5z6b
         nkkTSflNGvuPNHJMcWJHDISzrChnBCy+Qf3i+84K1CWzg4lRXic9tqWkKII+QuSOLZ6u
         moAS2SMzjrwrJ07WNWqzZaeWnl/t3FrIHbeuhF+mlK3h5xvcwQuNFuO7h5ldFJQQAG6V
         LbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IOdPOVqbU2O7qXGUrrPr2KaMG71tuheUu+tYitAMihs=;
        b=QuMAQdAV0Fq+LG1BvfkGY2PQz5hxucX08fQLEZNK5jfpe1WU59nmJXHtAjzOINx1Bn
         UpNWH3+1Co048gOBF+62o8aHlBtylUO5JNyaZT45UcCT00wqrLKJ/gcpHXeVnQ0jog+y
         hoEJc5nPqbeiIOkQFfmT9sPb/ErNEGmuKlt4biWlr+GbhibTyYPkHBA6xEtDCTmixIdy
         MxuBULrIu23xycCZH0Mj4Gr6eNiGCJFCqmUk+SbesMTiix58MbR3zjgeAnvhfch+4fOC
         5UO296a/GvThBntJsw25+zjaYelu4KMA73crYm6R1jQN7tXhDshuIlZYzupQdqxsoj/4
         qXuw==
X-Gm-Message-State: AODbwcCnLjDNes9SwED5MGl8TvAnLFkVBLwBHsUF6HOB9iNPLsN1sn5K
        61IY1Au6GRB0cQ==
X-Received: by 10.223.163.215 with SMTP id m23mr7927543wrb.100.1495316635623;
        Sat, 20 May 2017 14:43:55 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e73sm25666835wmd.1.2017.05.20.14.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 May 2017 14:43:54 -0700 (PDT)
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
Subject: [PATCH v3 26/30] test-lib: add a PTHREADS prerequisite
Date:   Sat, 20 May 2017 21:42:29 +0000
Message-Id: <20170520214233.7183-27-avarab@gmail.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169
In-Reply-To: <20170520214233.7183-1-avarab@gmail.com>
References: <20170520214233.7183-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a PTHREADS prerequisite which is false when git is compiled with
NO_PTHREADS=YesPlease.

There's lots of custom code that runs when threading isn't available,
but before this prerequisite there was no way to test it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile      | 1 +
 t/README      | 4 ++++
 t/test-lib.sh | 1 +
 3 files changed, 6 insertions(+)

diff --git a/Makefile b/Makefile
index 374fbc7e58..a79274e5e6 100644
--- a/Makefile
+++ b/Makefile
@@ -2242,6 +2242,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_EXPAT=\''$(subst ','\'',$(subst ','\'',$(NO_EXPAT)))'\' >>$@+
 	@echo USE_LIBPCRE1=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE)))'\' >>$@+
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@+
+	@echo NO_PTHREADS=\''$(subst ','\'',$(subst ','\'',$(NO_PTHREADS)))'\' >>$@+
 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@+
 	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
 	@echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
diff --git a/t/README b/t/README
index a90cb62583..2f95860369 100644
--- a/t/README
+++ b/t/README
@@ -817,6 +817,10 @@ use these, and "test_set_prereq" for how to define your own.
    Test is run on a filesystem which converts decomposed utf-8 (nfd)
    to precomposed utf-8 (nfc).
 
+ - PTHREADS
+
+   Git wasn't compiled with NO_PTHREADS=YesPlease.
+
 Tips for Writing Tests
 ----------------------
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1d0f636cbd..43529451f9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1013,6 +1013,7 @@ esac
 
 ( COLUMNS=1 && test $COLUMNS = 1 ) && test_set_prereq COLUMNS_CAN_BE_1
 test -z "$NO_PERL" && test_set_prereq PERL
+test -z "$NO_PTHREADS" && test_set_prereq PTHREADS
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
 test -n "$USE_LIBPCRE1" && test_set_prereq PCRE
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
-- 
2.13.0.303.g4ebf302169

