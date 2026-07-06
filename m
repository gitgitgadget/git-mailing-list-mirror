Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24463AEB40
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 05:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783314127; cv=none; b=uUd1NoNps864r3Bti92jreR3Ts3eH889xS+EpAMQbW1SbRBjO9ywZuVrnoRHf51SiKwm2clBoNSD7i6S+KerjTuHNTv79oYWnPlcH406Vzy/RrnrENs1eGek/fjGHQG0HffPi6JP6EgUwolg2pYg9mZMN2xJGBaFPaMa+T2q9aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783314127; c=relaxed/simple;
	bh=qaB1nsiXAcgKjaL+Qht+y9BlAoNECNd5rcmEi+61Miw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZnT+XKxfgvsdbQGGNcn6WtQLC8z1Ql9mRZ/4GYrAXDGN3jNYtsEs5e7bT5pJxJkJSAf5SLT8hORv7ofqYEZ+ttuY264iL1kEkIFnQeGW30xpGFtQ1N8QOP6rvagGeYwOCv11CL2f+t64aNAQLuPsn5hveuQpEdMu6nZiPc1PPNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZwIKaAz; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZwIKaAz"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e5c92c389so116579385a.3
        for <git@vger.kernel.org>; Sun, 05 Jul 2026 22:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783314125; x=1783918925; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LTIQGno0E9IVyA8/YHvOOSseNq4q5Fmb1ybXTEFeAI=;
        b=UZwIKaAzXbytoMy6RXpuajBRPLQPa5IvXgsk43ZnDPbrUFDn6/vojH0AqsSUOumqQr
         84AN3t8EwLZejUJ1UI2O4x217PlJWAx9pA5TQ+Dislc3zbEAFwn3qPqWEp8qXC5QJgAk
         9sTUtp9X8IhMaL3RNnyNeNOpE2Rf4Eoo1sIrQNp7+3dVn4pf0UmAR57fy4y9k16gJMbN
         cF7AjLNzk9YNct4B9Hh6NcQGAjJIkd+92o70ZcM3fue3oIQqTCRdtmJj0ehCj72MezpU
         ixh1518tOnfdZ1gwJo3j6q3IUd0dOKVwESFVJ3i19jHoketZ069Bp+dLn4ynkYlPpZR0
         lIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783314125; x=1783918925;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/LTIQGno0E9IVyA8/YHvOOSseNq4q5Fmb1ybXTEFeAI=;
        b=Kp4iazxsmnE66gpr5EkMxDA6jiSzBGIGas+Hg4h/f9ZZhAWA3VihX9nX9gyQjMcjZk
         aJRa50bEUbxYsS3pPXVIE0y/gfssWivaluvnXI6wXGk+eio5Srn0GsZD+IV5MPtPVfnZ
         +MiiwaE9wQtc2q0zBRl1AymegAwFUcM/+uEaYpPwZDQKu4uNYAoXRJvlTnF5dTn0m88o
         y3sz6MDMGMzw1faN33cEhWVlzGrVJX/ny4nt7Ee9MyVPVnG45hSpaiSOp5apeAOS/uoE
         4KcSpZ0J/oQ2R/Fxpv32sxncte+anZ9tuiVLIaHbzTSPZ5pYFzGnJ8tSB0T+ZzfWEckn
         Z4Gw==
X-Gm-Message-State: AOJu0YxifobCNL+YLIemj6QQR9FQelVSMXdPUtn04M3PfNW4osLtBzyu
	ni16NNG4i5n48UUBpd+H+kaQxqRkx+ogGr2LkaGsPnUVUzDzth1cEYVA/ZrD27AS
