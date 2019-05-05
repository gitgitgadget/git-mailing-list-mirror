Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A42BF1F45F
	for <e@80x24.org>; Sun,  5 May 2019 16:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfEEQYv (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 May 2019 12:24:51 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:51076 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbfEEQYv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 May 2019 12:24:51 -0400
Received: by mail-it1-f194.google.com with SMTP id q14so16772847itk.0
        for <git@vger.kernel.org>; Sun, 05 May 2019 09:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zvI5qgrs56hUr5MH02wrtUaLY6NJWP/VG8VlvmB2X+A=;
        b=XbdFwZvfYSiXkR2THLr7uwleGKqm2FbKUmxYNKhQV4t9+BPllMay2eSQ6NRcSLMPXZ
         Mrg2XAPl7h3WmRv3FT7+nLTcmr/9tyMH8S8Dy3y+y7qEuLiahDGOPitRQExx7PlFX1qN
         //RkuUmJf9KADVTb7JIiZJw/coGRdbW/qMagF63bwvFAu3H4dLw64e3QN+XHrB+k7ALx
         hHUHZpk3yP4MY4BDFdPQHLCuEKnWfCQ7bMgeKby9kdBV+hwRGwB99x4mEN81xpDo74bw
         AAsZBYh9vlMW0YnkiZfexr5T1aaNBIu0pl8MOhUvTPsqKcBdMmlqZ+jI+DsUYc1Vf5q0
         sIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zvI5qgrs56hUr5MH02wrtUaLY6NJWP/VG8VlvmB2X+A=;
        b=R+M7hkMcl/C8iqdQsHtQNZTfcawfJVUiS2rfEIdA9p5sFtigPLhu8f2DbvnD07EyT/
         DxFgRFPyeYYA66vjFDRDEwbKMt+Bc00aeaNpF6nZeOPJq5y0vOl6TT0KuBd4IxSLAefr
         zYVfW2kLkfD79YNkeOON8obf4XnHG9DbPLm26q1sJ5uyJPzivm338SR65X3JPRkjesXu
         QUvzukjsahl9Sl8Ia+54mOMU9E2HL0MM2vuS+++j4y1QEQsrTTYaiaFf0eN3ic320iiQ
         vXhr4WteHwhgU15EHIv8/FVzPlFbrUkimCLT6v5EmO7RvRbZhiWEbq5NvNE2u9IzHud1
         5Jlw==
X-Gm-Message-State: APjAAAV5V2lV8F10e3ezyR4u2dhWTZ1AoCXkfouUdRwRra6t2Eo8Ab/D
        XPnGI1aFFET3vTqpjglBE4GgYJIJ
X-Google-Smtp-Source: APXvYqyKLfUHAzciwSi4raDGtSXjooAKTIVAu+yv4eq9OFPBCDUSeOjJvbJE11Q62mbIeLNtAgNULQ==
X-Received: by 2002:a24:2f42:: with SMTP id j63mr15015810itj.108.1557073489726;
        Sun, 05 May 2019 09:24:49 -0700 (PDT)
Received: from archbookpro.localdomain ([199.119.233.193])
        by smtp.gmail.com with ESMTPSA id p23sm2713698iob.79.2019.05.05.09.24.48
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 05 May 2019 09:24:49 -0700 (PDT)
Date:   Sun, 5 May 2019 12:24:47 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 6/7] string-list: create string_list_append_all
Message-ID: <5f487f65e88569f38650efe9055b8f6391621c7a.1557072929.git.liu.denton@gmail.com>
References: <cover.1557072929.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1557072929.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future patch, we'll need to take one string_list and append it to
the end of another. Create the `string_list_append_all` function which
does this.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 string-list.c | 9 +++++++++
 string-list.h | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/string-list.c b/string-list.c
index a917955fbd..e63d58fbd2 100644
--- a/string-list.c
+++ b/string-list.c
@@ -215,6 +215,15 @@ struct string_list_item *string_list_append(struct string_list *list,
 			list->strdup_strings ? xstrdup(string) : (char *)string);
 }
 
+void string_list_append_all(struct string_list *list,
+			    const struct string_list *append_list)
+{
+	struct string_list_item *item;
+	ALLOC_GROW(list->items, list->nr + append_list->nr, list->alloc);
+	for_each_string_list_item(item, append_list)
+		string_list_append(list, item->string);
+}
+
 /*
  * Encapsulate the compare function pointer because ISO C99 forbids
  * casting from void * to a function pointer and vice versa.
diff --git a/string-list.h b/string-list.h
index 18c718c12c..32e0c4b47f 100644
--- a/string-list.h
+++ b/string-list.h
@@ -208,6 +208,13 @@ struct string_list_item *string_list_append(struct string_list *list, const char
  */
 struct string_list_item *string_list_append_nodup(struct string_list *list, char *string);
 
+/**
+ * Add all strings in append_list to list.  If list->strdup_string is
+ * set, then each string is copied; otherwise the new string_list_entry
+ * refers to the entry in the append_list.
+ */
+void string_list_append_all(struct string_list *list, const struct string_list *append_list);
+
 /**
  * Sort the list's entries by string value in `strcmp()` order.
  */
-- 
2.21.0.1049.geb646f7864

