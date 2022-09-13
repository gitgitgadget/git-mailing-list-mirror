Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B67ECAAD8
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 19:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiIMT0Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 15:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiIMT0J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 15:26:09 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DAF72B4C
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 12:26:05 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bj14so22333163wrb.12
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 12:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=vLw0qYalCooNhlK2Lxc4/zWY+hUhPGUErRGtlzuXuSI=;
        b=WtMThNMpKoQWibB0Ydfm/XK1Y1cuncy1vviloia11apuM4Tg5XCYkSNhrvSy1cQsJS
         VWakXZikZS/S0PryWBf0CieOydY4IK8q0heJs+0jmHOSUP8fNYJe2Mx2Vv8wljWrluIm
         JEOJJTx3Kux34RmtGio1WioLWkwwn/IFqTY4PgeL43iz0eD7iu5aGuW+OxfeMiGgxN9o
         RWSD0wbbsywEc6xKpfHfVbydY9pHfErPfYGQNOpXTb8THanITscOsLgEBaq7Vt5Qmf60
         7HmAEQz5pYiQlun0PYbqrrrKtoM+6c1aJ+/Mq4IKGIJz41SV22sDRKMMKNae3XNszPK9
         o36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vLw0qYalCooNhlK2Lxc4/zWY+hUhPGUErRGtlzuXuSI=;
        b=2Ww63wX7cK0/SZ7Yr0iU2IOlNrIIH0F7m4nNadVDtmUt2BBLCuEHvHD7D7RaIwGMC0
         3xn5FKXoPzqHaHzmvirT8d/cvsx7YYzr7dEwI9ibY/AujA1Ujw+lccD1V98a7l50mtYF
         F5SptAmx9GGRWAiHcB3OFFlCK3hZnTaorK/5FttwxBuCNZ0Ne8JuUL/c8G5BWCILhdQZ
         N/fLN5tWCjYxLqyfDrC8r9YuD+KTaFmZhIERiZxSJGXB0Lo1xQVg2MPd8U709T0C3uln
         09hLLy8Ta+H3kfN5UJ55YH0rIWOpVRjzeP8NfTnawjrCvacQkfl6vpeMN4yDx9c0Z+S7
         A96Q==
X-Gm-Message-State: ACgBeo0txzP5pIBn4DmxzViVPLffz+Gw05DbTrl2/+yOBxRmqEIxD8zZ
        48vT8baZ/nvdTjUob6eV0pkBUxdW1Bw=
X-Google-Smtp-Source: AA6agR7f1xQwCN6UFIjh7idLJq2FzXz2LaQTFsaYaysat0Eof8Dq4YUXFC2Fa1BpYSZfistamdsn6w==
X-Received: by 2002:a05:6000:243:b0:226:d241:11e6 with SMTP id m3-20020a056000024300b00226d24111e6mr19136818wrz.187.1663097163556;
        Tue, 13 Sep 2022 12:26:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i2-20020a5d4382000000b00228933481dbsm11197953wrq.47.2022.09.13.12.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 12:26:03 -0700 (PDT)
Message-Id: <20843e2051eeab71c5b7555f3e10383484e34b0e.1663097156.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Sep 2022 19:25:54 +0000
Subject: [PATCH 6/8] http: store all request headers on active_request_slot
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

Once a list of headers has been set on the curl handle, it is not
possible to recover that `struct curl_slist` instance to add or modify
headers.

In future commits we will want to modify the set of request headers in
response to an authentication challenge/401 response from the server,
with information provided by a credential helper.

There are a number of different places where curl is used for an HTTP
request, and they do not have a common handling of request headers.
However, given that they all do call the `start_active_slot()` function,
either directly or indirectly via `run_slot()` or `run_one_slot()`, we
use this as the point to set the `CURLOPT_HTTPHEADER` option just
before the request is made.

We collect all request headers in a `struct curl_slist` on the
`struct active_request_slot` that is obtained from a call to
`get_active_slot(int)`. This function now takes a single argument to
define if the initial set of headers on the slot should include the
"Pragma: no-cache" header, along with all extra headers specified via
`http.extraHeader` config values.

The active request slot obtained from `get_active_slot(int)` will always
contain a fresh set of default headers and any headers set in previous
usages of this slot will be freed.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 http-push.c   | 103 ++++++++++++++++++++++----------------------------
 http-walker.c |   2 +-
 http.c        |  82 ++++++++++++++++++----------------------
 http.h        |   4 +-
 remote-curl.c |  36 +++++++++---------
 5 files changed, 101 insertions(+), 126 deletions(-)

