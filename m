Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4F1C433F5
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 22:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7F4F61074
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 22:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhJSW77 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 18:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhJSW74 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 18:59:56 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013F5C06161C
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 15:57:42 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id g39so10760526wmp.3
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 15:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2ilqEFrYC5VGI89o9DeqCKACTNIHocslCTRHmnNsjrM=;
        b=ZbgA4jVieVeMhFKOiHr5Glhiji4oHqW6SWPp6W9XnbOwgs0ZoUajVmMnmySgeOQSpu
         7Utl+5NKPKrVSLKWb6JqWzZpIB0gBudiDIXDK/HjPYUA3U5rpLCFR6sNAl1PB5mALBAj
         3+NepRwA43tjtKXxCDfm9ltf/CJbkzEMkkpn0OzTFD0+MBkXgyAydALlDKUkc4fq2V/8
         iFL72Y2La/UKJVCuSc0r/FOg0cIhYXU/AM736JU51h6kO0uxg4/O1nfz2Mp+rZTjS4SE
         SnfcCqYMLkSI4BiB4wYs0hlbEJyCfj8qmW5yDK+IXAciN3fLDbWE9+Yxb4l9ZJ0ksD6p
         0bfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2ilqEFrYC5VGI89o9DeqCKACTNIHocslCTRHmnNsjrM=;
        b=HIwoKsWodnggG2dOC6TVcW5V5gKwFrEfGsFaUQXTB0lieNk9x5qN85hiOJNJjycQ3s
         N7Cp5GmenBUZzxJGc8ic2fiWgm8tyZrIpKwojwzx/PjfBIMFsrefl8onPLHtKaG1wZdw
         DxSHdL5ntQRpL4IfPRInAsJ4Py6/UpI3Snwz5e8dq/FeESCHFaUVPXqKFdCxTtuxCZMy
         IwwfwrV4cOyj1TQBHsWsZ4vsXgvQV7Y00i+gaZl27A8oT4MUppPJ5aBR21PwOtXwAXUw
         PgVZZeAg5Tb00VtaXVWF1xjAFBeSANbsASX88/FbbKItYM5KlmY0vD4G58MsBzbwAh3e
         YLBA==
X-Gm-Message-State: AOAM530Qo8R3p6Bvw+h6Uh9j/d3P58RwTO9IKpepsnLhz6Wnoj1JzLYB
        2HeoUy36pEGlYRz+8ZOC2n/1Wxi+9WI=
X-Google-Smtp-Source: ABdhPJxtyI+bAeWvRNsSsPRgXrvtaNb2NLV36korfMWgT3Ahq+v3/gOVebJGJ+UfpJ41W8uTaKRMKQ==
X-Received: by 2002:a5d:6d05:: with SMTP id e5mr46927249wrq.300.1634684261428;
        Tue, 19 Oct 2021 15:57:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c77sm333694wme.48.2021.10.19.15.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 15:57:40 -0700 (PDT)
Message-Id: <pull.1052.v3.git.1634684260142.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v2.git.1633746024175.gitgitgadget@gmail.com>
References: <pull.1052.v2.git.1633746024175.gitgitgadget@gmail.com>
From:   "Ivan Frade via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Oct 2021 22:57:39 +0000
Subject: [PATCH v3] fetch-pack: redact packfile urls in traces
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ivan Frade <ifrade@google.com>, Ivan Frade <ifrade@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ivan Frade <ifrade@google.com>

In some setups, packfile uris act as bearer token. It is not
recommended to expose them plainly in logs, although in special
circunstances (e.g. debug) it makes sense to write them.

Redact the packfile URL paths by default, unless the GIT_TRACE_REDACT
variable is set to false. This mimics the redacting of the Authorization
header in HTTP.

Signed-off-by: Ivan Frade <ifrade@google.com>
---
    fetch-pack: redact packfile urls in traces
    
    Changes since v1:
    
     * Redact only the path of the URL
     * Test are now strict, validating the exact line expected in the log
    
    Changes since v1:
    
     * Removed non-POSIX flags in tests
     * More accurate regex for the non-encrypted packfile line
     * Dropped documentation change
     * Dropped redacting the die message in http-fetch

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1052%2Fifradeo%2Fredact-packfile-uri-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1052/ifradeo/redact-packfile-uri-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1052

