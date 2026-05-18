Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B4E3E63B7
	for <git@vger.kernel.org>; Mon, 18 May 2026 09:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096674; cv=none; b=YtpD4bABkE+Je00V6wiXvdkVlGXj4cvqOTsk4bQ7Zb8JC3i2S0NuRXO8kmuKgRMIBCNcP2v7iTyoYe/OpCWjuyORB4VoaqgdYTd80KZ+734byeR8d33IaMn5sA6+e49rsfcVv1x1vKKW+S+JIPgMLTx/v0fLfBcOzPGOQs3xzjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096674; c=relaxed/simple;
	bh=9boSnrGXe4/0jO5vkymUXVkoiile4dMv9/2Lcn9gsm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ufBLNDjvl3aHK8V7LMKmZKrOiUlwi2rdthNpEvYM3pHeYcb8Ob1jXga3BAPShdnm0EzaclKhUxv0w9xNTW0XtiPrql7ZC7rQJn3UckOOoP4mHUBZ3njNaVc7FlLFpTRiu0Qo1pMnxyLxrtrBuAQdQyjZQO3tSIN2tvNH+HRWjdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IEaScCsl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zl7cDJGG; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IEaScCsl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zl7cDJGG"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A08B57A0142;
	Mon, 18 May 2026 05:31:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 18 May 2026 05:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779096672;
	 x=1779183072; bh=y4gnZI9+TnK4Cet4GQUHrteUR1NwVJuLqxHuuAdsY0s=; b=
	IEaScCslITLJ6AMjNKKONUjxkpKZxQcvj3XxgzkNZDHp0Apv+scKWSrumBuSdBoM
	D6jkphWgBqrhQRkH+dEj0lmOFzOmZeRhhUY990YQ5jYjj9nK6+cYVB4MtMODsFIS
	kLHMUab3CzsJ1iAyzLZ12wwo1BzsKSWIXyQ3za0J91WuWptMZXjdXHVwBuUT2Jn/
	2X7fDYMtyt+Ko/8OoV6ubGwZkKbCqODqMMaZCaBFtSXhYL/kHA5sAvDNec0lnhn5
	iaUQIDi1aDYFO5khjyGVHtE64pVryl3G6p//1dpmPXVhvy/o74ZPBwB2lqNnbjzF
	X2KgxEG710BV5zjqI5WPug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779096672; x=
	1779183072; bh=y4gnZI9+TnK4Cet4GQUHrteUR1NwVJuLqxHuuAdsY0s=; b=Z
	l7cDJGG/l8FXIoddzJtlnWc52Iy/+bi9TBP4HmelLm/WxeiDKXkH6P9P7Gpot1e9
	gwAJHRethxkTNAC+a6vIvexyg9tk85ZZ6Tedvf3o2cOFkQ8iLwSDc5susNXfScX9
	BiCDQLZe6ruOkmcgU5eTUBomXdU5mIECNq3CuihowOKCtU3k/zaSA8xLgrjQqrpX
	vNWjMolO0f9IRaF2s3HDzeeWQs3ubqQ1m3C2/2qsz/wdhqLnUY559/s0eqRHOqFx
	cI7ieCn5/2HMdl8SGwOeZefwfmJ05Z/v5OWuVfcrLs3yJrNf9Utpi3zyrjdSjVzz
	gIkgy19KnBK3ukxomG24g==
X-ME-Sender: <xms:YNwKaqOIZ7FB3jMvL-Bk1piHc5Ha3FrJJFhsaihm4XZoeTJEpSxRrw>
    <xme:YNwKav2FSPnpofGncu3q3j8Ik4Mwxfc5tiltpmUzRlwj9Dq19xIt412ZiM7S7pFUo
    _OjpGMWOEuZpVTsP2ZvH8LJj4rkE-z3xlxOlFQ2ceGcEQd4Sh_foA>