diff --git a/http-push.c b/http-push.c
index 5f4340a36e6..2b40959b376 100644
--- a/http-push.c
+++ b/http-push.c
@@ -211,29 +211,29 @@ static void curl_setup_http(CURL *curl, const char *url,
 	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1);
 }
 
-static struct curl_slist *get_dav_token_headers(struct remote_lock *lock, enum dav_header_flag options)
+static struct curl_slist *append_dav_token_headers(struct curl_slist *headers,
+	struct remote_lock *lock, enum dav_header_flag options)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct curl_slist *dav_headers = http_copy_default_headers();
 
 	if (options & DAV_HEADER_IF) {
 		strbuf_addf(&buf, "If: (<%s>)", lock->token);
-		dav_headers = curl_slist_append(dav_headers, buf.buf);
+		headers = curl_slist_append(headers, buf.buf);
 		strbuf_reset(&buf);
 	}
 	if (options & DAV_HEADER_LOCK) {
 		strbuf_addf(&buf, "Lock-Token: <%s>", lock->token);
-		dav_headers = curl_slist_append(dav_headers, buf.buf);
+		headers = curl_slist_append(headers, buf.buf);
 		strbuf_reset(&buf);
 	}
 	if (options & DAV_HEADER_TIMEOUT) {
 		strbuf_addf(&buf, "Timeout: Second-%ld", lock->timeout);
-		dav_headers = curl_slist_append(dav_headers, buf.buf);
+		headers = curl_slist_append(headers, buf.buf);
 		strbuf_reset(&buf);
 	}
 	strbuf_release(&buf);
 
-	return dav_headers;
+	return headers;
 }
 
 static void finish_request(struct transfer_request *request);
@@ -281,7 +281,7 @@ static void start_mkcol(struct transfer_request *request)
 
 	request->url = get_remote_object_url(repo->url, hex, 1);
 
-	slot = get_active_slot();
+	slot = get_active_slot(0);
 	slot->callback_func = process_response;
 	slot->callback_data = request;
 	curl_setup_http_get(slot->curl, request->url, DAV_MKCOL);
@@ -399,7 +399,7 @@ static void start_put(struct transfer_request *request)
 	strbuf_add(&buf, request->lock->tmpfile_suffix, the_hash_algo->hexsz + 1);
 	request->url = strbuf_detach(&buf, NULL);
 
