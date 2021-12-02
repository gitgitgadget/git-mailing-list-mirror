Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E5EC433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 17:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376389AbhLBRkP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 12:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348203AbhLBRkA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 12:40:00 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A4DC06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 09:36:38 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso2922380wms.2
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 09:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nL9nfaQRNgp3+nKpsfDXv0L+XfADnJ2jSOK5uvxCCM8=;
        b=qWe67C/zBDRdcBhhRV7Z5D8A2sSXUsAOYaL/PYynNdGd1m3QHj3cXITJsiAmO5RCDE
         RtYBbtOARlE6O6qhFhqlu9viFKqNpE7UN88s66DXVL4U3EbIYEOrtxBsz2sOw5UU87cZ
         dMJoCggTWp12OBzRTU9pKML541HEmmO/Oq3VWl8fgr3LiK01BDkCHo9kh7qkoXKZ0Y5m
         E3qeKUT5KGmZyVYI28FQJ0oA6q6fxQTHUTJ51Y6dhIA89x0oRy8Y8TkocXwOME+LMlob
         avEQjn4qIlBhA6pJziNui3ZVx7YV78qWJ7JiEIkcaTtP3d2tzgoXoT27b28t0WDY9kpL
         CIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nL9nfaQRNgp3+nKpsfDXv0L+XfADnJ2jSOK5uvxCCM8=;
        b=Jx28FHj9usyjadbrspZ2H7A7do0KvdeD/jJxZ9E1edL+b23MB9iB/0dFD2od061W2Y
         0rA70s0BT4hkiEhFpnkm/fsQbwGex3gQjjqceQM8e93zcdGbg39s/fvYm6Q1cT7YqlXK
         l7xxb56NiI4xyEXKBZFIAgVvfKgv94ZS9hMaBKdQPKMCxTzTm73JO59jxmOeg47Jn8GU
         wy9INEvLPM1gZJtt285PRqPlQt7nnZsYDYOo1nvrqnMo/El4hqGdpDm/UvZmBVUQjuhl
         IGXwaysdDacnoHT47TGApC1oiiJ/BlxEH3Yq4RAT+43PDFbsGq8K6HN6GPySNf5kuR1D
         k82A==
X-Gm-Message-State: AOAM533lMBzkAe8uxDJgMVWUh7bD2H81MGgm1fAJb1KOYWOoC28OzBhA
        iAQogzS9ea45m5+o1Fil9YnModgLAfk=
X-Google-Smtp-Source: ABdhPJxLd+YLq1Y61ZuzmNmpcYFz4PamJkCiD5tq2yvbxXp1Ps+1mVXiOIl8j1k0xztLhuJCr0TDTg==
X-Received: by 2002:a05:600c:3c85:: with SMTP id bg5mr8013784wmb.58.1638466596591;
        Thu, 02 Dec 2021 09:36:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x4sm2678752wmi.3.2021.12.02.09.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 09:36:36 -0800 (PST)
Message-Id: <062481ffece8415260c84fb4fd3a68a566c15135.1638466593.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1145.v3.git.git.1638466593.gitgitgadget@gmail.com>
References: <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com>
        <pull.1145.v3.git.git.1638466593.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Dec 2021 17:36:30 +0000
Subject: [PATCH v3 2/5] test-ref-store: don't add newline to reflog message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

By convention, reflog messages always end in '\n', so
before we would print blank lines between entries.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/helper/test-ref-store.c      | 5 ++---
 t/t1405-main-ref-store.sh      | 5 ++---
 t/t1406-submodule-ref-store.sh | 4 ++--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 3986665037a..5ac33dfb598 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -152,9 +152,8 @@ static int each_reflog(struct object_id *old_oid, struct object_id *new_oid,
 		       const char *committer, timestamp_t timestamp,
 		       int tz, const char *msg, void *cb_data)
 {
-	printf("%s %s %s %"PRItime" %d %s\n",
-	       oid_to_hex(old_oid), oid_to_hex(new_oid),
-	       committer, timestamp, tz, msg);
+	printf("%s %s %s %" PRItime " %d %s", oid_to_hex(old_oid),
+	       oid_to_hex(new_oid), committer, timestamp, tz, msg);
 	return 0;
 }
 
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 49718b7ea7f..a600bedf2cd 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -89,13 +89,12 @@ test_expect_success 'for_each_reflog()' '
 test_expect_success 'for_each_reflog_ent()' '
 	$RUN for-each-reflog-ent HEAD >actual &&
 	head -n1 actual | grep one &&
-	tail -n2 actual | head -n1 | grep recreate-main
+	tail -n1 actual | grep recreate-main
 '
 
 test_expect_success 'for_each_reflog_ent_reverse()' '
 	$RUN for-each-reflog-ent-reverse HEAD >actual &&
-	head -n1 actual | grep recreate-main &&
-	tail -n2 actual | head -n1 | grep one
+	tail -n1 actual | grep one
 '
 
 test_expect_success 'reflog_exists(HEAD)' '
diff --git a/t/t1406-submodule-ref-store.sh b/t/t1406-submodule-ref-store.sh
index 0a87058971e..b0365c1fee0 100755
--- a/t/t1406-submodule-ref-store.sh
+++ b/t/t1406-submodule-ref-store.sh
@@ -74,13 +74,13 @@ test_expect_success 'for_each_reflog()' '
 test_expect_success 'for_each_reflog_ent()' '
 	$RUN for-each-reflog-ent HEAD >actual &&
 	head -n1 actual | grep first &&
-	tail -n2 actual | head -n1 | grep main.to.new
+	tail -n1 actual | grep main.to.new
 '
 
 test_expect_success 'for_each_reflog_ent_reverse()' '
 	$RUN for-each-reflog-ent-reverse HEAD >actual &&
 	head -n1 actual | grep main.to.new &&
-	tail -n2 actual | head -n1 | grep first
+	tail -n1 actual | grep first
 '
 
 test_expect_success 'reflog_exists(HEAD)' '
-- 
gitgitgadget

