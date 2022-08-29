Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CC0ECAAD8
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 20:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiH2Uy1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 16:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiH2UyX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 16:54:23 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C2582845
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 13:54:22 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id k17so4820940wmr.2
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 13:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=dVT4Komgau6X4o+PgTxTUfj/QefvKOJ79AQA8TUj2zQ=;
        b=VsHRjFNFrYGVTHxVZHkrCWeDcRiW8yXLVuuNs4JMYHNFMT49qzDc4O5gGTEq+JXzul
         pAjzWqJhPq+W5aItOD++UJupeZBnL+3UzeVR41bkKxm+uF1MnGWnuBDaeaMHhI41b1R2
         OGIS2sLvt3HyPyPMeKl/7xEjUWn1QIXrBHF0qzMrJ0+qqUWijTSpnKxVEl/e3s2W/Kp7
         0SFc1nWri23x6TMpHi05EfnvY6pG1PmxEhCaWRDWedblMzIOJheHwleBHoRaaQpywNtt
         hEi1+oC9cjeROyr7QnasR+Bsjr2TkeSVx/L1UVrD0sKfUrwB3SFF+XHMgNA9gJQdhPWZ
         J0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=dVT4Komgau6X4o+PgTxTUfj/QefvKOJ79AQA8TUj2zQ=;
        b=nfajSEadvkAPkBmdowHyJXHrfOuqHKi3dvFDQ+TFeowBh9iGin/SvmLs6wyuO26+Nm
         RucOydH/5kqKhanfFNfQgMEaquXSgahcjCv0OjNgyltgHn1Dz6qUk8EfcP4CFc/U4RBH
         p0BUqgK+Ib/+68R9tw09RE+2e4lJZ6kOueZ4GDDa09WSH8tuCw0bCXbopQQjpEFxlwR1
         9tClPP+zDdML0GE4h6VlnTcm6negZolFVB+Jy2JDTS4MAhT68h/pxklq8NiyBd2iKQqD
         vS8KXbWUFLkyPxv0JfMGrNymimmS3cSsIygnvu+V/ZubUVCYGG+KR7kuBHWtl9zAM3qB
         kjHg==
X-Gm-Message-State: ACgBeo02lbG0ix0RSCwHt8N+jxlFgW7x5Db6RJBVtDty9g5GnXv2rtFx
        qYf7AToa6oYMZ3QZwNXXendqD2/VPko=
X-Google-Smtp-Source: AA6agR4D39Kgq3gG6BvkXQHIohr8pWSfHujf/UCzHKCBTVAQTRYrjxrVta8Q6T3JVrrM57ChK5JyAw==
X-Received: by 2002:a05:600c:3ac3:b0:3a5:e1de:5994 with SMTP id d3-20020a05600c3ac300b003a5e1de5994mr7896424wms.133.1661806460477;
        Mon, 29 Aug 2022 13:54:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i10-20020a1c3b0a000000b003a601707174sm10221990wma.33.2022.08.29.13.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 13:54:20 -0700 (PDT)
Message-Id: <d8a2faf9ce7de2562424181109120a6d84b0e470.1661806456.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
References: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Aug 2022 20:54:13 +0000
Subject: [PATCH 3/6] t5617: drop references to remote-tracking branches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

It has included submodule cloning tests without remote-tracking branches
tests since f05da2b48b (clone, submodule: pass partial clone filters to
submodules, 2022-02-04) at least. Rename it accordingly so that we can
put future submodule cloning tests there.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 ...617-clone-submodules-remote.sh => t5617-clone-submodules.sh} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename t/{t5617-clone-submodules-remote.sh => t5617-clone-submodules.sh} (97%)

diff --git a/t/t5617-clone-submodules-remote.sh b/t/t5617-clone-submodules.sh
similarity index 97%
rename from t/t5617-clone-submodules-remote.sh
rename to t/t5617-clone-submodules.sh
index ca8f80083a2..b5c66cb18cb 100755
--- a/t/t5617-clone-submodules-remote.sh
+++ b/t/t5617-clone-submodules.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='Test cloning repos with submodules using remote-tracking branches'
+test_description='Test cloning repos with submodules'
 
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
-- 
gitgitgadget

