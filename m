Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32C8E1F404
	for <e@80x24.org>; Sat, 28 Apr 2018 11:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759838AbeD1LeB (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 07:34:01 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39589 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759801AbeD1LeA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 07:34:00 -0400
Received: by mail-wr0-f193.google.com with SMTP id q3-v6so3993420wrj.6
        for <git@vger.kernel.org>; Sat, 28 Apr 2018 04:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G7Z+zeK4661wXkxhEDSOOuZUMJOndkyJJA4+RkOa6nk=;
        b=qqqFCk7+9sk/B47BtNN76De+03y31hmcvoAgrTmQXSk7i0+OjgWzIeT27He0f/jemu
         N203Kn/u68vVku96L7L1ETXBXdzlfr67mSsbWr7cOQ5ddENkggG1e4RpAPizgmp3PjrA
         vTbrlsJyljLKt8If5Lb6sunUo/Lsm4kyuA05OBZQpRIi+FRH7yJ72If6lEQY7ZfTW+qN
         ngePdmGVXHHugrdp2NK5ya1pVUNkCAD23phfCo76qNHT7tQZjxKe6tidmarAP59Qq09o
         bpEwTuBGmN7YzRDhGIrOx9IA2xK8Cd8jTINuPldOo4+IJBUYrDGwJ3dlIIFS+hIQU5iK
         ADlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G7Z+zeK4661wXkxhEDSOOuZUMJOndkyJJA4+RkOa6nk=;
        b=KYzVstpDr+JfH65Rk8wHpc1i0V7vo1CZJdTPJ3N8+++g7npAY0zxOrYoCkqf/BjsAn
         Oz1nYn0/f8CZzuhOWha91XOhL/3GHn7sF2jj749xaHeknvGuyBAoNAw3YlJR1sNxayLC
         pC+AklyiHTKAVr8FwaDAYuSf66IUjDpd7fiuCiyPEy3v+M8tF/eafaWDkA9gYbJDkhSg
         gtOMbetyrTi9LkU6ycdLTUEuokNHlzK+unNwFMcCKz7JQlRBZ4U+4bLnwawImCFcPGiB
         Sx0t1m9FenSMb9FgSDSUN+1dTJzYVoqieb2bDSdcPXR9CE46d/J/yrODl6wZRQ6BU6OY
         06XA==
X-Gm-Message-State: ALQs6tAyNLzCscH3iAicp7GPWCsRm59livbpVYgw9s4hgukkR7obKNdu
        rT/pLJihQVBogpGzgNd5o3o=
X-Google-Smtp-Source: AB8JxZouBnqdMMoRz9yRPxPwiMH2yt/KvURwig95pVgaP52p2Y9reQ6QIoWOUKqCrlPH6ASjzyAi0w==
X-Received: by 2002:adf:a9aa:: with SMTP id b39-v6mr4393223wrd.36.1524915239436;
        Sat, 28 Apr 2018 04:33:59 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id n23sm2737500wmc.23.2018.04.28.04.33.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 28 Apr 2018 04:33:58 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@talktalk.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH 2/2] unpack_trees_options: free messages when done
Date:   Sat, 28 Apr 2018 13:32:57 +0200
Message-Id: <20180428113257.25425-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424162939.20956-1-newren@gmail.com>
References: <20180424162939.20956-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Hi Elijah,

[Since this is leaving the topic of rename-detection in favour of 
leak-plugging, I'm shortening the cc-list a bit.]

> So, instead, I'd like to see something like the below
> (built on top of my series):

Thanks a lot. I now have the below patch in my tree as a preparatory
part of a three-patch series on top of your series. Since the gist of
this patch is entirely your creation, is it ok if I place your Author:
and Signed-off-by: on it? Credit where credit is due.

As you noted elsewhere [1], Ben is also working in this area. I'd be
perfectly happy to sit on these patches until both of your contributions
come through to master.

[1] https://public-inbox.org/git/CABPp-BFh=gL6RnbST2bgtynkij1Z5TMgAr1Via5_VyteF5eBMg@mail.gmail.com/

Martin

-->8--
Subject: merge-recursive: provide pair of `unpack_trees_{start,finish}()`

Rename `git_merge_trees()` to `unpack_trees_start()` and extract the
call to `discard_index()` into a new function `unpack_trees_finish()`.
As a result, these are called early resp. late in `merge_trees()`,
making the resource handling clearer. The next commit will expand on
that, teaching `..._finish()` to free more memory. (So rather than
moving the TODO-comment, just drop it, since it will be addressed soon
enough.)

Also call `..._finish()` when `merge_trees()` returns early.
---
 merge-recursive.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1de8dc1c53..e64102004a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -337,10 +337,10 @@ static void init_tree_desc_from_tree(struct tree_desc *desc, struct tree *tree)
 	init_tree_desc(desc, tree->buffer, tree->size);
 }
 
-static int git_merge_trees(struct merge_options *o,
-			   struct tree *common,
-			   struct tree *head,
-			   struct tree *merge)
+static int unpack_trees_start(struct merge_options *o,
+			      struct tree *common,
+			      struct tree *head,
+			      struct tree *merge)
 {
 	int rc;
 	struct tree_desc t[3];
@@ -378,6 +378,11 @@ static int git_merge_trees(struct merge_options *o,
 	return rc;
 }
 
+static void unpack_trees_finish(struct merge_options *o)
+{
+	discard_index(&o->orig_index);
+}
+
 struct tree *write_tree_from_memory(struct merge_options *o)
 {
 	struct tree *result = NULL;
@@ -3079,13 +3084,14 @@ int merge_trees(struct merge_options *o,
 		return 1;
 	}
 
-	code = git_merge_trees(o, common, head, merge);
+	code = unpack_trees_start(o, common, head, merge);
 
 	if (code != 0) {
 		if (show(o, 4) || o->call_depth)
 			err(o, _("merging of trees %s and %s failed"),
 			    oid_to_hex(&head->object.oid),
 			    oid_to_hex(&merge->object.oid));
+		unpack_trees_finish(o);
 		return -1;
 	}
 
@@ -3138,20 +3144,15 @@ int merge_trees(struct merge_options *o,
 
 		hashmap_free(&o->current_file_dir_set, 1);
 
-		if (clean < 0)
+		if (clean < 0) {
+			unpack_trees_finish(o);
 			return clean;
+		}
 	}
 	else
 		clean = 1;
 
-	/* Free the extra index left from git_merge_trees() */
-	/*
-	 * FIXME: Need to also data allocated by setup_unpack_trees_porcelain()
-	 * tucked away in o->unpack_opts.msgs, but the problem is that only
-	 * half of it refers to dynamically allocated data, while the other
-	 * half points at static strings.
-	 */
-	discard_index(&o->orig_index);
+	unpack_trees_finish(o);
 
 	if (o->call_depth && !(*result = write_tree_from_memory(o)))
 		return -1;
-- 
2.17.0

