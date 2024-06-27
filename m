Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF9719884D
	for <git@vger.kernel.org>; Thu, 27 Jun 2024 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501221; cv=none; b=py5Hmvki9Rpq6ybXAbWWc9qvWp7imQOnonFF5aE0mEmxIy2aKa3QtNdXYJiA5uuDrmslp6HWxB+Mrvupcg6xz7bCrWBbaMJy/wrs+kbN6LmmkNctEctnNLbh08+D8zKCcNtvjn5mAfsO7ONvJcBm5RIOaPw5tzSBPBeIdbHMZnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501221; c=relaxed/simple;
	bh=B13UYPZYulP1IRnaO4q4bGWZ/+KAwxWLbfcDd6gVR1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srBjUHSQrriqc5nxrxJTaH85ulKyMIN3VAfCYdDqXHvMTuttWGprjZnRpjJHJE6QU3KrARU3ST+8d2f1SXxXMGrEgSxwfIEHphR2yeo7/71EcDmfrfGYK+kTAIc6NjD82xKAjjCqAbqlx9MPiScQEqm2wVqlU0bYzUVVAu87nnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rx3HfQpq; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rx3HfQpq"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3737dc4a669so32459615ab.0
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 08:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719501218; x=1720106018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4TX0U3b8jimiqgeX357u7GUJDhVKKzDM/foxrwVdpbY=;
        b=Rx3HfQpq95hxICmsq4lJOa05X5EF9EG++c8lDN+GzcdDF5s22wOhucQQEGuSNXF3Gl
         DDSLwVaqnUfpnhUEk66KXdQqJg3YT8TQsyclCl+9c+tEVOjKZnaSVHPM636tg6kwYzk9
         CW5ty+DlOHgd3IjLswgbslJmQhHLucI5lM9bbrHaxNWwtT0A4mOviAL9WQen/uoEE+aa
         iSlbPAfsdTrOn/WrkLyhbo387SVc69+58hRbft5lkkE1yWqnipkibqmYP5g6vqm15j7M
         Ud8b1l6+2+wue71PMkMqErqv9CIKydYg02Tq0TSfyPe+JA4/ovlOwjvVw8rLd+MyPAF8
         0LvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719501218; x=1720106018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TX0U3b8jimiqgeX357u7GUJDhVKKzDM/foxrwVdpbY=;
        b=K7lgRKydsaygIAPv+DVNsEr917U1BwlYzumv3YrDUj6qw9jXBJsvkaO+laotfQkswX
         dSRtIqtiwXosVqLRs9RTvzfOLX4NxaaHy7l8KlsGya9UfmCR76slJHq5i4WE8ygkQqSO
         WRSPSjlUc94wzfgt5bacZFuH4jGswbKwG1z3miHGU4IM7XuUdEyQ4lXv8M3La5Yrb+hC
         5iq+jA+wPqzXX6peWxYMuZphMsUDoxgpBgLRL1b6hTcOzbh2rBaSTv+L56yp9pfv4cpC
         euXSUPi6VIduG2tPPiGbjAu9AOzIhZBV6DYIIR1o/QdZejmlai1NQ5uo0d1AFhKJORMQ
         tOlA==
X-Gm-Message-State: AOJu0YyH9IZUmQ61uYkKqtbHzbcUOYW9G7EODdhgrjkH8ijT0ATWfkHR
	0i32oM8+rpadfFm2G+JG1qL3qYw/Kj3j/4WOrXi6GXCm5uOwEKbXyHEkKw==
X-Google-Smtp-Source: AGHT+IFh8JIzP8I/wUNs+VVemS0VbJwUYftxYOZiny1wDT7SmoHiD3A24eUzi15kLKeQ4DR0fyCPwA==
X-Received: by 2002:a05:6e02:188a:b0:375:ca62:a418 with SMTP id e9e14a558f8ab-3763f6cd3a9mr203177865ab.22.1719501217817;
        Thu, 27 Jun 2024 08:13:37 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72749854a9fsm1173462a12.92.2024.06.27.08.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 08:13:37 -0700 (PDT)
Date: Thu, 27 Jun 2024 23:13:34 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v5 03/12] fsck: abstract common options for reusing
Message-ID: <Zn2BnsfvzfyMOZNb@ArchLinux>
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

Create "fsck_options" struct to contain the general fields. Change
"fsck_objects_options" to incorporate the general "fsck_options"
and object-speicifc options.

The fsck message will use "strict" option to set the corresponding
"msg_type". Rename the parameter name from "struct fsck_objects_options
*" to "struct fsck_options *".

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c           |  6 +++---
 builtin/index-pack.c     |  4 ++--
 builtin/mktag.c          |  6 +++---
 builtin/unpack-objects.c |  2 +-
 fsck.c                   | 25 ++++++++++++++++---------
 fsck.h                   | 32 ++++++++++++++++++++++----------
 object-file.c            |  4 ++--
 7 files changed, 49 insertions(+), 30 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index ec3220880d..c383125027 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -939,9 +939,9 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	fsck_walk_options.walk = mark_object;
 	fsck_obj_options.walk = mark_used;
