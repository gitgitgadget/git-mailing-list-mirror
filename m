Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E75ECAAD8
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 19:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiIMT0T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 15:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiIMT0G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 15:26:06 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FF979634
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 12:26:03 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h8so15386870wrf.3
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 12:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=9m3T1Nih1NsVSAkhHW78RmCfreuv3OwtdZEGKLpv2Q8=;
        b=gRJngYN3XSR2qRtHhq/tMq8xd0mCgbWQbGG3OTxr1xcJ8U+wkqpmlvnk/9RW96Tc68
         UjuuTz1k2dExiZBYfF1Xnze6Q8IGun84B0JNqHLwWyAYq4+o84s13WvRbYvjPOJHswAc
         1Xl+P9++RHEflAnzX9L8JnAMLFuWsibbEsxSbkqRTp+Cq4HuPN7YukNyEvwixP0n+G64
         4pq+ll37VVqSNrMPqsFdxA2YYlE9hz5J/jWJM3pgxiqxrjXhpfViN8kbGKfegdJTZVB4
         3I2kTpRaCoKJ7zlM1LEJVH9DQbGyBf9IqT4/BH8TjsFhNCGCcHt7NF6PnPb2tSP/VaZX
         jvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=9m3T1Nih1NsVSAkhHW78RmCfreuv3OwtdZEGKLpv2Q8=;
        b=af5fwBTX84y6Wpp6cJ9Y+BxCy4FrM6cOQWRMegv+bVXsiCELah9GK8gHMH8yskgo33
         t/CbonXpaJAotJShUF4p7d7KpOZFSHVQRCTVCoq8C674n2hm2CxhvcZ8FbQ7Xqk/LBDc
         C8etvhORbllK9cNHsR7sjqhkkfrkZ0pc+gD+QOSk23sL6RVFa6SyJ5CkzAsfAurcYXSd
         xMRRLwvq6crd+0hyNFR9p8DXGo7H7TpncDUWQ7vY9T8c34z/2FpbhWP2hMLI9UFplQ6i
         p0tG143GK4BjXmg6e6DD2MsEeqAF4Q/onhLPV2X7/2uBK7VWg10DbskaLqSu3b7JgBsg
         /NiQ==
X-Gm-Message-State: ACgBeo2Coz7dSqE9HYA07yyvVsB0yMMF92wn+KXDfkE25UA03JO1wZ62
        nmpLl2Y+wENr5X1AxQtMdv7uFivD+jM=
X-Google-Smtp-Source: AA6agR5E7U9bOzJvDwnIQ8kvXpXg8hDh0mZ7KIk/4jB/i0OQR/BvLrnGvZmpRMEX9d/RIYViyBdvvA==
X-Received: by 2002:a05:6000:cf:b0:228:e37b:361b with SMTP id q15-20020a05600000cf00b00228e37b361bmr19098182wrx.374.1663097161660;
        Tue, 13 Sep 2022 12:26:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c2cb100b003a5ca627333sm15714153wmc.8.2022.09.13.12.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:26:01 -0700 (PDT)
Message-Id: <78e66d56605cfb1c7000edf329ac16c05a5d69b0.1663097156.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Sep 2022 19:25:52 +0000
Subject: [PATCH 4/8] http: read HTTP WWW-Authenticate response headers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Read and store the HTTP WWW-Authenticate response headers made for
a particular request.

This will allow us to pass important authentication challenge
information to credential helpers or others that would otherwise have
been lost.

According to RFC2616 Section 4.2 [1], header field names are not
case-sensitive meaning when collecting multiple values for the same
field name, we can just use the case of the first observed instance of
each field name and no normalisation is required.

libcurl only provides us with the ability to read all headers recieved
for a particular request, including any intermediate redirect requests
or proxies. The lines returned by libcurl include HTTP status lines
delinating any intermediate requests such as "HTTP/1.1 200". We use
these lines to reset the strvec of WWW-Authenticate header values as
we encounter them in order to only capture the final response headers.

The collection of all header values matching the WWW-Authenticate
header is complicated by the fact that it is legal for header fields to
be continued over multiple lines, but libcurl only gives us one line at
a time.

In the future [2] we may be able to leverage functions to read headers
from libcurl itself, but as of today we must do this ourselves.

[1] https://datatracker.ietf.org/doc/html/rfc2616#section-4.2
[2] https://daniel.haxx.se/blog/2022/03/22/a-headers-api-for-libcurl/

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 credential.c |  1 +
 credential.h | 10 +++++++
 http.c       | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)

