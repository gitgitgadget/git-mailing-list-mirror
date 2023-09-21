Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D3BE7D0AE
	for <git@archiver.kernel.org>; Thu, 21 Sep 2023 21:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjIUVk0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Sep 2023 17:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjIUVjy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2023 17:39:54 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112461710
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 14:17:32 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59e8ebc0376so19560867b3.2
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 14:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695331051; x=1695935851; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6aHOle8N+he/kHuUZwZ5XD2ABLllxD2ea+pqnpp9t2c=;
        b=qkKPtMqGFJeP87Cpdl+yEmZdKgn7jVTXk3wLHSAAKJNH1GFo0pIiCHZEbQS3yJ0ObU
         4CdAs7aHpSlTje73xXheUGxUSXXdykk733RtZlqui74Fjw8uJjETRoci7UWK099Z2eHi
         Q8TeRi0H2fvElB+95+R586gHfTSYBj2lU3u0qc4i1gJsJHdT2vAJvDyzHOZE/L/ZJrqd
         nzhrnUS1rgqrA37xa4AC66mFPlNzWJFssUCMGSmEambzAmDuTgqUGpUqT8+LTqBIl+Ve
         +UwUfDj9PNFw6a3wQ66pGwiZ75NPzHAocpwD5riU+PSt5VVxcjJNYrHggZBXD/3nUhFY
         zaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695331051; x=1695935851;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6aHOle8N+he/kHuUZwZ5XD2ABLllxD2ea+pqnpp9t2c=;
        b=E9zzf4Xa6LMmIMsA+Mpl1FplrqDjDT+o3Hk+Oe/MD5RMIVQ9rbFPTLMSYLh3u3LbAw
         dgBGCejpWyf63IAI8C9Yy4TbG0qDOM1JJgcgNqwYzNeEFGgoPHHgR+V4O4xm8732o4VQ
         ZTn2+KgqK1/4dgNMGZLQP69syJVb3Hskt3pzVN42tRHTcC5iiLe38wZZeNq++SvU+F6N
         kJPe5P/0v7Tsy8t6CYAq8tImCXQW8Hfa9DWJmw+ZforAcO4qzDAUvYRHIE0cfiCyQsfy
         Z+w1mmIOpdwLeKBEfZZVd4hwWcPD51tpXFz7NqKkLw/ekn/H0OD5AxKOJCB7NWe0ndXW
         hpQQ==
X-Gm-Message-State: AOJu0YzD1EAqZQKm1R3V5TeOPAnRFdZ+zw1F2jzO0CeVmOBSDCEp6GLk
        VJPdLNUKURDtA4lM4cwx/EHzymMfLbe92hBBt754J/1khse5tU2KlQl8NIfsnAGcdD6XRuSB7xT
        urmnrqWoyx7FXLuI6ft41l4VBavh9cwRdUI+18FSMVNLv2SNPKO0wz7EtThsi/Ac=
X-Google-Smtp-Source: AGHT+IH1DJ90q+ylBjL9+WYagZFUDIy0Qq4Cnx4mZoD9Ipq/IY/LzAXKqvhkq4sXX21jY25n924dJozMSddP4g==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:828c:91e1:20c5:c8f])
 (user=steadmon job=sendgmr) by 2002:a81:a94a:0:b0:59b:ccba:1249 with SMTP id
 g71-20020a81a94a000000b0059bccba1249mr114618ywh.10.1695331051152; Thu, 21 Sep
 2023 14:17:31 -0700 (PDT)
Date:   Thu, 21 Sep 2023 14:17:21 -0700
In-Reply-To: <cover.1695330852.git.steadmon@google.com>
Mime-Version: 1.0
References: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com> <cover.1695330852.git.steadmon@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <8a1463c223497fca2fd3f11a54db5d7e52d1d08a.1695330852.git.steadmon@google.com>
Subject: [PATCH v3 2/5] config: split do_event() into start and flush operations
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, calvinwan@google.com, glencbz@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When handling config-parsing events, the current do_event() handler is a
bit confusing; calling it with a specific event type records the initial
offset where the event occurred, and runs the supplied callback against
the previous event (whose end offset is now known).

Split this operation into "start_event" and "flush_event" functions.
Then reimplement "do_event" (preserving the original behavior) using the
newly split functions.

In a later change, we can use these building blocks to also handle
"immediate" events, where we want to run the callback without having to
calculate an end offset for the event.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 config.c | 50 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/config.c b/config.c
index 1518f70fc2..ff138500a2 100644
--- a/config.c
+++ b/config.c
@@ -985,19 +985,11 @@ struct parse_event_data {
 	const struct config_parse_options *opts;
 };
 
-static int do_event(struct config_source *cs, enum config_event_t type,
-		    struct parse_event_data *data)
+static size_t get_corrected_offset(struct config_source *cs,
+				   enum config_event_t type)
 {
-	size_t offset;
-
-	if (!data->opts || !data->opts->event_fn)
-		return 0;
-
-	if (type == CONFIG_EVENT_WHITESPACE &&
-	    data->previous_type == type)
-		return 0;
+	size_t offset = cs->do_ftell(cs);
 
-	offset = cs->do_ftell(cs);
 	/*
 	 * At EOF, the parser always "inserts" an extra '\n', therefore
 	 * the end offset of the event is the current file position, otherwise
@@ -1005,14 +997,44 @@ static int do_event(struct config_source *cs, enum config_event_t type,
 	 */
 	if (type != CONFIG_EVENT_EOF)
 		offset--;
+	return offset;
+}
+
+static void start_event(struct config_source *cs, enum config_event_t type,
+		       struct parse_event_data *data)
+{
+	data->previous_type = type;
+	data->previous_offset = get_corrected_offset(cs, type);
+}
+
+static int flush_event(struct config_source *cs, enum config_event_t type,
+		       struct parse_event_data *data)
+{
+	if (!data->opts || !data->opts->event_fn)
+		return 0;
+
+	if (type == CONFIG_EVENT_WHITESPACE &&
+	    data->previous_type == type)
+		return 0;
 
 	if (data->previous_type != CONFIG_EVENT_EOF &&
 	    data->opts->event_fn(data->previous_type, data->previous_offset,
-				 offset, cs, data->opts->event_fn_data) < 0)
+				 get_corrected_offset(cs, type), cs,
+				 data->opts->event_fn_data) < 0)
 		return -1;
 
-	data->previous_type = type;
-	data->previous_offset = offset;
+	return 1;
+}
+
+static int do_event(struct config_source *cs, enum config_event_t type,
+		    struct parse_event_data *data)
+{
+	int maybe_ret;
+
+	if ((maybe_ret = flush_event(cs, type, data)) < 1)
+		return maybe_ret;
+
+	start_event(cs, type, data);
 
 	return 0;
 }
-- 
2.42.0.515.g380fc7ccd1-goog

