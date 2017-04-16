Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3E6D20D09
	for <e@80x24.org>; Sun, 16 Apr 2017 22:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932216AbdDPWVk (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 18:21:40 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33591 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932091AbdDPWVj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 18:21:39 -0400
Received: by mail-wr0-f193.google.com with SMTP id l28so18485328wre.0
        for <git@vger.kernel.org>; Sun, 16 Apr 2017 15:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NKrOMNIhJqnkuy5AmJXzU185HoILpnA+kYRvjckPxvY=;
        b=tyHKhHfjayQBpoTgQRnmClaHj8RcBKv8KLfzoE92kmQJcFopC2YZxdNOeLWuG90YEX
         BQ7TcQPZ+/6Zpi1KO7fgiO5WxLzsxcHHASb2E3l0a0hzYJUMN/K9BtrI97N8cZKpttOF
         obFbY48ACkz1vnDKV5j4LGO9NUuave1RC6tIbcoGYJvTGftOJrsv42MNPhEWUoGVCB9z
         uKPaWyNn8il+qMEfHDaJmHQQUmnuGV9xqAXdYLppdt8meucqO5trP6jM75Zngpw+YbSR
         caN+cheu+/vvzjK0jZHjpsbtxPci0Vn/EvO+E1l63EYkhoipul5Z23Rh1JJfZFR9xleF
         LvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NKrOMNIhJqnkuy5AmJXzU185HoILpnA+kYRvjckPxvY=;
        b=trpJ6CzR43PDjAZ/DODT7FXStokThB65+F1AOJMGxWvw18cE4YZt90k6rSw8bCPYc1
         r8+kODUfjMFJ6yGAtpM067VLYqvqYJTCqDbsOrvKRAbqMkGruEOPlYqYF7tbw6xMW0aa
         keRN6E3DTfWIXWPQz/Gm3IbagcUspaKCrPKFnXCY3Uf9V1OgWF4pfq7BrgeBVuXmvMts
         lyf1//X3tTfQ7wdAVP6engudbsuwLypCxgCpOynooI+fnpG6LfGXGiYcSC1zVF0yEm5P
         +w88EsgA6PSQh+ib1Qb7L8HG9YUFMKXQOoM7rSx19NgItOigOSaYnX7qeHuNPx/YQtae
         a8Gg==
X-Gm-Message-State: AN3rC/5xx3bFZprewso+wEZceDQD53/mc96+0BunmxMfe2/DUweCa8zg
        RrTxmemwKXY6Sg==
X-Received: by 10.223.148.7 with SMTP id 7mr15332682wrq.65.1492381292767;
        Sun, 16 Apr 2017 15:21:32 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id o9sm8045022wmd.4.2017.04.16.15.21.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Apr 2017 15:21:31 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/8] tests: add a PTHREADS prerequisite
Date:   Sun, 16 Apr 2017 22:20:59 +0000
Message-Id: <20170416222102.2320-6-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170416222102.2320-1-avarab@gmail.com>
References: <20170416222102.2320-1-avarab@gmail.com>
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
index 9b36068ac5..9753281acd 100644
--- a/Makefile
+++ b/Makefile
@@ -2235,6 +2235,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_EXPAT=\''$(subst ','\'',$(subst ','\'',$(NO_EXPAT)))'\' >>$@+
 	@echo USE_LIBPCRE=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE)))'\' >>$@+
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@+
+	@echo NO_PTHREADS=\''$(subst ','\'',$(subst ','\'',$(NO_PTHREADS)))'\' >>$@+
 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@+
 	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
 	@echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
diff --git a/t/README b/t/README
index ab386c3681..6775ced582 100644
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
index 13b5696822..fba91bad3a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1009,6 +1009,7 @@ esac
 
 ( COLUMNS=1 && test $COLUMNS = 1 ) && test_set_prereq COLUMNS_CAN_BE_1
 test -z "$NO_PERL" && test_set_prereq PERL
+test -z "$NO_PTHREADS" && test_set_prereq PTHREADS
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
 test -n "$USE_LIBPCRE" && test_set_prereq LIBPCRE
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
-- 
2.11.0

