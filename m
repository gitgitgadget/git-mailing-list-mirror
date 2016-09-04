Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 025AA2021E
	for <e@80x24.org>; Sun,  4 Sep 2016 20:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932227AbcIDUTK (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:19:10 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36191 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932214AbcIDUTH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:19:07 -0400
Received: by mail-wm0-f65.google.com with SMTP id l65so2665973wmf.3
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aq+NvHV+t5AuHIvmWvkaxCIp16rtUWlSow+XHTkDjls=;
        b=Rg+Y8B+20aIpLuSq9TP6ZrFVFpcu0qW4ouZBTed322AXx0RF4WRNZ0hySx0BY6g5+b
         OBzCQifmcOgNjGw0OOA49B1R8e4t6CyYTZyWRfESR0o3EV+rUj6iLSzFl1M211ldnFEZ
         L+yAGxMs0n1t1oi4GDeATuRu10Kei4/bfZn/Qiwkt8oDUO/X3/pEdhID1HjyrFl9KyLQ
         aVa79PoFsqTVGDC7cetEANZal9n39BsUmkLSxlOfAwDUH/0NJEUSKSUtjVvPUtcOUlPG
         kRhHbUZ6EWgP4P2mA/ET6ySvaqfLnsv4lQQzBo2rJlBsGlU58Nx4R9LWnmYYKryORg92
         kbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aq+NvHV+t5AuHIvmWvkaxCIp16rtUWlSow+XHTkDjls=;
        b=cVMg706YSLyt1OxClpPfeeacb7gjKG8X9i3/qK7Cc6tvwdH4P5WbSctSeTsIqL0Pg3
         ZGU7ieEid5Cr7xj9ddaPVvee+HyJNZ/bZL6VS7tn2exGh0M8T5ynRAMG+Zllsky5tx/w
         iopERcBxrijnR1W1vOjwHUlNEl1Uc7FWrgSvzLEVsGGvrxhJYBDozNnpjZH7KiekqQEz
         LDOBsSabqt0EzMfsrtZflgme3BhmLtDQCpySw38p9PF2gNenvOmai1IKnghk9SKC2Sn+
         305i6Om0kSaXl1PL3Cr4k/iaYUmYo4fOf0Sf0ck24XxhgW0Lq91/wOfW5qhUMGGd89kY
         wQRg==
X-Gm-Message-State: AE9vXwPXrfLGooD2JMjNGZc02UBeAxSQd9z+QbMPAGIdnXvK6neEW/amzqEfnzJpmtlIWA==
X-Received: by 10.28.170.197 with SMTP id t188mr11814103wme.42.1473020346038;
        Sun, 04 Sep 2016 13:19:06 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:19:05 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v14 14/41] builtin/apply: make apply_all_patches() return 128 or 1 on error
Date:   Sun,  4 Sep 2016 22:18:06 +0200
Message-Id: <20160904201833.21676-15-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To finish libifying the apply functionality, apply_all_patches() should not
die() or exit() in case of error, but return either 128 or 1, so that it
gives the same exit code as when die() or exit(1) is called. This way
scripts relying on the exit code don't need to be changed.

While doing that we must take care that file descriptors are properly closed
and, if needed, reset to a sensible value.

Also, according to the lockfile API, when finished with a lockfile, one
should either commit it or roll it back.

This is even more important now that the same lockfile can be passed
to init_apply_state() many times to be reused by series of calls to
the apply lib functions.

Helped-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 075ada4..5530ba1 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4578,15 +4578,18 @@ static int apply_all_patches(struct apply_state *state,
 					      arg);
 
 		fd = open(arg, O_RDONLY);
-		if (fd < 0)
-			die_errno(_("can't open patch '%s'"), arg);
+		if (fd < 0) {
+			error(_("can't open patch '%s': %s"), arg, strerror(errno));
+			res = -128;
+			goto end;
+		}
 		read_stdin = 0;
 		set_default_whitespace_mode(state);
 		res = apply_patch(state, fd, arg, options);
+		close(fd);
 		if (res < 0)
 			goto end;
 		errs |= res;
-		close(fd);
 	}
 	set_default_whitespace_mode(state);
 	if (read_stdin) {
@@ -4606,11 +4609,14 @@ static int apply_all_patches(struct apply_state *state,
 				   squelched),
 				squelched);
 		}
-		if (state->ws_error_action == die_on_ws_error)
-			die(Q_("%d line adds whitespace errors.",
-			       "%d lines add whitespace errors.",
-			       state->whitespace_error),
-			    state->whitespace_error);
+		if (state->ws_error_action == die_on_ws_error) {
+			error(Q_("%d line adds whitespace errors.",
+				 "%d lines add whitespace errors.",
+				 state->whitespace_error),
+			      state->whitespace_error);
+			res = -128;
+			goto end;
+		}
 		if (state->applied_after_fixing_ws && state->apply)
 			warning("%d line%s applied after"
 				" fixing whitespace errors.",
@@ -4624,15 +4630,24 @@ static int apply_all_patches(struct apply_state *state,
 	}
 
 	if (state->update_index) {
-		if (write_locked_index(&the_index, state->lock_file, COMMIT_LOCK))
-			die(_("Unable to write new index file"));
+		res = write_locked_index(&the_index, state->lock_file, COMMIT_LOCK);
+		if (res) {
+			error(_("Unable to write new index file"));
+			res = -128;
+			goto end;
+		}
 		state->newfd = -1;
 	}
 
 	return !!errs;
 
 end:
-	exit(res == -1 ? 1 : 128);
+	if (state->newfd >= 0) {
+		rollback_lock_file(state->lock_file);
+		state->newfd = -1;
+	}
+
+	return (res == -1 ? 1 : 128);
 }
 
 int cmd_apply(int argc, const char **argv, const char *prefix)
-- 
2.10.0.41.g9df52c3

