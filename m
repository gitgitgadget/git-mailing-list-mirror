Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CF62FD1BA
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018185; cv=none; b=RsPlIkEkUkLbeGHtfqTSGAuJVRzzgGIBpUFtjfyl7QXpiBM92sK+NTPVU9WAFBtYOhCJlOnHfI1P7QVOXp3MDR6AepGqlMEXpJhXvOEhXbqn84E33VsOvVX3QsXuoF6OdjUMnM0n1YTygqVn8vW7QAjpJiRv4butU0i0wk4L2xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018185; c=relaxed/simple;
	bh=CgqHqmrDvPK11BMZ6JXNFhgM4RtKq8ejAx911ShUHiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKFYdK7P7rR1uJLVfZ6hT1zISkQ8btXDn4NsMWt/XSssI3I2YRmUKFhskDhYcO9i77K2zLoQ+C8sWPffrsPJDOvEnNwZjsjNyvGa0Re19P100cqqlKNxO5WIhK+fC8V4IxSXRhnem+pxMyyoCZwe+dKPXL3tzC2zLWqDQSoJOJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9IQOppX; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9IQOppX"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71a455096e0so43472597b3.0
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 10:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755018183; x=1755622983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2oO/K9pUoZFYlKUpHMbQKY2aINc0cMDqpu6bD3AoSw=;
        b=X9IQOppX9d2wcHZB1zGKBBIc/D/l1tFBFOYchrGqA/Mz9Yj8qgfSATVWjbjj6F/qdY
         nyjhpWTB2BJhSvbjriotsRwj+BVOyhB7A8qzSaJ0rhy2wbP44TCCnmrRgNg5r7Fp1p2C
         wXydSW4saHEFnRZOgHBWr4wQTdZ2eNxkFwxiubse8OvXR2dq8qh7UJawIS7ANVD94Tvf
         Ii/jrSDNDMseg0HAQt27dTOQvZYHjA1ziyyp4yDTmE3sqU890qjmOMoQGnZE8btqmgRe
         kGV7HTifBLpCNf/+5ljzn+DetumG2dPVD/5sbih9kXm64kJhr99QjLQGvmDHJBRnbbus
         Y1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755018183; x=1755622983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d2oO/K9pUoZFYlKUpHMbQKY2aINc0cMDqpu6bD3AoSw=;
        b=MDSAilgkJ0bq1qHF34oP0CQ3iUUaC1Q+V8hbHshkSDO2+5t4GpPGQudKWd8YfWH3+Y
         vrnmaNIhMRNKRb11w78L9MBbVPXck/SnpwC+OQw5/afpWmLmdUrMsO74tMuaU45UKHR2
         o9dGNdOBuV/Vf3xK9U3VROn60UPiIRnpuE+ebiEiEvFLy4wKKkzKgt6eZ6fok0LOhFEX
         48tPsQir2vcOSOBUjxsDomKrJw3Un9MafBFe7wdwBRp08Uzt7Am5uDZ9azIIXiS61851
         mH3nw5wXyO4RTbHxzu7R++W3xSnDaGjNTbCJG+Xk0chizVOPz/alBh+gWvoAil7IEd6E
         lQBg==
X-Gm-Message-State: AOJu0YxWdWiKc0b346eCPOD+MtYt+Be4eflxMseDHjemIQjV/gxntcjm
	ouBXHZPMr3JVTFqaPDvb7SPqRD6pv7hg2yBMEFBnvYRrwkmUyQR8Qifp4q/CH76X
X-Gm-Gg: ASbGncvFwxieD+IJrZ20wVV0wr1s7VukWjWTEd9l4xrUjyuqymh0OOg/cPjo6GK1xSt
	pn9TbTsuc3CJI5MNew2+JH4jg8TW9QF7s8SFXhrle6+wPAXCdjMWakypEC3DPcV7tIw9du6a+Va
	O4jKyeJFPhvDNSg4GgCvoAfQCr1chseRWM1N/djMOdc//FQ+uaH+LSp+la1eF3y4TCQpmUCgM4o
	KkpQ85tRBB6sJF0V7aJTEH5k9fhh+6VJfTmRUi8UJA5ctIcnPhtsMX7RLyEmPL5z185+83YnF2E
	WI9dzufJSLaNxUJKghgQcI6RcGmfPgB2dGn5krR0AqFDpUKZJwo+sYso+PexO7CjdubbrPdbuMF
	8iEAxci7Z6YVUDef1u3yOc3YD7hidw7xYAzE0E6Gk8PpbGY2Gym86ssKeStY0j/8c0XQoh5EBJs
	Q=
X-Google-Smtp-Source: AGHT+IHlodqRlVA+HO942cKYLoxSclbWX2bv7BV3p0m1HF1HDr+RUKSfULbPXZaSSyX3CAUaATvpXA==
X-Received: by 2002:a05:690c:2608:b0:71b:efe7:bdba with SMTP id 00721157ae682-71d4ceddc13mr4122117b3.40.1755018182528;
        Tue, 12 Aug 2025 10:03:02 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:b54a:f21:a9f:3c85])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a3f6cfdsm76960927b3.24.2025.08.12.10.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:03:02 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 3/3] t7005: sanitize test environment for subsequent tests
Date: Tue, 12 Aug 2025 13:02:18 -0400
Message-ID: <20250812170256.71751-4-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250811221706.67168-1-ben.knoble+github@gmail.com>
References: <20250811221706.67168-1-ben.knoble+github@gmail.com>
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
 t/t7005-editor.sh | 85 ++++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 45 deletions(-)

diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index b384eff5d8..6cfefa916b 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -34,72 +34,67 @@
 	test_commit_message HEAD -m "$msg"
 '
 
-TERM=dumb
-export TERM
 test_expect_success 'dumb should error out when falling back on vi' '
-	test_must_fail git commit --amend
+	test_env TERM=dumb test_must_fail git commit --amend
 '
 
 test_expect_success 'dumb should prefer EDITOR to VISUAL' '
-	EDITOR=./e-EDITOR.sh &&
-	VISUAL=./e-VISUAL.sh &&
-	export EDITOR VISUAL &&
-	git commit --amend &&
+	test_env TERM=dumb EDITOR=./e-EDITOR.sh VISUAL=./e-VISUAL.sh \
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
-		test_env PATH="$PWD:$PATH" git commit --amend &&
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
+			test_env PATH="$PWD:$PATH" TERM=vt100 git commit --amend
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
-		test_env PATH="$PWD:$PATH" git commit --amend &&
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
+			test_env PATH="$PWD:$PATH" git commit --amend &&
+			test_commit_message HEAD expect || exit 1
+		done
+	)
+'
 
 test_expect_success 'editor with a space' '
 	echo "echo space >\"\$1\"" >"e space.sh" &&
 	chmod a+x "e space.sh" &&
-	GIT_EDITOR="./e\ space.sh" git commit --amend &&
+	test_env GIT_EDITOR="./e\ space.sh" git commit --amend &&
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

