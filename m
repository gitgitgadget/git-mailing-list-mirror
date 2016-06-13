From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 28/40] apply: rename and move opt constants to apply.h
Date: Mon, 13 Jun 2016 18:09:30 +0200
Message-ID: <20160613160942.1806-29-chriscool@tuxfamily.org>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 18:10:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCURu-0003vv-M3
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424948AbcFMQKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:10:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33584 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424931AbcFMQKg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:36 -0400
Received: by mail-wm0-f68.google.com with SMTP id r5so16044878wmr.0
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K92qBGLOqck4cj79YeMAKM5LLFpRks9x3/f/Q207khs=;
        b=PrT5DEH9yJpc3fTNGW4l5PtIpG9mTQkpeV4WOKsqxzxQtFHcW9qUfd0vBFkKSBNhiH
         5o7oCfRO1DTl7quS1tuB2uJB4ks56ZhABHOcu4hYVAbbVB73ngnTx2/I9EAhCLu65RoA
         hSa2Xs5KJ2+xY5t8cgfElfLM61t0vAttFB5cfRlFBGfq3VL8BGTJ0tqQKY1ho5UILUI8
         dBcSJS7OvUtI/UpkSBdexGj0+YqEncrbSBeXnmJfTHRppeoGEykDzoudv4REURJ27LCU
         zOQ1gkIIqwhMo2KOc9k6q0fXw/+R2tKHhDL/N/9n+TypMZzTAkLBlM9sT1KdtW14eGuj
         tzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K92qBGLOqck4cj79YeMAKM5LLFpRks9x3/f/Q207khs=;
        b=j7CU9WSbFhzzl+L6zohJg4WbNcXmlJ1aZP1p8TcnJ9i5o9iEMdpy9dUtHAcyfB643/
         owYw2dPPb09bwUZpQyNE0hO2+p3UfyC0Jbl0gAdsebtLfv6oPi+z2PWoinshpIroftGh
         5Z2El+7TS5USRSHoa1K6vvkZ8cad9vIOkLVOY8eRwOhH7LX+LX5gOizctvzaefRrRAaO
         zVlOuhoL9YPt2JlTmEi/ryjmTyrg9Lyv3GjbBZUtOoCOg2Gw9ezdlJ2nS/sKTCNTl3EQ
         KDbqHpNfgRWZ/BpqkXvw+iiUj+ZYDm2JIvalNSaL3uyCv+Bg+xx47PLHuXGEQdFsSXzK
         lyiQ==
X-Gm-Message-State: ALyK8tIpZ9az0mXXCuRwBDNJ8JddhQdFyabgsGjamXmQLZc3VEzIYNZSRYd7dAancpKmrg==
X-Received: by 10.28.15.197 with SMTP id 188mr336138wmp.75.1465834235009;
        Mon, 13 Jun 2016 09:10:35 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.10.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:10:34 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297205>

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
2.9.0.rc2.411.g3e2ca28
