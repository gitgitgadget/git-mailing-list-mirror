Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05666C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 00:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbiEXAXi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 20:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiEXAXR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 20:23:17 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EE4915B5
        for <git@vger.kernel.org>; Mon, 23 May 2022 17:23:12 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so486051wms.3
        for <git@vger.kernel.org>; Mon, 23 May 2022 17:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RQJVlgGN1lDBj4q0oaaU8S4Vs8blkBvpHuAU/1V7eog=;
        b=Vpz/T+yKd7Fs1d2BwwHJoMeKRiSWLLdCRtgzO1cL4oDv8xN2KIvcFEvew5WRMqoEYd
         PUA2cdbLvipbZaVoT9hJSInPhNeq67hEyXilVK4inI/fyrUugDL6mjUriWjPFsRHtn2R
         38MPkXVPbNvQSuQ71dHF7kk9uOoqAeIE8kSGgZxbQgOQt2AsVvbFpKmDuoX3Iz55zZ9j
         0W4hsFnSBIivuaI01cqgQW2qne2O8Hp8AQKrGHhOH8+LkN8sMnJxUhUu/muZceu1ggmR
         geCt15CabdjTU0A81TlOXQ/OCpTE353xtIDy+nIPOvEvlKVh2KzwVPc5eV5LvT8GO8BA
         GkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RQJVlgGN1lDBj4q0oaaU8S4Vs8blkBvpHuAU/1V7eog=;
        b=aQ3rICG9j6GSgAcp0lZT84/38VeKp+Kvl2/FG3YWwnsfSoNvNNXl/XRkeyG9ahszDa
         oPE3QVfQWQZoeUWCxaNrfX/d2q+7MKsqn6L8ai1J++4ULYqdKPR1SlZ5LBv+LtN9qs81
         FW5VHvVsgHQc5faDQBWYp21FGx5madqjnaq4J+5EA7IrLvUyOVGjHDL9FGHiwyoV+Ina
         ufjGW+3v/7ELbX392KsfUJ4EAKYiHUJCb+EbDE9+VWuY11L/3GL/QkUglk5SjLdr0R29
         ig91GkO/MPLcLmz9Y1cA5C1zH2nUo6gqKaPHHIjLCJ0fjXLPkTuW9vyQKEJOcm0A2cT6
         tcmw==
X-Gm-Message-State: AOAM530OxBHbvK3mkhWkThyVuezcIrbpzwH1LLnC39v/UM6dOg4U01Ok
        AjbALuVfWT88uhbuFcx4ZEi5hUTmBxk=
X-Google-Smtp-Source: ABdhPJxuwPKZbmUFNa7gYaN6QvWuT3Yn+SCKRwkQaEp0W77dXyjVZeArK2P/2ervHbjVy9cleyQorQ==
X-Received: by 2002:a05:600c:4ed3:b0:394:789b:913 with SMTP id g19-20020a05600c4ed300b00394789b0913mr1238575wmq.175.1653351790599;
        Mon, 23 May 2022 17:23:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g24-20020adfa498000000b0020c5253d90csm11273089wrb.88.2022.05.23.17.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 17:23:10 -0700 (PDT)
Message-Id: <4a4e0aa0a49a54eea88f9c2d8e1db6a697012718.1653351786.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1238.git.1653351786.gitgitgadget@gmail.com>
References: <pull.1238.git.1653351786.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 May 2022 00:23:05 +0000
Subject: [PATCH 3/4] http.c: avoid danging pointer to local variable
 `finished`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In http.c, the run_active_slot() function allows the given "slot" to
make progress by calling step_active_slots() in a loop repeatedly, and
the loop is not left until the request held in the slot completes.

Ages ago, we used to use the slot->in_use member to get out of the loop,
which misbehaved when the request in "slot" completes (at which time,
the result of the request is copied away from the slot, and the in_use
member is cleared, making the slot ready to be reused), and the "slot"
gets reused to service a different request (at which time, the "slot"
becomes in_use again, even though it is for a different request).  The
loop terminating condition mistakenly thought that the original request
has yet to be completed.

Today's code, after baa7b67d (HTTP slot reuse fixes, 2006-03-10) fixed
this issue, uses a separate "slot->finished" member that is set in
run_active_slot() to point to an on-stack variable, and the code that
completes the request in finish_active_slot() clears the on-stack
variable via the pointer to signal that the particular request held by
the slot has completed.  It also clears the in_use member (as before
that fix), so that the slot itself can safely be reused for an unrelated
request.

