Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823806;
	b=hg6AQo64FrKE+C+dnS9SoCKSgJUcZCJVna8vl5x550IPCAhxyFjzvvfUYNQ9ZHazIyS/
	 crzOomjX4YWMn+fWhfq/dSIweE13vgMjjPurd95M8rHT8d/kSK0e8I1X1FL+OOBxQ0GTI
	 /uAXnmcvhNy00AOUE9ur1IGOUi9HrisJBI8jAXQLraFw7bUyix7MPXM6QgLyICMgRmBIl
	 NUajrtUyK+Cz3xHXobkPiMrfYVxpTgvi0hJ6nHdvc/uNeUxXhBs8WfWup/m2KyhuWRjkU
	 yvIW9xOE5oOevAYI21x+P9bCdv/si2vLwsUpbQNdEPPn7DxuNwNCANv498aEX3Ts/ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=iyFdPKw8l7lc2mtR6tXhylcYp9/ZS66oN7qxNYJuISE=;
	b=EuFn9KCCOmv+7yiDdCHWJApGLp4QLnTp4j2+synHeTmKQ2c+7z0rbnxJ4lh9UoG79N59
	 emJd1jqw/zsSMZqcQGbD4wHmrjvwrsDwPl37WSvVfujrnOF7JMwueR8b7Xk0VQQH3tO75
	 hgulxkuqosbTwiM90BBaY6G/J8KtTepISPw4Jx0If2iXiatTXvWLYvBRUU6SqOKOmkQXT
	 xAcnCjBW2LkTJsxMDR2pvUgsMpKyMWlKS4ML/RHqKo9vfAviDs0Ho4tQwzyRslhCiL9tl
	 wHWC0DtEi5DRA/RalxMp1wAr8N2jqOhT3Rw/tV5JxsiESR8vRRPUP43QI5+x5y6iFRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QNHprerm;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EAF6070307
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 20:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12EAF6070307
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QNHprerm
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-490f38e9688so309763f8f.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 12:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793823804; x=1794428604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iyFdPKw8l7lc2mtR6tXhylcYp9/ZS66oN7qxNYJuISE=;
        b=QNHprermNW1Ooajpy3p5IJOetTikIzjwC2iklkX3xnAH3QbEPwV4Vo1Ib/1bxMx1bg
         oYqN3x5AeA8+JOiw9mv8xgno90gFFpiRMyBWv2E6Joi4MKxFLRu/qvzOUP/s2RBeNc/9
         0aF78gSl6x0ZJXN7ZwRo7LJ+DK+2M/2Sad/b1f6uz8dpfhZe4uXEZA61MryhBLb71NVH
         Gvh2+x5k/Kke4CULfXC3B3KjUtbmnX6FxGGDO03qBCpS+3fKcjE7JtC/vn2jiHjV4DTS
         fUrlVEZZ3TO/CfSmwqgjZpyd/LPhrx6Gc9zB4QZM+OWjPHxmxPvDUW/Wp8ws5TZ+vNe0
         Co3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793823804; x=1794428604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iyFdPKw8l7lc2mtR6tXhylcYp9/ZS66oN7qxNYJuISE=;
        b=SlqWtruRELmd51VY9fhdSMFvF59Jx5xhZ0N3+cXjKSq+ucH3rKvl1PQXbZjfUY/34s
         Hxv+h/w/6QKzOhCwOPlvVZQOcI1zR2U4irtUHfbTV/pe1gHRiHL3qJU5RKcZjsAZWB8R
         kBbDau9+n59Jqa5ZKaYRjoY2doB56O5S3xJC241ez1irGcvBslcvIhQFNwPOOF4eQPTJ
         sBrrKEPTIZ/E0QQa6bqt8pgWLKKa5mk6JUv6+qsqcdBoCbfhKZPiEy+ZpQWUxkhlGI1R
         7scNuD2gpI80LmccApubFuZfXY681Ko1+bZGQ8DXyWsKbNT9U1dAztv7YAjbh9EE33L2
         m8sg==
X-Gm-Message-State: APuU4Z8RU4Y4v+jgt5dG2Xk2QOZoNs04UVRdxR6Qqp2gPUv6UysbLlNM
	uihwRz+Q8qaLxzlpQjkb8tc/AKJsm/YEMAC1puU8VNNObi9VXMY2LTVt8fmcP3PHJ2id8Q3l
