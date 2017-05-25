Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BACB420D09
	for <e@80x24.org>; Thu, 25 May 2017 19:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1036757AbdEYTr5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 15:47:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34404 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036744AbdEYTr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 15:47:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id d127so55401081wmf.1
        for <git@vger.kernel.org>; Thu, 25 May 2017 12:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IOdPOVqbU2O7qXGUrrPr2KaMG71tuheUu+tYitAMihs=;
        b=kwXfM5ivO3tYChRouTlsMFNKjjqRIw3cnnghDDX2LRgwAIdkGP0cRI3/ICGQZ9doym
         GbMc/12O3/LxQNEPBEL8/JOQS1gbaZJugj3oSkP2U07w/CdyDLFXhciJt1du3kJE0lhe
         bru+GQ8Ju1bU5QlrHlyrMawXgqN0b9/ShGQclVsY3R6fO29ih76av4n6c+azWs8ZYkbW
         romIEfsA5G6FVsmwlJ0FYyJlsfUR8BXp5nLJfYewT9v8LJebAnnf/nqv9djUya01lUS9
         LNLo90rs8r9Mc+ajO4RjrMGIxVEZbXWyLSaGyjq96ocnKQE+EiNy34y12kgOiYVXmYao
         Uapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IOdPOVqbU2O7qXGUrrPr2KaMG71tuheUu+tYitAMihs=;
        b=JKUip+Vi59Hhu8bsGVCKQ0kueJWfO9u9d5QPQo9HmbdL57gTaT1AYx2/LnIVwSFao3
         bDqEbX2H5zFdsjz3XXsnK5bjy//UwqnHCBuCVwkxm8NYUF4EQUqSHBp0u+1M5pIk9U0P
         7+EFjhGIdlzlt7Xz9Zqw8pmtmP30jJdvwHnxELcS8JA0Crv+cXOqC268MuBBK59Re+BC
         W4VNa/QpLQExtU4SMBZH855gJnOhBRidfdj12vbvh0/pijWZOwM1MwzLwbyAZAI5ghno
         4yqSIilknpRuZOpcNh08/Blp3G4W6YJ+j51ceeYxdUsh+6FsSl89jB9qUF+WUxOKljm/
         1A6g==
X-Gm-Message-State: AODbwcDy08nbtLoNaOstc+BdfpBYjkWX/ecfrqPC0NrZcpzV5yQy+9Zm
        ExUUW9momIb89w==
X-Received: by 10.223.164.15 with SMTP id d15mr28877575wra.20.1495741645558;
        Thu, 25 May 2017 12:47:25 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q203sm8387273wme.0.2017.05.25.12.47.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 May 2017 12:47:24 -0700 (PDT)
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
Subject: [PATCH v4 27/31] test-lib: add a PTHREADS prerequisite
Date:   Thu, 25 May 2017 19:45:31 +0000
Message-Id: <20170525194535.9324-28-avarab@gmail.com>
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

