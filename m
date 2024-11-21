Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4DA83CDA
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 20:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732221849; cv=none; b=Tevd8wqbeq3ss03uPwukaGQWpxGDnXp/GfdTiA/srCbgYQOpyZMIsCSxvZMd+taQmHHbkOkpCkClmVx03/ar9B8N8tt7IOhKADlL3XBDML3zi+avjXOXppwxAdW5oMxrHq/U02k9s80qZB3c5adK7ro34IwjV6QAef3SEbRkYds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732221849; c=relaxed/simple;
	bh=56ziYKkAAf8UgtK3mBXWeSvxtT80Och/mLI8a3zjiSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=erccqX0cAfBi6wuJcHQchqLvCPwmYWsyKm4sZAQ3cHxwBMf395a/qANocEqPB2RRzdlv3Z0C3JspSL2TXdmfVoFfnOct/SRLY/QazCOfNPm5vxJYaBF7Lj70wZ/73V3diPBYKuqWR9N97jnn7MucVDGd0kNorKe1sz2Ahguap5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sf4qf3s9; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sf4qf3s9"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2967af48248so828260fac.2
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 12:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732221847; x=1732826647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rjI5PNefyH9wwX9OS3o+hM06SN2urMIWBkrzg9TLQY=;
        b=Sf4qf3s9b+/RRefx5PLz5A5flhTkbc7TJPcDUHR22AkPs0FAMtGsK1iaBkq8B/D5OI
         JB9W3Mcf/SpNgEggtiHeWpoq432+RvEwSNdWwcqSA8wiwVUEdxOXgl2ns3pNeWYY4cVm
         b/UY09dKpwhEA8gbhq2XiJ4PHbxFTDgDGuswrDtlglRWEuUiv4sUsRLfC5ZAV2aNwvTL
         VhBMwUTiK7+yn/WzgLtqQDMic8lwuCvPwSFqRlh9Qfz0l/lD73W+S1JEXPpPoenQYXD8
         VRGt0bqJ6e5Sok9AmpW6zq6LderdNSv9iUwLkhaX0cY84hsTysDionBJOYIpdwF/eRYQ
         DZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732221847; x=1732826647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rjI5PNefyH9wwX9OS3o+hM06SN2urMIWBkrzg9TLQY=;
        b=PEILPpNQesCDnlaiwzTj6wi89fVNmvUTBAZlPFxkeCrqxrczNoV3g53bd7fbw4tvOp
         JAdjF6JmHeZ488Bvut1GkKdq86FaC+O+XZq9YwYtkbXl3QUbxT4hoR+CYixNcJ6trhOh
         PISVkOKuQMcqnAL1SrwrD4wFuC/TnED0uD5/Xmdi4i0X/SAinYLmLabd8KkXOEldB9Gk
         TFP4Xnj6LwI438xGHYzEmFUVPWs0fIPx2UDczQw9p4xOKXOMqvPk/aUf+93JqZOyd4cQ
         aO3DTYJwZqitQAFYSCxH7j6Hsy5r9XF2e6Vg17rVJZE2tQs5Nmb3u2+tMPFTo9GoncSX
         n7EA==
X-Gm-Message-State: AOJu0YyXI8+vS8VSOds9IP0DnsuK5Jo8z27AqLI3FsvldIVMYCVZ5RbJ
	Iux7jaNowgSYgCdjOYK5K4JKxB6PdJjNrXYK+ofAU0Rieeq172+qlxKweg==
X-Gm-Gg: ASbGncslvQbZa6wKecpN/IfZ0j7ZIGsgL/+/mdECnuA351MXlIDaCVyxB7Cci+zx7Jm
	wmlLivXuUyVZ3zJVpNzj8CZvWfqY1qSaMfYmeoKvJmKsjwyiGRBv9ra09jls5lqqTfHB8B5CrkM
	XQXZ+yL0h8jQIT1pBxi09WiMoFPBKllIOBj4xXa06yPUkk54OnDM/VDaeZIwPWlVMvIf7yxBv7F
	5woz4b71Gj2NtlP5DHwHyrfz42cxGcXAakaeNdXyuEYylVQULrP1V7kCQ==
