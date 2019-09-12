Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB6871F463
	for <e@80x24.org>; Thu, 12 Sep 2019 22:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbfILWMv (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 18:12:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44275 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbfILWMt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 18:12:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id q21so16817376pfn.11
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 15:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y/bSt9wqim+DK7FYQyKxBrrZ36Af7LvzQsYgOveftBo=;
        b=WdMqm3rbJsZoOy8UyOysPCFquvLAD34pkFJXQcT5GYm/R+Lu+izHI0gh0D1lAKi1+x
         Ab9xoSROX1jZVe9LSQgjKwXpNF7Ui7LdzZNR+M+Bbfyc/EOP+79FYgFPr7U3V333Azgd
         3Or35dJJv3c5rWjLhLu8feyNK0sq7d02aEVB0BO2InS0AQtUiDi8kqgDbm0qs94l4dFk
         wLvQoTUc045OTDB/VhZDOO9AteT1R05cVqL6dVka2yf8QVuaDGIZa3IngKe2pCKB5h9U
         ww/vaGheoDNVbN8/zm3oINHoNH8V9rJSziwLZ3iLmEXsF+X3xdmhJ+4QznwBOYwKlfIl
         lBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y/bSt9wqim+DK7FYQyKxBrrZ36Af7LvzQsYgOveftBo=;
        b=E9bnajXCDF/TQBm76ziJ9d3RUfvABnjuscE3NbiODb2DyT1EwiukSJNUF+EPNMy7cy
         QFrTAYh9SSsqRFCCk0RNaINtlWXfVY/wc0lcdifNR0b6cV6RqGnsJo6w5MMiyaq/TT5e
         7UdiVBRrzHbo6F9RvOYqexOm71G9ZCp8VTrAOvt7IkWJhXWsKdqAAPPmGEkESj2CbZw1
         kzQt4uGNGrLs6PFH5ZAns85xVNgmqbkEd4h46n38WkQwdK7TyDWeB6zG3Tk6N5DKFPxy
         inbHO07uJgXGi8jiOeTL7PyGXRiNPMLxCt0NSDOhrpyzVEbv7KpSfS7FvYtPyjrqnFhU
         yYSg==
X-Gm-Message-State: APjAAAXEQOz/uN+BkExBapJHGoE4C7jIrJ18WZ2qgi3p/jTjNAi6naGz
        UqLOyQqxoxCrngNEu7vHwKPTkJq9P+k=
X-Google-Smtp-Source: APXvYqyUxdVNXZVydagM7ugXLW4f/m29KWdStPJ1awORqJHI0x9zQrTElqDAr46miiq4ZxGsL71Dtw==
X-Received: by 2002:a17:90a:983:: with SMTP id 3mr1063019pjo.57.1568326368483;
        Thu, 12 Sep 2019 15:12:48 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id y13sm24358188pfn.73.2019.09.12.15.12.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Sep 2019 15:12:47 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 02/12] dir: fix typo in comment
Date:   Thu, 12 Sep 2019 15:12:30 -0700
Message-Id: <20190912221240.18057-3-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.173.gad11b3a635.dirty
In-Reply-To: <20190912221240.18057-1-newren@gmail.com>
References: <20190905154735.29784-1-newren@gmail.com>
 <20190912221240.18057-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index d021c908e5..a9168bed96 100644
--- a/dir.c
+++ b/dir.c
@@ -139,7 +139,7 @@ static size_t common_prefix_len(const struct pathspec *pathspec)
 	 * ":(icase)path" is treated as a pathspec full of
 	 * wildcard. In other words, only prefix is considered common
 	 * prefix. If the pathspec is abc/foo abc/bar, running in
-	 * subdir xyz, the common prefix is still xyz, not xuz/abc as
+	 * subdir xyz, the common prefix is still xyz, not xyz/abc as
 	 * in non-:(icase).
 	 */
 	GUARD_PATHSPEC(pathspec,
-- 
2.23.0.173.gad11b3a635.dirty

