Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F20941F404
	for <e@80x24.org>; Tue, 17 Apr 2018 19:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752719AbeDQTQI (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 15:16:08 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41133 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752699AbeDQTQD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 15:16:03 -0400
Received: by mail-wr0-f193.google.com with SMTP id v24so21420505wra.8
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 12:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iREMPPNzoJGrM2sRvNyjpll4Hl4b5ZEBG/V1SoH7yZw=;
        b=e7KhUzlSHhHNMt9CP3BkElGv5xWEi/HjlmYgSqYOoIjlg8IFBV648LKXrCUuqM4Jof
         krj3RG1BznshhVakOAXK678K3b599hZD/gR7+YRMomM3D3KouBWGCFhkX/XM24Q632A8
         jd8FLA20CUAfi/IL3KqLviHY4Eah/9cGhxHZfwNbsUXrWHeWBqVwDtE6r4Sz0qhsLmz2
         +3a9qUi9e3EXnJpqUuzZHoHTJRyXKXjEVUo+/7Wwk2rmRxWjDtTVzU5+eizaEe8peMSr
         5iSVa/1Hpbnmz9HBUCJMM78ibzKq5rknps4Q2RGqD8AOzX+Jzx35daTeCoDxTTNksuCy
         bd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iREMPPNzoJGrM2sRvNyjpll4Hl4b5ZEBG/V1SoH7yZw=;
        b=GfXRgcY1sa1h7tw6bjjm712K8etVI+BwBMhlS7HXTnlPlGtQV7yVkQrB9TU2Zqu0/8
         Aosy1urvGi8O5iJvBKargFK5Azsh7dNhmG+XD7jxdaJj/AIDVsLo6tMYJuQYPw5MJwjP
         MDidpn2rNUGiYvfxtFaAcyOvFeW8vg4D3cYHsXeFFQyR430fV/4uYuCLJISZ8gydaExp
         yfirgLK90pe6iEvYi9gn8f4MyqWvZPmwZTR4OjMBRTQ1GI6cclk/fPmrSj8mD177K4sd
         YwzUFx/nv+/LJMhD8pvuAErlXXi04QSl7A32SOclO/Qqa5hczPOSzgticl7yenNx/0jE
         RZiQ==
X-Gm-Message-State: ALQs6tA3G6RStXJsheYNNiL7Lds9RA7GGWba1tVbnBs3XCWUZZLvvNlZ
        vxFX32GzEkVqzTx4BnCiW4cz848B
X-Google-Smtp-Source: AIpwx49vWb2ujgZIf3fwy90CQhH92GUmuBH65YbsNytCGoqauXe8D9v8rMcQoJuvI62s899c4Z697g==
X-Received: by 10.28.88.146 with SMTP id m140mr1928729wmb.10.1523992561711;
        Tue, 17 Apr 2018 12:16:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id m62sm2745398wmc.41.2018.04.17.12.15.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Apr 2018 12:15:57 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 3/4] git-[short]log.txt: unify quoted standalone --
Date:   Tue, 17 Apr 2018 21:15:28 +0200
Message-Id: <4b11e73a82e65d19054bcef66c0c470822b96067.1523991648.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.252.gfe0a9eaf31
In-Reply-To: <cover.1523991648.git.martin.agren@gmail.com>
References: <CAN0heSru4-VoCTxZ6OHU_jdTs0__xvRmd45Dd0H3L8apMKkW6w@mail.gmail.com> <cover.1523991648.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In git-log.txt, we have an instance of \--, which is known to sometimes
render badly. This one is even worse than normal though, since ``\-- ''
(with or without that trailing space) appears to be entirely broken,
both in HTML and manpages, both with AsciiDoc (version 8.6.9) and
Asciidoctor (version 1.5.4).

Further down in git-log.txt we have a ``--'', which renders good. In
git-shortlog.txt, we use "\-- " (including the quotes and the space),
which happens to look fairly good. I failed to find any other similar
instances. So all in all, we quote a double-dash in three different
places and do it differently each time, with various degrees of success.

Switch all of these to `--`. This sets the double-dash in monospace and
matches what we usually do with example command line usages and options.
Note that we drop the trailing space as well, since `-- ` does not
render well. These should still be clear enough since just a few lines
above each instance, the space is clearly visible in a longer context.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-log.txt      | 4 ++--
 Documentation/git-shortlog.txt | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index be2f10b70b..90761f1694 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -96,7 +96,7 @@ include::line-range-format.txt[]
 	Simplification' below for details and other simplification
 	modes.
 +
-Paths may need to be prefixed with ``\-- '' to separate them from
+Paths may need to be prefixed with `--` to separate them from
 options or the revision range, when confusion arises.
 
 include::rev-list-options.txt[]
@@ -125,7 +125,7 @@ EXAMPLES
 `git log --since="2 weeks ago" -- gitk`::
 
 	Show the changes during the last two weeks to the file 'gitk'.
-	The ``--'' is necessary to avoid confusion with the *branch* named
+	The `--` is necessary to avoid confusion with the *branch* named
 	'gitk'
 
 `git log --name-status release..test`::
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 00a22152a2..bc80905a8a 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -73,7 +73,7 @@ them.
 	Consider only commits that are enough to explain how the files
 	that match the specified paths came to be.
 +
-Paths may need to be prefixed with "\-- " to separate them from
+Paths may need to be prefixed with `--` to separate them from
 options or the revision range, when confusion arises.
 
 MAPPING AUTHORS
-- 
2.17.0.252.gfe0a9eaf31