diff --git a/credential.c b/credential.c
index f6389a50684..897b4679333 100644
--- a/credential.c
+++ b/credential.c
@@ -22,6 +22,7 @@ void credential_clear(struct credential *c)
 	free(c->username);
 	free(c->password);
 	string_list_clear(&c->helpers, 0);
+	strvec_clear(&c->wwwauth_headers);
 
 	credential_init(c);
 }
diff --git a/credential.h b/credential.h
index f430e77fea4..6a9d4e3de07 100644
--- a/credential.h
+++ b/credential.h
@@ -2,6 +2,7 @@
 #define CREDENTIAL_H
 
 #include "string-list.h"
+#include "strvec.h"
 
 /**
  * The credentials API provides an abstracted way of gathering username and
@@ -115,6 +116,14 @@ struct credential {
 	 */
 	struct string_list helpers;
 
+	/**
+	 * A `strvec` of WWW-Authenticate header values. Each string
+	 * is the value of a WWW-Authenticate header in an HTTP response,
+	 * in the order they were received in the response.
+	 */
+	struct strvec wwwauth_headers;
+	unsigned header_is_last_match:1;
+
 	unsigned approved:1,
 		 configured:1,
 		 quit:1,
@@ -130,6 +139,7 @@ struct credential {
 
 #define CREDENTIAL_INIT { \
 	.helpers = STRING_LIST_INIT_DUP, \
+	.wwwauth_headers = STRVEC_INIT, \
 }
 
 /* Initialize a credential structure, setting all fields to empty. */
diff --git a/http.c b/http.c
index 5d0502f51fd..091321af98e 100644
--- a/http.c
+++ b/http.c
@@ -183,6 +183,81 @@ size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 	return nmemb;
 }
 
+static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p)
+{
+	size_t size = eltsize * nmemb;
+	struct strvec *values = &http_auth.wwwauth_headers;
+	struct strbuf buf = STRBUF_INIT;
+	const char *val;
+	const char *z = NULL;
+
+	/*
+	 * Header lines may not come NULL-terminated from libcurl so we must
+	 * limit all scans to the maximum length of the header line, or leverage
+	 * strbufs for all operations.
+	 *
+	 * In addition, it is possible that header values can be split over
+	 * multiple lines as per RFC 2616 (even though this has since been
+	 * deprecated in RFC 7230). A continuation header field value is
+	 * identified as starting with a space or horizontal tab.
+	 *
+	 * The formal definition of a header field as given in RFC 2616 is:
+	 *
+	 *   message-header = field-name ":" [ field-value ]
+	 *   field-name     = token
+	 *   field-value    = *( field-content | LWS )
+	 *   field-content  = <the OCTETs making up the field-value
+	 *                    and consisting of either *TEXT or combinations
+	 *                    of token, separators, and quoted-string>
+	 */
+
+	strbuf_add(&buf, ptr, size);
+
+	/* Strip the CRLF that should be present at the end of each field */
+	strbuf_trim_trailing_newline(&buf);
+
+	/* Start of a new WWW-Authenticate header */
+	if (skip_iprefix(buf.buf, "www-authenticate:", &val)) {
+		while (isspace(*val)) val++;
+
+		strvec_push(values, val);
+		http_auth.header_is_last_match = 1;
+		goto exit;
+	}
+
+	/*
+	 * This line could be a continuation of the previously matched header
+	 * field. If this is the case then we should append this value to the
+	 * end of the previously consumed value.
+	 */
+	if (http_auth.header_is_last_match && isspace(*buf.buf)) {
+		const char **v = values->v + values->nr - 1;
+		char *append = xstrfmt("%s%.*s", *v, (int)(size - 1), ptr + 1);
+
+		free((void*)*v);
+		*v = append;
+
+		goto exit;
+	}
+
+	/* This is the start of a new header we don't care about */
+	http_auth.header_is_last_match = 0;
+
+	/*
+	 * If this is a HTTP status line and not a header field, this signals
+	 * a different HTTP response. libcurl writes all the output of all
+	 * response headers of all responses, including redirects.
+	 * We only care about the last HTTP request response's headers so clear
+	 * the existing array.
+	 */
+	if (skip_iprefix(buf.buf, "http/", &z))
+		strvec_clear(values);
+
+exit:
+	strbuf_release(&buf);
+	return size;
+}
+
 size_t fwrite_null(char *ptr, size_t eltsize, size_t nmemb, void *strbuf)
 {
 	return nmemb;
@@ -1829,6 +1904,8 @@ static int http_request(const char *url,
 					 fwrite_buffer);
 	}
 
+	curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, fwrite_wwwauth);
+
 	accept_language = http_get_accept_language_header();
 
 	if (accept_language)
-- 
gitgitgadget