X-ME-Received: <xmr:YNwKapntkNrRas2MiqY-0uG-9KbczUcXoW98Ietpz7kLwM0dtuW9FooF9bQk8RbRhtSN4tsUN3OeV11hPQ5s3h_m2oJWAJgPHcdhFEMcbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htoheptggrthesmhgrlhhonhdruggvvh
X-ME-Proxy: <xmx:YNwKamXK2YGxZOz_J9xc2e9g7iXIA3A5niAITcCzcJYi_ojBHR0i9g>
    <xmx:YNwKavunw1WCiNbG5fNOGTDVWx0uAVQ1eygPhm7BCFPSP6JYK4VuUg>
    <xmx:YNwKapZhmtadJyaQwO4FhYeI3OHXmOoM9RzdTvoS1X7fwHDgZ4__GQ>
    <xmx:YNwKauWY6XN43wLHcClEJo2FyZpRtSSLTRJnuijEp0e2yhjgyk_foA>
    <xmx:YNwKahH17Ihp4C6TwuCEAxiAEpdaCL_J9xwvSGtUXMDNiumjTToV33iP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 05:31:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6505a933 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 May 2026 09:31:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 18 May 2026 11:30:53 +0200
Subject: [PATCH v2 02/18] setup: stop using `the_repository` in
 `is_inside_worktree()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-pks-setup-wo-the-repository-v2-2-6933c0f1d568@pks.im>
References: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
In-Reply-To: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
X-Mailer: b4 0.15.2

The function `is_inside_worktree()` verifies whether or not the current
working directory is located inside the worktree of `the_repository`.
This is done by taking the worktree path and verifying that it's a
prefix of the current working directory.

This information is cached so that we don't have to re-do this change
multiple times. Furthermore, we proactively set the value in multiple
locations so that we don't even have to perform the check when we have
discovered the repository.

While we could simply move the caching variable into the repository, the
current layout doesn't really feel sensible in the first place:

  - It can easily lead to false positives or negatives if at any point
    in time we may switch the current working directory.

  - We don't call the function in a hot loop, and neither is it overly
    expensive to compute.

Drop the caching infrastructure and instead compute the property ad-hoc
via an injected repository.

Note that there is one small gotcha: we sometimes may end up with
relative directory paths, and if so `is_inside_dir()` might fail. This
wasn't an issue before because of how we proactively set the cached
value during repository discovery. Now that we stop doing that it
becomes a problem though, but it is worked around by resolving the
repository directory via `realpath()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/ls-files.c  |  2 +-
 builtin/rev-parse.c |  4 ++--
 object-name.c       |  2 +-
 setup.c             | 25 ++++++++++++++-----------
 setup.h             |  2 +-
 submodule.c         |  2 +-
 6 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b148607f7a..09d95111b3 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -703,7 +703,7 @@ int cmd_ls_files(int argc,
 	if (dir.exclude_per_dir)
 		exc_given = 1;
 
-	if (require_work_tree && !is_inside_work_tree())
+	if (require_work_tree && !is_inside_work_tree(repo))
 		setup_work_tree();
 
 	if (recurse_submodules &&
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 218b5f34d6..52709ca69b 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -1006,7 +1006,7 @@ int cmd_rev_parse(int argc,
 			}
 			if (!strcmp(arg, "--show-cdup")) {
 				const char *pfx = prefix;
-				if (!is_inside_work_tree()) {
+				if (!is_inside_work_tree(the_repository)) {
 					const char *work_tree =
 						repo_get_work_tree(the_repository);
 					if (work_tree)
@@ -1068,7 +1068,7 @@ int cmd_rev_parse(int argc,
 				continue;
 			}
 			if (!strcmp(arg, "--is-inside-work-tree")) {
-				printf("%s\n", is_inside_work_tree() ? "true"
+				printf("%s\n", is_inside_work_tree(the_repository) ? "true"
 						: "false");
 				continue;
 			}
diff --git a/object-name.c b/object-name.c
index 21dcdc4a0e..37a9ce8e87 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1703,7 +1703,7 @@ static char *resolve_relative_path(struct repository *r, const char *rel)
 	if (!starts_with(rel, "./") && !starts_with(rel, "../"))
 		return NULL;
 
-	if (r != the_repository || !is_inside_work_tree())
+	if (r != the_repository || !is_inside_work_tree(the_repository))
 		die(_("relative path syntax can't be used outside working tree"));
 
 	/* die() inside prefix_path() if resolved path is outside worktree */
diff --git a/setup.c b/setup.c
index ba2898473a..b316d9aaa8 100644
--- a/setup.c
+++ b/setup.c
@@ -27,7 +27,6 @@
 #include "worktree.h"
 
 static int inside_git_dir = -1;
-static int inside_work_tree = -1;
 static int work_tree_config_is_bogus;
 enum allowed_bare_repo {
 	ALLOWED_BARE_REPO_EXPLICIT = 0,
@@ -299,7 +298,7 @@ void verify_filename(const char *prefix,
  */
 void verify_non_filename(const char *prefix, const char *arg)
 {
-	if (!is_inside_work_tree() || is_inside_git_dir())
+	if (!is_inside_work_tree(the_repository) || is_inside_git_dir())
 		return;
 	if (*arg == '-')
 		return; /* flag */
@@ -477,11 +476,20 @@ int is_inside_git_dir(void)
 	return inside_git_dir;
 }
 
-int is_inside_work_tree(void)
+int is_inside_work_tree(struct repository *repo)
 {
-	if (inside_work_tree < 0)
-		inside_work_tree = is_inside_dir(repo_get_work_tree(the_repository));
-	return inside_work_tree;
+	struct strbuf buf = STRBUF_INIT;
+	const char *worktree;
+	int ret;
+
+	worktree = repo_get_work_tree(repo);
+	if (!worktree)
+		return 0;
+
+	ret = is_inside_dir(strbuf_realpath(&buf, worktree, 1));
+
+	strbuf_release(&buf);
+	return ret;
 }
 
 void setup_work_tree(void)
@@ -798,13 +806,10 @@ static int check_repository_format_gently(struct repository *repo,
 	if (!has_common) {
 		if (candidate->is_bare != -1) {
 			is_bare_repository_cfg = candidate->is_bare;
-			if (is_bare_repository_cfg == 1)
-				inside_work_tree = -1;
 		}
 		if (candidate->work_tree) {
 			free(git_work_tree_cfg);
 			git_work_tree_cfg = xstrdup(candidate->work_tree);
-			inside_work_tree = -1;
 		}
 	}
 
@@ -1252,7 +1257,6 @@ static const char *setup_discovered_git_dir(struct repository *repo,
 	if (strcmp(gitdir, DEFAULT_GIT_DIR_ENVIRONMENT))
 		set_git_dir(repo, gitdir, 0);
 	inside_git_dir = 0;
-	inside_work_tree = 1;
 	if (offset >= cwd->len)
 		return NULL;
 
@@ -1288,7 +1292,6 @@ static const char *setup_bare_git_dir(struct repository *repo,
 	}
 
 	inside_git_dir = 1;
-	inside_work_tree = 0;
 	if (offset != cwd->len) {
 		if (chdir(cwd->buf))
 			die_errno(_("cannot come back to cwd"));
diff --git a/setup.h b/setup.h
index 80bc6e5f07..7c0aa75319 100644
--- a/setup.h
+++ b/setup.h
@@ -5,7 +5,7 @@
 #include "string-list.h"
 
 int is_inside_git_dir(void);
-int is_inside_work_tree(void);
+int is_inside_work_tree(struct repository *repo);
 int get_common_dir_noenv(struct strbuf *sb, const char *gitdir);
 int get_common_dir(struct strbuf *sb, const char *gitdir);
 
diff --git a/submodule.c b/submodule.c
index b1a0363f9d..a939ff5072 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2620,7 +2620,7 @@ int get_superproject_working_tree(struct strbuf *buf)
 	int code;
 	ssize_t len;
 
-	if (!is_inside_work_tree())
+	if (!is_inside_work_tree(the_repository))
 		/*
 		 * FIXME:
 		 * We might have a superproject, but it is harder

-- 
2.54.0.771.g3ed373ac14.dirty

