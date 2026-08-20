Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF7E391E73
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 23:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787269790; cv=none; b=QOWZk00RcWHqTOIABwaqtcS3mU7OWx+WuLlhLdz28nCYu4LCqpqyIUxGMRfDfDN3wdaj/yH65LF82NCtQ4qjXGR0IDxLkWKYJJrdxECr75jBdYSHW/+0U4FSn6mPwoKn7/EOR+b8fOiTCqoxTwazDv76eC2Ydv0Bwysh3PbHI7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787269790; c=relaxed/simple;
	bh=OUcPbGuzbb8pyxjQfjzDOet+UytgnIupsjg34HviTYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HekaKdyD0j17fnDWLqngiWgUMIxsW0yQ1NHbqlIPitvr7TZ8vHypVPs7vhP8ARDQQ0CDDWMBnMzroA7oDYp+ckzrUgnNgNz8/vhrDrXHhDZvDe/r8tYoogLsd0jL2V0L8q/SBZ38XOUp2B9BAzcs/jMpTVUIpJ+zTGYSnhe3s/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oJPhMNrR; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJPhMNrR"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-446f87b6de1so550126fac.3
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 16:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787269788; x=1787874588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nR0aPcfVmssE2DVb9TZbTLcTDzeN9M3h3j9cx5My4TA=;
        b=oJPhMNrRQR5I2Xv3PcF8tqrlUCND6YUZ8z5Aq79HvAL3MgDyMGDIQW3EDK9f0W1ogg
         K4iuNKUcQVTmSUByPb6IxF8Pa+6PleAX7aNxohXmQeBLuE7NJp3Bpd0iHQmpYZERYdJu
         HrSTxB137g3tnDpZ+iWq7qKfO8kl6keNBNWSMIirvyrPq0z16940wUkpwSghvYnwsVwv
         2T7ZqDze8Mui7w4hODEPURaM2zGf99zopHzbPtsVuJwHSyFeX7qMRUia9wFxLw+Z6u4H
         8SMMhj7L1J0ItFrIQ4R8kgCw/9U/C7Qo5Z2snjm603ecju2JgsnoERwNjVTkKefJw5bM
         wivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787269788; x=1787874588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nR0aPcfVmssE2DVb9TZbTLcTDzeN9M3h3j9cx5My4TA=;
        b=okMcIIcdM9qOW30aIS2KTX0SJVTdJUx9r0QJYUbhDq1YEfk4cmRwHJaiDmA2tK1Hjc
         PoWC30A8XocqHrcMLwu3j8Ko3yq9/s34zc8fQ9ucDIx+q0XTXBhRK9+dVdFbYr0guVki
         U8ZR6WRbhYkbaXbHl8GkGR93ax41E/6+j0IM2xx1V0dmhDAxD10MqLDWMKFhJXC9h7/f
         3txm4xdegFiV5qpQvILJp5pDDJCJFewCpLS8bq3o8SYuq1yVdYPNzmMY/HiD2+D/uM2h
         uWYXj9CljhOH5bxHWjsyosjpzPr4FhUEW/B3Az0r5dG1n5TPSBl8knM43toZfg9UdykY
         61Yg==
X-Gm-Message-State: AOJu0YzNsy4C6mVW37psY50Gu4nXCWPo+7lX2sPfd8X4jgRUvPhh81do
	4CQw9D92Qe8TGJzM2QF60lQksnYJBIqI8ZhjI/tLbI0R8Au1UWwXtStm5EsrAA==
X-Gm-Gg: AR+sD13LJLnwycIi8FTXCgp9n9bK+XQQlD7BpoNHEJOOhlTUdVdycsCXd7I4dga9Jd4
	hJsbCwYCklYzHAytz0qbH0/ttt+XwQS0jt+wMTsp89nXFHeGsqCZ25fM9O+BBQ0YYhvU74HVQ5Z
	sJnBe+iZtb8KC6dErEoXimqdGG/OVqJsD//LQptR4tY1GUxMiNAtDsklwMVSktbO0McMCP09dj+
	0dw2mAgWKZRQMEWy8qMUrrfWTd6xcVmDNwwk+W8KaxpBXSp//fUpzRMMqYrMMdTjldezzOMUmsV
	9risnS3Jkb3ggscAn/71z1CmETR3uRCCAs3W8RDuYDdy0iWerCJ3BiNipTUICEQpz4v+AgsGRZd
	abi/c5X4okTsEOHlCyrBSwcNW/gmTs7MhJ6zlLrG1WD7kUAawsSxx992KDydCgxqkKkMmLHeXzv
	vinzmItre6SNDoEYankX7VTMGF8czhE4VTfwrjSVm1bZYkMa3EmhkDiUbrn501zOXsG9eN
X-Received: by 2002:a05:6820:4b03:b0:6b1:5c1b:5838 with SMTP id 006d021491bc7-6b15c1b5e2fmr1192014eaf.26.1787269787727;
        Thu, 20 Aug 2026 16:49:47 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4632a6c360asm2961133fac.5.2026.08.20.16.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 16:49:47 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 3/9] builtin/receive-pack: pass shallow file explicitly
