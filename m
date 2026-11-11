Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410906;
	b=NCWl/w+V43PHOuuvXTGEOuhbMFZQCZS1+pk5JBLAfvLBKNQL7kqs4I4LxXgU9omT1c65
	 atxmEJnYJ1sINoQfAyfQK0w8ftbMIZ6PB+C1HP4CXekrkzFx9MkcvZ/ybr/dHH3WzXV/x
	 agUzTurcg01poQzW+of0h5du5/Ru9hTtYfWsO9+zKMng6GDrBoED+pYNBDK326VBY7LeV
	 J/LYKBiC4ciJln/qXv6kjco+SV5RpDnEaXMXthTf8+SjgC7LNgliHcqdoR84XiltX/apR
	 qFuVmEjvTUOi0xpi3Y7DnjsNf1sA9ASyNzbqzqw5zt8xs2EwWNrGVLFeinDqVjXfQyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410906;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ro3NWOlp2Xl4MApWqqkREEjlNHzbU5jUfQNPRGiIPds=;
	b=3jxU2VvjSJUdcxekWTGmD9ylfO8mJyU435yUapG9o1ofZ3KkcJjkScmmx/nOAOTcc1iG
	 lQAickhYhCr/XqC3NjlkcP3KKCKR6WQJOPbJtbJrmeNactbWlSXttuWfZ+VpBlQW4L42C
	 R2TRlmgbV1h/CIxdMk3ptp8IzPkUf1Y/tGJUdXFSHVSW9kQ1lBRQ8B1e54KBxtfAjyZTp
	 K416D5AsNj7aad2gkF3aDNF1AgYV/FTyckkwv0l5oqoacm+c20l97l2HKkDc6ImFOmzD1
	 14WnKU3JgFaw7ENS15SZESH9yY796uYxXOsSy9+Jp3kCkU5ixhyCuQnMIJg1OUviW6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=Q3h7hWhy;
	arc=none smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663FD606A8A6
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 15:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 663FD606A8A6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=Q3h7hWhy
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7d2bf046ceaso1792434137.3
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 07:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1794410905; x=1795015705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ro3NWOlp2Xl4MApWqqkREEjlNHzbU5jUfQNPRGiIPds=;
        b=Q3h7hWhyQSfRuxe7hVKHM82y/nWZpn9BWs3BlloSyOHITkQiQjvBXUV0UtEnHa3LJI
         7Kyub4XIHTp1POT9PRKmA3vzBjONRJtYFWlme87Dnj4pyD1bgxuSPIpF4WX/w9rlu7iU
         wuupv3lvT7Jy+URjNe+J7jz20N08a//kNvvw09erJ/1sDiMYs7Cs4uNEMCkflUGmQjqH
         XeRdLpC16M9gSYcw1MT6spbWAGSwanGQ9KUATtsycsggqzu756uzjWRqWlOHX9CuYkt7
         Rc+Jg8iHS/ECNZ69zC806DXbsMCa0k9QSXuMM2cwopoX496jMzS1V3osx5j91F889udS
         MEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794410905; x=1795015705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ro3NWOlp2Xl4MApWqqkREEjlNHzbU5jUfQNPRGiIPds=;
        b=LBYW9xwyMgf0dq8BtJLstHJbn5kTF874eaZxmBQX73Ip7lcLcDDsK04gY2UaKfXCse
         nr0VRU+ohZ18osbMOy/oWm2nqC7um2fxCuNCha2m3Iq6etuvKzasFnq/ekh6C6r9ePRN
         UE7gnEFRvzugfWuLlkToaN4fGNdhzH8OfwghnR5DSeJbtzRLTmVFhQwLOQBHNrKNa7fH
         15HU48Gckea74gaTkjYi/269yEwIhXL1Jm7aXvb4EzQBKfdxKGAjhdFnwMdCu5L41VGY
         yWrnFPRWAS1WmW3yNakBS+HQ9hdI+1CwXRXS/nKn+WAoIkBl90NDFfD1MEJOvB1yWcN0
         VsCA==
