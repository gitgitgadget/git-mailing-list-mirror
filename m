Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793433849;
	b=mCSBrjnru8F+4kr/JmAcaHPmwjN/Wc82rVn+Pg/m5dTPCm/Gw/Iz3ShC2x2g062YDfXh
	 ZmLQl7b+txhNgH8UMgt+TaunVL7zKCM8ktMPiQONECelkWqSSyaAn97efzL0vP+NqYm8j
	 qKi8flG3Pv/XosZvmzr80PiJ2uiYwyHnTkV3J/Jzvk4s5v+YWtGroYzfDG9BNh5yQ7OVV
	 JRqm21T8CPlY9bQbp7R/WasQs//SP2cfBFIx8cBWk9hjF/ZB+KetinMHwehjWXfapBzqL
	 HaijBDIOKPmaegS5TWcUt455IKdvZzEJmg4TRz1zsDrQxg5lrW8UDJHLvx7RAPd+HwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793433849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=W3Lf7J7cS0JWq4lihEaDpQQyKgxvs533xxklAJLyVm4=;
	b=zvTW30zVt7HzHE5C24atTlyz9nJdCP5PLuQxsTB6zhK7yc8YHb30Pr81svjFFScqv01F
	 Wv3xv1uiSx0b5QONKvgZk3BTlrt9/pwZwV4dWz+It4t3zcd+TGY+DSimn/AstZ2CNsMzo
	 n7/8V9zQBMYIiIR+WNyanhML//JLf5p8eJhmo4SxANSwg1KJCFmwgb54aHZyMpFgGoDnw
	 Urt3m6YotVdVP6oUCutcKw8OAtSuHaAbaKrtKAAhgKFwUAZ7Rbq8MJiIYXZmuqUH1XaFq
	 cAmukBYtrnG60e/OefncHJpvHkMJ3eLp+hlgE4nhg67IH24D4wpqByQ8h1LqreinyiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ez0QUXAY;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F9E606A31F
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 08:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98F9E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ez0QUXAY
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91c847584b8so20400946d6.0
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 01:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793433847; x=1794038647; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W3Lf7J7cS0JWq4lihEaDpQQyKgxvs533xxklAJLyVm4=;
        b=ez0QUXAYGDNVHFq5w+tEgO0iupmxQkLkmJU9pKhP4IaOYTW8227wdzpjyHMqx5QeL0
         WDZeuyfPXH6U6z+20r6Pi2c5SgQmjjFqvHwEMlxTAReLxly8GwBNcYEIkCP/lEUHEfYc
         o988fwyni28wC90h9asdU75vpSBvyyK8CAindWDmSjQgSe54i2TIY0PM/W7crMhYMdCX
         J1JSUBdT42JRA9eX3lePxJ/2AHOYumRhvEBbNN4saf+eSfx6T+tzpw89wrZqQ6iUmw8J
         tk0Olm7FpEqyWcErraInGyCYZsJrNd0YDGx+gVaN3HRRwstw9ZQH/Q88WtRJDJdgocfv
         cvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793433847; x=1794038647;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W3Lf7J7cS0JWq4lihEaDpQQyKgxvs533xxklAJLyVm4=;
        b=YIaZW7evxiUtUQ0TN7RON/LLvGiwa0RDeD+XFfVgZ/SmEq9QghlJB6WXK5tWinmuQD
         mg6n4YM9gHWQGU4CNW94hRBAP1ib+pfJWe5iyHHUPPlorjPWK0WfrIpN5atfyb5SACIo
         nhP7inVtdArRh+3SiifASdgmA70/A7mSpodM4UKvJQQfFTlh7SriA0aTU07/GsZl6tg+
         /VIECyMoilTsqgIkqQkQgfwW+8O/AHsphPYP2e1r741xWu4upEMKlXpFitW2m5XuY+BS
         k7KQpK67d7Zia/B0x8DALQwOUjd3ZNWGVJ8i2gWD4FpETFNEonHgz3H7NvJ5Yn8d35xM
         6rjg==
X-Gm-Message-State: AFq9FYIX4s0pXEeZzspjfYv7PcCeyZn4STBiq89IuoiIA4iWyEY1//Or
	JUXh0FUVmd7xVaeHXTWReWxYq8DzEqB1kVoD6HcsjwQiJ6kumBdOTJAEBBnnv3LFsGs=
