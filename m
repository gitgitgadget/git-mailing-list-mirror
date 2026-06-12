Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556A238BF9A
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 11:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781262623; cv=none; b=p8gAK12d/w/xzR9CRoDafpLHf2OYTsYxJywicz40Oy59+1Rzw8f8nwtA5G6xtLxqgCRHYqrXeCPgTe2aPEjaYpTgemiuitMGXNnsgydVrZY862c2Qr258S+mOaMnL/S0dEBf1vhUCPCHTqhqKKSLYvleyZjkXn3el21CGrRbgeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781262623; c=relaxed/simple;
	bh=K3RV8pdVWyMsJ2CNPfhEte/o2m8WygoqVHnDXfWW7Sk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=N21p7k+IgsPrTWp1S2VLcFIcwGGEU/9xsOXyy8azjJAEOH6SENF67xuUppLwzYL6Wi7mPagu6hPPbI55OYk387En55vZN/P/9Bz7Xq66Uv+j+ztELmvIuXJEh/0X5pXJG9D/0FC+IPSJ3Cf0w+HO+B0xZkciyznhkwQu2AtiTj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZAASG8/; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZAASG8/"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-91578122305so137202185a.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 04:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781262621; x=1781867421; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2yOX/0qiGBk0Cq7lzfMw5LnJOIZEaD5mEmm1Kz/U5s=;
        b=GZAASG8/rlBW0t0VGBSRNopGnz0A/1HUmMOULRgCsPX6q7pe+clw33QCKa3NJXwIK+
         bhxX6A85qFBvQ7ofQTmp4go6JpqE3m7PgWEwvCfwvVHJsDFGyYwz23zA4TBYctdahwsU
         2mOIL2hATy5y+Vtx4mKLABKoUR11Q6wWqU5qYj4DWMYxrlwgdyUElz3e0ooMf/c45VzJ
         XwHj+wIII2K6Six5HHqcOmiaOjo2pDC7ngiZPLOQw+5jC3oCkCPwQ4c79dp4Wf2gtmjl
         9I9QDYjahUVratj9nt3KcDU2iRb9w79YWPPZro/mc+pgjqCCEoKqBXmWYeSgjvATy44V
         hXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781262621; x=1781867421;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i2yOX/0qiGBk0Cq7lzfMw5LnJOIZEaD5mEmm1Kz/U5s=;
        b=gS5LfLrZH4BZIaoLUMnQsdaguwZ7QP3P2MUVmHXgHXEA6NpUTQxFsR7dpG07mGiFpn
         2RqYOGURKLJp1gbKefhFw3wlOAC9EEEYIO0VETauXkHTYvDf9ZJKKJKWNENz3s6T52yB
         56urG7ZuZmTMqYZXESR3fOBWA5WT1EKvfZkaYLHQcw826+bfbxuy5hG2MVPSqK1Mmq1e
         FMzK6ijQIgOijZbCaOKwJb3sszGNiZrsazAquEnoX+HVPoWuer54j6fFQJi2SZHtCRQg
         0dcEogRzuwi4cMj3ISh218byQ000y7emYGohDGtX8HSOQfQM175nIiWwc1CL0B+MlmuC
         PkZQ==
X-Gm-Message-State: AOJu0YzWPO2JtAExQBV8dCMn1RkTeQGKeFiQLEF7rKVaDm0W/f2iVi+w
	snqG00SQLsUgH8DlfWTnp8+QWjTOEwMm9wvXfRkwsw2RoA4gglp9Aq29xjDZ3HB1
X-Gm-Gg: Acq92OGZqzVcR+E4X1tjvXArkquNLZNfDROdbXPp+71wAa3Y0gFRLU8UCrp+73kEpWj
	WtcsFO4poNrLUugrZJ9uFdan1iE9S74jkAT6r2XcjJOSM93qGPglG6X4TjHk7Pw2lSvKfruQr8k
	rrl3aHwxRXlotNpgSJJGPWLsXJ8sS/s5puld1WBMYb8oFWZPlzvS7c5fzmMYtIBM3wm6YtaBAHe
	ZJnR+KnTaQ8I8N03RUljVtPRNh1GhbgxRQDqiGN29z0x2rVtWTOSO/3Z2CCNq6fz06IYapiR3KG
	nFga8lLztUPdera5UK5SwuqduuR6EF1G+AVSw2geVU/hSlhVyWkuYnDq0JGp2oleYEa1c1uAguS
	EbA8nZR8Qe3nPdlD3WXLpbQQ+Dsa7SkP9nkWq9wQ4AHi8cvNequtWo2sL+o2RYTiqBbHXmxIchl
	s8dLpxdlG4mc5+lAcM6gIXa7rzTDjxWu88ZMka
