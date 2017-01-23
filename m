Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83E5820AC5
	for <e@80x24.org>; Mon, 23 Jan 2017 20:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751627AbdAWUoI (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 15:44:08 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33123 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbdAWUoH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 15:44:07 -0500
Received: by mail-pf0-f175.google.com with SMTP id y143so43789317pfb.0
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 12:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u1Qo/uVYuiwCUm1MzZ4PnhuR9gFbRhsUryB1pwLVTEc=;
        b=YFeJwJ9GcdPl54znjLCJWd798VmW5kLX1FtwSUCYLBpj50l91KovRNZ9RczXJNUrqe
         wOgbeZGjqMzHgHZOtlnPTF5ChinG8WIQZH2p0jm/WBJGAkeNP4lUfpThUwMLXUzWDBSL
         3jhA1lMYJvAOkN821l43vdiLLdUzVwsjGlu9aoPXQ57gP/fVtgVFs+jcaPFRuRSRST/s
         hcEiUW4r7haepGaw801jLWTFJx0mj+8jAe0vEqJA2mkC+fPPm/y8/f8NFRRfkZRvhAyh
         zE4hLW+zOPHxNpNQI829+tgtMZexyCeY/R52lSeS/f2OeU7UyLIAUh3zgwlor1wks3CH
         r05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u1Qo/uVYuiwCUm1MzZ4PnhuR9gFbRhsUryB1pwLVTEc=;
        b=IN5AczyMmiVXqMy8me/DQi4jn6CDlwZ1Ix/0NjBy/w/IsGLel+ediFUyDVjO7ZpS3a
         QpOPrHUG+ai5JLn2aHZbGCV6FGxQg1jBy+Fs+MwQ5YJUE2Jm+rxw1PhNTocj2VPZ6/RZ
         1/eBvicLvKf36r9cfRiHnmsEdfz+mKdqnp7eAuzm2BTKkzFnY5rNudjKKbwMKGsBOAB+
         cNOjWPFtX65TRIkWujMGq4/RERB3ywABdCMJGdW1nVE6GjYs7Udq6N33ikyzFbGjcxtt
         lgSY38cV56O+7Lb3sM1xmqjSVQzd84qW9ViELhsdZ7eQ3YF0sRg4ogS35vndP9VZIoQn
         DLww==
X-Gm-Message-State: AIkVDXKK02SGrEb4+hPzyaBNa1a/gGG+UizSlPGQODv+AouTPLfsPEaaDjhyn8isvA5yNNou
X-Received: by 10.99.95.216 with SMTP id t207mr34920519pgb.0.1485203777186;
        Mon, 23 Jan 2017 12:36:17 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id z29sm39280832pgc.7.2017.01.23.12.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jan 2017 12:36:16 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com, pclouds@gmail.com
Subject: [PATCH v2 27/27] attr: reformat git_attr_set_direction() function
Date:   Mon, 23 Jan 2017 12:35:25 -0800
Message-Id: <20170123203525.185058-28-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170123203525.185058-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170123203525.185058-1-bmwill@google.com>
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
index c2ea5cb29..f35c1107f 100644
--- a/attr.c
+++ b/attr.c
@@ -578,26 +578,30 @@ static struct attr_stack *read_attr_from_array(const char **list)
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
@@ -1132,19 +1136,6 @@ void attr_check_free(struct attr_check *check)
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
-		drop_attr_stack();
-	use_index = istate;
-}
-
 void attr_start(void)
 {
 #ifndef NO_PTHREADS
diff --git a/attr.h b/attr.h
index da7c3a229..62dbcb6b8 100644
--- a/attr.h
+++ b/attr.h
@@ -76,7 +76,8 @@ enum git_attr_direction {
 	GIT_ATTR_CHECKOUT,
 	GIT_ATTR_INDEX
 };
-void git_attr_set_direction(enum git_attr_direction, struct index_state *);
+void git_attr_set_direction(enum git_attr_direction new_direction,
+			    struct index_state *istate);
 
 extern void attr_start(void);
 
-- 
2.11.0.483.g087da7b7c-goog

