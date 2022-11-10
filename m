Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DFFC4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 22:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiKJW5l (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 17:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiKJW5j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 17:57:39 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0457451C3F
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 14:57:38 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso2108972wms.4
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 14:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zw2uyLiXbNUK+MV+XdFAmhMQRN5K3rhaJ5xcvF1uElM=;
        b=kvtrt8JirtaIK4LPierTqCylAgOxs+4eNfY075xquQg4z6qGqpJXvr1kmsfD0tct81
         mNr9+rSjLIwbphV8bQeUUMIhYPCjyYryhRHhefrr0SDuLwI0nYFk9CaS0TyvhjeuNFa7
         ipHZIDPDM8dQ7bPiimATHQubddOvTN/Mhbw6BCaSmBrUF8jEnSPrQ3o4MY1asUAx4Vib
         eRPQNU7ZqVGJAiHOE4X6Rj2/4giHACNdrW5Tpsil+2/PF07Kepmo6kYZY9BVPyKDQ2RP
         ob3bs4QCLc2p6KVtvnJEBXURzc/xjNZqtrldVBV3mxghjk2z17rBGFSF+igXRGU86gnG
         Yy3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zw2uyLiXbNUK+MV+XdFAmhMQRN5K3rhaJ5xcvF1uElM=;
        b=yZbLFf6WH9NqxqGP4n4OnRavJmXz4v0jjnUcetnOlJ2ve7H42baAIXYtT6SKEgDiWP
         mztvVzpIeDdkfP2X+tAaZJob7PlqUlcswOznrYHcNr2VltFy+OYF6Ze72RA4vuET7+YE
         KqqRtWfAlIQSf3j9mgD0WBEqHj89PkXK9AQ9BV9JNq2PUUnDn3S+AmKDyitrx0qzsX/e
         8yZ3WvIWphmSZyfAXR7RMsc963+TxK/MIuGLxHJR+e1sVFVJ3ULX9AdNXNyAgeXMB/oZ
         d9ORiSCy8q4ls6RGaO9Kpg0HnYseP4befLoWqe9p2owXuK54MKDI4BU8E2/27q1o6fO/
         2PfQ==
X-Gm-Message-State: ACrzQf1JLSMzAUzx2xMLA5deCocJFmrvijoZEYDD4v+QNebHBEPNH5d8
        8rxtk0RelaDrV7nEYSZnXmkHBKNpkuI=
X-Google-Smtp-Source: AMsMyM7iAM3qa6TxFdBYHpqvqauxaGplagOljrWlnCkkBgUR/LnKCIKOU34zqYlTqGgjvY6U10XMsA==
X-Received: by 2002:a05:600c:3316:b0:3cf:a3b1:e457 with SMTP id q22-20020a05600c331600b003cfa3b1e457mr19462723wmp.160.1668121056148;
        Thu, 10 Nov 2022 14:57:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i18-20020a5d5592000000b002365921c9aesm337158wrv.77.2022.11.10.14.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 14:57:35 -0800 (PST)
Message-Id: <pull.1377.v2.git.git.1668121055059.gitgitgadget@gmail.com>
In-Reply-To: <pull.1377.git.git.1667955151994.gitgitgadget@gmail.com>
References: <pull.1377.git.git.1667955151994.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Nov 2022 22:57:34 +0000
Subject: [PATCH v2] http: redact curl h2h3 headers in info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Emily Shaffer <nasamuffin@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

With GIT_TRACE_CURL=1 or GIT_CURL_VERBOSE=1, sensitive headers like
"Authorization" and "Cookie" get redacted. However, since [1], curl's
h2h3 module also prints headers in its "info", which don't get redacted.
For example,

  echo 'github.com	TRUE	/	FALSE	1698960413304	o	foo=bar' >cookiefile &&
  GIT_TRACE_CURL=1 GIT_TRACE_CURL_NO_DATA=1 git \
    -c 'http.cookiefile=cookiefile' \
    -c 'http.version=' \
    ls-remote https://github.com/git/git refs/heads/main 2>output &&
  grep 'cookie' output

produces output like:

  23:04:16.920495 http.c:678              == Info: h2h3 [cookie: o=foo=bar]
  23:04:16.920562 http.c:637              => Send header: cookie: o=<redacted>

Teach http.c to check for h2h3 headers in info and redact them using the
existing header redaction logic.

[1] https://github.com/curl/curl/commit/f8c3724aa90472c0e617ddbbc420aa199971eb77

Signed-off-by: Glen Choo <chooglen@google.com>
---
    http: redact curl h2h3 headers in info
    
    Thanks for the feedback, all :) For this patch, it sounds like it would
    be too onerous to do the kinds of testing I initially envisioned, so I
    think v2 is ready as-is.
    
    Changes in v2:
    
     * Describe the redacted string in comments.
     * Return 1 for "redactions have happened".
     * Fix a leak of the "inner" strbuf.
     * Rename function, fix typo.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1377%2Fchooglen%2Fhttp%2Fredact-h2h3-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1377/chooglen/http/redact-h2h3-v2
Pull-Request: https://github.com/git/git/pull/1377