X-Received: by 2002:a05:620a:710d:b0:915:b9f6:71a1 with SMTP id af79cd13be357-9161bd66007mr294091185a.45.1781262621183;
        Fri, 12 Jun 2026 04:10:21 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.45.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a006ef0sm172617585a.24.2026.06.12.04.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 04:10:20 -0700 (PDT)
Message-Id: <21684539debaf433b6b63404e1a7622a5cc33283.1781262619.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2331.git.git.1781262619.gitgitgadget@gmail.com>
References: <pull.2331.git.git.1781262619.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 12 Jun 2026 11:10:18 +0000
Subject: [PATCH 1/2] branch: suggest <remote>/<branch> on upstream slip
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

"git branch --set-upstream-to origin main" reads the trailing word as
the local branch to operate on and dies with "branch 'main' does not
exist", pointing at the wrong problem.

When that branch is missing and "<remote>/<branch>" names a real
remote-tracking ref, suggest the intended
"git branch --set-upstream-to=<remote>/<branch>" form.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c  | 17 +++++++++++++++++
 t/t3200-branch.sh | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index 1572a4f9ef..7ad3efb908 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -957,6 +957,23 @@ int cmd_branch(int argc,
 		if (!refs_ref_exists(get_main_ref_store(the_repository), branch->refname)) {
 			if (!argc || branch_checked_out(branch->refname))
 				die(_("no commit on branch '%s' yet"), branch->name);
+			if (argc == 1 && !strchr(new_upstream, '/') &&
+			    remote_is_configured(remote_get(new_upstream), 0)) {
+				struct strbuf remote_ref = STRBUF_INIT;
+
+				strbuf_addf(&remote_ref, "refs/remotes/%s/%s",
+					    new_upstream, argv[0]);
+				if (refs_ref_exists(get_main_ref_store(the_repository),
+						    remote_ref.buf)) {
+					int code = die_message(_("--set-upstream-to takes a single <remote>/<branch> argument"));
+					advise_if_enabled(ADVICE_SET_UPSTREAM_FAILURE,
+							  _("Did you mean to use: git branch --set-upstream-to=%s/%s?"),
+							  new_upstream, argv[0]);
+					strbuf_release(&remote_ref);
+					exit(code);
+				}
+				strbuf_release(&remote_ref);
+			}
 			die(_("branch '%s' does not exist"), branch->name);
 		}
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index e7829c2c4b..e2682a83a0 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1022,6 +1022,44 @@ test_expect_success '--set-upstream-to fails on a missing dst branch' '
 	test_cmp expect err
 '
 
+test_expect_success '--set-upstream-to suggests <remote>/<branch> on slip' '
+	test_when_finished "git remote remove slip-remote" &&
+	git remote add slip-remote . &&
+	git update-ref refs/remotes/slip-remote/slip-feature HEAD &&
+	test_must_fail git branch --set-upstream-to slip-remote slip-feature 2>err &&
+	test_grep "takes a single <remote>/<branch> argument" err &&
+	test_grep "hint: Did you mean to use: git branch --set-upstream-to=slip-remote/slip-feature?" err &&
+	test_must_fail git -c advice.setUpstreamFailure=false \
+		branch --set-upstream-to slip-remote slip-feature 2>err &&
+	test_grep ! "Did you mean" err
+'
+
+test_expect_success '--set-upstream-to does not suggest when no matching remote ref' '
+	test_when_finished "git remote remove slip-remote" &&
+	git remote add slip-remote . &&
+	test_must_fail git branch --set-upstream-to slip-remote no-such-branch 2>err &&
+	test_grep "branch ${SQ}no-such-branch${SQ} does not exist" err &&
+	test_grep ! "Did you mean" err
+'
+
+test_expect_success '--set-upstream-to to a local branch is not mistaken for a slip' '
+	git branch slip-local-upstream &&
+	git branch slip-local-target &&
+	git branch --set-upstream-to=slip-local-upstream slip-local-target 2>err &&
+	test_grep ! "Did you mean" err &&
+	echo refs/heads/slip-local-upstream >expect &&
+	git config branch.slip-local-target.merge >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--set-upstream-to slip suggestion keeps a slashed branch name' '
+	test_when_finished "git remote remove slip-remote" &&
+	git remote add slip-remote . &&
+	git update-ref refs/remotes/slip-remote/slip/feature HEAD &&
+	test_must_fail git branch --set-upstream-to slip-remote slip/feature 2>err &&
+	test_grep "hint: Did you mean to use: git branch --set-upstream-to=slip-remote/slip/feature?" err
+'
+
 test_expect_success '--set-upstream-to fails on a missing src branch' '
 	test_must_fail git branch --set-upstream-to does-not-exist main 2>err &&
 	test_grep "the requested upstream branch '"'"'does-not-exist'"'"' does not exist" err
-- 
gitgitgadget