-	fsck_obj_options.error_func = fsck_error_func;
+	fsck_obj_options.fsck_options.error_func = fsck_error_func;
 	if (check_strict)
-		fsck_obj_options.strict = 1;
+		fsck_obj_options.fsck_options.strict = 1;
 
 	if (show_progress == -1)
 		show_progress = isatty(2);
@@ -956,7 +956,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	if (name_objects)
 		fsck_enable_object_names(&fsck_walk_options);
 
-	git_config(git_fsck_config, &fsck_obj_options);
+	git_config(git_fsck_config, &fsck_obj_options.fsck_options);
 	prepare_repo_settings(the_repository);
 
 	if (connectivity_only) {
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 08ebeedfd3..360106b0c8 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1770,13 +1770,13 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 			} else if (skip_to_optional_arg(arg, "--strict", &arg)) {
 				strict = 1;
 				do_fsck_object = 1;
-				fsck_set_msg_types(&fsck_objects_options, arg);
+				fsck_set_msg_types(&fsck_objects_options.fsck_options, arg);
 			} else if (!strcmp(arg, "--check-self-contained-and-connected")) {
 				strict = 1;
 				check_self_contained_and_connected = 1;
 			} else if (skip_to_optional_arg(arg, "--fsck-objects", &arg)) {
 				do_fsck_object = 1;
-				fsck_set_msg_types(&fsck_objects_options, arg);
+				fsck_set_msg_types(&fsck_objects_options.fsck_options, arg);
 			} else if (!strcmp(arg, "--verify")) {
 				verify = 1;
 			} else if (!strcmp(arg, "--verify-stat")) {
diff --git a/builtin/mktag.c b/builtin/mktag.c
index be2abc71d8..76860f4c7c 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -91,12 +91,12 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 	if (strbuf_read(&buf, 0, 0) < 0)
 		die_errno(_("could not read from stdin"));
 
-	fsck_objects_options.error_func = mktag_fsck_error_func;
-	fsck_set_msg_type_from_ids(&fsck_objects_options,
+	fsck_objects_options.fsck_options.error_func = mktag_fsck_error_func;
+	fsck_set_msg_type_from_ids(&fsck_objects_options.fsck_options,
 				   FSCK_MSG_EXTRA_HEADER_ENTRY,
 				   FSCK_WARN);
 	/* config might set fsck.extraHeaderEntry=* again */
-	git_config(git_fsck_config, &fsck_objects_options);
+	git_config(git_fsck_config, &fsck_objects_options.fsck_options);
 	if (fsck_tag_standalone(NULL, buf.buf, buf.len, &fsck_objects_options,
 				&tagged_oid, &tagged_type))
 		die(_("tag on stdin did not pass our strict fsck check"));
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index c59e330db9..d8d0b14018 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -635,7 +635,7 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix UNUSED)
 			}
 			if (skip_prefix(arg, "--strict=", &arg)) {
 				strict = 1;
-				fsck_set_msg_types(&fsck_objects_options, arg);
+				fsck_set_msg_types(&fsck_objects_options.fsck_options, arg);
 				continue;
 			}
 			if (starts_with(arg, "--pack_header=")) {
diff --git a/fsck.c b/fsck.c
index 81b93f02fc..7ac6e4587c 100644
--- a/fsck.c
+++ b/fsck.c
@@ -107,7 +107,7 @@ void list_config_fsck_msg_ids(struct string_list *list, const char *prefix)
 }
 
 static enum fsck_msg_type fsck_msg_type(enum fsck_msg_id msg_id,
-					struct fsck_objects_options *options)
+					struct fsck_options *options)
 {
 	assert(msg_id >= 0 && msg_id < FSCK_MSG_MAX);
 
@@ -142,7 +142,7 @@ int is_valid_msg_type(const char *msg_id, const char *msg_type)
 	return 1;
 }
 
