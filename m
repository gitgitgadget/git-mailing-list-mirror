Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 350FC20248
	for <e@80x24.org>; Thu, 28 Mar 2019 16:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfC1QO6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 12:14:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45252 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfC1QO5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 12:14:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so23622671wra.12
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 09:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZJvTU3k0qMmPHSAq9eKvNiRlibzp+mODk3qXX35Wsb4=;
        b=ruGbbdAYCMtNU9g0UeyFkZe5H2MEdpzFhNeVk+LlTz4S9MrenO1eQJRgYJmlggh8h4
         2QAGhY5jYhrwh/vHb5tt5UHvpeGnNJhjBjniZ5ix5q4EORXDySsvH5Lafi7BgXkVG2kt
         qs7kgbbp/ptjqhjqM+U2BvhC5nEMLNFgLVXeWSgwh3L6MFtasBYYcScytY7tnwJTi0+D
         tGF+1BQbQDS07F4WcW8QALYBprgjdjN/RBOzLFJBGQnqf792H7VxJutYnHXve5c0f6uX
         d+paIzDeJXKwkG3DUQMMidfANgRUFS9+1JkBGuPzFyTNAO511CMRkOYev73gzpvAsj9e
         t7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZJvTU3k0qMmPHSAq9eKvNiRlibzp+mODk3qXX35Wsb4=;
        b=RE1LJLQOcbA6fbH3PCAHfEga8p2OFqKF1VF6Mw8eLRUwI2z1qRbMVWlCtq2SvqRRc0
         I4dJ3h3Qvwrbp7jIhXrdU1q4T7yA9qjBhUmbI1tBKbG508fRihKzj2Ii8hWnLMftRFPD
         2UpkwdYV8TEFq6vNuzmfVpQAFomSN5Jny2SOIF9I0vmYSG8o7kqeNdyCErZWWdeuIh6e
         MNMAyC7oDhFaTbZpk9WZBR5B/Bvdg9TfqM4k15b5Siqo4VdsOO7aAVlBMPQ3wLlb+ESh
         8CQjNJmO6BfsdzDg0671E3zni9mpuho+oKIOOJuTEAT4DSutuoI50zRCAD+6q5S6wVBS
         HCyw==
X-Gm-Message-State: APjAAAWfChtQNGQ0FMIpArCR/Xggg8y5v7SeKOlNMGsyvpoNlk+3jyP9
        /eIJiMlWRg6hz/t76X7u7uHjPKSFsGY=
X-Google-Smtp-Source: APXvYqxVsP1WvG5Ttb/ral8yQeHqucp/iOAw6OfWXitWnZkG+gwnT5BvSsZqpn6XJEuvs6zZ9ajhfA==
X-Received: by 2002:a5d:6181:: with SMTP id j1mr27215546wru.11.1553789694869;
        Thu, 28 Mar 2019 09:14:54 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d14sm25519089wro.79.2019.03.28.09.14.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 28 Mar 2019 09:14:54 -0700 (PDT)
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
Subject: [PATCH v4 7/7] gc: handle & check gc.reflogExpire config
Date:   Thu, 28 Mar 2019 17:14:34 +0100
Message-Id: <20190328161434.19200-8-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e
In-Reply-To: <20190315155959.12390-1-avarab@gmail.com>
References: <20190315155959.12390-1-avarab@gmail.com>
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
index ae716a00d4..8943bcc300 100644
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
2.21.0.392.gf8f6787159e

