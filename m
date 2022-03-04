Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BE6C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 15:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240048AbiCDPFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 10:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240025AbiCDPF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 10:05:27 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A9F15B3EC
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 07:04:39 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id i66so5171717wma.5
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 07:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QN4mRAiTxC5fu7XTz9VlYgbA6F2pTz4HHm2IG6o9d0g=;
        b=XpvmGWszfnh5foW9AJBIWK+YqFrV0h8xdC4WpS+QpYG2h4Ydd+JA/RCtBrkS7h6b8U
         AX2DapkDSbS2cnxggxCUicUKEl+z4JfZsArd0uA5hVGX1xKuroAOKN7lTlyymkAsYBIm
         ej3AlXwUfyt3bJWuqPzC6Lu1J1kt2PIONVqgNHGPEwUogEtIskZXyji3ZDEqQ8saW+mt
         PEj46Vw83xka1zGTWUXeRK4+V1rXwxClclEykVDyJpb7zbDWTlLGBKCV+wfbdFxdU8z+
         fnL6JpCXsO4iQI/BwWrLuxtzx2QC2Tykm3cdPCF/7HWk/jzjkhXpETQ0hA8iGduuzRNT
         3HGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QN4mRAiTxC5fu7XTz9VlYgbA6F2pTz4HHm2IG6o9d0g=;
        b=NpNBnvPWCyhbegmTJuqrb5L5tpwX3N8je8zCcYGoSq0pIxlk268FHx5DGRXFLCCKpC
         H0xTJEzuodLhmvJbb2D1wFCi1qYuAuOEbFTIc3hRDFLgdSkdaof3YhUk/czvcAlm+dAa
         EnCrc0Vet2FKn63EGZYsQm7GoPApbn7ccvRVa641ndi+uDPVuaRWm08jmZ6P78clGlpy
         MpBFfCEpZs0JyNHNEB6zyI2O78+4rRdyt39YQwg0gGa5xpZc67g+e5/OLbyVsEFyydhV
         wzy4mIQmUXYgEWCJzchvjbmc/N+03vbbcQZrDmM7jqvYsthLPH5qbncFWRaW+vjjK1F2
         6PxQ==
X-Gm-Message-State: AOAM530MeAYVDVjhWJmHZlMKSUBynExsQZzX923Ny8WQwoWaT5cDIC9T
        tIp3WMWAfFTsNPs8NpXfrC0o1cTRp+o=
X-Google-Smtp-Source: ABdhPJx7CKOG7bZsfGNeVWP1sfSTEivmQWpZo5IpRD5a8vhB6sKxfyTBId3HV41BzVtI0rARt37EGw==
X-Received: by 2002:a05:600c:4f02:b0:382:c373:69e2 with SMTP id l2-20020a05600c4f0200b00382c37369e2mr8134844wmq.132.1646406277949;
        Fri, 04 Mar 2022 07:04:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7-20020a5d6707000000b001f067c7b47fsm3708198wru.27.2022.03.04.07.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 07:04:37 -0800 (PST)
Message-Id: <04ca6a07f859165cb06197dac862db251b342406.1646406275.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
References: <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
        <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Mar 2022 15:04:29 +0000
Subject: [PATCH v3 2/7] fetch-pack: add refetch
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
        <avarab@gmail.com>, Robert Coup <robert@coup.net.nz>,
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

