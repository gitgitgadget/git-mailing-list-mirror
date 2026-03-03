Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938783A5E8B
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772559120; cv=none; b=bRt5V9xvpyA31cFFJeMQhDr+KKpOdpOQnk4THkzQ4hjh093MaWsVSJFMtIw53t8rRpHnSuDHdg88w1AvF0anQiGd4sqZRLvE/+P+RHevV7G4083r2ASo+7mL3FL3koyofDRXiS8m6TSILCVR/tINI6sM7e5ZVT30LXRx6tsQJXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772559120; c=relaxed/simple;
	bh=d4GmwHgERemaquCmY8ErUFROuPK1UxCNJPuGFRqeQ2w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JI4utXHx5ei9nwfIaTAYrghkqEwJurnEwNDiNwgqsctB1BufWratG4SDTC433XfTY5DweANAkZrx/SIEblRGvozkz2QRYDqAaA7P9/EBgM/4MC0OVHNxkNcKWU8PuLdaH54KJP7mKwj3/HEQ+5IIE3cXQa0uZtH9lmKuC70p+1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuFlBKTB; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuFlBKTB"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79863ab8478so58889787b3.3
        for <git@vger.kernel.org>; Tue, 03 Mar 2026 09:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772559117; x=1773163917; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgC9RCPc5ZstxcYqd82PzA0QgwH5xA4atIFVozmiyWQ=;
        b=TuFlBKTBusTdehOj8y0F5k9qQKYI9B7BR/zjNi8CzMzW167VU/leHDMbOSeEOiYsRG
         s4b6JgemhrjpcFAWuwOCTbSK5nq+6hSJGKYnbnj9hER1UTyF9hiBrrjf6g9VJbVarKfQ
         yzj/ZaXapINgN6wpIJeesXhofUx4EFtX7Q3QBcwKraM6WP7CqPD9CpNpPepqdr6gvhVX
         Za2jZGEN3NAiqkxIsK7RElU6YG7gYD/gM4+XdnE3ERXcVeohVjlIXqMx8VRDQxaJ8a7c
         d2CxoKIW4qDOGu0VDOpyM1WdOmqup52TANuHuUCLA0O5faEvGH3f5Cy8x+JjeVtfbqgK
         tnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772559117; x=1773163917;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AgC9RCPc5ZstxcYqd82PzA0QgwH5xA4atIFVozmiyWQ=;
        b=RoBrvom9MYFEWWqyPPfpKQdv6g6rNNP/htEa1bUs7hUy9fRSy+OZEEPunGEmVr40nN
         cpGi+CnxMcADjb00jOZgSTnK5GS5gOm1epMWv/0eBhHZk24LA+ivMVC1Y9bb0N7lLHFh
         vKlreXKSnSc/HGbXyQ92oYm5BXtcOn3uwjq2Nn7GjGe6+wfitdGQSJSaFAD+a9Yzv1qn
         GGHeiSd6dIg6lWEdLvg9BbE5wyrM2yGwKSdK1FjCg/or7HSCDKkI81XI4fkukfYtY1hi
         8bIgCTwCSD2Clc8ijVBfN5Ihael9/eYIiRQ60g7Oke3lD4jrzGQTzsluK2+mXsaLZF2q
         WFpA==
X-Gm-Message-State: AOJu0YzPHJrEjK9EoozjV580REfyQ9giN5pOAbnMx0Vdn12EUpCyxN3T
	9rbflJb2zogEqO9BYGxbcY2FHrB3Gzp2febDd6lo+ljunYWd6QtVo/qseJufaA==
X-Gm-Gg: ATEYQzzB+v97SJqteC3bzGaIuKj20GoHn3ylvvlL7q5d/WIWxG2REo6catcljlIopVd
	omBtQIUtA/GDpzR18Ir40NCaUd4NnioUZXr8C3HAyKsiK3gJAoU32K/lJA0Y9SvRM/dwezD0TWJ
	p7LIlIR39VYlHlykZ/rVAYXVdCgnK6MnhNHsvKD58/mbXyGjDifmB++VGaA+rNf7MHUINcWOZKq
	Lw0AzSejBVkrhWqrKyMuKBy2wejI+9tQskJn4jwqq7AjshEDU61RO1k3gXxIDALIxA2z3Fs8K+2
	Fs4Ww3aUCIjmGXI12xI/lM9Lo5mcEiKiRpxKGISRed3zZ/Tz3RPiqQVm584RCt9l/rwl2S7ab+B
	LSfcT+F6jhWWzRzxZZRAc5i+CFJLfoepvgs87kzQXV4IrtnlmhPRjLQCEQvLBEoGfymioH/h+NO
	btWUu07MnzYCiNwwMfPIoSgEqg
