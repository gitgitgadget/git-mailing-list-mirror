Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB693C24
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 13:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722259583; cv=none; b=sUmKrE9Wmf9tpoMWGnrDNH1gRL9w3AsXEciUttz/PpIJ8BQkYIs3yVf6myjWThuF/cG84sw6i/R1eHcYb/XlDmyKjFRHPwqOqatyDLKx/RK7R0eqkCwq45oyecW3o0lfXQT4dqO6KxmYmYPxFHeAJ3QQR4HwNZnM7kJRo1rOzyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722259583; c=relaxed/simple;
	bh=7ZDa7ZWnNCzQ5A6GUj1Dh3ymoB/Fqh971++EPpuvJkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsQscf/orxDJtBQptev0aZCQgPqRV6B/iuRs+wSqLcxpArpkkS5tsEcPx0w2hgpuMe0U9Uyb8095SMXG8DN+fKN0KBR89+b1qxjWAE5QkhlVcTfbMpBxyEGEW5O14nKw4asML/lCAFsqPOTyzllAxnulwcy4jUPLEUfyu+St/rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9kjzJr3; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9kjzJr3"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2caff99b1c9so1879874a91.3
        for <git@vger.kernel.org>; Mon, 29 Jul 2024 06:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722259581; x=1722864381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bD8c7gQ6DRUtbm73bhNDHnUk3N3GhZN60HOPY+jX8iI=;
        b=W9kjzJr3wyzCuwZGWB1Aw+85iWZxX2Klb3ZmYWMOchj9Wp4gSUd9InH298mrxQ8v5F
         T588jBXHVGL3UEsD5uNGHbMIQ0pyk/7UZAXqP84hdNK3w6gzE4i2ZvEuxljWZJjAtTA+
         TIcxF1yNcAbPZj/zvKK+yUO/+D9v2xkDnEGiVccWaIKYb9us2L9bYjRGB78LChOxUBWh
         lQDGmqIgUlCieifx869HClu74RnFfKKjS0GePGnQlvxd8/dXziiYKYNOqWs3T2EHlGGN
         8/rAQ/2gCe/hgc5vNrqnPYbglQeNl3KQhhiRm5t1uPMY2IVCMzrIpeVRLNR48cGEN8hg
         yxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722259581; x=1722864381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bD8c7gQ6DRUtbm73bhNDHnUk3N3GhZN60HOPY+jX8iI=;
        b=TMR7+GrzDlMM5LgNLBQLs2qIft+VDNKI9Rqrcd0KnY7IaftIAZQiZmDHqmu5jh646T
         lp+soCBHW/Oagk6cwNmSTsgCsnshZpWrLx9VQq1pvRJv2uCFRuyMdRv4tFLcFtgRgzcz
         40lbxjMVYv4A0UEmm51aYnWplVBVYpemq0GotdIgFbvVv2P7CwWcJKt/oxt4sHMu/b23
         cIPidisPEhuGieKQu32F8asKuvmXpvlw+ByxoKAe7Auvptp3N24klpUwNKbUAd4p9PZJ
         w3U7kVt6vHXPbZk5b+vjjn8+3Hj6a+MnZGfxeyr/KF+Z+LX4KiomXjniWgnklo76Q/nM
         EZMQ==
X-Gm-Message-State: AOJu0YyVrsU/aihOcvnHZv1dmdD0tIiQ/CiQfF9v5wQQTucXmXzqs9zi
	J14jk4ELxjeEjBa4w6EVQX1OTZ2itdkwz5bDow4csBNY4vXndqIGUPR6Xw==
X-Google-Smtp-Source: AGHT+IFEzjDW3oDJAKZmm4m+c5uQKg7yeIeKSZfsmxvsWB6sFB0tStDnobYRRaU0oFLB8WHakD0bDA==
X-Received: by 2002:a17:90b:1b44:b0:2cb:4c4f:3280 with SMTP id 98e67ed59e1d1-2cf7e5c15e2mr5268698a91.26.1722259580531;
        Mon, 29 Jul 2024 06:26:20 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28c565besm8497321a91.8.2024.07.29.06.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 06:26:20 -0700 (PDT)
Date: Mon, 29 Jul 2024 21:26:40 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v13 03/10] fsck: rename objects-related fsck error
 functions
Message-ID: <ZqeYkP5YiISbMrrN@ArchLinux>
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

The names of objects-related fsck error functions are general. It's OK
when there is only object database check. However, we have introduced
refs database check report function. To avoid ambiguity, rename
object-related fsck error functions to explicitly indicate these
functions are used to report objects-related messages.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c | 16 ++++++++--------
 fsck.c         | 32 ++++++++++++++++----------------
 fsck.h         | 30 +++++++++++++++---------------
 3 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 6abad60e7e..8553e2bc1b 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -89,13 +89,13 @@ static int objerror(struct object *obj, const char *err)
 	return -1;
 }
 
