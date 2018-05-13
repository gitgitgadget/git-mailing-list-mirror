Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 498821F406
	for <e@80x24.org>; Sun, 13 May 2018 05:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751254AbeEMFwa (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 01:52:30 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34598 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeEMFwX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 01:52:23 -0400
Received: by mail-lf0-f66.google.com with SMTP id r25-v6so13380145lfd.1
        for <git@vger.kernel.org>; Sat, 12 May 2018 22:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OCI/PCOGrL4yTCnOZYk2uJKr2aPpfDZfeHE/+1dKpLU=;
        b=jwREmD07CCjF5XGxVbKH4wY7obX+4VwMOE4I03bUt28PSKMBtpEWgcXit5JGSLdVv8
         zKJa7PH9DYPbSKwBbMnd4gVviHfY8HvgwgOV2ZsETdf8ok+LQxIT24IpN+4DgwNvsAxB
         lKP4DfU0fwVZY+U3DQD+xRhDWaMEG09MPpOcAtE8F673hGKtlhuiU9h0JOJeJ2vuWqs0
         rAAMVK1y+btXdumKmNTDN9s+CtHwkgfXTeDa/P9gP0R70OVxtcKz3HaZE87OX5ZD3TXT
         /NTNRdIavrd76TgyaW7a4q+QfgfKdnMme8q6Drz6+My/tB5uPYe7wSkANGPn2srd4czb
         VWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OCI/PCOGrL4yTCnOZYk2uJKr2aPpfDZfeHE/+1dKpLU=;
        b=GaNvnMT6xT6EUpQvi5tB0rI+4Y2jXNBp/MMlXcM5vC4c4VuLDY26BNge6SncSQeDxq
         eHO26sxGumVvt0ZTLKzlyHCEe1Vri600d2DlTrTqQXSNtSsbClksi+iBiT78IrRuz7TJ
         zCKkRD0c1HJOBBDIv1x4X6JkrJVA8O6I0opFKgW9+Pf8YZ25l3Wqhp3SQezjXc73cE5u
         75ItxcyLt0HSxYZL+K8w0I94Omk/irP+k5jG0JSNPTYmG1iawXnfnnl92kU0kvjHGOKe
         dr+HMibjrzOX0+AaZj4gdYg17zeWWbPdcOcIlL0z16etGLTUJvZD46yqyT6eY3EThugU
         TqMw==
X-Gm-Message-State: ALKqPweubQsgbnjvO07g5FDdwG08kJ+8ZYglNOuEibIQbIMjc54RDuVx
        AqgNhEb8rA5OzPc3yW0x+i0YVg==
X-Google-Smtp-Source: AB8JxZqoIhciShJXxCbFBy09+ZPCeAFkDkW8D3JkRiqsScQ6ZT3ykgV4CJ/sy4zVKJdvwII0UKb77Q==
X-Received: by 2002:a2e:4185:: with SMTP id d5-v6mr1952649ljf.114.1526190741968;
        Sat, 12 May 2018 22:52:21 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id y5-v6sm1257779ljd.12.2018.05.12.22.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 22:52:21 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 07/14] sequencer.c: use commit-slab to associate todo items to commits
Date:   Sun, 13 May 2018 07:52:01 +0200
Message-Id: <20180513055208.17952-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180513055208.17952-1-pclouds@gmail.com>
References: <20180512080028.29611-1-pclouds@gmail.com>
 <20180513055208.17952-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's done so that commit->util can be removed. See more explanation in
the commit that removes commit->util.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sequencer.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 6b785c6c5f..dd4993fd99 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3362,6 +3362,8 @@ static int subject2item_cmp(const void *fndata,
 	return key ? strcmp(a->subject, key) : strcmp(a->subject, b->subject);
 }
 
+define_commit_slab(commit_todo_item, struct todo_item *);
+
 /*
  * Rearrange the todo list that has both "pick commit-id msg" and "pick
  * commit-id fixup!/squash! msg" in it so that the latter is put immediately
@@ -3378,6 +3380,7 @@ int rearrange_squash(void)
 	struct hashmap subject2item;
 	int res = 0, rearranged = 0, *next, *tail, i;
 	char **subjects;
+	struct commit_todo_item commit_todo;
 
 	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
 		return -1;
@@ -3386,6 +3389,7 @@ int rearrange_squash(void)
 		return -1;
 	}
 
+	init_commit_todo_item(&commit_todo);
 	/*
 	 * The hashmap maps onelines to the respective todo list index.
 	 *
@@ -3416,10 +3420,11 @@ int rearrange_squash(void)
 
 		if (is_fixup(item->command)) {
 			todo_list_release(&todo_list);
+			clear_commit_todo_item(&commit_todo);
 			return error(_("the script was already rearranged."));
 		}
 
-		item->commit->util = item;
+		*commit_todo_item_at(&commit_todo, item->commit) = item;
 
 		parse_commit(item->commit);
 		commit_buffer = get_commit_buffer(item->commit, NULL);
@@ -3446,9 +3451,9 @@ int rearrange_squash(void)
 			else if (!strchr(p, ' ') &&
 				 (commit2 =
 				  lookup_commit_reference_by_name(p)) &&
-				 commit2->util)
+				 *commit_todo_item_at(&commit_todo, commit2))
 				/* found by commit name */
-				i2 = (struct todo_item *)commit2->util
+				i2 = *commit_todo_item_at(&commit_todo, commit2)
 					- todo_list.items;
 			else {
 				/* copy can be a prefix of the commit subject */
@@ -3527,5 +3532,6 @@ int rearrange_squash(void)
 	hashmap_free(&subject2item, 1);
 	todo_list_release(&todo_list);
 
+	clear_commit_todo_item(&commit_todo);
 	return res;
 }
-- 
2.17.0.705.g3525833791

