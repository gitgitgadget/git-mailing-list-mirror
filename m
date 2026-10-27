Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793105042;
	b=dIa9pp5sobCljsyh2pKprGMi+kaqaUT6ccqX9lH1bG2iiJy5VKvwhk11E75PUuQUIzWS
	 jARfnVpHT1iwO0oOhJ+don4bwhA0XkInKPMtbe1v5ey3daHDbSd5W8+N80mcK9fbAC0PP
	 Mqqg+2SaC6B8utQJs669vwh3jCFpZg6iOyy8Snw5Kjb869QPKKYyqFQLCwwTfBj8pMSzZ
	 nQMlHeNcEudvy28Q+XGr2m0zP5aH1uBTm6MEP+0k2wUYo4VO9tWCbbzgkffNG+b8txmkF
	 kFuwZMv/sGjtL40fmACzv+4uQHM+LJS41iO2Xx6Nn3ZPg14JncUsn4WdpOE7lT+djKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793105042;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=qicrcG4jpDxrpCPt2OkIh37zop0afYzmlQlcwXvRo14=;
	b=u07f25Adqw/Qr2Z2pCyoViPIGOLWSbRlkEpcxBiMEBrMCwR+XDFxF7kTA5gnK4QnJ7qe
	 TVL+Bja56qf6WoSj32sCLzTfxBmhftD+A3Zhl+Z95o1mqevk61A5bCSjZLnzsA+vJnvZb
	 mhrCaAGE/5VBobUj2Us+AAeXpBk6AhrrHZtmrGzey9rOMC5y2xtqe3z28vz8tapGjfIUm
	 a6eBm/UrhNFHpCncKeR1TWuGtvAH1lZ8jSn2Dgc1GwbkYT3swkhOiFmn0qOmfKRraO0ke
	 GgcgrZ18LOBx0Wsa8az1hxNJPZFKkVNakDlTWGWCLsyxfafaXEo1sn8JS2bVSwuy20Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m1ZYe9qK;
	arc=none smtp.remote-ip=209.85.167.172
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3628606A327
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 12:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3628606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m1ZYe9qK
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-51f2e9e6987so524648b6e.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 05:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793105041; x=1793709841; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qicrcG4jpDxrpCPt2OkIh37zop0afYzmlQlcwXvRo14=;
        b=m1ZYe9qKUcclCAeUY1dJ951etd/4WgfTLuaBdAueAETm0563qn/cm2eb1ONyW05n4h
         Pus5yBVxAEgSgE4eusdwCecyla18r4zyxJcoUEMLBfO8cCiWCoL2GMyfdrM69AC4INPR
         wjWUxn5nJR2NAY9TeAZI+1lgR1LJJVZXxpstepFfkSP77JIiSjCflG6dbJArZuLGdWHT
         g/fMEBndB4DgFQLkKuez+gjk1GCPOm+6A6eHgg7CD4i3A5KOF2HOrbypA92KhaGNwUr1
         9D7UZG1gLBrJ2nxSbbgBvJkL9i/KrOGFi9Xb1y5OyoMhfH4RciEsZ/Xyydaleg/fMkEv
         Peog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793105041; x=1793709841;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qicrcG4jpDxrpCPt2OkIh37zop0afYzmlQlcwXvRo14=;
        b=jFPEIupZpUmOlqjC8mORWNVyDzsHUnSlJK67b4PF3PTCbc40fIKQL2Lp80VkfAB+fH
         w0+Sq4w12eE8cp3kk263Fr8CNFrKIxo56/Xk1knNoJN8JzL+iLQyyhxYRjfQI/FOpkY8
         tBl5ZQWggOIdPzBk6Evg/r3KhHRyhwLbEUdOrKDFHSL7yZyMQs/rJmrbKCbXvkiZFQa8
         N75maMKRv8n1I1H9j6uvL7+nqFW445JcqWcLO8QG3rDXEfOZtC802bkOja9dTJDnu574
         vhL/HG91x0HzatOZvK6/btYmryPeLxMSjYTnYMflP8UspTHXkyqfnxYZHEZbyQh0ZlzD
         oQWg==
X-Gm-Message-State: AFq9FYLCdtbo9OKMS43PlvCABLgbUkwtFLCxaQtyYO1gkuDjURnhTXlU
	e4MA4K1Neh/p8GH75A6iM3KEURBs6GvfnZo04JVP9qmGf6f2++PFbUmKIapt6EFX
X-Gm-Gg: AYBFou2nHRkvNkqd5tkUgFVQKwOXIkyVZ1fi4FpbkEB9/COsmicKHn6t7UHVWuR1Adf
	lTxyAgDqARELLkrzBr2QPsoRvjN9k1Kf+VsQCQ2A22Vftsk55qXnay2iWcs5s1vJ4TO5lWu8Laf
	jPpVV4mrx8h2Age331HgpFRi7dEpiseBwDrpQiBmXCA/F5Mui4oIYCJO4zPucezy1/GFD10xxIN
	DaDHD+/wjR6t2a33AMQc102/ZnDSLlfED8q8DYQJ/5RdytAB0wg2YbSoP7BPadlZD1BAeYwb9or
	OmRjPzwkVczd3XZ61fZaRu8ja4csQKct8a00o3zWtbAMTQtM/kK44uIWV9kXRXsVTBzp89VqcQp
	9WQS68wNcfwDfO1B2LjdIaUZGAcb5nDV6TxYL+NMBt45yyVJUlKLh0SrnmIwybjXb60hqppe3kC
	M49m8n+VTjvYk7tiIQmg8QFaLGN9YHPn1NkZVZpg4pA5DiLUlXt0tG4FeJvqvPHaD4jiDxmfwk9
	c3GCYyTsGFu/eg9ZN9gzoLNUe6CgmlrnTjPq1ODk/huOTQ28QsrghwM0s8U
