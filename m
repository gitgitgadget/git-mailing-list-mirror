Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98503659FD
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776251525; cv=none; b=NcQDF82B2Q2ASnUjnrcB242tgptn65oC3/aYXhYhPDEsUVI3Plnlpm80M+8yCSGSLjP9OdAsaiXSJF12Xqthi7ve37roQ3FSciXTe+EsloWob5kKQu0dXAuVWHgyLRJVFg/yWF1I91CC7iKKv+I8SmpeDGV9u2r7ZtwCgEqvgSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776251525; c=relaxed/simple;
	bh=hqnWLxNzUpLTOR1qBC52imCK7DQ8jdrTvGVSLkRVcTc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RDr+wDfdE0atrFfL1+EXm6McUnHOCEdMWuV5jpRcvfVx4TcPQGqs9edEbFSlJY3FIHv2411cPGD6vRA2rKPIty4/9Ex9J+F1flYSdey3bQ+0JC3jLrAyTBNM11iSItTL5gEeCmedlHd06FlJVAS4KXef8MlmleypyTg3YmylZHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HW3Wm91T; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HW3Wm91T"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8a151012558so78440406d6.3
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 04:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776251522; x=1776856322; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9BP86YUXbRmEP0ysPlnzxO5z6Gbq99S35RT4wqyWkA=;
        b=HW3Wm91TKeMJJfLyWdPFB5J+5Td/jyy55WW03MwO6oEmqb0xq39xaqVVQsRtl7J/q9
         OAZaa0zge8Z0q8ebMaMXSnMXn+ikEX/aRQ2fjpWtz1f1VH7x34drHw3EoCplk/iOsaKo
         F0Vt6Q7CqamdGZwRTplGtdcyrglpMqJmoveiiFWXrtud+QwS0M2AiDECqzMIwfjwPqL+
         OLrQOcmnc952vaeHXMsMJ2OZp1UDsRNbytvQi+xqVsXqOZmHbtZCs/BadpFYr3SoAQvN
         e2tVkkEsGbnihsf71dOaWQL1RuBiRuCddPRC/HnmJtdt2mv2Iw1kHsctj+4AIxg8B2PO
         EAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776251522; x=1776856322;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j9BP86YUXbRmEP0ysPlnzxO5z6Gbq99S35RT4wqyWkA=;
        b=OYXf+3j+z29sanzZmGt1erlfGTqxxGFB3HE+jA4dNwN77iHdwM5z5HaszPrChB6ua9
         Z2hVfeeKqoley8Vx1pEgWeg2/CWlWTwjS/NxOI+Bq13U2+6B1vsoGpXUR5uffNOVX3j5
         USoI6W8DCTiu/EdfstU3UbyKpFI5p6zVPsWhMm9I6OOVTpwrMcweP055LcJ/rHYkrXh8
         YW0ADxkkhBO0ZG/gl57twF8ei15s9cE+E9klWA4LQa25o1wHcT8S4DFJZNiRvB5kq1su
         +FIgjKTiacylvQkinoL2yPKsdWWUN3j9BC7pwqPUQl0onxzPiW28hhbYvxe4WY1Jfgjk
         j3JA==
X-Gm-Message-State: AOJu0Yyog3FZswjp6MfIwU5CITQlWspIT3/6pYbUjfw7lOBlfkPcG95s
	lNHASQI9N5AtYvW7ECXDZ+vk7ukq2hifmmNzB3PUfVINzg/RtY8YN02nkCVea8oZ
X-Gm-Gg: AeBDieu/gg8ZoVxpSApGRKJSo+rWRf7IqyvwxwoMBDHigTmYkwwsG2QqGnZJ4aVGDPO
	rMcpXEmNB6x8ysf96YsHyu0siLCv9cnzrtkdXbFLp52SgXpMP1sByoI6W5Yqrfz+fPnVc9FOadq
	8BCuUGwHpDVQq3lJaOSzsseskOoaEwiLigw5lH2R93RFQmV8dtHcd8NAreNp+9ITuaOCuaHkmR1
	KhiaPy0ZFMCjpFnU87HS3YIcLtOefBLqIi1kaMew0us3ER2MSvStL2hpWa7IDtlpI+pkXLVNW0S
	PxqSpoO1ofXEPKXi01xdCFqfi0Qr39rNbnA6CXRVz31o4np9p/O7op7VdRKfYKZVWBdc0UFOtTY
	VMN0cwETdfInvONN/YEscshuk49Yme90kxWYps91dOgF1XgKQdiwL01gHAshviQkaM/8OMHlErX
	avuLXYbqfOX4sE1TiO7b/ZI1AR0Htv
