Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144E6C53210
	for <git@archiver.kernel.org>; Sun,  8 Jan 2023 14:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbjAHOtX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 09:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjAHOtS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 09:49:18 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF65C10040
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 06:49:17 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id co23so5763606wrb.4
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 06:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ORihh1f3OMbYbO2K6KZ5K/L2BkD1qgvsoy5DBA4/k4=;
        b=MuktEm8i9Ujp0l+cQtKpoxnSILO6Xqa+H5aV8bsreXT4ONLLwWSOGg+kjd9PbRnnPD
         Bya/mJgho/IBs8q0Nil/lVTy0af8NzbXUCyd9QOYF5Mn9F52iEcwCHDzu9Yw9tOO1H+u
         wck3XvgWSU87o0SwlTUK+/9i7U1ESZQ90l7iN6qteasidJOn9i4c6vRMegPeHMnU41Sa
         u7tLV+Lx8kOB8aFjdseqknosTsjBClD4noHvn0cxmHgz27AunyLmbqVtUeYvcLdqg3Mb
         OtfZxZqqnGU4v8ulgjQlLC/m40DWGGTxUlDeMHWaN0OWYHBTtJtvCzPhQ0U+lm5nh+xG
         srCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ORihh1f3OMbYbO2K6KZ5K/L2BkD1qgvsoy5DBA4/k4=;
        b=nI9eHtjSlG/3rRkOl94g9kfsNua2ocQiR8zyhr/g8cVWYKWxbOEstI54p3Rzil2pmu
         6LAYDFpQeCu8yFDsRLnxnVz+1Ual3ovwQbFrsqTIGiLjcoIwdA/zqThoVFsPtpFGBavQ
         CMx00RtOhg1fODxaWHENQPzRh3xnefL9owhRKbCcH1WAo34aJHNLhaZzFTw8AcHq9T8v
         KL+9IoXKZAY1aQhjKU7JcMxXirEsqZ6+PvpwC8DU7I9REjUtu0jhxMJB8/DEDhvjnxmv
         yqsKLQ11FGQqNPyt6MDfmTYZuoKb3MW8qItCyB77e4ZttB79ehtWxHRnPq7Za14YI+Yj
         ruRg==
X-Gm-Message-State: AFqh2koRXORCXG/iT8EXkZrKq96NoM04paNC2Pz+U8oQMtSPL3ZkzOV4
        FJPpzDt8WRDaOpvCjn0G1gduMEy3gu8=
X-Google-Smtp-Source: AMrXdXvlnTER+VPHFu0BzuSaVwuIAJoR8gxYx6MyBa4xutk+lrrJhgsvCnOKCgeNuT7HKYhkBrRotQ==
X-Received: by 2002:adf:fa88:0:b0:2bb:32bd:1dc0 with SMTP id h8-20020adffa88000000b002bb32bd1dc0mr4835642wrr.58.1673189356098;
        Sun, 08 Jan 2023 06:49:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6-20020a5d6546000000b002bc371a08adsm12117wrv.101.2023.01.08.06.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 06:49:15 -0800 (PST)
Message-Id: <pull.1413.v3.git.git.1673189354738.gitgitgadget@gmail.com>
In-Reply-To: <pull.1413.v2.git.git.1673189172832.gitgitgadget@gmail.com>
References: <pull.1413.v2.git.git.1673189172832.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Jan 2023 14:49:14 +0000
Subject: [PATCH v3] mingw: check that the file attributes are valid before
 modifying them
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

If the attributes are invalid, return -1
to indicate an error.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    mingw: check that the file attributes are valid before modifying them

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1413%2FAtariDreams%2Fset-hidden-flag-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1413/AtariDreams/set-hidden-flag-v3
Pull-Request: https://github.com/git/git/pull/1413

Range-diff vs v2:

 1:  f1cc7d9a98b ! 1:  0cbe8bce617 mingw: check that the file attributes are valid
     @@ Metadata
      Author: Seija Kijin <doremylover123@gmail.com>
      
       ## Commit message ##
     -    mingw: check that the file attributes are valid
     +    mingw: check that the file attributes are valid before modifying them
      
          If the attributes are invalid, return -1
          to indicate an error.


 compat/mingw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index af397e68a1d..01bafa01e92 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -435,6 +435,11 @@ static inline int needs_hiding(const char *path)
 static int set_hidden_flag(const wchar_t *path, int set)
 {
 	DWORD original = GetFileAttributesW(path), modified;
+	if (original == INVALID_FILE_ATTRIBUTES) {
+		errno = err_win_to_posix(GetLastError());
+		return -1;
+	}
+
 	if (set)
 		modified = original | FILE_ATTRIBUTE_HIDDEN;
 	else

base-commit: a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1
-- 
gitgitgadget
