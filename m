Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F43C433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 16:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242911AbiCNQLt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 12:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiCNQLp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 12:11:45 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF183E0C3
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 09:10:34 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q14so24816189wrc.4
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 09:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dHJAh2wSOh3GaTUQruWHP7hWq66tHM98xal7cz9L1WY=;
        b=aQkX0YNrVYXzP5v/GUAxfLm+vZWO4sh74cMFLEUsNRZbYPnK7phWKdyS2C6E/MqN+R
         +J2uv6KHc0PS/Q5hHSJR84tPAyogjvskeosM7apa0tuv9xgSFAlek7xz7kH6Msd+V994
         a25LT6CbOIK0umw3KNxPp22HJi8y0NpS8iJYLRl5U7Ed44EU2lmAiBYriBmzr6DX8kxt
         ziif0aMwjXtDYR306f3QnR1wMb17Bczk0TiP6z9YnbGUDO7h44lNX1NwWIqWS4VdD0dM
         DKQbzCEfzY/9H0S+u9Vi8Lm0GTXt25/i26M7mmkUhponYh0bPDFGrlitvm8HEddoSuwg
         Drsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dHJAh2wSOh3GaTUQruWHP7hWq66tHM98xal7cz9L1WY=;
        b=h/4Z0qeVXH8VgrTX7HWbK9qLEDiHLed++NhRTbK/pFcZl4/deJ/impH5ni7wNzjgeT
         Je6U2RYnArWOXM92cA6DbJSnyrjT3SxyzzlYmPxiXCQGBHEL7Xk781P5RQw5RPsYkkud
         dq3NldH2TyLye4AF5PMh4WKp1NaxTCMQrZuwzW1zzScfTt3LgFsoWxCpN/UitXN/haPk
         3u1ASgt6SlY5hkVcGhmkq6sLuP/wEXGACWpDwbUh2DVbq1yJJg9ft6OlAJUAj5vqjhiY
         pP4GAJWgM6iMCzU28gcR2VsPsHHfzerN57Ad4gcedJGlV4m+LB4NUvw3Lor3PzIrSthy
         mGIQ==
X-Gm-Message-State: AOAM532SgP9fRp3ZPXbfWTCK3qGlXNQvczgE6VQ18I02cKtAJ0F6AcKO
        WjF5Kp0G62/k2UrN7KZGjkeTv5OV1Qs=
X-Google-Smtp-Source: ABdhPJwVVw2VuyPqfocdjIIkY3vrSxKtTGkGTQSTSzTATtgU3uryPP1QZ4m6b6d/AtxX+Kr0jF5asg==
X-Received: by 2002:adf:e104:0:b0:1f1:d891:5aa6 with SMTP id t4-20020adfe104000000b001f1d8915aa6mr17156065wrz.582.1647274232818;
        Mon, 14 Mar 2022 09:10:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8-20020a05600c068800b00389bdc8c8c2sm14306436wmn.12.2022.03.14.09.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 09:10:32 -0700 (PDT)
Message-Id: <7206ef8dd8ab088feab841c5574d486b6f19af5e.1647274230.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
References: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
        <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Mar 2022 16:10:26 +0000
Subject: [PATCH v2 1/5] reset: revise index refresh advice
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Update the advice describing index refresh from "enumerate unstaged changes"
to "refresh the index." Describing 'refresh_index(...)' as "enumerating
unstaged changes" is not fully representative of what an index refresh is
doing; more generally, it updates the properties of index entries that are
affected by outside-of-index state, e.g. CE_UPTODATE, which is affected by
the file contents on-disk. This distinction is relevant to operations that
read the index but do not refresh first - e.g., 'git read-tree' - where a
stale index may cause incorrect behavior.

In addition to changing the advice message, use the "advise" function to
print advice.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/config/advice.txt | 4 ++--
 builtin/reset.c                 | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index c40eb09cb7e..971aad2f237 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -69,8 +69,8 @@ advice.*::
 		merge to avoid overwriting local changes.
 	resetQuiet::
 		Advice to consider using the `--quiet` option to linkgit:git-reset[1]
-		when the command takes more than 2 seconds to enumerate unstaged
-		changes after reset.
+		when the command takes more than 2 seconds to refresh the index
+		after reset.
 	resolveConflict::
 		Advice shown by various commands when conflicts
 		prevent the operation from being performed.
diff --git a/builtin/reset.c b/builtin/reset.c
index 6e65e90c5db..a420497a14f 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -525,9 +525,9 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 					      _("Unstaged changes after reset:"));
 				t_delta_in_ms = (getnanotime() - t_begin) / 1000000;
 				if (advice_enabled(ADVICE_RESET_QUIET_WARNING) && t_delta_in_ms > REFRESH_INDEX_DELAY_WARNING_IN_MS) {
-					printf(_("\nIt took %.2f seconds to enumerate unstaged changes after reset.  You can\n"
+					advise(_("It took %.2f seconds to refresh the index after reset.  You can\n"
 						"use '--quiet' to avoid this.  Set the config setting reset.quiet to true\n"
-						"to make this the default.\n"), t_delta_in_ms / 1000.0);
+						"to make this the default."), t_delta_in_ms / 1000.0);
 				}
 			}
 		} else {
-- 
gitgitgadget

