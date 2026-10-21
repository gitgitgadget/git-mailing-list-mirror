Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618530;
	b=qImFOF3i+NHQq61iszQxeLy0InFaSsfAB6N3VxO/FKw/1bzJcQBT/RH8PLo7MWFED6zp
	 7xxrz6aIV6Ps2aZfh6qK1CgVaB+sFkJ57L6RgEvv3ARUNfLIgAFhSYPp1amaL74cbpyUf
	 97QqSNxLEydRWWAqdoyU1JMSm3eSpYBMIy8fNAXbnc3+uBT4F82w351jx2MqI4AxGWGwv
	 SsrzCLaVa8sg0S4kuahBbQlh0Mzqvb+weeBd5xIi2eUT2HyrNGwO0waGxUywPToQ1iQuU
	 JuPgOz+u5qnC2UCmgoWbqXWRQGl6oszWOwYHGCWykj3o42X2fit7GuZnc6eOVrNcbqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618530;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=u885auD6EvO9c/BqeY5gEeYT+a9l41wgbasy0Ngx+6g=;
	b=RsoixlXHwsB1Eh7XaUnnewe+2Nt9mz1g/s3yF3Uxbvji0LPMx61VgrNvuJYgnRm9icmN
	 HuMVlHL+b96C59THlTAPSFcW6roIuXKjsC1Ek/XG51qO/zvngfcvW5oEyoiavzYcZhNJj
	 jjkM6iBRb1MwBhZVgqyKSw7VByYAoANjTH+sQPzI3gBsrhaA6tZEm6FVxo8Y8co7N7cIt
	 spelCe8HlxHBvMs6PuuhrioqQ7XbYtqITbnR/hXOLg60zm5ACaxhNshLjgxZMS7tS2G0B
	 8bMkE5XUcIVqI9BunoBpsJPmA3lPY5FJZBdaw4tnXJEntZjawwPxLSCDn98GyozT8iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BV5tKUZY;
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA29606A31A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 21:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAA29606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BV5tKUZY
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-7037daaa820so472935eaf.2
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 14:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792618529; x=1793223329; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u885auD6EvO9c/BqeY5gEeYT+a9l41wgbasy0Ngx+6g=;
        b=BV5tKUZYKflYrDWAQxxyIupwtGipWIvA0/Tuwu0XgFAT5m9tsruk9HvVcmljaOgaB0
         ha5J8SzLM0SA6hUC547B9O0B2rVydn368Kj0DswqHhXSzkO2NoazUORvWwAvSM9g0Y4j
         hXBdf9hRXrlO5WWNnfOC2PHkrNc5lZ76gFbtspHf+tCNUqPlOqd6FObkKfKtjroBrWff
         EwRtRBcCyYzZBTsESoMtf/7278NFYuF7gx6i9a0NrHRiCniQdZbdHjMazuWR3Av2XHxd
         CVTDwmX74SjOcmN4wIZ0vXTNi8C8ulLAHsxsC9DQwRq+juRdk7SygbgXd2m+qMkDYQ3L
         kLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792618529; x=1793223329;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u885auD6EvO9c/BqeY5gEeYT+a9l41wgbasy0Ngx+6g=;
        b=Cj7pL8cPdRBahJZ5kPt/Yg2DJrY/9IZib3KJTPFd//vxhEU7ZiS4St6dhRgkw5qkLL
         t2UfpexdHe9vZoCvv97BBdi48coxp5tFsu2WZLb4UCCrMzBLMX9By3R58/P7F8OJdHYQ
         SuU9+LWkJBqjzYqaMM6qEnr9yMdOBChltiXIa2gRn6eRy1IYPSUMdNSvAN7CXXVtwySq
         RpbeUYbxAy0bgiV+n/w4QqBcTBwOpRAT/c0HoUaqdBgzkh1YW5WN+REpGJd3Oa0Fa42N
         fpzMK0HFc9ED1mbx4oyvBMVYD2FvvXq8aWGA0FD7a1adKPBBBYT+uVQkx5TPyV5NRb2r
         uUMw==
X-Gm-Message-State: AFq9FYIDFn0VMwwgaM8iO/QOTccs3cwE4vhqFxOCA5/w6ZfaYvplrJEe
	VjuD6O5W/DCGqp5xpC/ItOjoQTxhWIZgUaMOSandAekiC6DVAh2U9MCuX0GWMA==
