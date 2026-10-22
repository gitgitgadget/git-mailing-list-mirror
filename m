Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792637505;
	b=rXx5DlxKT1RQ1g86QJb9RB14O48XNWbG4hcE1uL6KyhHQtCozbLOI/GnaNoA/AqrsO0T
	 1r6Bj402JGXwqxQsOfdstqNPPDrAtwLe3FqNSQVuakoL+OVD2AHWOglB27HpI6gzT+V/F
	 fkfm2gPqIZvPsMQJVbes1rky+zKz/SHLgDrONEj8NbPczo9a3nKHdF4jP7kSy4eCiVT4/
	 5vd6IBEr05LBMSoy54ELk5A1qx8pYela6vkTLdWRGoTgUalb+zuXq0u2LABzithxD2bDi
	 cGLuT80vNX30Z9HUkffRPfjNUWlD7VCk52exaUpJXkAdOr/u/MetjBlQvjPbPqZNquA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792637505;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Rt91wLqFiiPjpAteQmQVVjnzBlcqoaL9xlh2ZMf0u3g=;
	b=wWktx3wao5Ldhxh02atQAL5ywVDjUVR2EEX4dmAB3VPALRCQdV0xFkHDRQv2K69KSeSB
	 26XlUK24K0RfwFz9cIZg581VigvhHWOwfjaVWw7ndM7soXs06VANbSuIicYO2wigiMyGY
	 sYlkrAxpaQKpWFyFHQ1BwgR5bmX30IzVKCQujnzmv0rz0bz8V4GAVKE4Cn462ZbfSIkQp
	 Tye4LGDXtujH+rAybMuVjHKH25J/WpIwIlZ4nENc8NEa9yyJaNlbAFaK+BV8bfmXEGxcx
	 y0xu1t8q9E3YK0688gDLAUFGUNNZFf+SVKQ2I2hj5j4yUQ0Rq7D57uauTPvzIvAsObA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ru0xWwWe;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B655606A331
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 02:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B655606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ru0xWwWe
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso7365105ad.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 19:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792637504; x=1793242304; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Rt91wLqFiiPjpAteQmQVVjnzBlcqoaL9xlh2ZMf0u3g=;
        b=ru0xWwWerMeYvZQ+wuqtISDtBxrxVHydpqnTcUFh1PJSvPsPpKo1qTGsocJxlYaMAK
         z81RrUsSgnzqcep16oBIA5InqgrdguoP630b/b2GUMT1vRH+bjTje4P3PpgbwLeCA4gl
         yV0jTs1ZNIP6i60IXvebDwtQy5Wg5fDNWKyYVzIUfZBnhfodpUROQHvCLJYN8LO1+2dz
         Kh/99o6J2fMiOlDNMfUKrsXsTDABgcqOXgelTDMHg2CPDzqtLW6Q6i3eDaNxPaYJx3vk
         bnbbwKIXBoBMQCBCEJudXcwX2ZIHDl/pafmK+n037CNOF3P3WeHm/KGXRN9XlRzL2oTn
         Zz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792637504; x=1793242304;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rt91wLqFiiPjpAteQmQVVjnzBlcqoaL9xlh2ZMf0u3g=;
        b=sEGR9SQBlm4NNKkMTmDfXlYr59lMjHgPj1Y8y2WlDthnIU1/kL4NlmsUwjba33tMt1
         S42B24ekEb+9ZFCp2z6csjfEPSOmayiyyipWVN8xfnozcj0nBbST7ORF6o+w1bQWglgi
         dPksm7IbGIlOUGG+Q58kGvhTcsevgUCLePZYP7U9YU1usyOHDTUH7qdirrYWZColnw5t
         hU58fOZNfiqAzNXyCZxcM6BHLubiNmLVJeQVzhhUOfemKkfUr5A/PPn/rgAiVMB9ej9+
         9B2fpbVqlPGOXCnTz7hOQBFp/EGyiNPHvHGgzslSOSoz/Q2rjMKmX7NhNNYSJS8jzl+f
         nLIA==
X-Gm-Message-State: AFq9FYLFcbWTG8bKAeLJNcjNBjM6NMAkLg7WpxY6LFhcRbqBH1PUqb6O
	1NgtyugEJZ7+xilUmpAo2yTJZTjwiYJqiGCPdXLxnTDIz2FnreemDVf+6usIFA==
X-Gm-Gg: AYBFou21r388SC/nWXwbh+O5Gdp0KRrrKSG780pY71VzdWORs2SXexvUfWiPvze85KD
	A4D6+Hm5VN+YUJGeEcidqKhzZ5ObRJ8qjN30ilfOL6tjFIXB/u54+amyVHa9iV/kzV8PyzoamTk
	Wv8Z2ER2EuWqyaxydqzzEZ/e7P7I15RajNcVbgREF8tmz60B5bZLp0206FEtuNNvXcCqsYEEPI9
	JwhzkvnpUNeKQNTjfcv8YKgSvZ9C/ZY4lZsFU/xef3iAoHsmbI2K49ULUPw2Zb85nIheNUmmwXS
	avTF4JvINEo+wwP94PFXV/boSQq9Ultn56U8yO4FG+KuHt+KyFb9b9V1NGFQP/L5K+nwkhhq8iH
	qEvsBKSemWJpiN2GM5PZVbcDABpVawQTGOUtOb53dv73T/JkAHVuNRf/vN/cgL+JQRZDmcSVzSq
	mKwl+1GGv2TMOr4fQFwWqMnUAUwsuPpXOgoQWJNrWaXz/18BGpig4F7he2zwlY4/hHV2y4U+NW5
	Zb5p1cA1ZXrrKb6vJQAxTNXFN36qEaGtB4X21ZyK0lzENr6LaRLC99vrQ==
X-Received: by 2002:a17:902:f683:b0:2e9:5c55:c46a with SMTP id d9443c01a7336-2ea4396c346mr30616195ad.7.1792637503887;
        Wed, 21 Oct 2026 19:51:43 -0700 (PDT)
Received: from [127.0.0.1] ([52.157.2.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4356c1sm17568865ad.38.2026.10.21.19.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 19:51:43 -0700 (PDT)
Message-Id: <fcc73a773a7eba2612d983f8957b82f3d4fc09ef.1792637495.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2275.git.1792637495.gitgitgadget@gmail.com>
References: <pull.2275.git.1792637495.gitgitgadget@gmail.com>
From: "tsukasa inoue via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Oct 2026 02:51:35 +0000
Subject: [PATCH 2/2] checkout: finish switching when the tracking config
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
index 13a2938b42..c5e2202026 100644
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
index cdb6c6a634..ca1a1c7f86 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1080,6 +1080,19 @@ test_expect_success '--set-upstream-to fails on locked config' '
 	test_grep "could not lock config file .git/config" err
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
