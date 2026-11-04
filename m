Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818238;
	b=btlKv/Kw/eszi6mXfqsBjmwQiAgJTgFcA+gGLCHQ3/Euc9x4gnAO6KLazFXX++4qnKW/
	 R66Ec61C8mOwy468nQA4en7ddYK/XTogU80xsUpJdE+DsQXC8g7XQ6A/QHcex0xs7g6ga
	 Ouc8us59VYj6/ty5rBE4IixCxyYkWGvtfVJ/WPrTi1/QoVpSRi3YLQwSjjfqgSvVKEfWI
	 81+dNsTn0Rn3f04yvj+aLV7tvwfVQLJgAiCuJ3L/0v3bJggZvfIIWwYcKz6RaYthRd60Z
	 Kx2f426pWT3TIcjf2ryrAzJ6vUhXuzvqitjGamghXipM9t0mY2V8r9KOPAeHiDIMfCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=kC8AMGu++iS/uJq/laoFgHzwyS8Vpk87DdZJK90thkI=;
	b=XwYGPfTy368nWqxFx1KkBudZv7gcApu+7MKDSDwfdnP5Cxz0n5AqOhFEbQpGlmp59uwj
	 DF+8XsDOgsSH1zuITDWOO8l2MHBwa3xYOiNl9piTaw770xtqmrOLRO7/VwyVXutj2iC+t
	 Q+Arm2xGmO/MEqHAja08x94VNuMdKWajbbGBg4xQhEvrg5fXUEACzXcJt7JLB11pKP3vF
	 MQSJjJZxkpt6dczd4ItBkeI7BLenKx+u6E+Q59jCnhyhnUC7VBSi4c+S8QBK48Ta2oPb2
	 ljJX81DjDyq5clWDBAaLV/mXIHcncgOZa5SiJ8Sg2y4YiI7pyUFmpRUHZlfpvbCBZpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tylercipriani.com;
	spf=none smtp.mailfrom=tylercipriani.com;
	dkim=pass header.d=tylercipriani-com.20260707.gappssmtp.com header.i=@tylercipriani-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KSfRvos9;
	arc=none smtp.remote-ip=209.85.160.53
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D19C6082BD9
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 18:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D19C6082BD9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tylercipriani-com.20260707.gappssmtp.com header.i=@tylercipriani-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KSfRvos9
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4a76f63b243so1670873fac.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 10:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20260707.gappssmtp.com; s=20260707; t=1793818236; x=1794423036; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kC8AMGu++iS/uJq/laoFgHzwyS8Vpk87DdZJK90thkI=;
        b=KSfRvos9+nrmNr2a2O2fFASor1WC6LL9vdqMVTdziSnBF5EXvRYVI5xAcmqWk8TaLo
         RZX9E8dD6hipe0FmviB1w+Puoz4eLYXALaYD9QF/ymV+hrrhCT2N1lp+U7suZZ+QQ2Pe
         AZa0kbbrwqFoqHsFO793KMj5oSSyEtGJiPUMXiUKx8XWwNkxQw8fOPX5HEBMBwaVmFQ3
         wMwo8sxgE+vVxLZpx27IMKNLw+FafXwhe6WrK2bGrMp8DxpZMgPpB0UnnJ3T4QHqwZiT
         5L1EKeQ2PETkaJW5X0dirRgxvQj/u87s4C2KUISQQg4R8OggHjto2ktQlPbvVqwQDOAk
         uEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793818236; x=1794423036;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kC8AMGu++iS/uJq/laoFgHzwyS8Vpk87DdZJK90thkI=;
        b=szcbOwmzFZ0FMgkX02kdQuVsoAquSNyDm2mqnYoQIlNRYaeW6uU/MhqEFFpCMvnNSu
         n3NkqsN5vYrkFm5+R5IiLQxfSf6sQNCSA4Ma7e5RIMFifvpN2J4++wrWXWO1ZykAL5ew
         VCqlvqw+lJE7UnI89s0VGKwSN6Mm+dxAYfU8W7qfn92v9P6KrsGrgY4NQ7zkrnGxlF8A
         K2+A3w5kQgH40IgbjPASaWn64I/8LIa/yAwY0qFtg3Lb0Ya0rZprOM85JG8YMpqgj3Nw
         Xxf0l7Jw1Nv8ZXlERBb2lQOtI6xLxueIQyAxgjXJNhftJu+qtRU7jt1FMgKafeDYpSgS
         RGbA==
