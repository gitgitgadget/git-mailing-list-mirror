Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC24537BE60
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781868509; cv=none; b=neZiMRMwdgGPEiTsgBiI2Y3ylxaJCQDnuPfFxvHvakyw4HnKwgYfyvvqbtYPH6i0dfXVHy9Nah2Jbnfw1Q7r3NY5U2Rx+bY9XxKzEBvCQkB+8sSTf0Ec7eRjrpJHLUjsHNqPOkQahl5A1T4WXk5pgr/LKNmzTxBLMJwzquJJWso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781868509; c=relaxed/simple;
	bh=7WBspUG9t6Plko2j9xPUDd//0Z8gxploadErBg7KSGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aDiBES188hU5tfmU7yvS94seciKKdWB72RKkiyBPpDN96R1WILn0h3rbBRVyakVVVStVIa0x5a7z4IpFa+DsHl2VtWnPXc7OPuWXutjl4QpGXKHc0CbxkhGFwbD4kUui5duFIyhvXPWYR4QcAZl00UOhxQL6tNVXfufXjjwbad0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mv0UoTnK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GRNR/ITJ; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mv0UoTnK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GRNR/ITJ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 125A31D0015E;
	Fri, 19 Jun 2026 07:28:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 19 Jun 2026 07:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781868506;
	 x=1781954906; bh=BcHRFduO5sSVXSE1N+mFsPR8sFZlqUITU3qKvpUa1FA=; b=
	Mv0UoTnKLxrSXNA70nja3LVdNEthfeAa1VDyDMmJSRQRA/aBVGTlClcHlY0rCzNb
	OhHMzx4MxVxR0HRhIi8gqZpDTxLBpwOpcXrfJoSUA+uI/mosTT9lXHYMZLjVEfz/
	kNhpzl9DKZp+0OVoRwke4Oet+va/zBC2+MnNJEz4NXrzjaf+lLlSAhERGkN1lAo2
	tZoT7Gke12i6nSPUpn3eQb6qk8llrZwiLaa3G2SzJQ+eOKDqmPpW3Hkx+5mSVbT3
	mJlnfOEFkVbMR4J1se2aymZq1h+F/Bkw3kPBVAo2vNuSdPix2mIBuFA90Ry1l8rP
	41Gq5ns17cRP3yiddkOhMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781868506; x=
	1781954906; bh=BcHRFduO5sSVXSE1N+mFsPR8sFZlqUITU3qKvpUa1FA=; b=G
	RNR/ITJ3+yU/GTzINddq84UwjQhXEg2FYRh7n1Yxn5Pyf9SdgsYsLO7q/a1HwzM4
	anLeAKFbQkbJCj3aAXG7Gj8JBOM6dJmxrGTIulcRZai4eaFTgp3G0+2E5pLV1/sZ
	/7RxCnC1HGYnCzdMM0rAioDSPtKNUH5GQl9fOA+zA9mttrZDSivLjpEvz/1ozwT4
	U1gMwNPM2hGihUY6jlNAOzbZAoA1EIUsOk7rAMBFjJVo9mmQ7twpYjN/L4hPio4o
	tmJ6P2VyvQSbdB7NNnu6Hdf+CgIxaRuR/wR4qY7NL09C2HRt5ku0jtoigCv3Xmi8
	2fZ25hijYaiNetbCX0CWQ==
X-ME-Sender: <xms:2ic1apv10YWG9nXoF2ga7XocvvbX6wpJs_ldb9uaB6twqXheEGzrlw>
    <xme:2ic1apeVIdWpOuKgPduHN7S_0t6GWgFtr-nirJkMwLBwC-_x5nfwKmUdAVnqLS_YC
    _xKXHo1j8xa0_dFRb00irQpWCicbSIf7lX1z5iChUlcxRBrWIDD8A>
