From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 07/23] http-push, http-walker: style fixes
Date: Sat, 6 Jun 2009 16:43:33 +0800
Message-ID: <20090606164333.85a57ade.rctay89@gmail.com>
References: <cover.1244277116.git.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 06 10:49:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCrak-0003qh-Sm
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 10:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130AbZFFItQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 04:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754075AbZFFItP
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 04:49:15 -0400
Received: from mail-px0-f181.google.com ([209.85.216.181]:33895 "EHLO
	mail-px0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503AbZFFItO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 04:49:14 -0400
Received: by pxi11 with SMTP id 11so21643pxi.33
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 01:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=RWJRvUoITZshHJl6vqLhYAVBNY1niAISKpLYcbP8hQU=;
        b=a2wMgD+M9aswHVhYnj2ZV6SAmPpIFA0xd8inngWdCz61xtKQJjUH3D3k8AGBS2Zg2c
         W5peJd1q78nLjCUNl7dcrXIEySeCf+ZOABixcbYOsZn3C7eEoiZlbvplrYb+IcezkxeQ
         X1KJbFbM2eP4zRf3xvrTKdRt3VxL8ftk/SMYI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=jkfHzavi0yITJkbA+svWZtSxCGQKPHu7twW904YtWcDQxrn/XW88MlwvTnd1RmQMhy
         lXdRaauXla/2Q/VQM5s41SFrtCAO8Svbn92quY8EZWV6JoDjaNwqSEk6Ab2LQQ/CkwvI
         I8nymuAsM318tQnzoWOwuGoa21S/aVmFBvJ+A=
Received: by 10.142.49.4 with SMTP id w4mr1500902wfw.211.1244278155914;
        Sat, 06 Jun 2009 01:49:15 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 28sm2812757wfd.23.2009.06.06.01.49.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 01:49:15 -0700 (PDT)
In-Reply-To: <cover.1244277116.git.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120888>

- Use tabs to indent, instead of spaces.

- Do not use curly-braces around a single statement body in
  if/while statement;

- Do not start multi-line comment with description on the first
  line after "/*", i.e.

  /*
   * We prefer this over...
   */

  /* comments like
   * this (notice the first line)
   */

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c   |   48 ++++++++++++++++++++-------------
 http-walker.c |   83 ++++++++++++++++++++++++++++++++++----------------------
 2 files changed, 79 insertions(+), 52 deletions(-)

diff --git a/http-push.c b/http-push.c
index 1d84f3b..6ac0d63 100644
--- a/http-push.c
+++ b/http-push.c
@@ -276,7 +276,7 @@ static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
 	struct transfer_request *request = (struct transfer_request *)data;
 	do {
 		ssize_t retval = xwrite(request->local_fileno,
-				       (char *) ptr + posn, size - posn);
+					(char *) ptr + posn, size - posn);
 		if (retval < 0)
 			return posn;
 		posn += retval;
@@ -289,7 +289,7 @@ static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
 		request->stream.avail_out = sizeof(expn);
 		request->zret = git_inflate(&request->stream, Z_SYNC_FLUSH);
 		git_SHA1_Update(&request->c, expn,
-			    sizeof(expn) - request->stream.avail_out);
+				sizeof(expn) - request->stream.avail_out);
 	} while (request->stream.avail_in && request->zret == Z_OK);
 	data_received++;
 	return size;
@@ -323,7 +323,8 @@ static void start_fetch_loose(struct transfer_request *request)
 		error("fd leakage in start: %d", request->local_fileno);
 	request->local_fileno = open(request->tmpfile,
 				     O_WRONLY | O_CREAT | O_EXCL, 0666);