X-Gm-Gg: AYBFou00HdIgXHbHbcmFfYWTuSytUfEVvW945N2KM6m9SRzfiDs3xO91kuEYex0NR06
	HPcrJL+cKpgxpqqlL2a9SNt56EUoZvQL9dE4SPKBaZ6cZyKhkV/Wufg3bK0TGll1dRH0oxGpMMw
	va4S5JMoBnOHwW3ro7+K1LMEsw9KwDimupd+3rHaQRJoPOp9cbmoUR2b1rLOi5BSyvY3BRkMrW1
	jsl6hb18/E7AdYDdkejrNstnZhKS4Rk3x6eH0/98qbNOY3csqn8EMG65UdUC2dcKHVHwixB1z5g
	MziRZodK8UsDXdqMgS2wZ9Vx/hpiH2aQPKUi0xj+8YOPNbtCjalFGnj0wi1ncQQGtg1f9U5YyMw
	rDlF7lu2C49WNUDXN2GM9lWI+jgNBfOAN713o1d51M01rpt4pIi9CA+YjdUIVmWOcfixCk34SyO
	q2ftcnaLpyRjqF/R5FqTBhTo5QicN5q9WkBlzeoyDfXsyVWfNbKTna+UkLfUxCX+BT96DcDJXyi
	NoVgCFqKga0bw7aizJfdv6q+99j4zBW14oIUeLKcB+yU+tlEHh3QmqfBoACOMtYRxJvIv8iGOnv
	FAowoMx5TlxYbJYFPJC+Qkc5dK2mVjz++Q==
X-Received: by 2002:a05:6214:c46:b0:917:c04c:77b5 with SMTP id 6a1803df08f44-91c90409713mr134676136d6.3.1793433847523;
        Sat, 31 Oct 2026 01:04:07 -0700 (PDT)
Received: from [127.0.0.1] ([20.127.239.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91cb4478981sm6792236d6.35.2026.10.31.01.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 01:04:06 -0700 (PDT)
Message-Id: <c58afcc4b166d33489feee41d57e65738581a0da.1793433841.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2466.v2.git.git.1793433841.gitgitgadget@gmail.com>
References: <pull.2466.git.git.1793105039624.gitgitgadget@gmail.com>
	<pull.2466.v2.git.git.1793433841.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 31 Oct 2026 08:04:01 +0000
Subject: [PATCH v2 2/2] remote: resolve "simple" @{push} when pushing to
 another remote
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
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
 remote.c                  | 13 ++++++++-----
 t/for-each-ref-tests.sh   |  4 +++-
 t/t1514-rev-parse-push.sh | 13 ++++++++++++-
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/remote.c b/remote.c
index d15d34aad7..98665a3085 100644
--- a/remote.c
+++ b/remote.c
@@ -1972,16 +1972,19 @@ static char *branch_get_push_simple(struct repository *repo,
 				    struct branch *branch,
 				    struct strbuf *err)
 {
-	const char *up;
+	const char *up = NULL;
 	char *cur;
 
-	up = branch_get_upstream(branch, err);
-	if (!up)
-		return NULL;
+	if (!strcmp(remote->name,
+		    remotes_remote_for_branch(repo->remote_state, branch, NULL))) {
+		up = branch_get_upstream(branch, err);
+		if (!up)
+			return NULL;
+	}
 	cur = tracking_for_push_dest(repo, remote, branch->refname, err);
 	if (!cur)
 		return NULL;
-	if (strcmp(cur, up)) {
+	if (up && strcmp(cur, up)) {
 		free(cur);
 		return error_buf(err,
 				 _("cannot resolve 'simple' push to a single destination"));
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
index 5a4f16867a..dc2df7eb80 100755
--- a/t/t1514-rev-parse-push.sh
+++ b/t/t1514-rev-parse-push.sh
@@ -39,7 +39,7 @@ test_expect_success '@{push} with default=simple' '
 	resolve main@{pUSh} refs/remotes/origin/main
 '
 
-test_expect_success 'triangular @{push} fails with default=simple' '
+test_expect_success '@{push} with default=simple fails when upstream has a different name' '
 	test_config push.default simple &&
 	test_must_fail git rev-parse topic@{push}
 '
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
-- 
gitgitgadget
