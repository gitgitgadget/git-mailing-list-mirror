Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7408913B5A5
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525209; cv=none; b=vEzhiymtWw4XIxnkBinKtkEjaGuc60DlDPSvpUKVIq50wXvTdBALtkI5051QyehCjI0wCqHx/7nb6phUhLx07JxY3ilAWFxa1Xwz3oyKpqzYFQF/jRAWYupu2Uq1N9kAAgngnh8ZbDhlANs24a853bgB1GDXU33Q+fyv7pQ6eLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525209; c=relaxed/simple;
	bh=hK2rKftTrWOid2HvkeshtVcyXC4+9HkytjFdZ4GLRUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1iDn1ti6FZS3Vw6EEfUq9uoJWfSqB72f19mqzGWU3ee3guF8YPAnDbkeHJGTo9uq7MoaQAL+JJNoafcamYmcCaQpoEguXKvD8m0duzEwCAYqHvgA9LRr5xLubVp3hENCBDE443Ep9h+bh9lIcct9O+dWkK+t30ns8dlOERpKhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/uBUeXq; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/uBUeXq"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc60c3ead4so51956495ad.0
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 08:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722525206; x=1723130006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OEH1VTM2azpMrJWxk7om/YrgqmVLNtPFXWfi2cGKgmM=;
        b=a/uBUeXqg6wPDmbXbMoSDtBFy+ztFp4skSjys07zk2szxjp9IC7NHSKcOkXDbpZehV
         mPJqwTXoekIs1XSXUXVno1SqQwhT+ldAsQln4LYH47zwyZ6Qann8wAc7JukUtYPDKKDg
         vwSxcw/vpwHoV54A1eAh8Y6n4PY+gtkaAF4CX3pw7IMk5NSz4gL1zkXDhZnvEB6XcTof
         cxH674gEFe7InC68M5iTkuifKVIg95oORZkGRdk3tkjsFCxX1/ISQ70GMYKXS2fFh4Jx
         6O11w9fXhjpDVdSgey+T0RbvJO70l1EkG9DdF6wsYyOURW/UWpeu29enkYVQcYR64b7J
         qa8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722525206; x=1723130006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEH1VTM2azpMrJWxk7om/YrgqmVLNtPFXWfi2cGKgmM=;
        b=kN5ZJ3mUQ9ja3ouJ0mkrr/+faOkdYLKv6zQIXdeorwSZ/mIG48mr+mpfngpFyYH8bh
         EWpaAvL+9w0CxqlBSi9R/GF4kxCvm7K4cAoWusioWj0ZctVISFxAhwI8D9JWVmZDY1A0
         BRvT5qBUnbYV1d1UzgMETxki/cbn/tGe68R7+bMw9Wn2B30fO567120/rgwdAawiskOH
         lLmwBrXoytBF6I6aaHiybNt0xhS1FrRTmqnP1z8QGUJgkPCVIlMplSBi3uNd0/yNRKXA
         jhfBZJ4mK/TuZQD91Zqp9u81AM95WTScBw4RX/AmMfFb6bIKsFrYVIDSoi5+rupQ1gYf
         vGRA==
X-Gm-Message-State: AOJu0YyDg5ovDJmqvz52c3SpQbkG1YlBu/Hm9vru05DJSml9jm2t2pVL
	CihJBPdgTOmnW3EAFWLH0ipPw3WSAorYHqpwZqSs8vCT/y+eiYAIxO1fww==
X-Google-Smtp-Source: AGHT+IFKIvvuGtSAAUp8HqdyvzQJMQ+2QX3Ydp1mbtbDH5P9QrughK6B7nQWrbWr71IOXgu66rC0uA==
X-Received: by 2002:a17:903:1245:b0:1fd:88d2:47f6 with SMTP id d9443c01a7336-1ff573e72c6mr5806995ad.38.1722525206262;
        Thu, 01 Aug 2024 08:13:26 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c88bd1sm140638905ad.12.2024.08.01.08.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 08:13:25 -0700 (PDT)
Date: Thu, 1 Aug 2024 23:13:49 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v14 02/11] fsck: make "fsck_error" callback generic
Message-ID: <ZqumLSxEVtkxzzEV@ArchLinux>
References: <ZqulmWVBaeyP4blf@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqulmWVBaeyP4blf@ArchLinux>

The "fsck_error" callback is designed to report the objects-related
error messages. It accepts two parameter "oid" and "object_type" which
is not generic. In order to provide a unified callback which can report
either objects or refs, remove the objects-related parameters and add
the generic parameter "void *fsck_report".

