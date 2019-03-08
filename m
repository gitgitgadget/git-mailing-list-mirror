Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90B5A20248
	for <e@80x24.org>; Fri,  8 Mar 2019 09:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfCHJ6Q (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 04:58:16 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:45838 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfCHJ6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 04:58:16 -0500
Received: by mail-pf1-f175.google.com with SMTP id v21so13783690pfm.12
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 01:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ad5uVFtYShoS/2dWto1ZD6g9VMlCCbIo/E6zdDjm35M=;
        b=SQiHr3ajMg540RQjaeI1Vk2ovOVp4jnM6fzbqppbuQVKkzO7KKQD6z7xPLLnkpJKTv
         l/MW6fXuzh/M/D4IH/Jo9hsRMsPRBOIwBoNodVO7p40FhA8uu8IFEJkb4T5ekPeid/vB
         Vw77VHeh145YyGQ6dNpfW+0vrUwBwE6mCG55yycGtRlij5v/MG350Rx7ZmqMhMc91hoH
         7kxpSxgbYx/7Zg53FX0clKLtTswBCQE+b3ZLXTg69R01f30f7s6vp1mMBMft84XpkHvq
         iXtDqOHPRmYKjMHhv7ri/BP9FkBl6Y4LkszI9mh5KZPkU0GDAFfezQsrQXrUhWY45JAW
         AFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ad5uVFtYShoS/2dWto1ZD6g9VMlCCbIo/E6zdDjm35M=;
        b=hlGO2xj6rlD3or7LXrgzLCapeT6BRx8Au75ApfUIEqaYtWNgya5axFm3YmFsBk20XY
         tV2UM19RKU/jYL8NtzPVGc8G0pe2Oa12Jd7BFTYP9JIHZ/BVi/v3L4Dv4ywe8uVxEnRL
         BJqjXETOoZWujMZddwZdz/UaJmfY0gfwLWpEyQUp5sjwNlGvUswwL20uTeehiWv4eVNi
         pOdM248M/VDWUfhCGlrWUuStuQ/hAS3vulJsWu5X2JoSqWl4gieFsOaexGg4sXIMXN6X
         xovsRGjbtgdICt3AAZcpmCfycp63AOzqgwBOW0sc2dSY7PYAY+7hy1BERmVtUDol823U
         3jEA==
X-Gm-Message-State: APjAAAWCW03D78xwQhChrCKBc6dsDngNq+E1SFMWclzJ2R0sK5N0rlqe
        IPX/hAruq92GTW8C6lo/Ciw=
X-Google-Smtp-Source: APXvYqwhRASV8kQh/fjg+vBYw8HEwya9WpEF2JL5Kq6vMZtVrwG3khkbsibkqiw8uc2sRywL05YX0w==
X-Received: by 2002:a63:d205:: with SMTP id a5mr15990619pgg.142.1552039095379;
        Fri, 08 Mar 2019 01:58:15 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id f15sm11524493pfa.11.2019.03.08.01.58.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 01:58:14 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Mar 2019 16:58:10 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 03/21] doc: document --overwrite-ignore
Date:   Fri,  8 Mar 2019 16:57:34 +0700
Message-Id: <20190308095752.8574-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190308095752.8574-1-pclouds@gmail.com>
References: <20190208090401.14793-1-pclouds@gmail.com>
 <20190308095752.8574-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I added this option in git-checkout and git-merge in c1d7036b6b
(checkout,merge: disallow overwriting ignored files with
--no-overwrite-ignore - 2011-11-27) but did not remember to update
documentation. This completes that commit.
---
 Documentation/git-checkout.txt | 6 ++++++
 Documentation/git-merge.txt    | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 28817cfa41..5280d1f9ed 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -271,6 +271,12 @@ Note that this option uses the no overlay mode by default (see also
 	out anyway. In other words, the ref can be held by more than one
 	worktree.
 
+--overwrite-ignore::
+--no-overwrite-ignore::
+	Silently overwrite ignored files when switching branches. This
+	is the default behavior. Use `--no-overwrite-ignore` to abort
+	the operation when the new branch contains ignored files.
+
 --recurse-submodules::
 --no-recurse-submodules::
 	Using --recurse-submodules will update the content of all initialized
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 4cc86469f3..6a9163d8fe 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -87,6 +87,11 @@ will be appended to the specified message.
 	Allow the rerere mechanism to update the index with the
 	result of auto-conflict resolution if possible.
 
+--overwrite-ignore::
+--no-overwrite-ignore::
+	Silently overwrite ignored files from the merge result. This
+	is the default behavior. Use `--no-overwrite-ignore` to abort.
+
 --abort::
 	Abort the current conflict resolution process, and
 	try to reconstruct the pre-merge state.
-- 
2.21.0.rc1.337.gdf7f8d0522

