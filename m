Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E58261F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 19:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbeKNFwm (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 00:52:42 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38182 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbeKNFwl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 00:52:41 -0500
Received: by mail-wm1-f66.google.com with SMTP id f2-v6so12575489wme.3
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 11:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2jC6GZM1sZyjkN9l/SNT0OrLbSRHjZh9Lv3QgFG2lEI=;
        b=cZB6x304n/T3EEuvs99YTh5gBbRNE9wOZAK2xAJVGYVgqIHLFVPtk71n8CA1/d8ZaY
         L5D6hCqxXseM3BSHtr5TWJGLsEV7ZqZHrGH8CJbGf7eztZxFSVfrxqpuPCAcNHGDfFI6
         9gugBB5FOgQ639uZQKEhQLW1vIrAw7KNnlhWw2Pdx0d8E5ER6WgMQxChq60YXLI4+KcZ
         3j9SsINpBBfEQyKKbM8RxVP1s67CwUqsveevgRsCukvEJOIzBKHtHRRnR99p0VO6dAFT
         U3VY4spAx6HNLUy0SwQddmInXIn+0FrtkcznMYhHiMGCYTon06IL5r/0iXiDwoLc3GUH
         vqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2jC6GZM1sZyjkN9l/SNT0OrLbSRHjZh9Lv3QgFG2lEI=;
        b=K8grr6vSWpg1yTbe4qz6+xmo/z2cOui1XyRpkIS0NPnvGTsLzSUC3zh9BtLUKohWj4
         BbpW0gNRmrm8QEPJ3wdfn5fLRlLkXhE2nBaBMwQVohuQO4C4xS763eIiflIFIJEFH+4O
         tcyQKTQ1DTuDurD0ArbItR5Q3a8YfVRPpcPFBfCA9Du7dAUtk7oy8Ip8+289JN5xdaBv
         RXLorqTHpwFJU3s50gZ1nlpXgCnahnAbCcVYWGqfLy3jkdIKJ1TFJJ7Z3AXAW6D8IDSh
         9on/gTMJ0oDvtO+zqKPaBKEfnHfBa8vLgffEbF95X75sbhJYaSqoxfr/B4ohYFrl/T3W
         wUtQ==
X-Gm-Message-State: AGRZ1gJPGH495HofZ6J3NlsvCCJsYGCIvOXzD33mC3kote0wiMhAYkau
        rtelas0ZhjzuDRP7JaVtVV8QUQLUZ08=
X-Google-Smtp-Source: AJdET5cso/QdPE3ypBzGGNNJK0cy62imRB/Op95X2PknpRInEVdvxvqF3jHRUl5lru6Fg4j33xNClw==
X-Received: by 2002:a7b:c38f:: with SMTP id s15-v6mr4514082wmj.145.1542138781457;
        Tue, 13 Nov 2018 11:53:01 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id y7-v6sm13828560wmy.27.2018.11.13.11.53.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 11:53:00 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 4/7] push: move unqualified refname error into a function
Date:   Tue, 13 Nov 2018 19:52:42 +0000
Message-Id: <20181113195245.14296-5-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.1182.g4ecb1133ce
In-Reply-To: <20181026230741.23321-1-avarab@gmail.com>
References: <20181026230741.23321-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A follow-up change will extend this error message with the advice
facility. Doing so would make the indentation too deeply nested for
comfort. So let's split this into a helper function.

There's no changes to the wording here. Just code moving &
re-indentation, and re-flowing the "TRANSLATORS" comment.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 remote.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/remote.c b/remote.c
index 15da4019c3..ba8abf4d32 100644
--- a/remote.c
+++ b/remote.c
@@ -1005,6 +1005,26 @@ static int match_explicit_lhs(struct ref *src,
 	}
 }
 
+static void show_push_unqualified_ref_name_error(const char *dst_value,
+						 const char *matched_src_name)
+{
+	/*
+	 * TRANSLATORS: "matches '%s'%" is the <dst> part of "git push
+	 * <remote> <src>:<dst>" push, and "being pushed ('%s')" is
+	 * the <src>.
+	 */
+	error(_("The destination you provided is not a full refname (i.e.,\n"
+		"starting with \"refs/\"). We tried to guess what you meant by:\n"
+		"\n"
+		"- Looking for a ref that matches '%s' on the remote side.\n"
+		"- Checking if the <src> being pushed ('%s')\n"
+		"  is a ref in \"refs/{heads,tags}/\". If so we add a corresponding\n"
+		"  refs/{heads,tags}/ prefix on the remote side.\n"
+		"\n"
+		"Neither worked, so we gave up. You must fully qualify the ref."),
+	      dst_value, matched_src_name);
+}
+
 static int match_explicit(struct ref *src, struct ref *dst,
 			  struct ref ***dst_tail,
 			  struct refspec_item *rs)
@@ -1049,22 +1069,8 @@ static int match_explicit(struct ref *src, struct ref *dst,
 			matched_dst = make_linked_ref(dst_guess, dst_tail);
 			free(dst_guess);
 		} else {
-			/*
-			 * TRANSLATORS: "matches '%s'%" is the <dst>
-			 * part of "git push <remote> <src>:<dst>"
-			 * push, and "being pushed ('%s')" is the
-			 * <src>.
-			 */
-			error(_("The destination you provided is not a full refname (i.e.,\n"
-				"starting with \"refs/\"). We tried to guess what you meant by:\n"
-				"\n"
-				"- Looking for a ref that matches '%s' on the remote side.\n"
-				"- Checking if the <src> being pushed ('%s')\n"
-				"  is a ref in \"refs/{heads,tags}/\". If so we add a corresponding\n"
-				"  refs/{heads,tags}/ prefix on the remote side.\n"
-				"\n"
-				"Neither worked, so we gave up. You must fully qualify the ref."),
-			      dst_value, matched_src->name);
+			show_push_unqualified_ref_name_error(dst_value,
+							     matched_src->name);
 		}
 		break;
 	default:
-- 
2.19.1.1182.g4ecb1133ce