Range-diff vs v1:

 1:  e9232396736 ! 1:  a8c35ff4ddf http: redact curl h2h3 headers in info
     @@ http.c: static void set_curl_keepalive(CURL *c)
       #endif
       
      -static void redact_sensitive_header(struct strbuf *header)
     -+/* Return 0 if redactions been made, 1 otherwise. */
     ++/* Return 1 if redactions have been made, 0 otherwise. */
      +static int redact_sensitive_header(struct strbuf *header)
       {
     -+	int ret = 1;
     ++	int ret = 0;
       	const char *sensitive_header;
       
       	if (trace_curl_redact &&
     @@ http.c: static void redact_sensitive_header(struct strbuf *header)
       		/* Everything else is opaque and possibly sensitive */
       		strbuf_setlen(header,  sensitive_header - header->buf);
       		strbuf_addstr(header, " <redacted>");
     -+		ret = 0;
     ++		ret = 1;
       	} else if (trace_curl_redact &&
       		   skip_iprefix(header->buf, "Cookie:", &sensitive_header)) {
       		struct strbuf redacted_header = STRBUF_INIT;
     @@ http.c: static void redact_sensitive_header(struct strbuf *header)
       
       		strbuf_setlen(header, sensitive_header - header->buf);
       		strbuf_addbuf(header, &redacted_header);
     -+		ret = 0;
     ++		ret = 1;
      +	}
      +	return ret;
      +}
     @@ http.c: static void redact_sensitive_header(struct strbuf *header)
      +{
      +	const char *sensitive_header;
      +
     ++	/*
     ++	 * curl's h2h3 prints headers in info, e.g.:
     ++	 *   h2h3 [<header-name>: <header-val>]
     ++	 */
      +	if (trace_curl_redact &&
      +	    skip_iprefix(header->buf, "h2h3 [", &sensitive_header)) {
      +		struct strbuf inner = STRBUF_INIT;
      +
      +		/* Drop the trailing "]" */
      +		strbuf_add(&inner, sensitive_header, strlen(sensitive_header) - 1);
     -+		if (!redact_sensitive_header(&inner)) {
     ++		if (redact_sensitive_header(&inner)) {
      +			strbuf_setlen(header, strlen("h2h3 ["));
      +			strbuf_addbuf(header, &inner);
      +			strbuf_addch(header, ']');
      +		}
     ++
     ++		strbuf_release(&inner);
       	}
       }
       
     @@ http.c: static void curl_dump_data(const char *text, unsigned char *ptr, size_t
       	strbuf_release(&out);
       }
       
     -+static void curl_print_info(char *data, size_t size)
     ++static void curl_dump_info(char *data, size_t size)
      +{
      +	struct strbuf buf = STRBUF_INIT;
      +
     @@ http.c: static int curl_trace(CURL *handle, curl_infotype type, char *data, size
       	switch (type) {
       	case CURLINFO_TEXT:
      -		trace_printf_key(&trace_curl, "== Info: %s", data);
     -+		curl_print_info(data, size);
     ++		curl_dump_info(data, size);
       		break;
       	case CURLINFO_HEADER_OUT:
       		text = "=> Send header";


 http.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/http.c b/http.c
index 5d0502f51fd..8135fac283e 100644
--- a/http.c
+++ b/http.c
@@ -560,8 +560,10 @@ static void set_curl_keepalive(CURL *c)
 }
 #endif
 
-static void redact_sensitive_header(struct strbuf *header)
+/* Return 1 if redactions have been made, 0 otherwise. */
+static int redact_sensitive_header(struct strbuf *header)
 {
+	int ret = 0;
 	const char *sensitive_header;
 
 	if (trace_curl_redact &&
@@ -575,6 +577,7 @@ static void redact_sensitive_header(struct strbuf *header)
 		/* Everything else is opaque and possibly sensitive */
 		strbuf_setlen(header,  sensitive_header - header->buf);
 		strbuf_addstr(header, " <redacted>");
+		ret = 1;
 	} else if (trace_curl_redact &&
 		   skip_iprefix(header->buf, "Cookie:", &sensitive_header)) {
 		struct strbuf redacted_header = STRBUF_INIT;
@@ -612,6 +615,33 @@ static void redact_sensitive_header(struct strbuf *header)
 
 		strbuf_setlen(header, sensitive_header - header->buf);
 		strbuf_addbuf(header, &redacted_header);
+		ret = 1;
+	}
+	return ret;
+}
+
+/* Redact headers in info */
+static void redact_sensitive_info_header(struct strbuf *header)
+{
+	const char *sensitive_header;
+
+	/*
+	 * curl's h2h3 prints headers in info, e.g.:
+	 *   h2h3 [<header-name>: <header-val>]
+	 */
+	if (trace_curl_redact &&
+	    skip_iprefix(header->buf, "h2h3 [", &sensitive_header)) {
+		struct strbuf inner = STRBUF_INIT;
+
+		/* Drop the trailing "]" */
+		strbuf_add(&inner, sensitive_header, strlen(sensitive_header) - 1);
+		if (redact_sensitive_header(&inner)) {
+			strbuf_setlen(header, strlen("h2h3 ["));
+			strbuf_addbuf(header, &inner);
+			strbuf_addch(header, ']');
+		}
+
+		strbuf_release(&inner);
 	}
 }
 
@@ -668,6 +698,18 @@ static void curl_dump_data(const char *text, unsigned char *ptr, size_t size)
 	strbuf_release(&out);
 }
 
+static void curl_dump_info(char *data, size_t size)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_add(&buf, data, size);
+
+	redact_sensitive_info_header(&buf);
+	trace_printf_key(&trace_curl, "== Info: %s", buf.buf);
+
+	strbuf_release(&buf);
+}
+
 static int curl_trace(CURL *handle, curl_infotype type, char *data, size_t size, void *userp)
 {
 	const char *text;
@@ -675,7 +717,7 @@ static int curl_trace(CURL *handle, curl_infotype type, char *data, size_t size,
 
 	switch (type) {
 	case CURLINFO_TEXT:
-		trace_printf_key(&trace_curl, "== Info: %s", data);
+		curl_dump_info(data, size);
 		break;
 	case CURLINFO_HEADER_OUT:
 		text = "=> Send header";

base-commit: c03801e19cb8ab36e9c0d17ff3d5e0c3b0f24193
-- 
gitgitgadget
