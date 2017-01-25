Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A39D61F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 22:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752453AbdAYWDx (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 17:03:53 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34643 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752160AbdAYWD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 17:03:27 -0500
Received: by mail-pg0-f42.google.com with SMTP id 14so67625529pgg.1
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 14:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=BA3v0UYC0dqPCA0ZAVRujgwxbI0Izqu9MzqExjPTcXQ=;
        b=Tc8FUHB+kOT49RmvQiiaSdVdVu6z6+kKWBoG0mO9Gb616mnTe5pGWw5CPxBc/dpdvZ
         x7LIU8tyOJDJrh8XBqeTbJz1iG3lt3JpkePAvh6Zxnnqf+6OtQQSJkpNWtiDMOLqQVme
         M86T/NbAG9vPmI8g/d8emUvI5ebrLWoZ+0sG1aPy07hOgcxG+/5b1OXyx3W7aFB+Ze2r
         IGzWeVuMsyyxbBo9InwF/BIl52g8Y6ZJX3nIwccE4d3eXCw0BD8p9Wd2fM5j20Dxn9I9
         7sMCurI+3V29P69n0ajzRkxRsHvnFoOk+xxtdMI50FkaIJ0vbtIuBltUshTLsFxqITV8
         LNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=BA3v0UYC0dqPCA0ZAVRujgwxbI0Izqu9MzqExjPTcXQ=;
        b=cUiOD3fXTojIcOYOJUvOcM6oaornGcpFoDmhqPMrWzvIn1l0bo69je0MsAsIW7nmJa
         rBvArJiMXxWqCjNkTZP3Vgg8UXCnRywYWKb7sFEdJjzXKEnEj9hOr5BsxFvp7Ma4eVgs
         GplYAumsAB7Tl36dzfJj1rLk98RP/j+EpM0nxukEaAe6K/pwcPuiHxXQQ4IHxlbJnhh+
         Z7IUVdYvfrOwmXXo9uDEDvNpZyydOnK+I/6yrnLj5ovfFZdcSCX6vT16ZAyOiZ4waalf
         ApOJ/T1cjXGIW7t3sZyy94HWvo4DpEPCIjHJKkKmngKmCawkixbH1N2NtRr30nVwR7w0
         Enog==
X-Gm-Message-State: AIkVDXILdqiDTwqqqrGCYldzVBxIEggUgGihknvaFdoySh18qfrTYw+Fku9uag3zxoQE/R8d
X-Received: by 10.98.8.11 with SMTP id c11mr49175605pfd.135.1485381806472;
        Wed, 25 Jan 2017 14:03:26 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id o24sm3357308pfj.78.2017.01.25.14.03.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Jan 2017 14:03:25 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC 09/14] transport: put ref oid in out param
Date:   Wed, 25 Jan 2017 14:03:02 -0800
Message-Id: <27ff4202986d2bb88705f37cab33f171df1427a2.1485381677.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Return new OID information obtained through fetching in new structs
instead of reusing the existing ones. With this change, the input
structs are no longer used for output, and are thus marked const.

This is the 3rd of 3 patches to eliminate using input refs to
communicate information obtained by the fetch mechanism.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/clone.c      | 14 ++++++++++++--
 builtin/fetch-pack.c |  4 ++--
 fetch-pack.c         | 26 +++++++++++++++-----------
 fetch-pack.h         |  2 +-
 transport-helper.c   | 34 +++++++++++++++++++++++-----------
 transport.c          |  6 +++---
 transport.h          | 13 +++++--------
 7 files changed, 61 insertions(+), 38 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 0135c5f1c..3191da391 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -858,6 +858,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	struct refspec *refspec;
 	const char *fetch_pattern;
 
+	struct ref *new_remote_refs = NULL;
+
 	packet_trace_identity("clone");
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
 			     builtin_clone_usage, 0);
@@ -1075,8 +1077,15 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 				break;
 			}
 
-		if (!is_local && !complete_refs_before_fetch)
-			transport_fetch_refs(transport, mapped_refs, NULL);
+		if (!is_local && !complete_refs_before_fetch) {
+			transport_fetch_refs(transport, mapped_refs,
+					     &new_remote_refs);
+			if (new_remote_refs) {
+				refs = new_remote_refs;
+				free_refs(mapped_refs);
+				mapped_refs = wanted_peer_refs(refs, refspec);
+			}
+		}
 
 		remote_head = find_ref_by_name(refs, "HEAD");
 		remote_head_points_at =
@@ -1148,5 +1157,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	junk_mode = JUNK_LEAVE_ALL;
 
 	free(refspec);
+	free_refs(new_remote_refs);
 	return err;
 }
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index f31f874a0..a18fd0c44 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -11,7 +11,7 @@ static const char fetch_pack_usage[] =
 "[--include-tag] [--upload-pack=<git-upload-pack>] [--depth=<n>] "
 "[--no-progress] [--diag-url] [-v] [<host>:]<directory> [<refs>...]";
 
