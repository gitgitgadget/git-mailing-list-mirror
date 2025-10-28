Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC102EAD0B
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 21:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761688007; cv=none; b=hbVgZmOKBQ3NG5g6KXx/xP08weR/HEe4T558DlGi6P9Sqz6nbg8H0HWc0c/r4H/kIGAH1thMPUzXrlewcNla/ChGuI7nqh8QL6iTP/d8AU4O+eBZoZ8ih6Rwss2tCUMrZXgUyrFALtQWqxrQFMqJRX7AJvL4HWs8Riu63y88fHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761688007; c=relaxed/simple;
	bh=n4sirdsFzcZ1p/WOqO31XyfsyqHzNEFWT0S0NOZcIIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MqUIeXWge+htMmt9fcBZSHpSKgkjGv2eTt95+KVquutjRcS0yHjRPUS1EecN997zdIrHZeg9jYbHn3bVSWODQNTg2MRCOfs7y1T3E3adn0JaO3LYhqVGqLfqYk9gxgAGrwXG5aXfiEPL1FQL+w7h5Pm7svacgURcZMiHo7Ze3gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8/yxLWY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8/yxLWY"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2907948c1d2so68843765ad.3
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 14:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761688005; x=1762292805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGTgX8m7w5K27uvbeYGvfZIAehNxdYCOGQD3ksT/FQ0=;
        b=D8/yxLWY8DU6s23y4TLQPUlaZU4LCnbQnSn02sXLBzRR6nr0MqlLPsYhwEi7Jzjqzk
         EH8sybrR/aIOON9HRVpqKKtB9BNkWUXoqaUiZ+1zdgfJXo3eXDF7/NaRuICsC+2X1kP/
         eKVwlfb4AcXUL/cXNGa9cs9OVece2IjEPZJQvN34cV/UFxJ9bCfm52cz8yqhcbtKA412
         SOVBxvecX9sBykm+tAeuiHR1xgHBJZ2g8lqqDU8GvsV08oa+VUKMCtPPHvKCMywMVS5M
         MJNj5OlH3MJJslYeLbUelgBYeDYKe40QwEootRX+nqDVBjiEI5rCz7tQMrtDIQW5PazT
         kMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761688005; x=1762292805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGTgX8m7w5K27uvbeYGvfZIAehNxdYCOGQD3ksT/FQ0=;
        b=Gx2yrcd6NiYjBvnB/XWmZPU75Xyif61URn2Hoo8XdrOHTNNYGfA+w17JWu26tN+5g4
         6KNrWIPl9TgNrUBbOdZDa3o+tmiiFIN2Jsl4wK0Neers38v3pAC5gundZaisFRK+3lsd
         WnjRgEiydx2S5TBfxckY0yxhnHB+Is7JnGn/ekCk1zsUmK4EmHQRZSCTBuwUzwNrNC5i
         IconbFH7IP2FDzizQuY3UoUM7D5UaqCYwRE2hj2VSocS3fdvXXoyGSXJPnZYHhGhUPY3
         hHhNbwOGCG49/EsmFQig3cb49SaIqUkJqiRt09J67qpTVSNb5giQdoCQE9ezCl4+cuiP
         G0FA==
X-Gm-Message-State: AOJu0YwaoQct+w5J0xo44Lmn0n00WZprXQadmD7V3laqMkchnLdiMkWU
	znxoTDpMZkScNIzeWfcwhZfGLgjRxvnvxNQHe8eYKs9Emd+UshIR2SQq0lcmCD7/fUY=
X-Gm-Gg: ASbGncuRijDTRrNtxpHQlJFgIqlOv58NKbd11PXuQvy9yr7To9mhLCbc92A2n9Tgw3v
	jrCqxUSLvdA39cwanf1pkyHf3pzN24eUgCy899oADZt7ng6Ry5/9VdRZa8TVM/ecbiUj+uhvFXt
	dlPWK5Z6/Dv3SdF8wbnRYZjqpRpnYldce14W9LxmV7aAo8VGFY4odnj1/o/b/shIjqx8Df5NzpY
	rsufqofca4uNFFthpsSXLNs/6FD1hA+qwDJgCRT0UgvEt3hK26hMUIiZcLmdrPuUWWnQNqIdAKp
	t4jDGK9xeGwR7qGF69n6/tQkrG7/P2bD9MNDcJpnWi1DqLvmp0aNMIj/rbknwWEY2frDBPc1sqM
	XP76ihR885Y4kSsR5yCK+PouYGXuY2cAxMzGQwN29hE7gGnC/T3ezCMuOXH2OKbuCOYxR9ZSxb4
	ZLHI9lxw6+oRTOvO5Fx5TMXsvfA4jNxyUeMsESURALFL7Dao6ny9+ODW1C3Z2H+bVSDuG1XkD4V
	bnz1YmJdVCb2Zz5nkWIi+6tIY1bhSnFpXXyFXaDRDE=
