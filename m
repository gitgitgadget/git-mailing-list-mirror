Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E6940847
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 09:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721467671; cv=none; b=RFPkpd7S9+wXpgW2zCfyKydj2mi178EQy0tW+A82UXa31kujAeQaQL5tPDi/JXNzSbe7yOd9ozEpo38fXdETU/OEPwJvc22PUTh0RbRg/LNJuhqipplmRJc7i2OA1wuW5uzzesvmK/BBXT7SKXZwXGfg5b+Vlt+qvvJS35uci8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721467671; c=relaxed/simple;
	bh=Z2BbhBVeUKXRMN4iyitxtU0FNaDv3kizlZWJUjEcu8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1IXKajdBEAIudMwZM3gOu7qD+146C+PQ+wqf92xszkNbZik6iFNOi3Irt1sujMQqWpd6ODm8iYgx3YOs5pgL4UrRCIl/AguatYKkKAu6ssDncuaW+f2EmU5cft3bhIKwbK67abaUMj+NgNyoTAksl3Wjt3gWbUb2bm4TQ5zKoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlGW+Xjg; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlGW+Xjg"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fd6ed7688cso8812375ad.3
        for <git@vger.kernel.org>; Sat, 20 Jul 2024 02:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721467669; x=1722072469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GkX743KsJODa2s7UXmorzi4228aW7WaxboyE7KRIgUw=;
        b=SlGW+XjgmB7qCpJ5yj4/uKhMNqv5DvV2vK780YGb9nmbNQIo1f4y4bOZDA6HpBlFPS
         5fXkJT6KqcwJ2dJ6T4VZBiHGbWaEveSgp6Jb9d9fIBuGJLMEYseEUzFYPSe0IiOBO53B
         ADEF9Pn7L3Sz3tUWAP4vl1uORTbuaBLPZ737UaOra5v47Ft1M6PQaVQxSuNPNXiyGVfJ
         r3hdajkY0GzBCkjZlCxF38jNxm1uTug/CB4CV4KZn03N0uEuZ8Tp+ZsRsIHmRT2ViWYa
         /4sAhpGh5vkJ1ZkwxW1w7nXS4G4HyPAhLHtiTUGtqoZa44o5rOTQ7PNzf429r+r5MVop
         pWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721467669; x=1722072469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkX743KsJODa2s7UXmorzi4228aW7WaxboyE7KRIgUw=;
        b=DAd8NjC6rT7H85T5I31GezOuci9tUgHY2JMXac9eZylQR5WKXL377yWkKxV8g9h+Tt
         IUg1CL8hLy1mfx3GlLXjB2GIjHPPCN1+S3X4UUfhRf7uaHBOo8FtsQwlnosMhQNt0372
         vHfERvBXS70+VGsZqYKxz06XYRj0j8cVxsry0HhVzvrzMoEdVOI22XWnH5gzX4/0bAwT
         Xnxly5wGTWYjuzHQDYHSrhatJF0KhSRvGQ2Re45F1Ce710oXdmkpnJQ/X7zt1BHxIf2M
         J1wWD7048fibxcMQYlpN8UxSV1PHjMdpDzSzv/8TlE1uvbLn1cp+vCKRdHH+ph6IvHsf
         F0xA==
X-Gm-Message-State: AOJu0YwwtQ7DcCV82F9xYnbq6E6YB03qZd4i72ARv19YRAmhBr1s7iHp
	pVfX+dGqydP5oJepuF/uQz/kBL15CuIa+Gg6CU1r44YQ4L6rUHSRdr/DBw==
X-Google-Smtp-Source: AGHT+IF5YJwy05PowMTKLVWTAryU+2IaLKgT28ES6PRnYAhZlpPGSHs2P9C/1Iuh4eHywe5inIgvpw==
X-Received: by 2002:a17:902:ea04:b0:1fd:7e56:e108 with SMTP id d9443c01a7336-1fd7e56e494mr5106405ad.25.1721467669287;
        Sat, 20 Jul 2024 02:27:49 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f47895asm17936965ad.270.2024.07.20.02.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 02:27:48 -0700 (PDT)
