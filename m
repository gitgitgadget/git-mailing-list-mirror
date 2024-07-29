Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20AD3C24
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 13:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722259573; cv=none; b=IBiqt4v849zkv0VsifGrILGeqPv5r6T+JzsEUbnBci/iLD9pTN83kqh1FOA0/usl5qrLVoAjwY7Ju34oq/6JAiLPCXvONf+iTbAuBficcfZ7WgxamDIsUoNVLqrEyAPG/R6bl7k9nAmAxiJt95FOyVYcmsF6LNMnZ30t1eJUz6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722259573; c=relaxed/simple;
	bh=T/u4woMXYiptZFsUNUJptsaLd657VkrybvcIDW+tgso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X89QugBvjLU1Vvy90sL1fI7fc2UzW8mbbxy4WrDDVqYLWK3kMJKZgs7dZLV5cFgpqfzp8vmHX6Zn3tRR9cWeZ/7ihMKyCRMlXr0lyrtwlOBJcro73QxSkkIpFOoDoMCMO+Li3N+QWaCxmPJxFUOnWTOD0rA2ROlb4NDUm8BVlvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Us7hD+7l; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Us7hD+7l"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d18112b60so2292347b3a.1
        for <git@vger.kernel.org>; Mon, 29 Jul 2024 06:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722259570; x=1722864370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PDd8yrvBilTJ2Hg8IO0Rsc5tZtUtgMkB6weQ3gTiLO4=;
        b=Us7hD+7lQ3MgFPdUoyRCM4K/KNdJBPUnwOPgQXEDq/i5tF30bcLucD/GsJ7/4vUyqH
         z6VGeB81GaxTVdFzhcF+NRouJjhnnxDOryy5C9gKSwdycYnwtx00QIQJJCw7G5Rw8vfT
         GVWh9swo2nTUuSxc713+hPQxYVH2rki2fDZG3THTwOnt5zQHB1/t05prwDTVqgt+DnAg
         ygN+ZImECWaAq0vWsV3t09A9rSsgKbu1+viSBmmBdCgMgy2mgxC3DvglFDotbhAxDkPU
         X26xwzQtVUfk0PxFS3wn0cu+EMk2b0Leltq2B0vV9pVc/YJRfnSc23ZKQbm/YLALbyUs
         LEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722259570; x=1722864370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDd8yrvBilTJ2Hg8IO0Rsc5tZtUtgMkB6weQ3gTiLO4=;
        b=N2E7/ZgvNKj1C9iJpLxsHmgwLRxo0T8Z+aZLa0YVblHTGt6KhGp1r9O6rYMRFaSf8M
         R7qPwBihAKWLftz7pzZ1tx9SjIJ9/VuMfrts13dCKnAIsifLxYQkwmQbEIjxdPJMVvta
         lp46FHcudl2wjeZatJLi1rnxyraY0vsdG4UWFPqTsrE2FfQrFtVkfv44xt34KfX/KYRq
         JgPhtuiw8KBviHy7WyJykkFdXbx//V2O42mOoMkkBackWhPXs97Ga5EHv5x+Q0nOXobu
         sMW1GnXIpOU8T2GK0g9XG6MjNU9N/T8gf5WWdqIvpz8CggB367VKV6370/PjidmMBl5U
         jszw==
X-Gm-Message-State: AOJu0YyJfiMkJiALkpCC2D+jteLM0eLn7DuLiH5HM/kny23/zqL7q72P
	ymgXMOF718j6iaBqOvvU68K3JM3aNQY9b7XrD/+vHt+W6p9KP8Zyey/SVA==
X-Google-Smtp-Source: AGHT+IGK+KSAx4emqZoSOv+aKVvOeM5Xh3dE4kXiF6ztuj5hRwL3SBCqhIKMIN1YVhAaDbIRhWgZPQ==
X-Received: by 2002:a05:6a00:3d0d:b0:70e:cee8:264a with SMTP id d2e1a72fcca58-70ecee82ceemr13216220b3a.1.1722259570337;
        Mon, 29 Jul 2024 06:26:10 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f816db18sm6213964a12.33.2024.07.29.06.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 06:26:09 -0700 (PDT)
