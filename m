Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED57C32E135
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710655; cv=pass; b=k6s9EbBH7F2Nf0kYChdy/hMolGDi/tI5KoQgEAmaFZvt3hpKk2qyIgS4XJ/4kTdEjxHzxdSg4eD+xK9w0+ViGyMd1yWUgeHlpLiZ6Um1bQ+jMtmCLme1oI0/GrAtBvbwAynonA2clF7RIMj2CmCceJk9Eq7Hm9GchUQfSiCqOKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710655; c=relaxed/simple;
	bh=sfQ/BABe5F7MVYhHlEVtmY28vkM1BoKqsVHdALIirlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1vTju9Mds/kKQwRf2Ymv8bDYkVRX1p8McLSwJwp+D4/sQHTB30QgpVvCzh7D5vZcnTre9WreQEs5Ouol24lZXta66uJOCcMvZcS7jDZ+rctr+Who4jH38gv/hw0+jm/yTh+kRxABOvj12cYIE3Ogv5to1FoZlotlWOQ+7Y9+/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=LwSLXeMA; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="LwSLXeMA"
ARC-Seal: i=1; a=rsa-sha256; t=1760710645; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WCpn8ex1e1UP19x2kUcnl6J0Khbn0MGVtP0GA96zLQPNKraYGz4RbuVQ/xefkpcMXV3AkNokbIpmf9YttjD8sDIYfJOKzp4nbs3grRPwQUmkNIwxsneO4RwXBz0AqH38y/Eiu0ugr493GsjmrSyKGjiW8UT/JcIxQNS8w16rW4o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760710645; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nTAySWY++fo+w88YUNP79MsbdBSkZHPSHLWpZaPA8wA=; 
	b=Z4LLWxIYaour+EtEceqBRGGViV9U6TZh6/ygXIj6c1WOP/VnlnVJn4BzEr8dK2KxMn9AlSxiclnsszN9Yc7/XhRd3D1FeSEmYKMu+vrI6Yt1YdM9/WvRKyWY6MHy2JrhCUUN6fLXNw1ZiACIydLTo1r3anDt2iaL0Js9m7yhRsU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760710645;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=nTAySWY++fo+w88YUNP79MsbdBSkZHPSHLWpZaPA8wA=;
	b=LwSLXeMA56YTIW6F1gBypP/uNCcdWWD3ejEpSWumQ09e7uruscU/vDx/ugOR9sFj
	coCzaKJdsZQZ9zxJ5LAfJE08dcHIeUtfjVFymGnmxORapJFLRCMjDRbIYNzSOSi5qGF
	vayXlGF2+pkZ/ganpZpw6pUPClMLgAGNWwgJQHeI=
Received: by mx.zohomail.com with SMTPS id 1760710643859822.1065217318193;
	Fri, 17 Oct 2025 07:17:23 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 06/10] hook: allow overriding the ungroup option
Date: Fri, 17 Oct 2025 17:15:40 +0300
Message-ID: <20251017141544.1538542-7-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251017141544.1538542-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-1-adrian.ratiu@collabora.com>
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
index 7537cf0f9e..a325c7cb8c 100644
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
index ebe5dc450e..82b3d1dd27 100644
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
2.49.1

