Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 436711F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 16:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfJUQBA (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 12:01:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43325 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfJUQBA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 12:01:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so9391536wrr.10
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 09:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7gS/Xuc2yhFrqOwgoQyAzs7fWOm6Cn3jF4fmBXkRM3I=;
        b=UH6z8rPJU4BCqCP7YLpLHZY4ngdQbkFwXYnC29yTSLlV/dgFB5NGmcK9YzUHjJz6rK
         9aiz9wb2D9uxCRdVXHdWs98awalj1QvLNeIHkaAM/z6TYqwu1iqYKOhS+gDJbTlyVmHk
         uwRISj47EjMBuiTGhKMdHnZTt0NimMtTyags65h9ohDludBRHnPf8zq+9Slm79Bapc6W
         T8OAlHHf/juID8VDNHGZBOX9165gx7/tYeCk7mXHJEzGhlcjF1bRpD3J2tl3EUrBpZzY
         t1022SiDEpf6+hzvYQxi1cvl/FCUTJ6h+5UJDZhLVRxNr4I2ieG09l5hnxp41vviRkGz
         o+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7gS/Xuc2yhFrqOwgoQyAzs7fWOm6Cn3jF4fmBXkRM3I=;
        b=kYGvine34KcX9O3DbMB9j16YIPv7YRJhhu1+jBG5Ch4KFnh0adjfTH18UGgd8tRzpf
         SmHbL/q94jmnG7sGT2RE2BCG2fOapGzEv4FwLsPYBQLTDizMaiXgI0Yv12Avdvq3Lvtd
         mhut38kdovXPKkw3ch3k44j1nlsipMQtI8tWewtpQsVZGchH1GL3G4CXzWUYIWUrYJ37
         9BWLhRFzoJe8cP39xcSE15zi0x3ZKJHj7lowOkXJCM5M34+pKnwP+PDFCj10VOqosKez
         rZaU/e/v2KFSWMlF316yuVaJlC9DyfagnnwyRuHTkJ7rDd6fOZi6o21hgfphf3MmfDJC
         9ifg==
X-Gm-Message-State: APjAAAW/vyMJ05z7ASYMASrvdLRDM/8DJAiboGJi906yTswXXbyGRJVZ
        865LeRF8a9ZC8n6zgqjr6xeS2jkX
X-Google-Smtp-Source: APXvYqykGG44EKt2Bqup/7zb9xPcS9bdSNhNIWIdg1eT/ynkBReeH/JWPvyZDjOpNZ+gj78HxXp8YQ==
X-Received: by 2002:adf:ed88:: with SMTP id c8mr20122880wro.214.1571673658301;
        Mon, 21 Oct 2019 09:00:58 -0700 (PDT)
Received: from localhost.localdomain (x4db66cac.dyn.telefonica.de. [77.182.108.172])
        by smtp.gmail.com with ESMTPSA id u26sm16293196wrd.87.2019.10.21.09.00.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Oct 2019 09:00:57 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/5] Documentation: mention more worktree-specific exceptions
Date:   Mon, 21 Oct 2019 18:00:39 +0200
Message-Id: <20191021160043.701-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.rc0.472.ga6f06c86b4
In-Reply-To: <20191021160043.701-1-szeder.dev@gmail.com>
References: <20191021160043.701-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a directory in $GIT_DIR is overridden when $GIT_COMMON_DIR is set,
then usually all paths within that directory are overridden as well.
There are a couple of exceptions, though, and two of them, namely
'refs/rewritten' and 'logs/HEAD' are not mentioned in
'gitrepository-layout'.  Document them as well.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/gitrepository-layout.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index d6388f10bb..1a2ef4c150 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -96,9 +96,9 @@ refs::
 	directory.  The 'git prune' command knows to preserve
 	objects reachable from refs found in this directory and
 	its subdirectories.
-	This directory is ignored (except refs/bisect and
-	refs/worktree) if $GIT_COMMON_DIR is set and
-	"$GIT_COMMON_DIR/refs" will be used instead.
+	This directory is ignored (except refs/bisect,
+	refs/rewritten and refs/worktree) if $GIT_COMMON_DIR is
+	set and "$GIT_COMMON_DIR/refs" will be used instead.
 
 refs/heads/`name`::
 	records tip-of-the-tree commit objects of branch `name`
@@ -240,8 +240,8 @@ remotes::
 logs::
 	Records of changes made to refs are stored in this directory.
 	See linkgit:git-update-ref[1] for more information. This
-	directory is ignored if $GIT_COMMON_DIR is set and
-	"$GIT_COMMON_DIR/logs" will be used instead.
+	directory is ignored (except logs/HEAD) if $GIT_COMMON_DIR is
+	set and "$GIT_COMMON_DIR/logs" will be used instead.
 
 logs/refs/heads/`name`::
 	Records all changes made to the branch tip named `name`.
-- 
2.24.0.rc0.472.ga6f06c86b4