-	slot = get_active_slot();
+	slot = get_active_slot(0);
 	slot->callback_func = process_response;
 	slot->callback_data = request;
 	curl_setup_http(slot->curl, request->url, DAV_PUT,
@@ -417,15 +417,13 @@ static void start_put(struct transfer_request *request)
 static void start_move(struct transfer_request *request)
 {
 	struct active_request_slot *slot;
-	struct curl_slist *dav_headers = http_copy_default_headers();
 
-	slot = get_active_slot();
+	slot = get_active_slot(0);
 	slot->callback_func = process_response;
 	slot->callback_data = request;
 	curl_setup_http_get(slot->curl, request->url, DAV_MOVE);
-	dav_headers = curl_slist_append(dav_headers, request->dest);
-	dav_headers = curl_slist_append(dav_headers, "Overwrite: T");
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
+	slot->headers = curl_slist_append(slot->headers, request->dest);
+	slot->headers = curl_slist_append(slot->headers, "Overwrite: T");
 
 	if (start_active_slot(slot)) {
 		request->slot = slot;
@@ -440,17 +438,16 @@ static int refresh_lock(struct remote_lock *lock)
 {
 	struct active_request_slot *slot;
 	struct slot_results results;
-	struct curl_slist *dav_headers;
 	int rc = 0;
 
 	lock->refreshing = 1;
 
-	dav_headers = get_dav_token_headers(lock, DAV_HEADER_IF | DAV_HEADER_TIMEOUT);
-
-	slot = get_active_slot();
+	slot = get_active_slot(0);
 	slot->results = &results;
+	slot->headers = append_dav_token_headers(slot->headers, lock,
+		DAV_HEADER_IF | DAV_HEADER_TIMEOUT);
+
 	curl_setup_http_get(slot->curl, lock->url, DAV_LOCK);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
@@ -464,7 +461,6 @@ static int refresh_lock(struct remote_lock *lock)
 	}
 
 	lock->refreshing = 0;
-	curl_slist_free_all(dav_headers);
 
 	return rc;
 }
@@ -838,7 +834,6 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 	char *ep;
 	char timeout_header[25];
 	struct remote_lock *lock = NULL;
-	struct curl_slist *dav_headers = http_copy_default_headers();
 	struct xml_ctx ctx;
 	char *escaped;
 
@@ -849,7 +844,7 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 	while (ep) {
 		char saved_character = ep[1];
 		ep[1] = '\0';
-		slot = get_active_slot();
+		slot = get_active_slot(0);
 		slot->results = &results;
 		curl_setup_http_get(slot->curl, url, DAV_MKCOL);
 		if (start_active_slot(slot)) {
@@ -875,14 +870,15 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 	strbuf_addf(&out_buffer.buf, LOCK_REQUEST, escaped);
 	free(escaped);
 
+	slot = get_active_slot(0);
+	slot->results = &results;
+
 	xsnprintf(timeout_header, sizeof(timeout_header), "Timeout: Second-%ld", timeout);
-	dav_headers = curl_slist_append(dav_headers, timeout_header);
-	dav_headers = curl_slist_append(dav_headers, "Content-Type: text/xml");
+	slot->headers = curl_slist_append(slot->headers, timeout_header);
+	slot->headers = curl_slist_append(slot->headers,
+		"Content-Type: text/xml");
 
-	slot = get_active_slot();
-	slot->results = &results;
 	curl_setup_http(slot->curl, url, DAV_LOCK, &out_buffer, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &in_buffer);
 
 	CALLOC_ARRAY(lock, 1);
@@ -921,7 +917,6 @@ static struct remote_lock *lock_remote(const char *path, long timeout)
 		fprintf(stderr, "Unable to start LOCK request\n");
 	}
 
-	curl_slist_free_all(dav_headers);
 	strbuf_release(&out_buffer.buf);
 	strbuf_release(&in_buffer);
 
@@ -945,15 +940,14 @@ static int unlock_remote(struct remote_lock *lock)
 	struct active_request_slot *slot;
 	struct slot_results results;
 	struct remote_lock *prev = repo->locks;
-	struct curl_slist *dav_headers;
 	int rc = 0;
 
-	dav_headers = get_dav_token_headers(lock, DAV_HEADER_LOCK);
-
-	slot = get_active_slot();
+	slot = get_active_slot(0);
 	slot->results = &results;
+	slot->headers = append_dav_token_headers(slot->headers, lock,
+		DAV_HEADER_LOCK);
+
 	curl_setup_http_get(slot->curl, lock->url, DAV_UNLOCK);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
@@ -966,8 +960,6 @@ static int unlock_remote(struct remote_lock *lock)
 		fprintf(stderr, "Unable to start UNLOCK request\n");
 	}
 
-	curl_slist_free_all(dav_headers);
-
 	if (repo->locks == lock) {
 		repo->locks = lock->next;
 	} else {
@@ -1121,7 +1113,6 @@ static void remote_ls(const char *path, int flags,
 	struct slot_results results;
 	struct strbuf in_buffer = STRBUF_INIT;
 	struct buffer out_buffer = { STRBUF_INIT, 0 };
-	struct curl_slist *dav_headers = http_copy_default_headers();
 	struct xml_ctx ctx;
 	struct remote_ls_ctx ls;
 
@@ -1134,14 +1125,14 @@ static void remote_ls(const char *path, int flags,
 
 	strbuf_addstr(&out_buffer.buf, PROPFIND_ALL_REQUEST);
 
-	dav_headers = curl_slist_append(dav_headers, "Depth: 1");
-	dav_headers = curl_slist_append(dav_headers, "Content-Type: text/xml");
-
-	slot = get_active_slot();
+	slot = get_active_slot(0);
 	slot->results = &results;
+	slot->headers = curl_slist_append(slot->headers, "Depth: 1");
+	slot->headers = curl_slist_append(slot->headers,
+		"Content-Type: text/xml");
+
 	curl_setup_http(slot->curl, url, DAV_PROPFIND,
 			&out_buffer, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &in_buffer);
 
 	if (start_active_slot(slot)) {
@@ -1177,7 +1168,6 @@ static void remote_ls(const char *path, int flags,
 	free(url);
 	strbuf_release(&out_buffer.buf);
 	strbuf_release(&in_buffer);
-	curl_slist_free_all(dav_headers);
 }
 
 static void get_remote_object_list(unsigned char parent)
@@ -1199,7 +1189,6 @@ static int locking_available(void)
 	struct slot_results results;
 	struct strbuf in_buffer = STRBUF_INIT;
 	struct buffer out_buffer = { STRBUF_INIT, 0 };
-	struct curl_slist *dav_headers = http_copy_default_headers();
 	struct xml_ctx ctx;
 	int lock_flags = 0;
 	char *escaped;
@@ -1208,14 +1197,14 @@ static int locking_available(void)
 	strbuf_addf(&out_buffer.buf, PROPFIND_SUPPORTEDLOCK_REQUEST, escaped);
 	free(escaped);
 
-	dav_headers = curl_slist_append(dav_headers, "Depth: 0");
-	dav_headers = curl_slist_append(dav_headers, "Content-Type: text/xml");
-
-	slot = get_active_slot();
+	slot = get_active_slot(0);
 	slot->results = &results;
+	slot->headers = curl_slist_append(slot->headers, "Depth: 0");
+	slot->headers = curl_slist_append(slot->headers,
+		"Content-Type: text/xml");
+
 	curl_setup_http(slot->curl, repo->url, DAV_PROPFIND,
 			&out_buffer, fwrite_buffer);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &in_buffer);
 
 	if (start_active_slot(slot)) {
@@ -1257,7 +1246,6 @@ static int locking_available(void)
 
 	strbuf_release(&out_buffer.buf);
 	strbuf_release(&in_buffer);
-	curl_slist_free_all(dav_headers);
 
 	return lock_flags;
 }
@@ -1374,17 +1362,16 @@ static int update_remote(const struct object_id *oid, struct remote_lock *lock)
 	struct active_request_slot *slot;
 	struct slot_results results;
 	struct buffer out_buffer = { STRBUF_INIT, 0 };
-	struct curl_slist *dav_headers;
-
-	dav_headers = get_dav_token_headers(lock, DAV_HEADER_IF);
 
 	strbuf_addf(&out_buffer.buf, "%s\n", oid_to_hex(oid));
 
-	slot = get_active_slot();
+	slot = get_active_slot(0);
 	slot->results = &results;
+	slot->headers = append_dav_token_headers(slot->headers, lock,
+		DAV_HEADER_IF);
+
 	curl_setup_http(slot->curl, lock->url, DAV_PUT,
 			&out_buffer, fwrite_null);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
 
 	if (start_active_slot(slot)) {
 		run_active_slot(slot);
@@ -1486,18 +1473,18 @@ static void update_remote_info_refs(struct remote_lock *lock)
 	struct buffer buffer = { STRBUF_INIT, 0 };
 	struct active_request_slot *slot;
 	struct slot_results results;
-	struct curl_slist *dav_headers;
 
 	remote_ls("refs/", (PROCESS_FILES | RECURSIVE),
 		  add_remote_info_ref, &buffer.buf);
 	if (!aborted) {
-		dav_headers = get_dav_token_headers(lock, DAV_HEADER_IF);
 
-		slot = get_active_slot();
+		slot = get_active_slot(0);
 		slot->results = &results;
+		slot->headers = append_dav_token_headers(slot->headers, lock,
+			DAV_HEADER_IF);
+
 		curl_setup_http(slot->curl, lock->url, DAV_PUT,
 				&buffer, fwrite_null);
-		curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
 
 		if (start_active_slot(slot)) {
 			run_active_slot(slot);
@@ -1652,7 +1639,7 @@ static int delete_remote_branch(const char *pattern, int force)
 	if (dry_run)
 		return 0;
 	url = xstrfmt("%s%s", repo->url, remote_ref->name);
-	slot = get_active_slot();
+	slot = get_active_slot(0);
 	slot->results = &results;
 	curl_setup_http_get(slot->curl, url, DAV_DELETE);
 	if (start_active_slot(slot)) {
diff --git a/http-walker.c b/http-walker.c
index b8f0f98ae14..8747de2fcdb 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -373,7 +373,7 @@ static void fetch_alternates(struct walker *walker, const char *base)
 	 * Use a callback to process the result, since another request
 	 * may fail and need to have alternates loaded before continuing
 	 */
-	slot = get_active_slot();
+	slot = get_active_slot(0);
 	slot->callback_func = process_alternates_response;
 	alt_req.walker = walker;
 	slot->callback_data = &alt_req;
diff --git a/http.c b/http.c
index 091321af98e..42616f746b1 100644
--- a/http.c
+++ b/http.c
@@ -124,8 +124,6 @@ static unsigned long empty_auth_useless =
 	| CURLAUTH_DIGEST_IE
 	| CURLAUTH_DIGEST;
 
-static struct curl_slist *pragma_header;
-static struct curl_slist *no_pragma_header;
 static struct string_list extra_http_headers = STRING_LIST_INIT_DUP;
 
 static struct curl_slist *host_resolutions;
@@ -1132,11 +1130,6 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	if (remote)
 		var_override(&http_proxy_authmethod, remote->http_proxy_authmethod);
 
-	pragma_header = curl_slist_append(http_copy_default_headers(),
-		"Pragma: no-cache");
-	no_pragma_header = curl_slist_append(http_copy_default_headers(),
-		"Pragma:");
-
 	{
 		char *http_max_requests = getenv("GIT_HTTP_MAX_REQUESTS");
 		if (http_max_requests)
@@ -1198,6 +1191,8 @@ void http_cleanup(void)
 
 	while (slot != NULL) {
 		struct active_request_slot *next = slot->next;
+		if (slot->headers)
+			curl_slist_free_all(slot->headers);
 		if (slot->curl) {
 			xmulti_remove_handle(slot);
 			curl_easy_cleanup(slot->curl);
@@ -1214,12 +1209,6 @@ void http_cleanup(void)
 
 	string_list_clear(&extra_http_headers, 0);
 
-	curl_slist_free_all(pragma_header);
-	pragma_header = NULL;
-
-	curl_slist_free_all(no_pragma_header);
-	no_pragma_header = NULL;
-
 	curl_slist_free_all(host_resolutions);
 	host_resolutions = NULL;
 
@@ -1254,7 +1243,18 @@ void http_cleanup(void)
 	FREE_AND_NULL(cached_accept_language);
 }
 
-struct active_request_slot *get_active_slot(void)
+static struct curl_slist *http_copy_default_headers(void)
+{
+	struct curl_slist *headers = NULL;
+	const struct string_list_item *item;
+
+	for_each_string_list_item(item, &extra_http_headers)
+		headers = curl_slist_append(headers, item->string);
+
+	return headers;
+}
+
+struct active_request_slot *get_active_slot(int no_pragma_header)
 {
 	struct active_request_slot *slot = active_queue_head;
 	struct active_request_slot *newslot;
@@ -1276,6 +1276,7 @@ struct active_request_slot *get_active_slot(void)
 		newslot->curl = NULL;
 		newslot->in_use = 0;
 		newslot->next = NULL;
+		newslot->headers = NULL;
 
 		slot = active_queue_head;
 		if (!slot) {
@@ -1293,6 +1294,15 @@ struct active_request_slot *get_active_slot(void)
 		curl_session_count++;
 	}
 
+	if (slot->headers)
+		curl_slist_free_all(slot->headers);
+
+	slot->headers = http_copy_default_headers();
+
+	if (!no_pragma_header)
+		slot->headers = curl_slist_append(slot->headers,
+			"Pragma: no-cache");
+
 	active_requests++;
 	slot->in_use = 1;
 	slot->results = NULL;
@@ -1302,7 +1312,6 @@ struct active_request_slot *get_active_slot(void)
 	curl_easy_setopt(slot->curl, CURLOPT_COOKIEFILE, curl_cookie_file);
 	if (curl_save_cookies)
 		curl_easy_setopt(slot->curl, CURLOPT_COOKIEJAR, curl_cookie_file);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, pragma_header);
 	curl_easy_setopt(slot->curl, CURLOPT_RESOLVE, host_resolutions);
 	curl_easy_setopt(slot->curl, CURLOPT_ERRORBUFFER, curl_errorstr);
 	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, NULL);
@@ -1334,9 +1343,12 @@ struct active_request_slot *get_active_slot(void)
 
 int start_active_slot(struct active_request_slot *slot)
 {
-	CURLMcode curlm_result = curl_multi_add_handle(curlm, slot->curl);
+	CURLMcode curlm_result;
 	int num_transfers;
 
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, slot->headers);
+	curlm_result = curl_multi_add_handle(curlm, slot->curl);
+
 	if (curlm_result != CURLM_OK &&
 	    curlm_result != CURLM_CALL_MULTI_PERFORM) {
 		warning("curl_multi_add_handle failed: %s",
@@ -1651,17 +1663,6 @@ int run_one_slot(struct active_request_slot *slot,
 	return handle_curl_result(results);
 }
 
-struct curl_slist *http_copy_default_headers(void)
-{
-	struct curl_slist *headers = NULL;
-	const struct string_list_item *item;
-
-	for_each_string_list_item(item, &extra_http_headers)
-		headers = curl_slist_append(headers, item->string);
-
-	return headers;
-}
-
 static CURLcode curlinfo_strbuf(CURL *curl, CURLINFO info, struct strbuf *buf)
 {
 	char *ptr;
@@ -1879,12 +1880,11 @@ static int http_request(const char *url,
 {
 	struct active_request_slot *slot;
 	struct slot_results results;
-	struct curl_slist *headers = http_copy_default_headers();
-	struct strbuf buf = STRBUF_INIT;
+	int no_cache = options && options->no_cache;
 	const char *accept_language;
 	int ret;
 
-	slot = get_active_slot();
+	slot = get_active_slot(!no_cache);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
 
 	if (!result) {
@@ -1909,27 +1909,23 @@ static int http_request(const char *url,
 	accept_language = http_get_accept_language_header();
 
 	if (accept_language)
-		headers = curl_slist_append(headers, accept_language);
+		slot->headers = curl_slist_append(slot->headers,
+			accept_language);
 
-	strbuf_addstr(&buf, "Pragma:");
-	if (options && options->no_cache)
-		strbuf_addstr(&buf, " no-cache");
 	if (options && options->initial_request &&
 	    http_follow_config == HTTP_FOLLOW_INITIAL)
 		curl_easy_setopt(slot->curl, CURLOPT_FOLLOWLOCATION, 1);
 
-	headers = curl_slist_append(headers, buf.buf);
-
 	/* Add additional headers here */
 	if (options && options->extra_headers) {
 		const struct string_list_item *item;
 		for_each_string_list_item(item, options->extra_headers) {
-			headers = curl_slist_append(headers, item->string);
+			slot->headers = curl_slist_append(slot->headers,
+				item->string);
 		}
 	}
 
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "");
 	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0);
 
@@ -1947,9 +1943,6 @@ static int http_request(const char *url,
 		curlinfo_strbuf(slot->curl, CURLINFO_EFFECTIVE_URL,
 				options->effective_url);
 
-	curl_slist_free_all(headers);
-	strbuf_release(&buf);
-
 	return ret;
 }
 
@@ -2310,12 +2303,10 @@ struct http_pack_request *new_direct_http_pack_request(
 		goto abort;
 	}
 
-	preq->slot = get_active_slot();
+	preq->slot = get_active_slot(1);
 	curl_easy_setopt(preq->slot->curl, CURLOPT_WRITEDATA, preq->packfile);
 	curl_easy_setopt(preq->slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
 	curl_easy_setopt(preq->slot->curl, CURLOPT_URL, preq->url);
-	curl_easy_setopt(preq->slot->curl, CURLOPT_HTTPHEADER,
-		no_pragma_header);
 
 	/*
 	 * If there is data present from a previous transfer attempt,
@@ -2480,14 +2471,13 @@ struct http_object_request *new_http_object_request(const char *base_url,
 		}
 	}
 
-	freq->slot = get_active_slot();
+	freq->slot = get_active_slot(1);
 
 	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEDATA, freq);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_FAILONERROR, 0);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_file);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_ERRORBUFFER, freq->errorstr);
 	curl_easy_setopt(freq->slot->curl, CURLOPT_URL, freq->url);
-	curl_easy_setopt(freq->slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
 
 	/*
 	 * If we have successfully processed data from a previous fetch
diff --git a/http.h b/http.h
index 3c94c479100..a304cc408b2 100644
--- a/http.h
+++ b/http.h
@@ -22,6 +22,7 @@ struct slot_results {
 struct active_request_slot {
 	CURL *curl;
 	int in_use;
+	struct curl_slist *headers;
 	CURLcode curl_result;
 	long http_code;
 	int *finished;
@@ -43,7 +44,7 @@ size_t fwrite_null(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
 curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp);
 
 /* Slot lifecycle functions */
-struct active_request_slot *get_active_slot(void);
+struct active_request_slot *get_active_slot(int no_pragma_header);
 int start_active_slot(struct active_request_slot *slot);
 void run_active_slot(struct active_request_slot *slot);
 void finish_all_active_slots(void);
@@ -64,7 +65,6 @@ void step_active_slots(void);
 void http_init(struct remote *remote, const char *url,
 	       int proactive_auth);
 void http_cleanup(void);
-struct curl_slist *http_copy_default_headers(void);
 
 extern long int git_curl_ipresolve;
 extern int active_requests;
diff --git a/remote-curl.c b/remote-curl.c
index 72dfb8fb86a..edbd4504beb 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -847,14 +847,13 @@ static int run_slot(struct active_request_slot *slot,
 static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 {
 	struct active_request_slot *slot;
-	struct curl_slist *headers = http_copy_default_headers();
 	struct strbuf buf = STRBUF_INIT;
 	int err;
 
-	slot = get_active_slot();
+	slot = get_active_slot(0);
 
-	headers = curl_slist_append(headers, rpc->hdr_content_type);
-	headers = curl_slist_append(headers, rpc->hdr_accept);
+	slot->headers = curl_slist_append(slot->headers, rpc->hdr_content_type);
+	slot->headers = curl_slist_append(slot->headers, rpc->hdr_accept);
 
 	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
 	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
@@ -862,13 +861,11 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, NULL);
 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, "0000");
 	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, 4);
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &buf);
 
 	err = run_slot(slot, results);
 
-	curl_slist_free_all(headers);
 	strbuf_release(&buf);
 	return err;
 }
@@ -888,7 +885,6 @@ static curl_off_t xcurl_off_t(size_t len)
 static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_received)
 {
 	struct active_request_slot *slot;
-	struct curl_slist *headers = http_copy_default_headers();
 	int use_gzip = rpc->gzip_request;
 	char *gzip_body = NULL;
 	size_t gzip_size = 0;
@@ -930,21 +926,23 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
 			needs_100_continue = 1;
 	}
 
-	headers = curl_slist_append(headers, rpc->hdr_content_type);
-	headers = curl_slist_append(headers, rpc->hdr_accept);
-	headers = curl_slist_append(headers, needs_100_continue ?
+retry:
+	slot = get_active_slot(0);
+
+	slot->headers = curl_slist_append(slot->headers, rpc->hdr_content_type);
+	slot->headers = curl_slist_append(slot->headers, rpc->hdr_accept);
+	slot->headers = curl_slist_append(slot->headers, needs_100_continue ?
 		"Expect: 100-continue" : "Expect:");
 
 	/* Add Accept-Language header */
 	if (rpc->hdr_accept_language)
-		headers = curl_slist_append(headers, rpc->hdr_accept_language);
+		slot->headers = curl_slist_append(slot->headers,
+			rpc->hdr_accept_language);
 
 	/* Add the extra Git-Protocol header */
 	if (rpc->protocol_header)
-		headers = curl_slist_append(headers, rpc->protocol_header);
-
-retry:
-	slot = get_active_slot();
+		slot->headers = curl_slist_append(slot->headers,
+			rpc->protocol_header);
 
 	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
 	curl_easy_setopt(slot->curl, CURLOPT_POST, 1);
@@ -955,7 +953,8 @@ retry:
 		/* The request body is large and the size cannot be predicted.
 		 * We must use chunked encoding to send it.
 		 */
-		headers = curl_slist_append(headers, "Transfer-Encoding: chunked");
+		slot->headers = curl_slist_append(slot->headers,
+			"Transfer-Encoding: chunked");
 		rpc->initial_buffer = 1;
 		curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, rpc_out);
 		curl_easy_setopt(slot->curl, CURLOPT_INFILE, rpc);
@@ -1002,7 +1001,8 @@ retry:
 
 		gzip_size = stream.total_out;
 
-		headers = curl_slist_append(headers, "Content-Encoding: gzip");
+		slot->headers = curl_slist_append(slot->headers,
+			"Content-Encoding: gzip");
 		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, gzip_body);
 		curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE_LARGE, xcurl_off_t(gzip_size));
 
@@ -1025,7 +1025,6 @@ retry:
 		}
 	}
 
-	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, rpc_in);
 	rpc_in_data.rpc = rpc;
 	rpc_in_data.slot = slot;
@@ -1055,7 +1054,6 @@ retry:
 	if (stateless_connect)
 		packet_response_end(rpc->in);
 
-	curl_slist_free_all(headers);
 	free(gzip_body);
 	return err;
 }
-- 
gitgitgadget

