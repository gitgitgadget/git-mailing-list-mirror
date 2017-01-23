Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F33E20A17
	for <e@80x24.org>; Mon, 23 Jan 2017 20:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751629AbdAWUgA (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 15:36:00 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34130 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751516AbdAWUf5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 15:35:57 -0500
Received: by mail-pg0-f43.google.com with SMTP id 14so47683715pgg.1
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 12:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p6hyFTMCPfHZ/bG2tGbmkXQFwDn4O+5i9NwmqQqZT/g=;
        b=fH4dhva/98CngVzEdqS1zOlZ3BxTWsxlSWVc1+VbFZfbaaiw2g4/bTZI2VEhu029J3
         y3UDk3mHGEsxP3tzPgGzfRL6/Ob7RbnhJDsz6eA4GjAl/1p3yX1fr4Hl/Pbp1VzrMVA6
         EWRXSkTZIBxDah7q9p6hOdG9Pxd8H5vzIv9LgH6AMNYxRm2Jz0teCnYvPWi3pfDLFqUw
         K2EKmCYigwoE4JnfAXShu0g6naZ/EvYhVTw4Fnp+IuOQiFz9LJKmTLClVsZxT4/Yc2oF
         ITOtiGgT7yBdN01iyv7JsdIOYOxbpzXRt/Lc9cA4GapDMDkgg1m/7CirGnP4TlxQLVNt
         WWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p6hyFTMCPfHZ/bG2tGbmkXQFwDn4O+5i9NwmqQqZT/g=;
        b=N4iMFYl5cOL3oy8ait4gvCH9aAOHwrrTh+GtRTAkUvigxgPh1G1rNkVwt0yDRUw8Ek
         xv/GZrYqYOXHRsg1UNCvv54vYKDY2his4Q//OTYpvRt24Qn1F2z0qgxMyY1JOXgPabJ7
         V0YXbl+02ntxNEcjUQYA5EDVGZzFixqXh2XqMMDRqv65Tq/rKuKECB4qDxG+QL/5lgQw
         tsKmL4Fl9mlMNuQs8601xSZ8r78JmqA2ZlciNeSjQbzFXmtBB0weUXqWN2ex+qDvI/iK
         ypxs2QDHsn6m/eqtSa9QSI3H3NaCDIppkJh/NQjj6Sp6GW++eNk6OMqXBCjxMYN3xDhp
         O8sw==
X-Gm-Message-State: AIkVDXICnAypIB0undXmuUU6K04Fz70v0bCXBUpl+K1pMz+XNFUnATlIwSlk8eqxFX40zqM3
X-Received: by 10.98.159.80 with SMTP id g77mr33851738pfe.34.1485203756513;
        Mon, 23 Jan 2017 12:35:56 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id z29sm39280832pgc.7.2017.01.23.12.35.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jan 2017 12:35:55 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 13/27] attr.c: outline the future plans by heavily commenting
Date:   Mon, 23 Jan 2017 12:35:11 -0800
Message-Id: <20170123203525.185058-14-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170123203525.185058-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170123203525.185058-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index 8026d68bd..50e5ee393 100644
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
 static struct git_attr_check *check_all_attr;
-static struct git_attr *(git_attr_hash[HASHSIZE]);
 
 const char *git_attr_name(const struct git_attr *attr)
 {
@@ -102,6 +116,11 @@ static struct git_attr *git_attr_internal(const char *name, int len)
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
@@ -318,6 +337,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
  * .gitignore file and info/excludes file as a fallback.
  */
 
+/* NEEDSWORK: This will become per git_attr_check */
 static struct attr_stack {
 	struct attr_stack *prev;
 	char *origin;
@@ -382,6 +402,24 @@ static struct attr_stack *read_attr_from_array(const char **list)
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
2.11.0.483.g087da7b7c-goog