X-Gm-Message-State: APuU4Z/m6kdqNaagkxeq9G9QpOZD2JDP5XJ5Xyi4D0huqpzNfX6pyq90
	3adgl/J3ctEFI4rYiz5a9n7Dg/19nLhH+f7PcSBCuSY6Pkmc4QZwWQJXm3fOHvE84zs=
X-Gm-Gg: AYBFou0Q18VwbwHr2Xi/nkCM5S24uYA052Tlu228taJty1WsZToeLNh7GbXQ7i0dXx8
	luniaZRN42ubKFvr063SUHv4oXl99wy9PyUwzuquuYUsIfzkIdbbAzkl6pyP8n3qNxp8sA2d287
	G6A9WnxjLKxoh/A0JJEbYmBNomd4rFTtiIgY+ky4GAxvbbv/jZGE5HOJxpEP8fTM9n6Y+AwI7pL
	rvcBfSsoKSsGjBOztL6jNn7OicAux94e19Jx/XrY/E17sibuE5xS7L9u0RZSOf3rYAcKW9MFnte
	jKH0jm0iUe1+LXBppSMa8VNYfRxmFJLDbyozSNV6bK5fIQ23DSrJBB4yj5iehB+tNqVMsQHJ817
	23HquGKbpBjvc9TDXtErZuEhroLzSdznpJEgPclSTMiMaalksU5LVhfkSxWK6w5nIf6tgRUvBCe
	6E0sfnuow78/Dj1HCGiGS5SXg00RRLr+8LoPhB+mSGdGkMEJwSU8tY/n4vFig2zhVf89pXhHHKc
	kzgPfZxd7tETOJWXMoX8932E9tR+EgWprE6tOtIZzFjrQ52M/goMjsOhEfZK07WNkABypv3J4uX
	D5EAM4gCPivf7XahreN6movxoVOxbbw=
X-Received: by 2002:a05:6808:1807:b0:4af:aaca:7be3 with SMTP id 5614622812f47-567be4075acmr220325b6e.12.1793818236416;
        Wed, 04 Nov 2026 10:50:36 -0800 (PST)
Received: from localhost ([161.97.204.248])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-567a9fdc42dsm2349412b6e.14.2026.11.04.10.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:50:35 -0800 (PST)
From: Tyler Cipriani <tyler@tylercipriani.com>
To: tyler@tylercipriani.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	pa3ck.perosa@gmail.com,
	usmanakinyemi202@gmail.com
Subject: [PATCH v2] push: fix --force-with-lease forwarding in push_multiple()
Date: Wed,  4 Nov 2026 11:49:50 -0700
Message-ID: <20261104184950.403069-1-tyler@tylercipriani.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104002721.304153-1-tyler@tylercipriani.com>
References: <20261104002721.304153-1-tyler@tylercipriani.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

8ea8281665 (push: support pushing to a remote group, 2026-05-03) taught
push how to handle a remote group, but mishandled --force-with-lease.

Fix two bugs with remote group --force-with-lease:

- Non-fast-forward --force-with-lease is always rejected because that
  option is never forwarded to the remote group. The bare option sets
  cas.use_tracking_for_rest without adding a cas entry; only cas entries
  are forwarded.

- Using --force-with-lease=<ref>: (i.e., expect that <ref> is absent on
  the remote) could overwrite a remote branch if <ref>'s remote-tracking
  branch is up-to-date with the remote, which is the usual state
  following fetch.

Reported-by: Patrick Peroša <pa3ck.perosa@gmail.com>
Signed-off-by: Tyler Cipriani <tyler@tylercipriani.com>
---
Based on maint since it's a bug in 2.56.0