X-Google-Smtp-Source: AGHT+IHCNhdwnjogsxMfr4pJNWXihXV62DltrGRjSJg44yoDm/tbflezTSM2m779olgaDMI3hInRQA==
X-Received: by 2002:a05:6870:ac10:b0:288:4823:fe1b with SMTP id 586e51a60fabf-29720b9abdcmr255723fac.17.1732221846976;
        Thu, 21 Nov 2024 12:44:06 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2971d669843sm126481fac.28.2024.11.21.12.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 12:44:06 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 3/5] fetch-pack: introduce `fetch_pack_options`
Date: Thu, 21 Nov 2024 14:41:17 -0600
Message-ID: <20241121204119.1440773-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241121204119.1440773-1-jltobler@gmail.com>
References: <20241121204119.1440773-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When `fetch_pack_config()` is invoked, fetch-pack configuration is
parsed from the config. As part of this operation, fsck message severity
configuration is assigned to the `fsck_msg_types` global variable. This
is optionally used to configure the downstream git-index-pack(1) when
the `--strict` option is specified.

In a subsequent commit, the same fetch-pack fsck message configuration
needs to be reused. To facilitate this, introduce `fetch_pack_options`
which gets written to during the `fetch_pack_config_cb()` instead of
directly modifying the `fsck_msg_types` global.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 fetch-pack.c | 16 +++++++++-------
 fetch-pack.h |  8 ++++++++
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index fe1fb3c1b7..73309f8043 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -48,8 +48,8 @@ static int server_supports_filtering;
 static int advertise_sid;
 static struct shallow_lock shallow_lock;
 static const char *alternate_shallow_file;
+static struct fetch_pack_options fetch_pack_options = FETCH_PACK_OPTIONS_INIT;
 static struct fsck_options fsck_options = FSCK_OPTIONS_MISSING_GITMODULES;
-static struct strbuf fsck_msg_types = STRBUF_INIT;
 static struct string_list uri_protocols = STRING_LIST_INIT_DUP;
 
 /* Remember to update object flag allocation in object.h */
@@ -1017,7 +1017,7 @@ static int get_pack(struct fetch_pack_args *args,
 			strvec_push(&cmd.args, "--fsck-objects");
 		else
 			strvec_pushf(&cmd.args, "--strict%s",
-				     fsck_msg_types.buf);
+				     fetch_pack_options.fsck_msg_types.buf);
 	}
 
 	if (index_pack_args) {
@@ -1860,6 +1860,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 static int fetch_pack_config_cb(const char *var, const char *value,
 				const struct config_context *ctx, void *cb)
 {
+	struct fetch_pack_options *opts = cb;
 	const char *msg_id;
 
 	if (strcmp(var, "fetch.fsck.skiplist") == 0) {
@@ -1867,8 +1868,8 @@ static int fetch_pack_config_cb(const char *var, const char *value,
 
 		if (git_config_pathname(&path, var, value))
 			return 1;
-		strbuf_addf(&fsck_msg_types, "%cskiplist=%s",
-			fsck_msg_types.len ? ',' : '=', path);
+		strbuf_addf(&opts->fsck_msg_types, "%cskiplist=%s",
+			    opts->fsck_msg_types.len ? ',' : '=', path);
 		free(path);
 		return 0;
 	}
@@ -1877,8 +1878,9 @@ static int fetch_pack_config_cb(const char *var, const char *value,
 		if (!value)
 			return config_error_nonbool(var);
 		if (is_valid_msg_type(msg_id, value))
-			strbuf_addf(&fsck_msg_types, "%c%s=%s",
-				fsck_msg_types.len ? ',' : '=', msg_id, value);
+			strbuf_addf(&opts->fsck_msg_types, "%c%s=%s",
+				    opts->fsck_msg_types.len ? ',' : '=',
+				    msg_id, value);
 		else
 			warning("Skipping unknown msg id '%s'", msg_id);
 		return 0;
@@ -1904,7 +1906,7 @@ static void fetch_pack_config(void)
 		}
 	}
 
-	git_config(fetch_pack_config_cb, NULL);
+	git_config(fetch_pack_config_cb, &fetch_pack_options);
 }
 
 static void fetch_pack_setup(void)
diff --git a/fetch-pack.h b/fetch-pack.h
index b5c579cdae..8243b754ce 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -106,4 +106,12 @@ int report_unmatched_refs(struct ref **sought, int nr_sought);
  */
 int fetch_pack_fsck_objects(void);
 
+struct fetch_pack_options {
+	struct strbuf fsck_msg_types;
+};
+
+#define FETCH_PACK_OPTIONS_INIT { \
+	.fsck_msg_types = STRBUF_INIT, \
+}
+
 #endif
-- 
2.47.0

