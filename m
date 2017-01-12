Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC42F1FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 23:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750885AbdALXzc (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 18:55:32 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33220 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750844AbdALXz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 18:55:26 -0500
Received: by mail-pf0-f174.google.com with SMTP id y143so20699792pfb.0
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 15:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d3sHOwzhn2tvlG78KlHZHvp/aVC3yrC+ZWxlhigmRWw=;
        b=ftssX9WpyrN6m8FRcW4VcEcKHXu8p7H8op+ewVjRcRhU6x5AcCsOQheKv3hm0sPXUP
         6O4qrTP3hn9TutDLghh241JxaRBFRl3j430AF3kHRR0CYDrQoYZ79Qvz+AXWp1x4zL5Z
         1IwRvU5y/sbILQr0PEsrQY8BADS/NdWRwD7J0UaZ8sAdRmjaihtDQXBXafjuEuAMLlaU
         OLbEvVBwQNa3kS/Etvr89qW7US7MudlhjjLmkuG0ZXcEFPTCTEKBPP3NRX1dmUcuoWtg
         imGhDGlfwnQm4npuFNRPoAIcdtbV880zuYZnb5gitIBZgK8w2C41k+3naDz/N8J0Ug5M
         z0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d3sHOwzhn2tvlG78KlHZHvp/aVC3yrC+ZWxlhigmRWw=;
        b=Ll0bWer/PNoVcP8wfrhVbCvvlpLgoVrsnD+afaB+lVsCUxFvGND7sZBXCdFEk/SaRI
         MfvEhaW7ORV9vmRiVcBmW+ngJz92RdWZpSpdi07yPqu/u06ufGOzRfkmaQiXv8EdN7Qj
         t+LZgijvTUuUgtMdvD4EZ1mV+7pb5jASygB65otdu7juM4N22Qm0OJSzT3jsImVm5sDJ
         HMZg20AYRLBu6RJLZ812yx/WDNKdPzWOoX7OQttW5SkS2OOqAfbEkfMVdFaKbagHkOcN
         aF73NmuFj1vatyGCJ2OY/bJdx+ogPRltaz5pEAd+r/6cX+tgp1zj3Uvp3NEcbUEL1tSf
         R+Ag==
X-Gm-Message-State: AIkVDXKXH9tCJxwkOSZ6Gjf/gudteOhhNdwdrCZ22syXBIFU6UmPSqRbCo6yv+BYEhEYhCfE
X-Received: by 10.98.76.132 with SMTP id e4mr14140991pfj.24.1484265286122;
        Thu, 12 Jan 2017 15:54:46 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id e6sm24312192pgf.4.2017.01.12.15.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jan 2017 15:54:44 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, gitster@pobox.com,
        pclouds@gmail.com, sbeller@google.com
Subject: [PATCH 27/27] attr: reformat git_attr_set_direction() function
Date:   Thu, 12 Jan 2017 15:53:54 -0800
Message-Id: <20170112235354.153403-28-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170112235354.153403-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the 'git_attr_set_direction()' up to be closer to the variables
that it modifies as well as a small formatting by renaming the variable
'new' to 'new_direction' so that it is more descriptive.

Update the comment about how 'direction' is used to read the state of
the world.  It should be noted that callers of
'git_attr_set_direction()' should ensure that other threads are not
making calls into the attribute system until after the call to
'git_attr_set_direction()' completes.  This function essentially acts as
reset button for the attribute system and should be handled with care.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 49 ++++++++++++++++++++-----------------------------
 attr.h |  3 ++-
 2 files changed, 22 insertions(+), 30 deletions(-)

diff --git a/attr.c b/attr.c
index cbb07d25d..f5cc68b67 100644
--- a/attr.c
+++ b/attr.c
@@ -521,26 +521,30 @@ static struct attr_stack *read_attr_from_array(const char **list)
 }
 
 /*
- * NEEDSWORK: these two are tricky.  The callers assume there is a
- * single, system-wide global state "where we read attributes from?"
- * and when the state is flipped by calling git_attr_set_direction(),
- * attr_stack is discarded so that subsequent attr_check will lazily
- * read from the right place.  And they do not know or care who called
- * by them uses the attribute subsystem, hence have no knowledge of
- * existing git_attr_check instances or future ones that will be
- * created).
- *
- * Probably we need a thread_local that holds these two variables,
- * and a list of git_attr_check instances (which need to be maintained
- * by hooking into git_attr_check_alloc(), git_attr_check_initl(), and
- * git_attr_check_clear().  Then git_attr_set_direction() updates the
- * fields in that thread_local for these two variables, iterate over
- * all the active git_attr_check instances and discard the attr_stack
- * they hold.  Yuck, but it sounds doable.
+ * Callers into the attribute system assume there is a single, system-wide
+ * global state where attributes are read from and when the state is flipped by
+ * calling git_attr_set_direction(), the stack frames that have been
+ * constructed need to be discarded so so that subsequent calls into the
+ * attribute system will lazily read from the right place.  Since changing
+ * direction causes a global paradigm shift, it should not ever be called while
+ * another thread could potentially be calling into the attribute system.
  */
 static enum git_attr_direction direction;
 static struct index_state *use_index;
 
+void git_attr_set_direction(enum git_attr_direction new_direction,
+			    struct index_state *istate)
+{
+	if (is_bare_repository() && new_direction != GIT_ATTR_INDEX)
+		die("BUG: non-INDEX attr direction in a bare repo");
+
+	if (new_direction != direction)
+		drop_attr_stack();
+
+	direction = new_direction;
+	use_index = istate;
+}
+
 static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
 {
 	FILE *fp = fopen(path, "r");
@@ -1130,19 +1134,6 @@ void attr_check_free(struct attr_check *check)
 	free(check);
 }
 
-void git_attr_set_direction(enum git_attr_direction new, struct index_state *istate)
-{
-	enum git_attr_direction old = direction;
-
-	if (is_bare_repository() && new != GIT_ATTR_INDEX)
-		die("BUG: non-INDEX attr direction in a bare repo");
-
-	direction = new;
-	if (new != old)
-		drop_attr_stack();
-	use_index = istate;
-}
-
 void attr_start(void)
 {
 	pthread_mutex_init(&g_attr_hashmap.mutex, NULL);
diff --git a/attr.h b/attr.h
index 9b4dc07d8..b8be37c91 100644
--- a/attr.h
+++ b/attr.h
@@ -73,7 +73,8 @@ enum git_attr_direction {
 	GIT_ATTR_CHECKOUT,
 	GIT_ATTR_INDEX
 };
-void git_attr_set_direction(enum git_attr_direction, struct index_state *);
+void git_attr_set_direction(enum git_attr_direction new_direction,
+			    struct index_state *istate);
 
 extern void attr_start(void);
 
-- 
2.11.0.390.gc69c2f50cf-goog

