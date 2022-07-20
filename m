Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBED9C433EF
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 06:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239017AbiGTGfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 02:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbiGTGfH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 02:35:07 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CFCB7
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 23:35:04 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d8so4731742wrp.6
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 23:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VX7J6jKcAFfBQY7A1avwo/9vGdI32E/whFBBnAJ230A=;
        b=owDQmcAvCSd0Q98J7pRiiXdSg432rFje3FR6MVQPQFsFQZ0TZCyFDq9Fo1QHRs+ZmQ
         i/foglGHhdnAqUP5JpV+xICKDmP7ErSD+7P13AE/IlIXomzoDAAEBRV6vXKisx09Vnzb
         iP6sXspmvZzBXvJ5Nh7X0EmEBzH58YLbtYZHHvgkHRJy3hkqRY8DsRaErrYdC7NDglo5
         lsKL9NyUGXz3lcqlRbYBin9DBtsd7JMb3+AiUmrdvehEYsHjajMD2yD6xw/8v3WoUIxA
         iloPuNMSLQuThZDYyTpS10dwqY9U4txuyShPTIr3RXGBYosGMhqiSwx6y4cENa9eFlIG
         trOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VX7J6jKcAFfBQY7A1avwo/9vGdI32E/whFBBnAJ230A=;
        b=tWP1oP+16H/1Tg2DucuSWRVpiYnMXIdsbqIb9rho4BEK0GMSNCpxbx1GwCRoVGSyR2
         waU62nfvadiBHY+/UjqmLe9JFOtnmG7fCBbnrGIgDEQiKa67BYUTaze6MHOoER48ORd2
         56CYBv+WI8sJSkRK2LChmJhSzIWDXdMGIlEwL8DBN8lqxyNwH+BE12pGn8ZQIOUQkNI0
         Gkw9+ZGc58dmQSjt/pu7nTdK5a1DttVKaMnpGdTgBY1kTMwF62SU7tK0B61j2Ugs3mkT
         WbhWAPMgKZDay3ioF6IyhzJu0sAHFr5F4fzfXJ7B7drbsn6vZkyCCixqI83A4slFKNwV
         fZDA==
X-Gm-Message-State: AJIora8ztoslZzOPA4K5TnRk6RK3Gy4ozAbo28vJwUe0M6wLBhz1DMRF
        HSdzJBP/cLGMNIEJM87QsgKK3YZQRLk=
X-Google-Smtp-Source: AGRyM1uarp/805xTeKCN2VbuanYKq9N84/3Wy+0y+ceOvlruzciH1TboOZBPDtDy7LglWJCm8X34JA==
X-Received: by 2002:adf:f50b:0:b0:21e:2954:6990 with SMTP id q11-20020adff50b000000b0021e29546990mr7548172wro.298.1658298902544;
        Tue, 19 Jul 2022 23:35:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g14-20020adff40e000000b0021bbf6687b1sm17757075wro.81.2022.07.19.23.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 23:35:01 -0700 (PDT)
Message-Id: <1484eee8961227a9901e3baa052c74a6d992c220.1658298900.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1297.git.git.1658298900.gitgitgadget@gmail.com>
References: <pull.1297.git.git.1658298900.gitgitgadget@gmail.com>
From:   "Moritz Baumann via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Jul 2022 06:34:58 +0000
Subject: [PATCH 1/2] git-p4: fix typo in P4Submit.applyCommit()
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