-void fsck_set_msg_type_from_ids(struct fsck_objects_options *options,
+void fsck_set_msg_type_from_ids(struct fsck_options *options,
 				enum fsck_msg_id msg_id,
 				enum fsck_msg_type msg_type)
 {
@@ -158,7 +158,7 @@ void fsck_set_msg_type_from_ids(struct fsck_objects_options *options,
 	fsck_configs.msg_type[msg_id] = msg_type;
 }
 
-void fsck_set_msg_type(struct fsck_objects_options *options,
+void fsck_set_msg_type(struct fsck_options *options,
 		       const char *msg_id_str, const char *msg_type_str)
 {
 	int msg_id = parse_msg_id(msg_id_str);
@@ -187,7 +187,7 @@ void fsck_set_msg_type(struct fsck_objects_options *options,
 	free(to_free);
 }
 
-void fsck_set_msg_types(struct fsck_objects_options *options, const char *values)
+void fsck_set_msg_types(struct fsck_options *options, const char *values)
 {
 	char *buf = xstrdup(values), *to_free = buf;
 	int done = 0;
@@ -237,9 +237,16 @@ static int report(struct fsck_objects_options *options,
 {
 	va_list ap;
 	struct strbuf sb = STRBUF_INIT;
-	enum fsck_msg_type msg_type = fsck_msg_type(msg_id, options);
+	struct fsck_options *fsck_options;
+	enum fsck_msg_type msg_type;
 	int result;
 
+	if (options)
+		fsck_options = &options->fsck_options;
+	else
+		BUG("fsck_options is not set");
+
+	msg_type = fsck_msg_type(msg_id, fsck_options);
 	if (msg_type == FSCK_IGNORE)
 		return 0;
 
@@ -256,8 +263,8 @@ static int report(struct fsck_objects_options *options,
 
 	va_start(ap, fmt);
 	strbuf_vaddf(&sb, fmt, ap);
-	result = options->error_func(options, oid, object_type,
-				     msg_type, msg_id, sb.buf);
+	result = fsck_options->error_func(options, oid, object_type,
+					  msg_type, msg_id, sb.buf);
 	strbuf_release(&sb);
 	va_end(ap);
 
@@ -711,7 +718,7 @@ static int fsck_tree(const struct object_id *tree_oid,
 		 * bits..
 		 */
 		case S_IFREG | 0664:
-			if (!options->strict)
+			if (!options->fsck_options.strict)
 				break;
 			/* fallthrough */
 		default:
@@ -1283,7 +1290,7 @@ int fsck_finish(struct fsck_objects_options *options)
 int git_fsck_config(const char *var, const char *value,
 		    const struct config_context *ctx, void *cb)
 {
-	struct fsck_objects_options *options = cb;
+	struct fsck_options *options = cb;
 	const char *msg_id;
 
 	if (strcmp(var, "fsck.skiplist") == 0) {
diff --git a/fsck.h b/fsck.h
index 37deadc4bd..e531b44a66 100644
--- a/fsck.h
+++ b/fsck.h
@@ -92,15 +92,16 @@ enum fsck_msg_id {
 };
 #undef MSG_ID
 
+struct fsck_options;
 struct fsck_objects_options;
 struct object;
 
-void fsck_set_msg_type_from_ids(struct fsck_objects_options *options,
+void fsck_set_msg_type_from_ids(struct fsck_options *options,
 				enum fsck_msg_id msg_id,
 				enum fsck_msg_type msg_type);
-void fsck_set_msg_type(struct fsck_objects_options *options,
+void fsck_set_msg_type(struct fsck_options *options,
 		       const char *msg_id, const char *msg_type);
-void fsck_set_msg_types(struct fsck_objects_options *options, const char *values);
+void fsck_set_msg_types(struct fsck_options *options, const char *values);
 int is_valid_msg_type(const char *msg_id, const char *msg_type);
 
 /*
@@ -131,10 +132,15 @@ int fsck_error_cb_print_missing_gitmodules(struct fsck_objects_options *o,
 					   enum fsck_msg_id msg_id,
 					   const char *message);
 
+struct fsck_options {
+	fsck_error error_func;
+	unsigned verbose:1,
+		 strict:1;
+};
+
 struct fsck_objects_options {
+	struct fsck_options fsck_options;
 	fsck_walk_func walk;
-	fsck_error error_func;
-	unsigned strict:1;
 	struct oidset gitmodules_found;
 	struct oidset gitmodules_done;
 	struct oidset gitattributes_found;
@@ -143,27 +149,33 @@ struct fsck_objects_options {
 };
 
 #define FSCK_OBJECTS_OPTIONS_DEFAULT { \
+	.fsck_options = { \
+		.error_func = fsck_error_function, \
+	}, \
 	.gitmodules_found = OIDSET_INIT, \
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
 	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_error_function \
 }
 #define FSCK_OBJECTS_OPTIONS_STRICT { \
-	.strict = 1, \
+	.fsck_options = { \
+		.error_func = fsck_error_function, \
+		.strict = 1, \
+	}, \
 	.gitmodules_found = OIDSET_INIT, \
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
 	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_error_function, \
 }
 #define FSCK_OBJECTS_OPTIONS_MISSING_GITMODULES { \
-	.strict = 1, \
+	.fsck_options = { \
+		.error_func = fsck_error_cb_print_missing_gitmodules, \
+		.strict = 1, \
+	}, \
 	.gitmodules_found = OIDSET_INIT, \
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
 	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_error_cb_print_missing_gitmodules, \
 }
 
 /* descend in all linked child objects
diff --git a/object-file.c b/object-file.c
index ec44ac3d82..9eda05ee01 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2509,8 +2509,8 @@ static int index_mem(struct index_state *istate,
 	if (flags & HASH_FORMAT_CHECK) {
 		struct fsck_objects_options opts = FSCK_OBJECTS_OPTIONS_DEFAULT;
 
-		opts.strict = 1;
-		opts.error_func = hash_format_check_report;
+		opts.fsck_options.strict = 1;
+		opts.fsck_options.error_func = hash_format_check_report;
 		if (fsck_buffer(null_oid(), type, buf, size, &opts))
 			die(_("refusing to create malformed object"));
 		fsck_finish(&opts);
-- 
2.45.2

