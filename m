Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB90F1FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 20:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758104AbcLBUOS (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 15:14:18 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35191 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756114AbcLBUOR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 15:14:17 -0500
Received: by mail-pg0-f49.google.com with SMTP id p66so110878373pga.2
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 12:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=gMcS3zW5/ljlY6O9HyljVsq/fxLzksu+4HxnD2CyL3g=;
        b=cYWVU+v8JsT9aV9KyC18u7Ru5Qp4teg4IMhA/8hr8KOQzNJgFawUUr4ir0KucOI1Gi
         IFzHPoHH+NB+6CgYPn7cCxknpf+nAZmzBHhu5xH8oQAVvCCPQMSBJpPr1sVXdH2nnw8M
         72GTzJiYWEVW83I3c9QYd5hqjHhK4HRHS5pQO2F2Z6GABquwPLG5AFuSTM//cZ/fDWx9
         yAo3kosGGk1JIuam35bwIdi/pQ5aQGrPFN68kGLLqeivyYib2nllodept5yqi7Kahb0J
         K+uhyI/StVNAvVA4JOrdSszXwxkJXy44IS1HSXpj2Hgst1MDxmCyS/CFVSsiQ4c/0vBj
         wVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gMcS3zW5/ljlY6O9HyljVsq/fxLzksu+4HxnD2CyL3g=;
        b=kY9/31KoiiXFRvekIe17/AxKSvt7ABK7yd6hyl5/VVAjC5kx1nW4usYPkQqlGSJM6/
         +sZ5C3FeeTHeOrIkMUHt63w3QZOEVmMGI+YakWzOWeYH3R8N4B0c8TvKN+agKVhzLRAa
         /jPdhbB9+4rmLKY1DKPoRlR08W9K5M5YKxDrSwukRTb4S/nFsvxVyzg8MiEj6ut3Jnj7
         sI5M/f/XQNVRp9fknd6E5SWljJjZ6+fr35dVi6yXrNDKxjUBWrSAJC0O/hBMguMntrRR
         TeXR/dNvtOLYsaaGn1aO52QvouAaIFbhKC2dkI5EV/J7WPEaJbSotPzvCEWtWh6YegRZ
         NEvQ==
X-Gm-Message-State: AKaTC035KGbv8/RTbEw6bkUSkgWcjqLalxZUTRi2OvBwEH/jwwZq4iUXU/aF2H/dlEojfT7i
X-Received: by 10.98.33.133 with SMTP id o5mr45800393pfj.32.1480709122354;
        Fri, 02 Dec 2016 12:05:22 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:99ac:e2be:c532:3e35])
        by smtp.gmail.com with ESMTPSA id q9sm9659869pfg.47.2016.12.02.12.05.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 12:05:21 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] t3600: remove useless redirect
Date:   Fri,  2 Dec 2016 12:05:15 -0800
Message-Id: <20161202200515.3114-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.2.613.g22f2156
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the next line the `actual` is overwritten again, so no need to redirect
the output of checkout into that file.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 t/t3600-rm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 14f0edca2b..6e587f956f 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -709,7 +709,7 @@ test_expect_success 'checking out a commit after submodule removal needs manual
 	git commit -m "submodule removal" submod &&
 	git checkout HEAD^ &&
 	git submodule update &&
-	git checkout -q HEAD^ 2>actual &&
+	git checkout -q HEAD^ &&
 	git checkout -q master 2>actual &&
 	test_i18ngrep "^warning: unable to rmdir submod:" actual &&
 	git status -s submod >actual &&
-- 
2.10.2.613.g22f2156

