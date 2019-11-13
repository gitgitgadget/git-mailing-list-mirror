Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8F581F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 00:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKMAec (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 19:34:32 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:41675 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfKMAeb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 19:34:31 -0500
Received: by mail-pl1-f202.google.com with SMTP id b3so225660plz.8
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 16:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5rf5E2DnPHhZa5mjjbksJwDEfHPiRx7BYttEV69jymc=;
        b=DsTEAyOtg9rhHVdRsUM0NqqQlktNH0Ixyw+0tT4vw57RfP8rVWkhQxc1GKrkxnKYtz
         B16/guB8vMsSyOWSWS4WDZqg9zsQ6Tx7nA9bF9zDZl8bgk05tVNoUcUvUEQ0eRPdtS2p
         i1kB7o+CrcB9yiW2TYfyNqiOUz2HSS3ZvDvmhdifWgbxks1K1WwoE6Gn/SjMkethL7Ry
         GotHJWQ7m6YLlsEspGh7E7xSWjkzhRK73T9Kd9lJY1seWJR4iO5kS/Zy6IC0mlaNwcP1
         q7SVYuFjOSK78fJPKar2Cq+MJyDES+sYbN8mFRXkD2mwFTZe0KxpQ+JnhC4D89ayUAbn
         eIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5rf5E2DnPHhZa5mjjbksJwDEfHPiRx7BYttEV69jymc=;
        b=KCMQyw7L3Nb0rW+ouaDjOuz0VtvRZX9hUmXOQiBtPP2wfOIcjbBsRRP9oWXy6Y7Yxd
         giancm+mrGnFwF4M6+42bfpoPoGzpHRv8skmeUdo63uprilHc2EsQas3izH2Ihzg3EQc
         lFewDVzETiRqdqfIl0hDOt2TQyW+KVjZcicAdBEqVdKfMYJWGlpLC5bytVvTTS/uFuQ9
         uv22UfNxqEd4o7hPB4hsMwkyvPgSqR4YRFdH4UaTcXcKmTTRifrm88lRiV3t0kJu6mIS
         ot/LZ+HTAg20628jyuIh779ro5nZFKEehyFcojN5zJg2OQttJss/fT9SiZ745FfhwRqH
         kTwQ==
X-Gm-Message-State: APjAAAVNFeUAkob//ezlj0QHOFsSKJ1bdqEXCIPgLD0Eh97AA0UnRmXZ
        M6jn7e/Gf1P1d0Rj/wBXMRFFO6KC0w215YDq9CNvais1ylmiOiia1lM28DbUEPmtc4k+TQcrt8N
        DpMhvEWX9LNTn9vzy8zznVH0dawJ/txOsfnGJ8Yv1B5egBL5+znxa7O+1iot19RW7JFXgD9Lqed
        76
X-Google-Smtp-Source: APXvYqyfmMDWR2c6D93coA3O9V1sa6DtPpsWh7f8kghK+MlfxTLqDVgiRnj+z/IlXsNhWKcpeUGoznCv6YTobUzWv9B2
X-Received: by 2002:a63:cb50:: with SMTP id m16mr345238pgi.425.1573605268698;
 Tue, 12 Nov 2019 16:34:28 -0800 (PST)
Date:   Tue, 12 Nov 2019 16:34:20 -0800
In-Reply-To: <cover.1573604516.git.jonathantanmy@google.com>
Message-Id: <82daff8665c0a9b5df1dacbc2cff16d98dcc8175.1573604516.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1573604516.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH 2/2] promisor-remote: remove fetch_if_missing=0
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 6462d5eb9a ("fetch: remove fetch_if_missing=0", 2019-11-08)
strove to remove the need for fetch_if_missing=0 from the fetching
mechanism, so it is plausible to attempt removing fetch_if_missing=0
from the lazy-fetching mechanism in promisor-remote as well.

But doing so reveals a bug - when the server does not send an object
pointed to by a tag object, an infinite loop occurs: Git attempts to
fetch the missing object, which causes a deferencing of all refs (for
negotiation), which causes a lazy fetch of that missing object, and so
on. This bug is because of unnecessary use of the fetch negotiator
during lazy fetching - it is not used after initialization, but it is
still initialized (which causes the dereferencing of all refs).

Thus, when the negotiator is not used during fetching, refrain from
initializing it. Then, remove fetch_if_missing from promisor-remote.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c      | 46 ++++++++++++++++++++++++++++++++--------------
 promisor-remote.c |  3 ---
 2 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 37178e2d34..490b111822 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -896,8 +896,15 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	struct object_id oid;
 	const char *agent_feature;
 	int agent_len;
-	struct fetch_negotiator negotiator;
-	fetch_negotiator_init(r, &negotiator);
+	struct fetch_negotiator negotiator_alloc;
+	struct fetch_negotiator *negotiator;
+
+	if (args->no_dependents) {
+		negotiator = NULL;
+	} else {
+		negotiator = &negotiator_alloc;
+		fetch_negotiator_init(r, negotiator);
+	}
 
 	sort_ref_list(&ref, ref_compare_name);
 	QSORT(sought, nr_sought, cmp_ref_by_name);
