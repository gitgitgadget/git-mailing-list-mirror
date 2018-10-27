Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6060E1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbeJ0PEA (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:00 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44790 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbeJ0PD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:03:58 -0400
Received: by mail-lj1-f195.google.com with SMTP id v6-v6so3084128ljc.11
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S93iUWR5Uw0yWDycim3Foh3fsn/aG104t2zLA9QuxK4=;
        b=jOljD0NjNqVxH+4NxF+BAuK38bfI/9Ot4KIQnq6fag+uNWs9Ed9NYl8VReqe1admrF
         zv8XnYq1SvoQfn57WcxO7Mr9jeh75xyyTnqm/wMmFsSTEtnm3yZqwhnW3u2g6qAgjYmJ
         OtjGMZf0rhGMQwUNf3qVl0Xb69LGWrR2UyykzdxPZ5y1CXnQg4yYAMR5lzzow5es53St
         vSYe2ZDbUSiXQMfF0GZA7xETspmQ/PKl+22NiW+BbfBhlkFO6DzYlkYXqQOQJCP/mk5x
         O6lJYbLQS6Jqs519rwGKMstMVwSCUyfTLgN0GJa9N7PpqggTMqHWtBotyh4GRaCZILej
         oAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S93iUWR5Uw0yWDycim3Foh3fsn/aG104t2zLA9QuxK4=;
        b=BxNgASnb5bp6pUwR/teib143Azc0TT2iZpxU9w5mFchPbEkwbpzxwONyzwDyfNo05Y
         UTKHFMaU6zCPfW2tWto9mcqwL4IniJ6bz+gHtTtvYai91kXCxCAZ6fM4JcS4NiI2akHV
         6A9zcTJgdaPe/DHcGxQ9a5JllDuDw5ONaIFt+P5R1VpXtX9YsonAP9dKoDE7kxiXYxQW
         SarRp0Mc3JBNZrN6Un4Kx+W8wgBtS8Vt2XNXndyhYig4vjXxchQXC1eEmedvHzX5obHE
         XPeLihARlFk6mg0GmUOmIfhZeGhirDSnmXnTfSmwxyj6SyRRZd3IEm4Co3iFKy3OqKBS
         xNZg==
X-Gm-Message-State: AGRZ1gKZa/nFMxBYoFTMmMdOvvaih6HtlGSUTT1LlB7Jau8tx2V0T3l4
        L66N6+NNdHuVKGZZYIQVmVFK9v0i
X-Google-Smtp-Source: AJdET5eKyABMSUM5LF7m6kZSoRiId9AFxt5Kob3cuIzgfcwnnQfqynJdzBk+JfekmDr9tRMW21nYag==
X-Received: by 2002:a2e:5d8f:: with SMTP id v15-v6mr4468108lje.86.1540621443029;
        Fri, 26 Oct 2018 23:24:03 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:02 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/78] config.txt: move am.* to a separate file
Date:   Sat, 27 Oct 2018 08:22:39 +0200
Message-Id: <20181027062351.30446-7-pclouds@gmail.com>
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
 Documentation/config.txt    | 15 +--------------
 Documentation/config/am.txt | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/config/am.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f207cae90c..5e0f76fc6e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -295,20 +295,7 @@ include::config/add.txt[]
 
 include::config/alias.txt[]
 
-am.keepcr::
-	If true, git-am will call git-mailsplit for patches in mbox format
-	with parameter `--keep-cr`. In this case git-mailsplit will
-	not remove `\r` from lines ending with `\r\n`. Can be overridden
-	by giving `--no-keep-cr` from the command line.
-	See linkgit:git-am[1], linkgit:git-mailsplit[1].
-
-am.threeWay::
-	By default, `git am` will fail if the patch does not apply cleanly. When
-	set to true, this setting tells `git am` to fall back on 3-way merge if
-	the patch records the identity of blobs it is supposed to apply to and
-	we have those blobs available locally (equivalent to giving the `--3way`
-	option from the command line). Defaults to `false`.
-	See linkgit:git-am[1].
+include::config/am.txt[]
 
 apply.ignoreWhitespace::
 	When set to 'change', tells 'git apply' to ignore changes in
diff --git a/Documentation/config/am.txt b/Documentation/config/am.txt
new file mode 100644
index 0000000000..5bcad2efb1
--- /dev/null
+++ b/Documentation/config/am.txt
@@ -0,0 +1,14 @@
+am.keepcr::
+	If true, git-am will call git-mailsplit for patches in mbox format
+	with parameter `--keep-cr`. In this case git-mailsplit will
+	not remove `\r` from lines ending with `\r\n`. Can be overridden
+	by giving `--no-keep-cr` from the command line.
+	See linkgit:git-am[1], linkgit:git-mailsplit[1].
+
+am.threeWay::
+	By default, `git am` will fail if the patch does not apply cleanly. When
+	set to true, this setting tells `git am` to fall back on 3-way merge if
+	the patch records the identity of blobs it is supposed to apply to and
+	we have those blobs available locally (equivalent to giving the `--3way`
+	option from the command line). Defaults to `false`.
+	See linkgit:git-am[1].
-- 
2.19.1.647.g708186aaf9