Date: Mon, 29 Jul 2024 21:26:30 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v13 02/10] fsck: add a unified interface for reporting
 fsck messages
Message-ID: <ZqeYhkaArVmMdrnK@ArchLinux>
References: <ZqeXrPROpEg_pRS2@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqeXrPROpEg_pRS2@ArchLinux>

The static function "report" provided by "fsck.c" aims at checking fsck
error type and calling the callback "error_func" to report the message.
However, "report" function is only related to object database which
cannot be reused for refs. In order to provide a unified interface which
can report either objects or refs, create a new function "fsck_vreport"
following the "report" prototype. Instead of using "...", provide
"va_list" to allow more flexibility.

In order to provide an extensible error report for refs, add a new
"fsck_refs_info" structure and add parameter "const struct
*fsck_refs_info" into "fsck_vreport" function.

Like "report", the "fsck_vreport" function will use "error_func"
registered in "fsck_options" to report customized messages. Change
"error_func" prototype to align with the new "fsck_vreport".

Then, change "report" function to use "fsck_vreport" to report objects
related messages. Add a new function called "fsck_refs_report" to use
"fsck_vreport" to report refs related messages.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c  |  1 +
 builtin/mktag.c |  1 +
 fsck.c          | 56 +++++++++++++++++++++++++++++++++++++++++--------
 fsck.h          | 25 +++++++++++++++++++++-
 object-file.c   | 11 +++++-----
 5 files changed, 79 insertions(+), 15 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index d13a226c2e..6abad60e7e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -92,6 +92,7 @@ static int objerror(struct object *obj, const char *err)
 static int fsck_error_func(struct fsck_options *o UNUSED,
 			   const struct object_id *oid,
 			   enum object_type object_type,
+			   const struct fsck_refs_info *refs_info UNUSED,
 			   enum fsck_msg_type msg_type,
 			   enum fsck_msg_id msg_id UNUSED,
 			   const char *message)
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 4767f1a97e..6496deca0a 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -20,6 +20,7 @@ static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
 static int mktag_fsck_error_func(struct fsck_options *o UNUSED,
 				 const struct object_id *oid UNUSED,
 				 enum object_type object_type UNUSED,
+				 const struct fsck_refs_info *refs_info UNUSED,
 				 enum fsck_msg_type msg_type,
 				 enum fsck_msg_id msg_id UNUSED,
 				 const char *message)
