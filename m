Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E37C433F5
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 09:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiJCJAe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 05:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiJCJAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 05:00:09 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4191903C
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 01:47:08 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x59so3588901ede.7
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 01:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YKBjqpmsMKp1twREckUexojqIPpu7pEy4Nds3rF9KUg=;
        b=Hfd4QSjRTqArxfvjocRB1EIEN48HZbG39f8R1P6N0MGy/M9v60VZ9nflX8Yle7pZS1
         LM0dt1tu374o4y58dTbWtHuHgx7svzLzDNp5Na0/UD9lSFlvwTGoPW/XMrtlryH1zpq6
         nuCQYXH6oWfN51Xd5k8RTxk8aNgCmcpb9/8283C3gWl/39fRXs0gSFQsd+9nOO64FCmY
         5Exqvei/tnqruqXzlXOVBHIOxWfSgvfC7aeY38jUG/6Xqx/X+t4PCz91RcNDg2ovqWS+
         nHmL8fhr82NLvnDOiV2hw9d/0Bxnw8ItJoKz4FQMJwXwqHlXn118kYWpAWtErAJB5chr
         QIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YKBjqpmsMKp1twREckUexojqIPpu7pEy4Nds3rF9KUg=;
        b=yiQ8+pDGZcPlyvgTBFw/pHMWBHcTYY+EvBcUC15AqSsuzPiFNO/bIEm9boxp/eg++l
         D0M7M4Nk4hORQYvlCqNLWc7vX3daAk1ZQ8QO2DhF8d90Ng5wKp6643PnN6ybaarWLvQQ
         o+fDGWy7uzrhLoeP6eYNo/WX7//46xhysGpUFPLjbX2YZ1+1yQn6UR/QIiM/rwA1+wzp
         v+LomLiMAmWY9fglmUOoOmw7oMit3tWhKP8Tjm2g1WL33CoTbUWMopM83+JNVGuPE+Xa
         B/QYE/m+JleTqTixx6Q/Cs1pQuBc9apFcVmmSZ15xHOEMDx2bXS9cUCCuW87hzIBIicT
         KaMQ==
X-Gm-Message-State: ACrzQf0KXg8SnA3fXKAI8UiIm1m0QFhV0TOd/u2brCGz57CgKROuuCeq
        4Cok0/WqwFzoOifCpLSttFcg1k0xRaI=
X-Google-Smtp-Source: AMsMyM6JKF0i5t1DJqS5bll8ikcidXvqoinOObccyCf1tj4ujR7yC+1INDrRlXPEH34SscjMXu3yAg==
X-Received: by 2002:a50:9510:0:b0:453:dded:60e with SMTP id u16-20020a509510000000b00453dded060emr17898319eda.204.1664786826981;
        Mon, 03 Oct 2022 01:47:06 -0700 (PDT)
Received: from fedora35.example.com.example.com ([31.191.121.158])
        by smtp.gmail.com with ESMTPSA id x11-20020aa7d38b000000b00456e6e64047sm6907526edq.94.2022.10.03.01.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 01:47:06 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] git-reflog.txt: add an EXAMPLES section
Date:   Mon,  3 Oct 2022 08:46:54 +0000
Message-Id: <20221003084654.183966-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit adds an "EXAMPLES" section to the git reflog man page.
This new section currently provides examples of using git reflog
with branches, for which doubts often exist. In this commit we also
add a "SEE ALSO" section which refers to further information
on git commands or documentation referenced in the git reflog man page.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 Documentation/git-reflog.txt | 42 ++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 70791b9fd8..5bbd5958fe 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -96,6 +96,48 @@ them.
 --verbose::
 	Print extra information on screen.
 
+EXAMPLES
+--------
+
+`git reflog`::
+	Lists entries of reflog of HEAD, starting at `HEAD@{0}`.
+
+`git reflog HEAD`::
+	The same.
+
+`git reflog show HEAD`::
+	The same.
+
+`git reflog HEAD@{4}`::
+	The same, starting at the 4th prior value of HEAD.
+
+`git reflog master`::
+	Lists entries of reflog of `master`.
+
+`git reflog master@{0}`::
+	The same.
+
+`git reflog master@{now}`::
+	The same, show with timestamp.
+
+`git reflog master@{4.minutes}`::
+	The same, starting at master, 4 minutes ago.
+
+For the branch that is currently checked out, you can omit the name
+when you use any of the @{..} notation, so
+
+`git reflog @{0}`
+
+`git reflog @{now}`
+
+are often the easiest ways to view what you did on the current
+branch
+
+SEE ALSO
+--------
+linkgit:gitrevisions[7],
+linkgit:git-log[1]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.37.3

