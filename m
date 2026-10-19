Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437801;
	b=HYkCjekUvDyzhXTHo2BCqDywW+aSe3YYRk3fPfi7JaYLneqX+D5gQFXeBUWUJvcNQKGB
	 qahbYkZVFcfuWmF2tl4H5jPZQWrv8iG/7RxpQjY2Hu1pFXDnNuIYlOf7duzNQZ+VNdR4v
	 DSW0oNEUf16xT2RiNOhpM5EthAO2/b9bw9HZkp+XM6CUjMXCIb+5+4wkzWZ/VCotPHurp
	 gagCaYDjEFSsEJx3VLc7mk0hBQxjBpn5nxh3COMmV1D6vECd6Xj40PgdQJ2JkY1UC2G2f
	 3d6zMg/Z3ARwXYopj6IzvHJLPKnEVsMFGYDkrUSHm2O1Y7bLZF7b7ygmu7dwadkd4Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437801;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=pg+NfmeE8zer6MnTmQ8FHTxfhoG9m5sqaS66lE8pHDs=;
	b=4bwNObTHbudEVuxhO1rqIIiy2MNhuRnUiqY8FLz3A5z7NC1OJHR4ADvpJf/FFhDJTV+y
	 9+x+UlNIpTBViSroPtO3f9pHf28d2cXA+dX/OzzjtQ7o0Aq2ngI9LXl76yhfRdWOEAKYN
	 Lmjmc7iG41Gl0aGt+jsJkGy0L2dHbM2f6weZrv++kGD90OA04PHjwBE7lprqn4jcC35bX
	 46Lq/JLHBzDwBwlJS+MHmsGgGs3fZGq6CnOukejbRZ6OhZKuR23WS/HAIaG0lcsQQPG03
	 jR350VGQWrCyfrBIwEsynYMf/Qo8MdNXzklO++bytZm9V9hngb0zU0nzbl1L1IPVu1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mfGZOAFq;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50C6606A31A
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 19:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C50C6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mfGZOAFq
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-35d0be18c71so3934358eec.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 12:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792437800; x=1793042600; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pg+NfmeE8zer6MnTmQ8FHTxfhoG9m5sqaS66lE8pHDs=;
        b=mfGZOAFqmFayQqF6keZoUsv8EexN31lmoS0xrhohuGXxkgayIUhcaGuCV+wlSomPQk
         vgL4xsSYj8gPZiem24VSRLpTkZ6UedMJ5AhUhighA1xKx41epLA5kLiHgwvIX2N5fJfv
         EeV9w9K7EiPE8X5Wv1I1W4FYXCzxz+kSuE6q7mHQ3j1Kp5VgRBcDT/s8zueOrWk5iULl
         WPWxIzfxQgpHTmCyZIYHuo4jOYd6xGmS0VgYLukyEbL9VSnJHV1KcjMRGQF4Cl9GCthT
         UViWGuTZEv/qYrnGHvQTZ1a0mydZRlvwJRqFq/yjlM/ic1QY7HAfkYWvnek0MVIPJh7f
         jqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792437800; x=1793042600;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pg+NfmeE8zer6MnTmQ8FHTxfhoG9m5sqaS66lE8pHDs=;
        b=267HzDWbKid7Fko0VFWmjXObJMvzstGgHdyRdl8BhWc8Cna8z15eEY8Fx6hRJLIfWt
         Dye0Onk2W6MgpL+C6I8rPpZ6iN0rMVBrpCit3l5wBuJ3Kl3Qa6rQnBXz6BxKdoitC41n
         yVs4oQeJkCg53HNGmMnQYLynTQHaMb1kjzcpRG6lCBs295dGbFAjSZotUGJGPruflY9g
         SSoZAV/TGmmNnY2UIFCp8GzadmPs8TzqWTs5zTB4732Ao/St6z/GaKlbIiRyw2yzY2hu
         /5Bq1S3neiyZjYG8l8QalFgfj1Mc9RmwU6kPJ45rrYHKS9OYp3/SOXEvxJeSPnSPO9CR
         3HUQ==
X-Gm-Message-State: AFq9FYLH8sU97gLgQdQbdxWChMnqkEnmh5f0Rbd6bmb1Da7VQQ2/lQdy
	GkXBvhd5fQZzGcSntFMHeLUUc0P3QiNKkI6FFTncCHFHZ9tyDCoBsqrxnt5mlw==
X-Gm-Gg: AYBFou0bXJn6xSKbtPlcd3UCOijnOmQFHLnrxB6OYjfRJoy0mO/7YTwW+go1poNWHfZ
	UC9zvZ3Go/k60FOBGaiRcHXogZy0ShMgGWKACRYWISqXFFdKxMX6TskUHcr4m7uCE6ZvB2JOM4v
	OwkiPk5id3GldweBWjCczsXuAvAHmR0eLyGxU3EwFvskN55oCNsTrp7JKs9Cdo/sbEmF06IcLw7
	rodJB8TADIy1BatsAZkAOJ3U4gG5Jf+yM5wMnjvyqxMlp7pGNZSFaThZk0mcHkty5PVlY1A1cOT
	SAQn0f2dZ6qYk1foA2MaO1QfQWI82UcZ71TAH4Wcec7KWuIJfe/DLJNVcTzM00yywFF8hcTMPEQ
	d/vG+HIw5ivnPzfUmGnhSO/8tNk7+tsq6J19UvdNB+eW4vReE54HnCBTJOg1SWG2rJCsnIMKQJx
	TtOEO0eGRyJYVizU2FvsOkigenCdZtn0822XNEvclf6HuPnQDefFDMlNoJWGaOxYYuKS4ypaeP5
	0rg0OAYtw==