X-Gm-Gg: AfdE7ck2JDpv5+B1s/Vi73gMZDumaPEFonMtwViRw8VsKuYZq637pzCuowf9h5bEBZo
	Msbr0HNXvz4Ofhk2UaQnep1Ql2v1B6d+7Gd/Yeuv70wceTW8dYKYV/ofRLzA+hr0sZjZB4DfIll
	7saU2fVaxOQsm5O8IvrJ5Vf0o64FR5QSZt1IC6619F0GZHxSiSlcqc/G0SnZxU9RWNuxqmsWNdY
	U3EfF6OvAC3ZKiq6sG0XcqLK7v2InHfo5/UbX/dHZRt0st2abSrRagCNgrvmpg12gbykUeGKy7r
	N4gxZSJTNh43wjc2CXKm8UhQ1ugvg1Bh7mwBBVGF2SXDxu9tEW6WWvYmv5eB7lC348JN9e6S3TA
	LX4fijs3rh8hAeU2gCE/RrAjEmeB5pn/0eLBhGwHsKIKBNWYq5XP0PVcq/JscJcAxfV/NZciMm0
	VbPunGqxmtL4b5Lg==
X-Received: by 2002:a05:620a:170b:b0:92e:7973:ebd8 with SMTP id af79cd13be357-92e9a4a6eb9mr1193150585a.37.1783314124943;
        Sun, 05 Jul 2026 22:02:04 -0700 (PDT)
Received: from [127.0.0.1] ([68.154.38.16])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90ca004fsm842186985a.28.2026.07.05.22.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 22:02:04 -0700 (PDT)
Message-Id: <44ba6d1f1a549f34f73f3863c035837403271f35.1783314119.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2135.v4.git.1783314119.gitgitgadget@gmail.com>
References: <pull.2135.v3.git.1783054466.gitgitgadget@gmail.com>
	<pull.2135.v4.git.1783314119.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Jul 2026 05:01:54 +0000
Subject: [PATCH v4 2/6] t: fix grep assertions missing file arguments
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Three grep assertions were missing their file arguments, causing
them to read from empty stdin instead of the intended file:

- t2402: '! grep ...' should read from 'out', matching the
  grep on the preceding line.
- t7507: the closing quote is in the wrong place, making the
  entire 'diff --git actual' a single pattern with no file
  argument instead of pattern 'diff --git' and file 'actual'.
- t7700: '! grep ...' should read from 'packlist', matching
  the redirect on the preceding line.

Without file arguments these greps always succeed (empty stdin
matches nothing), so the assertions were not actually checking
anything.  All three tests pass with the corrected file arguments,
confirming the intended behavior is sound.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 t/t2402-worktree-list.sh  | 2 +-
 t/t7507-commit-verbose.sh | 2 +-
 t/t7700-repack.sh         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index e0c6abd2f5..93f92e854a 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -144,7 +144,7 @@ test_expect_success '"list" all worktrees with prunable annotation' '
 	rm -rf prunable &&
 	git worktree list >out &&
 	grep "/prunable  *[0-9a-f].* prunable$" out &&
-	! grep "/unprunable  *[0-9a-f].* prunable$"
+	! grep "/unprunable  *[0-9a-f].* prunable$" out
 '
 
 test_expect_success '"list" all worktrees --porcelain with prunable' '
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index b53d71c086..acdb6b1455 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -163,7 +163,7 @@ done
 
 test_expect_success "status ignores commit.verbose=true" '
 	git -c commit.verbose=true status >actual &&
-	! grep "^diff --git actual"
+	! grep "^diff --git" actual
 '
 
 test_done
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 63ef63fc50..c6ff3aed30 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -194,7 +194,7 @@ test_expect_success 'local packed unreachable obs that exist in alternate ODB ar
 	rm -f .git/objects/pack/* &&
 	mv pack-* .git/objects/pack/ &&
 	git verify-pack -v -- .git/objects/pack/*.idx >packlist &&
-	! grep "^$coid " &&
+	! grep "^$coid " packlist &&
 	echo >.git/objects/info/alternates &&
 	test_must_fail git show $coid
 '
-- 
gitgitgadget

