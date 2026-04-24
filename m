Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A841A34C121
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 21:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777065020; cv=none; b=LrPOkv8/cxNtUiGupLnhFO7ZHHR+Nlqr09vNu0fgb3+WVo+dYlTUMxox0bqeVRXSwT04Cl8J3iOxCcsvUqyStsI/G3rVuM8a2QFP6PovMq1DRpmKU+0u83tDwZmIAM6xIyz8+dByNUHZ3HgKtliZGmGsPt0BQZEnY6rZS86LDHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777065020; c=relaxed/simple;
	bh=hqnWLxNzUpLTOR1qBC52imCK7DQ8jdrTvGVSLkRVcTc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=emu0RZQEJSdGYuS0Gh8/dkbuYcPrH3zMaGYl109t7I105gjuCJrPtixoVTW87+evZCBZ+JX7p23SRJvenLOOXrmJcrO3T7gWyj6p3dSFi5hEAbLc4fczxg+DSKCrENb0QCiBBOBjLOPbOSy5p1EKqCPdICnWna+1MJtwM/NP7j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDk/ep7z; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDk/ep7z"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12dbd0f8063so1799536c88.0
        for <git@vger.kernel.org>; Fri, 24 Apr 2026 14:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777065017; x=1777669817; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9BP86YUXbRmEP0ysPlnzxO5z6Gbq99S35RT4wqyWkA=;
        b=WDk/ep7zLMAztrMk4S2m1QKm+fMjUumf2Othd8eFwSG/O3qZI/hOZfitRVE3/0a1km
         H3oh43VEtNxP1KPas5vijnTftnz4YrSvFUA122PGnnPP5kAPY0763//gA1DxzUeAJzzi
         Ia9R++mqOpoFa990Q/HEbjN248iJDM5wuBbsQMhPI35Y13hmSvWnLtyR/fVJyt2cQ5Yw
         WxXPZS+Cf6g9874RUv/t3tpC+Hrj6h/X+NNt0UNDv0lgnalXSqnRVKR0/XTTHGWAl5dI
         t149btE3kIEEwx7Kh/ooRpCF1yZtZq2m9k5ZghiN9flDYh2Q7pQQ7gROTGl8Qyf3Mg+a
         N3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777065017; x=1777669817;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j9BP86YUXbRmEP0ysPlnzxO5z6Gbq99S35RT4wqyWkA=;
        b=EGzx5c2/hPFpPKx7T1//H2Y8855M41OyokqnYoE0UHuSBuG0kQ/KB42EAENU0lPtIm
         ySaLZry4EH9gn/xi9foj1ayhtzOMIn2REo5tOqSoLBUaUdCrJORo0nK0O2C7bMpz37ih
         rc6X6FQqkfPDYHu2Wb41gFhnIEUlDkReioo+rISqFJ5s6XIPDVMLypUBMFLizu4UNDkZ
         zGf0EL1CIM9NSZBzbRP0Q/6t+LU57Y5eER1CvX7/6j816AJNDAXoC1H9wJRdlMWqT7jX
         HlOVChoxDwE6a671snLM9Q5n+huLdbVFNAadjh+San1muOxYokRQ4SFgNoF/m7ZnlPJK
         2sIQ==
X-Gm-Message-State: AOJu0Yza1OD0rxi0buaMSj3mNmoaPbku2VgwmLwYY1WaupxJyTzVXBzp
	UtAejnIJH99otwoxS3Lx/Bz2L3nzXKpMPi6YsWoIZBubdIBuWvjHjc1cXhsOzA==
X-Gm-Gg: AeBDieu8b3rt9xKhRLESPqqxsoHeARFistY/hskMM3YnbQRDcFbsJ53GhgtYjpS0Ct6
	ucmrsT8U1qKlI5mlk85akqujEniVoJZ+y/BxiE1defJpWh8704ItBbbzOOyLj0M8rnCEcG5BCHA
	dNpOaLW6gMx4WyXiXasUjW82HWTOi7ptUg6sUWvZHPAKpN13w8hj38fHwiKZeVkZyJpD1JIP74F
	yBb1lbXdRg9DRFyRdZUxkuyadK9Ihw5yUp7X4mDmYEE4U1ur0kGF7TIHq8FpeHFkQQWRW+wshE0
	umswUidO50bmu90mZIvMsT80TroPUKLhPLB/joxUblnk9jaXMqRv35PCug+bV3LSVUWASKPwiDK
	h9DE5bY6+9Lm9NGArvPP4nID4unf0mjZSh8N/8fOzIrb47t3BVKwkugimJuUwv5d5z14tqV4KJJ
	vRuoRssPY70brgW+OxdukNsEV4tffLgk8weWeCVFI=
X-Received: by 2002:a05:7300:8ca2:b0:2bd:c285:2fe with SMTP id 5a478bee46e88-2e46c396310mr18662126eec.9.1777065017110;
        Fri, 24 Apr 2026 14:10:17 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa244csm33179044eec.2.2026.04.24.14.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 14:10:16 -0700 (PDT)
Message-Id: <89e0bfa80326d20d11355ed2e73de0907e5c9e41.1777065012.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v15.git.git.1777065012.gitgitgadget@gmail.com>
References: <pull.2234.v14.git.git.1776270259.gitgitgadget@gmail.com>
	<pull.2234.v15.git.git.1777065012.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Apr 2026 21:10:09 +0000
Subject: [PATCH v15 2/5] sequencer: allow create_autostash to run silently
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

