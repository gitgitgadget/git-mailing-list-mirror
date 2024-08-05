Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456A215DBD5
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722876331; cv=none; b=XDKQBkxELXmTfPajpQYO2zAGviXzT6L4SYYRGZFMxFL2JPjtXZ3lFNrb6zG5VQoGiC/gzeQlcVOLnw6T2xLdIzmqS5qiVYJmSIyFKvIFmfqyR32xCSZ3UpeGLUFiBeirakYmmMu/dJ0JShgJgCY58+lLHZLPRuvuNKEbgsOnN5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722876331; c=relaxed/simple;
	bh=R3lgi6f9YZ2Fv+CgFnJqQX/2pLjRLr88tAvX3zh4K7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYEfOL2wG1GDXiwt+2y7yZmxMGCkzJXTWVoP+PuwYp15mHaE7PAW1x4VYme9a8g8TzbndLESmbcFKtlNjeQ4WgHqmQY+uZnw3AIHvd4wxwoXa20AyVB6njPfke+GlsVgPWhT6mq9YDyy9RjEdfV9iGT3ZxPq4moeVPbrS65/0EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAaMFV9e; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAaMFV9e"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ff4fa918afso30113425ad.1
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 09:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722876329; x=1723481129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g2QmbXhbiit5sMyfK14M78CBQMgETwqJePurU9Qll7Q=;
        b=ZAaMFV9eLEOYlucyPCcXWzLkriwGTqnW5GlAbmITR8qptIX6KLDZWFLlHiROru+68a
         /0e72admGZvLGGs71BivuR5OTxXFagPFllagt3vdE06Wa5e/bQ3DUscG4iEmIV/FFbX3
         aH080nR0r6nQZZOFLbs1NSCJHMufscxpDq3LP93lnY8Vpv0uPbHiue3QYyLiIEcbbIMm
         YVK2deZw9DxCT0PXd977r87dbE7GUPYBfb9rPgH6gLPaMbo3N2X++EGEPKv3XCcfFJUn
         vm5AlSR/ccC5UKxwJB7jbXpilotH5h+9d4Rb4pEXsrewcaiew6k9LzwphAF8I2FhdlMw
         fmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722876329; x=1723481129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2QmbXhbiit5sMyfK14M78CBQMgETwqJePurU9Qll7Q=;
        b=QRw1mysQTSi954yq9N3O/zDUnKu1WXgQH0m8TWhJkhgGfporz/6KC8e5Ep6N3RMB51
         x6omI/vp+RhMShFE6vJN7S/jG5GNiwMStiYNYK/YxJ0YbytvpPGZ4p9gsbClhPv6gtXa
         WYol9sSBGHB3+/YhEfS3EQ3eTtuiOBzki5x06HayE1/WGq1K8A5bcelTV+WV4FfqeUNg
         0vOfYtsV6jmZ1DbWpx1q8Q4J+Ee4M6fVdBnGt7jk3sYDf0ttskgV4Nf+vBlCgHcL0iZa
         PHxfVH+ZN8EJva7AD0gMzX8HD3P3hmyJUGfGGVHuctutk6T6z8TYlVHoWmukYPhWJyvx
         wCRg==
X-Gm-Message-State: AOJu0YxPYecBa9knUPULtOsm8Vf5UJ9ZI+vDrCE1y+I8n4dBuXR8FeOO
	RBj1E+aIMwEIcFe9ANPP9LPG9DizTm2RhfehN+cfO8sAs0iUPdMRXnto/A==
X-Google-Smtp-Source: AGHT+IEva0CrULfFdtIKoY3ZgZeOZxvrk8a8G4Ca4bg7KQ/1z6l70C4E4wyJZ3tL/2aUZAkntkM1oA==
X-Received: by 2002:a17:902:d492:b0:1fb:8419:8384 with SMTP id d9443c01a7336-1ff5722d6e9mr117464455ad.13.1722876329056;
        Mon, 05 Aug 2024 09:45:29 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59175d2csm70220615ad.212.2024.08.05.09.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 09:45:28 -0700 (PDT)
Date: Tue, 6 Aug 2024 00:45:57 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v15 5/9] fsck: add refs report function
Message-ID: <ZrEBxYagfzAfZKVJ@ArchLinux>
References: <ZrEBKjzbyxtMdCCx@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrEBKjzbyxtMdCCx@ArchLinux>

Introduce a new struct "fsck_ref_report" to contain the information we
need when reporting refs-related messages.

