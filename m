Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78F5F20248
	for <e@80x24.org>; Thu, 14 Mar 2019 12:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfCNMfG (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 08:35:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46731 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbfCNMfE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 08:35:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id 33so5664366wrb.13
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 05:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R+mzPH6o7d5LK0kLUlvPvjklPx0ec57GWWN5I611234=;
        b=HDj5NFcjqihHcJVoY2wEGDCLU4QOw+TfET9MkxZ8v42s5K6AP8uI/rO0DpHnXpAXVB
         UnGsTIqDPuEQtRQqjKmzyBLRBB43GRNJtjEzKteZGzSjSIY+yNxVg+xMZaGYg81etPdd
         cqZmt/tTunDX5CLhpm8IOCa4e9YpVzTrS9KKyf5oerfzO51z8gOu52OM3uuzOhD6/iF/
         FuZqH8d92yA/I/M5sqJI2x8JMuGd72PYJsstBlFgvW46jfbsC6yEZBXXXtSqiy/bzv8m
         0V7hrvIidI5DfT+sjxrTDC/tmD7vanzJtCRLbyD5q+A1MPTfh9RLPVXNU24RplTe+SXh
         Byvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R+mzPH6o7d5LK0kLUlvPvjklPx0ec57GWWN5I611234=;
        b=TPgYhfELuzUExozmE97tHcFlFFptcduvnvT+aFBERLpweUKBSj5A3RzkTZ9aW3wswN
         3cpy3rQR1fTkP8h1IVPPVu8tFb7nX8+Wxyw8gPe8k9TF9RYOaq5dkIfM3dsbdrLCzgAa
         gX4tSNhqwGW4rO/SZGOPTOEIqdtXBcIsSBWSdIx8Onn7SQgqcw7o4BDNKJXVMfuuycnM
         RSGIiyAr2tmwvOGRlaCOxCb0CbN8JhNfy60AEF7R4QNrb2R+2NUljnOsEqHg3Ew2fIkH
         xdXllORcnge4DV9uGVtfacaM1iqdE2LD2EE1dXaaQBeELX4/QTzPMy0kjC9cOhgxpZ1/
         2o6Q==
X-Gm-Message-State: APjAAAVznPnP3h8/cRJwc2ZodFA3+uT2rBUy70JL6rOBg9KPexCRXjO2
        5FSfhaL6ikWzUhUvDFMExUm4sZ88WhM=
X-Google-Smtp-Source: APXvYqywxMtaij1IaMKhgCdSh44Oz8BYKJ2+xabAg6UEZjvJDx8P1mztduUEiC1PaRv6lik6FueRrg==
X-Received: by 2002:adf:eb02:: with SMTP id s2mr2660726wrn.40.1552566901757;
        Thu, 14 Mar 2019 05:35:01 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p6sm42374095wre.63.2019.03.14.05.35.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 14 Mar 2019 05:35:01 -0700 (PDT)
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
Subject: [PATCH v2 6/7] gc: don't run "reflog expire" when keeping reflogs
Date:   Thu, 14 Mar 2019 13:34:38 +0100
Message-Id: <20190314123439.4347-7-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190313235439.30439-1-avarab@gmail.com>
References: <20190313235439.30439-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't redundantly run "git reflog expire --all" when gc.reflogExpire
and gc.reflogExpireUnreachable are set to "never".

An earlier change taught "git reflog expire" itself to exit early
under this scenario, so in some sense this isn't strictly
necessary. Reasons to also do it here:

 1) Similar to 8ab5aa4bd8 ("parseopt: handle malformed --expire
    arguments more nicely", 2018-04-21). We'll die early if the config
    variables are set to invalid values. We run "pack-refs" before
    "reflog expire", which can take a while, only to then die on an
    invalid gc.reflogExpire{Unreachable,} configuration.

 2) Not invoking the command at all means it won't show up in trace
    output, which makes what's going on more obvious.

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
2.21.0.360.g471c308f928