Changes since v1:
- Fix incorrect name in Reported-by trailer
- Fix confusing sentence with mixed verb tenses in log message

 builtin/push.c      |  7 ++++++-
 t/t5533-push-cas.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index 2377b5af55..7f0091206a 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -627,6 +627,9 @@ static int push_multiple(struct string_list *list,
 		strvec_pushf(&argv, "--push-option=%s",
 			     push_options->items[i].string);
 
+	if (cas.use_tracking_for_rest)
+		strvec_push(&argv, "--force-with-lease");
+
 	for (i = 0; i < cas.nr; i++) {
 		if (cas.entry[i].use_tracking) {
 			strvec_pushf(&argv, "--force-with-lease=%s",
@@ -636,7 +639,9 @@ static int push_multiple(struct string_list *list,
 				     cas.entry[i].refname,
 				     oid_to_hex(&cas.entry[i].expect));
 		} else {
-			strvec_push(&argv, "--force-with-lease");
+			/* <ref>: means expect ref not to exist */
+			strvec_pushf(&argv, "--force-with-lease=%s:",
+				     cas.entry[i].refname);
 		}
 	}
 
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index 2e14aecaa2..6a56aa46d3 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -168,6 +168,48 @@ test_expect_success 'push to update (allowed even though no-ff)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'push to update (allowed even though no-ff) multiple remotes' '
+	setup_srcdst_basic &&
+	git clone --bare src src2 &&
+	test_when_finished "rm -rf src2" &&
+	(
+		cd dst &&
+		git remote add src2 ../src2 &&
+		git fetch src2 &&
+		git config remotes.multi "origin src2" &&
+		git reset --hard HEAD^ &&
+		test_commit D &&
+		git push --force-with-lease multi main 2>err &&
+		test_grep "forced update" err
+	) &&
+	git ls-remote dst refs/heads/main >expect &&
+	git ls-remote src refs/heads/main >actual &&
+	git ls-remote src2 refs/heads/main >actual2 &&
+	test_cmp expect actual &&
+	test_cmp expect actual2
+'
+
+test_expect_success 'push to update (protected, expect absent) multiple remotes' '
+	setup_srcdst_basic &&
+	git clone --bare src src2 &&
+	git ls-remote src refs/heads/main >expect &&
+	test_when_finished "rm -rf src2" &&
+	(
+		cd dst &&
+		git remote add src2 ../src2 &&
+		git fetch src2 &&
+		git config remotes.multi "origin src2" &&
+		git reset --hard HEAD^ &&
+		test_commit D &&
+		test_must_fail git push --force-with-lease=main: multi main 2>err &&
+		test_grep "stale info" err
+	) &&
+	git ls-remote src refs/heads/main >actual &&
+	git ls-remote src2 refs/heads/main >actual2 &&
+	test_cmp expect actual &&
+	test_cmp expect actual2
+'
+
 test_expect_success 'push to delete (protected)' '
 	setup_srcdst_basic &&
 	git ls-remote src refs/heads/main >expect &&

Range-diff against v1:
1:  28266d5d24 ! 1:  f5553bf99a push: fix --force-with-lease forwarding in push_multiple()
    @@ Commit message
     
         Fix two bugs with remote group --force-with-lease:
     
    -    - Bare --force-with-lease always rejects non-fast-forward pushes since
    -      it was never forwarded. The bare option sets cas.use_tracking_for_rest
    -      without adding a cas entry; only cas entries were forwarded.
    +    - Non-fast-forward --force-with-lease is always rejected because that
    +      option is never forwarded to the remote group. The bare option sets
    +      cas.use_tracking_for_rest without adding a cas entry; only cas entries
    +      are forwarded.
     
         - Using --force-with-lease=<ref>: (i.e., expect that <ref> is absent on
           the remote) could overwrite a remote branch if <ref>'s remote-tracking
           branch is up-to-date with the remote, which is the usual state
           following fetch.
     
    -    Reported-by: Patrick Perośa <pa3ck.perosa@gmail.com>
    +    Reported-by: Patrick Peroša <pa3ck.perosa@gmail.com>
         Signed-off-by: Tyler Cipriani <tyler@tylercipriani.com>
     
      ## builtin/push.c ##
-- 
2.47.3

