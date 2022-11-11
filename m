Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED77FC433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 22:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbiKKWfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 17:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKKWfK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 17:35:10 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A501613F47
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 14:35:09 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id l14so8133945wrw.2
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 14:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7+t7ZPz53qBe1UFCOUTWOMytKIBMr1qWkG0cmUGI68=;
        b=VbcK1vmzFuGcOl1V9c4oheVHpYKjYVWCgTikAuo5A6O3RxTvJxxJbOoBkecwKIdWRL
         LNHKZP9HkYMDeVNW+TdZaWS1E3/1uwRnSLBFSrxO3PV09iY+wZ2+czFECmUtL4vJ0vfL
         x4OJt0seoxlcJyvLY7IF+K4O/2e2LoFudRpe3SMYUTqE3S/mAXID3rQXKjV8V6WkYtPk
         DTnMOLh/atTvFEc4r26c8VgYD9RcEAbtA2J4M1o5NZLJwvwaaRtKdY78wqOEaMj3YUoe
         XwzMcXjWqnhnClowAUuSGDTuwoKOtFu3yM43QRKAPryZy9iGBmrAw278vkjYyRDSeynF
         gIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7+t7ZPz53qBe1UFCOUTWOMytKIBMr1qWkG0cmUGI68=;
        b=HNENSRrksE1l6MeL17ijbqr6haJeSp2qitYVb5idJe4pZKzcEKjzRcZU6YBZuQxsps
         GlX/OQVEKShgaxhDK+YuxuxIdjbDTYM5GiLXAswbKbfmZy64xS+wSyHNuL4cFVUNeDc8
         B2eRjUIRTglt76BqKnVGXTG7qZvctRBU+4cs9wNoDfM2LJys4u7Fc1qovM/qYhn61IIJ
         b6q0Sj7RScukt2qh9it4rmCuRh9BIr6KCECjsOFHXcuJ4t20UijJpMPqVlIheUgCPsAG
         HBp/fXqAQU+XtTIGpop9xDruAlM9dXJU4C2VjjTkMcHchqhHz0lWldhQGnAiJ9NOxiPL
         YsaQ==
X-Gm-Message-State: ANoB5plHR4d3nPPhXFlkysHYkDNSlzEqWNS9r1vExeoSjoKgEvJTG0D8
        uIXf+vFXqxrUFB/vSczLSEuImOw+Qkg=
X-Google-Smtp-Source: AA0mqf4D2oQEHLR2DWPQTmYIJp2GMZXAulCRuz2IAQwoyIL6Mtj/th5/nk3j4idHBiQzthbHzHnuFg==
X-Received: by 2002:a5d:4d49:0:b0:235:470e:a9f3 with SMTP id a9-20020a5d4d49000000b00235470ea9f3mr2267206wru.263.1668206107897;
        Fri, 11 Nov 2022 14:35:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k18-20020a5d6e92000000b0023647841c5bsm2903687wrz.60.2022.11.11.14.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 14:35:07 -0800 (PST)
Message-Id: <pull.1377.v3.git.git.1668206106.gitgitgadget@gmail.com>
In-Reply-To: <pull.1377.v2.git.git.1668121055059.gitgitgadget@gmail.com>
References: <pull.1377.v2.git.git.1668121055059.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Nov 2022 22:35:04 +0000
Subject: [PATCH v3 0/2] http: redact curl h2h3 headers in info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Emily Shaffer <nasamuffin@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Big thanks to Peff for the feedback last round. I've incorporated all of the
suggestions. I'm so glad that we finally have tests here :)

Changes in v3:

 * Add the HTTP2 test from [1] to the start of the series
 * Drop struct strbuf inner in favor of doing work on the original strbuf

Changes in v2:

 * Describe the redacted string in comments.
 * Return 1 for "redactions have happened".
 * Fix a leak of the "inner" strbuf.
 * Rename function, fix typo.

[1] https://lore.kernel.org/git/Y25hDr7aHvKnxso3@coredump.intra.peff.net

