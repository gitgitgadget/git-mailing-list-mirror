Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901301F428F
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 17:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107486; cv=none; b=nxJf001clX6RRp+MzD3StTmCHVtKnTlG1GDwlQ+Jd7ozJCO0RtPY7SCXksuYip1BFL53bRl3vbEQqscGoIia3oPCf4yiKtWCY6iXMxu91ncooffXeQBzlaJf2Nm4sTYEslpuQjA3Hbw74qUVOwhwz8hZkk6cVhvAKqjcmfan0Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107486; c=relaxed/simple;
	bh=Qm+Z7Nmwp+UFVskEZbOle77SYMoR3Z39gAyCLXDhn8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJhMbS0Qo89m9Ljk7WEHfBiOBOLprtQR97V261rO5kPNhkx8OH7peT/PaSzpIT9+DR5LbltnxvUch6miL03wa0pTORFZf2Gn22a3ouJhByXEmowMz4NlO+5wHJfLQf6v0UkxrXhjsD4D6xJCPtkXeTZ+y5QMKe30RKAxeHNekj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edOHeuAA; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edOHeuAA"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d5fb5e34cso2116967b3.0
        for <git@vger.kernel.org>; Wed, 13 Aug 2025 10:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755107483; x=1755712283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anTainIr92L6DRe1UFCmTSV8ljLLv3GdUKDOaM0TRoQ=;
        b=edOHeuAAOXw/clg7wtW9HR2axBZrPWIovGCNd3zy4MuxFrpIiihkZ98cQH8+XYH2hQ
         /NtB9CxKTo4kOwy/R7keDRD361JQvHKoTrEcyPsUOXXDX1qGNzunH2ctKlH1lFLPHGHn
         LXgj5knjnhzHac1sRM7yqRFtD+O4IP2jZboUIrpHyWeAbKErwiCStZkHwinTF0P8HQ7b
         Mg7XkW0cuB7CzIZ7Ru3FfMNwV6NwStPA5UEkIy0FRbUjNigG1/fSZko7laA7RY92mgqv
         FsTjJibtDtoXd9idpGCDATlAm5lypmWGcZ5j5Il8h5jUESyMnmnwKONOx3X750MRnSXh
         3hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755107483; x=1755712283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=anTainIr92L6DRe1UFCmTSV8ljLLv3GdUKDOaM0TRoQ=;
        b=JkICa2xrAf3aQF9mVOcY5YlTo7Ub4OsMexmVk6YPve1W7jfhENfa8euXeNvy5B7Fse
         1FuC0F510biyah11W0JSduhNf21zdBzAprdpRFBBRThiEskzkQhxclfSZTiYq6pVMgai
         S37ahkifU091IF7h1ZfdLHLGgbwf0N/BMb5mWjHc9lfJWpC219eZKHOju2HFomXgl6KE
         FJIN+IfICqVVtyaAa+6KEY+DXo/Yph3XSS7eA2aD1ju2/OPpkfKw3Zeo/Zqv5MZl0RpH
         +pIbbvP7ulb6Zrx+RgwdVSCgLc/gcOI0+kkHfKPNHyR1G3S/T/i/747YXxn4g43yGUVg
         DV5g==
X-Gm-Message-State: AOJu0YxHFL8FoYqHJV4ujtrqJFb0T9B66XwwJ51vBsBpNw0BDr17EjET
	Pji7DdpWeDqavH/49W971jasdsWd5R2YA16jmNONgcOpADD+/QgNtmIgyX6VI3lM
