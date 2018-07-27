Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8527D1F597
	for <e@80x24.org>; Fri, 27 Jul 2018 14:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbeG0P7v (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 11:59:51 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53096 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730714AbeG0P7v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 11:59:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id o11-v6so5457397wmh.2
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 07:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fJToMK4PjKBWY09Z+D+O1RzP2Uthw0N7TjXbjiZypXs=;
        b=DBqZTd9Ny8L2T4YNdRoufCexgGbmZAp4k6GW7zkqB3bCYnPK27Aei9fxVh1ewJNEcS
         q5/hJYGuTXyinVM+tfqvH+nQkCrgvghAKg5UTiu3MUpMxSRcVvcQwZS5qma8VLC9CEFr
         +iEcGwD/HuMjXQwRZQme2TX2k15nESKTVX9PUsgzyNP9l0TGgLxb3T78aNemqVHjDXI4
         qNU7g9XY5DcWsYOSzddIWYNLW1p5CkQNRV38BEC4jep0ImolgzCDYxtKuz5pdYu4aOQX
         MStua+qJwGPtRbPx0vs5QXpW9VRjKNaTjDdcXqsvrnDg5BuiwRCQ615dDAu3BzDsHoB3
         6aQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fJToMK4PjKBWY09Z+D+O1RzP2Uthw0N7TjXbjiZypXs=;
        b=tCcYUYZxIGxf+c3tR+bnp/ZLa2rmQk2raUhIeuXOAfasp4qd6Xm83BMjIQp2NAkXMm
         LWXEDcQCwp+fyvF/7f9ffMsZ7fX7723Icz/VjfmQBc0PmKwucjyOPXpynkME2oZ7Jwxn
         kHv82dJpKPjwQHQLCJVJ3fcawlcnJZlT38JboDSuItQcDIgqoFLTFTCMO8Fu93WBurtA
         2oI8IjJ8oETS+zwZjFzfJ1VxuoHrjwIAHvgTTfqUZRI3Wvz4c+ge/cNa9wImhOgJZMvt
         DkDCzFd4DpJR4SyLwkPDaQym61ATbvrF5ILFIkxPV6fuf3whYSxMf7d3yrqZipbnc7ny
         R5Cw==
X-Gm-Message-State: AOUpUlExG1TkQO2OhaB7YebJRb0siNl1VLZHhwTKsrekSE5CVR9+AlUF
        oDXt3u85QPFaJbkGaD8sj9sHC9DE4Is=
X-Google-Smtp-Source: AAOMgpcYmbUylBYQSIxuc6cJPeWmmGmu4hQDATJZ54JamrZMlDKE2KTaiqNAZmL/fK7VQ3al4MRICg==
X-Received: by 2002:a1c:be13:: with SMTP id o19-v6mr4237880wmf.1.1532702256883;
        Fri, 27 Jul 2018 07:37:36 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j16-v6sm3005479wme.8.2018.07.27.07.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 07:37:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/10] receive.fsck.<msg-id> tests: remove dead code
Date:   Fri, 27 Jul 2018 14:37:11 +0000
Message-Id: <20180727143720.14948-2-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180525192811.25680-1-avarab@gmail.com>
References: <20180525192811.25680-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the setting of a receive.fsck.badDate config variable to
"ignore". This was added in efaba7cc77 ("fsck: optionally ignore
specific fsck issues completely", 2015-06-22) but never did anything,
presumably it was part of some work-in-progress code that never made
it into git.git.

None of these tests will emit the "invalid author/committer line - bad
date" warning. The dates on the commit objects we're setting up are
not invalid.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5504-fetch-receive-strict.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 49d3621a92..e1f8768094 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -149,8 +149,6 @@ test_expect_success 'push with receive.fsck.missingEmail=warn' '
 	git --git-dir=dst/.git branch -D bogus &&
 	git --git-dir=dst/.git config --add \
 		receive.fsck.missingEmail ignore &&
-	git --git-dir=dst/.git config --add \
-		receive.fsck.badDate warn &&
 	git push --porcelain dst bogus >act 2>&1 &&
 	! grep "missingEmail" act
 '
-- 
2.18.0.345.g5c9ce644c3

