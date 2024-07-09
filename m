Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE31E152160
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 12:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528514; cv=none; b=Aowa+kl2KzAEYYL+vDUc3f8Tg6eb/+enx/2GCa42qFMAJ8oRkPnqoPzWK89Pl6aIL8cn7iM98Enpkk+y0Xe3iOABG0uqDAV1VOLJt/1p5btDu2WpTKFre+iy5E4oELgSQ1btEUMrZxmrQZsfGlvOi1kEewN0MTpf+Tgy9v8stdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528514; c=relaxed/simple;
	bh=RtoJGtCg7eNC9cRZzb9vpBNwpW12SN2/x9clzQ5m7ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuP/Jv41ivmOrjPdWt2ljtXNCmG6hoNakp+mn7+V6Kt1fEq9TBm575o0bH+dgVa6oN15Jw2Kd/osAG/ZddC+lopqQ4CWjRk/F9aKGIvwVpZ+N7JrSDgA7f3Y4iD5fba3op4raLSQ8jydM+p6xUFJ593IbvnoEBY7/fHOdnYbqcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgRegyBW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgRegyBW"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fb3cf78fbdso25626265ad.1
        for <git@vger.kernel.org>; Tue, 09 Jul 2024 05:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720528511; x=1721133311; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CovjwZcCJcSU8wk2NorGkel0vg14P6lpXwb5E7XaFGo=;
        b=YgRegyBWiifIjgW5moWcITlcC8sRnjqcLDHRnbbYcbUt58G8ma/mNnrJGLIRnPxn2+
         1t7NMM0HInbH+1uAZSl08jkiGiGNit/Y17Q6ZMPGzBAtu8j/xT/Bt7aC3kSNhU5dM95Q
         V9RWcHPbmvGPd312sos1L/981njvuMArqXXYOoRyhekkC9/vIXxlYCMMLtRgesj6PRMp
         xr+rYUnapkpdaCDS0271hB3NGlh9ueQJ5B6WnZGldh8qpuctELg5dUr9JQq3mgr9yU59
         bCcrIJ3VwfmMS6zD/iJnBITzABe8XGS+JX6NtcpbclUNUBQPcp1jkP/dK0LMVM/Fe4OP
         m7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720528511; x=1721133311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CovjwZcCJcSU8wk2NorGkel0vg14P6lpXwb5E7XaFGo=;
        b=DTglSrDIV0pNuL+tR4L37bq0qYwurd7jAFhahOIBYrR0Nx468xfvS5LNAtJcfUUSDQ
         2p2ysulV2L3O8HZ+zN+ufWuTNwtqj0AyXAP27wZF1O6NTQ43StKsFHEDfowOrz7iCYxI
         d2mumMFBdYj+5bbTvb0Rrlp7r3Q25EBMPvDeYtl7/4PBYyG+VAa0gp5W3tKxzaWfd4dp
         w21CQuRpF2fdKJf4TfLdUtVoPycW9bR6RRqeRkQGho/Tj1qdb+A0CGTa+pt7dEkFHwkj
         vxqpVxBvU+YtifcA5NYrKKaVnj4DygJ/5ApQ2UYNQO7JpwDCr09DOcdaZKNWYH9G6rlm
         n4vw==
X-Gm-Message-State: AOJu0YwlLJq6bYVChfgqEtlDxYmr6N1gg7A5JNot2P9BGsRQv/q5ZxxV
	PMdZswYDbMvvCrlwsPd90IFrhggjom3Pp+hyH1T+mhk+gW3tteqqGe7Az4Ja
X-Google-Smtp-Source: AGHT+IFwGor9+RWhjwpJUFefczPpodQRSnJyZALu70UKsO0a6qxbQ8Vyn6a34lIPvldcC8EwNq9plg==
X-Received: by 2002:a17:903:41c8:b0:1fb:6294:2e35 with SMTP id d9443c01a7336-1fbb6d53ba8mr20352085ad.50.1720528511512;
        Tue, 09 Jul 2024 05:35:11 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab7bc2sm15031675ad.127.2024.07.09.05.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 05:35:11 -0700 (PDT)
Date: Tue, 9 Jul 2024 20:35:10 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v9 2/9] fsck: add a unified interface for reporting
 fsck messages
Message-ID: <Zo0ufgFhREKlmBFG@ArchLinux>
References: <Zo0sQCBqyxX8dJ-f@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo0sQCBqyxX8dJ-f@ArchLinux>

The static function "report" provided by "fsck.c" aims at checking fsck
error type and calling the callback "error_func" to report the message.
However, "report" function is only related to object database which
cannot be reused for refs. In order to provide a unified interface which
can report either objects or refs, create a new function "vfsck_report"
by adding "checked_ref_name" parameter following the "report" prototype.
Instead of using "...", provide "va_list" to allow more flexibility.

Like "report", the "vfsck_report" function will use "error_func"
registered in "fsck_options" to report customized messages. Change
"error_func" prototype to align with the new "vfsck_report".

