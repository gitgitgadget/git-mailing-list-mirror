Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F53C1F461
	for <e@80x24.org>; Tue,  9 Jul 2019 23:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfGIXJF (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 19:09:05 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:54088 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfGIXJE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 19:09:04 -0400
Received: by mail-pf1-f202.google.com with SMTP id 191so126803pfy.20
        for <git@vger.kernel.org>; Tue, 09 Jul 2019 16:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=nWgNDSp+xcVVbY1rq659H+vMaycRlPjHLA5201hcSlo=;
        b=wAvVl6KwU/077Ts3pyVZ8SROQXDUzA53Q6cPPhx506Ei3hPlVScwqxPII+O91C21g5
         drqzY7Zsj2BwNeShnMX7Cs2Km0gRIhBIIK2FQAtOOXP6MMDFaymH+zyivf6r7eoFBF5R
         70zsagwc6c/qUo70422j2fq90ZpO6pgTMi/REEdBg7ad9kUAxqikjaZ31VJa09056OVn
         TNRZ/hNoBHnyzOWAsYmKCwXyBXxrd/6y7g2RnvWBBdlK0YUfqnRWJhR8yaEj+tLDPhmk
         f66vWY++M27bt/tI/1bfyfLJ8RcOhcdxvCsHzu2BGqP0rDUztEt+/GJhIw4Xl8x7y7SN
         R+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=nWgNDSp+xcVVbY1rq659H+vMaycRlPjHLA5201hcSlo=;
        b=qQ2AILznyrBbwytwIjsPz/9jMjDzyjGgYKJT+YqBMWojWPhZpruw3eU0Ard2jUIzgy
         fxtdEsD64Otxioewu6eJsU+d9qMX5+Mk3U1KWBZ8E14Te6pozlsYpf/Dd472mQJieMzN
         UVl6LBIwTkgtK7NmQpWL7s5sz5ajh14c9BgMmH/4V72Fq6oZgZRyIeiE09Pm+EZuu9Dg
         2MxCiAz3l61aC5O232Z2EWDzTd0yALkDe+u+8wbQmmtd+EBvySNE3DgYU3NO4w2v5vq6
         4aj7orFyvAOybhIb4udE26w4pBNY7SBNAr4+u3Yot0W0OH2g06JB+QAKh+9b7InHqQG3
         O7LQ==
X-Gm-Message-State: APjAAAUQxy5Ws7T5ZaNwsZa5xkoM4srGcwWxyzllqKEDZeZdmzYf3joX
        ktgPIL12aB+MaXB1WBHvUsjleLb+CzTaBHviD0bMhPuSDQH0dl4cFK2ztv282AP3ZcBD8OK8s3M
        ygh4AnaGpre61jO2Vus7Z3kFs0pxiP4LAiBznMM/LasT4Bp9KuBLTpI2aOMQsZhs=
X-Google-Smtp-Source: APXvYqzW/6wZf7lhNYM2mQlWkio5+3JTn9jYkYz8JW58Lb1NW3+ExvrPwi42WGuYVM4+dbRqKM/yS/1kEGnAnQ==
X-Received: by 2002:a63:124a:: with SMTP id 10mr2192020pgs.254.1562713743776;
 Tue, 09 Jul 2019 16:09:03 -0700 (PDT)
Date:   Tue,  9 Jul 2019 16:09:01 -0700
Message-Id: <3f950d9fd772897edc02e9258267759d4244c1f8.1562713651.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH] trace2: correct trace2 field name documentation
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Correct the api-trace2 documentation, which lists "signal" as an
expected field for the signal event type, but which actually outputs
"signo" as the field name.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
This patch has been split off from the "Add a JSON Schema for trace2
events" series. The documentation discrepancy was discovered in the
process of testing the schema validation in that series.

 Documentation/technical/api-trace2.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 23c3cc7a37..fd1e628944 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -668,7 +668,7 @@ completed.)
 	"event":"signal",
 	...
 	"t_abs":0.001227,  # elapsed time in seconds
-	"signal":13        # SIGTERM, SIGINT, etc.
+	"signo":13         # SIGTERM, SIGINT, etc.
 }
 ------------
 
-- 
2.22.0.510.g264f2c817a-goog