@@ -984,7 +991,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		die(_("Server does not support --deepen"));
 
 	if (!args->no_dependents) {
-		mark_complete_and_common_ref(&negotiator, args, &ref);
+		mark_complete_and_common_ref(negotiator, args, &ref);
 		filter_refs(args, &ref, sought, nr_sought);
 		if (everything_local(args, &ref)) {
 			packet_flush(fd[1]);
@@ -993,7 +1000,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	} else {
 		filter_refs(args, &ref, sought, nr_sought);
 	}
-	if (find_common(&negotiator, args, fd, &oid, ref) < 0)
+	if (find_common(negotiator, args, fd, &oid, ref) < 0)
 		if (!args->keep_pack)
 			/* When cloning, it is not unusual to have
 			 * no common commit.
@@ -1013,7 +1020,8 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		die(_("git fetch-pack: fetch failed."));
 
  all_done:
-	negotiator.release(&negotiator);
+	if (negotiator)
+		negotiator->release(negotiator);
 	return ref;
 }
 
@@ -1231,7 +1239,8 @@ static int process_acks(struct fetch_negotiator *negotiator,
 				struct commit *commit;
 				oidset_insert(common, &oid);
 				commit = lookup_commit(the_repository, &oid);
-				negotiator->ack(negotiator, commit);
+				if (negotiator)
+					negotiator->ack(negotiator, commit);
 			}
 			continue;
 		}
@@ -1383,8 +1392,16 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct packet_reader reader;
 	int in_vain = 0, negotiation_started = 0;
 	int haves_to_send = INITIAL_FLUSH;
-	struct fetch_negotiator negotiator;
-	fetch_negotiator_init(r, &negotiator);
+	struct fetch_negotiator negotiator_alloc;
+	struct fetch_negotiator *negotiator;
+
+	if (args->no_dependents) {
+		negotiator = NULL;
+	} else {
+		negotiator = &negotiator_alloc;
+		fetch_negotiator_init(r, negotiator);
+	}
+
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_DIE_ON_ERR_PACKET);
@@ -1408,15 +1425,15 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 
 			/* Filter 'ref' by 'sought' and those that aren't local */
 			if (!args->no_dependents) {
-				mark_complete_and_common_ref(&negotiator, args, &ref);
+				mark_complete_and_common_ref(negotiator, args, &ref);
 				filter_refs(args, &ref, sought, nr_sought);
 				if (everything_local(args, &ref))
 					state = FETCH_DONE;
 				else
 					state = FETCH_SEND_REQUEST;
 
-				mark_tips(&negotiator, args->negotiation_tips);
-				for_each_cached_alternate(&negotiator,
+				mark_tips(negotiator, args->negotiation_tips);
+				for_each_cached_alternate(negotiator,
 							  insert_one_alternate_object);
 			} else {
 				filter_refs(args, &ref, sought, nr_sought);
@@ -1430,7 +1447,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 						    "negotiation_v2",
 						    the_repository);
 			}
-			if (send_fetch_request(&negotiator, fd[1], args, ref,
+			if (send_fetch_request(negotiator, fd[1], args, ref,
 					       &common,
 					       &haves_to_send, &in_vain,
 					       reader.use_sideband))
@@ -1440,7 +1457,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			break;
 		case FETCH_PROCESS_ACKS:
 			/* Process ACKs/NAKs */
-			switch (process_acks(&negotiator, &reader, &common)) {
+			switch (process_acks(negotiator, &reader, &common)) {
 			case 2:
 				state = FETCH_GET_PACK;
 				break;
@@ -1475,7 +1492,8 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		}
 	}
 
-	negotiator.release(&negotiator);
+	if (negotiator)
+		negotiator->release(negotiator);
 	oidset_clear(&common);
 	return ref;
 }
diff --git a/promisor-remote.c b/promisor-remote.c
index 9bd5b79d59..9f338c945f 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -16,10 +16,8 @@ static int fetch_refs(const char *remote_name, struct ref *ref)
 {
 	struct remote *remote;
 	struct transport *transport;
-	int original_fetch_if_missing = fetch_if_missing;
 	int res;
 
-	fetch_if_missing = 0;
 	remote = remote_get(remote_name);
 	if (!remote->url[0])
 		die(_("Remote with no URL"));
@@ -28,7 +26,6 @@ static int fetch_refs(const char *remote_name, struct ref *ref)
 	transport_set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
 	transport_set_option(transport, TRANS_OPT_NO_DEPENDENTS, "1");
 	res = transport_fetch_refs(transport, ref);
-	fetch_if_missing = original_fetch_if_missing;
 
 	return res;
 }
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