X-Gm-Gg: AYBFou2wPts88WGwh5tdgkaEJLrmP9ZfIpCOW9aCmG8eV1sRTytbgkKgfBYsd1TaKdH
	pB0vkFwp7cRBlg3Oy8yxk9Ucd0D3GnxZhSDhDxpSjFZZpWum1EUEValV+55cY5NNhbzpdTlnMxh
	4CT9n4ff06OO0yfrYTgPKH/jGwRrI8LFiMYcDy99ojo8h3FVjKXRVRoNR8HCMbdptm6sC0+No7v
	7HV0tAF2d6qQ+GM6bUWBt80GjE1bQx27nF8dNZkVftWMWnSU8XPFpNOA9bCi8LIPf6LcNWx0NL2
	6CGUeLULK/FKUj7+VXwQb7QzfR7Q1A/VSde6nmES3C7fni8K+lFALHGvU+nInSO7yos/vuUS5Ho
	CstvDvE827veMipjiS5N9DNZyfaWoIF7mPExQGKzFIpA8lhL+0MjRDU+ovwLDOTtWjKYq+83GV5
	34GvHWKtwDb1gXuJDsr1PLTRhlAOKRXv5hnUSnx+SbuqgocP/kHUMs/kxMf0baG+9jljthQS8Rh
	J5ZenJaxdNjeRZbJT1zEyCNNbm1s61R1Zw/6GV0cQPreIS5QL6rckI2ZVATwzJUvd2kZRhMR8jn
	MQqkgUvZJPlygFc4fKs2l5HhRZIb5dfimw8c0FiUIHdkd0s3QpcOegN0QWzsNmvisp2Pn1a0Spd
	Msd8FoymAvcjZChzky2OIzRgJIz6xf0Cfn7eaSaWOKpXDhE0dV7kMVFG9RTgi1qiScejPUWWeUw
	==
X-Received: by 2002:a05:6000:1a87:b0:48f:bd0e:6fd6 with SMTP id ffacd0b85a97d-4911a86c07bmr850289f8f.27.1793823804212;
        Wed, 04 Nov 2026 12:23:24 -0800 (PST)
