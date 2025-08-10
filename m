Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DA525BEF2
	for <git@vger.kernel.org>; Sun, 10 Aug 2025 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754841815; cv=none; b=KmQ1syB+sLm+kZx/Ow6f7HBcinmM/qRsWZ1CUnTcA00aRia2rXzMwNMeqOLsuDxx/G8ByaR3y0cXX04B0BlYIPI4JYp2uys+rzhFKh/+VO5/4gdbqcBOd1TN/4NNS3hQVFmCxO5F89g7/03nVa85rLHQjvWby80z9pP8+Q6ghQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754841815; c=relaxed/simple;
	bh=qoLiv0Onzb/xEnMDclh4YnKyOzQ9kJ6phB5idsjaU9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8LI2LKljr1PAlnXCfbGohIRAW5bu40OaJEpGCXbnNbrIjVdlhvf4k2nyx+QSdxNJGWkiuIITlU5DwKszrTdcT19Pf2cNEa7AGp4K6wAY/Q0OtX/IilXMbT5YsvhzH6yTzABRHx3MoFWBuW+y+ECw0rUnKWxT6idcfcr9wOSrXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWxMG3yS; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWxMG3yS"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71bd9e38af7so33285077b3.1
        for <git@vger.kernel.org>; Sun, 10 Aug 2025 09:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754841813; x=1755446613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVi+DmLyiC6v2ZKNBrE9DU3piGbuOuwJGD2ZzWZTCWg=;
        b=WWxMG3ySCG1/eD/n1bWtSoJs8EMOTL73VhJ6iljXiM1GOMJ+oPOTGnorFct0vPaixa
         WznHEl9CetS4+PQF4n9bz7jZdIDPN1ePl37gDwDiZbHP2HfjHoKuMNlcqslFqeSnOeIf
         7jClCLDskVH3UlsadF7xwsAWy/MgR3ghjXL72pcRhbdEuwmCyiy+9bzBtvsQPdIvTUug
         WcisZUXZNf5HH0vmpu93FJ0VONP51MvNGpW+uMgQT0mU7Ahs1A5nBnF0aBWy/NaF7zT/
         qXPVxPSGw0tBXn9GmHPQ1Ov48RwIeX3EUdbUloBriMbkl0Ef+PllQryAvefBKcM+Q8+r
         NWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754841813; x=1755446613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xVi+DmLyiC6v2ZKNBrE9DU3piGbuOuwJGD2ZzWZTCWg=;
        b=poqCURhLYMjbHcdtrTYoPLUMlS2iAYrJq4H8mwokDCy1Kr4bDMvPNjj4/AuMUaPgh3
         nOlTj8MlMtPSMUhZU+nFnk3GvAyJTeC8Jl5LBp9wcGITEDUsTtMCeztgAe6kKD9C1Bl8
         WThX79xxept38GA13hYdQ8w4nUWuyvSFlr2fmf6nwoNPeLKo5qv/n43k5kIAG7VWV3Ag
         H/BlXK/KdjEitTBIP2s+IXbZA6W96cEXu6iYOpmXf3cZruvNdu+0elpcvH94ShvBTYNC
         Zjac/vz3OqAJsR0UWn+4R45fYWMdLWWHFj5+0eZaLpvgJ+Z+qjUDhfeSiFgEHmeaEehK
         3Fow==
X-Gm-Message-State: AOJu0Ywoe+y+0RXm0e41y4ojp33d2imNUv+ejNXtY2tCgAeuI6iujCEq
	rb6/iqwBb3M7CEBNVJWjnu/0rCtLqOpXev4jTTBqPW/QwYtu/b71KEsqU60C3iHq
X-Gm-Gg: ASbGnctmYA6ZiIc2jCNZ/E/cooUp2JvEiEM9VonjIGsAmmxb4WMnePp04/8yJe4FIgL
	XLGPVFssPqaaUVdrei0W1M0O7crjqLmKI/TbkEKv7zGWgbqA2EZJG0yyGycLY13C7BS9zaBkER2
	DDUHOdoe/2pqj6/a7RqBzkdJwewHi4a78M4nF1McwzgO1wPS1LvTVeucmQiKubQay19kY7m/1Gj
	u4Edl8vFXrKO+zCzkWjRZEaQVDXtpP6vtVwZkh3+IC84ggTpzQgliP52cBs7T2RvLV8zVT7JL6j
	V/4L818oietJsWPEAJRlkXi8GqLEzRI8GpaJn6tTx0a4fPtMNdVN28J5tDJAnFuZ7YFcOvcBkMH
	drhylzhitTCWO9WyVaQB1IUuoA0+AfODf3RLCSVYZ48nda1kvwgmp52DXC26OYzcbIbnBm8XY
