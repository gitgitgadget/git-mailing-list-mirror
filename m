Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FC241F453
	for <e@80x24.org>; Sat, 20 Oct 2018 12:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeJTUu0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 16:50:26 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44839 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbeJTUuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 16:50:25 -0400
Received: by mail-lj1-f196.google.com with SMTP id v6-v6so33059186ljc.11
        for <git@vger.kernel.org>; Sat, 20 Oct 2018 05:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bq2v8XG3I6ZXS5wzDWHlkCZnFAQOuFdosvIfGuzxrsM=;
        b=T4zOovarfUPdCO2Dod7NAIpPM2/zB78TLGpqs8SmKhs47OPdxah0T5+wmcE2H115a3
         xuf2VTaOFvlgHwmJ0P8sJYWGS0xHdS6dR2Q+C+J5iTvXeQxpz1JVGJHTWzJv6fgEr2Cl
         87jP+h9UGSMvoq3cP7nCE4AAS6V2nKa/l4VN5Wg/nx7LzMFfcrC6l3rjfYq8YqgaXG2U
         WY5tkdHPd21BQsitwCqlf76TyAygfYuLD5dDjGgzsVJRApcY9eQoGLJxcYOA9vDVpk0A
         PcnxN3pkrLNJ047hCfy/q5m1blsdyBCknWtpOH+KB6umFN7+MEGwqCf+yee6DlsJjgwl
         fgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bq2v8XG3I6ZXS5wzDWHlkCZnFAQOuFdosvIfGuzxrsM=;
        b=EYQ38mbAmGrHGutrSoKfGVcbDFGiGLs0pz73WontE35yIIJiNmHMnlNT7s/dZ18GcS
         MwhSiMuycjeOK4cB1BleKPkVBlNoirGUxSlsTNyWXQOpSZsKLg/+me34Zl3yPijm/Kkx
         FeaUFRI95d5La+fdNHlAxns6wIy1ZLCdUzeQfXsuzep6t9eq8T5ocedC/qovKca9iBoN
         aDW6I/cOU8vagBd1L782ETPSyFSlr5pZHZtj0HmuKTGQ7S5gj981QFNKIflCwrxX+rTg
         qGdi8pUQfKIsoOW3Gqk7bSlyKp5k5mati8QlzGVoPQc6puODbgxgu5AaxdW+CqCwsvLp
         u33Q==
X-Gm-Message-State: ABuFfoixm2/G1A5GOtZGlwv56MEyS+tqMkbgrTaFpafxn1QlY25abvAT
        5MOjKcxdWQ1ck7zVKb/KFFTfarvN
X-Google-Smtp-Source: ACcGV62F0lae+71Y4qQOD0P8P8AKOwnGyk5iRmuxO82U76pcvJr0lhksA+0S5y2Q9voLFM4OSpXVOw==
X-Received: by 2002:a2e:8146:: with SMTP id t6-v6mr25367693ljg.32.1540039203394;
        Sat, 20 Oct 2018 05:40:03 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o22-v6sm5759379ljc.79.2018.10.20.05.40.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 05:40:02 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 41/59] config.txt: move pretty.* to a separate file
Date:   Sat, 20 Oct 2018 14:38:30 +0200
Message-Id: <20181020123848.2785-42-pclouds@gmail.com>
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
 Documentation/config.txt        | 10 +---------
 Documentation/pretty-config.txt |  9 +++++++++
 2 files changed, 10 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/pretty-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 656ae3158c..364e5fdbf1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -632,15 +632,7 @@ include::pack-config.txt[]
 
 include::pager-config.txt[]
 
-pretty.<name>::
-	Alias for a --pretty= format string, as specified in
-	linkgit:git-log[1]. Any aliases defined here can be used just
-	as the built-in pretty formats could. For example,
-	running `git config pretty.changelog "format:* %H %s"`
-	would cause the invocation `git log --pretty=changelog`
-	to be equivalent to running `git log "--pretty=format:* %H %s"`.
-	Note that an alias with the same name as a built-in format
-	will be silently ignored.
+include::pretty-config.txt[]
 
 protocol.allow::
 	If set, provide a user defined default policy for all protocols which
diff --git a/Documentation/pretty-config.txt b/Documentation/pretty-config.txt
new file mode 100644
index 0000000000..063c6b63d9
--- /dev/null
+++ b/Documentation/pretty-config.txt
@@ -0,0 +1,9 @@
+pretty.<name>::
+	Alias for a --pretty= format string, as specified in
+	linkgit:git-log[1]. Any aliases defined here can be used just
+	as the built-in pretty formats could. For example,
+	running `git config pretty.changelog "format:* %H %s"`
+	would cause the invocation `git log --pretty=changelog`
+	to be equivalent to running `git log "--pretty=format:* %H %s"`.
+	Note that an alias with the same name as a built-in format
+	will be silently ignored.
-- 
2.19.1.647.g708186aaf9

