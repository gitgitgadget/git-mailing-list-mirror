Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFE4347FF4
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764857777; cv=pass; b=qLBGXd8uQWdwnuoUgfBne0H9Q0635mRBS31cidtQporcwHkpUcPN0B2OhdbDSFuxswYJZxUagSsC7XhZ7ZHGnJOnBw8m+yqOzhszNl0ER2YHgtX0mGG4+KjjOkn2OR1qT0JlKJS/IQuRzraxErbfrHJcG8m+AVu0CAvlpv13lOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764857777; c=relaxed/simple;
	bh=XQdfyzJwxrJzncsDbdBN3MlDMNR6FOke+1Ay88iZOu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GpIUnOUDoYWSwyLLsAU8k+DZh5aSFpbOOcrI7orqCdD0SQd5UJgZ2GuPlSFYgLciJ54HHPYoGzTumALSfFwO8j2kCNeORQ7eeHKpWMAVYMvpd6lthX1tgVM++pDuqhCaWBaTEtF+4HHC/pbMBdgWbk5US2Fr6zQCib2gmTgCK5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Dd8gtkVt; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Dd8gtkVt"
ARC-Seal: i=1; a=rsa-sha256; t=1764857766; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cASRbiUH4u1lLlC3XZWSZuBhjbL4vJe2Q/CspPKfuhJk/tVprajvLMaxVYNpq46rwdDs7QxMmMTRYukVwY29SgIPeoJkHgvOsuhaPN2L71SN41TCrqTR/dXan0OnsjuZpmtu+oAYDDmo/4pp9DHHtD/s1wZ3RQuE5w7aUQrdqbk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764857766; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QEi9Ao2svq9XV+WjfgjB4uIQ8p/IBraSe4uOwDiX8sU=; 
	b=AmHozQBQFEgqPaokei1G7qhW+U80gNep5x9eyarIgHRf1dXLwqG1sfVEVXy9S66wV4GJF85IaXyj3TtTKIk3oYIDcLJgdh0YB0R7wLaioaB5QEoxurIOBldUuQAAV4hMN6WmFzsbLkauDb45CAvx9KaAf3aG1qESUOMgUEObuE4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764857766;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=QEi9Ao2svq9XV+WjfgjB4uIQ8p/IBraSe4uOwDiX8sU=;
	b=Dd8gtkVtSGblhMVL7CwRScyK6EmKvKe50mO5w1/+cUzKYfDadM8sPnO0miJwGGIb
	D+k8e37cCU2uYOvAm/SbFwUhVTUjdPTF34QcWWplhPAC6991GX65GVbl4i4AY2TDhCu
	T0Nin94CfDFkap1T2JAmm1wCIOXImiwQuCzYCGtA=
Received: by mx.zohomail.com with SMTPS id 1764857765926899.0297037853577;
	Thu, 4 Dec 2025 06:16:05 -0800 (PST)
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
Subject: [PATCH v4 07/11] hook: allow overriding the ungroup option
Date: Thu,  4 Dec 2025 16:15:31 +0200
Message-ID: <20251204141535.1986263-8-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251204141535.1986263-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251204141535.1986263-1-adrian.ratiu@collabora.com>
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
index 5ddd7678d1..00a1e2ad22 100644
--- a/hook.c
+++ b/hook.c
@@ -153,7 +153,7 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 		.tr2_label = hook_name,
 
 		.processes = 1,
-		.ungroup = 1,
+		.ungroup = options->ungroup,
 
 		.get_next_task = pick_next_hook,
 		.start_failure = notify_start_failure,
@@ -198,6 +198,9 @@ int run_hooks(struct repository *r, const char *hook_name)
 {
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 
+	/* All use-cases of this API require ungrouping. */
+	opt.ungroup = 1;
+
 	return run_hooks_opt(r, hook_name, &opt);
 }
 
diff --git a/hook.h b/hook.h
index 51cab785ea..01f91feab8 100644
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