-	/* This could have failed due to the "lazy directory creation";
+	/*
+	 * This could have failed due to the "lazy directory creation";
 	 * try to mkdir the last path component.
 	 */
 	if (request->local_fileno < 0 && errno == ENOENT) {
@@ -353,8 +354,10 @@ static void start_fetch_loose(struct transfer_request *request)
 	url = get_remote_object_url(repo->url, hex, 0);
 	request->url = xstrdup(url);

-	/* If a previous temp file is present, process what was already
-	   fetched. */
+	/*
+	 * If a previous temp file is present, process what was already
+	 * fetched.
+	 */
 	prevlocal = open(prevfile, O_RDONLY);
 	if (prevlocal != -1) {
 		do {
@@ -363,19 +366,20 @@ static void start_fetch_loose(struct transfer_request *request)
 				if (fwrite_sha1_file(prev_buf,
 						     1,
 						     prev_read,
-						     request) == prev_read) {
+						     request) == prev_read)
 					prev_posn += prev_read;
-				} else {
+				else
 					prev_read = -1;
-				}
 			}
 		} while (prev_read > 0);
 		close(prevlocal);
 	}
 	unlink_or_warn(prevfile);

-	/* Reset inflate/SHA1 if there was an error reading the previous temp
-	   file; also rewind to the beginning of the local file. */
+	/*
+	 * Reset inflate/SHA1 if there was an error reading the previous temp
+	 * file; also rewind to the beginning of the local file.
+	 */
 	if (prev_read == -1) {
 		memset(&request->stream, 0, sizeof(request->stream));
 		git_inflate_init(&request->stream);
@@ -398,8 +402,10 @@ static void start_fetch_loose(struct transfer_request *request)
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);

-	/* If we have successfully processed data from a previous fetch
-	   attempt, only fetch the data we don't already have. */
+	/*
+	 * If we have successfully processed data from a previous fetch
+	 * attempt, only fetch the data we don't already have.
+	 */
 	if (prev_posn>0) {
 		if (push_verbosely)
 			fprintf(stderr,
@@ -514,8 +520,10 @@ static void start_fetch_packed(struct transfer_request *request)
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
 	slot->local = packfile;

-	/* If there is data present from a previous transfer attempt,
-	   resume where it left off */
+	/*
+	 * If there is data present from a previous transfer attempt,
+	 * resume where it left off
+	 */
 	prev_posn = ftell(packfile);
 	if (prev_posn>0) {
 		if (push_verbosely)
@@ -780,7 +788,8 @@ static void finish_request(struct transfer_request *request)
 			aborted = 1;
 		}
 	} else if (request->state == RUN_FETCH_LOOSE) {
-		close(request->local_fileno); request->local_fileno = -1;
+		close(request->local_fileno);
+		request->local_fileno = -1;

 		if (request->curl_result != CURLE_OK &&
 		    request->http_code != 416) {
@@ -803,9 +812,8 @@ static void finish_request(struct transfer_request *request)
 					move_temp_to_file(
 						request->tmpfile,
 						request->filename);
-				if (request->rename == 0) {
+				if (request->rename == 0)
 					request->obj->flags |= (LOCAL | REMOTE);
-				}
 			}
 		}

@@ -1010,8 +1018,10 @@ static int fetch_index(unsigned char *sha1)
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, no_pragma_header);
 	slot->local = indexfile;

-	/* If there is data present from a previous transfer attempt,
-	   resume where it left off */
+	/*
+	 * If there is data present from a previous transfer attempt,
+	 * resume where it left off
+	 */
 	prev_posn = ftell(indexfile);
 	if (prev_posn>0) {
 		if (push_verbosely)
diff --git a/http-walker.c b/http-walker.c
index 9377851..6ac1783 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -71,7 +71,7 @@ static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
 	struct object_request *obj_req = (struct object_request *)data;
 	do {
 		ssize_t retval = xwrite(obj_req->local,
-				       (char *) ptr + posn, size - posn);
+					(char *) ptr + posn, size - posn);
 		if (retval < 0)
 			return posn;
 		posn += retval;
@@ -84,7 +84,7 @@ static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
 		obj_req->stream.avail_out = sizeof(expn);
 		obj_req->zret = git_inflate(&obj_req->stream, Z_SYNC_FLUSH);
 		git_SHA1_Update(&obj_req->c, expn,
-			    sizeof(expn) - obj_req->stream.avail_out);
+				sizeof(expn) - obj_req->stream.avail_out);
 	} while (obj_req->stream.avail_in && obj_req->zret == Z_OK);
 	data_received++;
 	return size;
