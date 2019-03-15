Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9D0D20248
	for <e@80x24.org>; Fri, 15 Mar 2019 16:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbfCOQA0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 12:00:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35268 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfCOQAX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 12:00:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id y15so6638704wma.0
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 09:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ebkw8BRdYgl0xvfh6d7pSyKczD01KbunU+1N6IDEEQ=;
        b=pDBp037ZeV5VIE91ar+aPXoxDVp45XU4hCLPTxrLW13sj0LjNyvXYN6zmckAZxkSNB
         gokVkO84DSJSqDdbw+FLJIZH2XtR5EjIKbREsfn1kjvt18tQBfSrQ+GGg/UM8MuyDm2R
         sWTy8GEgS+fM73yUGujz4X27ro/2g1cSVgh2CXwJwCq2vuBPwpve90T8/pjeWOMfmiGY
         WwiTnvpdihqjXvuODpEflOk11rCujc/4MtJTqDyhCSRHUmFD5fm5qDnePbYbe/1rt8C9
         tF116HxcBCQqCfs+oB4OYshONq3YjzCteOzvAWPosvfpKXCOta6GQzLsch3PIWnag3uj
         b2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ebkw8BRdYgl0xvfh6d7pSyKczD01KbunU+1N6IDEEQ=;
        b=m/FHTBZTyFrmcHtEo55X8ElHwxm1eTV7Sgwg0qcd3JTkyHHqSdqS3oRw6htjBxPxzf
         fRv5G4O1Ybek4Z9I8+jM3yiGDtBjAU5DqY44OHKHNvJyDhnIUWiJDe1o6qNQ3mEh2F+x
         uImg1UYx2GVSgE87BKyilDAAnDcrO0TH17ekXMvAt5iruWthQmaStHkWSx7EyNrPY/Pp
         Ta37qEptI6wzDPwII2nx/bZqLrOXl7PF6dLRuC/SK98zbR4eJFY+KV5xj8r7W+pmQ2+y
         m9MPD6CcimidcHoMGUl00wrq9WfB+qppuCHvwT9qyGwlHAKlnc1YVMC/V0Zo7zNpF0xk
         KSxQ==
X-Gm-Message-State: APjAAAUA1Zxq0SHiZYj5li3qKY7d5ZW14QqIp1XSiS65hu18ZWuuQ9Fo
        vctj1QSJ+ZeBAb2O3yvlydXl4XsuRxE=
X-Google-Smtp-Source: APXvYqxgB8iJLR3FGUKdHFZJDvju3DblV6tuKyVF56S3YhIV+YBWxGbOodVHf25+uYri4yKbWQUArQ==
X-Received: by 2002:a05:600c:224f:: with SMTP id a15mr2589345wmm.2.1552665620207;
        Fri, 15 Mar 2019 09:00:20 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a18sm467766wmm.14.2019.03.15.09.00.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 15 Mar 2019 09:00:19 -0700 (PDT)
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
Subject: [PATCH v3 7/8] gc: handle & check gc.reflogExpire config
Date:   Fri, 15 Mar 2019 16:59:58 +0100
Message-Id: <20190315155959.12390-8-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190314123439.4347-1-avarab@gmail.com>
References: <20190314123439.4347-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't redundantly run "git reflog expire --all" when gc.reflogExpire
and gc.reflogExpireUnreachable are set to "never", and die immediately
if those configuration valuer are bad.

As an earlier "assert lack of early exit" change to the tests for "git
reflog expire" shows, an early check of gc.reflogExpire{Unreachable,}
isn't wanted in general for "git reflog expire", but it makes sense
for "gc" because:

 1) Similarly to 8ab5aa4bd8 ("parseopt: handle malformed --expire
    arguments more nicely", 2018-04-21) we'll now die early if the
    config variables are set to invalid values.

    We run "pack-refs" before "reflog expire", which can take a while,
    only to then die on an invalid gc.reflogExpire{Unreachable,}
    configuration.

 2) Not invoking the command at all means it won't show up in trace
    output, which makes what's going on more obvious when the two are
    set to "never".

 3) As a later change documents we lock the refs when looping over the
    refs to expire, even in cases where we end up doing nothing due to
    this config.

    For the reasons noted in the earlier "assert lack of early exit"
    change I don't think it's worth it to bend over backwards in "git
    reflog expire" itself to carefully detect if we'll really do
    nothing given the combination of all its possible options and skip
    that locking, but that's easy to detect here in "gc" where we'll
    only run "reflog expire" in a relatively simple mode.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c  | 17 +++++++++++++++++
 t/t6500-gc.sh | 19 +++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index ae716a00d4a..8943bcc300d 100644
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
index 4684d06552a..7411bf7fecd 100755
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

