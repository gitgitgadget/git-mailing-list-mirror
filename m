Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99DFC20188
	for <e@80x24.org>; Sat, 13 May 2017 23:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758888AbdEMXRT (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 19:17:19 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33020 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757675AbdEMXRS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 19:17:18 -0400
Received: by mail-qt0-f196.google.com with SMTP id a46so11220444qte.0
        for <git@vger.kernel.org>; Sat, 13 May 2017 16:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Bi3Xd/hOA6Q5eWw0aVp5WilKroER69eGoNdzZ09QRA=;
        b=QHKlUfr+RuwvMwhiW0xnlR9f+1b9EYICcT3s1icq0YZ0QMhu7iVeaZEzYyTa7SmFvK
         sUNnuKrY57RJZaH+2+v4NgHkb5/B9QFG2iyP4KTi2vPwMjcb23reR5ydiD6XGxiD6i0S
         qHXZJ7bIppDir8z3IN5ezjLoDnkabzys0E4P/hPgGCSqiw95c6an8cviS2J/ruoGdMRi
         PZYwmyHSkhevCb7lSCqEDrv42tKBaNWEc78Le3+l9jgylW/YjOBPUgH3CLTHaTlcqcmH
         neyNGDTkvKATWwzKuAOEmXBGYRjE3bRDgC6yKhVTgX0gzEBUabELrp8S2JTRnaFYcEC/
         Nj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Bi3Xd/hOA6Q5eWw0aVp5WilKroER69eGoNdzZ09QRA=;
        b=tjkzJSgXRpf6hAgEW+2ZOHOLgIgLrzFPcfWq9UqpXChtboSIiLEI/n5D0AdtrKM3vO
         HcgSYwRg94Qx4n0iS5hT5Sx5lMEzq4SQieEubqEvUdLKkQntn5KOJg9kRSjOvRF0PUIt
         gFGNh4jJotZuiw86god3+OwtUMG/Rwe8MbtO5+1ba2O7RwfD9DPnVo6cILmF/Kb6eQw7
         IskmxF6xd4YQ4PIy/1TjXSxiA78bWbJdz5s1BhFboY8IdlWzs+R9bssTrCF7Bi/20J3I
         NjxCRRzEgRyS/tQ4MczAN6GMIZVP/2+lhihYKwc5ZZEtrxKNhhX1X0dVY1sftqcjdFmu
         6Gzg==
X-Gm-Message-State: AODbwcBpHUbNMPjvMHxTFFDDbSU4c1thGAAoECA0sXmnx2Ug1sYjCQn0
        Fzrn1YTx93B//Q==
X-Received: by 10.200.57.103 with SMTP id t36mr9497440qtb.291.1494717437633;
        Sat, 13 May 2017 16:17:17 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id k86sm5574840qkh.12.2017.05.13.16.17.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 16:17:16 -0700 (PDT)
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
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 25/29] test-lib: add a PTHREADS prerequisite
Date:   Sat, 13 May 2017 23:15:05 +0000
Message-Id: <20170513231509.7834-26-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170513231509.7834-1-avarab@gmail.com>
References: <20170513231509.7834-1-avarab@gmail.com>
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
index e5cfbcc36b..ab92c0ebaa 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1009,6 +1009,7 @@ esac
 
 ( COLUMNS=1 && test $COLUMNS = 1 ) && test_set_prereq COLUMNS_CAN_BE_1
 test -z "$NO_PERL" && test_set_prereq PERL
+test -z "$NO_PTHREADS" && test_set_prereq PTHREADS
 test -z "$NO_PYTHON" && test_set_prereq PYTHON
 test -n "$USE_LIBPCRE1" && test_set_prereq PCRE
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
-- 
2.11.0

