Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EF1F20248
	for <e@80x24.org>; Wed, 13 Mar 2019 23:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfCMXzI (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 19:55:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39367 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbfCMXzH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 19:55:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id p8so3900990wrq.6
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 16:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZRlxrUa2uuHticiVZXrDdssEMFiOmy7upKoonlU0mwE=;
        b=HpTE7Q1p4PYfQ8G2ol0F2Zm1SuhEfoCqPwg9leVUSfLh+TfslACDW4FFAYUxijvcYV
         cqeiaYF3QRbj5Oxabqnl8adVxH2RxRhanhHsFEle2pyUmOxgFLSx4ozOyTLdk+Z5ATld
         2Wr14OnayP8SQ2N9k+gFFXwjetQXLkP71GAQ3r8cRRNtHHo4Seqa8gxFQsMF/O/p/Jvp
         rD0Je9uGdou10QlsRxzJ5BNelin3+Ib8XfY7F8ZJpOy1thFTPEs6Patd9rsw1uPmzgcB
         onmOFPOaU40eOmHgHAjyWeUjoWgUEXZwz/3qAGCQe0IFe6uwRBTR6rUaoRbulDd3Iq0d
         IEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZRlxrUa2uuHticiVZXrDdssEMFiOmy7upKoonlU0mwE=;
        b=SBkktgbS6Io52nO5LLBw4zRhUt0jD7bz/OoXEd6ngYw6uEX1zTFK843Uz/qUC5xKNu
         wV/xYNMHqHTe1W+q+iAk+ZiPSMxYdTSvej0wIKgd9LbtbmMWKSosojEZXos0ajA/lk3B
         8tIHiwjNHUBhAL6tsygxBpFtVHb+Okd5gcYtiLVFYdIi/Ok5zh5z0ua25gTJc/AVJ/hZ
         IEpmB+NxGWx2m2L/VIgcOxgE6nUMUTWhrQHJ96n1q7AhUqDkwWOxlY1quFmC4KTaXDzX
         pnG9P0bLM2PwmTCAOLubsJI27vbzkj1magcbxOHjBN7Yd45JWT/fZLURfFur6trnkriC
         g4jQ==
X-Gm-Message-State: APjAAAXhsJsSjdYR752599hBmlsY2561Xe0vPKtPWN30xPJZhW2s+w7P
        mJGUi3tJsfoKn6U3ZubGZ6/lyrSMVh4=
X-Google-Smtp-Source: APXvYqw41N4CFpFlz44fc74MGqlBZA2gIHJh+gd/q0VefvOFH4f6vdAFmNf2W6IMFgm7pLe7dzvElA==
X-Received: by 2002:a5d:48ca:: with SMTP id p10mr5225317wrs.141.1552521304666;
        Wed, 13 Mar 2019 16:55:04 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b10sm9998566wru.92.2019.03.13.16.55.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 13 Mar 2019 16:55:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/5] gc: don't run "reflog expire" when keeping reflogs
Date:   Thu, 14 Mar 2019 00:54:38 +0100
Message-Id: <20190313235439.30439-5-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <87imwmbv7l.fsf@evledraar.gmail.com>
References: <87imwmbv7l.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't redundantly run "git reflog expire --all" when gc.reflogExpire
and gc.reflogExpireUnreachable are set to "never".

I'm being careful to not repeat the issue fixed in
8ab5aa4bd8 ("parseopt: handle malformed --expire arguments more
nicely", 2018-04-21). We'll die early if the config variables are set
to invalid values.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c  | 17 +++++++++++++++++
 t/t6500-gc.sh | 19 +++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index 425d0fa830..91b088dbfe 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -116,6 +116,19 @@ static void process_log_file_on_signal(int signo)
 	raise(signo);
 }
 
+static int gc_config_is_timestamp_never(const char *var)
+{
+	const char *value;
+	timestamp_t expire;
+
+	if (!git_config_get_value(var, &value) && value) {
+		if (parse_expiry_date(value, &expire))
+			die(_("failed to parse '%s' value '%s'"), var, value);
+		return expire == 0;
+	}
+	return 0;
+}
+
 static void gc_config(void)
 {
 	const char *value;
@@ -127,6 +140,10 @@ static void gc_config(void)
 			pack_refs = git_config_bool("gc.packrefs", value);
 	}
 
+	if (gc_config_is_timestamp_never("gc.reflogexpire") &&
+	    gc_config_is_timestamp_never("gc.reflogexpireunreachable"))
+		prune_reflogs = 0;
+
 	git_config_get_int("gc.aggressivewindow", &aggressive_window);
 	git_config_get_int("gc.aggressivedepth", &aggressive_depth);
 	git_config_get_int("gc.auto", &gc_auto_threshold);
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 4684d06552..7411bf7fec 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -120,6 +120,25 @@ test_expect_success 'gc --quiet' '
 	test_must_be_empty stderr
 '
 
+test_expect_success 'gc.reflogExpire{Unreachable,}=never skips "expire" via "gc"' '
+	test_config gc.reflogExpire never &&
+	test_config gc.reflogExpireUnreachable never &&
+
+	GIT_TRACE=$(pwd)/trace.out git gc &&
+
+	# Check that git-pack-refs is run as a sanity check (done via
+	# gc_before_repack()) but that git-expire is not.
+	grep -E "^trace: (built-in|exec|run_command): git pack-refs --" trace.out &&
+	! grep -E "^trace: (built-in|exec|run_command): git reflog expire --" trace.out
+'
+
+test_expect_success 'one of gc.reflogExpire{Unreachable,}=never does not skip "expire" via "gc"' '
+	>trace.out &&
+	test_config gc.reflogExpire never &&
+	GIT_TRACE=$(pwd)/trace.out git gc &&
+	grep -E "^trace: (built-in|exec|run_command): git reflog expire --" trace.out
+'
+
 run_and_wait_for_auto_gc () {
 	# We read stdout from gc for the side effect of waiting until the
 	# background gc process exits, closing its fd 9.  Furthermore, the
-- 
2.21.0.360.g471c308f928

