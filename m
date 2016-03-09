From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 37/48] builtin/apply: remove whitespace_option arg from set_default_whitespace_mode()
Date: Wed,  9 Mar 2016 18:49:05 +0100
Message-ID: <1457545756-20616-38-git-send-email-chriscool@tuxfamily.org>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 18:54:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiJ6-0000CS-Ti
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933765AbcCIRxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:53:54 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34878 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793AbcCIRxl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:53:41 -0500
Received: by mail-wm0-f49.google.com with SMTP id l68so190247696wml.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HxyHy10sux19flSZqTNDUVwzoVILCbrGpL7xe60ozzc=;
        b=JExlJYEpF9NFrakscYWfQ0q8C7w1K7OwjfQLL5e2sUd/GHYHwkpLk4G0MnSx66/3Ky
         5ovqVr3RGv/xISYK508sPxOUy8I+EohxZbs6AgTDKc3KB0m84UfDa2pOZcGw3aiRxyS5
         SG5C2a79aMp7BhKmXQ+Z1X3JXKt4HTAAhJmJclhC5ePNYTHQtHmKDiAaiItE7HtpWR5J
         wQq1wqOqObfe+olRFU2+ev5nNt/0fhad7EWUg2aZ5OlLARPoF6bTLZ4V42kQHXRQJ1Ja
         MmkKo/v6Hz0Tb+rw3ZdGoUoqMWfrmUbNi4fvn0p3LcxSiQi0z7LuDy1GtDxcwMndPTfW
         oh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HxyHy10sux19flSZqTNDUVwzoVILCbrGpL7xe60ozzc=;
        b=FCoUMvJJngLApDSob0UQBm95ayQtPSxCky4OahQmHDWG5sh/G9FnpXmnR79MkQN0dg
         ZGOjjxAdevIz40ParcapNpTUQmiSov4U5a8QOQUjsFCKhsu/FjxIDHH6F4Ai30e27/K+
         XsiFcXrYg4dXk2PO4y1Tvq38EmuXPTvNrs5TABNavWj5wP5lS8+jssj7TaCjahIMu7Q8
         heHe5LDN0Zk14pkQpFRBxWBvwcKVcwraEZJhgmCQpxdZrWdHoA4+FFCYxGt5ECrKcKTN
         kgjM5rrhD1jmactpu0L88LH5tDhzLZoNzhZI8Y4BexK0NiRkOjxB5n4xcjbjtx1IX74n
         Z93Q==
X-Gm-Message-State: AD7BkJIhCrlbciQJM3SMcI5Pwc7ssHmU91tETpSs1vTN1TKqQUd0RYK2LX28FH/A2+M+jA==
X-Received: by 10.194.23.37 with SMTP id j5mr35327037wjf.171.1457546020282;
        Wed, 09 Mar 2016 09:53:40 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:53:39 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288526>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 63eb031..3c00551 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -148,10 +148,9 @@ static void parse_ignorewhitespace_option(const char *option)
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
 
@@ -4788,11 +4787,11 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
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
2.8.0.rc1.49.gca61272
