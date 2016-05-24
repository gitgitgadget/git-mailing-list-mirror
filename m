From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 37/49] builtin/apply: remove whitespace_option arg from set_default_whitespace_mode()
Date: Tue, 24 May 2016 10:11:14 +0200
Message-ID: <20160524081126.16973-38-chriscool@tuxfamily.org>
References: <20160524081126.16973-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 10:12:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57SL-0000wb-De
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700AbcEXIMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:12:41 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36538 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754689AbcEXIMi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:38 -0400
Received: by mail-wm0-f66.google.com with SMTP id q62so3640386wmg.3
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dB5QVFYVXQZOtBwxyPjIJnSlZKoaPkEm+8l0fvrEYcE=;
        b=K+mhnzoAwQyg3q/z+Kis99rPECOwgZm72drHN3GXF3UD+HJD3HJxhd/q8+Qb9P4KVX
         ZN07+NVZEhQ4PVzPYM+JHTO0UfrjgDCBfJEiI3u8MwOmtwdodmL8GiLS5YNTbN0c4ehp
         JJ/cdKWKGVtdw/JFcwimFHEYydWfQ2dhQml1XrVnCxz6SeMUT1ONtk25oawYGxaI4n65
         rO0UZhANu8skci81ln3dhJDmNC9pUPlwwwZ9A8t8Wfy+Pc2ZfJ7KPN5EPyLmJwlD+sOH
         ybRhzL3KT9yOsWWeZZSiNFTdme2gw59S/iE04HSm7x9Dve6tnYdPuV4d5QO+1WJ+dNij
         1SQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dB5QVFYVXQZOtBwxyPjIJnSlZKoaPkEm+8l0fvrEYcE=;
        b=OPCxth8nUwOyzHlKY1/4Cur+UTdKTOWN47XWCeXu3KRELSRQ9d+EnCIFWjDZNEJPTT
         ldW20663lR8VoEelE8/s4rpEkiywwwBCCWqQj1jXyOqc5ReITk+xKq8fK0/mtTVxIQrd
         4Du/dBZBUL72a6V5B8ZU0pb3RKgxp4OOx/u7ZOkmNgMBBKO3q1ct4Dk/Jz/4guNf0zgj
         7Yx8omVeGE8tL8jvDqj+cGyqhLstAZ4wjYE510hVOzqIxazDNz7SQ+8euPJHHe71zfvH
         2MI/hj8vIXqelz209klQNziHgOGM47z7u9DTwWEoUHrJGmLpumj7rmdVmgI2gPMr+7fU
         zmKQ==
X-Gm-Message-State: ALyK8tIqWMcWsF5cLB6GsIlehnwl2wd51d7EMoN23yj5IWb0DsuFVLZTQ0V7sMkKvm808w==
X-Received: by 10.194.186.179 with SMTP id fl19mr3150079wjc.2.1464077556565;
        Tue, 24 May 2016 01:12:36 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:35 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295438>

A previous change has move the whitespace_option variable from cmd_apply
into 'struct apply_state', so that we can now avoid passing it separately
to set_default_whitespace_mode().

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 78205f8..523ed74 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -132,10 +132,9 @@ static void parse_ignorewhitespace_option(const char *option)
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
 
@@ -4785,11 +4784,11 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
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
2.8.3.443.gaeee61e