Date: Thu, 20 Aug 2026 18:49:34 -0500
Message-ID: <20260820234940.894624-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.424.g13c7afec21
In-Reply-To: <20260820234940.894624-1-jltobler@gmail.com>
References: <20260819215311.3880274-1-jltobler@gmail.com>
 <20260820234940.894624-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If shallow information is provided during `unpack()`, a temporary
shallow file is created and stored in global state. In a subsequent
commit, the `unpack()` logic is moved behind a generic ODB transaction
interface to handle writing packfiles and thus can no longer rely on
such global state. Lift the setup of the temporary shallow file out of
`unpack()` and wire it through to its call sites explicitly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/receive-pack.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ed1edcbe93..135105deae 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -86,7 +86,6 @@ static const char *head_name;
 static void *head_name_to_free;
 static int sent_capabilities;
 static int shallow_update;
-static const char *alt_shallow_file;
 static struct strbuf push_cert = STRBUF_INIT;
 static struct object_id push_cert_oid;
 static struct signature_check sigcheck;
@@ -2334,8 +2333,8 @@ static void push_header_arg(struct strvec *args, struct pack_header *hdr)
 		     ntohl(hdr->hdr_version), ntohl(hdr->hdr_entries));
 }
 
-static const char *unpack(int err_fd, struct shallow_info *si,
-			  struct odb_transaction *transaction)
+static const char *unpack(struct odb_transaction *transaction,
+			  const char *shallow_file, int err_fd)
 {
 	struct pack_header hdr;
 	const char *hdr_err;
@@ -2354,10 +2353,9 @@ static const char *unpack(int err_fd, struct shallow_info *si,
 		return hdr_err;
 	}
 
-	if (si->nr_ours || si->nr_theirs) {
-		alt_shallow_file = setup_temporary_shallow(si->shallow);
+	if (shallow_file) {
 		strvec_push(&child.args, "--shallow-file");
-		strvec_push(&child.args, alt_shallow_file);
+		strvec_push(&child.args, shallow_file);
 	}
 
 	odb_transaction_env(transaction, &child.env);
@@ -2433,14 +2431,14 @@ static const char *unpack(int err_fd, struct shallow_info *si,
 	return NULL;
 }
 
-static const char *unpack_with_sideband(struct shallow_info *si,
-					struct odb_transaction *transaction)
+static const char *unpack_with_sideband(struct odb_transaction *transaction,
+					const char *shallow_file)
 {
 	struct async muxer;
 	const char *ret;
 
 	if (!use_sideband)
-		return unpack(0, si, transaction);
+		return unpack(transaction, shallow_file, 0);
 
 	use_keepalive = KEEPALIVE_AFTER_NUL;
 	memset(&muxer, 0, sizeof(muxer));
@@ -2449,13 +2447,14 @@ static const char *unpack_with_sideband(struct shallow_info *si,
 	if (start_async(&muxer))
 		return NULL;
 
-	ret = unpack(muxer.in, si, transaction);
+	ret = unpack(transaction, shallow_file, muxer.in);
 
 	finish_async(&muxer);
 	return ret;
 }
 
-static void prepare_shallow_update(struct shallow_info *si)
+static void prepare_shallow_update(struct shallow_info *si,
+				   const char *shallow_file)
 {
 	int i, j, k, bitmap_size = DIV_ROUND_UP(si->ref->nr, 32);
 
@@ -2495,12 +2494,13 @@ static void prepare_shallow_update(struct shallow_info *si)
 	 * command. check_connected() will be done with
 	 * true .git/shallow though.
 	 */
-	setenv(GIT_SHALLOW_FILE_ENVIRONMENT, alt_shallow_file, 1);
+	setenv(GIT_SHALLOW_FILE_ENVIRONMENT, shallow_file, 1);
 }
 
 static void update_shallow_info(struct command *commands,
 				struct shallow_info *si,
-				struct oid_array *ref)
+				struct oid_array *ref,
+				const char *shallow_file)
 {
 	struct command *cmd;
 	int *ref_status;
@@ -2519,7 +2519,7 @@ static void update_shallow_info(struct command *commands,
 	si->ref = ref;
 
 	if (shallow_update) {
-		prepare_shallow_update(si);
+		prepare_shallow_update(si, shallow_file);
 		return;
 	}
 
@@ -2711,11 +2711,17 @@ int cmd_receive_pack(int argc,
 		if (!si.nr_ours && !si.nr_theirs)
 			shallow_update = 0;
 		if (!delete_only(commands)) {
+			const char *alt_shallow_file = NULL;
+
+			if (si.nr_ours || si.nr_theirs)
+				alt_shallow_file = setup_temporary_shallow(si.shallow);
+
 			if (odb_transaction_begin(the_repository->objects, &transaction, ODB_TRANSACTION_RECEIVE))
 				unpack_status = "unable to start object transaction";
 			else
-				unpack_status = unpack_with_sideband(&si, transaction);
-			update_shallow_info(commands, &si, &ref);
+				unpack_status = unpack_with_sideband(transaction, alt_shallow_file);
+
+			update_shallow_info(commands, &si, &ref, alt_shallow_file);
 		}
 		use_keepalive = KEEPALIVE_ALWAYS;
 		execute_commands(commands, unpack_status, &si, transaction,
-- 
2.55.0.424.g13c7afec21