X-Gm-Gg: ASbGncufO0jHLpz8HPm7zCqCqnrLNz65SQdEBUHj60KVb39arogvaYBKjgkJiRbkl/7
	nDMCjM8mbA1DXNPQ/5CRJ+TJ/fvK+sJMjEpVOz9RSOZeenktpRDkrGdzlAp54qTb7lSX+nAXYZc
	BFmtDf6HmPMwUvc0xE6YCRSmsZByR7g/TZJq5scIGTs2HyhIq2yoHCNvhwMdGPoZ5jcTNO1SjRB
	71uI2kaIwmr3NnxXRYbElXVHKjKWs0P/m9x23b3WmBQQyOFGn1dMJWuAQDMmKbowwoMyHjIRO3S
	urtpQPmOYsBkfTjSL6i53lMSwDflIAN1StKmw5grM1t5lDWHogYrroRsfUjAvtBeQIlpoWKJWHK
	gKa8T0YLi7kIamiBq1Y/C989FjgbjufRMvMETVyc5gY0bwxMqu9Tt3J1SUnKzVdczSfwwB4Yl5q
	okymbDlcA=
X-Google-Smtp-Source: AGHT+IEMhOgmdyRrNKwxH9ID6Gcj7IuaqlzhMTzk762aHEAgYbJ8RpJlBDZ7EeFxQdJbJY1Q6sFhnw==
X-Received: by 2002:a05:690c:f16:b0:70e:43e9:6149 with SMTP id 00721157ae682-71d6027feb0mr7270097b3.16.1755107483171;
        Wed, 13 Aug 2025 10:51:23 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:1c37:18b4:a0bf:d7d3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71d60fe1936sm439957b3.38.2025.08.13.10.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 10:51:22 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 3/3] t7005: sanitize test environment for subsequent tests
Date: Wed, 13 Aug 2025 13:50:05 -0400
Message-ID: <20250813175112.88435-4-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250812170256.71751-1-ben.knoble+github@gmail.com>
References: <20250812170256.71751-1-ben.knoble+github@gmail.com>
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

Use test_config, subshells, single-command environment overrides, and
test helpers to automatically undo environment and config modifications
once finished.

Best-viewed-with: --ignore-all-space
Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 t/t7005-editor.sh | 83 ++++++++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 44 deletions(-)

diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index 0a5861b7f0..c490e5707a 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -34,61 +34,57 @@
 	test_commit_message HEAD -m "$msg"
 '
 
-TERM=dumb
-export TERM
 test_expect_success 'dumb should error out when falling back on vi' '
-	test_must_fail git commit --amend
+	test_must_fail env TERM=dumb git commit --amend
 '
 
 test_expect_success 'dumb should prefer EDITOR to VISUAL' '
-	EDITOR=./e-EDITOR.sh &&
-	VISUAL=./e-VISUAL.sh &&
-	export EDITOR VISUAL &&
-	git commit --amend &&
+	TERM=dumb EDITOR=./e-EDITOR.sh VISUAL=./e-VISUAL.sh \
+		git commit --amend &&
 	test_commit_message HEAD -m "Edited by EDITOR"
 '
 
-TERM=vt100
-export TERM
 for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
 do
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
 	test_expect_success "Using $i" '
-		PATH="$PWD:$PATH" git commit --amend &&
-		test_commit_message HEAD expect
+		if test "$i" = core_editor
+		then
+			test_config core.editor ./e-core_editor.sh
+		fi &&
+		(
+			case "$i" in
+			[A-Z]*)
+				eval "$i=./e-$i.sh" &&
+				export $i
+				;;
+			esac &&
+			PATH="$PWD:$PATH" TERM=vt100 git commit --amend
+		) &&
+		test_commit_message HEAD -m "Edited by $i"
 	'
 done
 
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
-		PATH="$PWD:$PATH" git commit --amend &&
-		test_commit_message HEAD expect
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
+			PATH="$PWD:$PATH" git commit --amend &&
+			test_commit_message HEAD expect || exit 1
+		done
+	)
+'
 
 test_expect_success 'editor with a space' '
 	echo "echo space >\"\$1\"" >"e space.sh" &&
@@ -97,9 +93,8 @@
 	test_commit_message HEAD -m space
 '
 
-unset GIT_EDITOR
 test_expect_success 'core.editor with a space' '
-	git config core.editor \"./e\ space.sh\" &&
+	test_config core.editor \"./e\ space.sh\" &&
 	git commit --amend &&
 	test_commit_message HEAD -m space
 '
-- 
2.48.1

