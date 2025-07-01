Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7EE27467D
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 12:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372573; cv=none; b=rFYMbH5mXIeuxwhMPPJhAk8HtOcM10ioNSR2OpHk9juZbUgWHRoFrJHhh8BxFVK+DXCNATfkNM7hZ43Rs0q8E9okF449Q6GS3FXao7z7Gt0XNZvlJuIxnWxpQxreBur8UF6EohsPzOKZEEQ6HWPCw07oLF6ADU00VqLNiiEhA1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372573; c=relaxed/simple;
	bh=mPKRFlfhYlvGCrIxT+i960tLfp9vH6WC7C30oZkGWto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UtCH3fO8KUrwYYKZWMYyK6urVk4rpUN+/BjwC1AnOPTo9jrRcU91YrExQMFLzApl9DjCpKEryUjUUWn7TzDA2OjvQVu82Qa9AmsiVrO6r1nQSS6yLesVzJvXLgn3UaZabsjcmWwCzSgPOSzsX3owr15G0XWpj3tFZdilkbGdd2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dVIcCmJ9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V2ilCi4y; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dVIcCmJ9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V2ilCi4y"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 96BA8EC04DA;
	Tue,  1 Jul 2025 08:22:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 01 Jul 2025 08:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751372571;
	 x=1751458971; bh=MNjRYsFEyxwqLcs/zFi0uJ2nl0vMMGw7nBDIU3b6f5E=; b=
	dVIcCmJ9NKHlx+LblMvHqFv8vFBx2GJ++mNT7/7s+e/rK4OzDqPwWVEwNIa0pHL3
	Is+8KlXmHQd9YgsE+d9kuS8LiQOAY8w3ntXemILlLWccx1H9xcVjqM1Udxb/iL+M
	wcjVYeuDOvQ0NpE2VHGf5/iFM32m00fTtoe+GNSs2iHvLmt73EpavjYF60aKzZ0f
	laOeBamkc6RFsdX8v8LcY3GiHGZIE5pjq1GP2NrHSFwFWcrw8hHlCYxFFE9Kj7eV
	bl539+3nsAEFHCre7Ic9LvMmldjmodrd6FrheRhDAPmcGNAmCVOI9cLhFL/Z+Lzl
	WVMYBTCQHVLYTqLZfMtAZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751372571; x=
	1751458971; bh=MNjRYsFEyxwqLcs/zFi0uJ2nl0vMMGw7nBDIU3b6f5E=; b=V
	2ilCi4yGgQ86MNFLNehM+WtXkm1hbXBKOij7B6jjDHYNFuqF/pPzUaqqpT2aogMT
	N2jn2oiOp6zpnXQHG5Dq1S3ptYG3KIQ5qtE8/qI7c/0eWxvdcIMil4Fy09QmHhCP
	emZAi5yQtCViXExFIrQPyCujg5uj1M3rL54bUrI9DQ65nY2Z2xmhTHdgXyNPNv1d
	ZCgbPZb1M113iL47e6YSAs1NPyFKlFriAVZbkHbwX8wu0N7QqIhc+xtFD0bzZq6r
	NRSxZvoKRr/5SPtssUKuGDrPs8w79QjEjH6np74FxK9Q5TK+wL7JEjQ4/mquMBUT
	SjFy3+vEIhj3jESKeomKQ==
X-ME-Sender: <xms:G9NjaL7RWWzVli8zUJQH1KuKvU3dWw6cMjeLIk8MK7I04LmBL-lkJA>
    <xme:G9NjaA4ezTtR9LlPRK3tGPCbeMPMMwfQEFZEa26_esm1ck6LYr4CnxFo8b8GfqNXk
    NPKbX9LoTMICQ4FqA>
X-ME-Received: <xmr:G9NjaCe4no8GAUA6biU3DiZwgstD8XoVaDhIwDJllDFiHFO-HVXGFtq1fokDfgzvPcubOGK4x7pFpTKHFP6NXWwJTeE1KdasSRCHYQSPRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhtoh
    hlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:G9NjaMLe3ppVK_2QnKuzXovobh-x-f3lY0x3qDQqdrDReNOVqjZAVg>
    <xmx:G9NjaPLoIgBHQU2WxPKIYn744hR0O8opobaYnbJ6lc5MvnpOid-Xeg>
    <xmx:G9NjaFw3JYg0IVd_H0MN5cGe0dAsYK_jNLaW_8APMuJQXY83-2-8ig>
    <xmx:G9NjaLLLAqsBIVsxgYudhpqBREuHHFLER6gyJAPcVETlTyDAziNajw>
    <xmx:G9NjaCxCAdWtUBLxGMjiePZKFJRoEL992Hqp7BvYz_qzlQHYCXEsuAFO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 08:22:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8d364abd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 1 Jul 2025 12:22:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 01 Jul 2025 14:22:21 +0200
