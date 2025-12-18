Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6606A34D93A
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766077950; cv=pass; b=OcgFGeBs3+UWRLzMZr7gKAitDyZuq+pfbcHgWbUJW1LDFnNr7h4XO0dP2GTyc+bttdf3a2RpDK9869rEoH5LzcGvvO47E20DQ8Yha8GQ0nkIfkNEsJH8VWuHMVsrMmZgIdEVnGpFHFw/JRiSQRAyVaZnCcE1uBvJqx0UTahH7yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766077950; c=relaxed/simple;
	bh=HaR/74dJ9U/IC9xWkp8pQH4L+zh+495uPpuLRJ4zb9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YkymsUPIQxRxB2RWqeKzbd7Nvm6Sf7KZfCORPsGwM9KKcLAfjQvV+UNW9z8s0PYZMJxxSplMEz/Krf41NFZ4gApeFZObQnNuZGo8pAQRQwlLEHO1B0jR8k4ZJ43v9vZzLn4dUgJrJTmyOGwRDKem9r8QVDC4rDl5zZEW4Wwcpzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=EajYo+DO; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="EajYo+DO"
ARC-Seal: i=1; a=rsa-sha256; t=1766077936; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fqPdHMoxWOR+oiARGX9GvV4LZf+N6I22aY9LPuu44joH2YWC+m2bR4kotIKrVAU6aLMRKspdqLuKU0cqAELXZu8JZhl7HFpEFDS1tKT1+Q6+oSvIhUDcIj5v4hw2QH9aIhee0Mh8gafIfmVOaneq6DbENrB8NnTkI4n1D0HinCg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766077936; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wxNGi05G3H3s3mNa3fs+987bxg1lXv1kCj2z9082oVQ=; 
	b=iFo4fHHh3bsXOcjLjaCJlxrulbSPo8t3ZW0K9uoT/OCLWElvTNEf83oIwx5hPD0ka1y2ggfpK+swcUyieE74ed6sYvO9YPwXxmqjMv2MXTIo3j5/4SH1CX+oElwbPaEoQ4rAgS9BIrSnhPJ/AYQ1j7r+WEuSE08BXDb2I9D8mrM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766077935;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=wxNGi05G3H3s3mNa3fs+987bxg1lXv1kCj2z9082oVQ=;
	b=EajYo+DOaKbirt5qOAbGsEkqY6kvxPR5kf4q+m1BY4Mj0VDU/szC8wb+D8Vke7nt
	1F7MwBgnA3S5dQvHttX9kYzkHwhwerS4t8zfIQWrx4SYVcqZGuwaO6qfx5KcR3MPV6y
	GloZutSld3AcpOuMyt4OneQa37BDONtTKk4O0tBQ=
Received: by mx.zohomail.com with SMTPS id 1766077933761524.9871626398156;
	Thu, 18 Dec 2025 09:12:13 -0800 (PST)
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
Subject: [PATCH v5 07/11] hook: allow overriding the ungroup option
Date: Thu, 18 Dec 2025 19:11:21 +0200
Message-ID: <20251218171126.588066-8-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251218171126.588066-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251218171126.588066-1-adrian.ratiu@collabora.com>
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

