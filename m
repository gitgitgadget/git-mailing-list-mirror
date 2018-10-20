Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A584B1F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeJTUuA (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:00 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44816 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeJTUuA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:00 -0400
Received: by mail-lj1-f194.google.com with SMTP id v6-v6so33058633ljc.11
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QXrvDded2crQ+Tv+c2Sq/tF+MIm3KDjG0ehJj2ez5v8=;
        b=cxH5m3eBJrk3N0Aw+mXdDBJ2ksIiTlFI/6P9QrSsptlJTcCGhdio8yRf1y29OpvTmw
         cK0FnPABEm+k06p4L0HeC+DZvXaHqUoRrpbfnkdtC9AU8R0Al/r6Hpb6v14i4LxXUlsv
         o9UIqIUbkpbVRClnSQoh+v4kAnyrC4OTjlglgizNCY/fOQwNQ4wn3Z3MSFZftiGYxI0+
         MpeTCyIWlkvqsH75CMXkV+WRMBKkbrGN1wTD+PU+intEaf25r5F3LaxCKleJkoDKY/sW
         NdshR7GnTYSsiP6x33FkcfTfZmbDruTz+zZWgg6XIvJh2ThbHHDK4zCptFdxBJmAgAd7
         VPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QXrvDded2crQ+Tv+c2Sq/tF+MIm3KDjG0ehJj2ez5v8=;
        b=nmEaa9QLAPK4rajZHWTw3dIRHllOIaCOHB+69DBCeo4saxbyA2YbwB03VMJ8T57zDW
         v9Sy9vkccFimCUTXgLzw73sfADGwdjw7N+ZQGql5eOhcWxDVywxwO6Ady1okhSadJskn
         gT1TtPJDzdMzebAlsMlG9pvqp9HyfYO4y3AoAluzuFZe8OVtAS0fY8CtWsXeNS1xMyZX
         +tIvNSWHRFhHWmlfIuu5VwJF6GU7cLM99ot6sytA5ep6pGkiLXThpmxpiB3tOBdpS0VG
         uVcDD/8s0xP4kGNaO11mDcI2as0ttzC+w0Zgi1MEVfO30iJ1nwA7RdwL+DKkzTihOte0
         jdsw==
X-Gm-Message-State: ABuFfoifRAKz/M6Ka4FkszsHAop9hQNkXK5NEwQrzMkG/9mL/UY9CKPd
        o6YeMsPoPAZbfNSK7ZD8AwTlp4FV
X-Google-Smtp-Source: ACcGV60MzIhJXEEtEbZ5DLdRcqtKiu7LG8RpZFdaSVZJvtBaKvwB0Vb5h6Di0ReuWI3Kv8sf+hkbVw==
X-Received: by 2002:a2e:9615:: with SMTP id v21-v6mr25031200ljh.150.1540039178255;
        Sat, 20 Oct 2018 05:39:38 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.39.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:39:37 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 28/59] config.txt: move i18n.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:17 +0200
Message-Id: <20181020123848.2785-29-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181020123848.2785-1-pclouds@gmail.com>
References: <20181020123848.2785-1-pclouds@gmail.com>
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
 Documentation/i18n-config.txt | 10 ++++++++++
 2 files changed, 11 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/i18n-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index da97097805..ec0f4e2161 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -600,16 +600,7 @@ Environment variable settings always override any matches.  The URLs that are
 matched against are those given directly to Git commands.  This means any URLs
 visited as a result of a redirection do not participate in matching.
 
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
+include::i18n-config.txt[]
 
 imap::
 	The configuration variables in the 'imap' section are described
diff --git a/Documentation/i18n-config.txt b/Documentation/i18n-config.txt
new file mode 100644
index 0000000000..cc25621731
--- /dev/null
+++ b/Documentation/i18n-config.txt
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

