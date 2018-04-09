Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8720F1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 20:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754237AbeDIUmW (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 16:42:22 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:39556 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752369AbeDIUmP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 16:42:15 -0400
Received: by mail-it0-f47.google.com with SMTP id e98-v6so12005712itd.4
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 13:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4/mzBYAB/1ECebp8x46Blkc/YngDwkPZPJU1r5A8vJ8=;
        b=oFjB6ew4NXMyyH3OuPCkF63VfoN8LGuQLK/7mRuVjHWbOYLMHSPYoG6btDIDXkRmCh
         jQkq30gLhy3Lp8IYm8eWNyt5AOdVKulYWMpwpA0ZOigeZmCQouUk0n3dKgzk5m3QOvOK
         /KtOjeQuwbUciSYCYjj0Z4VgXmKtfwJ7GTolyWl/0SdLoaNQqbo+XbZaKaD0rjkB2KsR
         tk6NCueKPgUykh5NoHbsIY4kRQyDP7CII9JbpTaoyA3Ozk5Ex7HB9lk5jE0xirQWOvHq
         TkUkqdsSxbOgfzfw1VmBrdSR0G8fWmnlaPYy3j2UhiCsBAlIWdlJUyOP9wfZRszxJPjb
         jbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4/mzBYAB/1ECebp8x46Blkc/YngDwkPZPJU1r5A8vJ8=;
        b=r/catk4QbvL49d+iDLZbFwDO1WvUyQcKt7q7XBnAHkbDCx9vTCg2ZSInuwoUyFsxEt
         5eB4ssgMAugde/c/ZRyZR/xIwui9SMZwoal7wwHtXZ8puUEa+t93tSXU1nakiDcqOW7s
         yKARTr9vGbIX1HOsgzO8LrkL9XG/dcj/D4zYPgw4/Jcd4wIZlporKGiWRoSfDA0qKQEr
         3y45vp5nbkfo9EGRL5VZagU/NSHyGRydWVNnxPdWyZOWjwn5cKxsnCNCDAxsvUjZh793
         xAMQuHkOdFfw6ejr8DxY8DTnxuJ+cbZ1VB+9oJgGnuXZFnXSnbjSkZN6yS3xVV0hDK0G
         /drw==
X-Gm-Message-State: ALQs6tAKxf3TYWBxGE7PVpT2zG5+JoWKLTa6Sn+nYmQb4dCmEc85r2EB
        H1dHep5+0nIa1UgLPEFGv/kvI6Sy
X-Google-Smtp-Source: AIpwx49pi4n5vZAd7RtV9OHn4E0mOsy0xfKfEpFG/iVjSJ8Sb6c8aon+KBYj+sdYAHTOgk3suomp3g==
X-Received: by 2002:a24:5852:: with SMTP id f79-v6mr1673491itb.108.1523306534409;
        Mon, 09 Apr 2018 13:42:14 -0700 (PDT)
Received: from localhost.localdomain (174-16-129-48.hlrn.qwest.net. [174.16.129.48])
        by smtp.gmail.com with ESMTPSA id 134-v6sm98775itl.34.2018.04.09.13.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Apr 2018 13:42:13 -0700 (PDT)
From:   Ben Toews <mastahyeti@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, mastahyeti@gmail.com
Subject: [PATCH 2/8] gpg-interface: modernize function declarations
Date:   Mon,  9 Apr 2018 14:41:23 -0600
Message-Id: <20180409204129.43537-3-mastahyeti@gmail.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
In-Reply-To: <20180409204129.43537-1-mastahyeti@gmail.com>
References: <20180409204129.43537-1-mastahyeti@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Let's drop "extern" from our declarations, which brings us
in line with our modern style guidelines. While we're
here, let's wrap some of the overly long lines, and move
docstrings for public functions to their declarations, since
they document the interface.
---
 gpg-interface.c | 17 -----------------
 gpg-interface.h | 49 ++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 61c0690e12..08de0daa41 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -101,12 +101,6 @@ void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
 		fputs(output, stderr);
 }
 
-/*
- * Look at GPG signed content (e.g. a signed tag object), whose
- * payload is followed by a detached signature on it.  Return the
- * offset where the embedded detached signature begins, or the end of
- * the data when there is no such signature.
- */
 size_t parse_signature(const char *buf, unsigned long size)
 {
 	char *eol;
@@ -151,12 +145,6 @@ const char *get_signing_key(void)
 	return git_committer_info(IDENT_STRICT|IDENT_NO_DATE);
 }
 
-/*
- * Create a detached signature for the contents of "buffer" and append
- * it after "signature"; "buffer" and "signature" can be the same
- * strbuf instance, which would cause the detached signature appended
- * at the end.
- */
 int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
 {
 	struct child_process gpg = CHILD_PROCESS_INIT;
@@ -198,11 +186,6 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 	return 0;
 }
 
-/*
- * Run "gpg" to see if the payload matches the detached signature.
- * gpg_output, when set, receives the diagnostic output from GPG.
- * gpg_status, when set, receives the status output from GPG.
- */
 int verify_signed_buffer(const char *payload, size_t payload_size,
 			 const char *signature, size_t signature_size,
 			 struct strbuf *gpg_output, struct strbuf *gpg_status)
diff --git a/gpg-interface.h b/gpg-interface.h
index d2d4fd3a65..2c40a9175f 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -23,16 +23,43 @@ struct signature_check {
 	char *key;
 };
 
-extern void signature_check_clear(struct signature_check *sigc);
-extern size_t parse_signature(const char *buf, unsigned long size);
-extern void parse_gpg_output(struct signature_check *);
-extern int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key);
-extern int verify_signed_buffer(const char *payload, size_t payload_size, const char *signature, size_t signature_size, struct strbuf *gpg_output, struct strbuf *gpg_status);
-extern int git_gpg_config(const char *, const char *, void *);
-extern void set_signing_key(const char *);
-extern const char *get_signing_key(void);
-extern int check_signature(const char *payload, size_t plen,
-	const char *signature, size_t slen, struct signature_check *sigc);
-void print_signature_buffer(const struct signature_check *sigc, unsigned flags);
+void signature_check_clear(struct signature_check *sigc);
+
+/*
+ * Look at GPG signed content (e.g. a signed tag object), whose
+ * payload is followed by a detached signature on it.  Return the
+ * offset where the embedded detached signature begins, or the end of
+ * the data when there is no such signature.
+ */
+size_t parse_signature(const char *buf, unsigned long size);
+
+void parse_gpg_output(struct signature_check *);
+
+/*
+ * Create a detached signature for the contents of "buffer" and append
+ * it after "signature"; "buffer" and "signature" can be the same
+ * strbuf instance, which would cause the detached signature appended
+ * at the end.
+ */
+int sign_buffer(struct strbuf *buffer, struct strbuf *signature,
+		const char *signing_key);
+
+/*
+ * Run "gpg" to see if the payload matches the detached signature.
+ * gpg_output, when set, receives the diagnostic output from GPG.
+ * gpg_status, when set, receives the status output from GPG.
+ */
+int verify_signed_buffer(const char *payload, size_t payload_size,
+			 const char *signature, size_t signature_size,
+			 struct strbuf *gpg_output, struct strbuf *gpg_status);
+
+int git_gpg_config(const char *, const char *, void *);
+void set_signing_key(const char *);
+const char *get_signing_key(void);
+int check_signature(const char *payload, size_t plen,
+		    const char *signature, size_t slen,
+		    struct signature_check *sigc);
+void print_signature_buffer(const struct signature_check *sigc,
+			    unsigned flags);
 
 #endif
-- 
2.15.1 (Apple Git-101)

