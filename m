Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C1679DAF
	for <git@vger.kernel.org>; Sun,  3 Mar 2024 20:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709496248; cv=none; b=rNrTdJWZedwuy+61W94MXuLKkGczM4V5mxRcmk23co1ihD15oIB/5ABSt0N663MxA0fx2Wz3S/klvf7UzhWraLl9OCKU43WvuljNG4kgv3yoSaJf3P82Ih3UvCUlmywMqNL6zZxD/zKXwshhUrA2wsxdKF4cZSrj73cdWT1wMy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709496248; c=relaxed/simple;
	bh=AjLb+jTt4RTKYzVrYhHYEJGML6YAqCUMMaPSBIp6iew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWOCyszODDF43H3l9KONTspAWh8CtALafg3rEz6MBahJvDrIZv1nHOqLoD6tvV6Yp2/690jvDrlxEHyyeiyrPQQtMCDGsKHqlwJuVZ6J6sDI2ZU7eby6Kj4+AU8tpmUpQ9J7ySo4yFW7a9U0mKrAXX9eSpQeZqN4g6VdnNe+cPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=wHC1l6Pr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HShD7Pm6; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="wHC1l6Pr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HShD7Pm6"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5C86713800CF;
	Sun,  3 Mar 2024 15:04:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 03 Mar 2024 15:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1709496245; x=
	1709582645; bh=CJFdQNRlbLQ13mpOcuMBFELdYMJJbvethsFHZCGeyRY=; b=w
	HC1l6PrSY3gZnMy6rqxjEH+ZvoL70y6IkvdDn7xBrDgcTfp/1myTA8Fx8N/s2x5K
	b92L1Ib7sp3ZvGLRVZvToInFRhD4P479/Odn29VKRoA3vpTPKfcNf/aWymqRpt+M
	mh8F3/WRaKH5FNoZBchL1vga3Rp6WE3Buoh0crn3oDrVVM9PPiKlDebdf1dmTQ+l
	kONj0mJHBgpQFXC5zR1yXguHbtS7UoE6cXqTyR1oigVkE8k6L/ufN81ieiuz3qj+
	PzWs0ov5jdJuJUsSk9oug2jnukou/s5lxpIpTSuCDKr3lrNWfSSDciudDz+O/3w5
	ErQtcTupuj/gHRnTIBvYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709496245; x=
	1709582645; bh=CJFdQNRlbLQ13mpOcuMBFELdYMJJbvethsFHZCGeyRY=; b=H
	ShD7Pm6P2ebaK0lqMBC4bU07JWZPtkiswjbLFxEJKADpH72o0TNysW62Ie9CRdLi
	IqLGedp0a0aK7AhLKOj1SW14amQeJ8L5VMJ02O0oc+QIeL5RHYGqqfK9nxjkWxa9
	f2OBC2D0Ot382VleaUNe867hFgLlgvfGKvkly/xv/fbNU+Rmum6UgNOXgsmhn4h2
	8N78GPP8VTi/0kVY/q5dT5pDVmXrZGOQoryzO9ma8We9XAlG7Co2PB6to2ID/Zig
	LM4ENbrS6pgDjFYz7JyIDK2CPGXuk7e82baz/4RI4V00v96GnbwckEUAY9wChWoT
	zZfyFfCywhXLFuGt8luxw==
X-ME-Sender: <xms:tdfkZSrghZkzjOgLzR0Lcil9i0A_200PTt9IaqVvC2KYvGUcG7x-07E>
    <xme:tdfkZQpKFADkGOxbCeKECM5vAerX2oEdIl41WTE--6fA_hr-fZP9SV39gqv3b1msG
    -xZQKT7qL2OZ978GA>
X-ME-Received: <xmr:tdfkZXPawCcXwfy3q_mQBMJ6rna1Oviy_Gp8jPwYGFa5yigrQqI9RdDS5NCeWHMkAT3RG1iDLkZydrF3gfF7ombydUbe9fLVbhBzcvOrBxyt_qZz0-O06TBpng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheehgddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcuoegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhephedvle
    ffhfefheeludegtefhhfegleevudeiveffkeeiveegfeekgfevieevhedvnecuffhomhgr
    ihhnpegvgigvtgdrnhhrnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:tdfkZR7BR5IFFGYII4txJKAQt_IYK-1pJHp_BVXabJTAExN9UiGaEg>
    <xmx:tdfkZR7y-Qf5kEorvBbn29sOVwlOsmjtpJpTJovyZwJdQgp7qcQusQ>
    <xmx:tdfkZRinga2d5y392g0gjDLbjFC5EKTkZ--e1JNBYBOz8NUMK8h_Aw>
    <xmx:tdfkZRHluaGn7eRLH4doOiKau2YZHUDtScoFaggPJ5zDgXX7FybQlw>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Mar 2024 15:04:04 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 1/1] rebase: teach `--exec` about `GIT_REBASE_BRANCH`
