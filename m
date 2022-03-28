Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2441AC433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 14:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243574AbiC1OED (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 10:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240764AbiC1OEB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 10:04:01 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10C55EDE8
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 07:02:19 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a1so20532891wrh.10
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 07:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QN4mRAiTxC5fu7XTz9VlYgbA6F2pTz4HHm2IG6o9d0g=;
        b=HBzoybZxl/KjlWoUFYlLKCn9gra7U7JDqPACWA/BctpcWstI8J7FUXjjObwLZYOVdH
         StmJ/+WuPFfz8fa9oS5PSVlTtWyyj1uOBVXKwmJ3Cj3JvDuBfvIdjAXxNGhyq2EaDJ4Q
         fvf8Zz8osvLjPa8NXYToTgr3oFfyyHsIYv0OYG/uZSnnvNPR6Kg/XPe89KCn6pjvgD2c
         F5p17m9DjBpd/C7t7AUOiF377DINZ2P4uh2/Y4Oiw31UzHbHpXkxN7rp1N93qkyCTPdv
         3CBzQ65l57iJIN+G0BrZMnTJHyial20uwE7NQu0BxPH2MQJAhgwlq9Xi7IxPyVbhYn/d
         Wftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QN4mRAiTxC5fu7XTz9VlYgbA6F2pTz4HHm2IG6o9d0g=;
        b=CPiwwp+r+p2WzOGqJGngEWKk5HmbwQEnTpcnJm5jf/Nci94CO8fO5Tdbr4jFGVsnHh
         SViFLoTIyJLMZVjqUsXmWm9hyEEk7NJc26ImiPExBlTv5xSCnITAQL4NKi+YURAm88fN
         oe2vHhSNwT/Ez2ogF5n/Stizq7OzplBTB6g//VcUQniJeY7hsBR9xmO8xr8Q6MS4GDrx
         4EUxGoft6Sp5UcE66GOazZYm2sVGpL2rMxtoL9jLFTR1h2fA3hQMh9sxjf+BCtD3bNNI
         +8QiCthQIrIMyWGfd4eIXn5H0S3GD6l61ICigT8iOiU65UmD9Ug2zchRkApFkXgcgh9A
         pOFw==
X-Gm-Message-State: AOAM531aLrFhcxm0qW00VfxCZaD/RJGfJHGWhuzP7k3Clte+RgX34lzD
        E8vz3Cf8LSRdqoJC7qVbz1KaJOnUBkY=
X-Google-Smtp-Source: ABdhPJwh22wVd2jhNJ5zNqRjJeVrXEBoqv0VLETyNQ4Q6sUgat3/nzN8Ce30CjCNZZz7OTeMrIDS3g==
X-Received: by 2002:a5d:688a:0:b0:204:6e3:f937 with SMTP id h10-20020a5d688a000000b0020406e3f937mr23852329wru.90.1648476137980;
        Mon, 28 Mar 2022 07:02:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11-20020a5d456b000000b0020406ce0e06sm12233993wrc.94.2022.03.28.07.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 07:02:16 -0700 (PDT)
Message-Id: <03f0de3d28c00cbfda73f31a21e0fa8f8fe51742.1648476132.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1138.v4.git.1648476131.gitgitgadget@gmail.com>
References: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
        <pull.1138.v4.git.1648476131.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Mar 2022 14:02:06 +0000
Subject: [PATCH v4 2/7] fetch-pack: add refetch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Calvin Wan <calvinwan@google.com>,
        Robert Coup <robert@coup.net.nz>,
        Robert Coup <robert@coup.net.nz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Coup <robert@coup.net.nz>

Allow a "refetch" where the contents of the local object store are
ignored and a full fetch is performed, not attempting to find or
negotiate common commits with the remote.

A key use case is to apply a new partial clone blob/tree filter and
refetch all the associated matching content, which would otherwise not
be transferred when the commit objects are already present locally.

Signed-off-by: Robert Coup <robert@coup.net.nz>
---
 fetch-pack.c | 46 +++++++++++++++++++++++++++++-----------------
 fetch-pack.h |  1 +
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 87657907e78..4e1e88eea09 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -312,19 +312,21 @@ static int find_common(struct fetch_negotiator *negotiator,
 		const char *remote_hex;
 		struct object *o;
 
-		/*
-		 * If that object is complete (i.e. it is an ancestor of a
-		 * local ref), we tell them we have it but do not have to
-		 * tell them about its ancestors, which they already know
-		 * about.
-		 *
-		 * We use lookup_object here because we are only
-		 * interested in the case we *know* the object is
-		 * reachable and we have already scanned it.
-		 */
-		if (((o = lookup_object(the_repository, remote)) != NULL) &&
-				(o->flags & COMPLETE)) {
-			continue;
+		if (!args->refetch) {
+			/*
+			* If that object is complete (i.e. it is an ancestor of a
+			* local ref), we tell them we have it but do not have to
+			* tell them about its ancestors, which they already know
+			* about.
+			*
+			* We use lookup_object here because we are only
+			* interested in the case we *know* the object is
+			* reachable and we have already scanned it.
+			*/
+			if (((o = lookup_object(the_repository, remote)) != NULL) &&
+					(o->flags & COMPLETE)) {
+				continue;
+			}
 		}
 
 		remote_hex = oid_to_hex(remote);
@@ -692,6 +694,9 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 	int old_save_commit_buffer = save_commit_buffer;
 	timestamp_t cutoff = 0;
 
+	if (args->refetch)
+		return;
+
 	save_commit_buffer = 0;
 
 	trace2_region_enter("fetch-pack", "parse_remote_refs_and_find_cutoff", NULL);
@@ -1028,7 +1033,11 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	struct fetch_negotiator *negotiator;
 
 	negotiator = &negotiator_alloc;
-	fetch_negotiator_init(r, negotiator);
+	if (args->refetch) {
+		fetch_negotiator_init_noop(negotiator);
+	} else {
+		fetch_negotiator_init(r, negotiator);
+	}
 
 	sort_ref_list(&ref, ref_compare_name);
 	QSORT(sought, nr_sought, cmp_ref_by_name);
@@ -1121,7 +1130,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 
 	mark_complete_and_common_ref(negotiator, args, &ref);
 	filter_refs(args, &ref, sought, nr_sought);
-	if (everything_local(args, &ref)) {
+	if (!args->refetch && everything_local(args, &ref)) {
 		packet_flush(fd[1]);
 		goto all_done;
 	}
@@ -1587,7 +1596,10 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct strvec index_pack_args = STRVEC_INIT;
 
 	negotiator = &negotiator_alloc;
-	fetch_negotiator_init(r, negotiator);
+	if (args->refetch)
+		fetch_negotiator_init_noop(negotiator);
+	else
+		fetch_negotiator_init(r, negotiator);
 
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
@@ -1613,7 +1625,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			/* Filter 'ref' by 'sought' and those that aren't local */
 			mark_complete_and_common_ref(negotiator, args, &ref);
 			filter_refs(args, &ref, sought, nr_sought);
-			if (everything_local(args, &ref))
+			if (!args->refetch && everything_local(args, &ref))
 				state = FETCH_DONE;
 			else
 				state = FETCH_SEND_REQUEST;
diff --git a/fetch-pack.h b/fetch-pack.h
index 7f94a2a5831..8c7752fc821 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -42,6 +42,7 @@ struct fetch_pack_args {
 	unsigned update_shallow:1;
 	unsigned reject_shallow_remote:1;
 	unsigned deepen:1;
+	unsigned refetch:1;
 
 	/*
 	 * Indicate that the remote of this request is a promisor remote. The
-- 
gitgitgadget

