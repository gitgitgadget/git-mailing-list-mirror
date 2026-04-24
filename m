Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0192A280318
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777042885; cv=none; b=UaQk2Hx5CpHHbDmxCQunCy5rxJK5oeOIyvm+4R34KTNLFe5/oMhFe7vU0810OypqO7o6avdpUkCB45W+DVPOmTZwmaSPZhcYeuhIcJYTHNd9GaM5sCIMB59I0W0Kq499j6duLvnIldft6Iy86AaL3Q5mPKHTQn2Bd5Ynwx1hns4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777042885; c=relaxed/simple;
	bh=yX82TyB7MQCLvtauiAHheQkTi7xfhOxhE69AGWdjxiw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=n0wfPLO19gSLSmsRVmaxZxLQVFpBGR7dUR1Ec5JBLczbqa4w0Ir8b3QMXaTaq6oF2b9qUmC88mnr2EGxK1WkY6YrU4QcR4x/8JxoTMfQgmot3oHfGmoiJbB9oHrIzFvtsYLsYEaIAeeVTZm3wr+llf8U6WbF/a6fKl/OCRJoc+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPdFbZFz; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPdFbZFz"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-95697b46831so4439230241.0
        for <git@vger.kernel.org>; Fri, 24 Apr 2026 08:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777042882; x=1777647682; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJisFIYmu999F7p9DhPuR13C32V5G82pAGkfuc9Jdyc=;
        b=OPdFbZFzmvs23NT6mfhjp7bKeSc0W3re2NJd0y14Gyuqwa3hh880ltmE+f551lKWjC
         O3fxCesXRz67238wa+D0czjsyLTz3Hl9gSt4QlOxNhEWRcIEr+1Hh2v707DRLnzpq0au
         pOdmwllEbqBXr1975vwOezJU+xTxC6Lx3lrPMogU9Bpj3YzxitgbEAV1Ds1AF2WwALR2
         BFXq5TV/kIVJzz3wGZcjsREhFOorz4VA8UCuUCPHaw4ObPCNU0JcmVU83/o9SzL81yE6
         7mJZ1cNCYGOx9pKfNlsqyLG+QkNIKZtF1HzvNSg6vUt5vvXyd1lhddZ42YUf7ctS8uve
         r8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777042882; x=1777647682;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yJisFIYmu999F7p9DhPuR13C32V5G82pAGkfuc9Jdyc=;
        b=UrkfZd1ePPNIoRUmclp01OtIu5zvIivWIt2lZIxQwwB5/JemACx4Gu3UnOutZhKgxy
         9oYA+bNj4J03msnycLpwbbPAihhiSXNyji95z27c8Y7JSt+YVpn4qaSxkPD6jHhNXU6c
         +gunTEOplVicxliKn90bxKcDpbO8njC5kJYBj29B23TsJ3ESbbTDBb/pI5l3EQzHEHeS
         AwOTGi1t8h8QUa4aRoTKR9g1RYtvrx8+bZVtEBXUiG2hSGbUM7ABhUQ4Qga3Oz+Vyslr
         fsXmD+RIv3L6GP+nPfH0zYRhPlGJWCkPupZ9q2jxgl6YLDNb8ViTXd91ZddAdZ1yMkpK
         E1xA==
X-Gm-Message-State: AOJu0YyI7/y0tje49E7ad6qWheiKxIDIwZoMJiAndH9VWA0XTccNWaZf
	1+YJS6IQ4p0axu3SW3xUYdVSkT/H6JgL579sItpMCXUAjdpyXg8jqFMByZQOfQ==
