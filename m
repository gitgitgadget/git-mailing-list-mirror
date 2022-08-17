Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C393C25B0E
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 02:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbiHQCs2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 22:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238172AbiHQCsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 22:48:25 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1F213F95
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 19:48:22 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u14so125514wrq.9
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 19:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=GfuK3OfjqWycfIsAchRueEqPHtrs16kkw+UuZuK+2sM=;
        b=c571RBAHZCG+uocK2ZItY27CPqL8Lj91wy8p792fphqjSkpM2QvcsZoj3j7zQeFllu
         1vQS7s8af/Q1WsTxnIWwpVsd1l3+Y5Qs+eMrHX2RW5yNihmK2NmIvyTJztMke15EMi98
         36MH8Qj5v5iMBhGqn1/v0bPeGuaN+JY1WksPYJ6Z+IdiKkF/9qieqe9fi9yyjy8pe6RK
         VjKjxXOMMcsXX3uy/qIaCe9j/bhz0BD1BWJtsVHvSyYH0Jpw5icGj02EPyoA4/Kd3dGn
         BTICdhyxw1LqjMsnEJ6OVy6Y+XPden1c+xFWw2OEcEaD/P18fCyDOTiua4bBignqjudl
         jlug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=GfuK3OfjqWycfIsAchRueEqPHtrs16kkw+UuZuK+2sM=;
        b=LgfY/oYiWAuuYTA5p2oifWAjeQxLaU4we46DXR1aNffYvpI1/hn0j9i7IQZOFBMsWs
         myBBN83dJ1Wt91vIV+4udk17ZiVDBpUWV04rik4E2/OI5epIWXqaejcUa7b8AUumqe4D
         t+ZOyTA9clk/D/I470pEfhND9C62gpAopnc+4pOrh0iiAGYnKrzYx9jkaCRfsB+OJQTu
         anqCL7JWlcr/Wu6eUpkC2Y9WDSS8aH9p0ZxZf55zNOXFHsUu/R1KLhA69P/cUwNFsewd
         +oo0JiAThyXv8M+JvPgtBMt2lhg6RdlsYYLdK/O7yCp8AL78vpObIdoGXaxEBGWG5qGN
         LB8A==
X-Gm-Message-State: ACgBeo0dMXxJA1Pmgf+iVNxBWsI0tx2raPBwPPtx4Q5HC3I5x+qs/LqE
        nCzcQOfrm/VxpB1hYEmer7bfvsYEtAo=
X-Google-Smtp-Source: AA6agR7MBDk0fNVhb3SBvt2c9BphsEYCWaIRWrvTi97DxgFQYGLa/2TT8w2yBdw8cLo+CRKjsgBQ4w==
X-Received: by 2002:a5d:6882:0:b0:225:20a0:99cb with SMTP id h2-20020a5d6882000000b0022520a099cbmr1582047wru.368.1660704501038;
        Tue, 16 Aug 2022 19:48:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y5-20020adfd085000000b0021e6c52c921sm14552690wrh.54.2022.08.16.19.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 19:48:20 -0700 (PDT)
Message-Id: <68ab719d99c68c81159c65ee42930a3023f275db.1660704498.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1303.git.1660704498.gitgitgadget@gmail.com>
References: <pull.1303.git.1660704498.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Aug 2022 02:48:17 +0000
Subject: [PATCH 1/2] rev-list-options.txt: fix simple typo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/rev-list-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 195e74eec63..2f85726745a 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -659,7 +659,7 @@ Here, the merge commits `O` and `P` contribute extra noise, as they did
 not actually contribute a change to `file.txt`. They only merged a topic
 that was based on an older version of `file.txt`. This is a common
 issue in repositories using a workflow where many contributors work in
-parallel and merge their topic branches along a single trunk: manu
+parallel and merge their topic branches along a single trunk: many
 unrelated merges appear in the `--full-history` results.
 
 When using the `--simplify-merges` option, the commits `O` and `P`
-- 
gitgitgadget

