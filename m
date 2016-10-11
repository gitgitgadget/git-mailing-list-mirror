Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F32020989
	for <e@80x24.org>; Tue, 11 Oct 2016 00:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752885AbcJKAWJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 20:22:09 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36017 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752871AbcJKAWI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 20:22:08 -0400
Received: by mail-pa0-f46.google.com with SMTP id ry6so3894261pac.3
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 17:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3Hnh8213sWJqok2fI7sb34pC1OVRdjxIfogdB3v0T10=;
        b=pXzht6OFp3CP7UMvQpRm6vnBAoGzWdzlSGROsAQjNhTXWrD0lOjjjKfyoxbe8Ax1WK
         dSXE94iWgE67AHmVZZ7OEYM0a9+l7YA5PVAuA82SXvCX/B4eGjc7aASbzpGE9wnSVJJF
         z5ACBmXGfJ0I7YTvl7oIPbxhEdq/XcYO8crHFUahuUpTb0iIdx21gzgwZB98+LTw8gKo
         TcjbDnSpureSTa5u2kCkjrK/Z2M4paeSXw8MdM976OvwZbXQRmKU6U9Y3Fev2+Pbrnn7
         HZgV9/V/LOpIethhgkoQOA/NQBYvNm4iJ1V4DM+x/R0Y274HOMHzyFmT+T4PVvgRRl5s
         A7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3Hnh8213sWJqok2fI7sb34pC1OVRdjxIfogdB3v0T10=;
        b=fmaqZwegMS4jEJYUegv5h6Eq3+rEXlKONdg/CjXMx3q7aIrLx93yw3u3c1L/ztNJ0s
         GoYmekVEyJk83Wd98HOxjFRPEK9HHAiOE1Girg41Q1LV5haVysl0K4P/VYi63CdGGT2q
         gep2oWJgiTGUidM3SG5iJtItregHkUmK+SQ0gPQZpZoPZGNjzxX1VFMogBkdjsqHZaH3
         xxSAJdca/WDY39cy5+sibmccFyWJUAYIpHNg+BLxhC89dwldF+3xjzaoFYrUOsBGjO82
         bAs/3CMRlMvYJs1bfKrkrH50SFUMagzVbiUxWofE3fTZJGGg42ucTet7IYDWHuIkIRp/
         9cJQ==
X-Gm-Message-State: AA6/9RnMX5J9+c4pZtJZK+p/6zxUmFQ8YySUTBJ496T6gEN2Vx3t54hbXUOw0snzJGuXxnUr
X-Received: by 10.66.184.74 with SMTP id es10mr1626073pac.187.1476145327590;
        Mon, 10 Oct 2016 17:22:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b8ee:61f5:e989:77a7])
        by smtp.gmail.com with ESMTPSA id x190sm531428pfd.20.2016.10.10.17.22.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 17:22:07 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 25/28] attr.c: outline the future plans by heavily commenting
Date:   Mon, 10 Oct 2016 17:21:12 -0700
Message-Id: <20161011002115.23312-26-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.382.ga23ca1b.dirty
In-Reply-To: <20161011002115.23312-1-sbeller@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
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
index a08783a..e34b4c4 100644
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
2.10.1.382.ga23ca1b.dirty

