From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 77/83] apply: rename and move opt constants to apply.h
Date: Sun, 24 Apr 2016 15:34:17 +0200
Message-ID: <1461504863-15946-78-git-send-email-chriscool@tuxfamily.org>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:36:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKDR-0000Cp-BX
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028AbcDXNgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:36:39 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35234 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007AbcDXNge (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:36:34 -0400
Received: by mail-wm0-f45.google.com with SMTP id e201so60548916wme.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jX2OYijuXXgiiFyxtl5iQCLZ9SnhxLeslT4dgTRqy6Q=;
        b=PsCHwo0Lh6WinYX/cHccC/UMK9BAiYFEf+t9ELqv/qyks8geKcCEYMxMoZWzcqAbR5
         TKvJ2wZ2LQ7iEU31esiU7bqQRzt7GTdSQVg9Ia5kcuu5SEhPLZ3IEiJGcQ1qiKZRj7dt
         jZ0jdKNgCVuWqQL9hB0glkcfhBfUwQuGfM3knQfUZTDOTy+X0xGrNnksu/nnJYhrOyYQ
         Q7zi/wlm8JlPJ41BgpjztW/xK6WRQm1x8aXLKh+1z1k25VsoCwjSRg2+ov3+yA4j2zZg
         4K2EP2I28hKkXjdKGXgohtDAlwUwNKr7rtasgKKOkVZuVBmzGx2vf6m5OPA1ZJBM2kG7
         0t0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jX2OYijuXXgiiFyxtl5iQCLZ9SnhxLeslT4dgTRqy6Q=;
        b=Eygm/vNxOeJHIwbe9Ro/w6P5zkbxvjRZovNwgRZ1RflQZMqt263zff2fRGGw0nkub+
         vDl8L/q1MiZ5BsORmmSSEUQ0Fzi57SJIoHy0Q6Y45rdwIrcYpqZda1xrviI73HTdWWrw
         gkXOPZmRa1VfTTM54Sw6OD93PBwhq61INxKkxUOt56oxaIozFbkoLmtOp23fJbJn0Okl
         Jz438CUg2gKbrDCkKQXn6E0yZ8+FRP+un+LaBSc6yPqMH0Nko/KyKDMuLhjdbAw3n56f
         6+fREOEOlCDszGPhEer6J5Hb4CkXtxTGzwWvDam4gCte41jwF7T1divBq//hPUtmtfmx
         AmKw==
X-Gm-Message-State: AOPr4FUiAUgnWu5D1MtoKrS/JnaymW76bTChCo79PzlwF06Nxb1JTR1Q+EDZRv3k6icdcw==
X-Received: by 10.28.54.224 with SMTP id y93mr7119754wmh.82.1461504993284;
        Sun, 24 Apr 2016 06:36:33 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.36.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:36:32 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292361>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.h         |  3 +++
 builtin/apply.c | 11 ++++-------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/apply.h b/apply.h
index 35d4d15..3df0128 100644
--- a/apply.h
+++ b/apply.h
@@ -129,4 +129,7 @@ extern int parse_ignorewhitespace_option(struct apply_state *state,
 extern int init_apply_state(struct apply_state *state, const char *prefix);
 extern int check_apply_state(struct apply_state *state, int force_apply);
 
+#define APPLY_OPT_INACCURATE_EOF	(1<<0)
+#define APPLY_OPT_RECOUNT		(1<<1)
+
 #endif
diff --git a/builtin/apply.c b/builtin/apply.c
index 5910c5c..1c53c7e 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4443,9 +4443,6 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 	return errs;
 }
 
-#define INACCURATE_EOF	(1<<0)
-#define RECOUNT		(1<<1)
-
 /*
  * Try to apply a patch.
  *
@@ -4473,8 +4470,8 @@ static int apply_patch(struct apply_state *state,
 		int nr;
 
 		patch = xcalloc(1, sizeof(*patch));
-		patch->inaccurate_eof = !!(options & INACCURATE_EOF);
-		patch->recount =  !!(options & RECOUNT);
+		patch->inaccurate_eof = !!(options & APPLY_OPT_INACCURATE_EOF);
+		patch->recount =  !!(options & APPLY_OPT_RECOUNT);
 		nr = parse_chunk(state, buf.buf + offset, buf.len - offset, patch);
 		if (nr < 0) {
 			free_patch(patch);
@@ -4752,10 +4749,10 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 		OPT__VERBOSE(&state.apply_verbosely, N_("be verbose")),
 		OPT_BIT(0, "inaccurate-eof", &options,
 			N_("tolerate incorrectly detected missing new-line at the end of file"),
-			INACCURATE_EOF),
+			APPLY_OPT_INACCURATE_EOF),
 		OPT_BIT(0, "recount", &options,
 			N_("do not trust the line counts in the hunk headers"),
-			RECOUNT),
+			APPLY_OPT_RECOUNT),
 		{ OPTION_CALLBACK, 0, "directory", &state, N_("root"),
 			N_("prepend <root> to all filenames"),
 			0, apply_option_parse_directory },
-- 
2.8.1.300.g5fed0c0
