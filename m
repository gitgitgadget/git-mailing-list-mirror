Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96B5D20987
	for <e@80x24.org>; Sat, 22 Oct 2016 23:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965120AbcJVXdp (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:33:45 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:38173 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965004AbcJVXdV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:33:21 -0400
Received: by mail-it0-f51.google.com with SMTP id 66so74097204itl.1
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dYus7ibnUzcBAZWPI4AiXJBsfIAfQaUgiwK3o/TOCFo=;
        b=Q779yQqdESBkTHsUu/9wll6hZ6d5D50JQ7tPEM5rmVi/aWkY9pvGZ1JAIUf14cBWuk
         RCphHkip+UsYWRWuRb/3DHBMqVaPc/kkCUEK+fdYbq9s0QE4GD7kCKu0Rpfgd6mUEhS0
         5zkJl+53b+mYwHdG/Qqw5eWMk3AhWTzMeEcxd3+YsJywxkVLGBx6DlcYvoC5YP+Z5aYe
         9w3sXlnUcgwx14Cn6p+3UHW7RFXu/6Tye1gpxWPpa2hQwj67vBAUOon03oba2sVMrTOq
         lceNO9p0SccmzqLf1zEgVxLdOsHly/V8KFZup0YLt3qAPy7hDoIE2OjAZyKfC2k/jVIw
         hIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dYus7ibnUzcBAZWPI4AiXJBsfIAfQaUgiwK3o/TOCFo=;
        b=RZhEq3ShTWqlm5skU3ji66ice2dhkWzgEHcPrs734OoXSWFWVOMGS7HcUYUfC6YIJA
         9WfWxMqZ3mslrsmksEQRVwe5mByX9112a1lwFYjuBHbVUQwRGRAhTKkxFBLS/eHb6m0s
         1LCU7A59eqec6z97SnWgae0loaV3GN00+/gB6T2+X38v2IQMP35MrdeZUnPeYkxGhWO7
         yNfgMkANcPOIbiXtr5XL8nxgDOsCMlOJhjBzUUBNIHRj45CP1ehmChw+0boT49gIVjnC
         c+EH2LADlx+vj6UC9tGc8HnK+QzN91+gm/m9E+vb7hp4OAw9R9wW2N8+0ov8cUd2Miql
         tuoA==
X-Gm-Message-State: ABUngvemwhOCPVLe+RAfq13Yzj0O5QQeLhSpNrWo14DjKGU13cQIMqjJi8/yAY/olBwqUq6O
X-Received: by 10.107.9.136 with SMTP id 8mr7271803ioj.204.1477179200014;
        Sat, 22 Oct 2016 16:33:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id h79sm1951462ith.19.2016.10.22.16.33.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:33:19 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 25/36] attr.c: outline the future plans by heavily commenting
Date:   Sat, 22 Oct 2016 16:32:14 -0700
Message-Id: <20161022233225.8883-26-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <20161022233225.8883-1-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index 673dc7a..0f08ee6 100644
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
@@ -117,6 +131,11 @@ struct git_attr *git_attr_counted(const char *name, size_t len)
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
2.10.1.508.g6572022