X-Google-Smtp-Source: AGHT+IEv97U7DUd9ux83EIGDyjvpvftq63yd09dvjMMNKJoXxCpYDtzLJdJaezc6hmeMNfEvblDs7Q==
X-Received: by 2002:a05:690c:4a06:b0:71a:198a:217f with SMTP id 00721157ae682-71bf0cdefe4mr115951357b3.8.1754841812531;
        Sun, 10 Aug 2025 09:03:32 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:dc6d:d141:d6d7:493e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a3a999esm64149937b3.2.2025.08.10.09.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 09:03:31 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 1/3] t7005: use modern test style
Date: Sun, 10 Aug 2025 12:03:17 -0400
Message-ID: <20250810160323.49372-2-ben.knoble+github@gmail.com>
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

Tests in t7005 mask Git error codes and do not use our nice helpers for
comparing results. Improve that, and drop a few old-style blank lines
while at it.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 t/t7005-editor.sh | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index 5fcf281dfb..2f59fc0549 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -7,10 +7,8 @@
 unset EDITOR VISUAL GIT_EDITOR
 
 test_expect_success 'determine default editor' '
-
 	vi=$(TERM=vt100 git var GIT_EDITOR) &&
 	test -n "$vi"
-
 '
 
 if ! expr "$vi" : '[a-z]*$' >/dev/null
@@ -33,19 +31,16 @@
 fi
 
 test_expect_success setup '
-
 	msg="Hand-edited" &&
 	test_commit "$msg" &&
 	echo "$msg" >expect &&
-	git show -s --format=%s > actual &&
+	git show -s --format=%s >actual &&
 	test_cmp expect actual
-
 '
 
 TERM=dumb
 export TERM
 test_expect_success 'dumb should error out when falling back on vi' '
-
 	if git commit --amend
 	then
 		echo "Oops?"
@@ -56,13 +51,13 @@
 '
 
 test_expect_success 'dumb should prefer EDITOR to VISUAL' '
-
 	EDITOR=./e-EDITOR.sh &&
 	VISUAL=./e-VISUAL.sh &&
 	export EDITOR VISUAL &&
 	git commit --amend &&
-	test "$(git show -s --format=%s)" = "Edited by EDITOR"
-
+	echo "Edited by EDITOR" >expect &&
+	git show -s --format=%s >actual &&
+	test_cmp expect actual
 '
 
 TERM=vt100
@@ -83,8 +78,8 @@
 	esac
 	test_expect_success "Using $i" '
 		git --exec-path=. commit --amend &&
-		git show -s --pretty=oneline |
-		sed -e "s/^[0-9a-f]* //" >actual &&
+		git show -s --pretty=oneline >show &&
+		<show sed -e "s/^[0-9a-f]* //" >actual &&
 		test_cmp expect actual
 	'
 done
@@ -105,8 +100,8 @@
 	esac
 	test_expect_success "Using $i (override)" '
 		git --exec-path=. commit --amend &&
-		git show -s --pretty=oneline |
-		sed -e "s/^[0-9a-f]* //" >actual &&
+		git show -s --pretty=oneline >show &&
+		<show sed -e "s/^[0-9a-f]* //" >actual &&
 		test_cmp expect actual
 	'
 done
@@ -115,17 +110,18 @@
 	echo "echo space >\"\$1\"" >"e space.sh" &&
 	chmod a+x "e space.sh" &&
 	GIT_EDITOR="./e\ space.sh" git commit --amend &&
-	test space = "$(git show -s --pretty=format:%s)"
-
+	echo space >expect &&
+	git show -s --pretty=tformat:%s >actual &&
+	test_cmp expect actual
 '
 
 unset GIT_EDITOR
 test_expect_success 'core.editor with a space' '
-
 	git config core.editor \"./e\ space.sh\" &&
 	git commit --amend &&
-	test space = "$(git show -s --pretty=format:%s)"
-
+	echo space >expect &&
+	git show -s --pretty=tformat:%s >actual &&
+	test_cmp expect actual
 '
 
 test_done
-- 
2.48.1

