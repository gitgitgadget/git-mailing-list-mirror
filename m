Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F804317D
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 21:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771968928; cv=none; b=pspjr8Ft9tsfzJ6zNudQqODd3SnLpE1mlm1rZmow91N74CmrVWcGh+ZeQ3oP4lvWsAIGA9/E2qOHMiHz0jcXYNTFwLD34FXmZmlnni37Q4N1Hq9t/SUDoyEIILqw1Czpo3XPBtyiMod+QWAm/LuA4TJzglGvYWbzmMotNqIsaNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771968928; c=relaxed/simple;
	bh=4k9q7SJR2PKVBlcQKt2YI6zG4XpYF4b60S/fOuczcyY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qPURHexyCXE5GFdaNmvGikXunNzlzJGNhm8hdmu6XABIPVgaNFMr40E+MdZlq075tsJ/dZ6fXTDHiAQRcYRYL1jyPs14x9nnwIv8n62mOUmMNXXwB+GGFk0EMPoRDu2/OtYF3TYI4mzqA4+aF26un4DzQOddSZJrGpXcQ4Zbt1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGCAWxUX; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGCAWxUX"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cb513e860cso641735685a.2
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 13:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771968926; x=1772573726; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=benQchgAbKUk2vpMP0YguZie7UM/MqNay1PHJe9nT4c=;
        b=YGCAWxUXCaX3bbcFrzQy4+6NJJxIy9EiA9i2N4TvZ5GARqcVYd6iu0HDPyuRyUTojC
         ExPbUVxlsKHH7kUNKuomZOk9TIInGCLNeQWFsZKOYwyF1puj2JAjamazE9ruddstw5XS
         ROsgmbWHyErn1uKG5I9gutdZ8IMMozFZQpiJQxfi0pTZocK92iwspsOS3gbUqGcK6KeV
         20JgVCkHzKagMdQO7A6lI+mCZz5zqWhHmHOssLgNAJ+77AAidp96DmSFNiJuePLgXKXJ
         MaRjYHst8FrkAu6aRIYy+pD6r7KREFJWPwH9yIpTbcTCAhX9T6duJBF3OpIIBGAUHAlu
         tLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771968926; x=1772573726;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=benQchgAbKUk2vpMP0YguZie7UM/MqNay1PHJe9nT4c=;
        b=jcmWgO4b6ETBhl4MirG/At5M+pVON+XfW3byXoZPAmy9yjswfpg5ieerj6ka9Ddl3Z
         FxILyN6XobmZ1Gcyb6DKYv1z42ppxCVH/LJ3bSovsMQ8hwBNLt+QoXgctiauCs3n/3Jo
         kMbCHOa3kEiuwJ2eq5INLdGmGbQ1orG4tCCGy3SmK+7uR0xSuS5twsZS1xHb5DxS1vwu
         94pWX0qqmdOE4W7UqT1ktQmzrirYoZL4hQLvhY4tbRsL4fzqbYvFUCc5JNtIyHOSsCaj
         MYNhuH6NQmbt2ZoLLjEkN80KL1PXbBeSrEkV8OLCLpWefLopIP3LZKU7yc8Hehk2P1XB
         QEEQ==
X-Gm-Message-State: AOJu0YzQJLQQLfGAHdY8vq5yKh2CsfjVSF8xVTzec75GlAfdlphoOwkl
	t3ug3cXLgfkVy5U4IxZGmdoyf+56V3dkP98FBGLqrJHPEHgq2CfxwykBuJGGvw==
X-Gm-Gg: AZuq6aI6+UwMscGYzgXG8+GNw7dWJbeB4k2R2wrej31vXVIDJxbvPAgaGJu5x1qhsNb
	Mx6ITDYAIuESNMB+Ybr9mOauQzi7PjkfqnZLpIGmgdrTrJZ9ctU98hpxAE5uV5avkoU/zUULqeV
	Lj0MjnxUkhdzMK0SoSPN5B26pVRdHnBsX6jVqMMPNpTRLVJPIBr2+0HFkDc7pwUy082CdZhYUuf
	1cvZmrQUIsNqRsmplt2jo8TPgxSKQ4fDjoK3uQYWG6du2TRT6/jz/NkgUVdAwtN6NNtR70E85f2
	0Rg3D2ItP+Wvht8ML5yAfjkNeeTbr9uj4VSuD50uduE2MouWXk0YpvQ+Yt00K3uSlpEBKtibBSx
	jCHkN/jCg2F2Gdtqz1/YIhJXJ97qmMk3hPY8WFht9Crd23ugsZz84hKhrTxMwYw1qeOfOlo76B1
	H+h3WtkKNA4J0IymlbV+ewa8prZ7lDKte82A==
X-Received: by 2002:a05:620a:414c:b0:8ca:123e:819c with SMTP id af79cd13be357-8cb8ca0fae0mr1781202885a.35.1771968925739;
        Tue, 24 Feb 2026 13:35:25 -0800 (PST)
Received: from [127.0.0.1] ([20.55.87.153])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997c6b6af6sm105403276d6.12.2026.02.24.13.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 13:35:25 -0800 (PST)
Message-Id: <pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
In-Reply-To: <pull.2056.git.1771903950.gitgitgadget@gmail.com>
References: <pull.2056.git.1771903950.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Feb 2026 21:35:22 +0000
Subject: [PATCH v2 0/2] for-each-repo: work correctly in a worktree
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
    Derrick Stolee <stolee@gmail.com>

This was reported by Matthew [1] and is a quick fix.

[1]
https://lore.kernel.org/git/CABpCjbY=wpStuhxqRJ5TSNV3A-CmN-g-xZGJOQGSSv3GYhs2fQ@mail.gmail.com/

