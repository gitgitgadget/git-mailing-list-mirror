Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2A1C433FE
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 22:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiCKWpo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiCKWpg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 17:45:36 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A077F21132C
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:21:14 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m42-20020a05600c3b2a00b00382ab337e14so8332843wms.3
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hcNzkzFLgg+5Vio1hwhcoeX2wzTCyNge6Xc3i7j62zU=;
        b=WuaCIOzPPBzWdRZJ3S/hs7sPeCvCIIg/q5v7Bk5bn1tlLcI2r272yRyqlsyHTDN6Sf
         KxsHZ/3w1WRcGCbpubGpfgbIzEUeUsj3Ne5i5mw3iy7t7J9XeaE2OLWlV4uBI5SyUgNC
         BkNx/Jzk/sZ5ZPQj+nYYF6a8ft0uNCWibFBWdYCvklWkRh8cPI3MBmBIkuQQWi/erwdE
         FyQzKkJaGSmZZCXRi/Fz6Vt94qvsoCjhWqCXaFpGn8UasAQaI2pvr1jzH11fPvuA9c1e
         7roujqtovQyxJlkITJMS3/PYSOmZWJcNP8oKsKtXBhFqmvJNM/3wZXWyY/eXvM+1zhf+
         uKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hcNzkzFLgg+5Vio1hwhcoeX2wzTCyNge6Xc3i7j62zU=;
        b=4MQqMwVJ5o10Wh2f+QtBDONJ0+iZRLLqXRKzim8WtEzhzI54BfUR2b+mNLRPfWpJTM
         AoajFvFIVKTxcoXcyl8ikDmJzBblX+Y+pdpASN/qr7MqydxXctS+c2i/rFPUhLUx8TTl
         lQx7F5k8QzHuzqjoilNvTYvbayPYGKrtcWtuEL9i3uFDyDUGa9SgygWcBsPvx9EZhXe1
         SEy5qn9vRjqK6G/alKJB/gZ5B8pKOHTbfSVi2ifs5eV/vbAMDYAMIIy54NDva+lPn/Gn
         9NFioYwKnhF909fO+C5adqu2cQxG2+21D4iPyV77LQi5oSmx8yEsYmPzbwYCSV1sz53F
         yGjw==
X-Gm-Message-State: AOAM533iyp2GcpSPkFvQjC8WpDQPaMAV0DD47ZITeA8aTtHgVVbZzbnZ
        /q+b15t44cc1lNw0cujrZWIlt9t5TRI=
X-Google-Smtp-Source: ABdhPJypJQBTOTZRONj+ozXOHE9U9mnk+pgEHd708wp6Lv6ax4b/CvrAkUEwlnan3U40Say9TqqE4w==
X-Received: by 2002:a05:600c:26c8:b0:389:a542:c20b with SMTP id 8-20020a05600c26c800b00389a542c20bmr16922457wmv.46.1647033312350;
        Fri, 11 Mar 2022 13:15:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b00389ce2d65e8sm8816459wma.19.2022.03.11.13.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 13:15:12 -0800 (PST)
Message-Id: <68bdb635c877be7b1493ba91940b0a78e342e773.1647033303.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Mar 2022 21:14:57 +0000
Subject: [PATCH 10/16] t7527: delete unused verify_status() function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

fixup! t7527: create test for fsmonitor--daemon

Remove unused function verify_status().

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t7527-builtin-fsmonitor.sh | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index f60e211dbab..ef8777e7f6d 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -303,16 +303,6 @@ directory_to_file () {
 	echo 1 >dir1
 }
 
-verify_status () {
-	git status >actual &&
-	GIT_INDEX_FILE=.git/fresh-index git read-tree master &&
-	GIT_INDEX_FILE=.git/fresh-index git -c core.fsmonitor=false status >expect &&
-	test_cmp expect actual &&
-	echo HELLO AFTER &&
-	cat .git/trace &&
-	echo HELLO AFTER
-}
-
 # The next few test cases confirm that our fsmonitor daemon sees each type
 # of OS filesystem notification that we care about.  At this layer we just
 # ensure we are getting the OS notifications and do not try to confirm what
-- 
gitgitgadget

