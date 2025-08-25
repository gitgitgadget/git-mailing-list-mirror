Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A999134CB
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 18:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756147795; cv=none; b=e2uyTOszBzNMh9T6bPTKKqjwsab8NcF/T8WXgE7SDItIHKdz5DhUmmz4pCPS7mcYlCEPekVDQo0W1QFlFe38YZtxoUkYzplrmwTEa0dNiikGe3eNDn9wvkTIvAzuk0TeuQPSPMbs5C9Xo8qL29y9mqoPXzCEoJfJBY0oyJGJ0uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756147795; c=relaxed/simple;
	bh=89F/CuNo1X7LobTXrGBRlto/QUQotSPouLjKH7RCVHI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Ihu/kbYI2yRxVNjVvIr3/NgXFZA4jMyRzj5yubEPra4CJPew8bLDc8igPcaUzayuOFz+aiLGKW6Mpwhwagn+/GWl62SLLqOFC+9y8Y5Vg4UqS9XMWvmiF9WX375WghaEfq+jUPppWTnkcOxjVU/2fO6tBcpvuGAg5YDJM4YJdLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CD/z9zLr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CD/z9zLr"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1b004a31so36733185e9.0
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 11:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756147791; x=1756752591; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kvpNAOk1VeZrlCeuXgVlYWRwGpASVs0oxmg9QKqWwpc=;
        b=CD/z9zLrnYIyLx5tF8ULUAKAUn8t524x5F3uJmAZNOjV+kvSlXD+5oBrsflogNlFup
         +YNyD7ClXzYyUjeqD9xtcuN7EHCuWpJVEWqQbBUj1NilmQRYYrNikYaF5IYMuAJk1snw
         DIy9jNfpvFqFazon0ic3cmdXwaOHeHC4TpdVyXI02qStzw1IjtoH37TvwAh5xrkPWFAi
         HlR4JSe537sS4g029eFs+R0Xtw0ry4VblJLFksk/+pdLg1dfJqIMy3A6Jiz1mGHBd4Ay
         skRwNoJsTx+Hk14BDP+Yxp0PX2Xn6MBj1qvd1wHXEIeLiaoCdLpjjXc0clB4URIHAK9S
         reeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756147791; x=1756752591;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kvpNAOk1VeZrlCeuXgVlYWRwGpASVs0oxmg9QKqWwpc=;
        b=hfQ6si45/0MPkk8HUDlpKceNliIju/L+4Ubqd+0NfGPeqZj55wl4kYrLQJoURqo73R
         Ze+nVPyvyeuoXlwI9tXBy7PvsAIGL7iO8xI5i4J0uacLvzOtgisNqcbW/TrohCSC4OX0
         hStiG/GrJoUcXcagHn0APY2wJn0oll8fvGim6jssrq0saNrfDwiE3LKxrCs75QUsgz3r
         4eoDTifldppLYizmn9qmdUKZicSA24m5b67bRrfeI12jIEN0XYkToYCIcFqUJAVmEagm
         VgeaoOnXeBD2e3ukujrqyy6WeiB+l8L6WbCcGTrtoj/uuy+V7ByQVkSqDjPCrosLtxcp
         chOg==
X-Gm-Message-State: AOJu0YzB5aGvucE93Fc1Gn0yGF4n9o7UUHPNeDYWPL1DSM+ql8E8veF3
	ol2mfMUbYnyeAxvldu/fMBKHGYx2cUL/wjL4SIhEwTZHUS04TgjHGz0I3ucm5Q==
X-Gm-Gg: ASbGncuQ7laFC+mcVaaL3JHUIpJi03kYiBpA/EA4gt5/XPbTMISao9e5XQWFb044dIO
	NDarFytvXvggWtrRCLY+16Shl/CX6VF0D8TiYeB2fwoJSZzOsw5JGU3QMv+BM+Sicas8axlRHAN
	iCOd+zEBYqmvsgOrNjX245Fyk6mym4axZ7qhvH3rSqDpLjfwLurMfbOTv3ffgG4IsBRzycCuQd8
	0Qn/tGuW4FwE5/0mGxkyf0vSSHpfM8B+LaILxPMM1f7lW+zODrCcUFD0+cnc0bilRL+tDaSQqfW
	6FoG9oCAXfFe815kL81EMrimyDhi4w+qneV9tYUMDpN6eWMEn/jHb9CON+XeiqprYuwtn6n/yTt
	f9z03l6rii9NESeA/zcnqb6TdKM0=
X-Google-Smtp-Source: AGHT+IEPX7UnHyQuq+THQwAgiSzjxvmw/n2X1JTWkpx3ThcLM41495syou/jhC8yOyPbkj8JJJzrKA==
X-Received: by 2002:a05:600c:3b9e:b0:459:dc35:dc05 with SMTP id 5b1f17b1804b1-45b517a05e5mr115346635e9.9.1756147791056;
        Mon, 25 Aug 2025 11:49:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70ef55bddsm12359334f8f.22.2025.08.25.11.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 11:49:50 -0700 (PDT)
Message-Id: <pull.2037.git.git.1756147789443.gitgitgadget@gmail.com>
From: "Julien Jerphanion via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 Aug 2025 18:49:48 +0000
Subject: [PATCH] Add `-u` short option for `git pull`
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
Cc: Julien Jerphanion <git@jjerphan.xyz>,
    Julien Jerphanion <git@jjerphan.xyz>

From: Julien Jerphanion <git@jjerphan.xyz>

Add the short form `-u` as an alias for `--set-upstream`
in `git pull`, similarly to `git push` which supports both forms.

This allows users to use `git pull -u <remote> <branch>` as a
shorter alternative to `git pull --set-upstream <remote> <branch>`.

One test is included to verify that the short form works
correctly and set the upstream configuration as expected.

Signed-off-by: Julien Jerphanion <git@jjerphan.xyz>
---
    Add -u short option for git pull

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2037%2Fjjerphan%2Fpull%2Fset-upstream-short-option-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2037/jjerphan/pull/set-upstream-short-option-v1
Pull-Request: https://github.com/git/git/pull/2037

 builtin/pull.c          | 2 +-
 t/t5553-set-upstream.sh | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 5ebd5296207..e09f2963f78 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -254,7 +254,7 @@ static struct option pull_options[] = {
 		0),
 	OPT_BOOL(0, "show-forced-updates", &opt_show_forced_updates,
 		 N_("check for forced-updates on all updated branches")),
-	OPT_PASSTHRU(0, "set-upstream", &set_upstream, NULL,
+	OPT_PASSTHRU('u', "set-upstream", &set_upstream, NULL,
 		N_("set upstream for git pull/fetch"),
 		PARSE_OPT_NOARG),
 
diff --git a/t/t5553-set-upstream.sh b/t/t5553-set-upstream.sh
index 70e3376d31b..b4dd7c62ce9 100755
--- a/t/t5553-set-upstream.sh
+++ b/t/t5553-set-upstream.sh
@@ -124,6 +124,13 @@ test_expect_success 'pull --set-upstream upstream main sets branch main but not
 	check_config_missing other
 '
 
+test_expect_success 'pull -u upstream main sets branch main but not other' '
+	clear_config main other &&
+	git pull --no-rebase -u upstream main &&
+	check_config main upstream refs/heads/main &&
+	check_config_missing other
+'
+
 test_expect_success 'pull --set-upstream main:other2 does not set the branch other2' '
 	clear_config other2 &&
 	git pull --no-rebase --set-upstream upstream main:other2 &&

base-commit: 1fa68948c3d76328236cac73d2adf33c905bd8e3
-- 
gitgitgadget