I also took the liberty of removing the_repository as I wanted to make sure
that wasn't involved here.

Thanks, -Stolee

Derrick Stolee (2):
  for-each-repo: test outside of repo context
  for-each-repo: work correctly in a worktree

 builtin/for-each-repo.c  | 33 ++++++++++++++++++++++++++++++---
 t/t0068-for-each-repo.sh | 33 ++++++++++++++++++++++++---------
 2 files changed, 54 insertions(+), 12 deletions(-)


base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2056%2Fderrickstolee%2Ffor-each-repo-in-gitdir-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2056/derrickstolee/for-each-repo-in-gitdir-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2056

Range-diff vs v1:

 1:  86cd83f65b < -:  ---------- for-each-repo: stop using the_repository
 -:  ---------- > 1:  6e9d4f3029 for-each-repo: test outside of repo context
 2:  a47f9e9386 ! 2:  4e3f4aa6cd for-each-repo: work correctly in a worktree
     @@ Commit message
          repository's local config (demonstrating that it worked with
          non-worktree Git repositories).
      
     -    The fix is simple: unset the environment variable before looping over
     -    the repos.
     +    We need to be careful to unset the local Git environment variables and
     +    let the child process rediscover them, while also reinstating those
     +    variables in the parent process afterwards. Update run_command_on_repo()
     +    to store, unset, then reset the non-NULL variables.
      
          Reported-by: Matthew Gabeler-Lee <fastcat@gmail.com>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## builtin/for-each-repo.c ##
      @@
     + 
       #include "builtin.h"
       #include "config.h"
      +#include "environment.h"
       #include "gettext.h"
       #include "parse-options.h"
       #include "path.h"
     -@@ builtin/for-each-repo.c: int cmd_for_each_repo(int argc,
     - 	else if (err)
     - 		return 0;
     +@@ builtin/for-each-repo.c: static const char * const for_each_repo_usage[] = {
     + 
     + static int run_command_on_repo(const char *path, int argc, const char ** argv)
     + {
     +-	int i;
     ++	int res;
     + 	struct child_process child = CHILD_PROCESS_INIT;
     ++	char **envvars;
     ++	size_t envvar_nr = 0;
     + 	char *abspath = interpolate_path(path, 0);
     + 
     ++	while (local_repo_env[envvar_nr])
     ++		envvar_nr++;
     ++
     ++	CALLOC_ARRAY(envvars, envvar_nr);
     ++
     ++	for (size_t i = 0; i < envvar_nr; i++) {
     ++		envvars[i] = getenv(local_repo_env[i]);
     ++
     ++		if (envvars[i]) {
     ++			unsetenv(local_repo_env[i]);
     ++			envvars[i] = xstrdup(envvars[i]);
     ++		}
     ++	}
     ++
     + 	child.git_cmd = 1;
     + 	strvec_pushl(&child.args, "-C", abspath, NULL);
     + 
     +-	for (i = 0; i < argc; i++)
     ++	for (int i = 0; i < argc; i++)
     + 		strvec_push(&child.args, argv[i]);
       
     -+	/* Be sure to not pass GIT_DIR to children. */
     -+	unsetenv(GIT_DIR_ENVIRONMENT);
     + 	free(abspath);
     + 
     +-	return run_command(&child);
     ++	res = run_command(&child);
     ++
     ++	for (size_t i = 0; i < envvar_nr; i++) {
     ++		if (envvars[i]) {
     ++			setenv(local_repo_env[i], envvars[i], 1);
     ++			free(envvars[i]);
     ++		}
     ++	}
      +
     - 	for (size_t i = 0; i < values->nr; i++) {
     - 		int ret = run_command_on_repo(values->items[i].string, argc, argv);
     - 		if (ret) {
     ++	free(envvars);
     ++	return res;
     + }
     + 
     + int cmd_for_each_repo(int argc,
      
       ## t/t0068-for-each-repo.sh ##
     -@@ t/t0068-for-each-repo.sh: test_description='git for-each-repo builtin'
     +@@ t/t0068-for-each-repo.sh: TEST_NO_CREATE_REPO=1
       test_expect_success 'run based on configured value' '
       	git init one &&
       	git init two &&
     @@ t/t0068-for-each-repo.sh: test_description='git for-each-repo builtin'
      +	git -C two worktree add --orphan ../three &&
       	git init ~/four &&
       	git -C two commit --allow-empty -m "DID NOT RUN" &&
     --	git config run.key "$TRASH_DIRECTORY/one" &&
     --	git config --add run.key "$TRASH_DIRECTORY/three" &&
     --	git config --add run.key "~/four" &&
     -+	git config --global run.key "$TRASH_DIRECTORY/one" &&
     -+	git config --global --add run.key "$TRASH_DIRECTORY/three" &&
     -+	git config --global --add run.key "~/four" &&
     -+
     - 	git for-each-repo --config=run.key commit --allow-empty -m "ran" &&
     - 	git -C one log -1 --pretty=format:%s >message &&
     - 	grep ran message &&
     -@@ t/t0068-for-each-repo.sh: test_expect_success 'run based on configured value' '
     - 	grep ran message &&
     - 	git -C ~/four log -1 --pretty=format:%s >message &&
     - 	grep ran message &&
     -+
     - 	git for-each-repo --config=run.key -- commit --allow-empty -m "ran again" &&
     - 	git -C one log -1 --pretty=format:%s >message &&
     - 	grep again message &&
     + 	git config --global run.key "$TRASH_DIRECTORY/one" &&
      @@ t/t0068-for-each-repo.sh: test_expect_success 'run based on configured value' '
       	git -C three log -1 --pretty=format:%s >message &&
       	grep again message &&

-- 
gitgitgadget