Date: Sun,  3 Mar 2024 21:03:37 +0100
Message-ID: <4140fca4f454310d215df8bdac237caeb5c38521.1709495964.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.44.0.64.g52b67adbeb2
In-Reply-To: <cover.1709495964.git.code@khaugsbakk.name>
References: <cover.1709495964.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Commit-Hash: 4140fca4f454310d215df8bdac237caeb5c38521
Content-Transfer-Encoding: 8bit

The command fed to `--exec` might need some contextual information from
the branch name. But there is no convenient access to the branch name
that we were on before starting the rebase; rebase operates in detached
HEAD mode so we cannot ask for it directly. This means that we need to
parse something like this from the first line of `git branch --list`:

    (no branch, rebasing <branch>)

This is a moderate amount of effort for something that git-rebase(1) can
store for us.

To that end, teach `--exec` about an env. variable which stores the
branch name for the rebase-in-progress, if applicable.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-rebase.txt |  4 ++++
 builtin/rebase.c             | 15 ++++++++++++++-
 t/t3409-rebase-environ.sh    | 19 +++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 06206521fc3..9b3d6ee8203 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -578,6 +578,10 @@ squash/fixup series.
 This uses the `--interactive` machinery internally, but it can be run
 without an explicit `--interactive`.
 +
+The command has access to the environment variable `GIT_REBASE_BRANCH`
+which stores the branch name that `HEAD` was pointing at when the rebase
+started, if applicable.
++
 See also INCOMPATIBLE OPTIONS below.
 
 --root::
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5b086f651a6..0202130c2d7 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1044,6 +1044,17 @@ static int check_exec_cmd(const char *cmd)
 	return 0;
 }
 
+static void try_set_env_git_rebase_branch(void)
+{
+	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
+	const char *shortname = NULL;
+
+	if (refname)
+		skip_prefix(refname, "refs/heads/", &shortname);
+	if (shortname)
+		xsetenv("GIT_REBASE_BRANCH", shortname, true);
+}
+
 int cmd_rebase(int argc, const char **argv, const char *prefix)
 {
 	struct rebase_options options = REBASE_OPTIONS_INIT;
@@ -1451,8 +1462,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (gpg_sign)
 		options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);
 
-	if (options.exec.nr)
+	if (options.exec.nr) {
 		imply_merge(&options, "--exec");
+		try_set_env_git_rebase_branch();
+	}
 
 	if (options.type == REBASE_APPLY) {
 		if (ignore_whitespace)
diff --git a/t/t3409-rebase-environ.sh b/t/t3409-rebase-environ.sh
index acaf5558dbe..5b1d78a255a 100755
--- a/t/t3409-rebase-environ.sh
+++ b/t/t3409-rebase-environ.sh
@@ -21,4 +21,23 @@ test_expect_success 'rebase --exec does not muck with GIT_WORK_TREE' '
 	test_must_be_empty environ
 '
 
+test_expect_success 'rebase --exec cmd can access GIT_REBASE_BRANCH' '
+	write_script cmd <<-\EOF &&
+printf "%s\n" $GIT_REBASE_BRANCH >actual
+EOF
+	git branch --show-current >expect &&
+	git rebase --exec ./cmd HEAD~1 &&
+	test_cmp expect actual
+'
+
+test_expect_success 'rebase --exec cmd has no GIT_REBASE_BRANCH when on detached HEAD' '
+	test_when_finished git checkout - &&
+	git checkout --detach &&
+	write_script cmd <<-\EOF &&
+printf "%s" $GIT_REBASE_BRANCH >environ
+EOF
+	git rebase --exec ./cmd HEAD~1 &&
+	test_must_be_empty environ
+'
+
 test_done
-- 
2.44.0.64.g52b67adbeb2

