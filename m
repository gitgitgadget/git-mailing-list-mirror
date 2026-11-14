Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794682104;
	b=jPF0Txstr1iBDqyazv64huoFLkX5Y24yCFjf9UIPleXqhxW72Cxiba6Z3CDkNA1GUDMD
	 W5YnHQgUSbjoJNK4KSc9q4+lA7QPe+QCk5+G5IQFagMCS0LfXSNEqtRAS0D+Rs1Qmg9xD
	 ds4+RNfnvxMaHsu7yyRI7RxmZvoSjjK9PWFjT/kT5GAICOjkjZCPf5Od8PO4oE88NbO1p
	 2wp2wSpZsCeZ6bksUrSHV1ShLgKPYt/obzLtznkSHfsdfILim7viJa2241Ql9NCjvKY/y
	 8FuGFxS6WPuAP/us9AMdkoRTt9ajKPl2E50j+1q8pjDQFNzK3xhCM2ktXPnxQ/7uDUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794682104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k6RlHuQHqNtXePwNLc13DW5K0bbGcNkMzrg33ecfzso=;
	b=c9aIR9PMLHBlspC5Hs90trxp7lK/9etXQEQW5Bjr05GvgshiN/eh+1tAzmQBRsYOr2kF
	 Jjfdzz5nu7hi1evhvp4Xo9O32PzeVx0CjyI68TrC6jAxupusXkyBruJyO548CkDSXQ7C4
	 RnhyqCBQBDfybnwvdmE52D/t4r8533TUm+b/gu+MX1/SZePlZgVwE2uUm1vxgIfAVx5vn
	 HQoIJZi70CC8d3lVnG1P0nqUS2qdPC81UOZan/pRl6HT6rez6LUIqne0JUEG2SS6yp1sF
	 6tPrKDcM8WOCtx24A35cIAWABb4fTiB2FNPKKnkEyaqHc0D7zpj+GAXYkZHHE3oyolw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L+y6j1E5;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69CC606A336
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 18:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C69CC606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L+y6j1E5
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb606491faso3888325e9.3
        for <git@vger.kernel.org>; Sat, 14 Nov 2026 10:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794682102; x=1795286902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k6RlHuQHqNtXePwNLc13DW5K0bbGcNkMzrg33ecfzso=;
        b=L+y6j1E5yaUgx2mtK9EwpCXDQMTNj/8Gwo6oJlN8l/94izefcB+iaUfzVam9POM+K0
         keBxEu8/LcO8CKSQkF7EWW9vZSGSIgJhf+TMZPBXiE5JwJoLhqsKabYBopAK+mlvZ23u
         NV6RkR6iOQFXwH/gXrUI5KU/+DUh//z8HcJEbRw1pGdSGGEyOjPqzR7BEQ4zZRiZuW6o
         QM09Mn1H1kEcIv6ZrI7n6bJ56AGGaEMFFo7zn2TfRI5RMiYuVR90AX7OzUu3I15OEoeU
         iSxUDpNEIaVf6Y+oZTqBGK0wAScAeM2F9wsZXHrfh+20oOCCY6PsoiL0KXb9JoHQ+C8q
         iirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794682102; x=1795286902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k6RlHuQHqNtXePwNLc13DW5K0bbGcNkMzrg33ecfzso=;
        b=a08kFN5Q3oYfLpoWHToZJu5Z0gITB/pOUbh3vz9rEWW9lybODud/uPchgwBn8HzU7P
         QsPWfappKeSpI09IUEgTGrPIVVNWKScBhaYTK9OODfg6P4aiGhASJ9SDi3oZWSRJuxTm
         rbp0wO96Mkcu/CLD6hKPfbasPrAENX+q7lH+Ix7g1UDVVgc8f92x7ofkgvGeupHWYcaX
         xE8/JNJF1BuI6ARVtueL4JPO7uyACMshS7LZ5Su9emXR48SwPTAOyiQShANrJmEnVSdL
         f7mD9J3CMcDkkv/ZFas7N0R51wsyHBE6/pFMks8r4Wj6gtwjC0oluvxBP+gfDorByUXh
         iYgg==
X-Gm-Message-State: APuU4Z9ymJb+2T1kqIGXbJJ8aFhfrvMAPfIF1ARwsZn/xkFl931g7Hb0
	fe1sPnoaeroRXOBxrRaxM6/cVoDcFmCyccpjr5sKuTugisulBikcBNYF8I4C7aUKM4M=
