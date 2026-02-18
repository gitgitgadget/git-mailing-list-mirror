Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9B73358B6
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 22:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771453480; cv=pass; b=nvmjA8yXf03Tg2nhtW2yoUPGUx3cy5CtrbpvF+Nuqz8a4IMU8YBfcxyXTuLVS/aP2+ipVuaRQr5gZGMbHknF8OxXPlL3O3xxqq9Z6Tpa5KJuNvgLzdDVLKGNPf13Xd7ctq2ZDRFmNnpqYwOExI6yKzmcYuk3ezXu+LFSUuSGIIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771453480; c=relaxed/simple;
	bh=ai18Zofr5WqEIKTS5le2q/WPX3AU10OpLgwMZ09cXoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVBzZs+OlRXtOY3eS88W2S7M8i7ux8jHUkcxoh6d0wpEFGQBhhLjhanYIlkUloo++m4/CXqJI9pfvaCN+HLuqZWRG7aDnLtJJGF083/EU1uIADejUJWX331ufQs10OfjY9v/iig6FpcDIZhUecbHvN2oe2kRlj75/VXiO1qypGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=KZUYNkuv; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="KZUYNkuv"
ARC-Seal: i=1; a=rsa-sha256; t=1771453467; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=oH2SEcjg5owODA0ENTIDlLwUbX1CgHr6zILF5SWk0iuB4raQAOWyf/fmwmV0IxTkELYWoBUhCMcpGcDKSg+ff909XP01AeMFYaxN0EDw3/ZAmCQmzhj+Ahvif2Y5z+9V13Gqc63P3Z24OXeV4v0J/QWDzMkN9p2CTZTARCMR8/g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771453467; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xtb9lPKIsotLZkHKqY49caQUGNsJf18gn2uG0ot5D/U=; 
	b=lPdaxxR1PPuVF5H9Ii3pp6n2SB1NdlubrAWPZZvgNGtS2dqjtYixy8YNgmfRNlTFBorayc6AuJVEI97T/7SOZ0f0xxYTiFVOngykQWc4hoPIx5u5cGEXdCzjQinJHQN8scB3qe2S1HGiQ3bspngLdAHtj4amVPcbgYnlk/sHBJQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771453467;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=xtb9lPKIsotLZkHKqY49caQUGNsJf18gn2uG0ot5D/U=;
	b=KZUYNkuv4+StfkbZ8KnhOXgs8rj7wbj/rqde1K5smr5w3A72uNC+/3I8b5JlRniK
	VgEVHzTnxBkYWRFXt2bDjU9PFzEeAjMYICUUX77g5atnYIV9whBa6NZ9GoqUAD8iY1b
	HA55RTPyq2GKe3CVLvkhteE2RJjLdHFyLRgIKE3U=
Received: by mx.zohomail.com with SMTPS id 177145346430080.13158237699349;
	Wed, 18 Feb 2026 14:24:24 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 8/8] hook: add -z option to "git hook list"
Date: Thu, 19 Feb 2026 00:23:52 +0200
Message-ID: <20260218222352.55393-9-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260218222352.55393-1-adrian.ratiu@collabora.com>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add a NUL-terminate mode to git hook list, just in case hooks are
configured with weird characters like newlines in their names.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/git-hook.adoc |  8 ++++++--
 builtin/hook.c              |  9 ++++++---
 t/t1800-hook.sh             | 13 +++++++++++++
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-hook.adoc b/Documentation/git-hook.adoc
index 7e4259e4f0..12d2701b52 100644
--- a/Documentation/git-hook.adoc
+++ b/Documentation/git-hook.adoc
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git hook' run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]
-'git hook' list <hook-name>
+'git hook' list [-z] <hook-name>
 
 DESCRIPTION
 -----------
@@ -113,9 +113,10 @@ Any positional arguments to the hook should be passed after a
 mandatory `--` (or `--end-of-options`, see linkgit:gitcli[7]). See
 linkgit:githooks[5] for arguments hooks might expect (if any).
 
-list::
+list [-z]::
 	Print a list of hooks which will be run on `<hook-name>` event. If no
 	hooks are configured for that event, print a warning and return 1.
+	Use `-z` to terminate output lines with NUL instead of newlines.
 
 OPTIONS
 -------
@@ -130,6 +131,9 @@ OPTIONS
 	tools that want to do a blind one-shot run of a hook that may
 	or may not be present.
 
+-z::
+	Terminate "list" output lines with NUL instead of newlines.
+
 WRAPPERS
 --------
 
diff --git a/builtin/hook.c b/builtin/hook.c
index e151bb2cd1..83020dfb4f 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -11,7 +11,7 @@
 #define BUILTIN_HOOK_RUN_USAGE \
 	N_("git hook run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]")
 #define BUILTIN_HOOK_LIST_USAGE \
-	N_("git hook list <hook-name>")
+	N_("git hook list [-z] <hook-name>")
 
 static const char * const builtin_hook_usage[] = {
 	BUILTIN_HOOK_RUN_USAGE,
@@ -34,9 +34,12 @@ static int list(int argc, const char **argv, const char *prefix,
 	struct string_list *head;
 	struct string_list_item *item;
 	const char *hookname = NULL;
+	int line_terminator = '\n';
 	int ret = 0;
 
 	struct option list_options[] = {
+		OPT_SET_INT('z', NULL, &line_terminator,
+			    N_("use NUL as line terminator"), '\0'),
 		OPT_END(),
 	};
 
@@ -66,10 +69,10 @@ static int list(int argc, const char **argv, const char *prefix,
 
 		switch (h->kind) {
 		case HOOK_TRADITIONAL:
-			printf("%s\n", _("hook from hookdir"));
+			printf("%s%c", _("hook from hookdir"), line_terminator);
 			break;
 		case HOOK_CONFIGURED:
-			printf("%s\n", h->u.configured.friendly_name);
+			printf("%s%c", h->u.configured.friendly_name, line_terminator);
 			break;
 		default:
 			BUG("unknown hook kind");
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index e58151e8f8..b1583e9ef9 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -61,6 +61,19 @@ test_expect_success 'git hook list: configured hook' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git hook list: -z shows NUL-terminated output' '
+	test_hook test-hook <<-EOF &&
+	echo Test hook
+	EOF
+	test_config hook.myhook.command "echo Hello" &&
+	test_config hook.myhook.event test-hook --add &&
+
+	printf "myhookQhook from hookdirQ" >expect &&
+	git hook list -z test-hook >actual.raw &&
+	nul_to_q <actual.raw >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git hook run: nonexistent hook' '
 	cat >stderr.expect <<-\EOF &&
 	error: cannot find a hook named test-hook
-- 
2.52.0.732.gb351b5166d.dirty