-static void add_sought_entry(struct ref ***sought, int *nr, int *alloc,
+static void add_sought_entry(const struct ref ***sought, int *nr, int *alloc,
 			     const char *name)
 {
 	struct ref *ref;
@@ -44,7 +44,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	int i, ret;
 	struct ref *ref = NULL;
 	const char *dest = NULL;
-	struct ref **sought = NULL;
+	const struct ref **sought = NULL;
 	int nr_sought = 0, alloc_sought = 0;
 	int fd[2];
 	char *pack_lockfile = NULL;
diff --git a/fetch-pack.c b/fetch-pack.c
index d4642b05c..8cc85c19f 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -52,6 +52,10 @@ static int non_common_revs, multi_ack, use_sideband;
 #define ALLOW_REACHABLE_SHA1	02
 static unsigned int allow_unadvertised_object_request;
 
+/* An arbitrary non-NULL non-const pointer to assign to the util field of
+ * string list items when we need one. */
+#define ARBITRARY (&transfer_unpack_limit)
+
 __attribute__((format (printf, 2, 3)))
 static inline void print_verbose(const struct fetch_pack_args *args,
 				 const char *fmt, ...)
@@ -556,7 +560,7 @@ static void mark_recent_complete_commits(struct fetch_pack_args *args,
 
 static void filter_refs(struct fetch_pack_args *args,
 			struct ref **refs,
-			struct ref **sought, int nr_sought)
+			const struct ref **sought, int nr_sought)
 {
 	struct ref *newlist = NULL;
 	struct ref **newtail = &newlist;
@@ -604,16 +608,16 @@ static void filter_refs(struct fetch_pack_args *args,
 		for (i = 0; i < nr_sought; i++) {
 			unsigned char sha1[20];
 
-			ref = sought[i];
+			const struct ref *sref = sought[i];
 			if (matched[i])
 				continue;
-			if (get_sha1_hex(ref->name, sha1) ||
-			    ref->name[40] != '\0' ||
-			    hashcmp(sha1, ref->old_oid.hash))
+			if (get_sha1_hex(sref->name, sha1) ||
+			    sref->name[40] != '\0' ||
+			    hashcmp(sha1, sref->old_oid.hash))
 				continue;
 
 			matched[i] = 1;
-			*newtail = copy_ref(ref);
+			*newtail = copy_ref(sref);
 			newtail = &(*newtail)->next;
 		}
 	}
@@ -629,7 +633,7 @@ static void mark_alternate_complete(const struct ref *ref, void *unused)
 
 static int everything_local(struct fetch_pack_args *args,
 			    struct ref **refs,
-			    struct ref **sought, int nr_sought)
+			    const struct ref **sought, int nr_sought)
 {
 	struct ref *ref;
 	int retval;
@@ -831,7 +835,7 @@ static int cmp_ref_by_name(const void *a_, const void *b_)
 static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 				 int fd[2],
 				 const struct ref *orig_ref,
-				 struct ref **sought, int nr_sought,
+				 const struct ref **sought, int nr_sought,
 				 struct shallow_info *si,
 				 char **pack_lockfile)
 {
@@ -955,7 +959,7 @@ static void fetch_pack_setup(void)
 	did_setup = 1;
 }
 
-static int remove_duplicates_in_refs(struct ref **ref, int nr)
+static int remove_duplicates_in_refs(const struct ref **ref, int nr)
 {
 	struct string_list names = STRING_LIST_INIT_NODUP;
 	int src, dst;
@@ -965,7 +969,7 @@ static int remove_duplicates_in_refs(struct ref **ref, int nr)
 		item = string_list_insert(&names, ref[src]->name);
 		if (item->util)
 			continue; /* already have it */
-		item->util = ref[src];
+		item->util = ARBITRARY;
 		if (src != dst)
 			ref[dst] = ref[src];
 		dst++;
@@ -1078,7 +1082,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		       int fd[], struct child_process *conn,
 		       const struct ref *ref,
 		       const char *dest,
-		       struct ref **sought, int nr_sought,
+		       const struct ref **sought, int nr_sought,
 		       struct sha1_array *shallow,
 		       char **pack_lockfile)
 {
diff --git a/fetch-pack.h b/fetch-pack.h
index 76f7c719c..6e4fdbb68 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -38,7 +38,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		       int fd[], struct child_process *conn,
 		       const struct ref *ref,
 		       const char *dest,
-		       struct ref **sought,
+		       const struct ref **sought,
 		       int nr_sought,
 		       struct sha1_array *shallow,
 		       char **pack_lockfile);
diff --git a/transport-helper.c b/transport-helper.c
index f3d78bb9e..be0aa6d39 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -384,7 +384,7 @@ static int release_helper(struct transport *transport)
 }
 
 static int fetch_with_fetch(struct transport *transport,
-			    int nr_heads, struct ref **to_fetch)
+			    int nr_heads, const struct ref **to_fetch)
 {
 	struct helper_data *data = transport->data;
 	int i;
@@ -477,13 +477,14 @@ static int get_exporter(struct transport *transport,
 }
 
 static int fetch_with_import(struct transport *transport,
-			     int nr_heads, struct ref **to_fetch)
+			     int nr_heads, const struct ref **to_fetch, struct ref **fetched_refs)
 {
 	struct child_process fastimport;
 	struct helper_data *data = transport->data;
 	int i;
-	struct ref *posn;
+	const struct ref *posn;
 	struct strbuf buf = STRBUF_INIT;
+	struct ref *fr_head = NULL, **fr_tail = &fr_head;
 
 	get_helper(transport);
 
@@ -522,28 +523,38 @@ static int fetch_with_import(struct transport *transport,
 	 * (If no "refspec" capability was specified, for historical
 	 * reasons we default to the equivalent of *:*.)
 	 *
-	 * Store the result in to_fetch[i].old_sha1.  Callers such
+	 * Store the result in old_oid in fetched_refs.  Callers such
 	 * as "git fetch" can use the value to write feedback to the
 	 * terminal, populate FETCH_HEAD, and determine what new value
 	 * should be written to peer_ref if the update is a
 	 * fast-forward or this is a forced update.
 	 */
+	if (!fetched_refs)
+		goto cleanup;
 	for (i = 0; i < nr_heads; i++) {
-		char *private, *name;
-		posn = to_fetch[i];
-		if (posn->status & REF_STATUS_UPTODATE)
+		struct ref *ref;
+		char *private;
+		const char *name;
+
+		ref = copy_ref_peerless(to_fetch[i]);
+		*fr_tail = ref;
+		fr_tail = &ref->next;
+		if (ref->status & REF_STATUS_UPTODATE)
 			continue;
-		name = posn->symref ? posn->symref : posn->name;
+		name = ref->symref ? ref->symref : ref->name;
 		if (data->refspecs)
 			private = apply_refspecs(data->refspecs, data->refspec_nr, name);
 		else
 			private = xstrdup(name);
 		if (private) {
-			if (read_ref(private, posn->old_oid.hash) < 0)
+			if (read_ref(private, ref->old_oid.hash) < 0)
 				die("Could not read ref %s", private);
 			free(private);
 		}
 	}
+	*fetched_refs = fr_head;
+
+cleanup:
 	strbuf_release(&buf);
 	return 0;
 }
@@ -646,7 +657,8 @@ static int connect_helper(struct transport *transport, const char *name,
 }
 
 static int fetch(struct transport *transport,
-		 int nr_heads, struct ref **to_fetch, struct ref **fetched_refs)
+		 int nr_heads, const struct ref **to_fetch,
+		 struct ref **fetched_refs)
 {
 	struct helper_data *data = transport->data;
 	int i, count;
@@ -679,7 +691,7 @@ static int fetch(struct transport *transport,
 		return fetch_with_fetch(transport, nr_heads, to_fetch);
 
 	if (data->import)
-		return fetch_with_import(transport, nr_heads, to_fetch);
+		return fetch_with_import(transport, nr_heads, to_fetch, fetched_refs);
 
 	return -1;
 }
diff --git a/transport.c b/transport.c
index 80e007f2f..5ed3fc68e 100644
--- a/transport.c
+++ b/transport.c
@@ -95,7 +95,7 @@ static struct ref *get_refs_from_bundle(struct transport *transport, int for_pus
 }
 
 static int fetch_refs_from_bundle(struct transport *transport,
-			       int nr_heads, struct ref **to_fetch,
+			       int nr_heads, const struct ref **to_fetch,
 			       struct ref **fetched_refs)
 {
 	struct bundle_transport_data *data = transport->data;
@@ -203,7 +203,7 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 }
 
 static int fetch_refs_via_pack(struct transport *transport,
-			       int nr_heads, struct ref **to_fetch,
+			       int nr_heads, const struct ref **to_fetch,
 			       struct ref **fetched_refs)
 {
 	struct git_transport_data *data = transport->data;
@@ -1101,7 +1101,7 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs,
 {
 	int rc;
 	int nr_heads = 0, nr_alloc = 0, nr_refs = 0;
-	struct ref **heads = NULL;
+	const struct ref **heads = NULL;
 	struct ref *nop_head = NULL, **nop_tail = &nop_head;
 	struct ref *rm;
 
diff --git a/transport.h b/transport.h
index b9e7e4656..326ff9bd6 100644
--- a/transport.h
+++ b/transport.h
@@ -84,15 +84,12 @@ struct transport {
 	 *
 	 * The transport *may* provide, in fetched_refs, the list of refs that
 	 * it fetched. If the transport knows anything about the fetched refs
-	 * that the caller does not know (for example, shallow status), it
-	 * should provide that list of refs and include that information in the
-	 * list.
-	 *
-	 * If the transport did not get hashes for refs in
-	 * get_refs_list(), it should set the old_sha1 fields in the
-	 * provided refs now.
+	 * that the caller does not know (for example, shallow status or ref
+	 * hashes), it should provide that list of refs and include that
+	 * information in the list.
 	 **/
-	int (*fetch)(struct transport *transport, int refs_nr, struct ref **refs,
+	int (*fetch)(struct transport *transport,
+		     int refs_nr, const struct ref **refs,
 		     struct ref **fetched_refs);
 
 	/**
-- 
2.11.0.483.g087da7b7c-goog

