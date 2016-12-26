Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87909200E0
	for <e@80x24.org>; Mon, 26 Dec 2016 10:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932406AbcLZKX1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 05:23:27 -0500
Received: from mail-wj0-f196.google.com ([209.85.210.196]:36014 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754522AbcLZKWm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 05:22:42 -0500
Received: by mail-wj0-f196.google.com with SMTP id j10so48077809wjb.3
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 02:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+IK0tBHiMCjFQr2o5Q0g4PNr6HakTN88k4CvQOmAxuM=;
        b=h9158sYmlsJotuWyXF8X4CM7NNrsZCY6nM18ytVGuc0fZjc4XM/1ysbwegLZNhSyms
         RLxRdPmS+rBpNyQpmv7FZBcgYbXeewDaqmgJb+qBkP8igAQMx/ke+jSvTd/zph4VXAjN
         lfdrIMkXT3/N13ACZ4krm71q3Ssx3LieEUnOJgjCvjfcjzuyIb1JEFK1hq/VcvGbdkOk
         +Fb5wbJExU3felY98k0b508QPnq6ifKOso67gfkNqFBPex6kMgxBmaZ8AqBPfZtr6nzE
         N8SX4j/f4qPXChYMI+66vSN1NC+KP6v0dJd/8Z6mbeBdFOZF0gxMeZBkLpteXaknSins
         q1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+IK0tBHiMCjFQr2o5Q0g4PNr6HakTN88k4CvQOmAxuM=;
        b=Qgz0lsYUVmw62pNp763WTwP/fG1wG8qrXM/FPwjIE71hnWnNqzfr7m+T5v3lD0UgEb
         fXxTnEeNRwf3hYTtIok0KoRqmiHYwALx+vMegyhyXQUqrBHt0XGB4mZ9tlvrHmmfCABF
         +RiAJOqlROLVTohyqfd38oSSx0gPZsR+RWHeZVdOhLlhC5CVzjxn+EOxk/KXYzrQRYDu
         wRU9FwY6mBcqIS0lTaDVjnYkI6pBdF0KjU19lKG0Pmf8znFId3hcLTCpWkwc3bCZSjJX
         hnusSAita2U7kDR7bDRNvjmqM+EioA3BtH9Vhfxx3AoFv+gEb7zmSW/Sh4Tkfbf5dU3z
         UZnQ==
X-Gm-Message-State: AIkVDXKhX+VoEBIiiKz/2//UW0Agv2bBp+pyflFvs4zoyE3712VcSBqRvhIeyJI3qMD2Mw==
X-Received: by 10.194.52.42 with SMTP id q10mr22131667wjo.50.1482747761565;
        Mon, 26 Dec 2016 02:22:41 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id kp5sm54259010wjb.8.2016.12.26.02.22.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Dec 2016 02:22:40 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 07/21] Documentation/config: add information for core.splitIndex
Date:   Mon, 26 Dec 2016 11:22:08 +0100
Message-Id: <20161226102222.17150-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.209.gda91e66374.dirty
In-Reply-To: <20161226102222.17150-1-chriscool@tuxfamily.org>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d51182a060..221c5982c0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -331,6 +331,10 @@ core.trustctime::
 	crawlers and some backup systems).
 	See linkgit:git-update-index[1]. True by default.
 
+core.splitIndex::
+	If true, the split-index feature of the index will be used.
+	See linkgit:git-update-index[1]. False by default.
+
 core.untrackedCache::
 	Determines what to do about the untracked cache feature of the
 	index. It will be kept, if this variable is unset or set to
-- 
2.11.0.209.gda91e66374.dirty

