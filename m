Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60193221275
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776270266; cv=none; b=JlX9KXIfFnehwfyYnCE7BUJweAnKGh+WPXL3pPL4gzjO0ZvQKJYJ94IkwLh7PbhmaWqqgpj9eOCX7dfIxcn/1sL4A945Q1n9Xtf4jmcGVp3zsIkz5QrxTAc601WEklgbd36d2xOwHnQS8qcYuGhx5qjA5/d6Zz/s9y2JY97lKYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776270266; c=relaxed/simple;
	bh=hqnWLxNzUpLTOR1qBC52imCK7DQ8jdrTvGVSLkRVcTc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UfdN9hllFhvWEDQL9YPXWBaEGtPnVs/g42RWe58R/IWonBDry2yJp81/e9dwHDPDj0/SYh6AFO0yPiQh7y7a2SlpZ0dETb69KTMtK7gqCzxbPI3clVZ4YnsJIH5o9KuBxONXjQ/9e+DJQ4Q/9wYUlPRdGP9cHyhDYmEVCLqYdAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMlJavee; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMlJavee"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d7fdb922a5so5566416a34.3
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 09:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776270264; x=1776875064; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9BP86YUXbRmEP0ysPlnzxO5z6Gbq99S35RT4wqyWkA=;
        b=jMlJaveewBijRyrY3wSi0Kf5HVNVlU3kRW7MpdHmAmpsq3FNxJsOvfM7zgxL5yqQel
         TcOFGFL9VXpUK02MxFJBjW0GQvQuWqKqSDK7kkWUAf5LFLX/vwilz/EsysfbTktZrCRp
         B0o3RiOuo9tNvZE6GB31/u5vnL9oKoT6JiNDakH7fCRSvVphIhlz8ChAdtObdsJQtMkC
         aqedaNgx4cXH+xpHQBgvus0tfhGVpyx2EPqCD+ioYbKi6e6PY3gut5EkYPSfPlRfpYMV
         bRd1U9T0tdnghcTirJSZRkTeAjXghLXxsB8PGszKRfYcffyJmwByyy5Wa/PHriC/nXVk
         +1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776270264; x=1776875064;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j9BP86YUXbRmEP0ysPlnzxO5z6Gbq99S35RT4wqyWkA=;
        b=LvE61ViiFDgeR1PuUEG+V+YIVsth/rF5wtQKfdySasHMqUVQfBkx3nZtdYmr0aSHTd
         g5ukiJQsugs3guP906Smh+a0oPdSauJ/VyQtXXswDlfxCQctzYT3ILts+2c3nSHlT0ir
         A58eQ1HamBknI/4PvkulcXgt4OOYS5VllZ+PipOwnw1590jMCZRfOaKn1plPplUsDUNr
         UBAzmmt01lrn49JtouVkH9ZygGd5BxY/t8UjjmYff41HEa9LWNb6EPZJBCoYnqwgGtyU
         DdM+yXO1HIDhXogFv1IpVx/t/YCdTHDeyJvyAucg4K7GdTbp2Fp3jwSKdpfSs1LhCxdi
         a4qA==
X-Gm-Message-State: AOJu0YzwPx1g40yG5l9Ltw9SA7+EkpQG9IpHNV54aQDly9fsRMRsMz4a
	ICMG5zrnkO7zMDc8CBcw7IhlckqGZD1ztfGAitEzvfrTyXJlsiGVAp7ymsg+Sg==
X-Gm-Gg: AeBDiesBgqLNn4Mu6gZuTZmxlCFiy1Sjvg1F2FuJ1igU+Nyzyo5DB5BSZFPqB9EjNDP
	cIeDbTVLrlLEGDev1B60Flkgr1W94VfrERBtfG5+R1QsmtgxTynGUR4v2dzpfPOtoYNuRkoXsWM
	/zCs6OH1RIgHfQiK9lt5ChYA9O2M52MxYrwREZ2Naktt6nAb2vI5y0UQHZ5CI0RJC48AEOE2BJq
	0A+2PKNvOMHTo3v9nXmIV5xGFgGQGw2li7YnUZF/4oDXGwakE2+YH7s9QAnKjX3kiJf190bJxHk
	JvRBBV2EExrGXOTcnbRur3Os+z/KBNh9R8AfutKrDSeRQtwR1vwMDltwbTBIHZ4V9dAPz0UTtDN
	HnxWwJcT5Pk8CA1rLtGi/Euq3JVho2KRvAVq5m/PFqlYbLb2nRER7z/mqbnOtNS5XLnkZorY9+X
	pW0PS79gcvML6Si9G4f3wNiDpM
X-Received: by 2002:a9d:600e:0:b0:7dc:3e5a:64c4 with SMTP id 46e09a7af769-7dc3e5a68a9mr7944886a34.8.1776270263901;
        Wed, 15 Apr 2026 09:24:23 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.21.53])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc76b95a2csm1656942a34.22.2026.04.15.09.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 09:24:23 -0700 (PDT)
Message-Id: <ce29b10264eff142370a66a67f681f490ff07934.1776270259.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v14.git.git.1776270259.gitgitgadget@gmail.com>
References: <pull.2234.v13.git.git.1776251517.gitgitgadget@gmail.com>
	<pull.2234.v14.git.git.1776270259.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 16:24:16 +0000
Subject: [PATCH v14 2/5] sequencer: allow create_autostash to run silently
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

