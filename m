Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 446E91F453
	for <e@80x24.org>; Wed, 30 Jan 2019 09:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbfA3Jss (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 04:48:48 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41146 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfA3Jss (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 04:48:48 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so10820976plm.8
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 01:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qAzFqgUwqjAHLnU7Ja5dEQliPy6wwQ9QDXW/m4Sboe8=;
        b=nwv0NFoSks/g6PJbjm2ed81wciPN/QNbRIbBknyZY9Am7EMIhHGK3O7EFfa1xJeHCk
         9MoyWA9U2WgtU6obTX4qWl0A7zKFy9eplPnpRtttYX38s4knb9XJpC7sZB0tZ++nsJ50
         UGL1vu/oVZphVJvebRh9NwfTdB1ziXg9NGPcx1CcdHHBGGfOBl3bhDe9dx4FtwreBqBn
         JTE75UFF4NgY0e1xDcdYkF9PHDYbSw4oRwMp4P5Zx0r7B4dX2Iy0uxVFYYyJ3gkJe4vj
         mICkMS09PqxPzAa5bLWjdQKvONAVJ4sCwvuc2TrHeQcPLX/2pLR/4ykTP63s0J7SysZp
         DgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qAzFqgUwqjAHLnU7Ja5dEQliPy6wwQ9QDXW/m4Sboe8=;
        b=gZT9cr9KfipUDpMDK/+jn1BgMn+NiQnSQ5rNfpWhXKxHZ3UrR16LWWDm15FrmEfLrp
         rrxmiOWx1c0bt6a22PLwoFZb/uqqNX01aO0ecSkS17XMcKtu1F0AeAhOkL2IEKvWgYit
         q3SCFoSBDmupSWxPBmpnL0YkOd597eUY2ixlOpc0Zo9vRDBWjd8Dmp/Znkcd/tzNY2An
         FY1o3ivSpP9cdHIdN5iCtge+38fQy8YSKba7RfwNk8otDteH3ujsX0UTjIF5BGusRHqc
         vPvg24XgvbPWHSt/eC9WLUcYTje766k9PxDLuVzuJ4yUw9jwZlOlOaOgkVkeQ5jpA6mg
         fQoA==
X-Gm-Message-State: AJcUukdR1y5XAoCdlwJIyS7VIaWFcLuM2RXjQj3aVEVrRTvQGfBQdO4f
        vUJFPDGZLHjwZojP71YjohGuplY2
X-Google-Smtp-Source: ALg8bN5xY/ihRrGOUkmjZFnvu1U4xZUnxKTTnYp6Y/6a8W5UO+Qutu9ghnXKpNM/Wx2VW8YimmTeqg==
X-Received: by 2002:a17:902:fa2:: with SMTP id 31mr29866285plz.75.1548841727290;
        Wed, 30 Jan 2019 01:48:47 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 19sm6026253pfs.108.2019.01.30.01.48.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:48:46 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 30 Jan 2019 16:48:42 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/19] doc: document --overwrite-ignore
Date:   Wed, 30 Jan 2019 16:48:14 +0700
Message-Id: <20190130094831.10420-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190130094831.10420-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I added this option in git-checkout and git-merge in c1d7036b6b
(checkout,merge: disallow overwriting ignored files with
--no-overwrite-ignore - 2011-11-27) but did not remember to update
documentation. This completes that commit.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-checkout.txt | 5 +++++
 Documentation/git-merge.txt    | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index bc7fbdb8d2..9ac01f7967 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -270,6 +270,11 @@ Note that this option uses the no overlay mode by default (see also
 	out anyway. In other words, the ref can be held by more than one
 	worktree.
 
+--[no-]overwrite-ignore::
+	Silently overwrite ignored files when switching branches. This
+	is the default behavior. Use --no-overwrite-ignore to abort
+	the operation when the new branch contains ignored files.
+
 --[no-]recurse-submodules::
 	Using --recurse-submodules will update the content of all initialized
 	submodules according to the commit recorded in the superproject. If
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 4cc86469f3..0480e9d0f0 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -87,6 +87,10 @@ will be appended to the specified message.
 	Allow the rerere mechanism to update the index with the
 	result of auto-conflict resolution if possible.
 
+--[no-]overwrite-ignore::
+	Silently overwrite ignored files from the merge result. This
+	is the default behavior. Use --no-overwrite-ignore to abort.
+
 --abort::
 	Abort the current conflict resolution process, and
 	try to reconstruct the pre-merge state.
-- 
2.20.1.682.gd5861c6d90