X-ME-Received: <xmr:2ic1ahxp0DI8FVQWb3ZiVQ0c6xvt-JuTLvbe-XyjTtgxxCYqVqnL3rOVBm-6D625BJhIdLy6xz8G2arEll36eaMgeGDusJJToisLSWs5WZw>
X-ME-Proxy-Cause: dmFkZTFS9qJGiRupTLZARlQAwWBxBr3o+dmq+ExqQzgsj/m1Ot5OYCXQOpopuHnWUsJRXl
    jT6DtMdztVdgFB/vBHtj3kG7hM2IA+yQo49K9/NzWyMS3Y5gawaO6a0j7tSo8Dxdtd7lYi
    Hq/GbMIBjuknla5NubWM8zyu1Bw+Yjwq7YlCfHCPEB5Ej4O5hqJBHpKbmi0ziXVj7M4oga
    XNuXRcrLwJbEuO/xxj9+kO9a1HbcnIRVGkRRcHN5lRCe9UhfpErxACSzTqi4AxG8/5/3+T
    2Rz6h+EpMyTSOwkrmvjXJXAChOanSwVAz8vYmNxULqcIJArnGvUZm9R1kra0TN/34+evBA
    JrQeUfrev92f4eqAomknj3cyss6rvdozIJLAeUVh5+c7k3SyYKX99SYfguLSZ74GNV0VE+
    EVJ+wjAsV1pBtlgx8VwzTtbeIWQ1IzLGpX9vx8faPzmjO0/X7wNbk39xHydeidc9D4a9kJ
    sgUgtXOwILthBa9pJ1D+GK9Pd9QeZGzMGz3bjltRnCHEtCFs8KNw2WWOIkE/b0NlkpLgkC
    tQx7V5mw6hac4jYzkCkgxCYjao01bUenKYPEGUboEghkOpUc6OCPT/zJpma5/9Kpvjkj/+
    xDCSnY9tWVaP3Nue2Yi+flRosiENT/b9nydeXIhk+92Omd3TJYMPzmNkmadA
X-ME-Proxy: <xmx:2ic1avH2G-hdyX2vUrkKKxmp0_zvnhJEKk_0t7ENkrWny0wVhnBtLw>
    <xmx:2ic1alzgMUX6rjGJKvss3Ohlv2SyFyDf83P3Jr_rEViMYJMq8Qqc8A>
    <xmx:2ic1agt9NTEbC6uEo9gA0nFGIiMVAnQvXFUQwWU6PDziCSwiBj8BsA>
    <xmx:2ic1ai0zLVozWFP8vzitGKM5X_C03dUbzU6pD-C50xl5_vwgqOrfEA>
    <xmx:2ic1aq0Sst8ABDLROO4Rr8au2TVBJVjpptyVND22qA2HvKkZ_pWVgm1y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 07:28:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d026c47c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jun 2026 11:28:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 19 Jun 2026 13:27:57 +0200
Subject: [PATCH v4 09/10] refs: fix recursing `get_main_ref_store()` with
 "onbranch" config
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-9-a6472be7acc4@pks.im>
References: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-0-a6472be7acc4@pks.im>
In-Reply-To: <20260619-b4-pks-refs-avoid-chdir-notify-reparent-v4-0-a6472be7acc4@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

When we have an "onbranch" condition we need to ask the reference
database whether HEAD currently points at the configured branch. This
unfortunately creates a chicken-and-egg problem:

  - The reference database needs to read the configuration so that it
    can configure itself.

  - The configuration needs to construct a reference database to fully
    parse all of its conditionals.

The way we handle this is by simply excluding "onbranch" conditionals
when we haven't yet configured the reference database.

The mechanism for this is broken though: to verify whether or not we
have configured the reference database we check whether its format is
set to `REF_STORAGE_UNKNOWN` in `include_by_branch()`. But typically,
the format _is_ already known at that time because we set it up during
repository discovery in "setup.c".

The consequence is that we recurse:

  1. We call `get_main_ref_store()`.

  2. We don't yet have a reference store, so we call `ref_store_init()`.

  3. We parse the configuration required for the reference store.

  4. We eventually end up in `include_by_branch()`.

  5. We have already configured the reference storage format, so we end
     up calling `get_main_ref_store()` again.

We still haven't finished (1) though, so `get_main_ref_store()` will now
call `ref_store_init()` a second time. The end result is that we have
constructed the same reference store twice.

Of course, as both reference stores would be assigned to `refs_private`,
we leak one of those two instances. This never surfaced as an actual
leak though because the pointer is kept alive by the "chdir_notify"
subsystem.

The mechanism to use the configured reference format is quite fragile in
the first place. Introduce a new mechanism that allows us to explicitly
skip evaluation of "onbranch" conditions and use it to fix the issue.
Add a sanity check in `get_main_ref_store()` to make sure we aren't
recursing, which would have failed before the fix.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c                | 4 +++-
 config.h                | 1 +
 refs.c                  | 7 +++++++
 refs/files-backend.c    | 8 +++++++-
 refs/reftable-backend.c | 8 +++++++-
 5 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index a1b92fe083..223c252236 100644