X-Gm-Gg: AYBFou0MfqFDpBS05Uvlect06q6KvZwGZbmVR+pq9Ry7xChgMizVf6tNQwXth7iui7g
	h/mzdxLtCVk6xb1TLnfaJbSCZq0ZIfP2WyVpRhEFvFzLnhwBJwl3Bk8UASGOEhGxm9jC/OBI/Rv
	uaQvkHkl7OyemuF9nS+QOlav8eGhsxei8ML2av93W/bD11c1P7fG0t0gH2k7JdArDsQu4zk2oPR
	jlJQRbJRawN+FOl86EeQ9Lf9Y33rYV3yO+y8AU1SjZumGl4zPjMt2rwEcOKzqxHk0afeUOYZh9z
	sA/UR4nsP6ggUIRGZgjewxKAs9mZdz5Z2MRolREKYIQDmqfihZS8J6vqqOvsdAzm7vr4dmWtM1O
	DpC6kWBZVrQGLlXw9kN/lZ/6vlYNTg6ah6pGwiiSoYuQFO6Hv5tkPVlv0uoya5FZ3ASn83czA85
	gATFr5/wBegNDb0T48P1wMXtXY0HMEVv2OXGcMMaxqZ85KndOqF/SByt+VEtt2/RJ/xu8ltNojR
	I84JoHuLPsoXHmDcz6C+nI89SAKqJhveBl7Jj4b/gc5P+XPGc32lHKuUsM=
X-Received: by 2002:a05:6820:350d:20b0:702:dd8d:316d with SMTP id 006d021491bc7-709417252acmr1580685eaf.47.1792618528860;
        Wed, 21 Oct 2026 14:35:28 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.201.57])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70900caad26sm2871662eaf.1.2026.10.21.14.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 14:35:27 -0700 (PDT)
Message-Id: <be94ac75bfbcb4ea6af982f5a5cffd20344445b5.1792618518.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2268.v2.git.1792618518.gitgitgadget@gmail.com>
References: <pull.2268.git.1792458904027.gitgitgadget@gmail.com>
	<pull.2268.v2.git.1792618518.gitgitgadget@gmail.com>
From: "tsukasa inoue via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 21:35:18 +0000
Subject: [PATCH v2 3/3] checkout: finish switching when the tracking config
 cannot be written
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    tsukasa-ino <inoue.tsukasa.4@gmail.com>,
    tsukasa inoue <inoue.tsukasa.4@gmail.com>

From: tsukasa inoue <inoue.tsukasa.4@gmail.com>

When git switch -c <new> <remote>/<branch> (or checkout -b) cannot write
the tracking config, for example because .git/config.lock exists, the
worktree, the index and the new branch ref have already been updated.
Git then exits with status 1 while HEAD still points to the original
branch. The changes of the switch remain staged, and the post-checkout
hook does not run.

create_branch() now returns an error instead of exiting. Make checkout
ignore that error so that the switch completes and the command exits
with status 0. The error and the hint are still printed.

Match push -u, clone and fetch, which also print the error and continue.
The upstream can be set later with the command shown in the hint.

Keep git branch <new> <start> failing when the tracking config cannot be
written, so its behavior does not change; t3200 covers this. Making the
switch fully atomic, undoing the worktree, the index, the ref and the
config when the tracking config fails, is a separate topic.

Signed-off-by: tsukasa inoue <inoue.tsukasa.4@gmail.com>
---
 builtin/checkout.c        | 23 ++++++++++++++---------
 t/t2027-checkout-track.sh | 20 ++++++++++++++++++++
 t/t2060-switch.sh         | 20 ++++++++++++++++++++
 t/t3200-branch.sh         | 13 +++++++++++++
 4 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 87e067b45b..a203f9e2ca 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -979,15 +979,20 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 			free(refname);
 		}
 		else
-			if (create_branch(the_repository,
-					  opts->new_branch, new_branch_info->name,
-					  opts->new_branch_force ? 1 : 0,
-					  opts->new_branch_force ? 1 : 0,
-					  opts->new_branch_log,
-					  opts->quiet,
-					  opts->track,
-					  0))
-				exit(1);
+			/*
+			 * Not fatal: the error and hint have already been
+			 * shown, and like "push -u" and "clone" we finish
+			 * the switch instead of leaving HEAD on the old
+			 * branch with the worktree already updated.
+			 */
+			create_branch(the_repository,
+				      opts->new_branch, new_branch_info->name,
+				      opts->new_branch_force ? 1 : 0,
+				      opts->new_branch_force ? 1 : 0,
+				      opts->new_branch_log,
+				      opts->quiet,
+				      opts->track,
+				      0);
 		free(new_branch_info->name);
 		free(new_branch_info->refname);
 		new_branch_info->name = xstrdup(opts->new_branch);
