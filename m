Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618523;
	b=V1tacHF3bpQq2Et3DeVbSleW8fTx/MkM3ZHsRxxrnWGK6QC7Fi+Swd5FRpsv8su5gDKs
	 4UAjQ2dd6+RqUPHPX1GV7AxEepJMmB8Kj5fwTB4qjc1WdqstXUs/3Hn6FSOOrwDdFVKpj
	 +MxGXIqTWl9N1eYZR9Zby5bFXMGB+LajWlg+PyG/LL1/QgtU1H8DOXkoiocRWrzSHd7m1
	 4dr+AisMaxAmoY7YB3cd00M3WJq+hVPNmr6cjtKB0ZmhUAsLbW2yHsj4wNMK6NSF+dH3m
	 GtJMYhZi3ojt3Ii6qFRnHCcNbfz4oXYBpy5i5TDidufMkMRqQnP+0xwL+OSdNCkmylg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=sBDwS7deOuuluPOzRttBWOjBMDYsJLLsXjw+u1TqMwU=;
	b=GWgDZKKjSuLN1AUl9cWzP0DAzBPhAhXxpaXBA7pqmBcvIsOq56dT9XxbRHNlp51iBvbs
	 LzoSo48kfP2lALLDXBRElbA/UPTPDKvUMFDY0tbdoC8TBXjaNgVBrRJAQxV0J+GJP7xIl
	 e5U4W6ZfxVw1QP3BWmYaiJoV7OrCziq4o/B2KEW+RTMwCwcQZ18C4y58ZHRMKRGhpxFDr
	 938OQYDBaqQdZWncyNq1/W3YQ7q0JttqXLGVZN+9oP2zNUWHfLzwsHiACfjGTpdtF/YrA
	 W3gB4dQSJO7W9EVmd89+G7sc2xgzqXnabCVl0AWaRp65J0EmzsVLOxsHRHdB2aHVLFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GbuOWl3K;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC19606A31F
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 21:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DC19606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GbuOWl3K
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7fccba9c675so307773a34.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 14:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792618522; x=1793223322; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sBDwS7deOuuluPOzRttBWOjBMDYsJLLsXjw+u1TqMwU=;
        b=GbuOWl3K307NmRq7mbmVR1sruplwoJchdg9hM4Jz5oZPC+lPHyYl7PmfFnzFoHYowK
         iZFKfuzL9KvXjWQ83OHyDAOZ710i3igsEkOErIq0RFEYhdEpCYJwbctaiFVxQ4JShIXo
         yRutMEdgQ/SV5RX/2orO8NmOn4+qSqreiCCIePA+FARFJXauGPI+ssBXsCSKS8JqO1/W
         +MMwCnc9ZBdKRHIvfYkbg2Rh/MqRjEOyypNAkpqY6LK0zfHg9RBWftiVznzpyy7FCeEi
         9gbPaxDDF4Q0GLUsZmazPpCBRkwt+qMlasg3sYlMp3LZerYPTv39xspXkIzYw0weZ2r1
         hiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792618522; x=1793223322;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sBDwS7deOuuluPOzRttBWOjBMDYsJLLsXjw+u1TqMwU=;
        b=J6HEGOK7YoFY5/GahkU6ITf4YW83R+aPP3tZmpTnzpDMJVEde098q1/i7+67S+mRV9
         Fu2rd0c8BKtS2VICzzE/3EhamXGn46qsDKYD+97xd1pt3aZsD+A7re6h2WfHCy7qxC9d
         1PH16xwaKWmk32rxmLdRRR6hb09bLUM1uNB6lw2/5YE+y+CIincAMXDfTjr1O8dPLI3e
         yU75AWYo+PqQgRhwsWK+wKTe9x5RWTtOy5VSvJyDmqQn3UyBZMXhL0DdbrnAlvfIph+t
         SRT7qK4LW+dZ2GG6Z8HZ/of7q2Zd4ghh+1e2izS7CJ0xa0gRuRHTJjA0ScI12gnjeXvV
         mWlg==
X-Gm-Message-State: AFq9FYJg655mrMRvraP88/dvzRL5Cku6kLHrXIJKGu33qK29Y6MM6yFn
	qOzllfDow7eOdK7fEaQKlzFGcDXMkpCB51M0jVjjc8mPy9TbZY8L0ONUtCkl+Q==
X-Gm-Gg: AYBFou1b+YsCHo2iUO+LhKlFZdlFEj1tZSHmVn9uojuQY1pDVlMEzA/okX2bMeItTeG
	fbdMK2hfkjOaiehXMrMnFCRn/TGZFF1HLf+PX7ZKozLJGmcACa//0tGUHvZZ0hF0GU0F2G/SMWF
	2Xqvn7pK2FbREP5bA5qIvrnxATupm/uwKZ4OC+pv44JLmimXlmLB728UYuXr+LwFKvoUNWKeyoh
	moK1YnpP5Run73bAhAM7CrueVe53ClLG0no5Apc+IN9WEglEjuVkZp9Xi94IBnY21KMOFuKIHOh
	30qb79wmBr6Q2SXdZARlI4r158TwYcVFuQEp033poiasH3gTOzkKGan6DXpen+JdeGJ6dj0TylA
	Ax3Nypa4EmB8Fw03CoT/5HzPK/gFJvPD7GH4wxyjdYqQwMPYhphOJKKjDzjC1oM0/N9ADKMCGlA
	uB1RCZQQ0I6uUbqEqJ6q5R7XMSYf4RoM7ozhmjuJeq2M4rWwVH2J0lJgLn8gX6oz+fI+qgUpKYa
	lrv0XLO7/xWDkMqjc3yY4KdqcRbZ0/C+wGe+bkCFA2usyKG7urwoak7BkU=