One thing that is not quite clean in this arrangement is that, unless
the slot gets reused, at which point the finished member is reset to
NULL, the member keeps the value of &finished, which becomes a dangling
pointer into the stack when run_active_slot() returns.

Let's drop that local variable and introduce a new flag in the slot that
is used to indicate that even while the slot is no longer in use, it is
still reserved until further notice. It is the responsibility of
`run_active_slot()` to clear that flag once it is done with that slot.

Initial-patch-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 http-walker.c |  4 ----
 http.c        | 15 +++++++--------
 http.h        |  2 +-
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index 910fae539b8..5cc369dea85 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -225,13 +225,9 @@ static void process_alternates_response(void *callback_data)
 					 alt_req->url->buf);
 			active_requests++;
 			slot->in_use = 1;
-			if (slot->finished != NULL)
-				(*slot->finished) = 0;
 			if (!start_active_slot(slot)) {
 				cdata->got_alternates = -1;
 				slot->in_use = 0;
-				if (slot->finished != NULL)
-					(*slot->finished) = 1;
 			}
 			return;
 		}
diff --git a/http.c b/http.c
index f92859f43fa..00206676597 100644
--- a/http.c
+++ b/http.c
@@ -197,8 +197,7 @@ static void finish_active_slot(struct active_request_slot *slot)
 	closedown_active_slot(slot);
 	curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CODE, &slot->http_code);
 
-	if (slot->finished != NULL)
-		(*slot->finished) = 1;
+	slot->in_use = 0;
 
 	/* Store slot results so they can be read after the slot is reused */
 	if (slot->results != NULL) {
@@ -1176,13 +1175,14 @@ struct active_request_slot *get_active_slot(void)
 			process_curl_messages();
 	}
 
-	while (slot != NULL && slot->in_use)
+	while (slot != NULL && (slot->in_use || slot->reserved_for_use))
 		slot = slot->next;
 
 	if (slot == NULL) {
 		newslot = xmalloc(sizeof(*newslot));
 		newslot->curl = NULL;
 		newslot->in_use = 0;
+		newslot->reserved_for_use = 0;
 		newslot->next = NULL;
 
 		slot = active_queue_head;
@@ -1204,7 +1204,6 @@ struct active_request_slot *get_active_slot(void)
 	active_requests++;
 	slot->in_use = 1;
 	slot->results = NULL;
-	slot->finished = NULL;
 	slot->callback_data = NULL;
 	slot->callback_func = NULL;
 	curl_easy_setopt(slot->curl, CURLOPT_COOKIEFILE, curl_cookie_file);
@@ -1296,7 +1295,7 @@ void fill_active_slots(void)
 	}
 
 	while (slot != NULL) {
-		if (!slot->in_use && slot->curl != NULL
+		if (!slot->in_use && !slot->reserved_for_use && slot->curl
 			&& curl_session_count > min_curl_sessions) {
 			curl_easy_cleanup(slot->curl);
 			slot->curl = NULL;
@@ -1327,10 +1326,9 @@ void run_active_slot(struct active_request_slot *slot)
 	fd_set excfds;
 	int max_fd;
 	struct timeval select_timeout;
-	int finished = 0;
 
-	slot->finished = &finished;
-	while (!finished) {
+	slot->reserved_for_use = 1;
+	while (slot->in_use) {
 		step_active_slots();
 
 		if (slot->in_use) {
@@ -1367,6 +1365,7 @@ void run_active_slot(struct active_request_slot *slot)
 			select(max_fd+1, &readfds, &writefds, &excfds, &select_timeout);
 		}
 	}
+	slot->reserved_for_use = 0;
 }
 
 static void release_active_slot(struct active_request_slot *slot)
diff --git a/http.h b/http.h
index df1590e53a4..3b2f6da570c 100644
--- a/http.h
+++ b/http.h
@@ -22,9 +22,9 @@ struct slot_results {
 struct active_request_slot {
 	CURL *curl;
 	int in_use;
+	int reserved_for_use;
 	CURLcode curl_result;
 	long http_code;
-	int *finished;
 	struct slot_results *results;
 	void *callback_data;
 	void (*callback_func)(void *data);
-- 
gitgitgadget

