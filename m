Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792759849;
	b=2QOW7NwMn1nsKUjDwdskC8dGbPhUDtV+5noV/801Kb6AYA2GOmzjQbHfFq0XovBA7l19
	 hlqns6kvk3X9+riq4OxyFJfOSXV7NOAQzRtE9+3DE38MPRhA9C7qGTao7ga3bpXJiTXXR
	 rgsTEwjBmGv901iFe4na2r4ibpJp1n2UVpz2GITAFkiDi19l0XyMwZSV6ma94lieZolCI
	 8lL4MLcIQAwoZN5Hv70CYnZffJ840pClRMbjVfh9X+W+OgGQMEiyaatWxFagx021lX6Fd
	 ZJBz4L5KydCrMnrARBkNP8UQHfFb0a0EYja9lyQNeiCmks3ok9aeNBdwqVOGzsAU3sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759849;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=v29RY3EOhVCiqiqE74sLlyixq8JPz163h/P7/V3tMk4=;
	b=ilx/EXq6rD0TzmFn5JG8QhgfL0N8nr/JLU7BIfJRoeY20dVZlGI+EEIdo4CeW/wWqoUP
	 N2sl1XPONbIHI+/zfzs4+z8teMUje1rAd3LgPVRNjPyT2sbaEOK7r7g/iJynAVN9iyaR4
	 xi3mBxCxLhewGRUEcnTrwIb2mV/4eW9QkQTzVcoh7F6H3C3VXVWPeiWoVAf1jyVpb3YbH
	 9zlzJqlpYxMMh4sXCycncxE50jCgDqgv/W30Cu3BEZu6nUhGi+FF5s2+pHDB1gw04GXRr
	 Bo0dEMJwi8C18bGZoxaBRZYOURVrRV4b+9G4FnvfXnrMugz5UxXzS6WsyOW6B8iu7zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b="aaYK08/t";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Rx2L9wOe;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36D9606A31D
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 12:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B36D9606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=aaYK08/t;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Rx2L9wOe
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 1B8181D00045
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:50:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 23 Oct 2026 08:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792759847;
	 x=1792846247; bh=v29RY3EOhVCiqiqE74sLlyixq8JPz163h/P7/V3tMk4=; b=
	aaYK08/tzt3YiYPqgduiANe2qVRtyswSXRbcc+CVlhXkiTSwZ+FC0cvlrf6q1UUN
	gGLvrjIIrR1BgCFTQHFFrxdanfHcWewRSR8OXnRloe3VhXJvThRyxiC3FJt+6jyJ
	YXPUB8vIUXUgOup7f/zw5IuOmp7NPYN1JIB9li7kwH8AcqRDpu8E5yOjJJEZxxWO
	MedrXKlxAe90YEEcPKy7CUW+SWZ88YtmJHg24nRfnHWwgAqlzprwafnHcYTNWl2P
	ATU/ZKCoh+VBpSrM+2HR/O1PyNt8rYB4BW6cUIxGHW9itt0yLw8LbbCNz+iVqFRl
	mW8ShwBbWFxjVscC8WHNRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792759847; x=
	1792846247; bh=v29RY3EOhVCiqiqE74sLlyixq8JPz163h/P7/V3tMk4=; b=R
	x2L9wOejG6nXXlbEp/43PxQqst0fbYocN248tvVFWNZFHwGLOPDd76MCnHMs9xRJ
	I2p+J5sZaTVjpMqjHTQWm95JVaeODdRnMRV1QChREr1N6XmhVXSJqxa7LelKOVqp
	kHRtHoUu0L3WVm22WvJ4iqrU/D0u0jg91oINZWEcQWYnaYcaOvwfFV7UfO7M2RG3
	Mjqsk4JGgu6roHCXp0+dIiYzprBIUU1AEmK24zf+IDebJLZdVy2geyV/gTL0bvnG
	iE8lnPoGbAs9HydN/sQr0O+fDrpPjJHB6EG+xdNlSrdJcpwD0t2yjizvxObuf+9Q
	fd6fiiifMjZSZFWjbgA/Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792759847; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:IjkbSWGexm6YioqvMjBDR9v9Uz19FDPofd1KUki3Q7EiO5i
	sXTqAJ6sR/j/j+lNeWioecE5hDlgbGR2soFStDFDuCx2pSuWI1ARlo1MVQIQZMR2
	F8jK66YCS5heJuMmun7qMPyr/ryHu1nhXvWwobhln4eb/0zVyfuBkHNrcKdw/Hbn
	dOn/dSDDpd/N0UdVJfQ0A46dQNRnVuGO+0Z0y2iZvb5rZ5eWvT0izBdHhX0WgpZw
	yZOzNfOagCpSTelMSaFFgRrhY5Ge+qWldnNisyTAj0d5gN5Zs8S1Puxhlr3tfZoy
	SsXTAV1nz0Kq9coXh0UgqCkOXnPKOfkbawV6hbQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:VFaiHWSAYcaAldn/CaQoMLHZO0NSDMQ0MzRypvX3gJ8=:HsiKGWTf9eBpKWij40Otc0UqKu0/fm4uMTJgMny1riM=;
