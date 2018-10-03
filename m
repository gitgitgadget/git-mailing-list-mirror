Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 204B61F453
	for <e@80x24.org>; Wed,  3 Oct 2018 23:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbeJDFz2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 01:55:28 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:57249 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeJDFz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 01:55:28 -0400
Received: by mail-qk1-f201.google.com with SMTP id l75-v6so6540253qke.23
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 16:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UVopHplhmY4vMrEIQnBCjAZhsOOjrVcIpd0+XwBFdqk=;
        b=uKwgYCjXFhd+nledZZJstuYGlFF3DSmidCrII89Ej3eVjfm5MwZhuKOruGly8BDBzy
         8CkGUwDlYza5CnM+B6jzhzkPFbhQBFhvkjKw1+UFAR/XLvh5tX3Jv88aVdqUEZmsyrAX
         kkzL/VGYuzX4naYNh+tH3EIebZkS8tlyv081ymo8LFf2zwnHGpxOobEW+h8K51NSHgmU
         vE129Zx7QmiZlu9fDtZmx9diqW3XGPKVl0eFaRao8l2K131hMEW4JYi69WMhb7wF7/R0
         R/24alhSzdhx/8zwu1HmaS01eM8wyfAV/slNQ9PB6YzNaJutB4UDr7VdJtF3Xq+Nmuot
         zC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UVopHplhmY4vMrEIQnBCjAZhsOOjrVcIpd0+XwBFdqk=;
        b=E+Kk3Rjf+kHNAilg6AHFQ7s5AWzqawjOWWRTVTmLV932tmn4R0IpxMwThSfo1OVMWk
         WfNunrSApfK+II1jWDEYWj/AtLmVlkhpVjHyBw2iQYnMbTspkHiLx0Ti3mj3TBIxYjQr
         UkcG+LhxBVuR6VMqlQ1JFDHP4XHqkWvwct5pE0j+TkmU38slxVRts3Tb+8wkBFOiqxza
         xpfxtaysmdB3lf+BK80lHO3NYg9XS3IhQiG40EfqUYlihK3L6Nwd0oomqp7uXr/9xdUP
         cqM9yFMKDZh8IYwCXN7GXYyPnWhHo0pExSO3OLfrnl2FmrqSRr21BRgM9eXM57zn9Yq2
         U//w==
X-Gm-Message-State: ABuFfojIYoKv7aJ75iUje5VT4273sz70jo3cpzxUXE2mNLCaTHVjW9Xf
        Bj7xo3whqR4BTws1VVf0GYF1YN4yiXugdYUEVSC5jOGcFH/tdZ4iGGFousCwDW14VtRFIgf9T8V
        CRxX84w/sMOHjKDbmyGyzoZ9fM2+UWV8PvBTZgrmZQOTkSGY0oV7NzxU2GVjVWXzR24+9vzZir4
        4B
X-Google-Smtp-Source: ACcGV62bujl6fSPA00ezInV1dm0TqA344+wam8LOpgop5fsHPLjx/Isrlfsx7ee9KBKRpbz+2yNSYSbvi5Gz8wHrvnS9
X-Received: by 2002:a0c:89c5:: with SMTP id 5-v6mr2841101qvs.56.1538607900617;
 Wed, 03 Oct 2018 16:05:00 -0700 (PDT)
Date:   Wed,  3 Oct 2018 16:04:52 -0700
In-Reply-To: <cover.1538607476.git.jonathantanmy@google.com>
Message-Id: <ac263ac3bec1aaf482248730afa126a8667fa8d5.1538607476.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20180924154516.48704-1-jonathantanmy@google.com> <cover.1538607476.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v2 1/2] fetch-pack: avoid object flags if no_dependents
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When fetch_pack() is invoked as part of another Git command (due to a
lazy fetch from a partial clone, for example), it uses object flags that
may already be used by the outer Git command.