Range-diff vs v2:

 1:  701cb7a6ab9 ! 1:  9afe0093af4 fetch-pack: redact packfile urls in traces
     @@ Commit message
          recommended to expose them plainly in logs, although in special
          circunstances (e.g. debug) it makes sense to write them.
      
     -    Redact the packfile-uri lines by default, unless the GIT_TRACE_REDACT
     -    variable is set to false. This mimics the redacting of the
     -    Authorization header in HTTP.
     -
     -    Changes since v1:
     -    - Removed non-POSIX flags in tests
     -    - More accurate regex for the non-encrypted packfile line
     -    - Dropped documentation change
     -    - Dropped redacting the die message in http-fetch
     +    Redact the packfile URL paths by default, unless the GIT_TRACE_REDACT
     +    variable is set to false. This mimics the redacting of the Authorization
     +    header in HTTP.
      
          Signed-off-by: Ivan Frade <ifrade@google.com>
      
     @@ fetch-pack.c: static void receive_wanted_refs(struct packet_reader *reader,
       static void receive_packfile_uris(struct packet_reader *reader,
       				  struct string_list *uris)
       {
     -+	int original_options;
     ++	int saved_options;
       	process_section_header(reader, "packfile-uris", 0);
      +	/*
      +	 * In some setups, packfile-uris act as bearer tokens,
      +	 * redact them by default.
      +	 */
     -+	original_options = reader->options;
     ++	saved_options = reader->options;
      +	if (git_env_bool("GIT_TRACE_REDACT", 1))
     -+		reader->options |= PACKET_READ_REDACT_ON_TRACE;
     ++		reader->options |= PACKET_READ_REDACT_URL_PATH;
      +
       	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
       		if (reader->pktlen < the_hash_algo->hexsz ||
     @@ fetch-pack.c: static void receive_packfile_uris(struct packet_reader *reader,
       
       		string_list_append(uris, reader->line);
       	}
     -+	reader->options = original_options;
     ++	reader->options = saved_options;
      +
       	if (reader->status != PACKET_READ_DELIM)
       		die("expected DELIM");
       }
      
       ## pkt-line.c ##
     +@@ pkt-line.c: int packet_length(const char lenbuf_hex[4])
     + 	return (val < 0) ? val : (val << 8) | hex2chr(lenbuf_hex + 2);
     + }
     + 
     ++static int find_url_path_start(const char* buffer)
     ++{
     ++	const char *URL_MARK = "://";
     ++	char *p = strstr(buffer, URL_MARK);
     ++	if (!p) {
     ++		return -1;
     ++	}
     ++
     ++	p += strlen(URL_MARK);
     ++	while (*p && *p != '/')
     ++		p++;
     ++
     ++	// Position after '/'
     ++	if (*p && *(p + 1))
     ++		return (p + 1) - buffer;
     ++
     ++	return -1;
     ++}
     ++
     + enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
     + 						size_t *src_len, char *buffer,
     + 						unsigned size, int *pktlen,
     +@@ pkt-line.c: enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
     + {
     + 	int len;
     + 	char linelen[4];
     ++	int url_path_start;
     + 
     + 	if (get_packet_data(fd, src_buffer, src_len, linelen, 4, options) < 0) {
     + 		*pktlen = -1;
      @@ pkt-line.c: enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
       		len--;
       
       	buffer[len] = 0;
      -	packet_trace(buffer, len, 0);
     -+	if (options & PACKET_READ_REDACT_ON_TRACE) {
     ++	if (options & PACKET_READ_REDACT_URL_PATH &&
     ++	    (url_path_start = find_url_path_start(buffer)) != -1) {
      +		const char *redacted = "<redacted>";
     -+		packet_trace(redacted, strlen(redacted), 0);
     ++		struct strbuf tracebuf = STRBUF_INIT;
     ++		strbuf_insert(&tracebuf, 0, buffer, len);
     ++		strbuf_splice(&tracebuf, url_path_start,
     ++			      len - url_path_start, redacted, strlen(redacted));
     ++		packet_trace(tracebuf.buf, tracebuf.len, 0);
     ++		strbuf_release(&tracebuf);
      +	} else {
      +		packet_trace(buffer, len, 0);
      +	}
     @@ pkt-line.h: void packet_fflush(FILE *f);
       #define PACKET_READ_CHOMP_NEWLINE        (1u<<1)
       #define PACKET_READ_DIE_ON_ERR_PACKET    (1u<<2)
       #define PACKET_READ_GENTLE_ON_READ_ERROR (1u<<3)
     -+#define PACKET_READ_REDACT_ON_TRACE      (1u<<4)
     ++#define PACKET_READ_REDACT_URL_PATH      (1u<<4)
       int packet_read(int fd, char **src_buffer, size_t *src_len, char
       		*buffer, unsigned size, int options);
       
     @@ t/t5702-protocol-v2.sh: test_expect_success 'packfile-uri with transfer.fsckobje
       	test_i18ngrep "disallowed submodule name" err
       '
       
     -+test_expect_success 'packfile-uri redacted in trace' '
     ++test_expect_success 'packfile-uri path redacted in trace' '
      +	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
      +	rm -rf "$P" http_child log &&
      +
     @@ t/t5702-protocol-v2.sh: test_expect_success 'packfile-uri with transfer.fsckobje
      +	git -C "$P" add my-blob &&
      +	git -C "$P" commit -m x &&
      +
     -+	configure_exclusion "$P" my-blob >h &&
     ++	git -C "$P" hash-object my-blob >objh &&
     ++	git -C "$P" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
     ++	git -C "$P" config --add \
     ++		"uploadpack.blobpackfileuri" \
     ++		"$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
      +
      +	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
      +	git -c protocol.version=2 \
      +		-c fetch.uriprotocols=http,https \
      +		clone "$HTTPD_URL/smart/http_parent" http_child &&
      +
     -+	grep "clone< <redacted>" log
     ++	grep -F "clone< \\1$(cat packh) $HTTPD_URL/<redacted>" log
      +'
      +
     -+test_expect_success 'packfile-uri not redacted in trace when GIT_TRACE_REDACT=0' '
     ++test_expect_success 'packfile-uri path not redacted in trace when GIT_TRACE_REDACT=0' '
      +	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
      +	rm -rf "$P" http_child log &&
      +
     @@ t/t5702-protocol-v2.sh: test_expect_success 'packfile-uri with transfer.fsckobje
      +	git -C "$P" add my-blob &&
      +	git -C "$P" commit -m x &&
      +
     -+	configure_exclusion "$P" my-blob >h &&
     ++	git -C "$P" hash-object my-blob >objh &&
     ++	git -C "$P" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
     ++	git -C "$P" config --add \
     ++		"uploadpack.blobpackfileuri" \
     ++		"$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
      +
      +	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
      +	GIT_TRACE_REDACT=0 \
     @@ t/t5702-protocol-v2.sh: test_expect_success 'packfile-uri with transfer.fsckobje
      +		-c fetch.uriprotocols=http,https \
      +		clone "$HTTPD_URL/smart/http_parent" http_child &&
      +
     -+	grep -E "clone< ..[0-9a-f]{40,64} http://" log
     ++	grep -F "clone< \\1$(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" log
      +'
      +
       test_expect_success 'http:// --negotiate-only' '


 fetch-pack.c           | 11 +++++++++
 pkt-line.c             | 33 ++++++++++++++++++++++++++-
 pkt-line.h             |  1 +
 t/t5702-protocol-v2.sh | 51 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index a9604f35a3e..1587b9ae662 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1518,7 +1518,16 @@ static void receive_wanted_refs(struct packet_reader *reader,
 static void receive_packfile_uris(struct packet_reader *reader,
 				  struct string_list *uris)
 {
+	int saved_options;
 	process_section_header(reader, "packfile-uris", 0);
+	/*
+	 * In some setups, packfile-uris act as bearer tokens,
+	 * redact them by default.
+	 */
+	saved_options = reader->options;
+	if (git_env_bool("GIT_TRACE_REDACT", 1))
+		reader->options |= PACKET_READ_REDACT_URL_PATH;
+
 	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
 		if (reader->pktlen < the_hash_algo->hexsz ||
 		    reader->line[the_hash_algo->hexsz] != ' ')
@@ -1526,6 +1535,8 @@ static void receive_packfile_uris(struct packet_reader *reader,
 
 		string_list_append(uris, reader->line);
 	}
+	reader->options = saved_options;
+
 	if (reader->status != PACKET_READ_DELIM)
 		die("expected DELIM");
 }
diff --git a/pkt-line.c b/pkt-line.c
index de4a94b437e..1a9e6870559 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -386,6 +386,25 @@ int packet_length(const char lenbuf_hex[4])
 	return (val < 0) ? val : (val << 8) | hex2chr(lenbuf_hex + 2);
 }
 
+static int find_url_path_start(const char* buffer)
+{
+	const char *URL_MARK = "://";
+	char *p = strstr(buffer, URL_MARK);
+	if (!p) {
+		return -1;
+	}
+
+	p += strlen(URL_MARK);
+	while (*p && *p != '/')
+		p++;
+
+	// Position after '/'
+	if (*p && *(p + 1))
+		return (p + 1) - buffer;
+
+	return -1;
+}
+
 enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 						size_t *src_len, char *buffer,
 						unsigned size, int *pktlen,
@@ -393,6 +412,7 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 {
 	int len;
 	char linelen[4];
+	int url_path_start;
 
 	if (get_packet_data(fd, src_buffer, src_len, linelen, 4, options) < 0) {
 		*pktlen = -1;
@@ -443,7 +463,18 @@ enum packet_read_status packet_read_with_status(int fd, char **src_buffer,
 		len--;
 
 	buffer[len] = 0;
-	packet_trace(buffer, len, 0);
+	if (options & PACKET_READ_REDACT_URL_PATH &&
+	    (url_path_start = find_url_path_start(buffer)) != -1) {
+		const char *redacted = "<redacted>";
+		struct strbuf tracebuf = STRBUF_INIT;
+		strbuf_insert(&tracebuf, 0, buffer, len);
+		strbuf_splice(&tracebuf, url_path_start,
+			      len - url_path_start, redacted, strlen(redacted));
+		packet_trace(tracebuf.buf, tracebuf.len, 0);
+		strbuf_release(&tracebuf);
+	} else {
+		packet_trace(buffer, len, 0);
+	}
 
 	if ((options & PACKET_READ_DIE_ON_ERR_PACKET) &&
 	    starts_with(buffer, "ERR "))
diff --git a/pkt-line.h b/pkt-line.h
index 82b95e4bdd3..853d20688c8 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -88,6 +88,7 @@ void packet_fflush(FILE *f);
 #define PACKET_READ_CHOMP_NEWLINE        (1u<<1)
 #define PACKET_READ_DIE_ON_ERR_PACKET    (1u<<2)
 #define PACKET_READ_GENTLE_ON_READ_ERROR (1u<<3)
+#define PACKET_READ_REDACT_URL_PATH      (1u<<4)
 int packet_read(int fd, char **src_buffer, size_t *src_len, char
 		*buffer, unsigned size, int options);
 
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index d527cf6c49f..f01af2f2ed3 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -1107,6 +1107,57 @@ test_expect_success 'packfile-uri with transfer.fsckobjects fails when .gitmodul
 	test_i18ngrep "disallowed submodule name" err
 '
 
+test_expect_success 'packfile-uri path redacted in trace' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	rm -rf "$P" http_child log &&
+
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+
+	echo my-blob >"$P/my-blob" &&
+	git -C "$P" add my-blob &&
+	git -C "$P" commit -m x &&
+
+	git -C "$P" hash-object my-blob >objh &&
+	git -C "$P" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
+	git -C "$P" config --add \
+		"uploadpack.blobpackfileuri" \
+		"$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
+
+	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
+	git -c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		clone "$HTTPD_URL/smart/http_parent" http_child &&
+
+	grep -F "clone< \\1$(cat packh) $HTTPD_URL/<redacted>" log
+'
+
+test_expect_success 'packfile-uri path not redacted in trace when GIT_TRACE_REDACT=0' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	rm -rf "$P" http_child log &&
+
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+
+	echo my-blob >"$P/my-blob" &&
+	git -C "$P" add my-blob &&
+	git -C "$P" commit -m x &&
+
+	git -C "$P" hash-object my-blob >objh &&
+	git -C "$P" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
+	git -C "$P" config --add \
+		"uploadpack.blobpackfileuri" \
+		"$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
+
+	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
+	GIT_TRACE_REDACT=0 \
+	git -c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		clone "$HTTPD_URL/smart/http_parent" http_child &&
+
+	grep -F "clone< \\1$(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" log
+'
+
 test_expect_success 'http:// --negotiate-only' '
 	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
 	URI="$HTTPD_URL/smart/server" &&

base-commit: 9d530dc0024503ab4218fe6c4395b8a0aa245478
-- 
gitgitgadget
