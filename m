Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271AC85624
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015025; cv=none; b=JG6B+oWtiLA9xSQwTOeGPkaVXv8pZM9xEwedyECtJQMyrdFkmINNMIXLpvMz0Fo8MmlD3bc3Luu3SvNCJId2JyLw5vzArlcuzBYXKfnsblIRlMugma1YzToaTf4Q0Mr+sLwVJ+RMr9YgwFPjtE1U+DL+NTKJdFuxEyPESpsY8ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015025; c=relaxed/simple;
	bh=jQghWynB7l/myLbFQEpmq/CunycbaK16wPnKbUtPY+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGgQQbmI9bVCZycFGVPqlj9xhlBA+GTmqVUHv4Umt5TF4IXg5s6htWmMi2a5Lt3NforD0xmjKUQj0ZIiO/Q+JY8ACieCXIAotfzqj5uauvWzF9SEDmWFiL1yyiuE84clwHWpfsP9ojQbIVozKIyazRMHnv7ipO93byvggcpMtJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhhUROyi; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhhUROyi"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fb222a8eaeso2823105ad.3
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 06:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720015023; x=1720619823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wcHdesL+nRhq/wtl9I6I0uiecL39HaGJC1i/WB2Rjzk=;
        b=PhhUROyi/g+fl1WML9EtrQWSSx3U14+Uu7MlaflyWFAbIfukj8L8vA0eiZ6g2d3eEv
         fB1EiM120FqyetDTHQj5gGrFrq5+DrLX8K7uhK94Cjz+vFNLKkKWoozdH3cumMT8sNnu
         nOEFYsMmG7quHAe4ItC7tUL0/bvHTUBOeEdzS3Btez6Nx5VRq2UG7eFALHHN3Hot0WCo
         yDIe0QsNQQ+FWB/KUOUUx1GjPIQSWtpcc+2A9r7bVgMDvjusuXULa/UeJNl2vKUp/94n
         LoBhdgkYm0i2kAROqgM0jCNDbe3VK9VvIEZniHLik8KP1DHkSSkQeJZ7kbLtwUg9hddr
         G6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720015023; x=1720619823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcHdesL+nRhq/wtl9I6I0uiecL39HaGJC1i/WB2Rjzk=;
        b=rSKGIS+2SeLmhdNz7wOFghvSnH/D9iRPmSyzQsnQZ3CXZeJoyLWOedawun/8IewPhi
         Xsc7ZBAX3kg/ohE54SD2YdcFDr4WmvcIHvWIMSJDnb/jEnaJEZDuiPOI7Xs3K4pipGZY
         TF717o99u+/fDCbSaifsZW78fn+ptyocssIuT3n/czplHzfI2dpx3wFboPhD7fSGTXkg
         f+U0tYnR5N8OjHXfPWXSsiu0xDrz0LhcEifdEvJ5xevmPGBYBu1Bw4ynEdonWViax5pE
         MS8xSFpCHsFv6UFicJqyEjDAnLOZ3AEMkHF/O1m1d1A34lvmAUR63rhNDDtWUVYQvGcQ
         nGzQ==
X-Gm-Message-State: AOJu0Ywi+1Ip3Mku2NEezstjC0gEiMX5S+o7umIwoNQ3eH508JyZ/scI
	U11ZWxGG9wIpYIRm+ARKMQbl04cE41L7G+ig212SevG5/B1l4hJWtfa+KlXt
X-Google-Smtp-Source: AGHT+IHWI0go9aDr3Wbvb60ZjER4Dy3LG1+IyvR9pNQyTy+4r7kn/Pq8HgBgO4V3nsk2gxxeyMastQ==
X-Received: by 2002:a17:903:41d0:b0:1fb:167e:fb0f with SMTP id d9443c01a7336-1fb167efe72mr12669985ad.18.1720015022923;
        Wed, 03 Jul 2024 06:57:02 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1535b1esm103922435ad.140.2024.07.03.06.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 06:57:02 -0700 (PDT)
Date: Wed, 3 Jul 2024 21:57:02 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v7 3/9] fsck: add refs-related options and error report
 function
Message-ID: <ZoVYro3NYjpz7Cmd@ArchLinux>
References: <ZoVX6sn2C9VIeZ38@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoVX6sn2C9VIeZ38@ArchLinux>

Add refs-related options to the "fsck_options", create refs-specific
"error_func" callback "fsck_refs_error_function".

"fsck_refs_error_function" will use the "oid" parameter. When the caller
passes the oid, it will use "oid_to_hex" to get the corresponding hex
value to report to the caller.

Last, add "FSCK_REFS_OPTIONS_DEFAULT" and "FSCK_REFS_OPTIONS_STRICT"
macros to create refs options easily.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 fsck.c | 22 ++++++++++++++++++++++
 fsck.h | 15 +++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/fsck.c b/fsck.c
index 7182ce8e80..d1dcbdcac2 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1252,6 +1252,28 @@ int fsck_objects_error_function(struct fsck_options *o,
 	return 1;
 }
 
+int fsck_refs_error_function(struct fsck_options *options UNUSED,
+			     const struct object_id *oid,
+			     enum object_type object_type UNUSED,
+			     const char *checked_ref_name,
+			     enum fsck_msg_type msg_type,
+			     enum fsck_msg_id msg_id UNUSED,
+			     const char *message)
+{
+	static struct strbuf sb = STRBUF_INIT;
+
+	strbuf_addstr(&sb, checked_ref_name);
+	if (oid)
+		strbuf_addf(&sb, " -> (%s)", oid_to_hex(oid));
+
+	if (msg_type == FSCK_WARN) {
+		warning("%s: %s", sb.buf, message);
+		return 0;
+	}
+	error("%s: %s", sb.buf, message);
+	return 1;
+}
+
 static int fsck_blobs(struct oidset *blobs_found, struct oidset *blobs_done,
 		      enum fsck_msg_id msg_missing, enum fsck_msg_id msg_type,
 		      struct fsck_options *options, const char *blob_type)
diff --git a/fsck.h b/fsck.h
index f703dfb5e8..246055c0f9 100644
--- a/fsck.h
+++ b/fsck.h
@@ -135,11 +135,19 @@ int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
 						   enum fsck_msg_type msg_type,
 						   enum fsck_msg_id msg_id,
 						   const char *message);
+int fsck_refs_error_function(struct fsck_options *options,
+			     const struct object_id *oid,
+			     enum object_type object_type,
+			     const char *checked_ref_name,
+			     enum fsck_msg_type msg_type,
+			     enum fsck_msg_id msg_id,
+			     const char *message);
 
 struct fsck_options {
 	fsck_walk_func walk;
 	fsck_error error_func;
 	unsigned strict:1;
+	unsigned verbose_refs:1;
 	enum fsck_msg_type *msg_type;
 	struct oidset oid_skiplist;
 	struct oidset gitmodules_found;
@@ -173,6 +181,13 @@ struct fsck_options {
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

