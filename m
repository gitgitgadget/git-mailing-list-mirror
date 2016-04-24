From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 36/83] builtin/apply: remove whitespace_option arg from set_default_whitespace_mode()
Date: Sun, 24 Apr 2016 15:33:36 +0200
Message-ID: <1461504863-15946-37-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:35:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKCV-00086B-2K
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865AbcDXNfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:35:44 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37721 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844AbcDXNfh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:37 -0400
Received: by mail-wm0-f54.google.com with SMTP id n3so90211340wmn.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rHYt+6kMnV46ucIKTUY8hvLoxQBUMAshNy+uxWKY8xE=;
        b=flN4FhNXMOYHkCP7lxnnMhRJNEnSNGj1mggE9PnLl0rPNJlitxVOQio8RLoXvLvBs+
         X8RuASocRtgGYyycmnhz/aqmQs71W1/GQNE3j7WaewQaipgjgTeeEIbY9xF1RhelUnPA
         VWB1ysGr8EbjHteVsp6cP+OfWeHjENU50TLIGzgmFhTqOYwbzsG0XEJp/Dl9REdCrHTv
         AhHnyT2rrJRFXzjeP76MU/jty8h18R+hfSnbwTAOeKPllrX9BhB9YdVtD5iLfEagotgc
         XVfllA87ksn6m/hFGpAm1ASF1rzULKS1TDkasEXUIidJyJo7A3RlG1LFkzC17edJwYS4
         Q4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rHYt+6kMnV46ucIKTUY8hvLoxQBUMAshNy+uxWKY8xE=;
        b=XZVTE7aHRVb9TcUzmLPZoS6rpTjQ8hBvV9IgsUYtkc6t7+NXAewP8IrJuS6wAoHQzu
         JvTmKz3cs/jeaJVWNDzqoHgmYK6vH7UCO7KXpJh7mXg5Q5mH2IlVQKIhPy5VnmS+aLTQ
         nk4UmTr97ULMnQzDa4Lajha1ctPeTlLUnfOU4QaB9XpDhZAaTBpvzDIt34ONys40sR8k
         8nnms0V41gEwR3j9N97S+zpZlYvsWhONA2obr2rKOgcD7VrB/DahdtDhCWowQERJB9k+
         7Gx+aSA9DEA9t1NVJcYTHxcsPTCHh6YgJfPC/TkTnwksOA4l3tU/Z5d7yb8pLn9oz0e8
         G6Og==
X-Gm-Message-State: AOPr4FWk1E/LuXqScWe+c29imJPMOMgc8wOZceVYPigBZk1yCd6f419FAwn1QaD9DUIu0w==
X-Received: by 10.194.5.132 with SMTP id s4mr24131088wjs.118.1461504936653;
        Sun, 24 Apr 2016 06:35:36 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:35 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292342>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 64bc3e9..401e111 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -147,10 +147,9 @@ static void parse_ignorewhitespace_option(const char *option)
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
 
@@ -4790,11 +4789,11 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
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
2.8.1.300.g5fed0c0
