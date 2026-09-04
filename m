Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29B73D9058
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 07:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508432; cv=none; b=CxEb8AhnugnsoV2wEW84aEj5jQWLYS685k26MHUHk6GsyZX2V8WdwWjFj1T1SvXvp2erlP4t0L8DMuRuz6A22ocQNdZYwrqNsSNKL0sR73WEc8XGSm1Ha3lyOV60SLYi84Oe8ZcQQcsaig3AzDKWDcAeJs1cpuOBUp1DGX2DNMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508432; c=relaxed/simple;
	bh=Ll8c+RX/9QzAnBe+cqLUymB0xU1HAqDt/jCxZq03RJk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Rmvrj+FhhjGJVyH16TJt9Dz9t5UdksgfDeXaD+gIlJKWgkzDuG7bcCqMPpwkSt3KDNhv1RedhdNzmrend4jb5NGmcIQVwfsKMJ9F4A5vFDoEIQwodRIJz2hRarECM/34a7atHKB0zY6QLHe37C0jc//Jfu79WgV+pO1SqiKp7bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSLU42HI; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSLU42HI"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-9103f5b813aso4384166d6.3
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 00:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788508429; x=1789113229; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fXh/Wpe6HdlaI+C8RDUfCvH2nmh3Fk+4uEcQEYkzJL4=;
        b=fSLU42HIHxCLPyGs84DUXy1wsJABkztpSycjeeqODPW6tbSlhy38BIksqibubRRxcP
         V2+pCE110mik70f2LN5RbuGVhFIJ7u+k01DqgSGTKtnsnUtEi/z0wUyQQ9Oa2LS2NFUX
         b0lp6L19oP9+Bg6bNUM0ir+pr/ddB2XtNo4w9EOOopVcZK1aswh+0YId5O1CrbIhVItA
         7ugiLzlrKGiVFIcpV5c3TRV9sXXBGN8BzHaFPztTuNrHrsczzWk8SUuKUVcSoJ4JsvrX
         DXX14QtS5KN9cbcmTlJU9n0JLDC0M/DowLvG7A21PsqUegjwlgt48IBgd5grmNiy6ueA
         DoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788508429; x=1789113229;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fXh/Wpe6HdlaI+C8RDUfCvH2nmh3Fk+4uEcQEYkzJL4=;
        b=jQGGC9exFKSKg+vfXum6GN5ZBN7azBF/VESl8lAwBXPwQh0SikvkzThnbXWZIBnLOe
         aXbR8gWjLEe13a0B3G9o71i0F9wDJ04/z6vQd6sfLzjPG8QSrym9YVhx6gqYphmYm8KO
         A68Qt+CL5YD7UF7uW9lclW+NyETCCWHABunmxX7gXJ9aAPNd9Hq9fWbxpXVYzIubJoeF
         kdyzMYEjjuPX1HdTYc1rkLo+FzLlKXSt7lGraCfwKauAXNLA6VDH2vcR8U0aPos1tkXG
         sOnyXdvcUqekfDk/efNCwEpSV2AHc7fCItNqF4+MxSBXQi0kIp4Pjh3j4A1ZHDLU+j0u
         himA==
X-Gm-Message-State: AFuF++ldibKUMyVwwYvAVKK6+Ze6dggjz3J7srbJYY8YMQnsjynVymfD
	zxJmbsXBdYk73aCehh06jmGpjJLfvO5Izqe9N+xrOfgMZfR8T4oyvVQlGVxo98Xk
X-Gm-Gg: AYBFou2Tk3ZvaRHoqQLrjSlJRBp1DQ5RwRroRJOKqxQafVzoqZV65KfGL0S8laaXZLe
	imU6q5Z4M+34IWUjij2ChfzPq6i76lenzFCHQwRFCtGSwrnXqzzHhh7uQ+CI66+42mgbNSED9tS
	2tNGEIwukVSdgEuVagFcnh2ntllortTynL7yOfW8nIduQ7Xo6FYWcrTRjmTNZvk+OMT9nuViFxU
	K0x+NQU3mdl0EoRiW8aB6GIBOdnJwH/AbnoZSHvxUOXy8IlWMtSg2lWUnnmVi7nOBZf2avVapEj
	AOn1jhpY0iVrHNawIJax6xJTwX4i+owm1YK7Z3pk5Aa3hdVUnFVeLkpL6d/05p0L4easjoJvLCw
	EARS9abA8KSMMrJFk65TRXdQ2bn/W5FPsi+9xVaUH6tpmGwXb+IYXBOeR493tWc0TcqLfXQBGkv
	8HIH1/COXKADkqxaVx2SKJj7pgIhdGNx0R342U9lDtScQXIhl7HK+GHjgJFeht3JkFJJyyFIerc
	c8W4A==
X-Received: by 2002:ad4:4eac:0:b0:90c:4ddb:e298 with SMTP id 6a1803df08f44-9103eefcf6bmr44542236d6.6.1788508429427;
        Fri, 04 Sep 2026 00:53:49 -0700 (PDT)