diff --git a/t/t2027-checkout-track.sh b/t/t2027-checkout-track.sh
index c01f1cd617..c3be183bfc 100755
--- a/t/t2027-checkout-track.sh
+++ b/t/t2027-checkout-track.sh
@@ -47,6 +47,26 @@ test_expect_success 'checkout --track -b overrides autoSetupMerge=inherit' '
 	test_cmp_config refs/heads/main branch.b4.merge
 '
 
+test_expect_success 'checkout -b completes when tracking config cannot be written' '
+	test_when_finished "git update-ref -d refs/remotes/lockremote/lockbranch" &&
+	test_when_finished "git branch -D lock-new" &&
+	test_when_finished "git checkout main" &&
+	test_config remote.lockremote.url . &&
+	test_config remote.lockremote.fetch "+refs/heads/*:refs/remotes/lockremote/*" &&
+	git update-ref refs/remotes/lockremote/lockbranch one &&
+	test_when_finished "rm -f .git/config.lock" &&
+	>.git/config.lock &&
+	git -c core.configLockTimeout=0 \
+		checkout -b lock-new lockremote/lockbranch 2>err &&
+	test_grep "unable to write upstream branch configuration" err &&
+	echo refs/heads/lock-new >expect &&
+	git symbolic-ref HEAD >actual &&
+	test_cmp expect actual &&
+	git diff --cached --exit-code &&
+	rm -f .git/config.lock &&
+	test_must_fail git config branch.lock-new.remote
+'
+
 test_expect_success 'ambiguous tracking info' '
 	# Set up a few remote repositories
 	git init --bare --initial-branch=trunk src1 &&
diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
index cec2fe6876..b4f137acc3 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -146,6 +146,26 @@ test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
 	test_cmp_config "" --default "" branch.main2.merge
 '
 
+test_expect_success 'switch -c completes when tracking config cannot be written' '
+	test_when_finished "git update-ref -d refs/remotes/lockremote/lockbranch" &&
+	test_when_finished "git branch -D lock-new" &&
+	test_when_finished "git switch main" &&
+	test_config remote.lockremote.url . &&
+	test_config remote.lockremote.fetch "+refs/heads/*:refs/remotes/lockremote/*" &&
+	git update-ref refs/remotes/lockremote/lockbranch first-branch &&
+	test_when_finished "rm -f .git/config.lock" &&
+	>.git/config.lock &&
+	git -c core.configLockTimeout=0 \
+		switch -c lock-new lockremote/lockbranch 2>err &&
+	test_grep "unable to write upstream branch configuration" err &&
+	echo refs/heads/lock-new >expect &&
+	git symbolic-ref HEAD >actual &&
+	test_cmp expect actual &&
+	git diff --cached --exit-code &&
+	rm -f .git/config.lock &&
+	test_must_fail git config branch.lock-new.remote
+'
+
 test_expect_success 'switch back when temporarily detached and checked out elsewhere ' '
 	test_when_finished "
 		git worktree remove wt1 ||:
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index ccfb53efa3..b9c169a91a 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1105,6 +1105,19 @@ test_expect_success '--set-upstream-to hint uses short remote-tracking branch na
 	test_cmp_config refs/heads/hintbranch branch.hint-local.merge
 '
 
+test_expect_success 'branch with start point fails when tracking config cannot be written' '
+	test_when_finished "git branch -D lock-new || :" &&
+	test_when_finished "git update-ref -d refs/remotes/lockremote/lockbranch" &&
+	test_config remote.lockremote.url . &&
+	test_config remote.lockremote.fetch "+refs/heads/*:refs/remotes/lockremote/*" &&
+	git update-ref refs/remotes/lockremote/lockbranch HEAD &&
+	test_when_finished "rm -f .git/config.lock" &&
+	>.git/config.lock &&
+	test_must_fail git -c core.configLockTimeout=0 \
+		branch lock-new lockremote/lockbranch 2>err &&
+	test_grep "unable to write upstream branch configuration" err
+'
+
 test_expect_success 'use --set-upstream-to modify HEAD' '
 	test_config branch.main.remote foo &&
 	test_config branch.main.merge foo &&
-- 
gitgitgadget
