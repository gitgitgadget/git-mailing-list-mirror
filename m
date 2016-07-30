Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 208C01F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611AbcG3Rhq (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:37:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35903 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115AbcG3Rho (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:37:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id x83so20046721wma.3
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:37:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pebzxHBUsOskW1kQJTGrZIup0XnqyMn4DM3DXYj5CqM=;
        b=Va3PNCunLq45ly5K6o/ouH1u+DqOupXaScEG5q45SADme7QvbhfhXIqYsqz8vY4lKK
         KXqJaQZV3+MT3gpQpiwP+IvIg/f4reapJJm5wvhowGAI1GDakoZSYEiDMyD/mSp79PLF
         wsNtf2+S5SwEDancuBhOA8iw8fy1wcbotR3caSym7xAhuF9rq/hosvF61z4i7YrGh4c2
         nDBc2waGezQzQv3vmwtjaa/8LZwtqQQcn2sTI2Sxi2+qJu2F0vwBSlAin0Dj9wN7/+Ar
         b8FxGboKIejK/ZMXakKaqEGO6i0qMwYkFAByiSZWDk6TFB/b+5M/MQQoz5ugyAZYKA0w
         Aqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pebzxHBUsOskW1kQJTGrZIup0XnqyMn4DM3DXYj5CqM=;
        b=DgycWBfH2HI6rOrthSUyvA766BdktnLY/FNJcWBzsHVVN36UCRcseKp+BQJpDIN6R2
         7EI0he04oTJ28exVAZVt2nldbskN/XkI7ZJFvrzT50CPceXI6oGjNwpUnDSUZdzhX0Q0
         Ts/6qTbb4567o4Fb6XCw4zAl9eEDpY4rmjx6yOJpweCzggzjC8X7723KcqUZJBB1XYN7
         OhcQQ/GC2lVP83d2P67eu0jZfPMwiwci/2AEaDztebyvcgYFy7XZg8K3bjDfbKuzkp8/
         7nFgEpyFaSfLFcznEX3HjECqLLju3mFWwU7G4BJe8LaBuhTieVb1PbYXrKjtn/QnqYX0
         9LWg==
X-Gm-Message-State: AEkoouswCw7tUKFLZwLsBayzxDmmrPGIC7W8YTHCb0QpO2Y4G40HNBPoDBXyy6fV0lHLgA==
X-Received: by 10.28.221.8 with SMTP id u8mr48024315wmg.61.1469899548116;
        Sat, 30 Jul 2016 10:25:48 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:25:47 -0700 (PDT)
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
Subject: [PATCH v9 14/41] builtin/apply: make apply_all_patches() return 128 or 1 on error
Date:	Sat, 30 Jul 2016 19:24:42 +0200
Message-Id: <20160730172509.22939-15-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.558.gf53e569
In-Reply-To: <20160730172509.22939-1-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
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
index 8f5e2fa..84dcf41 100644
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
2.9.2.558.gf53e569

