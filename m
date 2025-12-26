Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3A131DD98
	for <git@vger.kernel.org>; Fri, 26 Dec 2025 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766751913; cv=pass; b=DNIe+zSjP88LpsEo6Z+8vB6StksfNv8fSsplqBtrIgy4anJQcmffmQ+eVZfErFKRvan2iaVhIOjwSrIL6PU//yqFLRE0+AEWW/srB3jPmGJkLPTUCWNhH6opSI5WRqc1lzod8AfaM7DfSj4GmrZLlv13t0WOBguLO8vFnfJDJqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766751913; c=relaxed/simple;
	bh=HaR/74dJ9U/IC9xWkp8pQH4L+zh+495uPpuLRJ4zb9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dg7F5B7FFN6EMQaEqOYZbIXuClLN9IzhaVkfEf0/vCX2JlXVQXR2MlbLbBRcROB7ffDlyy4Zbsk7coAuD4QE0HpsZFFYFQexPpFUWJiZTWk9hExJfDucwTnf/hLpnKV65AdJRpXlpZ8iHrXbGOKQP5RWW804AxLYArGO6Xuaqds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=h9PuanLU; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="h9PuanLU"
ARC-Seal: i=1; a=rsa-sha256; t=1766751897; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=n+Ca40wDehskUT+XncBcE12kO/rFX3r12dSEEhF2bZNOK+LRwQTdYcZGgYZQK2uHqThz1bNh3rrFVKkq8Wy69XwyHh/d3ofvjtur967uisLvrHPw//GuZLcoNvXJQ7DnhOcqvdMdwYR6JFVBqTAnYlTACNm6UqHhJgwpm7pmNbc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766751897; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wxNGi05G3H3s3mNa3fs+987bxg1lXv1kCj2z9082oVQ=; 
	b=jLw7uV61d27TPOS5PZn4tFRSjEC66tHQ+oVJSsmsTVFbN7FQsmTC7okp+ia5pc6pvz8D+2sYcZdgkkFfgQuWU93HqT0JTk6DXNJVI/64N3s0R6oKta000BAk1D33Z1O7Ejmdu39/wfti70eWVHUjx0evUgO639zu5PG7tqqi4WE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766751897;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=wxNGi05G3H3s3mNa3fs+987bxg1lXv1kCj2z9082oVQ=;
	b=h9PuanLUp8dH561ae7suajXbl0ogr/JYoSj1i6I4c+9moK0SU09D4yEPP0Mfwuxj
	pOWrkGOyCxzwrvqsAcwPGGBz0BH2ht570FBNadV8nM5hgPz6/hCYT0xJWehkcuUJBN8
	iDT/mTFPy2WKxJwJag/k4nSo7dKkqeLkMZUe8YWc=
Received: by mx.zohomail.com with SMTPS id 1766751896436271.5029964207122;
	Fri, 26 Dec 2025 04:24:56 -0800 (PST)
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
Subject: [PATCH v6 07/11] hook: allow overriding the ungroup option
Date: Fri, 26 Dec 2025 14:23:30 +0200
Message-ID: <20251226122334.16687-8-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251226122334.16687-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251226122334.16687-1-adrian.ratiu@collabora.com>
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
index 709c9eed58..2527f15d9d 100644
--- a/commit.c
+++ b/commit.c
@@ -1978,6 +1978,9 @@ int run_commit_hook(int editor_is_used, const char *index_file,
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
index 2169d4a6bd..78a1a44690 100644
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
2.51.2