Received: from [127.0.0.1] ([172.210.149.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91040595c57sm15127836d6.5.2026.09.04.00.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 00:53:49 -0700 (PDT)
Message-Id: <06d2f0f484e2e22178c6a956ec153e3d84ee073c.1788508426.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 04 Sep 2026 07:53:46 +0000
Subject: [PATCH 2/2] sequencer: keep auto maintenance out of the commands a
 rebase spawns
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

The commands a rebase with the merge backend spawns, the "git commit"
for a resolved, reworded or squashed pick, the "git merge" of a
"rebase -r" for an octopus merge or with a strategy, and whatever an
exec command runs, each kick off "git maintenance run --auto --detach",
a background process the rebase then races for the repository: the
"rerere gc" spawned by the commit of one "git rebase --continue" holds
MERGE_RR.lock while the next pick wants it, and a repack wants to
delete packs the sequencer still had open, which 65cda10d5b
(sequencer: release the ODB before spawning git commit, 2026-08-12)
had to fix for Windows.

Nothing a rebase creates is old enough to be pruned by the time it
ends, and repacking what it created can wait until then, so
maintenance in the middle of a rebase has nothing to do that a run at
its end cannot, and a rebase to get in the way of. Pass
maintenance.auto=false and gc.auto=0 to the commands a rebase spawns,
through GIT_CONFIG_PARAMETERS so that the shell of an exec command
passes them on too, appended to whatever -c the user gave, since the
last entry wins. What the user runs while the rebase is stopped, say
"git commit --amend" at an edit, is not the rebase's to control and
still runs it. "git commit" and "git merge" could skip it themselves
while a rebase is in progress, which would cover that too, but that
spreads the rebase's business over every command that runs
maintenance and defers theirs for as long as a rebase is left lying
around, so keep the decision with the rebase, in what it spawns. Both
backends run maintenance once the rebase is done, the merge backend
since the previous commit, so nothing is lost.

Cherry-pick and revert are left alone: they never ran maintenance at
the end of a sequence, and the "git commit" they spawn for a
--continue or an edited message is the only place they run it at all.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 sequencer.c                | 27 +++++++++++++++++++++++++++
 t/t3418-rebase-continue.sh | 18 ++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index f58ad254be..30c1a799cc 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1107,6 +1107,29 @@ static int run_command_silent_on_success(struct child_process *cmd)
 	return rc;
 }
 
+/*
+ * A rebase runs auto maintenance once it is done, not from every command
+ * it spawns along the way: their background "rerere gc" or repack would
+ * race the rebase for locks and files it still holds.
+ */
+static void disable_auto_maintenance(struct child_process *cmd)
+{
+	struct strbuf value = STRBUF_INIT;
+	const char *old = getenv(CONFIG_DATA_ENVIRONMENT);
+
+	if (old && *old)
+		strbuf_addf(&value, "%s ", old);
+	sq_quote_buf(&value, "maintenance.auto");
+	strbuf_addch(&value, '=');
+	sq_quote_buf(&value, "false");
+	strbuf_addch(&value, ' ');
+	sq_quote_buf(&value, "gc.auto");
+	strbuf_addch(&value, '=');
+	sq_quote_buf(&value, "0");
+	strvec_pushf(&cmd->env, "%s=%s", CONFIG_DATA_ENVIRONMENT, value.buf);
+	strbuf_release(&value);
+}
+
 /*
  * If we are cherry-pick, and if the merge did not result in
  * hand-editing, we will hit this commit and inherit the original
@@ -1148,6 +1171,8 @@ static int run_git_commit(const char *defmsg,
 			     author_date_from_env(&cmd.env));
 	if (opts->ignore_date)
 		strvec_push(&cmd.env, "GIT_AUTHOR_DATE=");
+	if (is_rebase_i(opts))
+		disable_auto_maintenance(&cmd);
 
 	strvec_push(&cmd.args, "commit");
 
@@ -3934,6 +3959,7 @@ static int do_exec(struct repository *r, const char *command_line, int quiet)
 	cmd.use_shell = 1;
 	strvec_push(&cmd.args, command_line);
 	strvec_push(&cmd.env, "GIT_CHERRY_PICK_HELP");
+	disable_auto_maintenance(&cmd);
 	status = run_command(&cmd);
 
 	/* force re-reading of the cache */
@@ -4342,6 +4368,7 @@ static int do_merge(struct repository *r,
 				     author_date_from_env(&cmd.env));
 		if (opts->ignore_date)
 			strvec_push(&cmd.env, "GIT_AUTHOR_DATE=");
+		disable_auto_maintenance(&cmd);
 
 		cmd.git_cmd = 1;
 		strvec_push(&cmd.args, "merge");
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 2c34cf8a01..cf6d20ce79 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -403,4 +403,22 @@ test_expect_success 'rebase runs auto maintenance at its end' '
 	test_subcommand_flex git maintenance run --auto <finish.txt
 '
 
+test_expect_success 'rebase spawns no auto maintenance before its end' '
+	git checkout -b two-conflicts topic &&
+	test_commit F2-again F2 222 &&
+	test_must_fail git rebase -x "git commit --allow-empty -m exec" main &&
+	echo resolved >F2 &&
+	git add F2 &&
+	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/mid.txt" \
+		git rebase --continue &&
+	test_subcommand_flex git commit <mid.txt &&
+	test_subcommand_flex ! git maintenance run --auto <mid.txt &&
+	echo resolved >F2 &&
+	git add F2 &&
+	GIT_TRACE2_EVENT="$(pwd)/end.txt" git rebase --continue &&
+	test_subcommand_flex git maintenance run --auto <end.txt &&
+	grep "\"child_start\".*\"maintenance\"" end.txt >maintenance &&
+	test_line_count = 1 maintenance
+'
+
 test_done
-- 
gitgitgadget