X-Received: by 2002:a05:6808:250d:b0:4f3:68d6:f07a with SMTP id 5614622812f47-55f6c208cefmr1253132b6e.30.1793105040648;
        Tue, 27 Oct 2026 05:44:00 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.167.85])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c0424a05dsm7718277b6e.4.2026.10.27.05.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 05:44:00 -0700 (PDT)
Message-Id: <pull.2466.git.git.1793105039624.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Oct 2026 12:43:59 +0000
Subject: [PATCH] remote: resolve "simple" @{push} when pushing to another
 remote
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
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

With push.default left at "simple", a branch whose upstream is on one
remote and whose push remote is another gets pushed by "git push" to a
branch of the same name on the push remote. But @{push} for that
branch fails with "cannot resolve 'simple' push to a single
destination". As a result "git status" shows the "git push" hint under
the comparison with the upstream, even though "git push" goes
elsewhere, and leaves out the comparison with the push branch when
status.compareBranches asks for it.

"git push" learned to handle "simple" this way in ed2b18292b (push:
change `simple` to accommodate triangular workflows, 2013-06-19). When
@{push} was added in e291c75a95 (remote.c: add branch_get_push,
2015-05-21), its "simple" case only covered pushing back to the remote
the branch is fetched from, where the upstream must have the same name.

Make @{push} follow "git push". When the push remote is not the remote
of the branch, resolve to the branch of the same name on the push
remote, as "current" does.

The test added in 9bf9eed093 (remote: fix leak in branch_get_push_1()
with invalid "simple" config, 2026-01-19) relied on a different push
remote being invalid for "simple". Use an upstream with a different
name on the same remote instead, so that it still exercises the error
path.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    remote: resolve "simple" @{push} when pushing to another remote
    
    With push.default=simple and remote.pushDefault pointing at a fork, git
    push pushes the branch to the fork, but @{push} fails with "cannot
    resolve 'simple' push to a single destination".
    
    So git status cannot compare the branch with where it was pushed. Make
    @{push} resolve to where git push goes.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2466%2FHaraldNordgren%2Fat-push-simple-triangular-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2466/HaraldNordgren/at-push-simple-triangular-v1
Pull-Request: https://github.com/git/git/pull/2466

 remote.c                  |  4 ++++
 t/for-each-ref-tests.sh   |  4 +++-
 t/t1514-rev-parse-push.sh | 11 +++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 49ee2ea318..fd434a3a10 100644
--- a/remote.c
+++ b/remote.c
@@ -2016,6 +2016,10 @@ static char *branch_get_push_1(struct repository *repo,
 			const char *up;
 			char *cur;
 
+			if (strcmp(remote->name,
+				   remotes_remote_for_branch(remote_state, branch, NULL)))
+				return tracking_for_push_dest(repo, remote, branch->refname, err);
+
 			up = branch_get_upstream(branch, err);
 			if (!up)
 				return NULL;
diff --git a/t/for-each-ref-tests.sh b/t/for-each-ref-tests.sh
index b1a10dd933..4991a82b91 100644
--- a/t/for-each-ref-tests.sh
+++ b/t/for-each-ref-tests.sh
@@ -1745,9 +1745,11 @@ test_expect_success ':remotename and :remoteref' '
 '
 
 test_expect_success '%(push) with an invalid push-simple config' '
+	test_when_finished "git config branch.main.merge refs/heads/main" &&
+	git config branch.main.merge refs/heads/not-main &&
 	echo "refs/heads/main " >expect &&
 	git -c push.default=simple \
-	    -c remote.pushdefault=myfork \
+	    -c remote.pushdefault=origin \
 	    for-each-ref \
 	    --format="%(refname) %(push)" refs/heads/main >actual &&
 	test_cmp expect actual
diff --git a/t/t1514-rev-parse-push.sh b/t/t1514-rev-parse-push.sh
index 5a4f16867a..4187e2a504 100755
--- a/t/t1514-rev-parse-push.sh
+++ b/t/t1514-rev-parse-push.sh
@@ -60,6 +60,17 @@ test_expect_success '@{push} with pushremote defined' '
 	resolve topic@{push} refs/remotes/other/topic
 '
 
+test_expect_success 'triangular @{push} with default=simple and remote.pushdefault' '
+	test_config push.default simple &&
+	test_config remote.pushdefault other &&
+	test_when_finished "git checkout main" &&
+	git checkout topic &&
+	test_commit simple-triangular &&
+	git push &&
+	resolve topic@{push} refs/remotes/other/topic &&
+	test_cmp_rev topic topic@{push}
+'
+
 test_expect_success '@{p} is short for @{push}' '
 	test_config push.default current &&
 	test_config branch.topic.pushremote other &&

base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
-- 
gitgitgadget
