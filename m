Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466F814A4C9
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726837648; cv=none; b=YfSGHOtZ/XVhCEXyWUchPamopjcn+Y6dkTkeWYm79AafPNwOQPGBetpAeVYTd6EVDsFte6Zum6THA+3fKc1aB4htea6lJiYoP1UJl1y4qXOdJ1IQ2mOK4ZNXxxtdWgRoC15Pv8Voq6Ylz4Yh3Op9PNdPYcUjDbDnN4idsXxnnkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726837648; c=relaxed/simple;
	bh=nAkZ4s5o5wOs97XEauJ+vnxb9cy2INi73oGrnGTugpA=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=RQvmOSRF40rW277pZCDZU1Qfmc8/lWfmEfEde7g5Kf6PW4Wrs/e49MqYU/mEtMn2DiBYcIWARGCfMBnZBtwMinumaZEIPraa3VwTeHNcKwy65DzvghM9Kpu5ZvWYbv9H0V0XGTua2xjW3V+zSekD6r2+Vvgj/cMSkDZgr2Utyvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0zz5Aok; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0zz5Aok"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c24ebaa427so4779078a12.1
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 06:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726837644; x=1727442444; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1WcboioGXhiqkKZ80HFdFEX4Cxc6Eb0t3QP5n8DAWAY=;
        b=E0zz5AokqymBnyWISnthMQRrw8T6GfpgzppnVxG1ujKvkiqK1HRNQdt+kF5veBxQOa
         oj4HLUtWluSiX00o1NxoaDDwb9g+43bZZcA0RPkG8133INrEyGsFdp5P5LDER0/KfygA
         6qhIeJl/FCe8zP8DrsklzUgjMhP5DV25nr9o0vAJt7vmrQtu2sNoBRc8foPKXQeHIyMt
         z/l/DQMZ85jQTSIQrkHFnGd820SetGMtM3lGtAxgndIGv6k8R2/guu8+v4YHMUfrkpYT
         PlrCGD0apIdCX6x2Io/vMtO2i15dvnmN1/zVcojd3UcvbznXOENZTXI1dCVMxdm9nS+K
         Q2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726837644; x=1727442444;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1WcboioGXhiqkKZ80HFdFEX4Cxc6Eb0t3QP5n8DAWAY=;
        b=oC/OGotSu5R/6plh4g+W5v34mJE5fhFZDG+9u1bGibiSeMJB+71wzSBiNAF+TTJX9u
         z42f2YK5PAqoi1WdXJ6gQXm6ezxFD04bM2ntxWiYh4vR5mZX9zgYt4mBFnevw5W/BBSE
         dcNLfjSiNS1Z+sNKNAhCax768+LgfSsglPoWTOx6i0iBZIHW+8DYK5zYDcgunX8DhlBw
         8cRfGV1Qt7hkK6U73aDfkTFQ5XEcMQrdSq8l1H0Z3dWp9m60UwAp6o+HbWHmCAzoDIHh
         qGd8NvrUaA7Somsj+Y3vkEgu+BaPtje11X6E4Us216ci8FZ+xXau1TAuErUpBdLmFCLm
         aiHA==
X-Gm-Message-State: AOJu0Yxa8LwNIRhRqhJLkDEEJepISaghqiJgZZTsxvBwvVtPvfR98k+O
	BzWULNvyhX0sV+jRKRUNZwcIcTp/+LPdItkwFxAbKQaaREn4Aq18XyL4cA==
X-Google-Smtp-Source: AGHT+IHMhtj/tGaPB9AO9dgciUoS3Dz8i2xUtFWfc+yRunTqalRjQ7jlX1EarFyq56fFERnvbflszw==
X-Received: by 2002:a05:6402:2747:b0:5be:e9f8:9ba4 with SMTP id 4fb4d7f45d1cf-5c4637b716dmr2988504a12.4.1726837643892;
        Fri, 20 Sep 2024 06:07:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bae0f73sm7212866a12.0.2024.09.20.06.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 06:07:23 -0700 (PDT)
Message-Id: <pull.1799.git.1726837642511.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Sep 2024 13:07:22 +0000
Subject: [PATCH] submodule status: propagate SIGPIPE
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
Cc: Calvin Wan <calvinwan@google.com>,
    Matt Liberty <mliberty@precisioninno.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

It has been reported than running

     git submodule status --recurse | grep -q ^+

results in an unexpected error message

    fatal: failed to recurse into submodule $submodule

When "git submodule--helper" recurses into a submodule it creates a
child process. If that process fails then the error message above is
displayed by the parent. In the case above the child is killed by
SIGPIPE as "grep -q" exits as soon as it sees the first match. Fix this
by propagating SIGPIPE so that it is visible to the process running
git. We could propagate other signals but I'm not sure there is much
value in doing that. In the common case of the user pressing Ctrl-C or
Ctrl-\ then SIGINT or SIGQUIT will be sent to the foreground process
group and so the parent process will receive the same signal as the
child.

Reported-by: Matt Liberty <mliberty@precisioninno.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    submodule status: propagate SIGPIPE
    
    Note that I haven't checked if any other submodule subcommands are
    affected by this - I'll leave that to someone more familiar with the
    code.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1799%2Fphillipwood%2Fsubmodule-status-sigpipe-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1799/phillipwood/submodule-status-sigpipe-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1799

 builtin/submodule--helper.c | 7 ++++++-
 t/t7422-submodule-output.sh | 7 +++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a46ffd49b34..a8e497ef3c6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -30,6 +30,7 @@
 #include "advice.h"
 #include "branch.h"
 #include "list-objects-filter-options.h"
+#include <signal.h>
 
 #define OPT_QUIET (1 << 0)
 #define OPT_CACHED (1 << 1)
@@ -695,6 +696,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 
 	if (flags & OPT_RECURSIVE) {
 		struct child_process cpr = CHILD_PROCESS_INIT;
+		int res;
 
 		cpr.git_cmd = 1;
 		cpr.dir = path;
@@ -710,7 +712,10 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 		if (flags & OPT_QUIET)
 			strvec_push(&cpr.args, "--quiet");
 
-		if (run_command(&cpr))
+		res = run_command(&cpr);
+		if (res == SIGPIPE + 128)
+			raise(SIGPIPE);
+		else if (res)
 			die(_("failed to recurse into submodule '%s'"), path);
 	}
 
diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
index ab946ec9405..c1686d6bb5f 100755
--- a/t/t7422-submodule-output.sh
+++ b/t/t7422-submodule-output.sh
@@ -167,4 +167,11 @@ do
 	'
 done
 
+test_expect_success !MINGW 'git submodule status --recursive propagates SIGPIPE' '
+	{ git submodule status --recursive 2>err; echo $?>status; } |
+		grep -q X/S &&
+	test_must_be_empty err &&
+	test_match_signal 13 "$(cat status)"
+'
+
 test_done

base-commit: ed155187b429a2a6b6475efe1767053df37ccfe1
-- 
gitgitgadget