X-Gm-Message-State: APuU4Z9emjd7Ed6yWfGmWQLgsnIxLJ1qusqCsnOVCpszrqJnG5Ef+zQ7
	dyf4/8nLhYSJiL0fyHs5bpYTkadF+doTek9tCwBvvMjKVJcVZo4263XWw3+VxdTBqpdRTSNXCMr
	r9LrXnbdLrsGuFfLGOwYmaFY3OzjFLD4Tfm2PtmLgEPAM5XtDrjpSFG6YT3GJjMQlk9crbwrEH7
	P7NplyY7pJBMclGwUCr2TNVJNbb8K3eh+KGubBWd4RybbsvSauuiGs943Q1viFPjkMYwzXWE7x0
	Ptg/b7uiIaZl/bJL4KZGldHZY466LoxUqXF2G1QpmA=
X-Gm-Gg: AYBFou2edM8phk8BCWyLIAVCHoayvp0WCfSzYwTiPJI9nZZqmu+b97kJKKKPjGRdB+g
	b477RgULFfaGKj9m8IImaNUWS8rKmfhhZEuzBA+J9baTbHInIKbpDLH43wOuiGuAvGWBFcMxmqB
	WKoC3VcKeKX4F1OLQKhW93zEmgcSYeEK9YqaY/VkKsZF/aoIZX7h8i67PM9PoWDLrNIXguFDCXa
	oGaH4vF0W07tERhGlIYysNq7WQzVK8JcnyvmjzOa8VJInpbROPJoG802KbN6fIio5lbmFlUMjaX
	5dD6Y3x/v6tUEdxfw+Wn9JkrAlTra0vsy2DEqvnCOgO2xdValuVmyF6qiYw04Ut6iEBbF7kIvm+
	l0LpEaDTJzwWVWmddwAPfUfXjQo/6mIxyCxdqfcfshfTo7p98mqeMCkQZ9cHGum8kBfhJ+kdTin
	q/BoNBfTUVr6TkfMjeZy6hxl153LjAwC5c5vAYXWYZWI0V7r7R8tJuErekwn8Kc1mDxO9y1mFZk
	uVycDE4y/A59259KqIK0dLhu3mD/z3BW4vPdBHIM9+NIaDbN4LUmLesIl0PcdHPBNBxEWPj7/C7
	KDRiVRgROF26MJX96u4/1RUeN9+8+lGHC3UmH3yTbYF42lyFlrVZ7tiiyKM/0tGGbJ1Yhqva9MO
	g8wtobkAN1lEVsQiQnEH7Y6DwPus9XFTOJlVVsemBEKznwHCrWuNSx1dhxzolWw1JjKYDqJtd9F
	opWK8Zg2FENGx7NT80w9pVTrvVpzYeME5JRq0AD5lbE5SqaS/G9upR+P5J5FuYZwVS9YhMYbaq/
	K61kgJxXwv3NASeqVUY7WkR/oWF940322a67vIhnuwIfRd7LHbikzM=
X-Received: by 2002:a05:6102:149a:b0:7d2:7266:2c8a with SMTP id ada2fe7eead31-7d50621737fmr1113751137.32.1794410905192;
        Wed, 11 Nov 2026 07:28:25 -0800 (PST)
Received: from remus.wildebeest-stargazer.ts.net ([69.43.88.101])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f04c2b8bfsm21341136d6.22.2026.11.11.07.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:28:24 -0800 (PST)
From: Jasper Mayone <me@jaspermayone.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	sunshine@sunshineco.com,
	kristofferhaugsbakk@fastmail.com,
	ben.knoble@gmail.com,
	haraldnordgren@gmail.com,
	Jasper Mayone <me@jaspermayone.com>
Subject: [PATCH v5 5/5] branch: do not mark the branch the current worktree is rebasing
Date: Wed, 11 Nov 2026 10:28:10 -0500
Message-ID: <20261111152811.99986-6-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111152811.99986-1-me@jaspermayone.com>
References: <20261102182930.3511-1-me@jaspermayone.com>
 <20261111152811.99986-1-me@jaspermayone.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since "ref-filter: name the worktree of a branch being rebased or
bisected", "git branch" marks a branch with "+" when a worktree is
rebasing or bisecting it. In that worktree itself, the list already
starts with "* (no branch, rebasing topic)", so a "+ topic" line
below it shows the same branch twice.

