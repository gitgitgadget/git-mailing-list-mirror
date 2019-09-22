Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 550611F463
	for <e@80x24.org>; Sun, 22 Sep 2019 12:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbfIVL77 (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Sep 2019 07:59:59 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37841 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728742AbfIVL77 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Sep 2019 07:59:59 -0400
Received: by mail-lf1-f66.google.com with SMTP id w67so8026672lff.4
        for <git@vger.kernel.org>; Sun, 22 Sep 2019 04:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qNQapSheaOYNP05xynpSBzMC/vrKqwxSU/iGbX33/gk=;
        b=WcVqMKuTKraSrADtwFM4YRpt/I0ta/bkJY9oHDInRUS9j+zymkt1ATaH6wyB2W9byu
         fZZ6NuNLmNDmJJqLBSr6rEb1HIYFH9SUU9bkhjZNLHfqDqMXTU+W8xjQ9gkxbBaIjTtF
         mhS1V6T6Jhsqf/1SunW+a6FXv1MnRdth0jAd+7N7M8NWIwXmxZ9y/enQ/NyTfofEvElz
         g9IiPrguWDF+xluq15fNw9TyeBjOGYXsZpE3Dz2FHEN1qFHWfJm/zuxQFHjbyCKEsBeb
         abVvKSs4AolM7IYuRbXHYwgdp1trYQN14I4sVAyyE3mHoPqMb52GyF9rsZlCUif9TiKw
         2V3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qNQapSheaOYNP05xynpSBzMC/vrKqwxSU/iGbX33/gk=;
        b=rWfRUwlZx4Vs+budTwc2sZ8ywfXwn3lmHqtJ0sQsD29cuyMh5GhT5LqXuycE+DDUDA
         0XUYx5TWTVoK3zCk0yODbsxbR1U3lRRl22G0ybxeIFBIg7Ex85LLwKwpLaSF3e0gL1MY
         tFfkxAuHfUcS9V+E9/gWqK7BrsfDyn/Vt6+7kHOcNQm7OXs2ArAbSQ9uNo38neu6ql10
         vL/AT4Sl5cdJaM8UZn1L//Ae0YdcLlEQ92n6RoX5OZDtMQgdUT8geUF1XslYVgSlqwzm
         WSG94KRx+DJLTLnOGXZrgVCOT0PmwOKU8fz9v+KwnSFHZYlfd0e+1iNLvfep8Gx6cUmw
         p1uA==
X-Gm-Message-State: APjAAAUOeGAxhQhiAfYmOImunqs5dPQKaJiDk4s3RxWA6atdfFHfyywR
        wC/NXybXqI4AkVoaBDLGDLeSkVSq
X-Google-Smtp-Source: APXvYqzEX6HfLEtlh8tlOs5rLGhBhPeBJGm8iMCPmtAQ6Oui18M96FFZxg5TDim0SdgGWd4MBNWKEg==
X-Received: by 2002:ac2:44b9:: with SMTP id c25mr14756920lfm.112.1569153595544;
        Sun, 22 Sep 2019 04:59:55 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id q24sm1622413ljj.6.2019.09.22.04.59.54
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2019 04:59:54 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 4/4] user-manual.txt: render ASCII art correctly under Asciidoctor
Date:   Sun, 22 Sep 2019 13:57:59 +0200
Message-Id: <774a3ee180401fb1074f07ae3ae3d55494646eb0.1569152396.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569152396.git.martin.agren@gmail.com>
References: <cover.1569152396.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit is similar to 379805051d ("Documentation: render revisions
correctly under Asciidoctor", 2018-05-06) and is a no-op with AsciiDoc.

When creating a literal block from an indented block without any sort of
delimiters, Asciidoctor strips off all leading whitespace, resulting in
a misrendered ASCII drawing. Use an explicit literal block to indicate
to Asciidoctor that we want to keep the leading whitespace. Drop the
common indentation for all lines to make this a no-op with AsciiDoc.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/user-manual.txt | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 919c214b71..06bd8994ee 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1831,15 +1831,17 @@ pull from that repository.  So the flow of changes, in a situation
 where there is one other developer with a public repository, looks
 like this:
 
-                        you push
-  your personal repo ------------------> your public repo
-	^                                     |
-	|                                     |
-	| you pull                            | they pull
-	|                                     |
-	|                                     |
-        |               they push             V
-  their public repo <------------------- their repo
+....
+		      you push
+your personal repo ------------------> your public repo
+      ^                                     |
+      |                                     |
+      | you pull                            | they pull
+      |                                     |
+      |                                     |
+      |               they push             V
+their public repo <------------------- their repo
+....
 
 We explain how to do this in the following sections.
 
-- 
2.23.0