diff --git a/fsck.c b/fsck.c
index 3f32441492..1185e9a8ad 100644
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
+static int fsck_vreport(struct fsck_options *options,
+			const struct object_id *oid,
+			enum object_type object_type,
+			const struct fsck_refs_info *refs_info,
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
+	result = options->error_func(options, oid, object_type, refs_info,
 				     msg_type, msg_id, sb.buf);
 	strbuf_release(&sb);
 	va_end(ap);
@@ -260,6 +266,35 @@ static int report(struct fsck_options *options,
 	return result;
 }
 
+__attribute__((format (printf, 5, 6)))
+static int report(struct fsck_options *options,
+		  const struct object_id *oid, enum object_type object_type,
+		  enum fsck_msg_id msg_id, const char *fmt, ...)
+{
+	va_list ap;
+	int result;
+
+	va_start(ap, fmt);
+	result = fsck_vreport(options, oid, object_type, NULL, msg_id, fmt, ap);
+	va_end(ap);
+
+	return result;
+}
+
+int fsck_refs_report(struct fsck_options *options,
+		     const struct object_id *oid,
+		     const struct fsck_refs_info *refs_info,
+		     enum fsck_msg_id msg_id, const char *fmt, ...)
+{
+	va_list ap;
+	int result;
+	va_start(ap, fmt);
+	result = fsck_vreport(options, oid, OBJ_NONE, refs_info,
+			      msg_id, fmt, ap);
+	va_end(ap);
+	return result;
+}
+
 void fsck_enable_object_names(struct fsck_options *options)
 {
 	if (!options->object_names)
@@ -1203,6 +1238,7 @@ int fsck_buffer(const struct object_id *oid, enum object_type type,
 int fsck_error_function(struct fsck_options *o,
 			const struct object_id *oid,
 			enum object_type object_type UNUSED,
+			const struct fsck_refs_info *refs_info UNUSED,
 			enum fsck_msg_type msg_type,
 			enum fsck_msg_id msg_id UNUSED,
 			const char *message)
@@ -1306,6 +1342,7 @@ int git_fsck_config(const char *var, const char *value,
 int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
 					   const struct object_id *oid,
 					   enum object_type object_type,
+					   const struct fsck_refs_info *refs_info,
 					   enum fsck_msg_type msg_type,
 					   enum fsck_msg_id msg_id,
 					   const char *message)
@@ -1314,5 +1351,6 @@ int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
 		puts(oid_to_hex(oid));
 		return 0;
 	}
-	return fsck_error_function(o, oid, object_type, msg_type, msg_id, message);
+	return fsck_error_function(o, oid, object_type, refs_info,
+				   msg_type, msg_id, message);
 }
diff --git a/fsck.h b/fsck.h
index bcfb2e34cd..4f01a46cc7 100644
--- a/fsck.h
+++ b/fsck.h
@@ -92,6 +92,7 @@ enum fsck_msg_id {
 };
 #undef MSG_ID
 
+struct fsck_refs_info;
 struct fsck_options;
 struct object;
 
@@ -114,23 +115,35 @@ int is_valid_msg_type(const char *msg_id, const char *msg_type);
 typedef int (*fsck_walk_func)(struct object *obj, enum object_type object_type,
 			      void *data, struct fsck_options *options);
 
-/* callback for fsck_object, type is FSCK_ERROR or FSCK_WARN */
+/*
+ * callback function for reporting errors when checking either objects or refs
+ */
 typedef int (*fsck_error)(struct fsck_options *o,
 			  const struct object_id *oid, enum object_type object_type,
+			  const struct fsck_refs_info *refs_info,
 			  enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
 			  const char *message);
 
 int fsck_error_function(struct fsck_options *o,
 			const struct object_id *oid, enum object_type object_type,
+			const struct fsck_refs_info *refs_info,
 			enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
 			const char *message);
 int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
 					   const struct object_id *oid,
 					   enum object_type object_type,
+					   const struct fsck_refs_info *refs_info,
 					   enum fsck_msg_type msg_type,
 					   enum fsck_msg_id msg_id,
 					   const char *message);
 
+/*
+ * The information for reporting refs-related error message
+ */
+struct fsck_refs_info {
+	const char *path;
+};
+
 struct fsck_options {
 	fsck_walk_func walk;
 	fsck_error error_func;
@@ -209,6 +222,16 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
  */
 int fsck_finish(struct fsck_options *options);
 
+/*
+ * Report an error or warning for refs.
+ */
+__attribute__((format (printf, 5, 6)))
+int fsck_refs_report(struct fsck_options *options,
+		     const struct object_id *oid,
+		     const struct fsck_refs_info *refs_info,
+		     enum fsck_msg_id msg_id,
+		     const char *fmt, ...);
+
 /*
  * Subsystem for storing human-readable names for each object.
  *
diff --git a/object-file.c b/object-file.c
index 065103be3e..91ddab2696 100644
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
+				    const struct fsck_refs_info *refs_info UNUSED,
+				    enum fsck_msg_type msg_type UNUSED,
+				    enum fsck_msg_id msg_id UNUSED,
+				    const char *message)
 {
 	error(_("object fails fsck: %s"), message);
 	return 1;
-- 
2.45.2