Received: from DESKTOP-GBO6I0C.hamlet-koi.ts.net ([135.136.39.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed45d7f7sm5984121f8f.38.2026.11.04.12.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:23:23 -0800 (PST)
From: Wasswa Edson <edsonwasswa54@gmail.com>
To: git@vger.kernel.org
Cc: Wasswa Edson <edsonwasswa54@gmail.com>
Subject: [PATCH] credential: parse subcommands with OPT_SUBCOMMAND
Date: Wed,  4 Nov 2026 23:22:28 +0300
Message-ID: <20261104202228.24642-1-edsonwasswa54@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"git credential" dispatches its four subcommands (fill, approve,
reject, capability) with a strcmp() chain after an argc check,
instead of using the parse-options API used by other builtins.

Convert the dispatch to OPT_SUBCOMMAND(). Besides making the code
shorter and more idiomatic, each subcommand gets its own usage
string, so "git credential <subcommand> -h" shows a targeted help
text, and the subcommand names are reported via
--git-completion-helper.

Since the builtin now uses parse-options, drop NO_PARSEOPT from its
git.c entry so "git --list-cmds=parseopt" includes it.

Two pre-existing inconsistencies are fixed while at it:

- The usage string did not mention "capability" even though it is a
  documented subcommand; it now lists all four.
- Documentation/git-credential.adoc marked its SYNOPSIS as a plain
  literal block, which t0450 cannot extract; mark it [verse] and drop
  "credential" from t0450/adoc-help-mismatches.

Behavior changes are limited to error paths: a missing or unknown
subcommand is reported as such ("need a subcommand" / "unknown
subcommand") before the usage text, instead of only showing the
usage text, and "git credential <subcommand> -h" exits 0 after
showing the subcommand's usage. Exit codes for failures are
unchanged (129).

Signed-off-by: Wasswa Edson <edsonwasswa54@gmail.com>
---
 Documentation/git-credential.adoc |   3 +-
 builtin/credential.c              | 148 ++++++++++++++++++++++++------
 git.c                             |   2 +-
 t/t0300-credentials.sh            |  18 ++++
 t/t0450/adoc-help-mismatches      |   1 -
 5 files changed, 138 insertions(+), 34 deletions(-)

diff --git a/Documentation/git-credential.adoc b/Documentation/git-credential.adoc
index e41493292f..e12d429f43 100644
--- a/Documentation/git-credential.adoc
+++ b/Documentation/git-credential.adoc
@@ -7,9 +7,8 @@ git-credential - Retrieve and store user credentials
 
 SYNOPSIS
 --------
-------------------
+[verse]
 'git credential' (fill|approve|reject|capability)
-------------------
 
 DESCRIPTION
 -----------
diff --git a/builtin/credential.c b/builtin/credential.c
index a295c80b36..7b398658bf 100644
--- a/builtin/credential.c
+++ b/builtin/credential.c
@@ -5,48 +5,136 @@
 #include "builtin.h"
 #include "environment.h"
 #include "config.h"
+#include "gettext.h"
+#include "parse-options.h"
 
-static const char usage_msg[] =
-	"git credential (fill|approve|reject)";
+static const char * const credential_usage[] = {
+	N_("git credential (fill|approve|reject|capability)"),
+	NULL,
+};
 
-int cmd_credential(int argc,
-		   const char **argv,
-		   const char *prefix UNUSED,
-		   struct repository *repo UNUSED)
+static const char * const credential_fill_usage[] = {
+	N_("git credential fill"),
+	NULL,
+};
+
+static const char * const credential_approve_usage[] = {
+	N_("git credential approve"),
+	NULL,
+};
+
+static const char * const credential_reject_usage[] = {
+	N_("git credential reject"),
+	NULL,
+};
+
+static const char * const credential_capability_usage[] = {
+	N_("git credential capability"),
+	NULL,
+};
+
+static int cmd_credential_fill(int argc, const char **argv, const char *prefix,
+			       struct repository *repo UNUSED)
 {
-	const char *op;
+	struct option options[] = { OPT_END() };
 	struct credential c = CREDENTIAL_INIT;
 
-	repo_config(the_repository, git_default_config, NULL);
+	argc = parse_options(argc, argv, prefix, options,
+			     credential_fill_usage, 0);
+	if (argc)
+		usage_with_options(credential_fill_usage, options);
+
+	if (credential_read(&c, stdin, CREDENTIAL_OP_INITIAL) < 0)
+		die("unable to read credential from stdin");
+
+	credential_fill(the_repository, &c, 0);
+	credential_next_state(&c);
+	credential_write(&c, stdout, CREDENTIAL_OP_RESPONSE);
+
+	credential_clear(&c);
+	return 0;
+}
 
-	show_usage_if_asked(argc, argv, usage_msg);
-	if (argc != 2)
-		usage(usage_msg);
-	op = argv[1];
+static int cmd_credential_approve(int argc, const char **argv,
+				const char *prefix,
+				struct repository *repo UNUSED)
+{
+	struct option options[] = { OPT_END() };
+	struct credential c = CREDENTIAL_INIT;
 
-	if (!strcmp(op, "capability")) {
-		credential_set_all_capabilities(&c, CREDENTIAL_OP_INITIAL);
-		credential_announce_capabilities(&c, stdout);
-		return 0;
-	}
+	argc = parse_options(argc, argv, prefix, options,
+			     credential_approve_usage, 0);
+	if (argc)
+		usage_with_options(credential_approve_usage, options);
 
 	if (credential_read(&c, stdin, CREDENTIAL_OP_INITIAL) < 0)
 		die("unable to read credential from stdin");
 
-	if (!strcmp(op, "fill")) {
-		credential_fill(the_repository, &c, 0);
-		credential_next_state(&c);
-		credential_write(&c, stdout, CREDENTIAL_OP_RESPONSE);
-	} else if (!strcmp(op, "approve")) {
-		credential_set_all_capabilities(&c, CREDENTIAL_OP_HELPER);
-		credential_approve(the_repository, &c);
-	} else if (!strcmp(op, "reject")) {
-		credential_set_all_capabilities(&c, CREDENTIAL_OP_HELPER);
-		credential_reject(the_repository, &c);
-	} else {
-		usage(usage_msg);
-	}
+	credential_set_all_capabilities(&c, CREDENTIAL_OP_HELPER);
+	credential_approve(the_repository, &c);
 
 	credential_clear(&c);
 	return 0;
 }
+
+static int cmd_credential_reject(int argc, const char **argv,
+				 const char *prefix,
+				 struct repository *repo UNUSED)
+{
+	struct option options[] = { OPT_END() };
+	struct credential c = CREDENTIAL_INIT;
+
+	argc = parse_options(argc, argv, prefix, options,
+			     credential_reject_usage, 0);
+	if (argc)
+		usage_with_options(credential_reject_usage, options);
+
+	if (credential_read(&c, stdin, CREDENTIAL_OP_INITIAL) < 0)
+		die("unable to read credential from stdin");
+
+	credential_set_all_capabilities(&c, CREDENTIAL_OP_HELPER);
+	credential_reject(the_repository, &c);
+
+	credential_clear(&c);
+	return 0;
+}
+
+static int cmd_credential_capability(int argc, const char **argv,
+				     const char *prefix,
+				     struct repository *repo UNUSED)
+{
+	struct option options[] = { OPT_END() };
+	struct credential c = CREDENTIAL_INIT;
+
+	argc = parse_options(argc, argv, prefix, options,
+			     credential_capability_usage, 0);
+	if (argc)
+		usage_with_options(credential_capability_usage, options);
+
+	credential_set_all_capabilities(&c, CREDENTIAL_OP_INITIAL);
+	credential_announce_capabilities(&c, stdout);
+
+	credential_clear(&c);
+	return 0;
+}
+
+int cmd_credential(int argc,
+		   const char **argv,
+		   const char *prefix,
+		   struct repository *repo)
+{
+	parse_opt_subcommand_fn *fn = NULL;
+	struct option options[] = {
+		OPT_SUBCOMMAND("fill", &fn, cmd_credential_fill),
+		OPT_SUBCOMMAND("approve", &fn, cmd_credential_approve),
+		OPT_SUBCOMMAND("reject", &fn, cmd_credential_reject),
+		OPT_SUBCOMMAND("capability", &fn, cmd_credential_capability),
+		OPT_END()
+	};
+
+	repo_config(the_repository, git_default_config, NULL);
+
+	argc = parse_options(argc, argv, prefix, options, credential_usage, 0);
+
+	return fn(argc, argv, prefix, repo);
+}
diff --git a/git.c b/git.c
index d7b5f88e52..da370902ab 100644
--- a/git.c
+++ b/git.c
@@ -562,7 +562,7 @@ static struct cmd_struct commands[] = {
 	{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 	{ "config", cmd_config, RUN_SETUP_GENTLY | DELAY_PAGER_CONFIG },
 	{ "count-objects", cmd_count_objects, RUN_SETUP },
-	{ "credential", cmd_credential, RUN_SETUP_GENTLY | NO_PARSEOPT },
+	{ "credential", cmd_credential, RUN_SETUP_GENTLY },
 	{ "credential-cache", cmd_credential_cache },
 	{ "credential-cache--daemon", cmd_credential_cache_daemon },
 	{ "credential-store", cmd_credential_store },
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index ea11cdb4dc..ce230caff1 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -1056,4 +1056,22 @@ test_expect_success 'interactive prompt is sanitized' '
 	EOF
 '
 
+test_expect_success 'credential subcommands -h show subcommand usage' '
+	for sub in fill approve reject capability
+	do
+		git credential $sub -h >out &&
+		test_grep "^usage: git credential $sub" out || return 1
+	done
+'
+
+test_expect_success 'credential requires a subcommand' '
+	test_expect_code 129 git credential 2>err &&
+	test_grep "need a subcommand" err
+'
+
+test_expect_success 'credential rejects unknown subcommand' '
+	test_expect_code 129 git credential foo 2>err &&
+	test_grep "unknown subcommand" err
+'
+
 test_done
diff --git a/t/t0450/adoc-help-mismatches b/t/t0450/adoc-help-mismatches
index baf3b1d809..939e47bf3a 100644
--- a/t/t0450/adoc-help-mismatches
+++ b/t/t0450/adoc-help-mismatches
@@ -9,7 +9,6 @@ checkout
 checkout-index
 clone
 column
-credential
 credential-cache
 credential-store
 fetch-pack
-- 
2.53.0

