Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 714561FAAD
	for <e@80x24.org>; Sat, 28 Jan 2017 02:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbdA1CDn (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 21:03:43 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34615 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751324AbdA1CDV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 21:03:21 -0500
Received: by mail-pg0-f49.google.com with SMTP id 14so85555341pgg.1
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 18:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=twfdxLUNuVNNJl577w2904tuNp8BB+SgygnjCX7t1o8=;
        b=OtpsE8GqfDxgoyZJfWoRgIO1w7FcEdoOQuABEW/d/+2+SOMeRYcn44e6dvOSEuzHTn
         r6rQmdyy8Y8r4WGgLmQK/Z1546dyQglQVGe9wJbZwIuHBwHKWJAvHpu3encFpfrSgLo5
         Fi08mBWl608frSrbFX6tTeP5BKuXeLn93lCL0tg57Ja0tFgVxrU7OF94XOMOUmK886/2
         MIqBvFuixvxWfW7PTrXCNbYuKJCR+9O0wRpvo8gxmKRWeoIacwURm0txO526yXeUD0BP
         9Icyp1uCqa8shjhYHueubPgGRjh5F4SXgl3nO/cnxaFQPosB/QeipUBaFLFWTvEk+2tg
         Wzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=twfdxLUNuVNNJl577w2904tuNp8BB+SgygnjCX7t1o8=;
        b=DCLPMbFl7r/ER81bqrTzbu5HMt9L4DFdqZ6yb24O1CLFDwB/A8R8pZ1Mm03hB0Xd9R
         JDRz/6EPQQEsuF5P8NHf1q6eSwztv4YNBZFo/ZY6zoFeWsHIM0B95Dsdm5abMEY+wIw8
         hIeHnhePDNyTCbbCBaZwuYYAnvzWNsLcFXbaVQ5hPWsPSF8mN2FYR75XcxSdYbrfWay3
         919XC06oo8myQYmJ5WF1nBkvPnCQ6eVa22j8Fl2P++GpIKvmZUEBJuts2nuD5YwlwwmI
         PSoqxPMFK3RXoENpDPYM3MrJ1pUWP6sm689aArxey4YLzBJrbKXey6rcBEoJeXHruFVf
         n4LQ==
X-Gm-Message-State: AIkVDXLbbvLNnj4mV66m+eERjDqCOZiIxc8YDwokcGTdjGD8wjLLeek1S+4oCed/4m1OjBZP
X-Received: by 10.99.19.65 with SMTP id 1mr12706398pgt.153.1485568990381;
        Fri, 27 Jan 2017 18:03:10 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id w76sm14136185pfd.74.2017.01.27.18.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jan 2017 18:03:09 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com, pclouds@gmail.com
Subject: [PATCH v3 27/27] attr: reformat git_attr_set_direction() function
Date:   Fri, 27 Jan 2017 18:02:07 -0800
Message-Id: <20170128020207.179015-28-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170128020207.179015-1-bmwill@google.com>
References: <20170123203525.185058-1-bmwill@google.com>
 <20170128020207.179015-1-bmwill@google.com>
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
index 62298ec2f..5493bff22 100644
--- a/attr.c
+++ b/attr.c
@@ -677,26 +677,30 @@ static struct attr_stack *read_attr_from_array(const char **list)
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
+		drop_all_attr_stacks();
+
+	direction = new_direction;
+	use_index = istate;
+}
+
 static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
 {
 	FILE *fp = fopen(path, "r");
@@ -1148,19 +1152,6 @@ void git_all_attrs(const char *path, struct attr_check *check)
 	}
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
-		drop_all_attr_stacks();
-	use_index = istate;
-}
-
 void attr_start(void)
 {
 #ifndef NO_PTHREADS
diff --git a/attr.h b/attr.h
index 6f4961fdb..48ab3e1c2 100644
--- a/attr.h
+++ b/attr.h
@@ -72,7 +72,8 @@ enum git_attr_direction {
 	GIT_ATTR_CHECKOUT,
 	GIT_ATTR_INDEX
 };
-void git_attr_set_direction(enum git_attr_direction, struct index_state *);
+void git_attr_set_direction(enum git_attr_direction new_direction,
+			    struct index_state *istate);
 
 extern void attr_start(void);
 
-- 
2.11.0.483.g087da7b7c-goog

