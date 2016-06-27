Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FEA92018B
	for <e@80x24.org>; Mon, 27 Jun 2016 18:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbcF0SZ0 (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:25:26 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33826 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbcF0SZX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:23 -0400
Received: by mail-wm0-f68.google.com with SMTP id 187so26961423wmz.1
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YC4cPEXgHvpJ4fOnMdUChq4r4+M3Zm1VACptK6PpM3o=;
        b=MdIfu9LLtdxb3r0PjFevPS+nAN8AntQHxlA5IRgK5E2nNiUDo+Wb41qYudxL7xjwzi
         RVjDJDd6LeabZJgvFRd7G0AdZSppV1sDCXxSeKakNpfF5Vg0k7WK2fIThZ5feUYhq7OP
         uzDv9YkYSvcAP7p2ni/1pQz8bvH2Rh985KmE9z2DTcCUw0yc9D20w9gAAD6FAZPeSZbl
         zJSF79kugUUByHTVQjjp/2G6zYBVBYHA/2TF1xbsBp1HufSiLLIYVH3UI6GKUcRuqeng
         ydlrSUdO15MLXULxQcpRv0l/GGaYLUnNqjVRiMWEFn+9f3ivLpZ/35BNo91Gu+AYeI/A
         cL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YC4cPEXgHvpJ4fOnMdUChq4r4+M3Zm1VACptK6PpM3o=;
        b=VVBhmsSZs9uXtK3gB1ulWXVVcovJo5Oj5oG8TgeC49Gg+t9Gd8lwZP3xLCPJuvctJk
         Cx9lkb/4W66E8q/CuARKQVyZY2b6SAF149CGXqCWdGwEYYz928EWmDMmJ+Gk2cp5nuC0
         krY3fSaDwt5L8IJDqVoJ7/+Q6xC8BQTvCF7XvLI3ESeHQTDYeF2qI3pOn1VjB2keNcIV
         ngNbcC0A4vpPk12OkW9oFbz1EIKhaxjZD2RTBH/Tqgb6qlBnyuVxOPF5PAZpsdvHOnLq
         EOoxC1lDNun66cbEBZYwTBz688YERRmrZhTAsFbUwyAKcJjswliLNb/3dFlZ0wObT+Sb
         qtjQ==
X-Gm-Message-State: ALyK8tLhefICCS7UgVHTLZGHdrB+ZWHDQQZ+1GHeVFAVqLke3rbqDoGQSE2ozbRV96Tiug==
X-Received: by 10.194.179.199 with SMTP id di7mr2214707wjc.26.1467051909637;
        Mon, 27 Jun 2016 11:25:09 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:08 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v8 14/41] builtin/apply: make apply_all_patches() return 128 or 1 on error
Date:	Mon, 27 Jun 2016 20:24:02 +0200
Message-Id: <20160627182429.31550-15-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
index 18c5419..29ca524 100644
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
2.9.0.172.gfb57a78

