Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC1E20312
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720622829; cv=none; b=ebtelvA8/pUXYUQum7OTLbR5V0LCyUkv5LnXekHxFV9I+24Jx7QndcJunFQkFUOKd6cEKw6KhdzAWyWwej60ubi0aFKAKUwSNii7UE5V52SK6dW5OqCSYK3eLensSvqME6YZhwOw+X4DqFQ9Irhfh7CW7DZbTzU8AwPN9GE0uk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720622829; c=relaxed/simple;
	bh=BKzhepDcYVwoFgmS2FyQgAmUFL24H9/LTkXDKtYwQ0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K92mO8YS3vSiO4SJTfiOeZdZLTFh4y4ukeuPeiVl6u+zorsTdxh6RJn1G0GKe7Cr075WWXahBKmmNs8vwoNaOvQqoOGJE/PHWOw6hs8mN0aHDScrrcB9sxgywDNvqPHJlQQLq6uTn/bSnt2qQWOr5pHUR2qZln7/Cpq6EMRDy5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Emho79Ck; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Emho79Ck"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fb64d627b0so22121205ad.0
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 07:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720622827; x=1721227627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ae8m2EBfWBW2Zzi/3R7qemJxNOx8Gz9LCWYj9bXbtTw=;
        b=Emho79CkEuGZf+CjyQ26yX+Yz9s9ft6fL1Pl4d4QmZbEACnnTdN6jfRpreon/uVmvX
         CRMPwrRy4yqpw6yeA9d6A4SToc+PLLmcLmHX1+LnfAxWOXflB+oSubKMTT1iqq4novtY
         S0R/6dQyLQ+rV/J0F3yYZ3oA6kinVdVoHPSJC+uA3kXvw2eKyYuqSFyVJixkWj4ig7Qd
         UgzsGgDg5KC8RHXs5ISN5rPk8exU6efK5hYdehLXki2WEGpYlkm81GrbrevKeahAaLS4
         HcvjdvACU5c/4kM1yN5UE2U/mP1GKjr6TORmLi54h+5bdH+xJvIMnBASux+rkYBhqI6b
         9saw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720622827; x=1721227627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ae8m2EBfWBW2Zzi/3R7qemJxNOx8Gz9LCWYj9bXbtTw=;
        b=SPjvI35iHhXw6TzZpg7KF3ZJ61a0YlnaY5eWPFwi1zzJd3Hor/yv44b5SccPUOq1/Q
         4z2CXiCkWA4+GaMMo8eJBjELlmuWYSbq4yUGRnVIWuSY+27qVBq3amma48wKWAQwXC4S
         ieZZ9C1KxXzKLhuhCI8RBT4UrsCmce9HX5CruRs0xJHsWZO7dWUWbaHX1snh8+jBgimO
         hHgHB5xCG5fuY7zlhLCbNDxcIig1EZStLYVMt6W5HL9zMnx0zmrT1vqHxS5fK/72nIR0
         X7De4+m+3wVnVyoliHCDNVcjD1NqILmOSPvbpH/bG41diB71dMeqMvTo/+G44qHClxa8
         OYcA==
X-Gm-Message-State: AOJu0Yx9yus71m2NQcR8OcwoJIJow4nMjCbksOvscHl3xvLG7wslfAcq
	SUhmaA9vxi6TBFb0VQXyOYrDcL2kZpL0KXxwuLaicDoyizvsY8oL3SHuCA==
X-Google-Smtp-Source: AGHT+IFxBVbwCSqdNIfOpOi212qYAbqz9x/N29O2+WX6zFww2TbPT4dcpZVfcPWfxcqBtjj+CqeSfg==
X-Received: by 2002:a17:902:d552:b0:1fb:90bd:afc2 with SMTP id d9443c01a7336-1fbb6d2516emr40383665ad.36.1720622826637;
        Wed, 10 Jul 2024 07:47:06 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6acf63fsm34394795ad.268.2024.07.10.07.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 07:47:06 -0700 (PDT)
Date: Wed, 10 Jul 2024 22:47:07 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v10 03/10] fsck: add a unified interface for reporting
 fsck messages
Message-ID: <Zo6e61kSAvuvBvBS@ArchLinux>
References: <Zo6eJi8BePrQxTQV@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo6eJi8BePrQxTQV@ArchLinux>

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
 builtin/fsck.c  |  1 +
 builtin/mktag.c |  1 +
 fsck.c          | 56 +++++++++++++++++++++++++++++++++++++++++--------
 fsck.h          | 17 ++++++++++++++-
 object-file.c   | 11 +++++-----
 5 files changed, 71 insertions(+), 15 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 6d86bbe1e9..de34538c4f 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -92,6 +92,7 @@ static int objerror(struct object *obj, const char *err)
 static int fsck_objects_error_func(struct fsck_options *o UNUSED,
 				   const struct object_id *oid,
 				   enum object_type object_type,
+				   const char *checked_ref_name UNUSED,
 				   enum fsck_msg_type msg_type,
 				   enum fsck_msg_id msg_id UNUSED,
 				   const char *message)
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
index 0aaff7f635..e1819964e3 100644
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
@@ -1203,6 +1239,7 @@ int fsck_buffer(const struct object_id *oid, enum object_type type,
 int fsck_objects_error_function(struct fsck_options *o,
 				const struct object_id *oid,
 				enum object_type object_type UNUSED,
+				const char *checked_ref_name UNUSED,
 				enum fsck_msg_type msg_type,
 				enum fsck_msg_id msg_id UNUSED,
 				const char *message)
@@ -1306,6 +1343,7 @@ int git_fsck_config(const char *var, const char *value,
 int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
 						   const struct object_id *oid,
 						   enum object_type object_type,
+						   const char *checked_ref_name,
 						   enum fsck_msg_type msg_type,
 						   enum fsck_msg_id msg_id,
 						   const char *message)
@@ -1314,6 +1352,6 @@ int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
 		puts(oid_to_hex(oid));
 		return 0;
 	}
-	return fsck_objects_error_function(o, oid, object_type,
+	return fsck_objects_error_function(o, oid, object_type, checked_ref_name,
 					   msg_type, msg_id, message);
 }
diff --git a/fsck.h b/fsck.h
index 41ebebbb59..f88e5faa94 100644
--- a/fsck.h
+++ b/fsck.h
@@ -114,19 +114,24 @@ int is_valid_msg_type(const char *msg_id, const char *msg_type);
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
 
 int fsck_objects_error_function(struct fsck_options *o,
 				const struct object_id *oid, enum object_type object_type,
+				const char *checked_ref_name,
 				enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
 				const char *message);
 int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
 						   const struct object_id *oid,
 						   enum object_type object_type,
+						   const char *checked_ref_name,
 						   enum fsck_msg_type msg_type,
 						   enum fsck_msg_id msg_id,
 						   const char *message);
@@ -209,6 +214,16 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
  */
 int fsck_finish(struct fsck_options *options);
 
+/*
+ * Report an error or warning for refs.
+ */
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

