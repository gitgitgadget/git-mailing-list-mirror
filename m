Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DC231F954
	for <e@80x24.org>; Wed, 22 Aug 2018 16:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeHVTbw (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 15:31:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44586 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbeHVTbu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 15:31:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id q127-v6so1834797ljq.11
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 09:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fjtSO5F14HRCuZ3dM9r/wpJOFVEsMO4l86ApgVTvO7w=;
        b=R/7uMevYErElOCw1CFk28u8Eq6NkcYBUP2PCUzPdRRfiokACUo1qU0E6dB9IF2fAox
         nt1czDklsdTrZIxfQGBJass4V+1L0SJmL/wLcNkuuYpgmunGug6NRIGd3dYb10ccjhFb
         MDvIm5LAJULjycVPkWwbDRp3jNVjoQExie2eDfE0ckk3vpu2Bt9RLYul7MOPZmNQa63c
         QY2E6v2u+1wDVV0RvpXtHylJaTaA1moSr1D5Mra2R2OE9PvSHTcp/9PM/qvAjR5B03il
         CjqXg/nHXCf6yNLOiYrjLClpkQgsGl7hwsBTBeFwePdbHXKWxQs7b6V3cfIdQcoeEZcp
         9vSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fjtSO5F14HRCuZ3dM9r/wpJOFVEsMO4l86ApgVTvO7w=;
        b=ax/Mn/deAwTzt5GwKyXVkScvE/Z2oBYx35T1fg+kp9KyYz1+C8puq2TYgHYvi4+a8l
         FMQs5y7elL53HrJwogmeSH5LuUtQiqjE3qRxLPY4uAIQ5AbDdxq4NnrbiGdtb8oO/7um
         LmXJUGcjg9w961/npuAuW+045jM1vKiIot2tLY2+MJEORkoUeoR5qX+LDdO/Ed5oMsri
         SpbKloymZAij0IGmPQSNPT0UMeDIqV74l2I+oSNkaWPOEgFv6VN24OqunTnNCW+Smv5Z
         2GfMeHYEkCFvZTjl1C4HZ3zmcd4HncYlCPYRG8+5MuEoj48tVasI6twt73anRzwBLF5n
         B8aA==
X-Gm-Message-State: APzg51Ab/eQ23KZhAZ9cTsnjyjTksLC93Jow35kq2pTZk44NWeHJn2rR
        M/o3dOgTQXYl2a17M7ty49hlP8Zf
X-Google-Smtp-Source: ANB0VdZz+SNYEC3eJdWzxoIPL2Nqu/iAP+6ky/FEOs1ke1W7gsoYYnwpps9O2UcTybl5IXkLzIVDMQ==
X-Received: by 2002:a2e:5f93:: with SMTP id x19-v6mr3072077lje.60.1534953979931;
        Wed, 22 Aug 2018 09:06:19 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u86-v6sm375213lfi.90.2018.08.22.09.06.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 09:06:19 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/11] config.txt: move sequence.editor out of "core" part
Date:   Wed, 22 Aug 2018 18:06:04 +0200
Message-Id: <20180822160605.21864-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.335.ga73d156e9c
In-Reply-To: <20180822160605.21864-1-pclouds@gmail.com>
References: <20180822160605.21864-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 414e28244e..a0eaf40564 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -822,12 +822,6 @@ core.packedRefsTimeout::
 	all; -1 means to try indefinitely. Default is 1000 (i.e.,
 	retry for 1 second).
 
-sequence.editor::
-	Text editor used by `git rebase -i` for editing the rebase instruction file.
-	The value is meant to be interpreted by the shell when it is used.
-	It can be overridden by the `GIT_SEQUENCE_EDITOR` environment variable.
-	When not configured the default commit message editor is used instead.
-
 core.pager::
 	Text viewer for use by Git commands (e.g., 'less').  The value
 	is meant to be interpreted by the shell.  The order of preference
@@ -2679,6 +2673,12 @@ rerere.enabled::
 
 include::sendemail-config.txt[]
 
+sequence.editor::
+	Text editor used by `git rebase -i` for editing the rebase instruction file.
+	The value is meant to be interpreted by the shell when it is used.
+	It can be overridden by the `GIT_SEQUENCE_EDITOR` environment variable.
+	When not configured the default commit message editor is used instead.
+
 showBranch.default::
 	The default set of branches for linkgit:git-show-branch[1].
 	See linkgit:git-show-branch[1].
-- 
2.19.0.rc0.335.ga73d156e9c