-static int fsck_error_func(struct fsck_options *o UNUSED,
-			   const struct object_id *oid,
-			   enum object_type object_type,
-			   const struct fsck_refs_info *refs_info UNUSED,
-			   enum fsck_msg_type msg_type,
-			   enum fsck_msg_id msg_id UNUSED,
-			   const char *message)
+static int fsck_objects_error_func(struct fsck_options *o UNUSED,
+				   const struct object_id *oid,
+				   enum object_type object_type,
+				   const struct fsck_refs_info *refs_info UNUSED,
+				   enum fsck_msg_type msg_type,
+				   enum fsck_msg_id msg_id UNUSED,
+				   const char *message)
 {
 	switch (msg_type) {
 	case FSCK_WARN:
@@ -939,7 +939,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	fsck_walk_options.walk = mark_object;
 	fsck_obj_options.walk = mark_used;
-	fsck_obj_options.error_func = fsck_error_func;
+	fsck_obj_options.error_func = fsck_objects_error_func;
 	if (check_strict)
 		fsck_obj_options.strict = 1;
 
diff --git a/fsck.c b/fsck.c
index 1185e9a8ad..af61fa90ba 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1235,13 +1235,13 @@ int fsck_buffer(const struct object_id *oid, enum object_type type,
 		      type);
 }
 
-int fsck_error_function(struct fsck_options *o,
-			const struct object_id *oid,
-			enum object_type object_type UNUSED,
-			const struct fsck_refs_info *refs_info UNUSED,
-			enum fsck_msg_type msg_type,
-			enum fsck_msg_id msg_id UNUSED,
-			const char *message)
+int fsck_objects_error_function(struct fsck_options *o,
+				const struct object_id *oid,
+				enum object_type object_type UNUSED,
+				const struct fsck_refs_info *refs_info UNUSED,
+				enum fsck_msg_type msg_type,
+				enum fsck_msg_id msg_id UNUSED,
+				const char *message)
 {
 	if (msg_type == FSCK_WARN) {
 		warning("object %s: %s", fsck_describe_object(o, oid), message);
@@ -1339,18 +1339,18 @@ int git_fsck_config(const char *var, const char *value,
  * Custom error callbacks that are used in more than one place.
  */
 
-int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
-					   const struct object_id *oid,
-					   enum object_type object_type,
-					   const struct fsck_refs_info *refs_info,
-					   enum fsck_msg_type msg_type,
-					   enum fsck_msg_id msg_id,
-					   const char *message)
+int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
+						   const struct object_id *oid,
+						   enum object_type object_type,
+						   const struct fsck_refs_info *refs_info,
+						   enum fsck_msg_type msg_type,
+						   enum fsck_msg_id msg_id,
+						   const char *message)
 {
 	if (msg_id == FSCK_MSG_GITMODULES_MISSING) {
 		puts(oid_to_hex(oid));
 		return 0;
 	}
-	return fsck_error_function(o, oid, object_type, refs_info,
-				   msg_type, msg_id, message);
+	return fsck_objects_error_function(o, oid, object_type, refs_info,
+					   msg_type, msg_id, message);
 }
diff --git a/fsck.h b/fsck.h
index 4f01a46cc7..f53ac339d2 100644
--- a/fsck.h
+++ b/fsck.h
@@ -124,18 +124,18 @@ typedef int (*fsck_error)(struct fsck_options *o,
 			  enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
 			  const char *message);
 
-int fsck_error_function(struct fsck_options *o,
-			const struct object_id *oid, enum object_type object_type,
-			const struct fsck_refs_info *refs_info,
-			enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
-			const char *message);
-int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
-					   const struct object_id *oid,
-					   enum object_type object_type,
-					   const struct fsck_refs_info *refs_info,
-					   enum fsck_msg_type msg_type,
-					   enum fsck_msg_id msg_id,
-					   const char *message);
+int fsck_objects_error_function(struct fsck_options *o,
+				const struct object_id *oid, enum object_type object_type,
+				const struct fsck_refs_info *refs_info,
+				enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
+				const char *message);
+int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
+						   const struct object_id *oid,
+						   enum object_type object_type,
+						   const struct fsck_refs_info *refs_info,
+						   enum fsck_msg_type msg_type,
+						   enum fsck_msg_id msg_id,
+						   const char *message);
 
 /*
  * The information for reporting refs-related error message
@@ -163,7 +163,7 @@ struct fsck_options {
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
 	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_error_function \
+	.error_func = fsck_objects_error_function \
 }
 #define FSCK_OPTIONS_STRICT { \
 	.strict = 1, \
@@ -171,7 +171,7 @@ struct fsck_options {
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
 	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_error_function, \
+	.error_func = fsck_objects_error_function, \
 }
 #define FSCK_OPTIONS_MISSING_GITMODULES { \
 	.strict = 1, \
@@ -179,7 +179,7 @@ struct fsck_options {
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
 	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_error_cb_print_missing_gitmodules, \
+	.error_func = fsck_objects_error_cb_print_missing_gitmodules, \
 }
 
 /* descend in all linked child objects
-- 
2.45.2

