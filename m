Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5DB40847
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 09:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721467662; cv=none; b=BUvPOMovV/iMsOd4CI7s9hlIbYbkK4ts14YyhIZJh1Xr0tGEJDeUHJKYLO7IdRXkkJmMQuhmwn5ouXM58QX8aKzKkA0UyhS8tRR+QhkaJJCnxHFA9v8BNnFxiO7YZFPNL+OTdCJsxVhKitKc9cjCYjVGqlGCikZa4sWGmrsLtog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721467662; c=relaxed/simple;
	bh=/8gPCmRaiPNQlMEZUwNHkzf6KWxbg72phA1Tk2bdMDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLZakodGlGpxH7RqfLwzGFmcD3jgtxBinn/ppKM2hA2gcmjmXzPjAUIwLd4rPqHqY0evDgjElwl3P1cCuQiY/if30ZPb48fTvO+KFRdo/2BkgYtJStdCDV007OfltuY56R/5jVSXXcwONEn+9HzI8YAbpUGPe4AQV43JmsevsrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDff17mZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDff17mZ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fb8781ef1bso22140055ad.3
        for <git@vger.kernel.org>; Sat, 20 Jul 2024 02:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721467659; x=1722072459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v36/1gT1sTivk2ZeIYYkaW9wHb7A7rKQJpHvYGuc83s=;
        b=UDff17mZIpKB4w03xQvLfwiYmKX5DhHWnFD8MQcc8Wn21LXN0fkMdSPJkRuMEqKHxc
         cn8fq+6I8dvsPswnTwVp1pvriQFeCk9ASCC0Pw+uuVtCktE4Xz/JWKJxTaJAguecB9yb
         tA7Mv6De6EPPW6G8dAyUFNbwfoVGXF4O4wRyDedI6rhyHnQCXvMtlygOagOhtjieug8i
         7Y4QaxNQGKlM7Mpn/MRV2zgc6c4a/K3BFJCRrRQ/gPkEWnM5ur/pc9e5FgkRIENPBvXF
         Yheqscc+eywLFGdjLl24sqoJN0CYr06FOHPcQMXzNl0kkWq7kQWyV1WKkhm63goEOfeG
         3yAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721467659; x=1722072459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v36/1gT1sTivk2ZeIYYkaW9wHb7A7rKQJpHvYGuc83s=;
        b=Rpxc4ia6jdzSzQKcZQIlY1QOfXWyScdVoi8SDn3D9IoYAzGVY7RdQ7xfgGKrMiUMDp
         nJIOBBPsivfqdg/d8/1MMLCJZFuE9Gym+0sn3yh0otFv2vlP3LKy0ByQYUXA2JotXmrH
         zjjO949q3yHpKEM1Gpto1U72J+RCVxwLxTE5i2Z3RKVra4wqfwStSNE4KwsOb65b6OYw
         MC0aBNdGM1Mm2khRzXikLB9ShlhvkkGhPlEvzZkxOd2pEX1jaeeRNs563tR6vUpGiqlS
         c7YF8xvKgEA211xprBgz8dL6NkLTCRlFbPUsU83cUc+c0CZNhjPgWl2FKZsTxyK8eM/m
         tjbw==
X-Gm-Message-State: AOJu0Yx6kInwRbvr7M70DMl55dO6LetzlnOQNC/x2M6l2lRcF7FQVgZN
	M5UyaG/uagNx5G70GFUigtPGTNVZePcF9q1Y9c/Q+KfwoBNQwhPnC414Qg==
X-Google-Smtp-Source: AGHT+IHLzj8OAMufgQDLp1pc1U1HGySnrrnmIAJTPr0aG+x2XIb5PZeJ39FzVeWguFc+Thdzjl/IGw==
X-Received: by 2002:a17:902:e547:b0:1fc:72f5:43b6 with SMTP id d9443c01a7336-1fd74554a16mr15116665ad.20.1721467659459;
        Sat, 20 Jul 2024 02:27:39 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f4530cbsm18038885ad.221.2024.07.20.02.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 02:27:38 -0700 (PDT)
