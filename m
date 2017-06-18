Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE6361FA7B
	for <e@80x24.org>; Sun, 18 Jun 2017 07:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752731AbdFRHxZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Jun 2017 03:53:25 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35271 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752665AbdFRHxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jun 2017 03:53:25 -0400
Received: by mail-pg0-f68.google.com with SMTP id f127so11813147pgc.2
        for <git@vger.kernel.org>; Sun, 18 Jun 2017 00:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mj4QoxZBUvD8VyQjPAf5ADaJIc20TnnRflBOmuq1rYk=;
        b=nQQuhwkjcsLGUD6RiGG7iL0XsSg14uHUxJHnPzwC9tD7iPFAhe3GdNcFP9zP73HVgt
         0ArNvQs+Jd/PZGWZtd+/kb8zfRaPc9u7Q0vjCZi8PX5EG4qUVN+h9D8M3A6mtHBTNOEE
         ydJppZMD44Y6e7cfCPCJEUMBqhguvgeBcZLxKBYCL3N58Kp5kEg2CE8DdlZG9p27sMM4
         L7SvBLBorPsO0lDs9O8Od/hDf9XqFgFAdtHYQZqL68DDF2JKuhRmh8OMPJKC968prydr
         DkTeNdN2eTZcvTswlhByutPFRyYdBs4Hd9ip+JacpWDPOK17qhOTPu9yVzv4fkGvs4VP
         0bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mj4QoxZBUvD8VyQjPAf5ADaJIc20TnnRflBOmuq1rYk=;
        b=VMxZCoYwg2/1EkuY7e9HR+ju0XgwllfjXQfqV5H5WmCO/4sBBDqpYERi8pfXk2c26p
         PZ6tR8JlLgW2iJGtsDcPS4RzpNShpM39dRCH2hr46hNTlMzVItCOtgqWU0Gvnyf/Ku7g
         oFPw2qiBKeOp6E0M7UXgVLiNZn2xrq7AFFW9RoqUxqruMbm3KhCIg7ZVxfrxk226jQo7
         EEhlSN9lsInsKQ7L9K8vEhs1ufeDs3zScvvO+/S2S0WzCXhv9jmKHw3ErM9b1JDPv+G/
         zxpDsuKIawAe/Jf2ZS9lZ59yU4RfijpwY7gaN1iimir/QSGeDiwo0+r8NUDmbfKVfDZZ
         cINA==
X-Gm-Message-State: AKS2vOyOqzftPe4d9JxETjPViFqy7AOYgfk9JGZYqmEQiI+GHL5PzyjG
        2oFtSVj9ncTH5w==
X-Received: by 10.99.114.19 with SMTP id n19mr2255461pgc.81.1497772404274;
        Sun, 18 Jun 2017 00:53:24 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7208:1ff:86ae:df58:5f4e:dbf8])
        by smtp.gmail.com with ESMTPSA id n2sm14718175pgd.26.2017.06.18.00.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Jun 2017 00:53:23 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     peff@peff.net, git@vger.kernel.org, sandals@crustytoothpaste.net,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: [PATCH/ALMOST FINAL] Contextually notify user about an initial commit
Date:   Sun, 18 Jun 2017 13:23:01 +0530
Message-Id: <20170618075301.6431-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <1497771338.1689.4.camel@gmail.com>
References: <1497771338.1689.4.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git status" indicated "Initial commit" when HEAD points at
an unborn branch.  This message is shared with the commit
log template "git commit" prepares for the user when
creating a commit (i.e. "You are about to create the initial
commit"), and is OK as long as the reader is aware of the
nature of the message (i.e. it guides the user working
toward the next commit), but was confusing to new users,
especially the ones who do "git commit -m message" without
having a chance to pay attention to the commit log template.

The "Initial commit" indication wasn't an issue in the commit
template. Taking that into consideration, a good solution would
be to contextually use different messages to indicate the user
that there were no commits in this branch.

A few alternatives considered were,

* Waiting for initial commit
* Your current branch does not have any commits
* Current branch waiting for initial commit

Patch-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 builtin/commit.c | 1 +
 wt-status.c      | 5 ++++-
 wt-status.h      | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 1d805f5da..0f36d2ac3 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1648,6 +1648,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_commit_usage, builtin_commit_options);
 
 	status_init_config(&s, git_commit_config);
+	s.commit_template = 1;
 	status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
 	s.colopts = 0;
 
diff --git a/wt-status.c b/wt-status.c
index 037548496..34aa1af66 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1576,7 +1576,10 @@ static void wt_longstatus_print(struct wt_status *s)
 
 	if (s->is_initial) {
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
-		status_printf_ln(s, color(WT_STATUS_HEADER, s), _("Initial commit"));
+		status_printf_ln(s, color(WT_STATUS_HEADER, s),
+				 s->commit_template
+				 ? _("Initial commit")
+				 : _("No commits yet on the branch"));
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
 	}
 
diff --git a/wt-status.h b/wt-status.h
index 6018c627b..782b2997f 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -76,6 +76,7 @@ struct wt_status {
 	char color_palette[WT_STATUS_MAXSLOT][COLOR_MAXLEN];
 	unsigned colopts;
 	int null_termination;
+	int commit_template;
 	int show_branch;
 	int hints;
 
-- 
2.11.0

