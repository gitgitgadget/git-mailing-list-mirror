From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 78/94] apply: rename and move opt constants to apply.h
Date: Wed, 11 May 2016 15:17:29 +0200
Message-ID: <20160511131745.2914-79-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:21:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U4l-0004bD-E6
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbcEKNVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:21:10 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33990 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932353AbcEKNVI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:21:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id n129so9423073wmn.1
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tDrhiTVnqP1lSsO71ny8bTCBVX7pYpBCRhBwBRuTqo0=;
        b=tVFNLJrIbhy52SysKNoDck+KyCr6fqWPEJxiSyzLASS0F6OOdY9w5wCUUuhQTjSdSO
         2sbGPhFzatDEJ8b0IkyYolSYCg8wHTPqWizrdfcmPctMJl3pA5pTN5FrLxS7raM4conm
         RNeJtVfVlc9vIA1oP6LPzy+pOm1ow8dzVjKEVAiOLMaRHxaMGCHb7d8vv4roHN/XdKBC
         YavI7/Tu555L/Uuvhc+VLBs/T0aA38bELKGMg7vG7b3Trh/yV1SNNOutkd2ShP1cpAnR
         7xnKopSCayOE9CUHcjDUpjEH24eu/pWnKqntNjnYb4H5HCPS/8fbVQWxJs/4V3GioWgB
         jTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tDrhiTVnqP1lSsO71ny8bTCBVX7pYpBCRhBwBRuTqo0=;
        b=Sh3vppJiIgkNoTEmbfeGkL6/w9S39ITwtqm4yj9Bwb3FxiDkR5Lo4etIJQDMYSBzoM
         LrLBWGEWj+WK8i3ppeMKQnusq4fqDqhT9b1rouA6J0rCVnHaNZcFVd7wZyi0l03vU0iq
         m6WCcIygmwrp74qhYGwyxRPoaiwQDEoPTohRKRyYcLSOetWRMxRvwHnoogM5S7c2+AXn
         FRg4i+n3jbb/XV25si9k3qR21O0V53GIByNkg/vKJzEBykilo6EPVSPwpxDNfOEj6kYR
         EdirTOkPukoGzouwlC2jaCOEszO4NPhfqHbRuSYhI5xpvJVdeixomvJRNRlYSVW1s4u+
         6vkg==
X-Gm-Message-State: AOPr4FUe04E75ccXqITZ/gFdxIpLSnLnRBIoUlTqyct9rCft0V9Vr6B+O7SVISc8VbWSTw==
X-Received: by 10.194.115.39 with SMTP id jl7mr4127714wjb.81.1462972867069;
        Wed, 11 May 2016 06:21:07 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:21:06 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294293>

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
index 5266612..60e0c2f 100644
--- a/apply.h
+++ b/apply.h
@@ -122,4 +122,7 @@ extern int init_apply_state(struct apply_state *state,
 			    struct lock_file *lock_file);
 extern int check_apply_state(struct apply_state *state, int force_apply);
 
+#define APPLY_OPT_INACCURATE_EOF	(1<<0)
+#define APPLY_OPT_RECOUNT		(1<<1)
+
 #endif
diff --git a/builtin/apply.c b/builtin/apply.c
index f05dc96..9ce177b 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4448,9 +4448,6 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 	return errs;
 }
 
-#define INACCURATE_EOF	(1<<0)
-#define RECOUNT		(1<<1)
-
 /*
  * Try to apply a patch.
  *
@@ -4479,8 +4476,8 @@ static int apply_patch(struct apply_state *state,
 		int nr;
 
 		patch = xcalloc(1, sizeof(*patch));
-		patch->inaccurate_eof = !!(options & INACCURATE_EOF);
-		patch->recount =  !!(options & RECOUNT);
+		patch->inaccurate_eof = !!(options & APPLY_OPT_INACCURATE_EOF);
+		patch->recount =  !!(options & APPLY_OPT_RECOUNT);
 		nr = parse_chunk(state, buf.buf + offset, buf.len - offset, patch);
 		if (nr < 0) {
 			free_patch(patch);
@@ -4770,10 +4767,10 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
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
2.8.2.490.g3dabe57
