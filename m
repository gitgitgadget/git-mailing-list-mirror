From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 48/83] builtin/apply: rename 'prefix_' parameter to 'prefix'
Date: Sun, 24 Apr 2016 15:33:48 +0200
Message-ID: <1461504863-15946-49-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 15:37:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKEL-0000f8-Fn
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbcDXNf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:35:57 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36612 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbcDXNfz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:35:55 -0400
Received: by mail-wm0-f47.google.com with SMTP id v188so69570465wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b8w+nevfzhH22PrFP2RkXWiLdFAz3/0SgRLh39PX8Hs=;
        b=xfXunboW80/japcL+uKn7vYUTN/0OkDgneyM1iGY+od/Hhy4IU2MMAotbOUWAsx4jK
         BZbRVWLYtsA1C7X7QCxoWtr5jkWUBRWNsSzMmNs2xDFgPq9sS/R3y+z5Gq3L2DhPrdsU
         ENdfIp6XW8E/QPVBcO443MW9gNCJGAvHk5kTTkUSPGLcKKLlgNayFS2wOrnPUkZ48uld
         YmLQ3+i2HYbyFuS/zSsHFcYl27CA72ohcG8q+psY7Kk6OPOhiABEOfSVWYvkxlh7HcNm
         azjZxRcroC/KCosmd29JzkrEoMEG2IJ7SWsHrAjSP3TJ9npaCnhkhg6lLLWwB9PxJ93i
         bkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b8w+nevfzhH22PrFP2RkXWiLdFAz3/0SgRLh39PX8Hs=;
        b=Ra3Ol5Xzo1r5YIsjUgBgxY5xUsiPIp3D1wjHExaaLLJmYjp7UPqeHHs1yGot9l5ntI
         LOhT+NmfWbnu9f/K/urg4HkiqfzfKnWR+MRNGCO24Im/UVTZ7HBnpnlP2PNxYZ8/ocQN
         0ObUyZ23o5LercKd7hjJBy4NYnMWm54x2sSkYaYNH/8iBc5yhdVtkfmGp3ysV1m3klt2
         726uOEss1UrXcxkgZwQpwDODyHlT4ACrUxWyUUkCCImXlTc6OktIDQOU6Znnvcgte1HP
         aI7YIS7rV5+DC3/iF8v6eWxJ59SCYooRm1jwZhHwN0zTWfKJ/qYTCWKVo3+jqtNoz//m
         3r4w==
X-Gm-Message-State: AOPr4FXpNRwrxhxGkGDdrOBrJLrUDsygQR9RVNw/7qUpHD5vGgbh+t1uEGGxtZieZPSSkA==
X-Received: by 10.194.48.7 with SMTP id h7mr32851316wjn.81.1461504953683;
        Sun, 24 Apr 2016 06:35:53 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.35.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:35:53 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292375>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 787426f..6c0b153 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4670,10 +4670,10 @@ static int option_parse_directory(const struct option *opt,
 	return 0;
 }
 
-static void init_apply_state(struct apply_state *state, const char *prefix_)
+static void init_apply_state(struct apply_state *state, const char *prefix)
 {
 	memset(state, 0, sizeof(*state));
-	state->prefix = prefix_;
+	state->prefix = prefix;
 	state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
 	state->apply = 1;
 	state->line_termination = '\n';
@@ -4789,7 +4789,7 @@ static int apply_all_patches(struct apply_state *state,
 	return !!errs;
 }
 
-int cmd_apply(int argc, const char **argv, const char *prefix_)
+int cmd_apply(int argc, const char **argv, const char *prefix)
 {
 	int force_apply = 0;
 	int options = 0;
@@ -4864,7 +4864,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		OPT_END()
 	};
 
-	init_apply_state(&state, prefix_);
+	init_apply_state(&state, prefix);
 
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
-- 
2.8.1.300.g5fed0c0