X-Received: by 2002:a05:6830:10c1:b0:81e:a314:7f70 with SMTP id 46e09a7af769-84e30a2b879mr297344a34.1.1792618522044;
        Wed, 21 Oct 2026 14:35:22 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.201.57])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84cbcdd969csm3178581a34.11.2026.10.21.14.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 14:35:21 -0700 (PDT)
Message-Id: <e7059183786a5983bdebda34b3eb8f8f822ca9c0.1792618518.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2268.v2.git.1792618518.gitgitgadget@gmail.com>
References: <pull.2268.git.1792458904027.gitgitgadget@gmail.com>
	<pull.2268.v2.git.1792618518.gitgitgadget@gmail.com>
From: "tsukasa inoue via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 21:35:16 +0000
Subject: [PATCH v2 1/3] branch: strip refs/heads/ from the --set-upstream-to
 hint
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

When git switch fails to write the tracking config, it prints a hint
with the command to set the upstream by hand. For example, if
.git/config.lock exists:

    error: could not lock config file .git/config: File exists
    error: unable to write upstream branch configuration
    hint:
    hint: After fixing the error cause you may try to fix up
    hint: the remote tracking information by invoking:
    hint:   git branch --set-upstream-to=origin/refs/heads/feat

The hint says origin/refs/heads/feat, but the correct name is
origin/feat. Running the command as printed fails, because the full
ref name is not a valid remote-tracking branch name here.

This has been wrong since a3f40ec4b0 (branch: accept multiple upstream
branches for tracking, 2021-12-20).

Strip refs/heads/ from the hint, as the success message in the same
function already does. The git config --add line for multiple upstreams
still needs the full ref name, so it is not changed.

Signed-off-by: tsukasa inoue <inoue.tsukasa.4@gmail.com>
---
 branch.c          |  8 +++++---
 t/t3200-branch.sh | 25 +++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/branch.c b/branch.c
index 22f4f46b96..bb07846911 100644
--- a/branch.c
+++ b/branch.c
@@ -186,12 +186,14 @@ out_err:
 
 	advise(_("\nAfter fixing the error cause you may try to fix up\n"
 		"the remote tracking information by invoking:"));
-	if (remotes->nr == 1)
+	if (remotes->nr == 1) {
+		shortname = remotes->items[0].string;
+		skip_prefix(shortname, "refs/heads/", &shortname);
 		advise("  git branch --set-upstream-to=%s%s%s",
 			origin ? origin : "",
 			origin ? "/" : "",
-			remotes->items[0].string);
-	else {
+			shortname);
+	} else {
 		advise("  git config --add branch.\"%s\".remote %s",
 			local, origin ? origin : ".");
 		for_each_string_list_item(item, remotes)
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cdb6c6a634..ccfb53efa3 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1080,6 +1080,31 @@ test_expect_success '--set-upstream-to fails on locked config' '
 	test_grep "could not lock config file .git/config" err
 '
 
+test_expect_success '--set-upstream-to hint uses short remote-tracking branch name on locked config' '
+	test_when_finished "git branch -D hint-local" &&
+	test_when_finished "git update-ref -d refs/remotes/hintremote/hintbranch" &&
+	test_config remote.hintremote.url . &&
+	test_config remote.hintremote.fetch "+refs/heads/*:refs/remotes/hintremote/*" &&
+	git update-ref refs/remotes/hintremote/hintbranch HEAD &&
+	git branch hint-local &&
+	test_when_finished "rm -f .git/config.lock" &&
+	>.git/config.lock &&
+	test_must_fail git -c core.configLockTimeout=0 \
+		branch --set-upstream-to=hintremote/hintbranch hint-local 2>err &&
+	cat >expect <<-\EOF &&
+	hint:
+	hint: After fixing the error cause you may try to fix up
+	hint: the remote tracking information by invoking:
+	hint:   git branch --set-upstream-to=hintremote/hintbranch
+	EOF
+	grep "^hint:" err >actual &&
+	test_cmp expect actual &&
+	rm -f .git/config.lock &&
+	git branch --set-upstream-to=hintremote/hintbranch hint-local &&
+	test_cmp_config hintremote branch.hint-local.remote &&
+	test_cmp_config refs/heads/hintbranch branch.hint-local.merge
+'
+
 test_expect_success 'use --set-upstream-to modify HEAD' '
 	test_config branch.main.remote foo &&
 	test_config branch.main.merge foo &&
-- 
gitgitgadget

