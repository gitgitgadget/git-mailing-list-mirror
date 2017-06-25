Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CE1C2082E
	for <e@80x24.org>; Sun, 25 Jun 2017 18:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbdFYSVb (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Jun 2017 14:21:31 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36353 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751337AbdFYSVa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2017 14:21:30 -0400
Received: by mail-wr0-f195.google.com with SMTP id 77so25660277wrb.3
        for <git@vger.kernel.org>; Sun, 25 Jun 2017 11:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9YdmQUOI4WpjYqTCMw+DUIaVeiyoiUwTO94yxckoFH8=;
        b=HUWPHJ+cRaI/qQEHSksARvcmbXS7y+2dSMFvqpCCAX5+FqN4k+FcyG4r6LHzOqeDDi
         oflB7hxWR6wSPU097bkYk+9w3HrAd7mhgIei9d7KMJDkkY98nOkcM0HS20JyujqJbO7+
         FT7zzQn5/OJC/Ku4SuL7j7UjEcDYYkGDoTZA1usg5YUW1qmNSNm7J21PE8+iA3VZuOE6
         MXQEzTDmq8bB72BaCO7ZMhy2eVmVGm9HQVenyoApYA/JvISoGFJdfESL58c5IUUAS7Dg
         /M+ISgFFB6pAOUR0R4djyDQJvE7Gj5hP7dh9CVYpPWH2IxwcW0PVkLbyLlJbQw/dsAKr
         zM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9YdmQUOI4WpjYqTCMw+DUIaVeiyoiUwTO94yxckoFH8=;
        b=NXOiLt60OjbjXKXtsfEzjtAux8on2XHMfLCPpihf/ooiWfOj3q3d8RMJE72OA5jgjV
         cqrrQCjH3R7Mf58oul3hYBnmjAmn/U84MZMRXy+nWE1B62zaARopKVe9tSJv5PbtLZd7
         2Ddaod4Kllkfjw0E1KO4o5U8ifjurjpXjwDaxVpUAN7MGcoLOjGrq8hQgOtFWJB8+HCv
         rl4sW0iiI9u2c2P8MgO1nRv8bEd/UvuQIyFcwQnyookWVduoN8YNCjeNYuOHteNXvDxl
         ijtQf/TZFNWyHF+mv1EWGCGca7adMCwHhg27I9Dd79BMAaU09i1lBLolFqRWkqK/evC5
         7jNw==
X-Gm-Message-State: AKS2vOwg1Au2sbnVnlSO9e59iIyLWCxDRZN+DxhZ0faDpBDH35xlwa4r
        stCRhwTVgMpGWzoF
X-Received: by 10.223.134.16 with SMTP id 16mr11439004wrv.83.1498414889107;
        Sun, 25 Jun 2017 11:21:29 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB71F6.dip0.t-ipconnect.de. [93.219.113.246])
        by smtp.gmail.com with ESMTPSA id u13sm13313926wmd.22.2017.06.25.11.21.28
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 25 Jun 2017 11:21:28 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: [PATCH v6 4/6] convert: put the flags field before the flag itself for consistent style
Date:   Sun, 25 Jun 2017 20:21:23 +0200
Message-Id: <20170625182125.6741-5-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.13.1
In-Reply-To: <20170625182125.6741-1-larsxschneider@gmail.com>
References: <20170625182125.6741-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 convert.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/convert.c b/convert.c
index f1e168bc30..9907e3b9ba 100644
--- a/convert.c
+++ b/convert.c
@@ -597,12 +597,12 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	}
 	process = &entry->subprocess.process;
 
-	if (!(wanted_capability & entry->supported_capabilities))
+	if (!(entry->supported_capabilities & wanted_capability))
 		return 0;
 
-	if (CAP_CLEAN & wanted_capability)
+	if (wanted_capability & CAP_CLEAN)
 		filter_type = "clean";
-	else if (CAP_SMUDGE & wanted_capability)
+	else if (wanted_capability & CAP_SMUDGE)
 		filter_type = "smudge";
 	else
 		die("unexpected filter type");
@@ -703,9 +703,9 @@ static int apply_filter(const char *path, const char *src, size_t len,
 	if (!dst)
 		return 1;
 
-	if ((CAP_CLEAN & wanted_capability) && !drv->process && drv->clean)
+	if ((wanted_capability & CAP_CLEAN) && !drv->process && drv->clean)
 		cmd = drv->clean;
-	else if ((CAP_SMUDGE & wanted_capability) && !drv->process && drv->smudge)
+	else if ((wanted_capability & CAP_SMUDGE) && !drv->process && drv->smudge)
 		cmd = drv->smudge;
 
 	if (cmd && *cmd)
-- 
2.13.1

