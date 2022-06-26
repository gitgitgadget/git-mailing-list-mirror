Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4FACCA47C
	for <git@archiver.kernel.org>; Sun, 26 Jun 2022 13:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbiFZNKg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jun 2022 09:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbiFZNK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jun 2022 09:10:29 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83FBDF11
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 06:10:27 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o16so9420825wra.4
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 06:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ttd+toG8GGhKdiiHSvU7Y18seRuo6ZMnslKhMPaaPCU=;
        b=PS8gu7UyjWDa+q2nGTF1RxIr542N22oCcUMWuI63ANItBbqNwjo2fU7HmI6WWokVX3
         WuplGHzvgXBKABHYXx5/Paki6o049lfMrRX7LtAgj9sdTWDTCMgnKFZI3IswkFHkAobo
         NxHKMfTKCAMyfZSh9rg3jDkyKONnLMEKmJMGHHaeQF8AYVMnJObZKpxloY3M0oUrQsu3
         VnsWopGjheMEizS8fwnsQmAzIRlRjTLlWnECikRhoU2K0FJkQETzyjt2aU1NoVbHlIFl
         liJ7yPm1oiPEpQDmQB78aTcW/XsfyPUxJ0sq4F8emiFVRlGn3VLRY8VjMghBrInDWMmd
         JfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ttd+toG8GGhKdiiHSvU7Y18seRuo6ZMnslKhMPaaPCU=;
        b=xA6Ha+RIu76ihRGrrA2e2HfqbDYzWAK+AUeigWgzWs7O8SuBqL+ocYNfZ18EMOzP/f
         3Yh+5fRAxllDPoQkpJcNIuwiL0rIiMPNrBgYbeNOexzCLz2WDoOy/fi/P00ntMJM/q71
         hSMFmq7HoBxm0UOtThqwErlJ1UQtOxihc7U7sB5que2UjUQVNHjauYuo3jHEcIDgjL3T
         gzZ2e80RJMTEr6Do2JuyZeZ/2Kt/uLE/oBlsSqGMGgaTQNxwvS6BNNyuOSf0/C1Pr8wW
         umvcyRZNn4ZIf79t55K5klOQzlJ/7fUZjSR7279H8fl0G7KPiUmqxSD8rm/eaEJsEOpJ
         q7Fw==
X-Gm-Message-State: AJIora8wSWe5hBesdJljNa1fufpyguCGMYrEr2EoKJN7v/yoJKJWU8Mz
        A/PCehQVODkf7PB4i5TZBbdmH8fkdcGobA==
X-Google-Smtp-Source: AGRyM1veQqo75pynb1iTtV/N3PwlD6xAYL9SGa6R1XRdQz88FXLLSAQr4V/1UxEAWsyU0JkRSY52+g==
X-Received: by 2002:a5d:6d86:0:b0:21b:ce00:4163 with SMTP id l6-20020a5d6d86000000b0021bce004163mr978385wrs.511.1656249026247;
        Sun, 26 Jun 2022 06:10:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e29-20020a5d595d000000b0021bc663ed67sm2248962wri.56.2022.06.26.06.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 06:10:25 -0700 (PDT)
Message-Id: <fe556b58814405baf5f19f4dd3e89883d08edb8e.1656249018.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
        <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 26 Jun 2022 13:10:17 +0000
Subject: [PATCH v2 6/6] p5310-pack-bitmaps.sh: enable pack.writeReverseIndex
 for testing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

Enable pack.writeReverseIndex to true to see the effect of writing
the reverse index in the existing bitmap tests (with and without
lookup table).

Below is the result of performance test. Output format is in
seconds.

Test                                             this tree
-------------------------------------------------------------------
5310.4: repack to disk (lookup=false)           294.92(257.60+14.29)
5310.5: simulated clone                         14.97(8.95+1.31)
5310.6: simulated fetch                         1.64(2.77+0.20)
5310.7: pack to file (bitmap)                   41.76(29.33+6.77)
5310.8: rev-list (commits)                      0.71(0.49+0.09)
5310.9: rev-list (objects)                      4.65(4.55+0.09)
5310.10: rev-list with tag negated via --not	0.08(0.02+0.05)
	 --all (objects)
5310.11: rev-list with negative tag (objects)   0.06(0.01+0.04)
5310.12: rev-list count with blob:none          0.09(0.03+0.05)
5310.13: rev-list count with blob:limit=1k      7.58(7.06+0.33)
5310.14: rev-list count with tree:0             0.09(0.03+0.06)
5310.15: simulated partial clone                8.64(8.04+0.35)
5310.19: repack to disk (lookup=true)           249.86(191.57+19.50)
5310.20: simulated clone                        13.67(8.83+1.06)
5310.21: simulated fetch                        0.50(0.63+0.13)
5310.22: pack to file (bitmap)                  41.24(28.99+6.67)
5310.23: rev-list (commits)                     0.67(0.50+0.07)
5310.24: rev-list (objects)                     4.88(4.79+0.08)
5310.25: rev-list with tag negated via --not    0.04(0.00+0.03)
	 --all (objects)
5310.26: rev-list with negative tag (objects)   0.05(0.00+0.04)
5310.27: rev-list count with blob:none          0.05(0.01+0.03)
5310.28: rev-list count with blob:limit=1k      8.02(7.16+0.34)
5310.29: rev-list count with tree:0             0.05(0.01+0.04)
5310.30: simulated partial clone                8.57(8.16+0.32)

Tests 4-15 are without the use of lookup table. The rests are
repeatation of the previous tests but using lookup table.

Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Mentored-by: Taylor Blau <me@ttaylorr.com>
Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 t/perf/p5310-pack-bitmaps.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
index 6ff42bdd391..9848c5d5040 100755
--- a/t/perf/p5310-pack-bitmaps.sh
+++ b/t/perf/p5310-pack-bitmaps.sh
@@ -13,7 +13,8 @@ test_perf_large_repo
 # We intentionally use the deprecated pack.writebitmaps
 # config so that we can test against older versions of git.
 test_expect_success 'setup bitmap config' '
-	git config pack.writebitmaps true
+	git config pack.writebitmaps true &&
+	git config pack.writeReverseIndex true
 '
 
 test_bitmap () {
-- 
gitgitgadget
