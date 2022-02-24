Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D99C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 16:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiBXQ2T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 11:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiBXQ2S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 11:28:18 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73230107830
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:27:46 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id o62-20020a1ca541000000b00380e3cc26b7so156045wme.0
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ipJUUily8FthndGEpAjnRsp0x5TyWGuHke5fA/MgxUg=;
        b=Oi83URpK7u1d9ygcdpu5P+hkA6dJr3Zh2uu9mlu/hQ04+23dPKFnfAotY+v1X05jh7
         3q3MapFndLjxDt7JQMbadOjZB3jzF2HSPCVOoiElQriSQ2EjkDt5IuK35vS+gS5cQIAg
         mNY+7TS9f+pnYh+nd2A1Em/xOJoOjeQsjkSnAvXLXUwJYa8nE2utyHeelkuBRYov6u4f
         WM1yE+nS8dCjzTBysxYZ2S0vzsYZIqG3oAlLAqduLmao2JUa/fglx9djy2uo3kfE3Q8X
         aVP7PvTBbuXacomlKGJvsqUeiNTt9f4hmGWnNTNi7Qwul3CIxZWCnoBopP6XvkP+E9vs
         xVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ipJUUily8FthndGEpAjnRsp0x5TyWGuHke5fA/MgxUg=;
        b=xpVTH1cD+9YYso80QkdFD8ncQkMb8wKG1eg3F4U/y1U/skI5pqn2u7VJ7TDTRQwYta
         sLe4+f5bwBvTO7k2dGXhvH64VKq8/GO3xcMvbaIUQLeEBkdNDF7e+SGbn5d3E6SaIl+S
         y0li/j3gmkLw1K9JrDPqslOedBiF9IyzyxVFp5ykjSqGZdw+4OHzx95cbmZ9vJ6Lsnsf
         8a1W5W+Gk0CSldyR7ts6CMdJA1LmEGESsf48AWefnrxl5prc4s3c1FldVyYHDVlQbfll
         aoGhJ/bLX4b3PVzSYIJB2K1L1r2525jtFha0KhLERcrI65G7H0/9+4GGrRqYfhgs/iRG
         K1oA==
X-Gm-Message-State: AOAM532dlOOBvtgsIto6Fxs7FdjP0wQqZBTKtugsTfoI2IsxWv5IouLj
        vbYM4WQ0oAJLV3hFAsEUkkyRic2uXms=
X-Google-Smtp-Source: ABdhPJwIeVZZDFTE++N5QJej+api6f5kE+4BYz6f2Jf26uZi0aISJpa6swRij31hfDL2N+sE3F4zAg==
X-Received: by 2002:a05:600c:1c15:b0:37b:f7f2:ab68 with SMTP id j21-20020a05600c1c1500b0037bf7f2ab68mr12057338wms.100.1645719221939;
        Thu, 24 Feb 2022 08:13:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 50sm3149415wrc.113.2022.02.24.08.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:13:41 -0800 (PST)
Message-Id: <2d817a65db55750d27986c2e2ab5b1723d17081e.1645719218.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
        <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 16:13:32 +0000
Subject: [PATCH v2 2/8] fetch-pack: add repairing
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
        Robert Coup <robert@coup.net.nz>,
        Robert Coup <robert@coup.net.nz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Coup <robert@coup.net.nz>

Allow a 'repair fetch' where the contents of the local object store are
ignored and a full fetch is performed, not attempting to find or
negotiate common commits with the remote.

A key use case is to apply a new partial clone blob/tree filter and
refetch all the associated matching content, which would otherwise not
be transferred when the commit objects are already present locally.

Signed-off-by: Robert Coup <robert@coup.net.nz>
---
 fetch-pack.c | 50 +++++++++++++++++++++++++++++++-------------------
 fetch-pack.h |  1 +
 2 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 87657907e78..8103243947a 100644
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
+		if (!args->repair) {
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
@@ -694,6 +696,9 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 
 	save_commit_buffer = 0;
 
+	if (args->repair)
+		return;
+
 	trace2_region_enter("fetch-pack", "parse_remote_refs_and_find_cutoff", NULL);
 	for (ref = *refs; ref; ref = ref->next) {
 		struct commit *commit;
@@ -1027,9 +1032,6 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	struct fetch_negotiator negotiator_alloc;
 	struct fetch_negotiator *negotiator;
 
-	negotiator = &negotiator_alloc;
-	fetch_negotiator_init(r, negotiator);
-
 	sort_ref_list(&ref, ref_compare_name);
 	QSORT(sought, nr_sought, cmp_ref_by_name);
 
@@ -1119,9 +1121,16 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	if (!server_supports_hash(the_hash_algo->name, NULL))
 		die(_("Server does not support this repository's object format"));
 
+	negotiator = &negotiator_alloc;
+	if (args->repair) {
+		fetch_negotiator_init_noop(negotiator);
+	} else {
+		fetch_negotiator_init(r, negotiator);
+	}
+
 	mark_complete_and_common_ref(negotiator, args, &ref);
 	filter_refs(args, &ref, sought, nr_sought);
-	if (everything_local(args, &ref)) {
+	if (!args->repair && everything_local(args, &ref)) {
 		packet_flush(fd[1]);
 		goto all_done;
 	}
@@ -1587,7 +1596,10 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct strvec index_pack_args = STRVEC_INIT;
 
 	negotiator = &negotiator_alloc;
-	fetch_negotiator_init(r, negotiator);
+	if (args->repair)
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
+			if (!args->repair && everything_local(args, &ref))
 				state = FETCH_DONE;
 			else
 				state = FETCH_SEND_REQUEST;
diff --git a/fetch-pack.h b/fetch-pack.h
index 7f94a2a5831..bbb663edda8 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -42,6 +42,7 @@ struct fetch_pack_args {
 	unsigned update_shallow:1;
 	unsigned reject_shallow_remote:1;
 	unsigned deepen:1;
+	unsigned repair:1;
 
 	/*
 	 * Indicate that the remote of this request is a promisor remote. The
-- 
gitgitgadget