Subject: [PATCH v6 09/17] odb: get rid of `the_repository` in `for_each()`
 functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-pks-object-store-wo-the-repository-v6-9-dbf3894ab4e2@pks.im>
References: <20250701-pks-object-store-wo-the-repository-v6-0-dbf3894ab4e2@pks.im>
In-Reply-To: <20250701-pks-object-store-wo-the-repository-v6-0-dbf3894ab4e2@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

There are a couple of iterator-style functions that execute a callback
for each instance of a given set, all of which currently depend on
`the_repository`. Refactor them to instead take an object database as
parameter so that we can get rid of this dependency.

Rename the functions accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/count-objects.c     |  2 +-
 builtin/receive-pack.c      |  3 ++-
 builtin/submodule--helper.c |  3 ++-
 diagnose.c                  |  2 +-
 fetch-pack.c                |  3 ++-
 odb.c                       | 36 +++++++++++++++++++-----------------
 odb.h                       | 23 ++++++++++++++++++-----
 revision.c                  |  3 ++-
 8 files changed, 47 insertions(+), 28 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 58e0af433d1..f687647931e 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -159,7 +159,7 @@ int cmd_count_objects(int argc,
 		printf("prune-packable: %lu\n", packed_loose);
 		printf("garbage: %lu\n", garbage);
 		printf("size-garbage: %s\n", garbage_buf.buf);
-		foreach_alt_odb(print_alternate, NULL);
+		odb_for_each_alternate(the_repository->objects, print_alternate, NULL);
 		strbuf_release(&loose_buf);
 		strbuf_release(&pack_buf);
 		strbuf_release(&garbage_buf);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 0f5958c4a66..7ea273d93e4 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -359,7 +359,8 @@ static void write_head_info(void)
 
 	refs_for_each_fullref_in(get_main_ref_store(the_repository), "",
 				 exclude_patterns, show_ref_cb, &seen);
-	for_each_alternate_ref(show_one_alternate_ref, &seen);
+	odb_for_each_alternate_ref(the_repository->objects,
+				   show_one_alternate_ref, &seen);
 
 	oidset_clear(&seen);
 	strvec_clear(&excludes_vector);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 84f7fa53424..7ca483cab52 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1668,7 +1668,8 @@ static void prepare_possible_alternates(const char *sm_name,
 		die(_("Value '%s' for submodule.alternateErrorStrategy is not recognized"), error_strategy);
 
 	if (!strcmp(sm_alternate, "superproject"))
-		foreach_alt_odb(add_possible_reference_from_superproject, &sas);
+		odb_for_each_alternate(the_repository->objects,
+				       add_possible_reference_from_superproject, &sas);
 	else if (!strcmp(sm_alternate, "no"))
 		; /* do nothing */
 	else
diff --git a/diagnose.c b/diagnose.c
index ad0d5c12465..5092bf80d35 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -229,7 +229,7 @@ int create_diagnostics_archive(struct repository *r,
 	strbuf_reset(&buf);
 	strbuf_addstr(&buf, "--add-virtual-file=packs-local.txt:");
 	dir_file_stats(r->objects->sources, &buf);
-	foreach_alt_odb(dir_file_stats, &buf);
+	odb_for_each_alternate(r->objects, dir_file_stats, &buf);
 	strvec_push(&archiver_args, buf.buf);
 
 	strbuf_reset(&buf);
diff --git a/fetch-pack.c b/fetch-pack.c
index cf157f5d7e5..47fa7fa4c49 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -115,7 +115,8 @@ static void for_each_cached_alternate(struct fetch_negotiator *negotiator,
 	size_t i;
 
 	if (!initialized) {
-		for_each_alternate_ref(cache_one_alternate, &cache);
+		odb_for_each_alternate_ref(the_repository->objects,
+					   cache_one_alternate, &cache);
 		initialized = 1;
 	}
 
diff --git a/odb.c b/odb.c
index 691a8c7c681..03fb68605c1 100644
--- a/odb.c
+++ b/odb.c
@@ -494,8 +494,8 @@ static void fill_alternate_refs_command(struct child_process *cmd,
 }
 
 static void read_alternate_refs(const char *path,
-				alternate_ref_fn *cb,
-				void *data)
+				odb_for_each_alternate_ref_fn *cb,
+				void *payload)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct strbuf line = STRBUF_INIT;
@@ -517,7 +517,7 @@ static void read_alternate_refs(const char *path,
 			break;
 		}
 
-		cb(&oid, data);
+		cb(&oid, payload);
 	}
 
 	fclose(fh);
@@ -526,16 +526,16 @@ static void read_alternate_refs(const char *path,
 }
 
 struct alternate_refs_data {
-	alternate_ref_fn *fn;
-	void *data;
+	odb_for_each_alternate_ref_fn *fn;
+	void *payload;
 };
 
 static int refs_from_alternate_cb(struct odb_source *alternate,
-				  void *data)
+				  void *payload)
 {
 	struct strbuf path = STRBUF_INIT;
 	size_t base_len;
-	struct alternate_refs_data *cb = data;
+	struct alternate_refs_data *cb = payload;
 
 	if (!strbuf_realpath(&path, alternate->path, 0))
 		goto out;
@@ -549,29 +549,31 @@ static int refs_from_alternate_cb(struct odb_source *alternate,
 		goto out;
 	strbuf_setlen(&path, base_len);
 
-	read_alternate_refs(path.buf, cb->fn, cb->data);
+	read_alternate_refs(path.buf, cb->fn, cb->payload);
 
 out:
 	strbuf_release(&path);
 	return 0;
 }
 
-void for_each_alternate_ref(alternate_ref_fn fn, void *data)
+void odb_for_each_alternate_ref(struct object_database *odb,
+				odb_for_each_alternate_ref_fn cb, void *payload)
 {
-	struct alternate_refs_data cb;
-	cb.fn = fn;
-	cb.data = data;
-	foreach_alt_odb(refs_from_alternate_cb, &cb);
+	struct alternate_refs_data data;
+	data.fn = cb;
+	data.payload = payload;
+	odb_for_each_alternate(odb, refs_from_alternate_cb, &data);
 }
 
-int foreach_alt_odb(alt_odb_fn fn, void *cb)
+int odb_for_each_alternate(struct object_database *odb,
+			 odb_for_each_alternate_fn cb, void *payload)
 {
 	struct odb_source *alternate;
 	int r = 0;
 
-	odb_prepare_alternates(the_repository->objects);
-	for (alternate = the_repository->objects->sources->next; alternate; alternate = alternate->next) {
-		r = fn(alternate, cb);
+	odb_prepare_alternates(odb);
+	for (alternate = odb->sources->next; alternate; alternate = alternate->next) {
+		r = cb(alternate, payload);
 		if (r)
 			break;
 	}
diff --git a/odb.h b/odb.h
index eba16929a81..7e65e9707c1 100644
--- a/odb.h
+++ b/odb.h
@@ -73,11 +73,6 @@ struct odb_source {
 	char *path;
 };
 
-typedef int alt_odb_fn(struct odb_source *, void *);
-int foreach_alt_odb(alt_odb_fn, void*);
-typedef void alternate_ref_fn(const struct object_id *oid, void *);
-void for_each_alternate_ref(alternate_ref_fn, void *);
-
 /*
  * Replace the current writable object directory with the specified temporary
  * object directory; returns the former primary object directory.
@@ -192,6 +187,24 @@ void odb_clear(struct object_database *o);
  */
 struct odb_source *odb_find_source(struct object_database *odb, const char *obj_dir);
 
+/*
+ * Iterate through all alternates of the database and execute the provided
+ * callback function for each of them. Stop iterating once the callback
+ * function returns a non-zero value, in which case the value is bubbled up
+ * from the callback.
+ */
+typedef int odb_for_each_alternate_fn(struct odb_source *, void *);
+int odb_for_each_alternate(struct object_database *odb,
+			   odb_for_each_alternate_fn cb, void *payload);
+
+/*
+ * Iterate through all alternates of the database and yield their respective
+ * references.
+ */
+typedef void odb_for_each_alternate_ref_fn(const struct object_id *oid, void *);
+void odb_for_each_alternate_ref(struct object_database *odb,
+				odb_for_each_alternate_ref_fn cb, void *payload);
+
 /*
  * Create a temporary file rooted in the primary alternate's directory, or die
  * on failure. The filename is taken from "pattern", which should have the
diff --git a/revision.c b/revision.c
index cdefe7d6e48..b0364f556ee 100644
--- a/revision.c
+++ b/revision.c
@@ -1907,7 +1907,8 @@ static void add_alternate_refs_to_pending(struct rev_info *revs,
 	struct add_alternate_refs_data data;
 	data.revs = revs;
 	data.flags = flags;
-	for_each_alternate_ref(add_one_alternate_ref, &data);
+	odb_for_each_alternate_ref(the_repository->objects,
+				   add_one_alternate_ref, &data);
 }
 
 static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,

-- 
2.50.0.195.g74e6fc65d0.dirty