--- a/config.c
+++ b/config.c
@@ -302,7 +302,9 @@ static int include_by_branch(struct config_include_data *data,
 	struct strbuf pattern = STRBUF_INIT;
 	const char *refname, *shortname;
 
-	if (!data->repo || data->repo->ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
+	if (!data->repo ||
+	    data->opts->ignore_refs ||
+	    data->repo->ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
 		return 0;
 
 	refname = refs_resolve_ref_unsafe(get_main_ref_store(data->repo),
diff --git a/config.h b/config.h
index bf47fb3afc..42aedde878 100644
--- a/config.h
+++ b/config.h
@@ -88,6 +88,7 @@ typedef int (*config_parser_event_fn_t)(enum config_event_t type,
 struct config_options {
 	unsigned int respect_includes : 1;
 	unsigned int ignore_repo : 1;
+	unsigned int ignore_refs : 1;
 	unsigned int ignore_worktree : 1;
 	unsigned int ignore_cmdline : 1;
 	unsigned int system_gently : 1;
diff --git a/refs.c b/refs.c
index 5b773b1c15..f242e6ca96 100644
--- a/refs.c
+++ b/refs.c
@@ -2359,15 +2359,22 @@ void ref_store_release(struct ref_store *ref_store)
 
 struct ref_store *get_main_ref_store(struct repository *r)
 {
+	static bool initializing;
+
 	if (r->refs_private)
 		return r->refs_private;
 
 	if (!r->gitdir)
 		BUG("attempting to get main_ref_store outside of repository");
+	if (initializing)
+		BUG("main reference store creation is recursing");
 
+	initializing = true;
 	r->refs_private = ref_store_init(r, r->ref_storage_format,
 					 r->gitdir, REF_STORE_ALL_CAPS);
 	r->refs_private = maybe_debug_wrap_ref_store(r->gitdir, r->refs_private);
+	initializing = false;
+
 	return r->refs_private;
 }
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 79fb6735e1..ce29875cdd 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -141,6 +141,12 @@ static struct ref_store *files_ref_store_init(struct repository *repo,
 					      const char *gitdir,
 					      const struct ref_store_init_options *opts)
 {
+	struct config_options config_opts = {
+		.respect_includes = 1,
+		.ignore_refs = 1,
+		.commondir = repo->commondir,
+		.git_dir = repo->gitdir,
+	};
 	struct files_ref_store *refs = xcalloc(1, sizeof(*refs));
 	struct ref_store *ref_store = (struct ref_store *)refs;
 	struct strbuf ref_common_dir = STRBUF_INIT;
@@ -158,7 +164,7 @@ static struct ref_store *files_ref_store_init(struct repository *repo,
 	refs->store_flags = opts->access_flags;
 	refs->log_all_ref_updates = LOG_REFS_UNSET;
 
-	repo_config(repo, files_ref_store_config, refs);
+	config_with_options(files_ref_store_config, refs, NULL, repo, &config_opts);
 	chdir_notify_register(NULL, files_ref_store_reparent, refs);
 
 	strbuf_release(&refdir);
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index ee92bd9c70..05d4edc6fd 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -390,6 +390,12 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 					  const char *gitdir,
 					  const struct ref_store_init_options *opts)
 {
+	struct config_options config_opts = {
+		.respect_includes = 1,
+		.ignore_refs = 1,
+		.commondir = repo->commondir,
+		.git_dir = repo->gitdir,
+	};
 	struct reftable_ref_store *refs = xcalloc(1, sizeof(*refs));
 	struct strbuf ref_common_dir = STRBUF_INIT;
 	struct strbuf refdir = STRBUF_INIT;
@@ -424,7 +430,7 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	refs->write_options.lock_timeout_ms = 100;
 	refs->log_all_ref_updates = LOG_REFS_UNSET;
 
-	repo_config(repo, reftable_be_config, refs);
+	config_with_options(reftable_be_config, refs, NULL, repo, &config_opts);
 
 	/*
 	 * It is somewhat unfortunate that we have to mirror the default block

-- 
2.55.0.rc1.722.g2b3ac350e6.dirty

