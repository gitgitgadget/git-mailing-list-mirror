Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F1371F461
	for <e@80x24.org>; Thu, 11 Jul 2019 16:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbfGKQJP (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 12:09:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55483 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728456AbfGKQJO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 12:09:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so6233920wmj.5
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 09:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZK6F8I9MMRXb1nyoGtw4TkkqOifbnYF7o0+q1l/W/JM=;
        b=kAMbPj1JfZ8kzpL/Ffgo6M+wohD5b/767zojEW6hIEiiF2pJIr6xaXEpQEFHp3m6XK
         M5Pf/LiL2ZAIesvThja2d51QYPWQiyz4VXkDe+iVCSzuvNnqwOw8fE0+TMIch9CBX/SU
         JGY6j1C3cQt5wMI2SSzZJk/2sOUVhcKXx0wksnxiXfRg5+U6KaOsgdzKdveNWzmp7PHH
         nY8PPVhvgtpdxJnOADQ2EkfdD3QtzUOSmiPLBpU+LNkNkz/QhqpbpZlFaCk+j8si5rpQ
         r9Cvpe3L0to9tFLBnyDENup3N4nMoZ/HR7WTBVO6ji2awXOj7pAKuokLBo9mRDurjlX2
         u8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZK6F8I9MMRXb1nyoGtw4TkkqOifbnYF7o0+q1l/W/JM=;
        b=OleCviMNiHExroIhACChoM/lbSisXlXjk6QqrxE7l2wWZPo0B145fwI/SJNgeluU3c
         Gxy1B1jeEShsEpoFWbNtL3HZK+3aG2wRpuholHyR9thJfyEY7YwenpClpnMlcnGuBcKw
         qjcHdVJO6D5TGMesHRKY6YGobZFP4+JSsaOt5sGDNgKIhS1HSW7vw+tpb+1aa4qRHnF9
         N5VimQ6FvM0ZAJJjS6jvcV/LlfPC1aRHNtqbFdD2QJcx8sa9b8QtwNlo+sTlQYuoVlUG
         QkjHqsoES85PU+qraoU11wQtJ4+/TkPOJTCNnajWJSyfoUCq1ye2XpfpKOJVffZwpZW0
         EXpg==
X-Gm-Message-State: APjAAAXGYhbpFDPaqiYVCKQgQZ5HgRmZDrMSVnCQCxC67pWXr7b0BaOj
        a8VrrnXE0muA6iGfJuJ1RbhVazrel0k=
X-Google-Smtp-Source: APXvYqyUecXoSD+//bP7PvxPP9pCbb9zBtMBqGylG+SziJE8IwJkHh86IIYu/4nqupr09RXNuU7hLQ==
X-Received: by 2002:a7b:c0c6:: with SMTP id s6mr5216790wmh.115.1562861352135;
        Thu, 11 Jul 2019 09:09:12 -0700 (PDT)
Received: from localhost (host232-157-dynamic.24-79-r.retail.telecomitalia.it. [79.24.157.232])
        by smtp.gmail.com with ESMTPSA id e7sm6208336wmd.0.2019.07.11.09.09.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 09:09:11 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 08/14] range-diff: fix function parameter indentation
Date:   Thu, 11 Jul 2019 17:08:45 +0100
Message-Id: <20190711160851.14380-9-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a
In-Reply-To: <20190711160851.14380-1-t.gummerer@gmail.com>
References: <20190708163315.29912-1-t.gummerer@gmail.com>
 <20190711160851.14380-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the indentation of the function parameters for a couple of
functions, to match the style in the rest of the file.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 range-diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 48b0e1b4ce..9242b8975f 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -148,7 +148,7 @@ static int read_patches(const char *range, struct string_list *list)
 }
 
 static int patch_util_cmp(const void *dummy, const struct patch_util *a,
-		     const struct patch_util *b, const char *keydata)
+			  const struct patch_util *b, const char *keydata)
 {
 	return strcmp(a->diff, keydata ? keydata : b->diff);
 }
@@ -373,7 +373,7 @@ static struct diff_filespec *get_filespec(const char *name, const char *p)
 }
 
 static void patch_diff(const char *a, const char *b,
-			      struct diff_options *diffopt)
+		       struct diff_options *diffopt)
 {
 	diff_queue(&diff_queued_diff,
 		   get_filespec("a", a), get_filespec("b", b));
-- 
2.22.0.510.g264f2c817a

