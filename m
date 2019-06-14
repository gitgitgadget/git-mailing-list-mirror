Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 676111F462
	for <e@80x24.org>; Fri, 14 Jun 2019 21:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfFNV42 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 17:56:28 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38475 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfFNV4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 17:56:25 -0400
Received: by mail-io1-f68.google.com with SMTP id d12so1005433iod.5
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 14:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lQ9L/SjWM7YWE5h7AKOfsUj5sHMgU7S4SU8FlOk3VHE=;
        b=Nun7kRk5N0FUKfYkaFY+UIG4SQFrI5qgozga8RBYDB+4QYHUuHhpwPLlSzSwqzGJjy
         wRdhtK8nKzKTksCIJCw11Bao1V8ah0ou9EbZOSThRljVoSKhN41wGQYyLf1TvLtSBhly
         009aUn3VWGw9KXydNv7xpcD3/6oCW6tlcZb73wutPp0nFsrHpx6cJy2j2VOrmK9qcFd/
         qcFMQbRsvVJlKUsqfvq9cY+u2+bo6OeCb2eUcBFpkI9ZGkOZAb3pCSh5+68HfuiYCOf0
         YKzui4oqNmj/hlTMqN/tZ7igl02jwZkFS9B8jyXPsdh/zlioX0WOgZG8tFRwmJwThUte
         GoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lQ9L/SjWM7YWE5h7AKOfsUj5sHMgU7S4SU8FlOk3VHE=;
        b=eI0sVZdGjJIeEbngjrA/V7dKXUCQx9I3s3IvJB8a4ZN33n+5UUp0uYMDFfoihuqR1/
         45EzCI/cMtAsxzlRUUKAiXrB7L/Qfji52Plrc3FfaRGryHrzb57cKVnDGLjynzHVcjSC
         AyMgmT3Svbwl/wixQ2XVg6qUKg9Jd0Vo6YIw/jD7d3mRxuGmt5uq16idlr1ohkwKoajy
         oMJYY8tkdNlb3xF0gbJaacQ5zctt1ukgVxqIUl0i03vVPOkLQJbsjRstmwHwlBVz6gA7
         UQYwiKKumcsD0Y1N0HygWImHl/EkT5xQHV20t6PlTLOI6buL0Sp6sghFL0VhN+amsmRg
         bpMQ==
X-Gm-Message-State: APjAAAXTvv2G3YXkXaGbxEsl5fTt5NxZ+gajx4ZJfU+syW3AVZJUPdj6
        0Z/qpYZMmLDHbjdTIrQlcQfspWCB
X-Google-Smtp-Source: APXvYqwFUs9V2uTPWwO9wB923NPKlrjvnuf4mAXJ0MnFzH+OjKtWu9LOh5fMhnC7rA3QDRMHdQ3gCw==
X-Received: by 2002:a02:8787:: with SMTP id t7mr69506828jai.29.1560549384926;
        Fri, 14 Jun 2019 14:56:24 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-grc-01-76-68-140-144.dsl.bell.ca. [76.68.140.144])
        by smtp.gmail.com with ESMTPSA id j1sm4124598iop.14.2019.06.14.14.56.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 14:56:24 -0700 (PDT)
Date:   Fri, 14 Jun 2019 17:56:23 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RESEND PATCH v3 5/8] string-list: create string_list_append_all
Message-ID: <3554164deb27c93069ebe2ed9ee9cce7f55c242f.1560547501.git.liu.denton@gmail.com>
References: <cover.1558492582.git.liu.denton@gmail.com>
 <cover.1560547500.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1560547500.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
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
index f964399949..8227e00e6a 100644
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
2.22.0.355.g3bfa262345

