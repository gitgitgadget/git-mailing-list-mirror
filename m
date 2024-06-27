Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D720A197A61
	for <git@vger.kernel.org>; Thu, 27 Jun 2024 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501320; cv=none; b=Ak/86yoqE5QeEPHJrIQmbNHWCLxwbxoYztKcN33Hob63/6upJy3dd7KAjPamZkztBSpQ44uxQiptUn7WvaNt5L8dq4/GjJ4GlGYoyEShWs2f82XVsoIGfHo+e9RW/Dd7pZDVVYwbXA2XQAr4cksN+YRA37zRaB56/xZKYl+RTTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501320; c=relaxed/simple;
	bh=MMLgikjjCWZJpa62DV+t8V+bsKzXMjmlEfnYr0BN4Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BURWXYJ9wz0tDm9Ee+xijduM7SvC0LqIugQaf84MzPTf4JNRBrYpdU4tN5CxtInvgVwapadsqBB8tR8e6RbAnV1hChDjPqjm534kYyOk/fvcGwwIhONM+CCXYPXirt/RsQFxj//YCkyNq3+xhm54PzsauE0xaWOYFWfzW2N5XDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0byfTTv; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0byfTTv"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-718354c17e4so4399066a12.1
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 08:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719501317; x=1720106117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DTdwjzRv4a3DZpn0+6TZLo6M300hXmSeHagjQKRIRWU=;
        b=h0byfTTvXzwUvTnFRLQdrbmN1s52t7302hUx9XnDmz/CAnAwpLtcO8cZRWeeiMrhBZ
         hZdQCjTC789UtvZlC/dICur9Izyb2EUr+owhQyqWWhivjejlaqnPPn3rBxl2BVvEgiq2
         2o5KS+5ZB5H0TMExVGCB5H9ynXCjPtj2ZUghRec6zjaxaOqFVtZUxyp13zagwE+zdR85
         FegaC7kjb1rBEmEQvwMUXB6rDzlC4GkoS2j7E0giCX495Qt0YzcuRB/ch2uxqzPPrUdH
         eOlSAehK+1mOb6LX3zcw7ooJBmAu0FQH6ph+R+my1cjyaLHy8Ck8v2iMu+BY0aOvo23a
         uJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719501317; x=1720106117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTdwjzRv4a3DZpn0+6TZLo6M300hXmSeHagjQKRIRWU=;
        b=CPZ2dI5kobNQTMU3DQlvcRsZod2ONe4II4gZ6EUsgfowmwxQ5yja6aMveDzbSKbHyB
         ECerDXR0yRSCHxPDcLtR4UnoK6LkHFTp20HJPMZqbxCnM0ak47rq0eunPmvoRHHZk03Q
         luHJnzmCPe9s12w4jhnkD6gmTyz+qswjRDObGUbqlIdCxTkqzsJjnzfpp3gFfgJQHuSM
         lRuHIop0R0USn6YnEhAGekErDI8SYQZI2iQtbrymSq3fWPala6KcBv/xuYRoNh3Il/Yy
         3lrXyIGTj0fe3D3EiZn+hOiuHRYyn8EZVCV/17xSQQyVPeyEgiFxgRl3X4WNnZAqhh2L
         fX0w==
X-Gm-Message-State: AOJu0YxlJ/Eg1R6hSxsp6/+t7BsDeg1XqWgHZ5pHzxMlepHPgC138vzM
	4LweyiN8zk29aMoA6kb1pjWSl0UlOM8fT8C96wKlTLDeFmJvpaHEa3JI9Q==
X-Google-Smtp-Source: AGHT+IF4gvlRUUSPyIAxDNsqh/0J+pHgCOPq22Bwswo8F1+qF3wTQkqzpS60/SOSZBTlZ8TSlu/SzA==
X-Received: by 2002:a05:6a20:3016:b0:1be:c551:b74f with SMTP id adf61e73a8af0-1bec551ba09mr3846504637.27.1719501317468;
        Thu, 27 Jun 2024 08:15:17 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8d7e54699sm3830485a91.4.2024.06.27.08.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 08:15:16 -0700 (PDT)
Date: Thu, 27 Jun 2024 23:15:14 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v5 07/12] refs: set up ref consistency check
 infrastructure
Message-ID: <Zn2CAgdg65SlJvRu@ArchLinux>
References: <Zn2Ah3WDhtOmzrzn@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn2Ah3WDhtOmzrzn@ArchLinux>

The interfaces defined in the `ref_storage_be` are carefully structured
in semantic. It's organized as the five parts:

1. The name and the initialization interfaces.
2. The ref transaction interfaces.
3. The ref internal interfaces (pack, rename and copy).
4. The ref filesystem interfaces.
5. The reflog related interfaces.

To keep consistent with the git-fsck(1), add a new interface named
"fsck_refs_fn" to the end of "ref_storage_be". This semantic cannot be
grouped into any above five categories. Explicitly add blank line to
make it different from others.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs.c                  |  5 +++++
 refs.h                  |  8 ++++++++
 refs/debug.c            | 11 +++++++++++
 refs/files-backend.c    | 15 ++++++++++++++-
 refs/packed-backend.c   |  8 ++++++++
 refs/refs-internal.h    |  6 ++++++
 refs/reftable-backend.c |  8 ++++++++
 7 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index dd0d9c360f..646fdfaf22 100644
--- a/refs.c
+++ b/refs.c
@@ -316,6 +316,11 @@ int check_refname_format(const char *refname, int flags)
 	return check_or_sanitize_refname(refname, flags, NULL);
 }
 