X-Received: by 2002:a05:690c:ed5:b0:798:6af6:a413 with SMTP id 00721157ae682-798854695afmr164680657b3.12.1772559116720;
        Tue, 03 Mar 2026 09:31:56 -0800 (PST)
Received: from [127.0.0.1] ([20.161.28.103])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507512559b2sm112811541cf.17.2026.03.03.09.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 09:31:55 -0800 (PST)
Message-Id: <pull.2056.v4.git.1772559114.gitgitgadget@gmail.com>
In-Reply-To: <pull.2056.v3.git.1772465805.gitgitgadget@gmail.com>
References: <pull.2056.v3.git.1772465805.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Mar 2026 17:31:50 +0000
Subject: [PATCH v4 0/4] for-each-repo: work correctly in a worktree
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
Cc: gitster@pobox.com,
    fastcat@gmail.com,
    Eric Sunshine <sunshine@sunshineco.com>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

This was reported by Matthew [1] and I thought it would be a quick fix. It
turns out to have had a lot of implications to get exactly right.

[1]
https://lore.kernel.org/git/CABpCjbY=wpStuhxqRJ5TSNV3A-CmN-g-xZGJOQGSSv3GYhs2fQ@mail.gmail.com/


Updates in v3
=============

v2 included some important changes that apparently didn't save in my cover
letter. Sorry. The most important one was that the first patch was replaced
with one that tests the command outside of a Git repo so the first patch in
v1 can be caught as a bug.

But v2 also included a bug! The filtering of GIT_CONFIG* environment
variables was incorrect. Further, duplicating this logic from
prepare_other_repo_env() was a new bug waiting to happen.

Here is the new setup:

 * Patch 1 is the same as in v2.
 * A new Patch 2 extracts clear_local_repo_env() from
   prepare_other_repo_env().
 * The old Patch 2 is now Patch 3 with a much simpler implementation that
   calls clear_local_repo_env().
 * Tests are added to check that these config-related environment variables
   are preserved. The NO_REPLACE_OBJECTS case seemed like it would take
   longer than necessary to set up for the value it provides.
 * A fourth patch is added that simplifies the use of argv. It's separate
   because it modifies the original implementation in a way that is a "nice
   to have" but isn't necessary for solving the bug that motivates the
   series.


Updates in V4
=============

Minor updates from Peff's review:

 1. Update the comment of prepare_other_repo_env() to avoid duplication.
 2. Rename the new method to sanitize_repo_env().
 3. Move incorrect removal of 'int i;' to correct patch.

Thanks, -Stolee

Derrick Stolee (4):
  for-each-repo: test outside of repo context
  run-command: extract sanitize_repo_env helper
  for-each-repo: work correctly in a worktree
  for-each-repo: simplify passing of parameters

 builtin/for-each-repo.c  | 12 +++----
 run-command.c            |  7 ++++-
 run-command.h            | 15 ++++++---
 t/t0068-for-each-repo.sh | 67 +++++++++++++++++++++++++++++++++-------
 4 files changed, 77 insertions(+), 24 deletions(-)


base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2056%2Fderrickstolee%2Ffor-each-repo-in-gitdir-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2056/derrickstolee/for-each-repo-in-gitdir-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2056

