Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76B7C20229
	for <e@80x24.org>; Thu, 10 Nov 2016 20:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965481AbcKJUfJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:35:09 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35869 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965299AbcKJUfI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:35:08 -0500
Received: by mail-pf0-f178.google.com with SMTP id 189so152173026pfz.3
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RA2ZEraEqsYtK6h2ZkZnNy1Av+yluKppfhZoQpUF3V0=;
        b=cxh4x30CJxlrrfyNh91SjrczEb24Gu1eO6+IS/mqefkOMMpbeW8kCL0Y0ft8TtsYhf
         LiydB07PMCzds04DQpurR2iGsqzYWPOAR0frwTvLAB02qYX4sORIGZ9YhH7yeT3eNW1h
         c+cJ/KriNakNd5U19fVFSQD+7BvDOHRHCLG726k5XsPhguVsWIG1XZLrH+gUYDPep0Zd
         aU+6cEQd9HUtnz4qqlOFgZhV7xPOXf7O07xmHihZTZFwRmajyZiPtkzbieY1ddurgttz
         uB9ssGElCoAU+U313etHmXQEFbbuaEHuLjRiWd5Bhr9CVvJaPnQ+Zuu+cSaZSM4zm1LB
         ibKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RA2ZEraEqsYtK6h2ZkZnNy1Av+yluKppfhZoQpUF3V0=;
        b=eYVpXQS8hEuFCicmPXBL1G4YdbbiiZNm6vbxQ6kPQe3MSlFH8g3uh7jBLchJUPKavi
         8OUO59w8z4fLAysaTl2MpZIr0bRrkn4njs4zzXtgvrGc++IANnuZZRYdiGEb99JbWlpb
         Wd9W/DYKptUcTZz1S9mkq+khH7Tb4L8UIKyHOk3k65CKx7WiQr7GnN7FKDtjdsg4DroQ
         Pma4/L/txDqD2iWBzrC4/JAooh6yq/QpOYnNyHI80+lFWRoOiiNrDkK1CIH9qH0WoRWQ
         s9VT0mDIPsNsNsa4KuDtr3cKVld2OObrckQNpysAn0Uk8boar00VTymD/ZIV0iwapfao
         aOIw==
X-Gm-Message-State: ABUngvcQlNgGzjMzsEbxTNIn6Izo9Esc2ItymyyoX0QhwpDdVBR/FXzUeBYJ5uQBRkWdXc/H
X-Received: by 10.98.103.84 with SMTP id b81mr13492318pfc.6.1478810107130;
        Thu, 10 Nov 2016 12:35:07 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id y2sm9253240pff.82.2016.11.10.12.35.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:35:06 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 24/35] attr.c: outline the future plans by heavily commenting
Date:   Thu, 10 Nov 2016 12:34:17 -0800
Message-Id: <20161110203428.30512-25-sbeller@google.com>
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
 attr.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index 246a5d0..60d7eec 100644
--- a/attr.c
+++ b/attr.c
@@ -30,6 +30,11 @@ static const char git_attr__unknown[] = "(builtin)unknown";
 #define DEBUG_ATTR 0
 #endif
 
+/*
+ * NEEDSWORK: the global dictionary of the interned attributes
+ * must stay a singleton even after we become thread-ready.
+ * Access to these must be surrounded with mutex when it happens.
+ */
 struct git_attr {
 	struct git_attr *next;
 	unsigned h;
@@ -39,10 +44,19 @@ struct git_attr {
 	char name[FLEX_ARRAY];
 };
 static int attr_nr;
+static struct git_attr *(git_attr_hash[HASHSIZE]);
+
+/*
+ * NEEDSWORK: maybe-real, maybe-macro are not property of
+ * an attribute, as it depends on what .gitattributes are
+ * read.  Once we introduce per git_attr_check attr_stack
+ * and check_all_attr, the optimization based on them will
+ * become unnecessary and can go away.  So is this variable.
+ */
 static int cannot_trust_maybe_real;
 
+/* NEEDSWORK: This will become per git_attr_check */
 static struct git_attr_check_elem *check_all_attr;
-static struct git_attr *(git_attr_hash[HASHSIZE]);
 
 const char *git_attr_name(const struct git_attr *attr)
 {
@@ -117,6 +131,11 @@ static struct git_attr *git_attr_internal(const char *name, int len)
 	a->maybe_real = 0;
 	git_attr_hash[pos] = a;
 
+	/*
+	 * NEEDSWORK: per git_attr_check check_all_attr
+	 * will be initialized a lot more lazily, not
+	 * like this, and not here.
+	 */
 	REALLOC_ARRAY(check_all_attr, attr_nr);
 	check_all_attr[a->attr_nr].attr = a;
 	check_all_attr[a->attr_nr].value = ATTR__UNKNOWN;
@@ -329,6 +348,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
  * .gitignore file and info/excludes file as a fallback.
  */
 
+/* NEEDSWORK: This will become per git_attr_check */
 static struct attr_stack {
 	struct attr_stack *prev;
 	char *origin;
@@ -393,6 +413,24 @@ static struct attr_stack *read_attr_from_array(const char **list)
 	return res;
 }
 
+/*
+ * NEEDSWORK: these two are tricky.  The callers assume there is a
+ * single, system-wide global state "where we read attributes from?"
+ * and when the state is flipped by calling git_attr_set_direction(),
+ * attr_stack is discarded so that subsequent attr_check will lazily
+ * read from the right place.  And they do not know or care who called
+ * by them uses the attribute subsystem, hence have no knowledge of
+ * existing git_attr_check instances or future ones that will be
+ * created).
+ *
+ * Probably we need a thread_local that holds these two variables,
+ * and a list of git_attr_check instances (which need to be maintained
+ * by hooking into git_attr_check_alloc(), git_attr_check_initl(), and
+ * git_attr_check_clear().  Then git_attr_set_direction() updates the
+ * fields in that thread_local for these two variables, iterate over
+ * all the active git_attr_check instances and discard the attr_stack
+ * they hold.  Yuck, but it sounds doable.
+ */
 static enum git_attr_direction direction;
 static struct index_state *use_index;
 
-- 
2.10.1.469.g00a8914