X-Received: by 2002:a05:7022:419e:b0:185:e68c:904c with SMTP id a92af1059eb24-18dbe2af64bmr132783c88.7.1792437799799;
        Mon, 19 Oct 2026 12:23:19 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.3.242])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-18314ef8ed8sm29209678c88.3.2026.10.19.12.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 12:23:19 -0700 (PDT)
Message-Id: <pull.2458.git.git.1792437798463.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 19 Oct 2026 19:23:18 +0000
Subject: [PATCH] status: compare against both upstream and push branch by
 default
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

In a triangular workflow, where a branch is pulled from one place and
pushed to another, "git status" only compares the branch to its
upstream. It says nothing about the branch it is pushed to unless
status.compareBranches is configured.

Show both comparisons by default. When the two resolve to the same
branch, which is the common case, only one comparison is shown, so the
output for most users does not change. Setting status.compareBranches
to "@{upstream}" gives the previous output.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    status: compare against both upstream and push branch by default
    
    Make @{upstream} @{push} the default for status.compareBranches. When
    both resolve to the same branch only one comparison is shown, so most
    users see no change.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2458%2FHaraldNordgren%2Fstatus-compare-branches-default-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2458/HaraldNordgren/status-compare-branches-default-v1
Pull-Request: https://github.com/git/git/pull/2458

 Documentation/config/status.adoc | 11 ++++++-----
 remote.c                         |  1 +
 t/t5505-remote.sh                |  1 -
 t/t6040-tracking-info.sh         | 30 +++++++++++++++---------------
 4 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/Documentation/config/status.adoc b/Documentation/config/status.adoc
index b5dd85b761..1d847d3a8a 100644
--- a/Documentation/config/status.adoc
+++ b/Documentation/config/status.adoc
@@ -23,8 +23,9 @@ status.compareBranches::
 	are supported. They are interpreted as `branch@{upstream}` and
 	`branch@{push}` for the current branch.
 +
-If not set, the default behavior is equivalent to `@{upstream}`, which
-compares against the configured upstream tracking branch.
+If not set, the default behavior is equivalent to `@{upstream} @{push}`,
+which compares against both the configured upstream and push tracking
+branches.
 +
 The entries are shown in the order they appear in the configuration.
 Duplicate entries that resolve to the same ref are suppressed after
@@ -36,11 +37,11 @@ Example:
 +
 ----
 [status]
-	compareBranches = @{upstream} @{push}
+	compareBranches = @{upstream}
 ----
 +
-This would show comparisons against both the configured upstream and push
-tracking branches for the current branch.
+This would only show the comparison against the configured upstream
+tracking branch for the current branch.
 
 status.displayCommentPrefix::
 	If set to true, linkgit:git-status[1] will insert a comment
diff --git a/remote.c b/remote.c
index 71170f36a9..6fdb4b84da 100644
--- a/remote.c
+++ b/remote.c
@@ -2465,6 +2465,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		string_list_remove_empty_items(&branches, 0);
 	} else {
 		string_list_append(&branches, "@{upstream}");
+		string_list_append(&branches, "@{push}");
 	}
 
 	upstream_ref = branch_get_upstream(branch, NULL);
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 5fbfcb0848..f77753605f 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -34,7 +34,6 @@ setup_url_pushremote () {
 		git checkout -b topic --track origin/main &&
 		git commit --allow-empty -m topic-change &&
 		git config push.default current &&
-		git config status.compareBranches "@{upstream} @{push}" &&
 		git config branch.topic.pushRemote "$fork_url" &&
 		git push
 	)
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index e95d420972..e10cde090d 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -331,19 +331,6 @@ test_expect_success 'status.compareBranches deduplicates when upstream and push
 	test_cmp expect actual
 '
 
-test_expect_success 'status.compareBranches with only upstream shows only upstream' '
-	test_config -C test status.compareBranches "@{upstream}" &&
-	git -C test checkout main &&
-	git -C test status >actual &&
-	cat >expect <<-EOF &&
-	On branch main
-	Your branch is up to date with ${SQ}origin/main${SQ}.
-
-	nothing to commit, working tree clean
-	EOF
-	test_cmp expect actual
-'
-
 test_expect_success 'status.compareBranches with only push shows only push' '
 	test_config -C test push.default current &&
 	test_config -C test status.compareBranches "@{push}" &&
@@ -361,9 +348,8 @@ test_expect_success 'status.compareBranches with only push shows only push' '
 	test_cmp expect actual
 '
 
-test_expect_success 'status.compareBranches shows ahead of both upstream and push branch' '
+test_expect_success 'status shows ahead of both upstream and push branch by default' '
 	test_config -C test push.default current &&
-	test_config -C test status.compareBranches "@{upstream} @{push}" &&
 	git -C test checkout -b feature3 origin/main &&
 	git -C test push origin HEAD &&
 	(cd test && advance work) &&
@@ -380,6 +366,20 @@ test_expect_success 'status.compareBranches shows ahead of both upstream and pus
 	test_cmp expect actual
 '
 
+test_expect_success 'status.compareBranches with only upstream shows only upstream' '
+	test_config -C test push.default current &&
+	test_config -C test status.compareBranches "@{upstream}" &&
+	git -C test checkout feature3 &&
+	git -C test status >actual &&
+	cat >expect <<-EOF &&
+	On branch feature3
+	Your branch is ahead of ${SQ}origin/main${SQ} by 1 commit.
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'checkout with status.compareBranches shows both branches' '
 	test_config -C test push.default current &&
 	test_config -C test status.compareBranches "@{upstream} @{push}" &&

base-commit: c51408889c3b372814bc20b9431c3b74d0d268eb
-- 
gitgitgadget
