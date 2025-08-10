Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B972719D082
	for <git@vger.kernel.org>; Sun, 10 Aug 2025 16:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754841821; cv=none; b=TSsYRq7RdLQCEkKUTvw3n7RaB3zsKvJdMzMT9jreEb+/tYOMdwJ+v0/nYKZhGxNdPuVx3SBL21Kh+3a0T+31hopzatb1L7qVQgS3OnuakN39/ZxZ+TI7DDzHDHB1v7ZAGAb19xbfKxY2FKyGkHGipDvliL6ATC7uPCwiB8KoQog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754841821; c=relaxed/simple;
	bh=e3N41Hs+i81IJrMs7ilX4FrcV2ZZ60XbEe0e+dzdfdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHeaeWxkvrWicSSXzMDgaupebttDuvSZ+1A0l7vOFGSkB8JOBv2eZOYBLuLIG0oTVAZJ/t6umLeD7kknykdVAJs+crL5DfrGaF0l4j+ZVIOla8J4xPSvnL5C+u+kZtJKSNPPxT0bqXbTcDQazNaKPOBM1O15EbF8Xt1xRvS3xZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeTvik7s; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeTvik7s"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71b49bbb95cso33698847b3.1
        for <git@vger.kernel.org>; Sun, 10 Aug 2025 09:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754841817; x=1755446617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JL4TUbtPThWn2IpFXUJqwd/vTnpIEICl8X+HWVzqHg=;
        b=IeTvik7sM7Vzg7dh7QTlNh/EmWV/klq1FZUJkv+eNrYT6SaEhVFWk/rfEytKarlhGe
         isNhEBtp8ZFl0QsdinR+V/4GjKDg7PXQL6kKMuLbrG+NzHUdBdifRKYcFlvd4P0rCNaO
         cqSx0Cz/ZjTt7HEPAtY1LFma5hCY/wQFBgU7o2StGh0nFbbLjCSCY1GCMIXEaEldDCc5
         pNhZgCw6HpszHPj8fvafV4aFsLkj6xWd8PJ1OAEoQ7CSBxuUUKApsNuiHg62/mkkPqLO
         u+TuIZF5mhq1748fZvmjbNuptkrx/m2Uql/GmK+NHkG2rchTrtOfWR1Wr9OmnLUGLxCo
         /dLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754841817; x=1755446617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2JL4TUbtPThWn2IpFXUJqwd/vTnpIEICl8X+HWVzqHg=;
        b=uXWMhqPNPKJ6Pwe3MmtdczwXJ/Kfqeanuaj0lnQSVjLMz4dkEzOdetw/slD6khBtHd
         irTPkE2egxx3eAjPfk5m5LgclF/zp+kgw5vXmf2gABJlleQ4XF8p0QjySfOaxwgPrctW
         UFiCvPID4O5nuK5HsFviWaZR8E/vJ3Nsr1wtZU7tjN2YGl/Z8+zAEM+xTgRxD8qDawcS
         iQFSMSOgBkDi6Z8CTeocgLm1XZ9d0A51zGG4P/LiEFOq9O6jCdTY9dd8L0tNXF5HJrOZ
         6osI9U2pw4gF5DKJq8UUr6wKNgjqrTO8vk2WAWoLcRUs2MTFPF2NDptX5s10GubclLqH
         KR4w==
X-Gm-Message-State: AOJu0YwsbeO1TZFpikJDvTWlBCY1lm9wCtACn3c/nxNexm9IY+xMa3wV
	MsX8tPXckVVAdA32v7PCa5xQMo51ClR5sCepJEUxuNuV2/un/vXVH+UdwMuSHgdi
X-Gm-Gg: ASbGnctyirCCV/At0/olOK26or8tuwUsWsEjJjn8afVUi6fOXL5KQ7m0Uga8dfDAfOJ
	svDTgAx+lka3NksHGJ0nhNo0C11MSqBVVjw1tSRe+qbbu5S8+qzYbEvhyKbDxBE+biSXs10k2PR
	GvDxuG9MJpT9NV/lOljodI+Aqm7nYF+v5ntB+D69VEkWZLLRFNgnHTKVUFIjMQGxofQ5hNQ0RZx
	6WOYV16so/aksErO/bOZx5s3oXPezb3Npsqm+og93E72Qf+u457N5ipudgk55mIoBUzRSAC9HIe
	/lii3rE+AzPu6AlQKvkJt+JpEPhEbjK4yF2eOaBl12J7cQnOQo+wPdZR1J3hAdjenOtlhlk2NPA
	GyGqx13scYKTsrm56v9oR/Ue1XQqPXgQf0AhwjyZDQ8equrwrsDe0immcUvxbvkqKuH0QepJj
X-Google-Smtp-Source: AGHT+IGgiDtAcfBZ/Yy4eiB1XGRTWL4sGQsoeYJWfq2ig1IfuHMuAZox7tU6w9Zohvc8YozTqP6Cpg==
X-Received: by 2002:a05:690c:6281:b0:71a:323a:b297 with SMTP id 00721157ae682-71bf0cd2dc8mr126766167b3.7.1754841817156;
        Sun, 10 Aug 2025 09:03:37 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:dc6d:d141:d6d7:493e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a3a999esm64149937b3.2.2025.08.10.09.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 09:03:36 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 2/3] t7005: sanitize test environment for subsequent tests
