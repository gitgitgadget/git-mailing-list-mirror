Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23E691F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbeJ0PEf (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:35 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37282 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbeJ0PEe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:34 -0400
Received: by mail-lj1-f194.google.com with SMTP id c4-v6so3111815lja.4
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E8im2AWO3PkP4LFNtmSQdnUqLhYqgZ7AiD/ofFFXNkc=;
        b=sZG+nriA1FPf2n+FhW+h1J/ox6SNURVW/UEimHWomLzY+QAsS99f2fc/V39SxbLo/N
         opdF7PEvFap9SDXaN2rBLdAWD0Isn994Vxgj8OkXH0SEpwslBq0m7Q/SctkyqxoUr8LN
         c7QgxrVD3FwuZwoy6YHDNnV4dt051hMhVN8hffXnw5vGBJhQMvMz1O0n1GjQlhp0R7yC
         HUHPC7v4MqBSFy4flhXYC4PKYclqEbjNzEc+x85QWmuJEGpDbCFh0lk+OjL+PFZk9m4b
         9SjHlVqtJ6c7IvTM25H+5qlfuTlaHXfXnuvXjMRNaLRZ1xFWTFi+TT2t9vS7k0V1uwJe
         /fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E8im2AWO3PkP4LFNtmSQdnUqLhYqgZ7AiD/ofFFXNkc=;
        b=WYptB5GS0dF5djJMimWPBJA1GhATJbSWuBZ/GJ14vkE1INtzNtoOBLNAGoEEntajVn
         /F6CU4vwGT/echI9YgG/3sSWrRA5lRPeBUfYwAWweS58gvlxgl+VSVf/hl6suDPYnAjy
         jrCoK0mMkuS115/pl6hqTaRaEcloC6kubAJB0FwMPTOV9uzbZpaHDpkS/5z9PQ0SGytO
         PpZNW0qbUEdUhke0g6+DTG3IfJVvZqCopdXWyvnMSlpUrhKmV8865RNm8v8h8I1LjC4+
         iUA1Pw48Hx+7L89/P+wQK6A9vNQ8g+IKjjObntbridhsSbkqKO6tACHLsev87qn9T01S
         WI+w==
X-Gm-Message-State: AGRZ1gLnmn+J7s3ikghdOHeEqXZ9JxTGOOIyIjst0vQrpmVfLgNvoCxK
        bVqiBEbV0ayCLsS6sGHSaiWDBiIR
X-Google-Smtp-Source: AJdET5eUHTD1bNLsRaUEizdlZou3s448Xpbt6004yg46cxOF1Du6T0FivqYZ24QP/x7r9vHiVscInA==
X-Received: by 2002:a2e:8e95:: with SMTP id z21-v6mr2966565ljk.166.1540621478927;
        Fri, 26 Oct 2018 23:24:38 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:37 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 36/78] config.txt: move i18n.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:09 +0200
Message-Id: <20181027062351.30446-37-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181027062351.30446-1-pclouds@gmail.com>
References: <20181027062351.30446-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt      | 11 +----------
 Documentation/config/i18n.txt | 10 ++++++++++
 2 files changed, 11 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/config/i18n.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 11194e1851..a44e717f30 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -351,16 +351,7 @@ include::config/help.txt[]
 
 include::config/http.txt[]
 
-i18n.commitEncoding::
-	Character encoding the commit messages are stored in; Git itself
-	does not care per se, but this information is necessary e.g. when
-	importing commits from emails or in the gitk graphical history
-	browser (and possibly at other places in the future or in other
-	porcelains). See e.g. linkgit:git-mailinfo[1]. Defaults to 'utf-8'.
-
-i18n.logOutputEncoding::
-	Character encoding the commit messages are converted to when
-	running 'git log' and friends.
+include::config/i18n.txt[]
 
 imap::
 	The configuration variables in the 'imap' section are described
diff --git a/Documentation/config/i18n.txt b/Documentation/config/i18n.txt
new file mode 100644
index 0000000000..cc25621731
--- /dev/null
+++ b/Documentation/config/i18n.txt
@@ -0,0 +1,10 @@
+i18n.commitEncoding::
+	Character encoding the commit messages are stored in; Git itself
+	does not care per se, but this information is necessary e.g. when
+	importing commits from emails or in the gitk graphical history
+	browser (and possibly at other places in the future or in other
+	porcelains). See e.g. linkgit:git-mailinfo[1]. Defaults to 'utf-8'.
+
+i18n.logOutputEncoding::
+	Character encoding the commit messages are converted to when
+	running 'git log' and friends.
-- 
2.19.1.647.g708186aaf9

