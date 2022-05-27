Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888CFC433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 21:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354698AbiE0VJp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 17:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351476AbiE0VJn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 17:09:43 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68054134E0B
        for <git@vger.kernel.org>; Fri, 27 May 2022 14:09:31 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j25so7408162wrb.6
        for <git@vger.kernel.org>; Fri, 27 May 2022 14:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=N1Eo3S49SuLE5/nvsGEp1jeWzQchxpAz/jsT0VzhlG0=;
        b=JO1Zd7UT/+IlBuLzNvxOORrV0T1an8T56YfRjUM7NsJ07gZDbO37QEhWIytT69hhIX
         7hgAmVxeULNe7gIv2mKuMTYP7xVep4wwz1lpig+8uOdpooE+7l33Mt+4zG96c8vLgl5y
         wPG93jT6D7Vnxcknuyfrc/mP3l8fHhkT8gbHTbva8i2fP3h8dyrUkKcUmuWygSUlUV3c
         XXppM3z2fcymfcIbhrTJ/RBRtt+w+FSsDBw/dJocG/rUxj8GWuWLPY3ieh8VtxwT2/vk
         2sfrNuAVJCpeYKP1nMMH2UMebGjJU/efxYMvelziKaSsAF+LqXOB4EOXkL7GBC/n7Foo
         UDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=N1Eo3S49SuLE5/nvsGEp1jeWzQchxpAz/jsT0VzhlG0=;
        b=g8ZryJCIFQhWlub8lSudxhb7OJfgQQdgjKMo+YP8RcTNzNS5qtiNxXwV/ukKPYKBSm
         DH8rg4CiJGw4JP/jJmvCg6fMmYTi9CSZrJ5vp9zbzHi6JbVymAkaavPm6MCoxp0ZjFtu
         7wVt/dFDFurJNjdEN2aL7kgeRQcmuNEuvvSW+PvMczVPOfJoBXLODZpnS7WvIol3UVc7
         CI4+YV1P9bf9UAk81ifND1D+1KiMkZhZ++FwERpCic+7ixw++0ZW7iSoHzhS+kDCJUKq
         iAhhPd3I7XztOXJZ6qaC/N6/OfaY63w3eWprKgL7WrYolV+U8DUz2iUY5YwZbF30rZ23
         /J7A==
X-Gm-Message-State: AOAM531GqecQ983DdIf/zyDMlxmt2g8xENHS6UTpHVGx2UW6ykpzD1fy
        ZU4cUF1jc4AnM/YjTjHEZqvazdbUZSE=
X-Google-Smtp-Source: ABdhPJxk8iQJC0edjotDUMyyYUfxOppRTyJcR17EVTzPROrOiDQhX7yU0tE6J1UVDG1hHU/as3rtKQ==
X-Received: by 2002:adf:cd87:0:b0:20f:e5fd:d265 with SMTP id q7-20020adfcd87000000b0020fe5fdd265mr20668450wrj.196.1653685769670;
        Fri, 27 May 2022 14:09:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g11-20020a5d64eb000000b0020fcc655e4asm2785697wri.5.2022.05.27.14.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 14:09:29 -0700 (PDT)
Message-Id: <e25d5907cd1e3894f19ffbfb3310175fd660563b.1653685761.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com>
References: <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
        <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 May 2022 21:09:21 +0000
Subject: [PATCH v3 5/5] upload-pack: make uploadpack.packObjectsHook protected
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Now that protected config includes "-c", "uploadpack.packObjectsHook"
behaves identically to a 'Protected config only' variable. Refactor it
to use git_protected_config() and mark it 'Protected config only'.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 Documentation/config/uploadpack.txt | 22 +++++++++-------------
 upload-pack.c                       | 17 +++++++++++------
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/Documentation/config/uploadpack.txt b/Documentation/config/uploadpack.txt
index 32fad5bbe81..57e5e021323 100644
--- a/Documentation/config/uploadpack.txt
+++ b/Documentation/config/uploadpack.txt
@@ -39,19 +39,15 @@ uploadpack.keepAlive::
 	disables keepalive packets entirely. The default is 5 seconds.
 
 uploadpack.packObjectsHook::
-	If this option is set, when `upload-pack` would run
-	`git pack-objects` to create a packfile for a client, it will
-	run this shell command instead.  The `pack-objects` command and
-	arguments it _would_ have run (including the `git pack-objects`
-	at the beginning) are appended to the shell command. The stdin
-	and stdout of the hook are treated as if `pack-objects` itself
-	was run. I.e., `upload-pack` will feed input intended for
-	`pack-objects` to the hook, and expects a completed packfile on
-	stdout.
-+
-Note that this configuration variable is ignored if it is seen in the
-repository-level config (this is a safety measure against fetching from
-untrusted repositories).
+	'(Protected config only)' If this option is set, when
+	`upload-pack` would run `git pack-objects` to create a packfile
+	for a client, it will run this shell command instead. The
+	`pack-objects` command and arguments it _would_ have run
+	(including the `git pack-objects` at the beginning) are appended
+	to the shell command. The stdin and stdout of the hook are
+	treated as if `pack-objects` itself was run. I.e., `upload-pack`
+	will feed input intended for `pack-objects` to the hook, and
+	expects a completed packfile on stdout.
 
 uploadpack.allowFilter::
 	If this option is set, `upload-pack` will support partial
diff --git a/upload-pack.c b/upload-pack.c
index 3a851b36066..2a39391369d 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1321,18 +1321,21 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
 		data->advertise_sid = git_config_bool(var, value);
 	}
 
-	if (current_config_scope() != CONFIG_SCOPE_LOCAL &&
-	    current_config_scope() != CONFIG_SCOPE_WORKTREE) {
-		if (!strcmp("uploadpack.packobjectshook", var))
-			return git_config_string(&data->pack_objects_hook, var, value);
-	}
-
 	if (parse_object_filter_config(var, value, data) < 0)
 		return -1;
 
 	return parse_hide_refs_config(var, value, "uploadpack");
 }
 
+static int upload_pack_protected_config(const char *var, const char *value, void *cb_data)
+{
+	struct upload_pack_data *data = cb_data;
+
+	if (!strcmp("uploadpack.packobjectshook", var))
+		return git_config_string(&data->pack_objects_hook, var, value);
+	return 0;
+}
+
 void upload_pack(const int advertise_refs, const int stateless_rpc,
 		 const int timeout)
 {
@@ -1342,6 +1345,7 @@ void upload_pack(const int advertise_refs, const int stateless_rpc,
 	upload_pack_data_init(&data);
 
 	git_config(upload_pack_config, &data);
+	git_protected_config(upload_pack_protected_config, &data);
 
 	data.stateless_rpc = stateless_rpc;
 	data.timeout = timeout;
@@ -1697,6 +1701,7 @@ int upload_pack_v2(struct repository *r, struct packet_reader *request)
 	data.use_sideband = LARGE_PACKET_MAX;
 
 	git_config(upload_pack_config, &data);
+	git_protected_config(upload_pack_protected_config, &data);
 
 	while (state != FETCH_DONE) {
 		switch (state) {
-- 
gitgitgadget
