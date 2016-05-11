From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 37/94] builtin/apply: remove whitespace_option arg from set_default_whitespace_mode()
Date: Wed, 11 May 2016 15:16:48 +0200
Message-ID: <20160511131745.2914-38-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed May 11 15:19:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U3M-0002jQ-Od
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbcEKNTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:19:44 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34859 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932204AbcEKNTn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:19:43 -0400
Received: by mail-wm0-f65.google.com with SMTP id e201so9405634wme.2
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+zjKjBhZn49cbk33Y2KI7Ouvq3rrUNB1YD4XywDbCz4=;
        b=cbtmqKdm9o8wpdH32AdHc/r4ZOxMO6WUhdVBxmSJgb6qzElNWn0J/Lb8Aqmd5sB6ZA
         0kcHP+Gai50+ray1UMEFq5lMB14N3Tx+yd7P/xIQSfKu0DIAzzXu9FqoaOjgmf8K2aCU
         zXif2ksgeqC+EfB2kmlg5mIAE0O2jJ1LzJ9IlhdniV2C98IonNGl9LLDaRAwI8xGaAlI
         ujaAoqAx/ZYapXV37iRvHdLLJKe/zWfy/GmK4dG+jD3DWM3CiOD922CRz5S22qumEQYH
         PHnVxciRwX/y0PtkKwRu1S6EDMmDwdFZt6eguCsUBetgEeUMbpJ5glR786y3mNVSR9nb
         UjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+zjKjBhZn49cbk33Y2KI7Ouvq3rrUNB1YD4XywDbCz4=;
        b=Bkc/UzCnxq03hQy5oyh+vXhi4lJ/cUR9HMtEo+HvtvKtgyEiF5Nx0U3JvMimKPcL3Q
         1FWINw1oHDm7BEqtkNnM65s6NFyhKL70SBypF5JpFuW2AR5eM8ZhIDKq8M144tIE+Fav
         /jQiLfOgtNqbrSLXLdVf0jZa6hclyRnnrCz7wTDmddTEMOrrm/AsxCLnWmGMxTfFE0fV
         7uPZsR5z1bS25szEQZd4q3srOLwXio5knI+6v5iiUdlWfNuaKpv31bFmePjsG6aSrjyZ
         7O+mXQ0/fv68cwhmPNTBv29RJSvUoJ1jMLGCgoLPytxubTQYV1N9gxb9Vu5ZFz/aE5Of
         IYgQ==
X-Gm-Message-State: AOPr4FV7KWVWoZO74rHfOx6eEX+WV+6vdjZsomzaXmcnIa+x8kwaM2Tdx8SO2NTA2sHH/Q==
X-Received: by 10.194.147.178 with SMTP id tl18mr665592wjb.142.1462972781815;
        Wed, 11 May 2016 06:19:41 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.19.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:19:40 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294267>

A previous change has move the whitespace_option variable from cmd_apply
into 'struct apply_state', so that we can now avoid passing it separately
to set_default_whitespace_mode().

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 4b9a5ff..ab954b4 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -138,10 +138,9 @@ static void parse_ignorewhitespace_option(const char *option)
 	die(_("unrecognized whitespace ignore option '%s'"), option);
 }
 
-static void set_default_whitespace_mode(struct apply_state *state,
-					const char *whitespace_option)
+static void set_default_whitespace_mode(struct apply_state *state)
 {
-	if (!whitespace_option && !apply_default_whitespace)
+	if (!state->whitespace_option && !apply_default_whitespace)
 		ws_error_action = (state->apply ? warn_on_ws_error : nowarn_ws_error);
 }
 
@@ -4785,11 +4784,11 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		if (fd < 0)
 			die_errno(_("can't open patch '%s'"), arg);
 		read_stdin = 0;
-		set_default_whitespace_mode(&state, state.whitespace_option);
+		set_default_whitespace_mode(&state);
 		errs |= apply_patch(&state, fd, arg, options);
 		close(fd);
 	}
-	set_default_whitespace_mode(&state, state.whitespace_option);
+	set_default_whitespace_mode(&state);
 	if (read_stdin)
 		errs |= apply_patch(&state, 0, "<stdin>", options);
 	if (state.whitespace_error) {
-- 
2.8.2.490.g3dabe57
