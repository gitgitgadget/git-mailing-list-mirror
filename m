Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073B6C433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 14:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243600AbiC1OER (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 10:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243584AbiC1OEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 10:04:09 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021755EDFD
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 07:02:28 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d7so20551923wrb.7
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 07:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PP2l5Bl9a6f1fyS1pihI4FXmDEYUOOLXfsvqfku/UIQ=;
        b=ALE+n9j2M3jfY+BH4R/qj4YGVZ3A6G1ZlDtyVGRZTWGIeTqCWafK1yNXFlFMPCaQnH
         nXU9gCKPRRYYIa7U3e+IPU3lrqZ+Wt6xvrxaAWIFKcCWDy6lAgqVjvzyo/2b5Sv9XCU+
         1Dd2ZFQLOovTzh1rfteCzo88rkjYXWjnMrybPXOejbxyYjEHHM69piZ7vYcFblT9DneE
         ENW+79gO1IuqYzzglhXgd2gVddoGF93PyR+/a0vAQ0JCl0MehlAhlieGasAw8MBohMit
         liH3W7Dvl5/KCK3T/V4Qy9W/k3LBWlCJQoL9NMCGsc7giYonH/LpkBZPCAvg3Olle+Tj
         iikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PP2l5Bl9a6f1fyS1pihI4FXmDEYUOOLXfsvqfku/UIQ=;
        b=w7f/0T82xxx7dbGPwoF12FT+VvRnJNiUCpaftQzfQNaWY/vmchLJTCbCsum8eha7lC
         JYyMfS956sjO5xHJ6bR84Th4PF6BPwaG5C+U5DpPlenoaArCZBdugXTm4JPVCC5AmAjj
         n8RNnLuvqXVV6ucMfuXEppaj4gXR6ZvDiAxKl6bGBwbmA1WUWhwIqzugc7bohDnPHA6f
         lOEaX1ADOL1m4hzBFeC7raq9lXj5ShhUwh8sbz8t15fcAaJPlaTlkyTTQxYNxH78HIkn
         a1kWw3c7HmxQygerpL09eB9WKH5yw92M8PJZsANuiJhCRDLzi3tPDnVexgsDyk/N+P+H
         yF9A==
X-Gm-Message-State: AOAM532BhLsRSq6Q7qQn8vkCadBPvB49yOZFIrvunQq0dsUN/jjp4qkw
        UKFHAEWn9bwQCHPvNqtVS6aYAsqh/MA=
X-Google-Smtp-Source: ABdhPJwX7ZAikrIO3SnURgc96ICJwujg2p4fBrbhIFUa0MYPqcc0iXB9/atQfTf4ySHBgolh76doHA==
X-Received: by 2002:adf:e4c4:0:b0:205:aa07:698e with SMTP id v4-20020adfe4c4000000b00205aa07698emr16301208wrm.719.1648476147285;
        Mon, 28 Mar 2022 07:02:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q6-20020adffec6000000b00205b60faeeesm5964098wrs.24.2022.03.28.07.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 07:02:26 -0700 (PDT)
Message-Id: <da1e6de7a9f87c4d5a1970fba17380c3ea7b76ca.1648476132.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1138.v4.git.1648476131.gitgitgadget@gmail.com>
References: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
        <pull.1138.v4.git.1648476131.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Mar 2022 14:02:11 +0000
Subject: [PATCH v4 7/7] docs: mention --refetch fetch option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Calvin Wan <calvinwan@google.com>,
        Robert Coup <robert@coup.net.nz>,
        Robert Coup <robert@coup.net.nz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Coup <robert@coup.net.nz>

Document it for partial clones as a means to apply a new filter, and
reference it from the remote.<name>.partialclonefilter config parameter.

Signed-off-by: Robert Coup <robert@coup.net.nz>
---
 Documentation/config/remote.txt           | 6 ++++--
 Documentation/technical/partial-clone.txt | 3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
index a8e6437a903..0678b4bcfef 100644
--- a/Documentation/config/remote.txt
+++ b/Documentation/config/remote.txt
@@ -82,5 +82,7 @@ remote.<name>.promisor::
 	objects.
 
 remote.<name>.partialclonefilter::
-	The filter that will be applied when fetching from this
-	promisor remote.
+	The filter that will be applied when fetching from this	promisor remote.
+	Changing or clearing this value will only affect fetches for new commits.
+	To fetch associated objects for commits already present in the local object
+	database, use the `--refetch` option of linkgit:git-fetch[1].
diff --git a/Documentation/technical/partial-clone.txt b/Documentation/technical/partial-clone.txt
index a0dd7c66f24..99f0eb30406 100644
--- a/Documentation/technical/partial-clone.txt
+++ b/Documentation/technical/partial-clone.txt
@@ -181,6 +181,9 @@ Fetching Missing Objects
   currently fetches all objects referred to by the requested objects, even
   though they are not necessary.
 
+- Fetching with `--refetch` will request a complete new filtered packfile from
+  the remote, which can be used to change a filter without needing to
+  dynamically fetch missing objects.
 
 Using many promisor remotes
 ---------------------------
-- 
gitgitgadget