Create a new "fsck_object_report" structure which incorporates the
removed parameters "oid" and "object_type". Then change the
corresponding references to adapt to new "fsck_error" callback.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c  |  7 +++++--
 builtin/mktag.c |  3 +--
 fsck.c          | 20 +++++++++++++-------
 fsck.h          | 17 ++++++++++++-----
 object-file.c   |  9 ++++-----
 5 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index d13a226c2e..9673a08286 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -90,12 +90,15 @@ static int objerror(struct object *obj, const char *err)
 }
 
 static int fsck_error_func(struct fsck_options *o UNUSED,
-			   const struct object_id *oid,
-			   enum object_type object_type,
+			   void *fsck_report,
 			   enum fsck_msg_type msg_type,
 			   enum fsck_msg_id msg_id UNUSED,
 			   const char *message)
 {
+	struct fsck_object_report *report = fsck_report;
+	const struct object_id *oid = report->oid;
+	enum object_type object_type = report->object_type;
+
 	switch (msg_type) {
 	case FSCK_WARN:
 		/* TRANSLATORS: e.g. warning in tree 01bfda: <more explanation> */
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 4767f1a97e..c6b644219f 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -18,8 +18,7 @@ static int option_strict = 1;
 static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
 
 static int mktag_fsck_error_func(struct fsck_options *o UNUSED,
-				 const struct object_id *oid UNUSED,
-				 enum object_type object_type UNUSED,
+				 void *fsck_report UNUSED,
 				 enum fsck_msg_type msg_type,
 				 enum fsck_msg_id msg_id UNUSED,
 				 const char *message)
diff --git a/fsck.c b/fsck.c
index 3f32441492..4c1f8bc44a 100644
--- a/fsck.c
+++ b/fsck.c
@@ -232,6 +232,10 @@ static int report(struct fsck_options *options,
 		  enum fsck_msg_id msg_id, const char *fmt, ...)
 {
 	va_list ap;
+	struct fsck_object_report report = {
+		.oid = oid,
+		.object_type = object_type
+	};
 	struct strbuf sb = STRBUF_INIT;
 	enum fsck_msg_type msg_type = fsck_msg_type(msg_id, options);
 	int result;
@@ -252,7 +256,7 @@ static int report(struct fsck_options *options,
 
 	va_start(ap, fmt);
 	strbuf_vaddf(&sb, fmt, ap);
-	result = options->error_func(options, oid, object_type,
+	result = options->error_func(options, &report,
 				     msg_type, msg_id, sb.buf);
 	strbuf_release(&sb);
 	va_end(ap);
@@ -1201,12 +1205,14 @@ int fsck_buffer(const struct object_id *oid, enum object_type type,
 }
 
 int fsck_error_function(struct fsck_options *o,
-			const struct object_id *oid,
-			enum object_type object_type UNUSED,
+			void *fsck_report,
 			enum fsck_msg_type msg_type,
 			enum fsck_msg_id msg_id UNUSED,
 			const char *message)
 {
+	struct fsck_object_report *report = fsck_report;
+	const struct object_id *oid = report->oid;
+
 	if (msg_type == FSCK_WARN) {
 		warning("object %s: %s", fsck_describe_object(o, oid), message);
 		return 0;
@@ -1304,15 +1310,15 @@ int git_fsck_config(const char *var, const char *value,
  */
 
 int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
-					   const struct object_id *oid,
-					   enum object_type object_type,
+					   void *fsck_report,
 					   enum fsck_msg_type msg_type,
 					   enum fsck_msg_id msg_id,
 					   const char *message)
 {
 	if (msg_id == FSCK_MSG_GITMODULES_MISSING) {
-		puts(oid_to_hex(oid));
+		struct fsck_object_report *report = fsck_report;
+		puts(oid_to_hex(report->oid));
 		return 0;
 	}
-	return fsck_error_function(o, oid, object_type, msg_type, msg_id, message);
+	return fsck_error_function(o, fsck_report, msg_type, msg_id, message);
 }
diff --git a/fsck.h b/fsck.h
index bcfb2e34cd..303174a5d8 100644
--- a/fsck.h
+++ b/fsck.h
@@ -114,23 +114,30 @@ int is_valid_msg_type(const char *msg_id, const char *msg_type);
 typedef int (*fsck_walk_func)(struct object *obj, enum object_type object_type,
 			      void *data, struct fsck_options *options);
 
-/* callback for fsck_object, type is FSCK_ERROR or FSCK_WARN */
+/*
+ * Callback for reporting errors either for objects or refs. The "fsck_report"
+ * is a generic pointer that can be used to pass any information.
+ */
 typedef int (*fsck_error)(struct fsck_options *o,
-			  const struct object_id *oid, enum object_type object_type,
+			  void *fsck_report,
 			  enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
 			  const char *message);
 
 int fsck_error_function(struct fsck_options *o,
-			const struct object_id *oid, enum object_type object_type,
+			void *fsck_report,
 			enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
 			const char *message);
 int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
-					   const struct object_id *oid,
-					   enum object_type object_type,
+					   void *fsck_report,
 					   enum fsck_msg_type msg_type,
 					   enum fsck_msg_id msg_id,
 					   const char *message);
 
+struct fsck_object_report {
+	const struct object_id *oid;
+	enum object_type object_type;
+};
+
 struct fsck_options {
 	fsck_walk_func walk;
 	fsck_error error_func;
diff --git a/object-file.c b/object-file.c
index 065103be3e..05ac6ebed6 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2470,11 +2470,10 @@ int repo_has_object_file(struct repository *r,
  * give more context.
  */
 static int hash_format_check_report(struct fsck_options *opts UNUSED,
-				     const struct object_id *oid UNUSED,
-				     enum object_type object_type UNUSED,
-				     enum fsck_msg_type msg_type UNUSED,
-				     enum fsck_msg_id msg_id UNUSED,
-				     const char *message)
+				    void *fsck_report UNUSED,
+				    enum fsck_msg_type msg_type UNUSED,
+				    enum fsck_msg_id msg_id UNUSED,
+				    const char *message)
 {
 	error(_("object fails fsck: %s"), message);
 	return 1;
-- 
2.45.2