Use %(currentworktree) in the default format, so that a branch that
the current worktree has gets no "+" mark and no "(path)" with -vv.
A branch that is checked out normally in the current worktree is not
affected, as %(HEAD) already marks it with "*" before these checks.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Jasper Mayone <me@jaspermayone.com>
---
 builtin/branch.c         | 10 ++++++++--
 t/t3203-branch-output.sh | 22 +++++++++++++++++++++-
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index a613148fc7..87670d16e4 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -424,8 +424,14 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
 	struct strbuf local = STRBUF_INIT;
 	struct strbuf remote = STRBUF_INIT;
 
-	strbuf_addf(&local, "%%(if)%%(HEAD)%%(then)* %s%%(else)%%(if)%%(worktreepath)%%(then)+ %s%%(else)  %s%%(end)%%(end)",
+	/*
+	 * Mark a branch that another worktree has checked out with "+".
+	 * A branch that the current worktree is rebasing or bisecting has
+	 * no mark, as the "(no branch, ...)" line already shows its name.
+	 */
+	strbuf_addf(&local, "%%(if)%%(HEAD)%%(then)* %s%%(else)%%(if)%%(currentworktree)%%(then)  %s%%(else)%%(if)%%(worktreepath)%%(then)+ %s%%(else)  %s%%(end)%%(end)%%(end)",
 			branch_get_color(BRANCH_COLOR_CURRENT),
+			branch_get_color(BRANCH_COLOR_LOCAL),
 			branch_get_color(BRANCH_COLOR_WORKTREE),
 			branch_get_color(BRANCH_COLOR_LOCAL));
 	strbuf_addf(&remote, "  %s",
@@ -447,7 +453,7 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
 
 		if (filter->verbose > 1)
 		{
-			strbuf_addf(&local, "%%(if:notequals=*)%%(HEAD)%%(then)%%(if)%%(worktreepath)%%(then)(%s%%(worktreepath)%s) %%(end)%%(end)",
+			strbuf_addf(&local, "%%(if:notequals=*)%%(HEAD)%%(then)%%(if)%%(currentworktree)%%(then)%%(else)%%(if)%%(worktreepath)%%(then)(%s%%(worktreepath)%s) %%(end)%%(end)%%(end)",
 				    branch_get_color(BRANCH_COLOR_WORKTREE), branch_get_color(BRANCH_COLOR_RESET));
 			strbuf_addf(&local, "%%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s%%(if)%%(upstream:track)"
 				    "%%(then): %%(upstream:track,nobracket)%%(end)] %%(end)%%(contents:subject)",
diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
index debfac5f26..5541f1429b 100755
--- a/t/t3203-branch-output.sh
+++ b/t/t3203-branch-output.sh
@@ -456,6 +456,23 @@ test_expect_success 'branch being rebased in a worktree is marked' '
 	test_cmp expect actual
 '
 
+test_expect_success 'branch being rebased is not marked in its own worktree' '
+	test_when_finished "git -C rebase_dir rebase --abort; rm -rf rebase_dir; git worktree prune; git branch -D rebasing" &&
+	git worktree add -b rebasing rebase_dir branch-two &&
+	(
+		cd rebase_dir &&
+		git commit --allow-empty -m rebase-me &&
+		test_must_fail git rebase -f -x false HEAD~1 &&
+		git branch --list rebasing >actual &&
+		echo "  rebasing" >expect &&
+		test_cmp expect actual &&
+		git branch -vv --list rebasing >actual &&
+		test_grep ! "$(pwd)" actual &&
+		git branch >actual &&
+		test_grep "^\* (no branch, rebasing rebasing)" actual
+	)
+'
+
 test_expect_success 'branch being bisected in a worktree is marked' '
 	test_when_finished "git -C bisect_dir bisect reset; rm -rf bisect_dir; git worktree prune; git branch -D bisecting" &&
 	git worktree add -b bisecting bisect_dir branch-two &&
@@ -464,7 +481,10 @@ test_expect_success 'branch being bisected in a worktree is marked' '
 		git commit --allow-empty -m bisect-one &&
 		git commit --allow-empty -m bisect-two &&
 		git bisect start HEAD HEAD~2 &&
-		test_must_fail git symbolic-ref -q HEAD
+		test_must_fail git symbolic-ref -q HEAD &&
+		git branch --list bisecting >actual &&
+		echo "  bisecting" >expect &&
+		test_cmp expect actual
 	) &&
 	git branch --list bisecting >actual &&
 	echo "+ bisecting" >expect &&
-- 
2.56.0

