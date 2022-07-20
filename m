Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6890DC43334
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 18:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiGTS4D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 14:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiGTSzf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 14:55:35 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC372DEC6
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 11:55:34 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v5so2697811wmj.0
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 11:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VX7J6jKcAFfBQY7A1avwo/9vGdI32E/whFBBnAJ230A=;
        b=BimmSu+q5GuSXHvfFhusnnoguvSreOOb29L/RcpJ2cKfEtleM3uS0hO5G7Tg4E4lc0
         CVZITZwkHDbNmdo+eqxNqtVcqtHojysamb0eAf13545OCCeqs8N961Ak8X2KBDMzAKaR
         RpDgYT33pLPKamd14aioRuw35AK7JmwgQaxRg1OYU0cpDTyLdUMO0OfaWMbljbFWTcoj
         JExyh+R8JDaywVXY9AEQFIMDO0Cm4WSLEGyrRnKXlZEnrRKWkDtFSGlQxOrDZbDB/fIl
         +I2hzQSJM3kDPjMJ5Vj3lcr5abckiccy4K2M/wuX62PfEjLf+PDkT10r6V1ns6Qrl+ga
         wQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VX7J6jKcAFfBQY7A1avwo/9vGdI32E/whFBBnAJ230A=;
        b=CdKMI5f5Bt5cHwTpiN4cEhN1OYaUWeZCqL7wKz42ckFjA0mw2vKdTro+Ar/XOd2dSD
         ma8BcYOY1PR/FIYWW3NZuukt3M47mm/DX0/xWrW2gjfRFWKEIh9Z/jm6WLZWPSuOi2J/
         v+ohSuxMNTBgryBdAFxTixnSWqY0oz//YL9RLCmr3r4P6HABj2aUGINiyLWmo8xQQcbn
         0Mk1uqvKtG8QHMEQ4lphx2X2zVyWLj3hajxobUF/swcQisOb+G47gWETYgw2MwK29Iiy
         UAIJHNImQLJs1H+NqpA3cCtzgja4hYTNrhDEhGyBfByJ0ZsPi65YhJh4JRJCzJa9m9CX
         CvWQ==
X-Gm-Message-State: AJIora+edbpFUHYfst99zizgcYXDBHGu0yrT4dl5KpXBX1n/Q2QdlUpg
        i7/hjX0TdUy/kgXG5mpAIZa59ivvBV4=
X-Google-Smtp-Source: AGRyM1v3y/vTIyD/ZDa9GcngPaBR/oJ7jLc7+U1oom3+15Ge+gXjPdb+dVSDcmfLSL9NF1AvUz+mNg==
X-Received: by 2002:a05:600c:3551:b0:3a3:1d4f:69ed with SMTP id i17-20020a05600c355100b003a31d4f69edmr5224468wmq.188.1658343332935;
        Wed, 20 Jul 2022 11:55:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n11-20020a05600c304b00b003a320b6d5eesm3074744wmh.15.2022.07.20.11.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 11:55:32 -0700 (PDT)
Message-Id: <1484eee8961227a9901e3baa052c74a6d992c220.1658343330.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1297.v2.git.git.1658343330.gitgitgadget@gmail.com>
References: <pull.1297.git.git.1658298900.gitgitgadget@gmail.com>
        <pull.1297.v2.git.git.1658343330.gitgitgadget@gmail.com>
From:   "Moritz Baumann via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Jul 2022 18:55:29 +0000
Subject: [PATCH v2 1/2] git-p4: fix typo in P4Submit.applyCommit()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Luke Diamand <luke@diamand.org>,
        Moritz Baumann <moritz.baumann@sap.com>,
        Moritz Baumann <moritz.baumann@sap.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Moritz Baumann <moritz.baumann@sap.com>

Signed-off-by: Moritz Baumann <moritz.baumann@sap.com>
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 8fbf6eb1fe3..1de3d6f1cd4 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2226,7 +2226,7 @@ class P4Submit(Command, P4UserMap):
                                 raw=True):
                             if regexp.search(line):
                                 if verbose:
-                                    print("got keyword match on %s in %s in %s" % (regex.pattern, line, file))
+                                    print("got keyword match on %s in %s in %s" % (regexp.pattern, line, file))
                                 kwfiles[file] = regexp
                                 break
 
-- 
gitgitgadget