The commit that introduced the lazy fetch feature (88e2f9ed8e
("introduce fetch-object: fetch one promisor object", 2017-12-05)) tried
to avoid this overlap, but it did not avoid it totally. It was
successful in avoiding writing COMPLETE, but did not avoid reading
COMPLETE, and did not avoid writing and reading ALTERNATE.

Ensure that no flags are written or read by fetch_pack() in the case
where it is used to perform a lazy fetch. To do this, it is sufficient
to avoid checking completeness of wanted refs (unnecessary in the case
of lazy fetches), and to avoid negotiation-related work (in the current
implementation, already, no negotiation is performed). After that was
done, the lack of overlap was verified by checking all direct and
indirect usages of COMPLETE and ALTERNATE - that they are read or
written only if no_dependents is false.

There are other possible solutions to this issue:

 (1) Split fetch-pack.{c,h} into a flag-using part and a non-flag-using
     part, and whenever no_dependents is set, only use the
     non-flag-using part.
 (2) Make fetch_pack() be able to be used with arbitrary repository
     objects. fetch_pack() should then create its own repository object
     based on the given repository object, with its own object
     hashtable, so that the flags do not conflict.

(1) is possible but invasive - some functions would need to be split;
and such invasiveness would potentially be unnecessary if we ever were
to need (2) anyway. (2) would be useful if we were to support, say,
submodules that were partial clones themselves, but I don't know when or
if the Git project plans to support those.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 101 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 59 insertions(+), 42 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 75047a4b2a..b9b1211dda 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -253,8 +253,10 @@ static int find_common(struct fetch_negotiator *negotiator,
 	if (args->stateless_rpc && multi_ack == 1)
 		die(_("--stateless-rpc requires multi_ack_detailed"));
 
-	mark_tips(negotiator, args->negotiation_tips);
-	for_each_cached_alternate(negotiator, insert_one_alternate_object);
+	if (!args->no_dependents) {
+		mark_tips(negotiator, args->negotiation_tips);
+		for_each_cached_alternate(negotiator, insert_one_alternate_object);
+	}
 
 	fetching = 0;
 	for ( ; refs ; refs = refs->next) {
@@ -271,8 +273,12 @@ static int find_common(struct fetch_negotiator *negotiator,
 		 * We use lookup_object here because we are only
 		 * interested in the case we *know* the object is
 		 * reachable and we have already scanned it.
+		 *
+		 * Do this only if args->no_dependents is false (if it is true,
+		 * we cannot trust the object flags).
 		 */
-		if (((o = lookup_object(the_repository, remote->hash)) != NULL) &&
+		if (!args->no_dependents &&
+		    ((o = lookup_object(the_repository, remote->hash)) != NULL) &&
 				(o->flags & COMPLETE)) {
 			continue;
 		}
@@ -710,31 +716,29 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 
 	oidset_clear(&loose_oid_set);
 
-	if (!args->no_dependents) {
-		if (!args->deepen) {
-			for_each_ref(mark_complete_oid, NULL);
-			for_each_cached_alternate(NULL, mark_alternate_complete);
-			commit_list_sort_by_date(&complete);
-			if (cutoff)
-				mark_recent_complete_commits(args, cutoff);
-		}
+	if (!args->deepen) {
+		for_each_ref(mark_complete_oid, NULL);
+		for_each_cached_alternate(NULL, mark_alternate_complete);
+		commit_list_sort_by_date(&complete);
+		if (cutoff)
+			mark_recent_complete_commits(args, cutoff);
+	}
 
-		/*
-		 * Mark all complete remote refs as common refs.
-		 * Don't mark them common yet; the server has to be told so first.
-		 */
-		for (ref = *refs; ref; ref = ref->next) {
-			struct object *o = deref_tag(the_repository,
-						     lookup_object(the_repository,
-						     ref->old_oid.hash),
-						     NULL, 0);
+	/*
+	 * Mark all complete remote refs as common refs.
+	 * Don't mark them common yet; the server has to be told so first.
+	 */
+	for (ref = *refs; ref; ref = ref->next) {
+		struct object *o = deref_tag(the_repository,
+					     lookup_object(the_repository,
+					     ref->old_oid.hash),
+					     NULL, 0);
 
-			if (!o || o->type != OBJ_COMMIT || !(o->flags & COMPLETE))
-				continue;
+		if (!o || o->type != OBJ_COMMIT || !(o->flags & COMPLETE))
+			continue;
 
-			negotiator->known_common(negotiator,
-						 (struct commit *)o);
-		}
+		negotiator->known_common(negotiator,
+					 (struct commit *)o);
 	}
 
 	save_commit_buffer = old_save_commit_buffer;
@@ -990,11 +994,15 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	if (!server_supports("deepen-relative") && args->deepen_relative)
 		die(_("Server does not support --deepen"));
 
-	mark_complete_and_common_ref(&negotiator, args, &ref);
-	filter_refs(args, &ref, sought, nr_sought);
-	if (everything_local(args, &ref)) {
-		packet_flush(fd[1]);
-		goto all_done;
+	if (!args->no_dependents) {
+		mark_complete_and_common_ref(&negotiator, args, &ref);
+		filter_refs(args, &ref, sought, nr_sought);
+		if (everything_local(args, &ref)) {
+			packet_flush(fd[1]);
+			goto all_done;
+		}
+	} else {
+		filter_refs(args, &ref, sought, nr_sought);
 	}
 	if (find_common(&negotiator, args, fd, &oid, ref) < 0)
 		if (!args->keep_pack)
@@ -1040,7 +1048,7 @@ static void add_shallow_requests(struct strbuf *req_buf,
 	}
 }
 
-static void add_wants(const struct ref *wants, struct strbuf *req_buf)
+static void add_wants(int no_dependents, const struct ref *wants, struct strbuf *req_buf)
 {
 	int use_ref_in_want = server_supports_feature("fetch", "ref-in-want", 0);
 
@@ -1057,8 +1065,12 @@ static void add_wants(const struct ref *wants, struct strbuf *req_buf)
 		 * We use lookup_object here because we are only
 		 * interested in the case we *know* the object is
 		 * reachable and we have already scanned it.
+		 *
+		 * Do this only if args->no_dependents is false (if it is true,
+		 * we cannot trust the object flags).
 		 */
-		if (((o = lookup_object(the_repository, remote->hash)) != NULL) &&
+		if (!no_dependents &&
+		    ((o = lookup_object(the_repository, remote->hash)) != NULL) &&
 		    (o->flags & COMPLETE)) {
 			continue;
 		}
@@ -1155,7 +1167,7 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 	}
 
 	/* add wants */
-	add_wants(wants, &req_buf);
+	add_wants(args->no_dependents, wants, &req_buf);
 
 	if (args->no_dependents) {
 		packet_buf_write(&req_buf, "done");
@@ -1346,16 +1358,21 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				args->deepen = 1;
 
 			/* Filter 'ref' by 'sought' and those that aren't local */
-			mark_complete_and_common_ref(&negotiator, args, &ref);
-			filter_refs(args, &ref, sought, nr_sought);
-			if (everything_local(args, &ref))
-				state = FETCH_DONE;
-			else
+			if (!args->no_dependents) {
+				mark_complete_and_common_ref(&negotiator, args, &ref);
+				filter_refs(args, &ref, sought, nr_sought);
+				if (everything_local(args, &ref))
+					state = FETCH_DONE;
+				else
+					state = FETCH_SEND_REQUEST;
+
+				mark_tips(&negotiator, args->negotiation_tips);
+				for_each_cached_alternate(&negotiator,
+							  insert_one_alternate_object);
+			} else {
+				filter_refs(args, &ref, sought, nr_sought);
 				state = FETCH_SEND_REQUEST;
-
-			mark_tips(&negotiator, args->negotiation_tips);
-			for_each_cached_alternate(&negotiator,
-						  insert_one_alternate_object);
+			}
 			break;
 		case FETCH_SEND_REQUEST:
 			if (send_fetch_request(&negotiator, fd[1], args, ref,
-- 
2.19.0.605.g01d371f741-goog