With the new "fsck_vreport" function, add a new function
"fsck_report_ref" to report refs-related fsck error message. Unlike
"report" function uses the exact parameters, we simply pass "struct
fsck_ref_report *report" as the parameter. This is because at current we
don't know exactly how many fields we need. By passing this parameter,
we don't need to change this function prototype when we want to add more
information into "fsck_ref_report".

We have introduced "fsck_report_ref" function to report the error
message for refs. We still need to add the corresponding callback
function. Create refs-specific "error_func" callback
"fsck_refs_error_function".

Last, add "FSCK_REFS_OPTIONS_DEFAULT" macro to create default options
when checking ref consistency.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 fsck.c | 41 +++++++++++++++++++++++++++++++++++++++++
 fsck.h | 25 +++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/fsck.c b/fsck.c
index 3614aa56a3..38554b626e 100644
--- a/fsck.c
+++ b/fsck.c
@@ -280,6 +280,19 @@ static int report(struct fsck_options *options,
 	return result;
 }
 
+int fsck_report_ref(struct fsck_options *options,
+		    struct fsck_ref_report *report,
+		    enum fsck_msg_id msg_id,
+		    const char *fmt, ...)
+{
+	va_list ap;
+	int result;
+	va_start(ap, fmt);
+	result = fsck_vreport(options, report, msg_id, fmt, ap);
+	va_end(ap);
+	return result;
+}
+
 void fsck_enable_object_names(struct fsck_options *options)
 {
 	if (!options->object_names)
@@ -1237,6 +1250,34 @@ int fsck_objects_error_function(struct fsck_options *o,
 	return 1;
 }
 
+int fsck_refs_error_function(struct fsck_options *options UNUSED,
+			     void *fsck_report,
+			     enum fsck_msg_type msg_type,
+			     enum fsck_msg_id msg_id UNUSED,
+			     const char *message)
+{
+	struct fsck_ref_report *report = fsck_report;
+
+	struct strbuf sb = STRBUF_INIT;
+	int ret = 0;
+
+	strbuf_addstr(&sb, report->path);
+
+	if (report->oid)
+		strbuf_addf(&sb, " -> (%s)", oid_to_hex(report->oid));
+	else if (report->referent)
+		strbuf_addf(&sb, " -> (%s)", report->referent);
+
+	if (msg_type == FSCK_WARN)
+		warning("%s: %s", sb.buf, message);
+	else
+		ret = error("%s: %s", sb.buf, message);
+
+	strbuf_release(&sb);
+	return ret;
+
+}
+
 static int fsck_blobs(struct oidset *blobs_found, struct oidset *blobs_done,
 		      enum fsck_msg_id msg_missing, enum fsck_msg_id msg_type,
 		      struct fsck_options *options, const char *blob_type)
diff --git a/fsck.h b/fsck.h
index 3b80d02506..2002590f60 100644
--- a/fsck.h
+++ b/fsck.h
@@ -133,11 +133,23 @@ int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
 						   enum fsck_msg_id msg_id,
 						   const char *message);
 
+int fsck_refs_error_function(struct fsck_options *options,
+			     void *fsck_report,
+			     enum fsck_msg_type msg_type,
+			     enum fsck_msg_id msg_id,
+			     const char *message);
+
 struct fsck_object_report {
 	const struct object_id *oid;
 	enum object_type object_type;
 };
 
+struct fsck_ref_report {
+	const char *path;
+	const struct object_id *oid;
+	const char *referent;
+};
+
 struct fsck_options {
 	fsck_walk_func walk;
 	fsck_error error_func;
@@ -175,6 +187,9 @@ struct fsck_options {
 	.gitattributes_done = OIDSET_INIT, \
 	.error_func = fsck_objects_error_cb_print_missing_gitmodules, \
 }
+#define FSCK_REFS_OPTIONS_DEFAULT { \
+	.error_func = fsck_refs_error_function, \
+}
 
 /* descend in all linked child objects
  * the return value is:
@@ -216,6 +231,16 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
  */
 int fsck_finish(struct fsck_options *options);
 
+/*
+ * Report an error or warning for refs.
+ */
+__attribute__((format (printf, 4, 5)))
+int fsck_report_ref(struct fsck_options *options,
+		    struct fsck_ref_report *report,
+		    enum fsck_msg_id msg_id,
+		    const char *fmt, ...);
+
+
 /*
  * Subsystem for storing human-readable names for each object.
  *
-- 
2.46.0

