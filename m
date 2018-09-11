Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79C5F1F404
	for <e@80x24.org>; Tue, 11 Sep 2018 18:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbeIKXte (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 19:49:34 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:42055 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeIKXte (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 19:49:34 -0400
Received: by mail-ua1-f73.google.com with SMTP id g10-v6so12932575uap.9
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 11:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9Tm7w1vIrdBBkPoLF6rT11GI/7dZ7xevniUrahWCjKQ=;
        b=gK5kzZGTUY0SDax613FfFnY2QubaYxCAYMTS5ey0iaBeZ1ZTrb9i82HCWBIHcDUxWp
         wKDBvhneu/3BDg1Cxk6lF9V8HuDQlvPXofgaNaTlzjt6LlGQUt95Cpe+nrDuaZ/GCarW
         En9nQA+4zgvyw4GPHMctzl8eWvoT2YD8SuHtXBEx2zGi0+7Jd8oy8rNjgLKzqbMwLwiR
         V5jg/VHhW1MKKuX/jPhBvwmyif4CPfxtaQwxYLymfW1abRQkyfVjjD0mBi7urFqTdHnr
         Zudk7E0hB9oPi5tUL9235t+Dc8QxKR/5HwJBTyOuaHxEiYfmcuhOqP+Q9aJ6KaoGQ+AU
         EmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9Tm7w1vIrdBBkPoLF6rT11GI/7dZ7xevniUrahWCjKQ=;
        b=dJBMTskOwcdxPrk33JATLvueRRrV/UKgbk3vqKp1B9jsRe1QIjEIqt7u4RJBT3jKSg
         nb0g0vAU5mT6gZ40BwVH2U4+JV24Q3IQG/5lO5YiqLjsTPc5FbzHbFjmd5J5iRpWVmxs
         RkypDTP4k1TJTkkcHPxeLGj8x51YTXQefe1iIbRHMpPUcMYQY1dzlXIKsoiysNDLndRs
         Md2qTNhdZKhD/LVTK6deJkcXerG/sh1zFDHwEOVMx4tP9ujIC6KQqR+2cBegaUH5Hwnc
         mi4Tie0K2I2KQmov2x6jdMn/82js3Q54c9JOigDimicVQIc5OlEu4qSmpvfw6mIGskqx
         ZuTg==
X-Gm-Message-State: APzg51BIjHnswRK14CETGXIwVAtZas89tino8aadIt9wZt+XQYz954Zi
        sZ4RyuoP10K7XFpT7H2ACWxeF0f/j3sw
X-Google-Smtp-Source: ANB0Vda19H2Z5OP/vOogNqMfIs1q8EkkDjboQ7i2L2RCTKuN749GYLb7kmL+HSYHkmloLQr0qWa5X/IL9ZKg
X-Received: by 2002:ab0:b12:: with SMTP id b18-v6mr5312188uak.0.1536691735625;
 Tue, 11 Sep 2018 11:48:55 -0700 (PDT)
Date:   Tue, 11 Sep 2018 11:48:50 -0700
In-Reply-To: <xmqqy3c8rh3d.fsf@gitster-ct.c.googlers.com>
Message-Id: <20180911184850.24891-1-sbeller@google.com>
Mime-Version: 1.0
References: <xmqqy3c8rh3d.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH] string-list: remove unused function print_string_list
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The helper function stayed unused for 3 years. A removal of that function
was proposed before[1], but now time has proven we really do not need the
function.

[1] https://public-inbox.org/git/1421343725-3973-1-git-send-email-kuleshovmail@gmail.com/
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 string-list.c | 10 ----------
 string-list.h |  8 --------
 2 files changed, 18 deletions(-)

diff --git a/string-list.c b/string-list.c
index 771c4550980..1f6063f2a27 100644
--- a/string-list.c
+++ b/string-list.c
@@ -195,16 +195,6 @@ void string_list_clear_func(struct string_list *list, string_list_clear_func_t c
 	list->nr = list->alloc = 0;
 }
 
-
-void print_string_list(const struct string_list *p, const char *text)
-{
-	int i;
-	if ( text )
-		printf("%s\n", text);
-	for (i = 0; i < p->nr; i++)
-		printf("%s:%p\n", p->items[i].string, p->items[i].util);
-}
-
 struct string_list_item *string_list_append_nodup(struct string_list *list,
 						  char *string)
 {
diff --git a/string-list.h b/string-list.h
index ff8f6094a33..18c718c12ce 100644
--- a/string-list.h
+++ b/string-list.h
@@ -113,14 +113,6 @@ typedef int (*string_list_each_func_t)(struct string_list_item *, void *);
 void filter_string_list(struct string_list *list, int free_util,
 			string_list_each_func_t want, void *cb_data);
 
-/**
- * Dump a string_list to stdout, useful mainly for debugging
- * purposes. It can take an optional header argument and it writes out
- * the string-pointer pairs of the string_list, each one in its own
- * line.
- */
-void print_string_list(const struct string_list *p, const char *text);
-
 /**
  * Free a string_list. The `string` pointer of the items will be freed
  * in case the `strdup_strings` member of the string_list is set. The
-- 
2.19.0.397.gdd90340f6a-goog