+int refs_fsck(struct ref_store *refs, struct fsck_refs_options *o)
+{
+	return refs->be->fsck(refs, o);
+}
+
 void sanitize_refname_component(const char *refname, struct strbuf *out)
 {
 	if (check_or_sanitize_refname(refname, REFNAME_ALLOW_ONELEVEL, out))
diff --git a/refs.h b/refs.h
index df8cbf6124..a8f4deb108 100644
--- a/refs.h
+++ b/refs.h
@@ -3,6 +3,7 @@
 
 #include "commit.h"
 
+struct fsck_refs_options;
 struct object_id;
 struct ref_store;
 struct repository;
@@ -547,6 +548,13 @@ int refs_for_each_reflog(struct ref_store *refs, each_reflog_fn fn, void *cb_dat
  */
 int check_refname_format(const char *refname, int flags);
 
+/*
+ * Check the reference database for consistency. Return 0 if refs and
+ * reflogs are consistent, and non-zero otherwise. The errors will be
+ * written to stderr.
+ */
+int refs_fsck(struct ref_store *refs, struct fsck_refs_options *o);
+
 /*
  * Apply the rules from check_refname_format, but mutate the result until it
  * is acceptable, and place the result in "out".
diff --git a/refs/debug.c b/refs/debug.c
index 547d9245b9..6306c25fd3 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -419,6 +419,15 @@ static int debug_reflog_expire(struct ref_store *ref_store, const char *refname,
 	return res;
 }
 
+static int debug_fsck(struct ref_store *ref_store,
+		      struct fsck_refs_options *o)
+{
+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
+	int res = drefs->refs->be->fsck(drefs->refs, o);
+	trace_printf_key(&trace_refs, "fsck: %d\n", res);
+	return res;
+}
+
 struct ref_storage_be refs_be_debug = {
 	.name = "debug",
 	.init = NULL,
@@ -451,4 +460,6 @@ struct ref_storage_be refs_be_debug = {
 	.create_reflog = debug_create_reflog,
 	.delete_reflog = debug_delete_reflog,
 	.reflog_expire = debug_reflog_expire,
+
+	.fsck = debug_fsck,
 };
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 44c5c3b201..7257fffb77 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3406,6 +3406,17 @@ static int files_ref_store_remove_on_disk(struct ref_store *ref_store,
 	return ret;
 }
 
+static int files_fsck(struct ref_store *ref_store,
+		      struct fsck_refs_options *o)
+{
+	int ret;
+	struct files_ref_store *refs =
+		files_downcast(ref_store, REF_STORE_READ, "fsck");
+
+	ret = refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
+	return ret;
+}
+
 struct ref_storage_be refs_be_files = {
 	.name = "files",
 	.init = files_ref_store_init,
@@ -3432,5 +3443,7 @@ struct ref_storage_be refs_be_files = {
 	.reflog_exists = files_reflog_exists,
 	.create_reflog = files_create_reflog,
 	.delete_reflog = files_delete_reflog,
-	.reflog_expire = files_reflog_expire
+	.reflog_expire = files_reflog_expire,
+
+	.fsck = files_fsck,
 };
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index c4c1e36aa2..db152053f8 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1733,6 +1733,12 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
 	return empty_ref_iterator_begin();
 }
 
+static int packed_fsck(struct ref_store *ref_store,
+		       struct fsck_refs_options *o)
+{
+	return 0;
+}
+
 struct ref_storage_be refs_be_packed = {
 	.name = "packed",
 	.init = packed_ref_store_init,
@@ -1760,4 +1766,6 @@ struct ref_storage_be refs_be_packed = {
 	.create_reflog = NULL,
 	.delete_reflog = NULL,
 	.reflog_expire = NULL,
+
+	.fsck = packed_fsck,
 };
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index fa975d69aa..ecc082baf8 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -4,6 +4,7 @@
 #include "refs.h"
 #include "iterator.h"
 
+struct fsck_options;
 struct ref_transaction;
 
 /*
@@ -650,6 +651,9 @@ typedef int read_raw_ref_fn(struct ref_store *ref_store, const char *refname,
 typedef int read_symbolic_ref_fn(struct ref_store *ref_store, const char *refname,
 				 struct strbuf *referent);
 
+typedef int fsck_fn(struct ref_store *ref_store,
+		    struct fsck_refs_options *o);
+
 struct ref_storage_be {
 	const char *name;
 	ref_store_init_fn *init;
@@ -677,6 +681,8 @@ struct ref_storage_be {
 	create_reflog_fn *create_reflog;
 	delete_reflog_fn *delete_reflog;
 	reflog_expire_fn *reflog_expire;
+
+	fsck_fn *fsck;
 };
 
 extern struct ref_storage_be refs_be_files;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 7d872a32ac..2a358b40ca 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -2292,6 +2292,12 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 	return ret;
 }
 
+static int reftable_be_fsck(struct ref_store *ref_store,
+			    struct fsck_refs_options *o)
+{
+	return 0;
+}
+
 struct ref_storage_be refs_be_reftable = {
 	.name = "reftable",
 	.init = reftable_be_init,
@@ -2319,4 +2325,6 @@ struct ref_storage_be refs_be_reftable = {
 	.create_reflog = reftable_be_create_reflog,
 	.delete_reflog = reftable_be_delete_reflog,
 	.reflog_expire = reftable_be_reflog_expire,
+
+	.fsck = reftable_be_fsck,
 };
-- 
2.45.2

