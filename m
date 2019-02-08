Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F005F1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 09:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfBHJEg (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 04:04:36 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40964 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfBHJEf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 04:04:35 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so1304050pgq.8
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 01:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qAzFqgUwqjAHLnU7Ja5dEQliPy6wwQ9QDXW/m4Sboe8=;
        b=Y9U03pwYzJ24bn9FK/RU5D/0NEbgTuFE9J6MoUtGGPGUWvwpj7jjj/l+xALq+PpSO3
         2UFlm2kHYycwk1D9lMEvkCnbxi3Ix1XVEA2sNxoCLbvktYWKkibdzRfzWeAIznm52Ad3
         gsDAQ2hxf/uHRQytmUCTsc2U+a4Ga+9WD1jPAnImm1nk3LbTbznqZiz0AFhSpdaPnfYI
         zvuQvNkBQQGSIoshVPtTRp5gEPi2RU7tZh07KoLcAq4Srb1ci/4D/wV8JUkadnEqDmTv
         FCwvTM71tKxFyPEho4WJmqlGPPLvZdcaMUOWKDsrPCSpDzLfmxG5COxjOBv4HqB9w3mG
         86qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qAzFqgUwqjAHLnU7Ja5dEQliPy6wwQ9QDXW/m4Sboe8=;
        b=DYBePsj4tb+SGjy6jNjZwj3An9AWPATWkQXWh52OJ0enAJAkNxkVJTJgQm1QlI2C42
         Luqn3XEp+qff/rHXDgVT+iMGFpi2Kelgfg8cx9SIpaQKxr5iqIve/m01aZS33sJiuIcL
         CPcHIMloqL4/TrsMgHGnmoow07YwAKs0sgp7PMqb/FcjTO/6udOXaF0P/svCoSSTFOHX
         Vde1NBX1V/nR8E0OvpVybT5cE60CRnTIuejxauI3H+r8K3CLOuS8Y/3B2Pfqjh9iXAuE
         QcTQXlDQ4YGOChlA0/73qKZfxJ1o36M/mz4qcD3NyXK58l9y1y4mM12IiMZ6BRmLb4b+
         vXmg==
X-Gm-Message-State: AHQUAuZ1IENvVCOeW2W3RXL9sLYK+sNcoEti5eD/TsjfPLUn4oTTNEms
        C8cEV2AT/26IaghKVA/9lqQO8C6E
X-Google-Smtp-Source: AHgI3IaZi8p7rSJ+IglAxT4/+mmaehC8ah3bKKcqKXifgHmrEcJEdE8OhL5oSQUtEnHfSAd4pQxBuw==
X-Received: by 2002:a63:ea4f:: with SMTP id l15mr9887719pgk.102.1549616674964;
        Fri, 08 Feb 2019 01:04:34 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id s9sm1547480pgl.88.2019.02.08.01.04.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 01:04:34 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 08 Feb 2019 16:04:29 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/19] doc: document --overwrite-ignore
Date:   Fri,  8 Feb 2019 16:03:44 +0700
Message-Id: <20190208090401.14793-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190208090401.14793-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
 <20190208090401.14793-1-pclouds@gmail.com>
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