X-Gm-Gg: AYBFou3mXYy7hI3bWiIySXqCmtbO0PWTm9iQBYqAfZ+Wc1RcFHhg6P0ZH8oKfinWYgU
	1g96PImDS/A3Z1WNpDM8RpAbhNQrpg9G3nOOPxocR2Hdem8vGM+Qy0RYSF3HYRTIc/iniaPaqwd
	ZMgkuqGgUtFO9th0ppBsr/yS3vVxUIClZ66H8r32YEqoCPq89kBQm3cgc+GfP5dX9MUwagT1J7N
	ys5WI67H6c03pmf4AGQlw4DH2L5qb9WMrygfA10e3Ebq9Ywcfd4IRWTpKd/3GsSABHxWPSV10TQ
	ByFbOXLM5801+/FXC5zBNl29nuX77Y9AdoxS8aAgdy478LKMy7YN+8wt1VkXnsLqb04/Uwy+XCc
	bMkzZlz+aiVUQ7icOjXOFgNuHtKXRXlxxvciG2sps77LqIE7EDvZhSMz6eHkHMOTW3i7EbE1VZS
	GJyu50hh6NV7qwTY9yCS8Az7l7hg91/gpQYNK5UeNSBOVB4DsI92yS+guSY0tzO63AwPVIBB4vs
	9KIvZIOJff8Gk0EBxvXF1+AXnTqMQx64Dcx6zCpWl7/3VTuAEZ/RNoqU2Qkmp1VTN6F/5QmQdnt
	IoScVY7wnraYLsSb4EYKmFJTA/DfbTPOBMQ0TBBQx/Vf7ejkUbwomI3osS9Jt7uwuTm2t2g1ObJ
	x79yY70G76JeucdasXzJjXiodB27uHLBNC4HwW4LJWOyPpePvBgDoaInPQx5ZkraB90Bkt93229
	9vIkPvrYcJlZ5TGDdRBQb5ZpbOY82+SI1C
X-Received: by 2002:a05:600c:37ca:b0:4a1:e0db:8cf8 with SMTP id 5b1f17b1804b1-4bb559f2787mr131216555e9.3.1794682102101;
        Sat, 14 Nov 2026 10:48:22 -0800 (PST)
