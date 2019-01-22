Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 918A11F453
	for <e@80x24.org>; Tue, 22 Jan 2019 21:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfAVVW1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 16:22:27 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:36662 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfAVVWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 16:22:25 -0500
Received: by mail-ed1-f46.google.com with SMTP id f23so15452edb.3
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 13:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EJ95PQqHzSBcG7NICHPsSKArfsai5JdwDxdML/7q1Io=;
        b=BZFGoAMhkeav2thYtc4U1bzWfpxcZfEoo19yUMuIPwx97SpOFQF2W/rqg8gHX3z5wb
         YY/jbBD4StUTMl81eVhiL/UzJBGQl2E6rKG1rYowumGPhqfrjjLzlrPS4K9Tb/6/9nO/
         pyJhuLoy6jJX8asue0LpS6kKt/xPpY0bF1a1qlFsANYMItBSGf4BrVP+89tHePvw3fi6
         vuO0OdqC6ntqiIdJvbOi2l+6ZHSfos878JFKlHv6Cnhlulrex8FBb3KSco/vzlNs972N
         xjj6rJqZZLf9qKAd+WIgBkFmRgPZC/eOs6ETzvjfSA3XbqNXb7kzqfezV+OkD1dch0VM
         ldOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EJ95PQqHzSBcG7NICHPsSKArfsai5JdwDxdML/7q1Io=;
        b=hX/XodSKJIH2CYKHV+4evodUfFyhHg8FPd/xxS0Wz8K5EZm55BcKgUnSy7ZZdBxphW
         uyrFtywssqyd2ODjnuOHFsmbZo2tlpMsBQ1ekdsT+gRUAu9E0LKgnIsimHwl8qCI7QyK
         3eUyc1JKqZe3qF+LPB92lnnDqYVsRcBXjf5Lm2JFVrsrwfAH7fK4kWWVAACOrka/3qY2
         eTtyOnDY8og7WHX2ejTLFGPY/Ybt7pJdKzxmKNrf4ePfZlTTIGAqDYyJPt9q9RZrNLiU
         xTTnDdZdfn5Q2rWHvYBDysjj0GIK6oEpkT4qaRDgiP5utYdbx9+1W2bvV081ZlvADAwM
         4XqA==
X-Gm-Message-State: AJcUukeEP7z6fciKcOo05yoRB0mj7CiyEGnghOikSKFZyBuVyGz4ndCI
        3Rd7s/7Dwg7uycCTy5NSjRWNo1EG
X-Google-Smtp-Source: ALg8bN7rQ67OPRjNQDOcsVM9xRhQteMJ704WCHWYiAiqcWhDoBn6gDz0fPo/4etEwc5NuGc1j9w7vA==
X-Received: by 2002:a50:8eea:: with SMTP id x39mr110223edx.177.1548192143758;
        Tue, 22 Jan 2019 13:22:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a38sm9714365edd.44.2019.01.22.13.22.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 13:22:23 -0800 (PST)
Date:   Tue, 22 Jan 2019 13:22:23 -0800 (PST)
X-Google-Original-Date: Tue, 22 Jan 2019 21:22:10 GMT
Message-Id: <618e5ccb0ba5662c1f5d581d0dc50a0f64b51775.1548192131.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.git.gitgitgadget@gmail.com>
References: <pull.108.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 13/14] trace2:data: add subverb for rebase
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/rebase.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 00de70365e..aac0d52ade 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -819,6 +819,16 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		ACTION_EDIT_TODO,
 		ACTION_SHOW_CURRENT_PATCH,
 	} action = NO_ACTION;
+	static const char *action_names[] = {
+		N_("undefined"),
+		N_("continue"),
+		N_("skip"),
+		N_("abort"),
+		N_("quit"),
+		N_("edit_todo"),
+		N_("show_current_patch"),
+		NULL
+	};
 	const char *gpg_sign = NULL;
 	struct string_list exec = STRING_LIST_INIT_NODUP;
 	const char *rebase_merges = NULL;
@@ -1001,6 +1011,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		die(_("The --edit-todo action can only be used during "
 		      "interactive rebase."));
 
+	if (trace2_is_enabled()) {
+		if (is_interactive(&options))
+			trace2_cmd_subverb("interactive");
+		else if (exec.nr)
+			trace2_cmd_subverb("interactive-exec");
+		else
+			trace2_cmd_subverb(action_names[action]);
+	}
+
 	switch (action) {
 	case ACTION_CONTINUE: {
 		struct object_id head;
-- 
gitgitgadget