X-Gm-Gg: AeBDieu3jEduImysxY7mR3wF9BQn4S85+erMnkWlk3r6iY7iTiFnrPp53+j9VQhrWkR
	Hbp1BzCemVghqDtw1vgBKPLkeL3ulf2KcwU8JBwOTi57pW71pOkXPJNye/ggUZZLVXnkIqa/iHw
	f3I/CvtCbEjHwsjl5ocoxmGbkKDBsNGzxIUvEJKGgBf1FqQV/ued0/lZjF3Ycbvs/DqPGwqwkS4
	XDHyGiAUjYtE821SucS2un7Y3VJJrSLt5544mcTUvkBYOzaEIyj72Dg99+uDYvwuWUMlOEM3Ar+
	kchr5/eR2gbZNhHXwwDdQ1ILpwg5bQFXs8mNqu8QTjUKsrYXLcgyqIKvuwCqvHZRzGkT2C6q8hP
	av+zPOKY8fwRsyP4uvdCepE8eZJx65G6coPydIwlHVKjm1rj/T5zgCe1TCtD9ps4xqfEvPAh2St
	eg9ncVfNXc5DN3iQGBVO+Zk29t8wdewJTqCQZ4kA==
X-Received: by 2002:a05:6102:419f:b0:604:f029:224c with SMTP id ada2fe7eead31-616f4d6abf2mr17257102137.8.1777042881332;
        Fri, 24 Apr 2026 08:01:21 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.251.133])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac429e9sm185752676d6.3.2026.04.24.08.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 08:01:20 -0700 (PDT)
Message-Id: <d9a2e76f3c2a96523f1655ef2f73f9b03ce88af3.1777042877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2098.git.1777042877.gitgitgadget@gmail.com>
References: <pull.2098.git.1777042877.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Apr 2026 15:01:11 +0000
Subject: [PATCH 2/8] t7900: do not let `$HOME/.gitconfig` interfere with XDG
 tests
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The XDG config tests for `git maintenance register/unregister`
create a fresh `$XDG_CONFIG_HOME/git/config` and expect git to use
that location. However, if `$HOME/.gitconfig` exists (which may
happen when test-lib.sh writes global config, e.g. to set
`safe.bareRepository`), git prefers `$HOME/.gitconfig` over the XDG
location, and the `maintenance.repo` entry ends up in the wrong
file.

This is an inherent consequence of setting global config in
test-lib.sh rather than adjusting individual tests: writing any
entry to `$HOME/.gitconfig` has side effects beyond the intended
setting, because the mere existence of that file changes which
global config location git prefers for all subsequent writes.
Individual per-test adjustments would not have this interaction.

Fix this by overriding `HOME` to a non-existent directory inside the
subshells that test XDG behavior. Since these subshells already
override `XDG_CONFIG_HOME`, they do not need `$HOME/.gitconfig` at
all, and the subshell scoping ensures the original `HOME` is
restored automatically.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t7900-maintenance.sh | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 4700beacc1..4358df0424 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -101,8 +101,12 @@ test_expect_success "maintenance.autoDetach overrides gc.autoDetach" '
 test_expect_success 'register uses XDG_CONFIG_HOME config if it exists' '
 	test_when_finished rm -r .config/git/config &&
 	(
+		# Override HOME so that .gitconfig (which test-lib.sh may
+		# have created, e.g. to set safe.bareRepository) does not
+		# take precedence over the XDG location.
+		HOME=$PWD/must-not-exist &&
 		XDG_CONFIG_HOME=.config &&
-		export XDG_CONFIG_HOME &&
+		export HOME XDG_CONFIG_HOME &&
 		mkdir -p $XDG_CONFIG_HOME/git &&
 		>$XDG_CONFIG_HOME/git/config &&
 		git maintenance register &&
@@ -124,8 +128,12 @@ test_expect_success 'register does not need XDG_CONFIG_HOME config to exist' '
 test_expect_success 'unregister uses XDG_CONFIG_HOME config if it exists' '
 	test_when_finished rm -r .config/git/config &&
 	(
+		# Override HOME so that .gitconfig (which test-lib.sh may
+		# have created, e.g. to set safe.bareRepository) does not
+		# take precedence over the XDG location.
+		HOME=$PWD/must-not-exist &&
 		XDG_CONFIG_HOME=.config &&
-		export XDG_CONFIG_HOME &&
+		export HOME XDG_CONFIG_HOME &&
 		mkdir -p $XDG_CONFIG_HOME/git &&
 		>$XDG_CONFIG_HOME/git/config &&
 		git maintenance register &&
-- 
gitgitgadget

