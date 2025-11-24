Received: from sender3-op-o12.zoho.com (sender3-op-o12.zoho.com [136.143.184.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA083188596
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764004890; cv=pass; b=YQvF52xpu5CpePo9e967EcifUFFCefXajlu929oGNmFcexpduyLih5CjYzatsHgZlo6DiiQLYwNw0jOUDUwAY7uEGFU8XJdbW/MqSVcx5bGtw3uj99CJhRD4ILKt0jaxNqDe86gMG7T5Vt/JBRduhxGStMgXbxLDzlwWrj2kGhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764004890; c=relaxed/simple;
	bh=REMwakTBZazfeC+WavvgAG1rIZC3oTOm7ySF1IDZE68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVpb/ZpFeypfBBKqhiAZPKKKLfzkKJc/b4j6wBWS84nqvJgZ55V17rf5YpfnKZLO9Rc1B4Xeb4wTbvJxZ9OiHJYtJ1tnOrA2lT2OBWYKXNuC/4yGxKxED8/2J24jmy/XZPoonuQW0brLE7bW5K88Xq2CEQIYjgjzGcsHVfsIlxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=OXOAl6Mw; arc=pass smtp.client-ip=136.143.184.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="OXOAl6Mw"
ARC-Seal: i=1; a=rsa-sha256; t=1764004877; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=C/9zxsF75gx1p0TXN2r10yZi8UqUd+gjlVoCBDmT+JzbEbYC9+6bNfbOqo5H9mTuuvanacDA0riLHANpDYuxRNPKahCFIVCgtlJNQsPa6UHblD2E7yBN2wJBLsm/FcbPctfDplClUuD0SpbTnsXIoY5KDv9boSujcT5sD7D9gRQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764004877; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Uel3oB2ns6dBL3tBpJoOI5a/8j/wn5CPG2AOLAebgJY=; 
	b=IOjGx6ZSvk/CYvnBo0SjjDqJiKAx7TuOtqd4Rk8oeHAPq3gQbrzy5aqxezzpbn9QvfLMNqXpG2PvuBtCw1N3FxZdDEj0Z9jos0cirgb9hnD/ZjeJC5q1Yl8jQ/++VK6EjX52JiWXfN5ee0RvbTwRuVs6ejS7VkUjk4sl6VPOQCo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764004877;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Uel3oB2ns6dBL3tBpJoOI5a/8j/wn5CPG2AOLAebgJY=;
	b=OXOAl6MwhEGTbwUPj+cCIdTCi4T247T4W7AKdn67t2RrHEfalUCeCxIZmVSXayHR
	l8X9QbxpAzHrw56SuE00EnQ0KVzwl7aMS8PmvCrptUYYTkS7l4pJxFuBME5ciWld0IR
	kMtFSm9fy6OXBnGoBIw5bfQg52k/drkTXs/Nv1n0=
Received: by mx.zohomail.com with SMTPS id 1764004875059441.6781800788573;
	Mon, 24 Nov 2025 09:21:15 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 06/10] hook: allow overriding the ungroup option
Date: Mon, 24 Nov 2025 19:20:39 +0200
Message-ID: <20251124172043.1650014-7-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251124172043.1650014-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251124172043.1650014-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

When calling run_process_parallel() in run_hooks_opt(), the
ungroup option is currently hardcoded to .ungroup = 1.

This causes problems when ungrouping should be disabled, for
example when sideband-reading collated output from child hooks,
because sideband-reading and ungrouping are mutually exclusive.

Thus a new hook.h option is added to allow overriding.

The existing ungroup=1 behavior is preserved in the run_hooks()
API and the "hook run" command. We could modify these to take
an option if necessary, so I added two code comments there.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/hook.c | 6 ++++++
 commit.c       | 3 +++
 hook.c         | 5 ++++-
 hook.h         | 5 +++++
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/builtin/hook.c b/builtin/hook.c
index 7afec380d2..73e7b8c2e8 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -43,6 +43,12 @@ static int run(int argc, const char **argv, const char *prefix,
 	if (!argc)
 		goto usage;
 
+	/*
+	 * All current "hook run" use-cases require ungrouped child output.
+	 * If this changes, a hook run argument can be added to toggle it.
+	 */
+	opt.ungroup = 1;
+
 	/*
 	 * Having a -- for "run" when providing <hook-args> is
 	 * mandatory.
diff --git a/commit.c b/commit.c
index 16d91b2bfc..7da33dde86 100644
--- a/commit.c
+++ b/commit.c
@@ -1965,6 +1965,9 @@ int run_commit_hook(int editor_is_used, const char *index_file,
 		strvec_push(&opt.args, arg);
 	va_end(args);
 
+	/* All commit hook use-cases require ungrouping child output. */
+	opt.ungroup = 1;
+
 	opt.invoked_hook = invoked_hook;
 	return run_hooks_opt(the_repository, name, &opt);
 }
diff --git a/hook.c b/hook.c
index cd2bb7418a..89c7a7a9cb 100644
--- a/hook.c
+++ b/hook.c
@@ -147,7 +147,7 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 		.tr2_label = hook_name,
 
 		.processes = 1,
-		.ungroup = 1,
+		.ungroup = options->ungroup,
 
 		.get_next_task = pick_next_hook,
 		.start_failure = notify_start_failure,
@@ -192,6 +192,9 @@ int run_hooks(struct repository *r, const char *hook_name)
 {
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 
+	/* All use-cases of this API require ungrouping. */
+	opt.ungroup = 1;
+
 	return run_hooks_opt(r, hook_name, &opt);
 }
 
diff --git a/hook.h b/hook.h
index dd87326a5a..dc9eff1e57 100644
--- a/hook.h
+++ b/hook.h
@@ -34,6 +34,11 @@ struct run_hooks_opt
 	 */
 	int *invoked_hook;
 
+	/**
+	 * Allow hooks to set run_processes_parallel() 'ungroup' behavior.
+	 */
+	unsigned int ungroup:1;
+
 	/**
 	 * Path to file which should be piped to stdin for each hook.
 	 */
-- 
2.51.0