X-ME-Sender: <xms:J1jbaqrbvqRJ9fd24v-LxemzPy764XTxcjogtLnbmoGWl-3kK-7-ug>
    <xme:J1jbavlX9jEhACpc_Ssu_rGqcPgaIpqvyfJ5NpnvmFSS1NiMARuko3lEOctyZT6LF
    1mojV6iH9nJbqgVcc5TPnV-s_1xVhypsPu8XwjkEDvnmgyGDGOWSAU>
X-ME-Received: <xmr:J1jbak2WmxzpQlC7zGwJnaII4WVkHAwLXtDPDh9Pz22KPKeehKMaZftUW61n5M7VfI3Pmg>
X-ME-Proxy-Cause: dmFkZTGqNuAd1/xXSkVpjRGwpg8ruCWl6SmqOphFYTWvsnIwKxkcEYhnMN2aeMunw78weI
    hd3WZPzhRTxd3w/shofImYxiwLdJ0byPH6NZx/1Cn2ueSoP/lmw8nDe013bC/eIEbp9Snb
    6yo16Dcj5aY0LE0tZwWYQ/lJ8H93jdbTIkZy/xVdf4BYvhi1Sh2VWHoopSIJlhN7evHEE9
    HMRPknYvfUUkrGNA+VvBsjBQwm9t/3En9rtyVpnQZUVWETWV7HHQtzJS+YNZ33BrW6ong7
    t4EF79vc+lyYhgbrBnt+bMwq3ZpiLhOl3NHQTApCD7jBa2nV7FteS8HSCEptRNT5AjJ9t+
    NUEC76lPHIFnVfAHPqRnRMvK7Ng3u7G6EDSPakqCqYIBvQx83zOZBg83brQ6BFZ8CwugnQ
    J1GB6qC0ccQpC2WczAY6PVuSS4nwyZtCq5hN3n2XevcPyBpFre0TU7j8bSQZeazSF1Pj84
    xYCI56/knMNiG8t+x6gsN6SEiieyFVCGvwBQ8bdwIeiQ0jZm/JwP4jCBHoaabY8qIeDLRn
    hw00egjjZNXfZ+QKqnMkGYgRvLHQt6wWVBySMPoweh0DjA55QsSy1TH8CyMz4X4D+oPksF
    80tsiwn6ZLAIvMxe5jZ3FkSAI6BSFH7A4OIahXQC6tUjeTiOsufwVkfm6brQ
X-ME-Proxy: <xmx:J1jbavCtubTmPF4kYTSXekcnF9_fN9qE6xF0xghykhk8cD3LXQQ8KQ>
    <xmx:J1jbapykud_UXwvTM6nRLyiWwiAJmhp4VpXYgOSWLCm1DGbXZxszQQ>
    <xmx:J1jbalkratVWxTx_iCiHcI-EDqZUgdOHL4rrchLM3UM9oSAKWk7jvQ>
    <xmx:J1jbamF0MXSmtKNhsw026P4IfisGDNG3xVeJD66pyEUUz_jcC9FndA>
    <xmx:J1jbamJZNYn0vEYJ_EtrSnf4xH6OwUgrQ2wMU0zPaUbk4BzrQX6Ei1ob>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 23 Oct 2026 08:50:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8472074b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 23 Oct 2026 12:50:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 23 Oct 2026 14:50:21 +0200
Subject: [PATCH 4/7] rerere: cache result of `is_rerere_enabled()`
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-pks-rerere-wo-the-repository-v1-4-b6ac0c2e4b81@pks.im>
References: <20261023-pks-rerere-wo-the-repository-v1-0-b6ac0c2e4b81@pks.im>
In-Reply-To: <20261023-pks-rerere-wo-the-repository-v1-0-b6ac0c2e4b81@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The function `setup_rerere()` reads the rerere configuration and then
figures out whether the rerere cache is enabled after all, either
because it has been explicitly enabled or because it's implicitly
enabled and ".git/rr-cache" exists. Whether the cache is enabled will
not change in a single process though, so it does not make sense to
reevaluate these conditions every single time `setup_rerere()` is
called.

