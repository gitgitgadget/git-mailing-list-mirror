Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFA601F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 16:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733291AbeKOCgH (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 21:36:07 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44495 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeKOCgG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 21:36:06 -0500
Received: by mail-pg1-f195.google.com with SMTP id w3-v6so7580673pgs.11
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 08:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5yf6kjv1ZWqr/Qa47VR28fELsLqQ5bG3RA5QipW5P0A=;
        b=FWGSb/ceWmNI8I5CtuXEVUQQlGPjbjUD+Tt8x8MgkKZ4rYWuu/qs3e0HB+F7ojPyoW
         32Wk1cvkl+ZjButeTRv1iXWnqv7F5sNnXUOVOUzP/Tj8TjjBF0onLecrq5zyJtiQd/Ct
         4oKfqudseMYs0vungW9qZKVuMqwwS64XT4h8gqB8Oq6TwU4qYM7y7Yvp63YdYOnU39XA
         PGhkrWd99CXVmytNeZ1TzapOiCBf9jyrGhCPUIBY9HboWUA6aiCQxEp7FcoUgLJgC7tf
         aH8aMap/wzkXg0eUsTms9WlISiorhD8UXI+r+cn11pVrWYT+u4f1ZgfTT/T+WAtZ+q8L
         evMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5yf6kjv1ZWqr/Qa47VR28fELsLqQ5bG3RA5QipW5P0A=;
        b=IrCZWbdrmuKXl9i1Fu31yZVm1xamCubmvPsmY5VJEd8hNWTf8rdmmCJfb9yUI/Rekp
         YoMfrU7YLEz9d/Gtyy97JfClmZ/DEf4VfB5FjIqkesx2MY7T3BGFSrZRfnlFj6LrshtQ
         Ze7MEf+9hlDSSrEtz9TAKVZxcfiq+RaMcZKsqL5FDt2y8EJlmamlNtyaS6pKC+DAhkbh
         NarzLDV9Hxs4kdR5icdRBYAxdYI2rcwtV2zce1is8NPgjvl4Ky9cNchlKoPK6ztq+Z8h
         mzhq06IY7eN1iHfmwC8s1sd/SrBgVwswTvD8p77Xsi0NGE+3BCORFEB3wnGE7HCruH2k
         Or1A==
X-Gm-Message-State: AGRZ1gL4NiANcVJgKGYc+AzT/CgIRXt3TJ7u1z4G8d0WA/xeyaUuNACv
        eTcdEz9mNS1girfSbwcRF7HxBXw7
X-Google-Smtp-Source: AJdET5cGfdsBnpyuAcIhI4Kbcgv7xQdmWmyB/QLClQZy+/EGUOUpFcJrsPmKKxLfy86z85bC7jU9tA==
X-Received: by 2002:a65:448a:: with SMTP id l10mr2352107pgq.387.1542213131128;
        Wed, 14 Nov 2018 08:32:11 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id v5sm27526375pgn.5.2018.11.14.08.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 08:32:10 -0800 (PST)
Date:   Wed, 14 Nov 2018 08:32:10 -0800 (PST)
X-Google-Original-Date: Wed, 14 Nov 2018 16:31:59 GMT
Message-Id: <b801dc80276cf6fd9727f0ead7054c5ea58465b3.1542213121.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.73.v2.git.gitgitgadget@gmail.com>
References: <pull.73.git.gitgitgadget@gmail.com>
        <pull.73.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 4/5] tests: do not require Git to be built when testing an
 installed Git
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We really only need the test helpers to be built in the worktree in that
case, but that is not what we test for.

On the other hand it is a perfect opportunity to verify that
`GIT_TEST_INSTALLED` points to a working Git.

So let's test the appropriate Git executable. While at it, also adjust
the error message in the `GIT_TEST_INSTALLED` case.

This patch is best viewed with `-w --patience`.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 93883580a8..3d3a65ed0e 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -51,10 +51,15 @@ export LSAN_OPTIONS
 
 ################################################################
 # It appears that people try to run tests without building...
-"$GIT_BUILD_DIR/git" >/dev/null
+"${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git" >/dev/null
 if test $? != 1
 then
-	echo >&2 'error: you do not seem to have built git yet.'
+	if test -n "$GIT_TEST_INSTALLED"
+	then
+		echo >&2 "error: there is no working Git at '$GIT_TEST_INSTALLED'"
+	else
+		echo >&2 'error: you do not seem to have built git yet.'
+	fi
 	exit 1
 fi
 
-- 
gitgitgadget

