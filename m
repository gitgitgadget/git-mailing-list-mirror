From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 28/44] apply: rename and move opt constants to apply.h
Date: Fri, 10 Jun 2016 22:11:02 +0200
Message-ID: <20160610201118.13813-29-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:12:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSn7-0003W7-OU
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbcFJUMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 16:12:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33533 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932446AbcFJUMU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:20 -0400
Received: by mail-wm0-f68.google.com with SMTP id r5so1069847wmr.0
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hwZ6h2RWAsFaBfAOVj+Nqj32lwrmXG7vProp9v1nQag=;
        b=xw+nNllRxGjqzYNg/hZZ4wxknZfAhF9PP5HyhPulQ4BJhD0Z2BQ5E2i6s15E72R/a3
         eg1LaGFlPRUS6YzZAsscE15seAZ0Gjs1Wo39opHu4QxDxFnIg2OBY/WL4iaP3ExstuIT
         GFsEWUXdi7uCLTcVmal5HDxIGbLSGqWpauFskl6hRimoSgUg1HHqAJ6U/QHPa5ojDeeg
         72VTT1+4QN3TlZs0ndKwdFsq3YMbIwWkEcaM8eyQFeBjqAWi8LQZaDcQa3ccq7ecSZ+H
         SyoZI2eUj/nMuUBClXVmv6nc+VUK/ajtcZv5uskvxjSjECBmKukRwxiTebxyMO4i26GD
         Vd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hwZ6h2RWAsFaBfAOVj+Nqj32lwrmXG7vProp9v1nQag=;
        b=C9s0t0qQcTAWXWpWWS69nr8lX5C0iCZ/kq7JZh1De/9ZI/9LOt+GtYO47OqYZSP2Nz
         /QE7AGmgIGO/55cMe3qRRyMsgNEBFHQKJi+3ndDpOaiLetQM8yf3kLINTDPcKRMvyNf2
         9vG4llnquQR44fhqmmzmCmaDTPQNyjAWzUHgDXXXcdTzkkC8MT9Ps1VuXmuh+LKebDd9
         hGG+aUrTw/ZkTN+ODoYbhCMTB5hz9B+rtE4QLUtBjc7r0CQkY57Pamz8GteFz3poXV1u
         uNq7lEqRxUU4z5XjDLQ6nGNfA5YKXB94wDObgK2zOlo4myyFydGhJWt2edvaWQMAF+fU
         5zsA==
X-Gm-Message-State: ALyK8tLmnzPr/mQSO8jAaTDzOkXtgxVG8N7uf+rxzqDLT+VIkBEdNA6t+mia9yWiYb+LoA==
X-Received: by 10.28.230.200 with SMTP id e69mr655744wmi.53.1465589539385;
        Fri, 10 Jun 2016 13:12:19 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:12:18 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297037>

The constants for the "inaccurate-eof" and the "recount" options will
be used in both "apply.c" and "builtin/apply.c", so they need to go
into "apply.h", and therefore they need a name that is more specific
to the API they belong to.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.h         |  3 +++
 builtin/apply.c | 11 ++++-------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/apply.h b/apply.h
index 1f2277e..3cc3da6 100644
--- a/apply.h
+++ b/apply.h
@@ -108,4 +108,7 @@ extern int init_apply_state(struct apply_state *state,
 extern void clear_apply_state(struct apply_state *state);
 extern int check_apply_state(struct apply_state *state, int force_apply);
 
+#define APPLY_OPT_INACCURATE_EOF	(1<<0)
+#define APPLY_OPT_RECOUNT		(1<<1)
+
 #endif
diff --git a/builtin/apply.c b/builtin/apply.c
index c84add0..a06ab55 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4449,9 +4449,6 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 
 static struct lock_file lock_file;
 
-#define INACCURATE_EOF	(1<<0)
-#define RECOUNT		(1<<1)
-
 /*
  * Try to apply a patch.
  *
@@ -4480,8 +4477,8 @@ static int apply_patch(struct apply_state *state,
 		int nr;
 
 		patch = xcalloc(1, sizeof(*patch));
-		patch->inaccurate_eof = !!(options & INACCURATE_EOF);
-		patch->recount =  !!(options & RECOUNT);
+		patch->inaccurate_eof = !!(options & APPLY_OPT_INACCURATE_EOF);
+		patch->recount =  !!(options & APPLY_OPT_RECOUNT);
 		nr = parse_chunk(state, buf.buf + offset, buf.len - offset, patch);
 		if (nr < 0) {
 			free_patch(patch);
@@ -4785,10 +4782,10 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
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
2.9.0.rc2.362.g3cd93d0