X-Received: by 2002:a05:6214:29ee:b0:8ad:87a2:3c1a with SMTP id 6a1803df08f44-8ad87a23d69mr112821036d6.46.1776251521379;
        Wed, 15 Apr 2026 04:12:01 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.227.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6c993a3asm9250556d6.22.2026.04.15.04.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:12:00 -0700 (PDT)
Message-Id: <7f3c32f5e99bfbd9c3bd69db962b1e0197b0b9f2.1776251517.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v13.git.git.1776251517.gitgitgadget@gmail.com>
References: <pull.2234.v12.git.git.1776171585.gitgitgadget@gmail.com>
	<pull.2234.v13.git.git.1776251517.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 11:11:54 +0000
Subject: [PATCH v13 2/5] sequencer: allow create_autostash to run silently
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Jeff King <peff@peff.net>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add a silent parameter to create_autostash_internal and introduce
create_autostash_ref_silent so that callers can create an autostash
without printing the "Created autostash" message.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/merge.c |  6 ++++--
 sequencer.c     | 17 +++++++++++------
 sequencer.h     |  3 ++-
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 2cbce56f8d..3ebe190ef1 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1672,7 +1672,8 @@ int cmd_merge(int argc,
 		}
 
 		if (autostash)
-			create_autostash_ref(the_repository, "MERGE_AUTOSTASH");
+			create_autostash_ref(the_repository, "MERGE_AUTOSTASH",
+					     NULL, false);
 		if (checkout_fast_forward(the_repository,
 					  &head_commit->object.oid,
 					  &commit->object.oid,
@@ -1764,7 +1765,8 @@ int cmd_merge(int argc,
 		die_ff_impossible();
 
 	if (autostash)
-		create_autostash_ref(the_repository, "MERGE_AUTOSTASH");
+		create_autostash_ref(the_repository, "MERGE_AUTOSTASH",
+				     NULL, false);
 
 	/* We are going to make a new commit. */
 	git_committer_info(IDENT_STRICT);
diff --git a/sequencer.c b/sequencer.c
index b7d8dca47f..ff5258f481 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4657,7 +4657,9 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
 
 static void create_autostash_internal(struct repository *r,
 				      const char *path,
-				      const char *refname)
+				      const char *refname,
+				      const char *message,
+				      bool silent)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct lock_file lock_file = LOCK_INIT;
@@ -4679,7 +4681,8 @@ static void create_autostash_internal(struct repository *r,
 		struct object_id oid;
 
 		strvec_pushl(&stash.args,
-			     "stash", "create", "autostash", NULL);
+			     "stash", "create",
+			     message ? message : "autostash", NULL);
 		stash.git_cmd = 1;
 		stash.no_stdin = 1;
 		strbuf_reset(&buf);
@@ -4702,7 +4705,8 @@ static void create_autostash_internal(struct repository *r,
 					&oid, null_oid(the_hash_algo), 0, UPDATE_REFS_DIE_ON_ERR);
 		}
 
-		printf(_("Created autostash: %s\n"), buf.buf);
+		if (!silent)
+			printf(_("Created autostash: %s\n"), buf.buf);
 		if (reset_head(r, &ropts) < 0)
 			die(_("could not reset --hard"));
 		discard_index(r->index);
@@ -4714,12 +4718,13 @@ static void create_autostash_internal(struct repository *r,
 
 void create_autostash(struct repository *r, const char *path)
 {
-	create_autostash_internal(r, path, NULL);
+	create_autostash_internal(r, path, NULL, NULL, false);
 }
 
-void create_autostash_ref(struct repository *r, const char *refname)
+void create_autostash_ref(struct repository *r, const char *refname,
+			  const char *message, bool silent)
 {
-	create_autostash_internal(r, NULL, refname);
+	create_autostash_internal(r, NULL, refname, message, silent);
 }
 
 static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
diff --git a/sequencer.h b/sequencer.h
index a6fa670c7c..02d2d9db06 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -229,7 +229,8 @@ void commit_post_rewrite(struct repository *r,
 			 const struct object_id *new_head);
 
 void create_autostash(struct repository *r, const char *path);
-void create_autostash_ref(struct repository *r, const char *refname);
+void create_autostash_ref(struct repository *r, const char *refname,
+			  const char *message, bool silent);
 int save_autostash(const char *path);
 int save_autostash_ref(struct repository *r, const char *refname);
 int apply_autostash(const char *path);
-- 
gitgitgadget

