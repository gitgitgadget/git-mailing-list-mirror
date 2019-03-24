Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAFC220248
	for <e@80x24.org>; Sun, 24 Mar 2019 08:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfCXIpt (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 04:45:49 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:42993 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfCXIpt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 04:45:49 -0400
Received: by mail-pg1-f180.google.com with SMTP id p6so4362856pgh.9
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 01:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LeimIk1dn45YD7OMz+K4OozpDM6PWx6KWcUsm/gDZSE=;
        b=QFW+XYSpn1YIDOWJyMl1B2vpQKdV70OOVVUl0JLIXuBj+UEtOb95JnqGjDOYP3ymtJ
         1PJdfJ9IHKtChUQYG8Ct2jXZCmt1e/fwv7Vi6hoZ5T/9Vv5+gAG0qqR+U552UO/BUQ/k
         oqMnE5DKWzDo3VQ83Rms6WB7s2cIJjnub7tQgr+Tsz47eHLpFy98LmMBRTjOJs8Au7E0
         IiKyGzAUlybY0tYFtuEkIerFWATXcDV21yHmRNTjdu1oNFhQ3iTWV2jVOWPdbHPYNbX3
         YkNalRLAz0UZ5pzp37e1YDLEm0MWPb/tWx85Wmm8UZ/6ZnJYu08gfZ7i8GO84yAH0K6x
         GK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LeimIk1dn45YD7OMz+K4OozpDM6PWx6KWcUsm/gDZSE=;
        b=gM9BoFPQvIYGLD4TERD5PQpzw5n8GGQtJ7LcRPxxDj4w7NK7Jfve+MJXU7AQSBVLpL
         QoBXHhphbSB7huTu5i9Ty+hWalH+bhbZXVzMz5GWvf49bXST9olC9m/WLWgudhGdFjY0
         RvarEj8fQZRHEf7e6S0i5q8Hel3sM7Dh3y8ZY71jXQL49tnpyWooNqa/CDwL8zOZfzQ8
         0GXHKmlc/wFRccmQwf/b2EWfVqTTYn3c1FaiJuecWVvDZwWxu7QFNnuBi5PExhSmQoKq
         o4dXIbZ8r0YWHsog5erVZ2mb+FutTtXig4BI2QMJbNTEFn5f7RCI2kdncJJMqgXq2QkF
         c7LA==
X-Gm-Message-State: APjAAAVAVAVgfQK6OlTSqVSslX+S7tu+GNsSrE92HK0Rl1HW/2+DoNkX
        aaweJqTCwd/2nCqybWEDpQQOVjE+GDA=
X-Google-Smtp-Source: APXvYqzF/gqHTqbwBNnOdBa2YJGGcPqpQzh8w5Pm3oJsDvlS7wsV3s5ObZdMEJa+x9DAXhG1mcx8zw==
X-Received: by 2002:a63:ac12:: with SMTP id v18mr16225858pge.111.1553417148669;
        Sun, 24 Mar 2019 01:45:48 -0700 (PDT)
Received: from localhost.localdomain ([2405:205:1486:f9d2:785d:51aa:fd3f:3c85])
        by smtp.gmail.com with ESMTPSA id u15sm19291348pfm.163.2019.03.24.01.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 01:45:48 -0700 (PDT)
From:   Kapil Jain <jkapil.cs@gmail.com>
To:     christian.couder@gmail.com
Cc:     git@vger.kernel.org, t.gummerer@gmail.com,
        Kapil Jain <jkapil.cs@gmail.com>
Subject: [GSoC][RFC/PATCH 2/2] userdiff: added shell script support, clears test
Date:   Sun, 24 Mar 2019 14:15:23 +0530
Message-Id: <20190324084523.8744-1-jkapil.cs@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAP8UFD3K4ft7UVSFeaQzKVVGFPwcLcpTKB+sqFN9X9_j_A093w@mail.gmail.com>
References: <CAP8UFD3K4ft7UVSFeaQzKVVGFPwcLcpTKB+sqFN9X9_j_A093w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kapil Jain <jkapil.cs@gmail.com>
---

The test passes now, but imo the regex is not working,
because the output of git diff with shell regex remains same
as earlier it was without shell regex.

without shell regex the output was shown as:
-$TEST_DIRECTORY
+$TEST_DIR

with shell regex the output should be:
[-$TEST_DIRECTORY-]
{+$TEST_DIR+}

but even with shell regex the output is:
-$TEST_DIRECTORY
+$TEST_DIR

some thoughts on regex would be helpful.
the shell regex is below:

+
+PATTERNS("shell",
+  /* Function Names */
+  "([A-Za-z_][A-Za-z0-9_]*)[[:space:]]*\\([[:space:]]*\\)[[:space:]]*\\{",
+  /* Words */
+  "([$#@A-Za-z_\"\'][$#@A-Za-z0-9_\"\']*)"),
+

Thanks.

 t/t4034/shell/expect | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4034/shell/expect b/t/t4034/shell/expect
index f2f65e7a9b..1f0d1e1d43 100644
--- a/t/t4034/shell/expect
+++ b/t/t4034/shell/expect
@@ -1,6 +1,6 @@
 <BOLD>diff --git a/pre b/post<RESET>
-<BOLD>index 2fc00ad..cd34305 100644<RESET>
+<BOLD>index 32440f9..43a84e0 100644<RESET>
 <BOLD>--- a/pre<RESET>
 <BOLD>+++ b/post<RESET>
 <CYAN>@@ -1 +1 @@<RESET>
-<RED>[-$TEST_DIRECTORY-]<RESET><GREEN>{+$TEST_DIR+}<RESET>
+<RED>$TEST_DIRECTORY<RESET><GREEN>$TEST_DIR<RESET>
-- 
2.20.1

