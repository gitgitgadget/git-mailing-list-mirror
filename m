Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E9351F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbeJ0PEQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:16 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40886 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbeJ0PEP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:15 -0400
Received: by mail-lf1-f68.google.com with SMTP id n3-v6so2485771lfe.7
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6TP9eMN9NaAPCNaenZ+KaVLBOSeF3/qiCnit3W8CepU=;
        b=NNhJGZxeR0keE+rR+OZYf92mjyyslcvBjEpeQoxXJU3NVe76LZeAuuOvK4Haw+edXw
         WuVPfFZzkkZdbQX8gQ0S1qwSDpL8bqLoXCwDV8Yv/hU5azSkUPOKrEBJtgoCXFdNYJ6Z
         Fo6CIYU9hE/RvDU6D0l148kL8cCPp16FylKi+BvRIvjcR4Kgq8XB8FHF4zenyrXywqKs
         Z276hj7+USq9OOKHyZFtJD3zf7ksRpkUzPBv3wWFlk46TE2NXTAjGoJTfYDF5xC82YkY
         jspUchc2DneKZIKb+sxDEeXt4jDzhK3nIz9jUXLoqYJ86xdMquV5FshX+YfvhpYiVmGo
         lUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6TP9eMN9NaAPCNaenZ+KaVLBOSeF3/qiCnit3W8CepU=;
        b=tQ0K8phG1paPM2x7QOPeAXjKMmRRDO3sxmXeHYvzU+5XUZ2hY74g1OsKT3Dyne1kEk
         zOms1mrZhrB8+r6R1FdUEZ8UWIuBGnxNLTFjOQd3sOoRIU+gAzjSiu/37QSDAG98Hb1G
         92yq3m/eCx7KydjHw4+2aG6GHR3ejjOnJYA5WcBGgE4roYqxsQcIcodWZEVkMEV9PBvm
         VKVOk0FB9QsTrmUWW/hzKVlYh76biq/9EhviLi+0922DEHPLaTkn6PpfhQaYvalI8PHw
         Sb6e/vsGopOtgyK1Eme/UMxrr0drSzdum/IWbuNyG1RCg+DvjUUggkn+wHs2dfr7jqx4
         NDhA==
X-Gm-Message-State: AGRZ1gLuJ+PU59izELWmdIFzVEz+leXJskuX8I3IRu7qZB+sjTCiiz9X
        GQkObLU8qVP4l5Or2NdzL9BZND+6
X-Google-Smtp-Source: AJdET5eiJiOpjcKpQbqSJ4qs/Nut7gOQiVaUlKRebUURSciBGxjwBd6LlfxWqM7sSKrYW5bpBDx5FA==
X-Received: by 2002:a19:ae03:: with SMTP id f3mr4093678lfc.86.1540621459603;
        Fri, 26 Oct 2018 23:24:19 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:18 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 19/78] config.txt: move difftool.* to a separate file
Date:   Sat, 27 Oct 2018 08:22:52 +0200
Message-Id: <20181027062351.30446-20-pclouds@gmail.com>
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
 Documentation/config.txt          | 15 +--------------
 Documentation/config/difftool.txt | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/config/difftool.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5693ce7654..f313c7da2e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -321,20 +321,7 @@ include::config/completion.txt[]
 
 include::config/diff.txt[]
 
-difftool.<tool>.path::
-	Override the path for the given tool.  This is useful in case
-	your tool is not in the PATH.
-
-difftool.<tool>.cmd::
-	Specify the command to invoke the specified diff tool.
-	The specified command is evaluated in shell with the following
-	variables available:  'LOCAL' is set to the name of the temporary
-	file containing the contents of the diff pre-image and 'REMOTE'
-	is set to the name of the temporary file containing the contents
-	of the diff post-image.
-
-difftool.prompt::
-	Prompt before each invocation of the diff tool.
+include::config/difftool.txt[]
 
 fastimport.unpackLimit::
 	If the number of objects imported by linkgit:git-fast-import[1]
diff --git a/Documentation/config/difftool.txt b/Documentation/config/difftool.txt
new file mode 100644
index 0000000000..6762594480
--- /dev/null
+++ b/Documentation/config/difftool.txt
@@ -0,0 +1,14 @@
+difftool.<tool>.path::
+	Override the path for the given tool.  This is useful in case
+	your tool is not in the PATH.
+
+difftool.<tool>.cmd::
+	Specify the command to invoke the specified diff tool.
+	The specified command is evaluated in shell with the following
+	variables available:  'LOCAL' is set to the name of the temporary
+	file containing the contents of the diff pre-image and 'REMOTE'
+	is set to the name of the temporary file containing the contents
+	of the diff post-image.
+
+difftool.prompt::
+	Prompt before each invocation of the diff tool.
-- 
2.19.1.647.g708186aaf9