Glen Choo (1):
  http: redact curl h2h3 headers in info

Jeff King (1):
  t: run t5551 tests with both HTTP and HTTP/2

 http.c                            | 47 +++++++++++++++++++++++++++----
 t/lib-httpd.sh                    |  5 ++++
 t/lib-httpd/apache.conf           | 19 +++++++++++--
 t/t5551-http-fetch-smart.sh       | 13 +++++++--
 t/t5559-http-fetch-smart-http2.sh |  4 +++
 5 files changed, 77 insertions(+), 11 deletions(-)
 create mode 100755 t/t5559-http-fetch-smart-http2.sh


base-commit: c03801e19cb8ab36e9c0d17ff3d5e0c3b0f24193
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1377%2Fchooglen%2Fhttp%2Fredact-h2h3-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1377/chooglen/http/redact-h2h3-v3
Pull-Request: https://github.com/git/git/pull/1377

Range-diff vs v2:

 -:  ----------- > 1:  09194dba8cd t: run t5551 tests with both HTTP and HTTP/2
 1:  a8c35ff4ddf ! 2:  bb5df1a48b9 http: redact curl h2h3 headers in info
     @@ Commit message
      
          With GIT_TRACE_CURL=1 or GIT_CURL_VERBOSE=1, sensitive headers like
          "Authorization" and "Cookie" get redacted. However, since [1], curl's
     -    h2h3 module also prints headers in its "info", which don't get redacted.
     -    For example,
     +    h2h3 module (invoked when using HTTP/2) also prints headers in its
     +    "info", which don't get redacted. For example,
      
            echo 'github.com      TRUE    /       FALSE   1698960413304   o       foo=bar' >cookiefile &&
            GIT_TRACE_CURL=1 GIT_TRACE_CURL_NO_DATA=1 git \
     @@ Commit message
            23:04:16.920562 http.c:637              => Send header: cookie: o=<redacted>
      
          Teach http.c to check for h2h3 headers in info and redact them using the
     -    existing header redaction logic.
     +    existing header redaction logic. This fixes the broken redaction logic
     +    that we noted in the previous commit, so mark the redaction tests as
     +    passing under HTTP2.
      
          [1] https://github.com/curl/curl/commit/f8c3724aa90472c0e617ddbbc420aa199971eb77
      
     +    Helped-by: Jeff King <peff@peff.net>
          Signed-off-by: Glen Choo <chooglen@google.com>
      
       ## http.c ##
     @@ http.c: static void set_curl_keepalive(CURL *c)
       
      -static void redact_sensitive_header(struct strbuf *header)
      +/* Return 1 if redactions have been made, 0 otherwise. */
     -+static int redact_sensitive_header(struct strbuf *header)
     ++static int redact_sensitive_header(struct strbuf *header, size_t offset)
       {
      +	int ret = 0;
       	const char *sensitive_header;
       
       	if (trace_curl_redact &&
     +-	    (skip_iprefix(header->buf, "Authorization:", &sensitive_header) ||
     +-	     skip_iprefix(header->buf, "Proxy-Authorization:", &sensitive_header))) {
     ++	    (skip_iprefix(header->buf + offset, "Authorization:", &sensitive_header) ||
     ++	     skip_iprefix(header->buf + offset, "Proxy-Authorization:", &sensitive_header))) {
     + 		/* The first token is the type, which is OK to log */
     + 		while (isspace(*sensitive_header))
     + 			sensitive_header++;
      @@ http.c: static void redact_sensitive_header(struct strbuf *header)
       		/* Everything else is opaque and possibly sensitive */
       		strbuf_setlen(header,  sensitive_header - header->buf);
       		strbuf_addstr(header, " <redacted>");
      +		ret = 1;
       	} else if (trace_curl_redact &&
     - 		   skip_iprefix(header->buf, "Cookie:", &sensitive_header)) {
     +-		   skip_iprefix(header->buf, "Cookie:", &sensitive_header)) {
     ++		   skip_iprefix(header->buf + offset, "Cookie:", &sensitive_header)) {
       		struct strbuf redacted_header = STRBUF_INIT;
     + 		const char *cookie;
     + 
      @@ http.c: static void redact_sensitive_header(struct strbuf *header)
       
       		strbuf_setlen(header, sensitive_header - header->buf);
     @@ http.c: static void redact_sensitive_header(struct strbuf *header)
      +	 */
      +	if (trace_curl_redact &&
      +	    skip_iprefix(header->buf, "h2h3 [", &sensitive_header)) {
     -+		struct strbuf inner = STRBUF_INIT;
     -+
     -+		/* Drop the trailing "]" */
     -+		strbuf_add(&inner, sensitive_header, strlen(sensitive_header) - 1);
     -+		if (redact_sensitive_header(&inner)) {
     -+			strbuf_setlen(header, strlen("h2h3 ["));
     -+			strbuf_addbuf(header, &inner);
     ++		if (redact_sensitive_header(header, sensitive_header - header->buf)) {
     ++			/* redaction ate our closing bracket */
      +			strbuf_addch(header, ']');
      +		}
     -+
     -+		strbuf_release(&inner);
       	}
       }
       
     +@@ http.c: static void curl_dump_header(const char *text, unsigned char *ptr, size_t size,
     + 
     + 	for (header = headers; *header; header++) {
     + 		if (hide_sensitive_header)
     +-			redact_sensitive_header(*header);
     ++			redact_sensitive_header(*header, 0);
     + 		strbuf_insertstr((*header), 0, text);
     + 		strbuf_insertstr((*header), strlen(text), ": ");
     + 		strbuf_rtrim((*header));
      @@ http.c: static void curl_dump_data(const char *text, unsigned char *ptr, size_t size)
       	strbuf_release(&out);
       }
     @@ http.c: static int curl_trace(CURL *handle, curl_infotype type, char *data, size
       		break;
       	case CURLINFO_HEADER_OUT:
       		text = "=> Send header";
     +
     + ## t/t5551-http-fetch-smart.sh ##
     +@@ t/t5551-http-fetch-smart.sh: test_expect_success 'redirects send auth to new location' '
     + 	expect_askpass both user@host auth/smart/repo.git
     + '
     + 
     +-test_expect_success !HTTP2 'GIT_TRACE_CURL redacts auth details' '
     ++test_expect_success 'GIT_TRACE_CURL redacts auth details' '
     + 	rm -rf redact-auth trace &&
     + 	set_askpass user@host pass@host &&
     + 	GIT_TRACE_CURL="$(pwd)/trace" git clone --bare "$HTTPD_URL/auth/smart/repo.git" redact-auth &&
     +@@ t/t5551-http-fetch-smart.sh: test_expect_success !HTTP2 'GIT_TRACE_CURL redacts auth details' '
     + 	grep -i "Authorization: Basic <redacted>" trace
     + '
     + 
     +-test_expect_success !HTTP2 'GIT_CURL_VERBOSE redacts auth details' '
     ++test_expect_success 'GIT_CURL_VERBOSE redacts auth details' '
     + 	rm -rf redact-auth trace &&
     + 	set_askpass user@host pass@host &&
     + 	GIT_CURL_VERBOSE=1 git clone --bare "$HTTPD_URL/auth/smart/repo.git" redact-auth 2>trace &&
     +@@ t/t5551-http-fetch-smart.sh: test_expect_success 'fetch by SHA-1 without tag following' '
     + 		--no-tags origin $(cat bar_hash)
     + '
     + 
     +-test_expect_success !HTTP2 'cookies are redacted by default' '
     ++test_expect_success 'cookies are redacted by default' '
     + 	rm -rf clone &&
     + 	echo "Set-Cookie: Foo=1" >cookies &&
     + 	echo "Set-Cookie: Bar=2" >>cookies &&

-- 
gitgitgadget
