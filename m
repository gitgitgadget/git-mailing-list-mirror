From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 79/83] apply: make some parsing functions static again
Date: Sun, 24 Apr 2016 15:39:08 +0200
Message-ID: <1461505148-16164-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:39:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKFw-0001U1-4D
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178AbcDXNjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:39:20 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:34819 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbcDXNjS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:39:18 -0400
Received: by mail-wm0-f48.google.com with SMTP id e201so60588218wme.0
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=9az4Sfu5NQIiErty8oxHwasaAOcT0KsLFocqf+VWjMA=;
        b=AYS0QZ0HbOrqnIye66GwSrQ5/jeO3PjeE7QcTpFnu1tF5p0LMkEdzcXRDML9UMTx8z
         Gmv+wNUAydZb721JMdHl50b5MnGlhJq3KSMqebpgW6sdV99yEYSahGu70wmiHWfVcCJu
         NPNjJcFLuITo85VHa5ERpZMDg+jT2RtGKgeuhhGLezr4qoUw0klMiOViSL4MipwQmx1r
         k6w79Z4Qdp5sUwmQU5HY5tTBRes73er/VzOSZ/0q1g0YX5ROFwPP+lUVi+WEoHyxOw1u
         TWhNa8eAPr+GCF5ZSX++eiWRJfWGaYyWwscDfgDQVnLkHNSBk37qWuHFIz1i56bi+dnx
         PYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9az4Sfu5NQIiErty8oxHwasaAOcT0KsLFocqf+VWjMA=;
        b=VWnURJiyvnn7uK9z400bADjRLV/467bnngHNF3oKusOKSxIgzdXy65rPWI3GiRbrjB
         8xvnCQ9mxzbZ2EPJwNiEQxig47Q/R00dI24gMRtfH8N1d9MepsjParNIC2taeMdgLfQP
         ziDeJLSnuycECSJKSNh8IHWsK8GFXptX3k4GikV/3ReXrYzq9Itsox4pSfnWzrewiKCa
         mmCRl2t9q4ah/MVCpBfv0zJGJuybhd5UjMH2mGx7lFOCYACy2zQqMgpcxfB6oD4Q10ot
         skEGJGYPFWyONtULkx5j3a8PRtnH00JIO5gupblktP0VaJrs0w86d/FAgBIbEJSi+8ZK
         zEhw==
X-Gm-Message-State: AOPr4FViTjUg22xYfNlfoGMuLRRYy2v+Sub9QfYtNdtULOE0PGIhJqBxMGcGL33uG2vd8A==
X-Received: by 10.194.115.196 with SMTP id jq4mr29032044wjb.101.1461505157350;
        Sun, 24 Apr 2016 06:39:17 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id gr4sm18448691wjd.23.2016.04.24.06.39.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:39:16 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292401>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 6 +++---
 apply.h | 5 -----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/apply.c b/apply.c
index 99b7a2d..86e0d20 100644
--- a/apply.c
+++ b/apply.c
@@ -27,7 +27,7 @@ static void git_apply_config(void)
 	git_config(git_default_config, NULL);
 }
 
-int parse_whitespace_option(struct apply_state *state, const char *option)
+static int parse_whitespace_option(struct apply_state *state, const char *option)
 {
 	if (!option) {
 		state->ws_error_action = warn_on_ws_error;
@@ -57,8 +57,8 @@ int parse_whitespace_option(struct apply_state *state, const char *option)
 	return error(_("unrecognized whitespace option '%s'"), option);
 }
 
-int parse_ignorewhitespace_option(struct apply_state *state,
-				  const char *option)
+static int parse_ignorewhitespace_option(struct apply_state *state,
+						 const char *option)
 {
 	if (!option || !strcmp(option, "no") ||
 	    !strcmp(option, "false") || !strcmp(option, "never") ||
diff --git a/apply.h b/apply.h
index 6803259..ba138d4 100644
--- a/apply.h
+++ b/apply.h
@@ -121,11 +121,6 @@ struct apply_state {
 	enum ws_ignore ws_ignore_action;
 };
 
-extern int parse_whitespace_option(struct apply_state *state,
-				   const char *option);
-extern int parse_ignorewhitespace_option(struct apply_state *state,
-					 const char *option);
-
 extern int apply_option_parse_exclude(const struct option *opt,
 				      const char *arg, int unset);
 extern int apply_option_parse_include(const struct option *opt,
-- 
2.8.1.300.g5fed0c0