Date: Sun, 10 Aug 2025 12:03:18 -0400
Message-ID: <20250810160323.49372-3-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250520193506.95199-1-ben.knoble+github@gmail.com>
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the editor tests manipulate the environment or config in ways
that affect future tests, but those modifications are visible to future
tests and create a footgun for them.

Use test_config, subshells, and test helpers to automatically undo
environment and config modifications once finished.

Best-viewed-with: --ignore-all-space
Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 t/t7005-editor.sh | 132 +++++++++++++++++++++++++---------------------
 1 file changed, 71 insertions(+), 61 deletions(-)

diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index 2f59fc0549..eae76cc2f2 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -38,73 +38,84 @@
 	test_cmp expect actual
 '
 
-TERM=dumb
-export TERM
 test_expect_success 'dumb should error out when falling back on vi' '
-	if git commit --amend
-	then
-		echo "Oops?"
-		false
-	else
-		: happy
-	fi
+	(
+		TERM=dumb &&
+		export TERM &&
+		if git commit --amend
+		then
+			echo "Oops?"
+			false
+		else
+			: happy
+		fi
+	)
 '
 
 test_expect_success 'dumb should prefer EDITOR to VISUAL' '
-	EDITOR=./e-EDITOR.sh &&
-	VISUAL=./e-VISUAL.sh &&
-	export EDITOR VISUAL &&
-	git commit --amend &&
-	echo "Edited by EDITOR" >expect &&
-	git show -s --format=%s >actual &&
+	(
+		TERM=dumb &&
+		export TERM &&
+		EDITOR=./e-EDITOR.sh &&
+		VISUAL=./e-VISUAL.sh &&
+		export EDITOR VISUAL &&
+		git commit --amend &&
+		echo "Edited by EDITOR" >expect &&
+		git show -s --format=%s >actual
+	) &&
 	test_cmp expect actual
 '
 
-TERM=vt100
-export TERM
-for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
-do
-	echo "Edited by $i" >expect
-	unset EDITOR VISUAL GIT_EDITOR
-	git config --unset-all core.editor
-	case "$i" in
-	core_editor)
-		git config core.editor ./e-core_editor.sh
-		;;
-	[A-Z]*)
-		eval "$i=./e-$i.sh"
-		export $i
-		;;
-	esac
-	test_expect_success "Using $i" '
-		git --exec-path=. commit --amend &&
-		git show -s --pretty=oneline >show &&
-		<show sed -e "s/^[0-9a-f]* //" >actual &&
-		test_cmp expect actual
-	'
-done
+test_expect_success 'Using individual editors' '
+	test_when_finished "test_unconfig --unset-all core.editor" &&
+	(
+		TERM=vt100 &&
+		export TERM &&
+		for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
+		do
+			sane_unset EDITOR VISUAL GIT_EDITOR &&
+			test_might_fail git config --unset-all core.editor &&
+			echo "Edited by $i" >expect &&
+			case "$i" in
+			core_editor)
+				git config core.editor ./e-core_editor.sh
+				;;
+			[A-Z]*)
+				eval "$i=./e-$i.sh" &&
+				export $i
+				;;
+			esac &&
+			git --exec-path=. commit --amend &&
+			git show -s --pretty=oneline >show &&
+			<show sed -e "s/^[0-9a-f]* //" >actual &&
+			test_cmp expect actual
+		done
+	)
+'
 
-unset EDITOR VISUAL GIT_EDITOR
-git config --unset-all core.editor
-for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
-do
-	echo "Edited by $i" >expect
-	case "$i" in
-	core_editor)
-		git config core.editor ./e-core_editor.sh
-		;;
-	[A-Z]*)
-		eval "$i=./e-$i.sh"
-		export $i
-		;;
-	esac
-	test_expect_success "Using $i (override)" '
-		git --exec-path=. commit --amend &&
-		git show -s --pretty=oneline >show &&
-		<show sed -e "s/^[0-9a-f]* //" >actual &&
-		test_cmp expect actual
-	'
-done
+test_expect_success 'Using editors with overrides' '
+	(
+		TERM=vt100 &&
+		export TERM &&
+		for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
+		do
+			echo "Edited by $i" >expect &&
+			case "$i" in
+			core_editor)
+				git config core.editor ./e-core_editor.sh
+				;;
+			[A-Z]*)
+				eval "$i=./e-$i.sh" &&
+				export $i
+				;;
+			esac &&
+			git --exec-path=. commit --amend &&
+			git show -s --pretty=oneline >show &&
+			<show sed -e "s/^[0-9a-f]* //" >actual &&
+			test_cmp expect actual
+		done
+	)
+'
 
 test_expect_success 'editor with a space' '
 	echo "echo space >\"\$1\"" >"e space.sh" &&
@@ -115,9 +126,8 @@
 	test_cmp expect actual
 '
 
-unset GIT_EDITOR
 test_expect_success 'core.editor with a space' '
-	git config core.editor \"./e\ space.sh\" &&
+	test_config core.editor \"./e\ space.sh\" &&
 	git commit --amend &&
 	echo space >expect &&
 	git show -s --pretty=tformat:%s >actual &&
-- 
2.48.1