Range-diff vs v3:

 1:  6e9d4f3029 = 1:  6e9d4f3029 for-each-repo: test outside of repo context
 2:  13d783dbbd ! 2:  24398664c2 run-command: extract clear_local_repo_env helper
     @@ Metadata
      Author: Derrick Stolee <stolee@gmail.com>
      
       ## Commit message ##
     -    run-command: extract clear_local_repo_env helper
     +    run-command: extract sanitize_repo_env helper
      
          The current prepare_other_repo_env() does two distinct things:
      
     @@ Commit message
          item is required as the GIT_DIR discovery should happen naturally from
          the '-C' parameter in the child process.
      
     +    Helped-by: Jeff King <peff@peff.net>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## run-command.c ##
     @@ run-command.c: int run_auto_maintenance(int quiet)
       }
       
      -void prepare_other_repo_env(struct strvec *env, const char *new_git_dir)
     -+void clear_local_repo_env(struct strvec *env)
     ++void sanitize_repo_env(struct strvec *env)
       {
       	const char * const *var;
       
     @@ run-command.c: void prepare_other_repo_env(struct strvec *env, const char *new_g
      +
      +void prepare_other_repo_env(struct strvec *env, const char *new_git_dir)
      +{
     -+	clear_local_repo_env(env);
     ++	sanitize_repo_env(env);
       	strvec_pushf(env, "%s=%s", GIT_DIR_ENVIRONMENT, new_git_dir);
       }
       
     @@ run-command.h: struct run_process_parallel_opts
      + * environment.h. GIT_CONFIG_PARAMETERS and GIT_CONFIG_COUNT are preserved
      + * to pass -c and --config-env options from the parent process.
      + */
     -+void clear_local_repo_env(struct strvec *env);
     ++void sanitize_repo_env(struct strvec *env);
      +
       /**
        * Convenience function which prepares env for a command to be run in a
     -  * new repo. This adds all GIT_* environment variables to env with the
     +- * new repo. This adds all GIT_* environment variables to env with the
     +- * exception of GIT_CONFIG_PARAMETERS and GIT_CONFIG_COUNT (which cause the
     +- * corresponding environment variables to be unset in the subprocess) and adds
     +- * an environment variable pointing to new_git_dir. See local_repo_env in
     +- * environment.h for more information.
     ++ * new repo. This removes variables pointing to the local repository (using
     ++ * sanitize_repo_env() above), and adds an environment variable pointing to
     ++ * new_git_dir.
     +  */
     + void prepare_other_repo_env(struct strvec *env, const char *new_git_dir);
     + 
 3:  2a6091095f ! 3:  e759b35069 for-each-repo: work correctly in a worktree
     @@ Commit message
          We need to be careful to unset the local Git environment variables and
          let the child process rediscover them, while also reinstating those
          variables in the parent process afterwards. Update run_command_on_repo()
     -    to use the new clear_local_repo_env() helper method to erase these
     +    to use the new sanitize_repo_env() helper method to erase these
          environment variables.
      
          During review of this bug fix, there were several incorrect patches
          demonstrating different bad behaviors. Most of these are covered by
          tests, when it is not too expensive to set it up. One case that would be
          expensive to set up is the GIT_NO_REPLACE_OBJECTS environment variable,
     -    but we trust that using clear_local_repo_env() will be sufficient to
     +    but we trust that using sanitize_repo_env() will be sufficient to
          capture these uncovered cases by using the common code for resetting
          environment variables.
      
     @@ builtin/for-each-repo.c
       #include "gettext.h"
       #include "parse-options.h"
       #include "path.h"
     -@@ builtin/for-each-repo.c: static const char * const for_each_repo_usage[] = {
     - 
     - static int run_command_on_repo(const char *path, int argc, const char ** argv)
     - {
     --	int i;
     +@@ builtin/for-each-repo.c: static int run_command_on_repo(const char *path, int argc, const char ** argv)
       	struct child_process child = CHILD_PROCESS_INIT;
       	char *abspath = interpolate_path(path, 0);
       
     -+	clear_local_repo_env(&child.env);
     ++	sanitize_repo_env(&child.env);
      +
       	child.git_cmd = 1;
       	strvec_pushl(&child.args, "-C", abspath, NULL);
 4:  f6582e9402 ! 4:  8b1f083da1 for-each-repo: simplify passing of parameters
     @@ builtin/for-each-repo.c: static const char * const for_each_repo_usage[] = {
      -static int run_command_on_repo(const char *path, int argc, const char ** argv)
      +static int run_command_on_repo(const char *path, const char **argv)
       {
     +-	int i;
       	struct child_process child = CHILD_PROCESS_INIT;
       	char *abspath = interpolate_path(path, 0);
     + 
      @@ builtin/for-each-repo.c: static int run_command_on_repo(const char *path, int argc, const char ** argv)
       
       	child.git_cmd = 1;

-- 
gitgitgadget