Date: Sat, 20 Jul 2024 17:28:00 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v12 04/10] fsck: add refs-related error report function
Message-ID: <ZpuDIKyxF5z8kbAK@ArchLinux>
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

Create refs-specific "error_func" callback "fsck_refs_error_function"
which could provide the following report messages for files backend

1. "ref_checkee": "fsck error name": "user message".
2. "ref_checkee.sub_ref_checkee": "fsck error name": "user message".
3. "ref_checkee -> (oid hex)": "fsck error name": "user message".
4. "ref_checkee.sub_ref_checkee -> (oid hex)": "fsck error name": "user
   message".

"fsck_refs_error_function" uses the "ref_checkee" and "sub_ref_checkee"
in the "fsck_refs_info" to indicate the information of the checked refs.
For loose ref and reflog, it only uses the "ref_checkee". For packed
refs and reftable refs, when checking the consistency of the file
itself, it still only uses "ref_checkee". However, when checking the
consistency of the ref or reflog contained in the file ,it will use the
"sub_ref_checkee" to indicate that we are not checking the file but the
incorporated ref or reflog.

"fsck_refs_error_function" will use the "oid" parameter if the caller
passes the oid, it will use "oid_to_hex" to get the corresponding hex
value to report to the caller.

Last, add "FSCK_REFS_OPTIONS_DEFAULT" and "FSCK_REFS_OPTIONS_STRICT"
macros to create refs options easily.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 fsck.c | 29 +++++++++++++++++++++++++++++
 fsck.h | 13 +++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/fsck.c b/fsck.c
index 9a7e3d8679..e87b13fdc3 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1247,6 +1247,35 @@ int fsck_objects_error_function(struct fsck_options *o,
 	return 1;
 }
 
+int fsck_refs_error_function(struct fsck_options *options,
+			     const struct object_id *oid,
+			     enum object_type object_type UNUSED,
+			     enum fsck_msg_type msg_type,
+			     enum fsck_msg_id msg_id UNUSED,
+			     const char *message)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct fsck_refs_info *refs_info = &options->refs_info;
+	int ret = 0;
+
+	if (the_repository->ref_storage_format == REF_STORAGE_FORMAT_FILES) {
+		strbuf_addstr(&sb, refs_info->ref_checkee);
+		if (refs_info->u.files.sub_ref_checkee)
+			strbuf_addf(&sb, ".%s", refs_info->u.files.sub_ref_checkee);
+
+		if (oid)
+			strbuf_addf(&sb, " -> (%s)", oid_to_hex(oid));
+	}
+
+	if (msg_type == FSCK_WARN)
+		warning("%s: %s", sb.buf, message);
+	else
+		ret = error("%s: %s", sb.buf, message);
+
+	strbuf_release(&sb);
+	return ret;
+}
+
 static int fsck_blobs(struct oidset *blobs_found, struct oidset *blobs_done,
 		      enum fsck_msg_id msg_missing, enum fsck_msg_id msg_type,
 		      struct fsck_options *options, const char *blob_type)
diff --git a/fsck.h b/fsck.h
index 6411437334..a3870ffe2b 100644
--- a/fsck.h
+++ b/fsck.h
@@ -132,6 +132,12 @@ int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
 						   enum fsck_msg_type msg_type,
 						   enum fsck_msg_id msg_id,
 						   const char *message);
+int fsck_refs_error_function(struct fsck_options *options,
+			     const struct object_id *oid,
+			     enum object_type object_type,
+			     enum fsck_msg_type msg_type,
+			     enum fsck_msg_id msg_id,
+			     const char *message);
 
 /*
  * The information for reporting refs-related error message
@@ -183,6 +189,13 @@ struct fsck_options {
 	.gitattributes_done = OIDSET_INIT, \
 	.error_func = fsck_objects_error_cb_print_missing_gitmodules, \
 }
+#define FSCK_REFS_OPTIONS_DEFAULT { \
+	.error_func = fsck_refs_error_function, \
+}
+#define FSCK_REFS_OPTIONS_STRICT { \
+	.strict = 1, \
+	.error_func = fsck_refs_error_function, \
+}
 
 /* descend in all linked child objects
  * the return value is:
-- 
2.45.2

