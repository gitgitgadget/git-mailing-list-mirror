Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 975DA1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbeJ0PEu (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:04:50 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45246 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728492AbeJ0PEt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:04:49 -0400
Received: by mail-lf1-f67.google.com with SMTP id c24-v6so2470203lfi.12
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 23:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aMMEfMFkmh9japNZDtK8C9giNrRCN6wf/R30hRYr1tc=;
        b=sT2WmwsT2om4lxZyA06P/PIiUURJUfPnfyOylzmB0IKKSyK3NmfGLR+DBrtGLIMcos
         UBpkVZ9vErImcNRanFyiQm0pYjUsuRW0s3Dz1gI3QcBVUsTPs2yercMv5OvKH0/f5JAV
         Du/zDEW/ICVR52kHzdI6M2AZDMhhiDw8HV3QJRfjqEDCj4YTxAvD6LHq+t5s29o9lNwv
         jUneYwrlNlq5hJX50JF43ywAOROCu7inRxrT68bfK8UnnGRS49qUzwItSpi4x0gKmT/u
         bYH1d92VuqtaObTvEvftoBORcJPD36XL6LP86ZYqHuhTv0GWhC5NPkLVFC9Pv908/3fg
         Me4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aMMEfMFkmh9japNZDtK8C9giNrRCN6wf/R30hRYr1tc=;
        b=rg6w5q66pZr9Ax7U2Li4Iv+JWdj5zIIEkVXYxHh1SzQEOQcSFdBn0hdapdxvV3Z81P
         9R7+e8NtvFYqjz4ny4SdDPBF+W4B1kIUIpWnxirvWa75uoDxMmgitBHzVFzIT9yTVhbj
         IBt+LuMM1711GVT9yeJzfNmWJ20Ebo3/sxzMN5hp2czBS/bQ6jwvZeXs0x+lpRCSKS53
         7dudLbEDLR1hNLHYgnTE1vEFol4x5eo7QvV00OrZHd8naBFKK6c0EljGUlbzI8ttg9+J
         twBL2Xk2NnmBeBcIaOVGJX6ZbogwRcWI0j6dsUSoiDd8A2yQFH+hJhjFMH+xxd81sXsS
         o/2A==
X-Gm-Message-State: AGRZ1gJXY6DVO9QSvCQvdnJPLKmr4tbRmBD5+Dwtlgw5X/dQ31bSX6Un
        8QHVF3cTr4+GD2M3LVT6MZCZfviq
X-Google-Smtp-Source: AJdET5dsLS9szvU5LOLYPNoH6kNtGalUfj3VisEIlNeWH/EGYwjVxLMXSLTE1Y/BpJ6u/MOOMJMcxg==
X-Received: by 2002:a19:a28e:: with SMTP id l136mr4062697lfe.87.1540621494016;
        Fri, 26 Oct 2018 23:24:54 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c81-v6sm2097487lfe.79.2018.10.26.23.24.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:24:53 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 50/78] config.txt: move pager.* to a separate file
Date:   Sat, 27 Oct 2018 08:23:23 +0200
Message-Id: <20181027062351.30446-51-pclouds@gmail.com>
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
 Documentation/config.txt       | 9 +--------
 Documentation/config/pager.txt | 8 ++++++++
 2 files changed, 9 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/config/pager.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4e839db64c..a7b72d2722 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -379,14 +379,7 @@ include::config/notes.txt[]
 
 include::config/pack.txt[]
 
-pager.<cmd>::
-	If the value is boolean, turns on or off pagination of the
-	output of a particular Git subcommand when writing to a tty.
-	Otherwise, turns on pagination for the subcommand using the
-	pager specified by the value of `pager.<cmd>`.  If `--paginate`
-	or `--no-pager` is specified on the command line, it takes
-	precedence over this option.  To disable pagination for all
-	commands, set `core.pager` or `GIT_PAGER` to `cat`.
+include::config/pager.txt[]
 
 pretty.<name>::
 	Alias for a --pretty= format string, as specified in
diff --git a/Documentation/config/pager.txt b/Documentation/config/pager.txt
new file mode 100644
index 0000000000..d3731cf66c
--- /dev/null
+++ b/Documentation/config/pager.txt
@@ -0,0 +1,8 @@
+pager.<cmd>::
+	If the value is boolean, turns on or off pagination of the
+	output of a particular Git subcommand when writing to a tty.
+	Otherwise, turns on pagination for the subcommand using the
+	pager specified by the value of `pager.<cmd>`.  If `--paginate`
+	or `--no-pager` is specified on the command line, it takes
+	precedence over this option.  To disable pagination for all
+	commands, set `core.pager` or `GIT_PAGER` to `cat`.
-- 
2.19.1.647.g708186aaf9

