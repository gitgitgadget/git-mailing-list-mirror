Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8A80207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 17:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbdFZRYv (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 13:24:51 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34500 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbdFZRYt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 13:24:49 -0400
Received: by mail-pg0-f66.google.com with SMTP id j186so918560pge.1
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 10:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6rvdRBCQby5ywa4isPLZww9aDcp5B94rlG94xzaQMy8=;
        b=s9rYWwN+a+6mPZ1M8KoFgXCtQpYnqCLwBKl5+rWpj3qnwn4vy1uM9H+nwPfFpMX7K3
         ruTU9gYpNgOPOjXGCkFTAi0LXgVy1QAwoaywh+cnx9O/lS6WSc0k3Yb2hZmNeS+UN+IC
         TRrayhGo9g9XDSPlLFFMBikArRbP3+tWXTAYgImJ6P3jAeezCkw+EAwl0HQqhB4KvVBx
         SV4pWWv7Y1IKPb1LGWIc1Hq0N0QL0nwhI73OEMOfWZ9X7R3tAfWdkLo3VyAyPl/IsqzY
         yGH+DZGnUsLS7Fq/vOTjWSq+9VUeAIDXdWXgppupcwedymL4sKr+Tn2lYxsMRUEvIg3/
         QLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6rvdRBCQby5ywa4isPLZww9aDcp5B94rlG94xzaQMy8=;
        b=Ci+UQzpcTLC+h9ojJLVzWY4WhS496ZNpbz2rW1FGdcuv+DHXla6xPlIxjJxXc/+7dR
         7q8GOcb/L0JmZ2XqY7hX8j+7qiHanSEYw6veCeRtYsoJ0/3kfLdz7JfhhSs3LfuOa2tU
         stuf5k2T5IlqGPXT9XFrATzuB3lBd5LNTJ5ODnTeEyht2nSSjokOX3x2FVwQsANHizIC
         MojanPK+bXj3Qms6EOgRRW0MHoV9hM8y6OllFY63o2ODpGy5xtZNAwTtbelru5xFLaw2
         6AZ9k/xUfqbETFHER57OtT5h6Q6/dalQjuP4lMeAriaElh3AR53FwhE7RZiHn6cEvK9I
         RIgA==
X-Gm-Message-State: AKS2vOxOO1LIUIc4iyXoFQuwb0u3YRPMgZ84W/SXY/qP+CA4G6SBlgF1
        sEkeOxaRIwmTww==
X-Received: by 10.98.10.2 with SMTP id s2mr1140333pfi.121.1498497889104;
        Mon, 26 Jun 2017 10:24:49 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7084:b510:f8f1:caed:3b9:d590])
        by smtp.gmail.com with ESMTPSA id u9sm1163281pfg.127.2017.06.26.10.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jun 2017 10:24:48 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH/RFC] commit-template: improve readability of commit template
Date:   Mon, 26 Jun 2017 22:54:33 +0530
Message-Id: <20170626172433.19785-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* Previously the commit template didn't separate the
  distinct messages shown. This resulted in difficulty
  in interpreting it's content. Add new lines to separate
  the distinct parts of the template.

* Previously the warning about usage of explicit paths
  without any options wasn't clear. Make it more clear
  so user gets what it's trying to say.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 I've tried to improve the message specified in the commit. Hope
 it works correctly.

 Local test passed.

 builtin/commit.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 8d1cac062..0a5676b76 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -841,9 +841,11 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				  "with '%c' will be kept; you may remove them"
 				  " yourself if you want to.\n"
 				  "An empty message aborts the commit.\n"), comment_line_char);
-		if (only_include_assumed)
+		if (only_include_assumed) {
+			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", ""); // Add new line for clarity
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 					"%s", only_include_assumed);
+		}
 
 		/*
 		 * These should never fail because they come from our own
@@ -877,8 +879,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				(int)(ci.name_end - ci.name_begin), ci.name_begin,
 				(int)(ci.mail_end - ci.mail_begin), ci.mail_begin);
 
-		if (ident_shown)
-			status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
+		status_printf_ln(s, GIT_COLOR_NORMAL, "%s", ""); // Add new line for clarity
 
 		saved_color_setting = s->use_color;
 		s->use_color = 0;
@@ -1209,7 +1210,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (argc == 0 && (also || (only && !amend && !allow_empty)))
 		die(_("No paths with --include/--only does not make sense."));
 	if (argc > 0 && !also && !only)
-		only_include_assumed = _("Explicit paths specified without -i or -o; assuming --only paths...");
+		only_include_assumed = _("Explicit paths (<paths>) specified without -i or -o; assuming --only <paths>");
 	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
 		cleanup_mode = use_editor ? CLEANUP_ALL : CLEANUP_SPACE;
 	else if (!strcmp(cleanup_arg, "verbatim"))
-- 
2.11.0