X-Google-Smtp-Source: AGHT+IF6R9DKnEJHX49icNEPtnCOQTxuDIFbyD31GQebzg8wvFBonLNYGWiU8mgYJ3xJ0CKXeEKIzA==
X-Received: by 2002:a17:902:e546:b0:290:9576:d6ef with SMTP id d9443c01a7336-294def37ef6mr8205215ad.54.1761688004786;
        Tue, 28 Oct 2025 14:46:44 -0700 (PDT)
Received: from localhost.localdomain ([2409:40e3:177:42ef:798a:642a:892e:b13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e42afdsm125645655ad.99.2025.10.28.14.46.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Oct 2025 14:46:44 -0700 (PDT)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk,
	newren@gmail.com,
	gitster@pobox.com,
	ps@pks.im,
	karthik.188@gmail.com,
	code@khaugsbakk.name,
	rybak.a.v@gmail.com,
	jltobler@gmail.com,
	toon@iotcl.com,
	johncai86@gmail.com,
	johannes.schindelin@gmx.de,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v5 3/3] replay: add replay.refAction config option
Date: Wed, 29 Oct 2025 03:16:09 +0530
Message-ID: <20251028214609.10041-4-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028214609.10041-1-siddharthasthana31@gmail.com>
References: <20251022185045.29256-1-siddharthasthana31@gmail.com>
 <20251028214609.10041-1-siddharthasthana31@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a configuration option to control the default behavior of git replay
for updating references. This allows users who prefer the traditional
pipeline output to set it once in their config instead of passing
--ref-action=print with every command.

The config option uses string values that mirror the behavior modes:
  * replay.refAction = update (default): atomic ref updates
  * replay.refAction = print: output commands for pipeline

The command-line --ref-action option always overrides the config setting,
allowing users to temporarily change behavior for a single invocation.

Implementation details:

In cmd_replay(), after parsing command-line options, we check if
--ref-action was provided. If not, we read the configuration using
repo_config_get_string_tmp(). If the config variable is set, we validate
the value and use it to set the ref_action_str:

  Config value      Internal mode    Behavior
  ──────────────────────────────────────────────────────────────
  "update"          "update"         Atomic ref updates (default)
  "print"           "print"          Pipeline output
  (not set)         "update"         Atomic ref updates (default)
  (invalid)         error            Die with helpful message

If an invalid value is provided, we die() immediately with an error
message explaining the valid options. This catches configuration errors
early and provides clear guidance to users.

The command-line --ref-action option, when provided, overrides the
config value. This precedence allows users to set their preferred default
while still having per-invocation control:

  git config replay.refAction print         # Set default
  git replay --ref-action=update --onto main topic  # Override once

The config and command-line option use the same value names ('update'
and 'print') for consistency and clarity. This makes it immediately
obvious how the config maps to the command-line option, addressing
feedback about the relationship between configuration and command-line
options being clear to users.

Examples:

$ git config --global replay.refAction print
$ git replay --onto main topic1..topic2 | git update-ref --stdin

$ git replay --ref-action=update --onto main topic1..topic2

$ git config replay.refAction update
$ git replay --onto main topic1..topic2  # Updates refs directly

The implementation follows Git's standard configuration precedence:
command-line options override config values, which matches user
expectations across all Git commands.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Elijah Newren <newren@gmail.com>
Helped-by: Christian Couder <christian.couder@gmail.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 Documentation/config/replay.adoc | 11 +++++++
 builtin/replay.c                 | 39 ++++++++++++++++++-------
 t/t3650-replay-basics.sh         | 49 +++++++++++++++++++++++++++++++-
 3 files changed, 87 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/config/replay.adoc

diff --git a/Documentation/config/replay.adoc b/Documentation/config/replay.adoc
new file mode 100644
index 0000000000..7d549d2f0e
--- /dev/null
+++ b/Documentation/config/replay.adoc
@@ -0,0 +1,11 @@
+replay.refAction::
+	Specifies the default mode for handling reference updates in
+	`git replay`. The value can be:
++
+--
+	* `update`: Update refs directly using an atomic transaction (default behavior).
+	* `print`: Output update-ref commands for pipeline use.
+--
++
+This setting can be overridden with the `--ref-action` command-line option.
+When not configured, `git replay` defaults to `update` mode.
diff --git a/builtin/replay.c b/builtin/replay.c
index 0564d4d2e7..17898bbdd1 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -8,6 +8,7 @@
 #include "git-compat-util.h"
 
 #include "builtin.h"
+#include "config.h"
 #include "environment.h"
 #include "hex.h"
 #include "lockfile.h"
@@ -289,6 +290,31 @@ static struct commit *pick_regular_commit(struct repository *repo,
 	return create_commit(repo, result->tree, pickme, replayed_base);
 }
 
+static enum ref_action_mode parse_ref_action_mode(const char *mode_str, const char *source)
+{
+	if (!mode_str || !strcmp(mode_str, "update"))
+		return REF_ACTION_UPDATE;
+	if (!strcmp(mode_str, "print"))
+		return REF_ACTION_PRINT;
+	die(_("invalid %s value: '%s'"), source, mode_str);
+}
+
+static enum ref_action_mode get_ref_action_mode(struct repository *repo, const char *ref_action_str)
+{
+	const char *config_value = NULL;
+
+	/* Command line option takes precedence */
+	if (ref_action_str)
+		return parse_ref_action_mode(ref_action_str, "--ref-action");
+
+	/* Check config value */
+	if (!repo_config_get_string_tmp(repo, "replay.refAction", &config_value))
+		return parse_ref_action_mode(config_value, "replay.refAction");
+
+	/* Default to update mode */
+	return REF_ACTION_UPDATE;
+}
+
 static int handle_ref_update(enum ref_action_mode mode,
 			     struct ref_transaction *transaction,
 			     const char *refname,
@@ -367,17 +393,8 @@ int cmd_replay(int argc,
 	die_for_incompatible_opt2(!!advance_name_opt, "--advance",
 				  contained, "--contained");
 
-	/* Default to update mode if not specified */
-	if (!ref_action_str)
-		ref_action_str = "update";
-
-	/* Parse ref action mode */
-	if (!strcmp(ref_action_str, "update"))
-		ref_action = REF_ACTION_UPDATE;
-	else if (!strcmp(ref_action_str, "print"))
-		ref_action = REF_ACTION_PRINT;
-	else
-		die(_("unknown --ref-action mode '%s'"), ref_action_str);
+	/* Parse ref action mode from command line or config */
+	ref_action = get_ref_action_mode(repo, ref_action_str);
 
 	advance_name = xstrdup_or_null(advance_name_opt);
 
diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
index 123734b49f..9ca04b2fdd 100755
--- a/t/t3650-replay-basics.sh
+++ b/t/t3650-replay-basics.sh
@@ -219,7 +219,8 @@ test_expect_success 'merge.directoryRenames=false' '
 
 test_expect_success 'default atomic behavior updates refs directly' '
 	# Store original state for cleanup
-	test_when_finished "git branch -f topic2 topic1" &&
+	START=$(git rev-parse topic2) &&
+	test_when_finished "git branch -f topic2 $START" &&
 
 	# Test default atomic behavior (no output, refs updated)
 	git replay --onto main topic1..topic2 >output &&
@@ -232,6 +233,10 @@ test_expect_success 'default atomic behavior updates refs directly' '
 '
 
 test_expect_success 'atomic behavior in bare repository' '
+	# Store original state for cleanup
+	START=$(git rev-parse topic2) &&
+	test_when_finished "git branch -f topic2 $START" &&
+
 	# Test atomic updates work in bare repo
 	git -C bare replay --onto main topic1..topic2 >output &&
 	test_must_be_empty output &&
@@ -245,4 +250,46 @@ test_expect_success 'atomic behavior in bare repository' '
 	git -C bare update-ref refs/heads/topic2 $(git -C bare rev-parse topic1)
 '
 
+test_expect_success 'replay.refAction config option' '
+	# Store original state
+	START=$(git rev-parse topic2) &&
+	test_when_finished "git branch -f topic2 $START" &&
+	test_when_finished "git config --unset replay.refAction || true" &&
+
+	# Set config to print
+	git config replay.refAction print &&
+	git replay --onto main topic1..topic2 >output &&
+	test_line_count = 1 output &&
+	test_grep "^update refs/heads/topic2 " output &&
+
+	# Reset and test update mode
+	git branch -f topic2 $START &&
+	git config replay.refAction update &&
+	git replay --onto main topic1..topic2 >output &&
+	test_must_be_empty output &&
+
+	# Verify ref was updated
+	git log --format=%s topic2 >actual &&
+	test_write_lines E D M L B A >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'command-line --ref-action overrides config' '
+	# Store original state
+	START=$(git rev-parse topic2) &&
+	test_when_finished "git branch -f topic2 $START" &&
+
+	# Set config to update but use --ref-action=print
+	test_config replay.refAction update &&
+	git replay --ref-action=print --onto main topic1..topic2 >output &&
+	test_line_count = 1 output &&
+	test_grep "^update refs/heads/topic2 " output
+'
+
+test_expect_success 'invalid replay.refAction value' '
+	test_config replay.refAction invalid &&
+	test_must_fail git replay --onto main topic1..topic2 2>error &&
+	test_grep "invalid.*replay.refAction.*value" error
+'
+
 test_done
-- 
2.51.0