Adapt the function to instead cache the status of the rerere cache via
a new `struct repository::rerere_cache_enabled` member. This allows us
to get rid of the `GIT_PATH_FUNC()`, which caches the path to the rerere
cache directory. But now that we already cache the enabled state in the
first place it becomes moot to cache the path, as well.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repository.c |  1 +
 repository.h |  6 ++++++
 rerere.c     | 43 +++++++++++++++++++++++--------------------
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/repository.c b/repository.c
index e584d6c405..f51699a6dd 100644
--- a/repository.c
+++ b/repository.c
@@ -76,6 +76,7 @@ void initialize_repository(struct repository *repo)
 	repo->bare_cfg = -1;
 	repo->fetch_if_missing = 1;
 	repo_config_values_init(&repo->config_values_private_);
+	repo->rerere_cache_enabled = -1;
 
 	/*
 	 * When a command runs inside a repository, it learns what
diff --git a/repository.h b/repository.h
index 91b1f57db7..86795b6946 100644
--- a/repository.h
+++ b/repository.h
@@ -185,6 +185,12 @@ struct repository {
 	/* True if commit-graph has been disabled within this process. */
 	int commit_graph_disabled;
 
+	/*
+	 * Indicates whether the rerere-cache has been enabled. -1 (the default
+	 * value) causes us to perform auto-detection via ".git/rr-cache".
+	 */
+	int rerere_cache_enabled;
+
 	/*
 	 * Controls whether the repository should lazily fetch missing
 	 * objects from promisor remotes. Defaults to 1.
diff --git a/rerere.c b/rerere.c
index 56b6ef547b..8fa921fc8f 100644
--- a/rerere.c
+++ b/rerere.c
@@ -27,9 +27,6 @@
 #define THREE_STAGED 2
 void *RERERE_RESOLVED = &RERERE_RESOLVED;
 
-/* if rerere_enabled == -1, fall back to detection of .git/rr-cache */
-static int rerere_enabled = -1;
-
 /* automatically update cleanly resolved paths to the index */
 static int rerere_autoupdate;
 
@@ -873,40 +870,46 @@ static int do_plain_rerere(struct repository *r,
 	return write_rr(rr, fd);
 }
 
-static void git_rerere_config(struct repository *r)
-{
-	repo_config_get_bool(r, "rerere.enabled", &rerere_enabled);
-	repo_config_get_bool(r, "rerere.autoupdate", &rerere_autoupdate);
-	repo_config_get_int(r, "rerere.locktimeout", &rerere_lock_timeout_ms);
-}
-
-static GIT_PATH_FUNC(git_path_rr_cache, "rr-cache")
-
 static int is_rerere_enabled(struct repository *r)
 {
 	int rr_cache_exists;
+	char *dir;
 
-	if (!rerere_enabled)
+	if (r->rerere_cache_enabled != -1)
+		return r->rerere_cache_enabled;
+
+	repo_config_get_bool(r, "rerere.enabled", &r->rerere_cache_enabled);
+	if (!r->rerere_cache_enabled)
 		return 0;
 
-	rr_cache_exists = is_directory(git_path_rr_cache());
-	if (rerere_enabled < 0)
-		return rr_cache_exists;
+	dir = repo_git_path(r, "rr-cache");
+
+	rr_cache_exists = is_directory(dir);
+	if (r->rerere_cache_enabled < 0) {
+		r->rerere_cache_enabled = rr_cache_exists;
+		goto out;
+	}
 
 	if (!rr_cache_exists &&
-	    safe_create_dir_in_gitdir(r, git_path_rr_cache()))
-		die(_("could not create directory '%s'"), git_path_rr_cache());
-	return 1;
+	    safe_create_dir_in_gitdir(r, dir))
+		die(_("could not create directory '%s'"), dir);
+	r->rerere_cache_enabled = 1;
+
+out:
+	free(dir);
+	return r->rerere_cache_enabled;
 }
 
 int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
 {
 	int fd;
 
-	git_rerere_config(r);
 	if (!is_rerere_enabled(r))
 		return -1;
 
+	repo_config_get_bool(r, "rerere.autoupdate", &rerere_autoupdate);
+	repo_config_get_int(r, "rerere.locktimeout", &rerere_lock_timeout_ms);
+
 	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
 		rerere_autoupdate = !!(flags & RERERE_AUTOUPDATE);
 	if ((flags & RERERE_READONLY) && (flags & RERERE_NOWAIT))

-- 
2.56.0.307.g5fe7bd680c.dirty

