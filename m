Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A16AC1F437
	for <e@80x24.org>; Sat, 28 Jan 2017 02:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751284AbdA1CDH (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 21:03:07 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36222 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750742AbdA1CCt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 21:02:49 -0500
Received: by mail-pg0-f46.google.com with SMTP id 3so26925397pgj.3
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 18:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p6hyFTMCPfHZ/bG2tGbmkXQFwDn4O+5i9NwmqQqZT/g=;
        b=n8TGiT52loaNvqcrL1RorKeSisqcYTMXaG99+B3/gTNblclkrMhuO9UXrGOO38FtU0
         rD2FpLK5Rwl5wH2h5LZk3v0naEUP88mo93eOQIyFYSnKAhPJEfVmOGzEMmeYWl6tMliH
         CYgFFpe1h67ANcJEBBbiHLWgIP7DSYgSPeR4GSxEWItxh7+nc1J/735zO4GldGQisNXE
         kRgZc3S0FaPNe0NG9vMsmF9CMFGllPS/MySADafOufCxJVNGKMNCRhsUpvNBttmfy7Ah
         eUuv9ndaSX/jm6h68+lAvrGcUBWxxnM8tvo787VfGSa9bO0ThGPnT14tn/cOKb8EVYEy
         HENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p6hyFTMCPfHZ/bG2tGbmkXQFwDn4O+5i9NwmqQqZT/g=;
        b=bJtE7UlUFpKlGLAKcqVx4tcYNne21rAMhX/9B5QGI1v+mI98M05BTisixLCozYagK/
         9D7fWncitfPSjLFKWLYQ/lLBfQKFYUXI2Kng3pYPJ0n9kNWM0j9p98AFkZA5sVzN7w++
         2buk7eqhJ5yUkeRN8wK3IBppRNoIYQmcOCy3iGKV4GgJjDJhNPgQfgtrFdAnuVupXJnY
         Ji/8d48ndLBdGAkDfPUbdxJxHI4XU5qD8XdYFfyuWsM87mbt8N+Cu/gu1zorhUduwWlm
         nnENqHJourJpvhFBtydAd6JrTkSa+QCYHjcz4I345HgumXkw6DRKnP44s5H4+Jzjm0QB
         w9BA==
X-Gm-Message-State: AIkVDXJZ3Mre+uPpJVt6dMIZBfobcpuBsrBPAncFI3hlbUu3a8o/rWRxEQmlN2PdP8YchfJ7
X-Received: by 10.84.231.134 with SMTP id g6mr16688931plk.40.1485568968473;
        Fri, 27 Jan 2017 18:02:48 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id w76sm14136185pfd.74.2017.01.27.18.02.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jan 2017 18:02:47 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 13/27] attr.c: outline the future plans by heavily commenting
Date:   Fri, 27 Jan 2017 18:01:53 -0800
Message-Id: <20170128020207.179015-14-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170128020207.179015-1-bmwill@google.com>
References: <20170123203525.185058-1-bmwill@google.com>
 <20170128020207.179015-1-bmwill@google.com>
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

