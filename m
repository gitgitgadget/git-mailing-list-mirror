Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 261EA1F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 21:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128AbcHOVxx (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 17:53:53 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35258 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbcHOVxv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 17:53:51 -0400
Received: by mail-pa0-f41.google.com with SMTP id i5so19506845pat.2
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 14:53:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hbMXheiwOrDEWp+6BVXOziwAolklaqYKjjt/JHfdTT8=;
        b=EoVVr/4II7DFskyNQnxC0W8RX2Wv2CtirMXaLDTkngMgR9PqHXTs96CAPPzrqKdnJ6
         8mMMzTFpGy59UCNrYtG9M5HAiyiwjEpauktsY8PkqTZ+E184jYrxSXuW+p3tbMAJiaiK
         ySjpQBZR52dMU10RmYAw4shuZBRx8p3vlK5KWV2UzcpIleAAt4bHqKMe78sMcagMrhMU
         Vxa0DqO3fS7qIZTSVcQHKthJAaXO4Wc+Y0mnqWDtCPmFnConZ/Wrz5MrGWaH0F3+k85U
         xVoXxPf332TLzK9+jqiKP0F2WchhzhZwmRLwQUyu0RQs2NcFcO8ECsyhix+xvxfqejcg
         d9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hbMXheiwOrDEWp+6BVXOziwAolklaqYKjjt/JHfdTT8=;
        b=N9EuOSYRAKnGAg9hvhzv4Oa4u1fHuK7jQk/xmUgADEnenN9bJZHjUPZn6MXai4xW6I
         n8+3R1hmvyBAV6HHaQnoW3bqFk+HnJvQI+jpcDcD35QmKTp3b63zL7NBWELArvfY0bPo
         UOAa9hJrrAQVsL3Z2r5zG7AApGDz945FeNPHyCzyj23NOW7/qT8rZSTD64F8p6K5/8p2
         0qM46ts8ymq27hkUa9OXXSQmjzzMjb5aERQps7M16bcumw2T1tJTXHbn5OEhIkcuGAgD
         kDTYhPpSmVbtOyi6Lyh7sAyT/kc6lpVwLlulcUdDo4WyVfYBr3N97zcTOBfij7sPoOc5
         efmg==
X-Gm-Message-State: AEkooustgEuHW4bKkEg98C2xeutadFV7QD9H+xt4HLM2DRYwSC+BT+3b0o8psudQoQn7K7dg
X-Received: by 10.66.88.131 with SMTP id bg3mr58473651pab.43.1471298030935;
        Mon, 15 Aug 2016 14:53:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fd0c:5bce:d30d:9f4d])
        by smtp.gmail.com with ESMTPSA id wa9sm33753498pac.35.2016.08.15.14.53.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 Aug 2016 14:53:50 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 6/8] clone: clarify option_reference as required
Date:	Mon, 15 Aug 2016 14:53:25 -0700
Message-Id: <20160815215327.15682-7-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.730.g525ad04.dirty
In-Reply-To: <20160815215327.15682-1-sbeller@google.com>
References: <20160815215327.15682-1-sbeller@google.com>
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
index 4cd3a66..ef5db7c 100644
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
@@ -300,7 +300,7 @@ static int add_one_reference(struct string_list_item *item, void *cb_data)
 
 static void setup_reference(void)
 {
-	for_each_string_list(&option_reference, add_one_reference, NULL);
+	for_each_string_list(&option_required_reference, add_one_reference, NULL);
 }
 
 static void copy_alternates(struct strbuf *src, struct strbuf *dst,
@@ -952,7 +952,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	git_config_set(key.buf, repo);
 	strbuf_reset(&key);
 
-	if (option_reference.nr)
+	if (option_required_reference.nr)
 		setup_reference();
 
 	fetch_pattern = value.buf;
-- 
2.9.2.730.g525ad04.dirty

