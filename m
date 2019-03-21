Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C751920248
	for <e@80x24.org>; Thu, 21 Mar 2019 13:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfCUNRc (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 09:17:32 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:42309 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbfCUNRc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 09:17:32 -0400
Received: by mail-pg1-f171.google.com with SMTP id p6so4165330pgh.9
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 06:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FGeH/6CWpqekXS3GFFV/0h8ujAtb811g9fdEfu6/xKo=;
        b=LzMhy+EGXDYiHoziKBXa8G4tqG60ckSxkJ/iA6b0E2qgQDJhSSo6+7j8E0Cdw26A4F
         VsgerGzV3ydf84S0dSoxMA2XW9h1RzpTLTvfEWZyLgJJmgcQJS8Bysp2A9VU5A+25lEt
         UsZz7eLtzIuL/Jo5d2xYbiSsip3tqJRzjnmb4MxUx0BhhS7/ECQlC5F81E7I226WAp4H
         XmmRLjMa6vj155SjgFCvDL8g3UpCtCKB0eov2Kyxf4ymf4pvWqjtw08Cl4ZtF/9Ot4TQ
         8F7499Eogk+uV2cGQjYbZfJ3qxSp1KrwVv4qxKIqRHQ34e4/A+ID6pfIHo0DdQWaQy/5
         nRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FGeH/6CWpqekXS3GFFV/0h8ujAtb811g9fdEfu6/xKo=;
        b=hvJBwJmTGRYmXDPT+vRGx8LHpCmwAXXjefKIASs1r24riyPzOdr9XW6pbHT77Zl5e4
         ealtJxT5h5peja3VOSIx4+57frAhzX/z7rhtK2MPqVWi06F8rdIayS3iisEuNnug/9xi
         tmjKfDddlE3ZhRsrG0CQlC/y9XiBFWAxv74MAH2NrxzYILUb4Ux/GiSvCGUJjtJaXGZ8
         Ytpv/aaxGP3fsl8cnj2yooONByfP/FywcKgY+zacv/S4m5HakAgFh3FaW1IaTgtoZyYC
         Gcl9dAYUQpcKOMcUA2rkfDzgjy0RtaKDTTR+GSgnvdJqVgnC/+lrzEQBnIPIqUKKrerf
         U60Q==
X-Gm-Message-State: APjAAAXNHXqu10X8405kozQIa8Ovg7NYrS5IOiZCJeNpoI8YDa+vyS5B
        8bzZrFBABH0InJTyUsH9XHlpMsrq
X-Google-Smtp-Source: APXvYqxGhpdM9zquW/7hAEzMNdDGhPPz9wsaE3pPSa2Nrpkzj3hOJhMqIEIhRa7c/NJ8VFCxwDh7xg==
X-Received: by 2002:aa7:8b96:: with SMTP id r22mr3240270pfd.223.1553174251736;
        Thu, 21 Mar 2019 06:17:31 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id u20sm3217083pga.76.2019.03.21.06.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 06:17:30 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Mar 2019 20:17:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v5 03/26] doc: document --overwrite-ignore
Date:   Thu, 21 Mar 2019 20:16:32 +0700
Message-Id: <20190321131655.15249-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190321131655.15249-1-pclouds@gmail.com>
References: <20190317124926.17137-1-pclouds@gmail.com>
 <20190321131655.15249-1-pclouds@gmail.com>
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
2.21.0.548.gd3c7d92dc2

