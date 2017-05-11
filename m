Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97B921FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755329AbdEKJUJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:20:09 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35642 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755093AbdEKJUG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:20:06 -0400
Received: by mail-wm0-f68.google.com with SMTP id v4so5494960wmb.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 02:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Bi3Xd/hOA6Q5eWw0aVp5WilKroER69eGoNdzZ09QRA=;
        b=EQj0SEuzTzw33hZLHjYeAaQPN4qVzY5BJOQaMlugj473N8sKgOw7tF2zfY/UyOvPCk
         Vg8634Hr7n+e4Xg2Yz+vRia5RbEPogDcObyNyI25/HFfk5PWqqvdhA3VnmoH9d6nauEx
         YIYgpGJWR7KIc9QEiQwDMB/m3hQFgdTUG7VZlT/KpQ/QspJ//p1/gjP7jfm7RBggNIio
         n9xvGlpmDX/2ogK4CtzmsBKE6NTqh6gB9r/8CvBKeonmgsutkQyufZmjIG928yzmwy4K
         i+doDM6NpiwliYfiHBxDivKsHDbKO7jaSJT6h5fg2G5ZuQOS39Wx8ZGFG6MomjcPT9fb
         oCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Bi3Xd/hOA6Q5eWw0aVp5WilKroER69eGoNdzZ09QRA=;
        b=E5ar7GAbWZpTStmHbsWftXkzEF6D2xJkAQcwR9PMKObysmosTKdlcfyzitE+4J1xld
         Wf68PciF3BukS00k1kX6HzSAqkhxVsumj9MabDSTPVuns9RUChEBfmDC2lVq0xAq3+90
         ctlm3ZSE/fcTyAzPHK27olPwiqOWps2B1YmmdWF1yvpBc3PSG7K/fD/wKY6WVF6tNbrZ
         RCOoJbvL27EX7srSVXdNlrHRqGtxSzIJEJp7ahlrMUxUHzs9HIF+HwLZNoQ7z/ycCj30
         fTDHp8/N4ZfU55muCvWOxNiarpNFV7Q1Np5YW/xnMbwUq541Jpyrwzz6OvrCaSh+JmxG
         vA9w==
X-Gm-Message-State: AODbwcBYLrCZI+l7ThXK7Nu91N65c6pE+UByUgCIV4HdHMkxqSscpvLN
        7hujLiRKbT+0C5o4JE8=
X-Received: by 10.80.148.185 with SMTP id s54mr54668eda.34.1494494405149;
        Thu, 11 May 2017 02:20:05 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b3sm8341ede.9.2017.05.11.02.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 May 2017 02:20:04 -0700 (PDT)
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
Subject: [PATCH 25/29] test-lib: add a PTHREADS prerequisite
Date:   Thu, 11 May 2017 09:18:25 +0000
Message-Id: <20170511091829.5634-26-avarab@gmail.com>
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

