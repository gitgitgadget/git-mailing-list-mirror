Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71181203BD
	for <e@80x24.org>; Thu, 11 Aug 2016 23:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423AbcHKXO1 (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 19:14:27 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36483 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365AbcHKXOX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 19:14:23 -0400
Received: by mail-pf0-f179.google.com with SMTP id h186so2869542pfg.3
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 16:14:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ng4oFLNwCHU7rqR87C1lqNK++kxvoOY+qipBrhf/iKU=;
        b=ZEufdwauOzp3E4elU09qEX6YwP2QMzWKJKdEmZ65Br3vuAYH0UCGIg+OZ0lQYesDzv
         pgVb2ixsAje7LaVZbBCBv/okBponqd4Zmd5zHHp9toDHTX0zj1Ni7J/gE7IWWZRCtoVj
         eJOpF/N5mUyB/eGiaM2WfoD55LP3HyhBuvyIdutNqj882xJ+gBG0cQAP57119hSOhlqQ
         m7rfefVSIOdJwTz1q7V5Y3eCX0wr6GMcPS+cETQ7+eqLmECSntSxlzxBK6eiemhM45eW
         qgZMpCAKzOj8p1bmZMk5z40urDipAHLo7Rw8FTjpqeMfFAJMbxqA2HlmsirQyWjqjVvL
         wDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ng4oFLNwCHU7rqR87C1lqNK++kxvoOY+qipBrhf/iKU=;
        b=Yao5yHfVLPM0kYx0rIluwWrnzWMMSpFNjBYGYuj/8AqR90kLJFyVxsL0BN4WfVFJ16
         7twXwb4c+23IUHGiKW91lVzoCMyZiAioWRyx020GzYmx1U7pStyk2Z6zL7yxG9owmgNn
         iorhLknZcdBuB/pKiouvvKx+uPH2oYnpVhITUQ8m/jjdgAfW5nC5ZKOtWA6ysdxbEcKc
         hDWXs8thXeyJtNRs0DqL9ycsxj8hsJbtE2Ds0E2EYqdTwLNJ2WjdrqHyI8z8ZLWP4IF+
         yqJS/91NpzaOMJUBCHR+sJpbekdgbZ7+SX6HmWQGyBtziOCtYIlY5445PNx3rX0aCIp9
         ov4g==
X-Gm-Message-State: AEkoouuARx4nYb8NNZUaiaVam8Qkhs2bs1eMeUXAR3aw0Zici02kDBSzNMq3wGWxckEsvSMp
X-Received: by 10.98.213.130 with SMTP id d124mr21632153pfg.118.1470957262170;
        Thu, 11 Aug 2016 16:14:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:2879:1504:a6e4:e441])
        by smtp.gmail.com with ESMTPSA id ra13sm7725244pac.29.2016.08.11.16.14.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 Aug 2016 16:14:21 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 6/8] clone: clarify option_reference as required
Date:	Thu, 11 Aug 2016 16:14:03 -0700
Message-Id: <20160811231405.17318-7-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.737.g4a14654
In-Reply-To: <20160811231405.17318-1-sbeller@google.com>
References: <20160811231405.17318-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In the next patch we introduce optional references; To better distinguish
between optional and required references we rename the variable.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/clone.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 24b17539..7ccbdef 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -50,7 +50,7 @@ static int option_verbosity;
 static int option_progress = -1;
 static enum transport_family family;
 static struct string_list option_config = STRING_LIST_INIT_NODUP;
-static struct string_list option_reference = STRING_LIST_INIT_NODUP;
+static struct string_list option_required_reference = STRING_LIST_INIT_NODUP;
 static int option_dissociate;
 static int max_jobs = -1;
 
@@ -79,7 +79,7 @@ static struct option builtin_clone_options[] = {
 		    N_("number of submodules cloned in parallel")),
 	OPT_STRING(0, "template", &option_template, N_("template-directory"),
 		   N_("directory from which templates will be used")),
-	OPT_STRING_LIST(0, "reference", &option_reference, N_("repo"),
+	OPT_STRING_LIST(0, "reference", &option_required_reference, N_("repo"),
 			N_("reference repository")),
 	OPT_BOOL(0, "dissociate", &option_dissociate,
 		 N_("use --reference only while cloning")),
@@ -297,7 +297,7 @@ static int add_one_reference(struct string_list_item *item, void *cb_data)
 
 static void setup_reference(void)
 {
-	for_each_string_list(&option_reference, add_one_reference, NULL);
+	for_each_string_list(&option_required_reference, add_one_reference, NULL);
 }
 
 static void copy_alternates(struct strbuf *src, struct strbuf *dst,
@@ -949,7 +949,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	git_config_set(key.buf, repo);
 	strbuf_reset(&key);
 
-	if (option_reference.nr)
+	if (option_required_reference.nr)
 		setup_reference();
 
 	fetch_pattern = value.buf;
-- 
2.9.2.737.g4a14654