Date: Sat, 20 Jul 2024 17:27:49 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v12 03/10] fsck: rename objects-related fsck error
 functions
Message-ID: <ZpuDFUL7D3GQV8EO@ArchLinux>
References: <ZpuCg1GL1YE_sJBP@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpuCg1GL1YE_sJBP@ArchLinux>

The names of objects-related fsck error functions are general. It's OK
when there is only object database check. However, we have introduced
refs database check report function. To avoid ambiguity, rename
object-related fsck error functions to explicitly indicate these
functions are used to report objects-related messages.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c | 14 +++++++-------
 fsck.c         | 27 ++++++++++++++-------------
 fsck.h         | 26 +++++++++++++-------------
 3 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index d13a226c2e..6d86bbe1e9 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -89,12 +89,12 @@ static int objerror(struct object *obj, const char *err)
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
+				   enum fsck_msg_type msg_type,
+				   enum fsck_msg_id msg_id UNUSED,
+				   const char *message)
 {
 	switch (msg_type) {
 	case FSCK_WARN:
@@ -938,7 +938,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	fsck_walk_options.walk = mark_object;
 	fsck_obj_options.walk = mark_used;
-	fsck_obj_options.error_func = fsck_error_func;
+	fsck_obj_options.error_func = fsck_objects_error_func;
 	if (check_strict)
 		fsck_obj_options.strict = 1;
 
diff --git a/fsck.c b/fsck.c
index f2417e65fd..9a7e3d8679 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1232,12 +1232,12 @@ int fsck_buffer(const struct object_id *oid, enum object_type type,
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
+				enum fsck_msg_type msg_type,
+				enum fsck_msg_id msg_id UNUSED,
+				const char *message)
 {
 	if (msg_type == FSCK_WARN) {
 		warning("object %s: %s", fsck_describe_object(o, oid), message);
@@ -1335,16 +1335,17 @@ int git_fsck_config(const char *var, const char *value,
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
+						   enum fsck_msg_type msg_type,
+						   enum fsck_msg_id msg_id,
+						   const char *message)
 {
 	if (msg_id == FSCK_MSG_GITMODULES_MISSING) {
 		puts(oid_to_hex(oid));
 		return 0;
 	}
-	return fsck_error_function(o, oid, object_type, msg_type, msg_id, message);
+	return fsck_objects_error_function(o, oid, object_type,
+					   msg_type, msg_id, message);
 }
diff --git a/fsck.h b/fsck.h
index a2ecb39b51..6411437334 100644
--- a/fsck.h
+++ b/fsck.h
@@ -122,16 +122,16 @@ typedef int (*fsck_error)(struct fsck_options *o,
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
+				enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
+				const char *message);
+int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
+						   const struct object_id *oid,
+						   enum object_type object_type,
+						   enum fsck_msg_type msg_type,
+						   enum fsck_msg_id msg_id,
+						   const char *message);
 
 /*
  * The information for reporting refs-related error message
@@ -165,7 +165,7 @@ struct fsck_options {
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
 	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_error_function \
+	.error_func = fsck_objects_error_function \
 }
 #define FSCK_OPTIONS_STRICT { \
 	.strict = 1, \
@@ -173,7 +173,7 @@ struct fsck_options {
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
 	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_error_function, \
+	.error_func = fsck_objects_error_function, \
 }
 #define FSCK_OPTIONS_MISSING_GITMODULES { \
 	.strict = 1, \
@@ -181,7 +181,7 @@ struct fsck_options {
 	.gitmodules_done = OIDSET_INIT, \
 	.gitattributes_found = OIDSET_INIT, \
 	.gitattributes_done = OIDSET_INIT, \
-	.error_func = fsck_error_cb_print_missing_gitmodules, \
+	.error_func = fsck_objects_error_cb_print_missing_gitmodules, \
 }
 
 /* descend in all linked child objects
-- 
2.45.2

