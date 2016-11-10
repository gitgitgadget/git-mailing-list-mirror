Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5DCB20229
	for <e@80x24.org>; Thu, 10 Nov 2016 20:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936135AbcKJUen (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:34:43 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35142 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933893AbcKJUel (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:34:41 -0500
Received: by mail-pf0-f180.google.com with SMTP id i88so151077614pfk.2
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U23MMmHZRAHVCIOQLP6zG9wYtlhit9G7rGqJ73Ou4dY=;
        b=AHh54r2vl3RO81Agu0MOKsrrvZpDYGAbHcBcZLQF2C0kHiS2vGGkVTJmOeyP5hLzGN
         VpLUrOWj6mnlq06h33IDZplwrT2u6ZC7RA0eAFSgO42pc+kFjdb4SmbohODM5VkcKfrr
         4FsoLrB7HlfXPaabC8Y/i8q1G5qLUuwbx/NkiFUeWBA50Ky+8yxINQFNnD9GoaRzFd/M
         MwJrg2B6+IBbEXfEacuY0BypmCluKc8Hm13ReQmZwxn02HlKs7ijicG2wYDC6vKas8SI
         ICYjm0LdIv5POVfirR5FlaTbw5SRRUKgoKqi36faRDI8zUIw/iVpohAAVYwHfcUXWdVu
         fOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U23MMmHZRAHVCIOQLP6zG9wYtlhit9G7rGqJ73Ou4dY=;
        b=ikgX7wL9Abcfzny4totgyh3ZzHOlMBWA4k2FfLax9RfXL6QniFSeaLVwsSRVGK6V6J
         eYbM12kWZoZdO1id9kd4FDGFmKBpgfZ3RuxIWCfEx42PZQUzQrpdJuzawMZ2Xl8E6W8n
         XSsgYzTIH+B/vHGDAEXg5uMWyaZCYjdWeDgDIZbtqU/9B7nmddUrhk7L81pNh8WfxD+x
         UBWaL4akfldso6LyHDY0sC07FzZo3132VpccYOj5AHQJ4/4pl2Vbi6MMNlalbQU8ymRs
         EpUo7i51lW6PRKzweGrl8hi8LacY9jk9f4p/l9T+o64JNzsxaJU3VUlVHIm7qAGGoe9j
         CLhw==
X-Gm-Message-State: ABUngvcQJvj0+s3yFGx9f8agCZdKtm8GyFdMprYhUrU2V1ZIjJQs7PGRZgy0YfsMtgpxk8uV
X-Received: by 10.98.63.148 with SMTP id z20mr13286438pfj.151.1478810080423;
        Thu, 10 Nov 2016 12:34:40 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id x20sm9256747pfa.84.2016.11.10.12.34.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:34:39 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 04/35] attr.c: explain the lack of attr-name syntax check in parse_attr()
Date:   Thu, 10 Nov 2016 12:33:57 -0800
Message-Id: <20161110203428.30512-5-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161110203428.30512-1-sbeller@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/attr.c b/attr.c
index 4ae7801..05db667 100644
--- a/attr.c
+++ b/attr.c
@@ -183,6 +183,12 @@ static const char *parse_attr(const char *src, int lineno, const char *cp,
 			return NULL;
 		}
 	} else {
+		/*
+		 * As this function is always called twice, once with
+		 * e == NULL in the first pass and then e != NULL in
+		 * the second pass, no need for invalid_attr_name()
+		 * check here.
+		 */
 		if (*cp == '-' || *cp == '!') {
 			e->setto = (*cp == '-') ? ATTR__FALSE : ATTR__UNSET;
 			cp++;
-- 
2.10.1.469.g00a8914