Then, change "report" function to use "vfsck_report" to report objects
related messages. Add a new function called "fsck_refs_report" to use
"vfsck_report" to report refs related messages.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c  | 15 ++++-----
 builtin/mktag.c |  1 +
 fsck.c          | 81 ++++++++++++++++++++++++++++++++++++-------------
 fsck.h          | 40 +++++++++++++++---------
 object-file.c   | 11 ++++---
 5 files changed, 101 insertions(+), 47 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index d13a226c2e..de34538c4f 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -89,12 +89,13 @@ static int objerror(struct object *obj, const char *err)
 	return -1;
 }
 
-static int fsck_error_func(struct fsck_options *o UNUSED,
-			   const struct object_id *oid,
-			   enum object_type object_type,
-			   enum fsck_msg_type msg_type,
-			   enum fsck_msg_id msg_id UNUSED,
-			   const char *message)
+static int fsck_objects_error_func(struct fsck_options *o UNUSED,
+				   const struct object_id *oid,
+				   enum object_type object_type,
+				   const char *checked_ref_name UNUSED,
+				   enum fsck_msg_type msg_type,
+				   enum fsck_msg_id msg_id UNUSED,
+				   const char *message)
 {
 	switch (msg_type) {
 	case FSCK_WARN:
@@ -938,7 +939,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	fsck_walk_options.walk = mark_object;
 	fsck_obj_options.walk = mark_used;
-	fsck_obj_options.error_func = fsck_error_func;
+	fsck_obj_options.error_func = fsck_objects_error_func;
 	if (check_strict)
 		fsck_obj_options.strict = 1;
 
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 4767f1a97e..42f945c584 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -20,6 +20,7 @@ static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
 static int mktag_fsck_error_func(struct fsck_options *o UNUSED,
 				 const struct object_id *oid UNUSED,
 				 enum object_type object_type UNUSED,
+				 const char *checked_ref_name UNUSED,
 				 enum fsck_msg_type msg_type,
 				 enum fsck_msg_id msg_id UNUSED,
 				 const char *message)
diff --git a/fsck.c b/fsck.c
index 3f32441492..e1819964e3 100644
--- a/fsck.c
+++ b/fsck.c
@@ -226,12 +226,18 @@ static int object_on_skiplist(struct fsck_options *opts,
 	return opts && oid && oidset_contains(&opts->skip_oids, oid);
 }
 
-__attribute__((format (printf, 5, 6)))
-static int report(struct fsck_options *options,
-		  const struct object_id *oid, enum object_type object_type,
-		  enum fsck_msg_id msg_id, const char *fmt, ...)
+/*
+ * Provide a unified interface for either fscking refs or objects.
+ * It will get the current msg error type and call the error_func callback
+ * which is registered in the "fsck_options" struct.
+ */
+static int vfsck_report(struct fsck_options *options,
+			const struct object_id *oid,
+			enum object_type object_type,
+			const char *checked_ref_name,
+			enum fsck_msg_id msg_id, const char *fmt, va_list ap)
 {
-	va_list ap;
+	va_list ap_copy;
 	struct strbuf sb = STRBUF_INIT;
 	enum fsck_msg_type msg_type = fsck_msg_type(msg_id, options);
 	int result;
@@ -250,9 +256,9 @@ static int report(struct fsck_options *options,
 	prepare_msg_ids();
 	strbuf_addf(&sb, "%s: ", msg_id_info[msg_id].camelcased);
 
-	va_start(ap, fmt);
-	strbuf_vaddf(&sb, fmt, ap);
-	result = options->error_func(options, oid, object_type,
+	va_copy(ap_copy, ap);
+	strbuf_vaddf(&sb, fmt, ap_copy);
+	result = options->error_func(options, oid, object_type, checked_ref_name,
 				     msg_type, msg_id, sb.buf);
 	strbuf_release(&sb);
 	va_end(ap);
@@ -260,6 +266,36 @@ static int report(struct fsck_options *options,
 	return result;
 }
 
+__attribute__((format (printf, 5, 6)))
+static int report(struct fsck_options *options,
+		  const struct object_id *oid, enum object_type object_type,
+		  enum fsck_msg_id msg_id, const char *fmt, ...)
+{
+	va_list ap;
+	int result;
+	va_start(ap, fmt);
+	result = vfsck_report(options, oid, object_type, NULL,
+			      msg_id, fmt, ap);
+	va_end(ap);
+	return result;
+}
+
+
+
+int fsck_refs_report(struct fsck_options *options,
+		     const struct object_id *oid,
+		     const char *checked_ref_name,
+		     enum fsck_msg_id msg_id, const char *fmt, ...)
+{
+	va_list ap;
+	int result;
+	va_start(ap, fmt);
+	result = vfsck_report(options, oid, OBJ_NONE,
+			      checked_ref_name, msg_id, fmt, ap);
+	va_end(ap);
+	return result;
+}
+
 void fsck_enable_object_names(struct fsck_options *options)
 {
 	if (!options->object_names)
@@ -1200,12 +1236,13 @@ int fsck_buffer(const struct object_id *oid, enum object_type type,
 		      type);
 }
 
-int fsck_error_function(struct fsck_options *o,
-			const struct object_id *oid,
-			enum object_type object_type UNUSED,
-			enum fsck_msg_type msg_type,
-			enum fsck_msg_id msg_id UNUSED,
-			const char *message)
+int fsck_objects_error_function(struct fsck_options *o,
+				const struct object_id *oid,
+				enum object_type object_type UNUSED,
+				const char *checked_ref_name UNUSED,
+				enum fsck_msg_type msg_type,
+				enum fsck_msg_id msg_id UNUSED,
+				const char *message)
 {
 	if (msg_type == FSCK_WARN) {
 		warning("object %s: %s", fsck_describe_object(o, oid), message);
@@ -1303,16 +1340,18 @@ int git_fsck_config(const char *var, const char *value,
  * Custom error callbacks that are used in more than one place.
  */
 
-int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
-					   const struct object_id *oid,
-					   enum object_type object_type,
-					   enum fsck_msg_type msg_type,
-					   enum fsck_msg_id msg_id,
-					   const char *message)
+int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
+						   const struct object_id *oid,
+						   enum object_type object_type,
+						   const char *checked_ref_name,
+						   enum fsck_msg_type msg_type,
+						   enum fsck_msg_id msg_id,
+						   const char *message)
 {
 	if (msg_id == FSCK_MSG_GITMODULES_MISSING) {
 		puts(oid_to_hex(oid));
 		return 0;
 	}
-	return fsck_error_function(o, oid, object_type, msg_type, msg_id, message);
+	return fsck_objects_error_function(o, oid, object_type, checked_ref_name,
+					   msg_type, msg_id, message);
 }
diff --git a/fsck.h b/fsck.h
index bcfb2e34cd..8ce48395f6 100644
--- a/fsck.h
+++ b/fsck.h
@@ -114,22 +114,27 @@ int is_valid_msg_type(const char *msg_id, const char *msg_type);
 typedef int (*fsck_walk_func)(struct object *obj, enum object_type object_type,
 			      void *data, struct fsck_options *options);
 
-/* callback for fsck_object, type is FSCK_ERROR or FSCK_WARN */
+/*
+ * callback function for reporting errors when checking either objects or refs
+ */
 typedef int (*fsck_error)(struct fsck_options *o,
 			  const struct object_id *oid, enum object_type object_type,
+			  const char *checked_ref_name,
 			  enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
 			  const char *message);
 
-int fsck_error_function(struct fsck_options *o,
-			const struct object_id *oid, enum object_type object_type,
-			enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
-			const char *message);
-int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
-					   const struct object_id *oid,
-					   enum object_type object_type,
-					   enum fsck_msg_type msg_type,
-					   enum fsck_msg_id msg_id,
-					   const char *message);
+int fsck_objects_error_function(struct fsck_options *o,
+				const struct object_id *oid, enum object_type object_type,
+				const char *checked_ref_name,
+				enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
+				const char *message);
+int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
+						   const struct object_id *oid,
+						   enum object_type object_type,
+						   const char *checked_ref_name,
+						   enum fsck_msg_type msg_type,
+						   enum fsck_msg_id msg_id,
+						   const char *message);
 
 struct fsck_options {
 	fsck_walk_func walk;
@@ -150,7 +155,7 @@ struct fsck_options {
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
 	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_error_function \
+	.error_func = fsck_objects_error_function \
 }
 #define FSCK_OPTIONS_STRICT { \
 	.strict = 1, \
@@ -158,7 +163,7 @@ struct fsck_options {
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
 	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_error_function, \
+	.error_func = fsck_objects_error_function, \
 }
 #define FSCK_OPTIONS_MISSING_GITMODULES { \
 	.strict = 1, \
@@ -166,7 +171,7 @@ struct fsck_options {
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
 	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_error_cb_print_missing_gitmodules, \
+	.error_func = fsck_objects_error_cb_print_missing_gitmodules, \
 }
 
 /* descend in all linked child objects
@@ -209,6 +214,13 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
  */
 int fsck_finish(struct fsck_options *options);
 
+__attribute__((format (printf, 5, 6)))
+int fsck_refs_report(struct fsck_options *options,
+		     const struct object_id *oid,
+		     const char *checked_ref_name,
+		     enum fsck_msg_id msg_id,
+		     const char *fmt, ...);
+
 /*
  * Subsystem for storing human-readable names for each object.
  *
diff --git a/object-file.c b/object-file.c
index 065103be3e..d2c6427935 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2470,11 +2470,12 @@ int repo_has_object_file(struct repository *r,
  * give more context.
  */
 static int hash_format_check_report(struct fsck_options *opts UNUSED,
-				     const struct object_id *oid UNUSED,
-				     enum object_type object_type UNUSED,
-				     enum fsck_msg_type msg_type UNUSED,
-				     enum fsck_msg_id msg_id UNUSED,
-				     const char *message)
+				    const struct object_id *oid UNUSED,
+				    enum object_type object_type UNUSED,
+				    const char *ref_checked_name UNUSED,
+				    enum fsck_msg_type msg_type UNUSED,
+				    enum fsck_msg_id msg_id UNUSED,
+				    const char *message)
 {
 	error(_("object fails fsck: %s"), message);
 	return 1;
-- 
2.45.2

