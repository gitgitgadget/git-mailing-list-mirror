Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09E081F404
	for <e@80x24.org>; Fri, 13 Apr 2018 21:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751818AbeDMVTQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 17:19:16 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:43662 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeDMVTM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 17:19:12 -0400
Received: by mail-io0-f195.google.com with SMTP id q84so11746563iod.10
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 14:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=4Oyfrm2dCmciG3dqoBdRAtvxVsbbzXZcYYElhRYv0mc=;
        b=jq2FOOESxkH+4wTAKb7SkGAQcrZUCvcYeAYvVW5WVc9JM3Vsyk/F4yXyiiysc07T9N
         5+4+xs0JMLIcZj8vHsEv3yC6FvbrglQeU1Cs3SSGRtr4iJLC6gaVk2UwGGptH6Vm4T7x
         mQKLOyLzEnuhb3pxg7E9oxL4ghqax4PsB9Ksw6QGH/fp/2fRggLt5RmPMSpjAIe1cWg6
         E3Uvvc4HG/QM5NdtOFBFc3WWEUc1XGX/8iM3WgGq6A5TR1c7FgQGZ4HSSsLIbsXL7UEn
         Krn2JKobrT0e/LO4eIReaK0U0S5G4NOmKUz3LHaDF8M8lq3loHwD0sDN0OIWTke6G4oJ
         1GEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=4Oyfrm2dCmciG3dqoBdRAtvxVsbbzXZcYYElhRYv0mc=;
        b=V4lbbkX1cTXpIPovK7aP7g8aY/W/hRFsgEUDcyODQ1jfVrL+x8Hip/ojKrrf/Itn/g
         pYlcwFe+IHfhKhzUQV/SE7MrfsYI60VZSno1T+mCK7DCQ04dkcgg9qdGZdpjYELzOn5s
         kHOZIO2sJJywrNtc05684fvxcIS0aIlk1REgVeBU6oak3JuZMYj16hwfB1MXtpLPaZla
         sEUVOHvnUzyuPIMGr3XejPZrWL/ymKhhYNd8zzI6TBh5yc2l3iSI7SB2/TDWEwpMdPxb
         21+OyV7yz9Yb88mPaI62aLV1J5Kjrf7UGiPgBLMq3rh+MW0NfCNCjRVPACD0Sze68NUn
         ry0Q==
X-Gm-Message-State: ALQs6tCfwBAylcQE0ZP7mtT6J+JDDSIlgt29O63gKYMk+oSWkNb676vN
        fez6cWwqN062dyAg0S0QAeH3qib65Js=
X-Google-Smtp-Source: AIpwx48PVR1aDwzpS5LyDp6YirvNWvFFoPTFtqHGUgZp3wPd1POliOvlEQRTrxFe/yPV0O8kja11EQ==
X-Received: by 10.107.79.18 with SMTP id d18mr6014895iob.286.1523654351609;
        Fri, 13 Apr 2018 14:19:11 -0700 (PDT)
Received: from localhost.localdomain (174-16-129-48.hlrn.qwest.net. [174.16.129.48])
        by smtp.gmail.com with ESMTPSA id z7sm3125124iob.9.2018.04.13.14.19.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Apr 2018 14:19:11 -0700 (PDT)
From:   Ben Toews <mastahyeti@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, sbeller@google.com,
        gitster@pobox.com, szeder.dev@gmail.com, sunshine@sunshineco.com,
        Ben Toews <mastahyeti@gmail.com>
Subject: [PATCH v2 3/9] gpg-interface: modernize function declarations
Date:   Fri, 13 Apr 2018 15:18:31 -0600
Message-Id: <20180413211837.99415-4-mastahyeti@gmail.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
In-Reply-To: <20180413211837.99415-1-mastahyeti@gmail.com>
References: <20180413211837.99415-1-mastahyeti@gmail.com>
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

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ben Toews <mastahyeti@gmail.com>
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