@@ -119,7 +119,8 @@ static void start_object_request(struct walker *walker,
 		error("fd leakage in start: %d", obj_req->local);
 	obj_req->local = open(obj_req->tmpfile,
 			      O_WRONLY | O_CREAT | O_EXCL, 0666);
-	/* This could have failed due to the "lazy directory creation";
+	/*
+	 * This could have failed due to the "lazy directory creation";
 	 * try to mkdir the last path component.
 	 */
 	if (obj_req->local < 0 && errno == ENOENT) {
@@ -158,8 +159,10 @@ static void start_object_request(struct walker *walker,
 	strcpy(posn, hex + 2);
 	strcpy(obj_req->url, url);

-	/* If a previous temp file is present, process what was already
-	   fetched. */
+	/*
+	 * If a previous temp file is present, process what was already
+	 * fetched.
+	 */
 	prevlocal = open(prevfile, O_RDONLY);
 	if (prevlocal != -1) {
 		do {
@@ -168,19 +171,20 @@ static void start_object_request(struct walker *walker,
 				if (fwrite_sha1_file(prev_buf,
 						     1,
 						     prev_read,
-						     obj_req) == prev_read) {
+						     obj_req) == prev_read)
 					prev_posn += prev_read;
-				} else {
+				else
 					prev_read = -1;
-				}
 			}
 		} while (prev_read > 0);
 		close(prevlocal);
 	}
 	unlink_or_warn(prevfile);

-	/* Reset inflate/SHA1 if there was an error reading the previous temp
-	   file; also rewind to the beginning of the local file. */
+	/*
+	 * Reset inflate/SHA1 if there was an error reading the previous temp
+	 * file; also rewind to the beginning of the local file.
+	 */
 	if (prev_read == -1) {
 		memset(&obj_req->stream, 0, sizeof(obj_req->stream));
 		git_inflate_init(&obj_req->stream);
@@ -203,8 +207,10 @@ static void start_object_request(struct walker *walker,
 	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, data->no_pragma_header);

-	/* If we have successfully processed data from a previous fetch
-	   attempt, only fetch the data we don't already have. */
+	/*
+	 * If we have successfully processed data from a previous fetch
+	 * attempt, only fetch the data we don't already have.
+	 */
 	if (prev_posn>0) {
 		if (walker->get_verbosely)
 			fprintf(stderr,
@@ -221,7 +227,8 @@ static void start_object_request(struct walker *walker,
 	if (!start_active_slot(slot)) {
 		obj_req->state = ABORTED;
 		obj_req->slot = NULL;
-		close(obj_req->local); obj_req->local = -1;
+		close(obj_req->local);
+		obj_req->local = -1;
 		free(obj_req->url);
 		return;
 	}
@@ -231,7 +238,8 @@ static void finish_object_request(struct object_request *obj_req)
 {
 	struct stat st;

-	close(obj_req->local); obj_req->local = -1;
+	close(obj_req->local);
+	obj_req->local = -1;

 	if (obj_req->http_code == 416) {
 		fprintf(stderr, "Warning: requested range invalid; we may already have all the data.\n");
@@ -350,9 +358,8 @@ static void prefetch(struct walker *walker, unsigned char *sha1)
 		object_queue_head = newreq;
 	} else {
 		tail = object_queue_head;
-		while (tail->next != NULL) {
+		while (tail->next != NULL)
 			tail = tail->next;
-		}
 		tail->next = newreq;
 	}

@@ -401,8 +408,10 @@ static int fetch_index(struct walker *walker, struct alt_base *repo, unsigned ch
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, data->no_pragma_header);
 	slot->local = indexfile;

-	/* If there is data present from a previous transfer attempt,
-	   resume where it left off */
+	/*
+	 * If there is data present from a previous transfer attempt,
+	 * resume where it left off
+	 */
 	prev_posn = ftell(indexfile);
 	if (prev_posn>0) {
 		if (walker->get_verbosely)
@@ -507,7 +516,8 @@ static void process_alternates_response(void *callback_data)
 			struct alt_base *newalt;
 			char *target = NULL;
 			if (data[i] == '/') {
-				/* This counts
+				/*
+				 * This counts
 				 * http://git.host/pub/scm/linux.git/
 				 * -----------here^
 				 * so memcpy(dst, base, serverlen) will
@@ -520,7 +530,8 @@ static void process_alternates_response(void *callback_data)
 					okay = 1;
 				}
 			} else if (!memcmp(data + i, "../", 3)) {
-				/* Relative URL; chop the corresponding
+				/*
+				 * Relative URL; chop the corresponding
 				 * number of subpath from base (and ../
 				 * from data), and concatenate the result.
 				 *
@@ -549,7 +560,7 @@ static void process_alternates_response(void *callback_data)
 				}
 				/* If the server got removed, give up. */
 				okay = strchr(base, ':') - base + 3 <
-					serverlen;
+				       serverlen;
 			} else if (alt_req->http_specific) {
 				char *colon = strchr(data + i, ':');
 				char *slash = strchr(data + i, '/');
@@ -593,9 +604,11 @@ static void fetch_alternates(struct walker *walker, const char *base)
 	struct alternates_request alt_req;
 	struct walker_data *cdata = walker->data;

-	/* If another request has already started fetching alternates,
-	   wait for them to arrive and return to processing this request's
-	   curl message */
+	/*
+	 * If another request has already started fetching alternates,
+	 * wait for them to arrive and return to processing this request's
+	 * curl message
+	 */
 #ifdef USE_CURL_MULTI
 	while (cdata->got_alternates == 0) {
 		step_active_slots();
@@ -615,8 +628,10 @@ static void fetch_alternates(struct walker *walker, const char *base)
 	url = xmalloc(strlen(base) + 31);
 	sprintf(url, "%s/objects/info/http-alternates", base);

-	/* Use a callback to process the result, since another request
-	   may fail and need to have alternates loaded before continuing */
+	/*
+	 * Use a callback to process the result, since another request
+	 * may fail and need to have alternates loaded before continuing
+	 */
 	slot = get_active_slot();
 	slot->callback_func = process_alternates_response;
 	alt_req.walker = walker;
@@ -762,8 +777,10 @@ static int fetch_pack(struct walker *walker, struct alt_base *repo, unsigned cha
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, data->no_pragma_header);
 	slot->local = packfile;

-	/* If there is data present from a previous transfer attempt,
-	   resume where it left off */
+	/*
+	 * If there is data present from a previous transfer attempt,
+	 * resume where it left off
+	 */
 	prev_posn = ftell(packfile);
 	if (prev_posn>0) {
 		if (walker->get_verbosely)
@@ -840,18 +857,18 @@ static int fetch_object(struct walker *walker, struct alt_base *repo, unsigned c
 	}

 #ifdef USE_CURL_MULTI
-	while (obj_req->state == WAITING) {
+	while (obj_req->state == WAITING)
 		step_active_slots();
-	}
 #else
 	start_object_request(walker, obj_req);
 #endif

-	while (obj_req->state == ACTIVE) {
+	while (obj_req->state == ACTIVE)
 		run_active_slot(obj_req->slot);
-	}
+
 	if (obj_req->local != -1) {
-		close(obj_req->local); obj_req->local = -1;
+		close(obj_req->local);
+		obj_req->local = -1;
 	}

 	if (obj_req->state == ABORTED) {
--
1.6.3.1