Received: from localhost.localdomain ([212.88.111.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ac0e3fsm128620355e9.5.2026.11.14.10.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 10:48:20 -0800 (PST)
From: Wasswa Edson <edsonwasswa54@gmail.com>
To: git@vger.kernel.org
Cc: tangajoris@gmail.com,
	Wasswa Edson <edsonwasswa54@gmail.com>
Subject: [PATCH v2 3/3] credential: parse subcommands with OPT_SUBCOMMAND
Date: Sat, 14 Nov 2026 21:47:52 +0300
Message-ID: <20261114184752.1417-4-edsonwasswa54@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20261114184752.1417-1-edsonwasswa54@gmail.com>
References: <20261104202228.24642-1-edsonwasswa54@gmail.com>
 <20261114184752.1417-1-edsonwasswa54@gmail.com>
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

Now that each subcommand of "git credential" lives in its own
function, switch the dispatch to OPT_SUBCOMMAND(). This gives each
subcommand its own usage string, so that "git credential <subcommand>
-h" shows help for that subcommand, and makes the subcommand names
available to the completion via --git-completion-helper.

Each subcommand takes neither options nor arguments; reject any
with a common helper. Drop NO_PARSEOPT from the git.c entry, as the
command now uses parse-options.

This changes the behavior only on error paths:

 - A missing or unknown subcommand is reported as such ("need a
   subcommand" / "unknown subcommand") before the usage text.

 - Extra arguments are reported as "too many arguments" before the
   usage text of the subcommand.

 - "git credential <subcommand> -h" shows the usage of that
   subcommand and exits with 0, instead of failing with the usage of
   the whole command.

Failures still exit with 129.

Helped-by: Tanga Joris <tangajoris@gmail.com>
Signed-off-by: Wasswa Edson <edsonwasswa54@gmail.com>
---
 builtin/credential.c   | 91 +++++++++++++++++++++++++++++-------------
 git.c                  |  2 +-
 t/t0300-credentials.sh | 27 +++++++++++++
 3 files changed, 91 insertions(+), 29 deletions(-)

diff --git a/builtin/credential.c b/builtin/credential.c
index d6ba21a2cb..b9945d019b 100644
--- a/builtin/credential.c
+++ b/builtin/credential.c
@@ -5,16 +5,52 @@
 #include "builtin.h"
 #include "environment.h"
 #include "config.h"
+#include "gettext.h"
+#include "parse-options.h"
+
+static const char * const credential_usage[] = {
+	N_("git credential (fill|approve|reject|capability)"),
+	NULL,
+};
+
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
+static void parse_no_args(int argc, const char **argv, const char *prefix,
+			  const char * const *usagestr)
+{
+	struct option options[] = {
+		OPT_END()
+	};
 
-static const char usage_msg[] =
-	"git credential (fill|approve|reject|capability)";
+	if (parse_options(argc, argv, prefix, options, usagestr, 0))
+		usage_msg_opt(_("too many arguments"), usagestr, options);
+}
 
-static int cmd_credential_fill(int argc UNUSED, const char **argv UNUSED,
-			       const char *prefix UNUSED,
+static int cmd_credential_fill(int argc, const char **argv, const char *prefix,
 			       struct repository *repo UNUSED)
 {
 	struct credential c = CREDENTIAL_INIT;
 
+	parse_no_args(argc, argv, prefix, credential_fill_usage);
+
 	if (credential_read(&c, stdin, CREDENTIAL_OP_INITIAL) < 0)
 		die("unable to read credential from stdin");
 
@@ -26,12 +62,14 @@ static int cmd_credential_fill(int argc UNUSED, const char **argv UNUSED,
 	return 0;
 }
 
-static int cmd_credential_approve(int argc UNUSED, const char **argv UNUSED,
-				  const char *prefix UNUSED,
+static int cmd_credential_approve(int argc, const char **argv,
+				  const char *prefix,
 				  struct repository *repo UNUSED)
 {
 	struct credential c = CREDENTIAL_INIT;
 
+	parse_no_args(argc, argv, prefix, credential_approve_usage);
+
 	if (credential_read(&c, stdin, CREDENTIAL_OP_INITIAL) < 0)
 		die("unable to read credential from stdin");
 
@@ -42,12 +80,14 @@ static int cmd_credential_approve(int argc UNUSED, const char **argv UNUSED,
 	return 0;
 }
 
-static int cmd_credential_reject(int argc UNUSED, const char **argv UNUSED,
-				 const char *prefix UNUSED,
+static int cmd_credential_reject(int argc, const char **argv,
+				 const char *prefix,
 				 struct repository *repo UNUSED)
 {
 	struct credential c = CREDENTIAL_INIT;
 
+	parse_no_args(argc, argv, prefix, credential_reject_usage);
+
 	if (credential_read(&c, stdin, CREDENTIAL_OP_INITIAL) < 0)
 		die("unable to read credential from stdin");
 
@@ -58,13 +98,14 @@ static int cmd_credential_reject(int argc UNUSED, const char **argv UNUSED,
 	return 0;
 }
 
-static int cmd_credential_capability(int argc UNUSED,
-				     const char **argv UNUSED,
-				     const char *prefix UNUSED,
+static int cmd_credential_capability(int argc, const char **argv,
+				     const char *prefix,
 				     struct repository *repo UNUSED)
 {
 	struct credential c = CREDENTIAL_INIT;
 
+	parse_no_args(argc, argv, prefix, credential_capability_usage);
+
 	credential_set_all_capabilities(&c, CREDENTIAL_OP_INITIAL);
 	credential_announce_capabilities(&c, stdout);
 
@@ -77,24 +118,18 @@ int cmd_credential(int argc,
 		   const char *prefix,
 		   struct repository *repo)
 {
-	const char *op;
+	parse_opt_subcommand_fn *fn = NULL;
+	struct option options[] = {
+		OPT_SUBCOMMAND("fill", &fn, cmd_credential_fill),
+		OPT_SUBCOMMAND("approve", &fn, cmd_credential_approve),
+		OPT_SUBCOMMAND("reject", &fn, cmd_credential_reject),
+		OPT_SUBCOMMAND("capability", &fn, cmd_credential_capability),
+		OPT_END()
+	};
 
 	repo_config(the_repository, git_default_config, NULL);
 
-	show_usage_if_asked(argc, argv, usage_msg);
-	if (argc != 2)
-		usage(usage_msg);
-	op = argv[1];
-
-	if (!strcmp(op, "fill"))
-		return cmd_credential_fill(argc - 1, argv + 1, prefix, repo);
-	if (!strcmp(op, "approve"))
-		return cmd_credential_approve(argc - 1, argv + 1, prefix, repo);
-	if (!strcmp(op, "reject"))
-		return cmd_credential_reject(argc - 1, argv + 1, prefix, repo);
-	if (!strcmp(op, "capability"))
-		return cmd_credential_capability(argc - 1, argv + 1, prefix,
-						 repo);
-
-	usage(usage_msg);
+	argc = parse_options(argc, argv, prefix, options, credential_usage, 0);
+
+	return fn(argc, argv, prefix, repo);
 }
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
index ea11cdb4dc..858996ac4a 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -1056,4 +1056,31 @@ test_expect_success 'interactive prompt is sanitized' '
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
+test_expect_success 'credential subcommands reject extra arguments' '
+	for sub in fill approve reject capability
+	do
+		test_expect_code 129 git credential $sub extra \
+			</dev/null 2>err &&
+		test_grep "too many arguments" err || return 1
+	done
+'
+
 test_done
-- 
2.53.0

