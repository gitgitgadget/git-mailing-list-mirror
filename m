Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6586D2E3F2
	for <git@vger.kernel.org>; Sun, 28 Apr 2024 22:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714343479; cv=none; b=tkwRu1bIT9OGTNEdEC4fL7Cmpou6Qg8SHhneapnCAm6tASI2LdsTfouwQXgXGvkrlF5mzJv0TVQart+QOqgaPBRL9ObgdW7vaqIOb0VUSA1HmI8bRHs15Ce5nGaSt7T2GI4CjakHq4UihemBI9oTCKp8KCNwc+BtKUY/kBiDlcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714343479; c=relaxed/simple;
	bh=mXdyuW9SpuwPoHN3LZsafvlv7UN+oGgmHHavu4/rZIM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qygHLSCyI9hLIfk4F7nPWVvWRRG7enuEK1ScJ1jetcy3ZuO4hzYVRMpzuhNSnw/AZPP7NCBBO1cwUd9kLc/vhXN2xaNltjtbVaNqbPhaFoRtNgx+ETY3Yds+oDi4WfqwG2JFZZebmm9A6HhVSnoAX08K6z94jdzl+TO5wKdhLes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1rOjaUy; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1rOjaUy"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41bca450fa3so11650765e9.2
        for <git@vger.kernel.org>; Sun, 28 Apr 2024 15:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714343475; x=1714948275; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osBKKwwpR/+9hL2wkALs6vJuDNYhp8UoHBeiito79xI=;
        b=F1rOjaUykdX/i2aSSmM2mQyo/YrH3/lZ44qRVmh/rMoKFcYQV5EUkvOi2In6O+I+MX
         RBdhqd3wbZzUcQXpgTLyMC5+vrio7BVQccYqJRLXmc+/7YYcrhUnoE7hnMZ0GSM9cdYL
         96GSX6BssyP7X7VYoGNJOwzT36kl1lf38nekwRbBBRMj590qJvBBbsDljhxtFVWLf628
         XBv1e/pUUjjVQMSY51yp2mnUn/oBy6iLMhu3yW2dxxIvbVxfHUkYkiSEX+OqPzV4UrxU
         2DhFRMWtic8tUzESLQBCSi7RHFJIwY550eAeqnVe4xIe1l5NSwRVK43KpniGkZvGo4Rg
         +dOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714343475; x=1714948275;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osBKKwwpR/+9hL2wkALs6vJuDNYhp8UoHBeiito79xI=;
        b=AbgxPjBctYa+PFwV0LTH2G0JNMrYPXDGHGl4fo3QGUifnuBSJShrcjMZuLHhAx6Tzh
         B8Tm18Q5omdRLdVs8ZKNLXxBEPy9ieO+suf5kOve3y2iof9NTqAzJ71eg4ozgC2XH7Ql
         P/iTRurS0tc0eDceuVbUDjQdDxRcjdEiOSE4XVJnTc1KaM/mAh8Ir7Am4ndOGg6bGWHO
         XdjnCIfFDOsXhG/e1OEwZL6W7h9/bbUsGXOabi/dgwECpNVw/hPJuQ/Dob1lwbXRGDw8
         kNOlo2WCV6aoxcRtLAr/bq5fWomc21o/lzhddRYnGXp/UH9a78X70F5vb365gTn88gK3
         o3ZA==
X-Gm-Message-State: AOJu0YyVW94HXqpZNwWYI1/ZtgzBzTY7gGbkF5rE+3ijZpJWvDsAFdi1
	1+4B51phg8ppKUiwkp/quOVP0YU7JY6JLG+byUFUFvLKHNGXsPQFJkAinA==
X-Google-Smtp-Source: AGHT+IG1wlMZX+7gokpZBnn9sd33eVGlNgVWhQK3gWInpYkJ+PadjFNW9WP93omRG68kLso1KOSitw==
X-Received: by 2002:a05:600c:3108:b0:41b:b884:f151 with SMTP id g8-20020a05600c310800b0041bb884f151mr4439618wmo.34.1714343475592;
        Sun, 28 Apr 2024 15:31:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n40-20020a05600c502800b0041b4c293f75sm14052311wmr.13.2024.04.28.15.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 15:31:15 -0700 (PDT)
Message-Id: <33e128496b3d250b45a27490fa45d40cb659c3b2.1714343461.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
References: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
From: "Matheus Afonso Martins Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Apr 2024 22:31:01 +0000
Subject: [PATCH 13/13] tests: add tests for the new url-parse builtin
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
Cc: Matheus Moreira <matheus.a.m.moreira@gmail.com>,
    Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

From: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

Test git URL parsing, validation and component extraction
on all documented git URL schemes and syntaxes.

Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
---
 t/t9904-url-parse.sh | 194 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 194 insertions(+)
 create mode 100755 t/t9904-url-parse.sh

diff --git a/t/t9904-url-parse.sh b/t/t9904-url-parse.sh
new file mode 100755
index 00000000000..f147f00591c
--- /dev/null
+++ b/t/t9904-url-parse.sh
@@ -0,0 +1,194 @@
+#!/bin/sh
+#
+# Copyright © 2024 Matheus Afonso Martins Moreira
+#
+
+test_description='git url-parse tests'
+
+. ./test-lib.sh
+
+test_expect_success 'git url-parse -- ssh syntax' '
+	git url-parse "ssh://user@example.com:1234/repository/path" &&
+	git url-parse "ssh://user@example.com/repository/path" &&
+	git url-parse "ssh://example.com:1234/repository/path" &&
+	git url-parse "ssh://example.com/repository/path"
+'
+
+test_expect_success 'git url-parse -- git syntax' '
+	git url-parse "git://example.com:1234/repository/path" &&
+	git url-parse "git://example.com/repository/path"
+'
+
+test_expect_success 'git url-parse -- http syntax' '
+	git url-parse "https://example.com:1234/repository/path" &&
+	git url-parse "https://example.com/repository/path" &&
+	git url-parse "http://example.com:1234/repository/path" &&
+	git url-parse "http://example.com/repository/path"
+'
+
+test_expect_success 'git url-parse -- scp syntax' '
+	git url-parse "user@example.com:/repository/path" &&
+	git url-parse "example.com:/repository/path"
+'
+
+test_expect_success 'git url-parse -- username expansion - ssh syntax' '
+	git url-parse "ssh://user@example.com:1234/~user/repository" &&
+	git url-parse "ssh://user@example.com/~user/repository" &&
+	git url-parse "ssh://example.com:1234/~user/repository" &&
+	git url-parse "ssh://example.com/~user/repository"
+'
+
+test_expect_success 'git url-parse -- username expansion - git syntax' '
+	git url-parse "git://example.com:1234/~user/repository" &&
+	git url-parse "git://example.com/~user/repository"
+'
+
+test_expect_success 'git url-parse -- username expansion - scp syntax' '
+	git url-parse "user@example.com:~user/repository" &&
+	git url-parse "example.com:~user/repository"
+'
+
+test_expect_success 'git url-parse -- file urls' '
+	git url-parse "file:///repository/path" &&
+	git url-parse "file:///" &&
+	git url-parse "file://"
+'
+
+test_expect_success 'git url-parse -c protocol -- ssh syntax' '
+	test ssh = "$(git url-parse -c protocol "ssh://user@example.com:1234/repository/path")" &&
+	test ssh = "$(git url-parse -c protocol "ssh://user@example.com/repository/path")" &&
+	test ssh = "$(git url-parse -c protocol "ssh://example.com:1234/repository/path")" &&
+	test ssh = "$(git url-parse -c protocol "ssh://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c protocol -- git syntax' '
+	test git = "$(git url-parse -c protocol "git://example.com:1234/repository/path")" &&
+	test git = "$(git url-parse -c protocol "git://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c protocol -- http syntax' '
+	test https = "$(git url-parse -c protocol "https://example.com:1234/repository/path")" &&
+	test https = "$(git url-parse -c protocol "https://example.com/repository/path")" &&
+	test http = "$(git url-parse -c protocol "http://example.com:1234/repository/path")" &&
+	test http = "$(git url-parse -c protocol "http://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c protocol -- scp syntax' '
+	test ssh = "$(git url-parse -c protocol "user@example.com:/repository/path")" &&
+	test ssh = "$(git url-parse -c protocol "example.com:/repository/path")"
+'
+
+test_expect_success 'git url-parse -c user -- ssh syntax' '
+	test user = "$(git url-parse -c user "ssh://user@example.com:1234/repository/path")" &&
+	test user = "$(git url-parse -c user "ssh://user@example.com/repository/path")" &&
+	test "" = "$(git url-parse -c user "ssh://example.com:1234/repository/path")" &&
+	test "" = "$(git url-parse -c user "ssh://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c user -- git syntax' '
+	test "" = "$(git url-parse -c user "git://example.com:1234/repository/path")" &&
+	test "" = "$(git url-parse -c user "git://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c user -- http syntax' '
+	test "" = "$(git url-parse -c user "https://example.com:1234/repository/path")" &&
+	test "" = "$(git url-parse -c user "https://example.com/repository/path")" &&
+	test "" = "$(git url-parse -c user "http://example.com:1234/repository/path")" &&
+	test "" = "$(git url-parse -c user "http://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c user -- scp syntax' '
+	test user = "$(git url-parse -c user "user@example.com:/repository/path")" &&
+	test "" = "$(git url-parse -c user "example.com:/repository/path")"
+'
+
+test_expect_success 'git url-parse -c host -- ssh syntax' '
+	test example.com = "$(git url-parse -c host "ssh://user@example.com:1234/repository/path")" &&
+	test example.com = "$(git url-parse -c host "ssh://user@example.com/repository/path")" &&
+	test example.com = "$(git url-parse -c host "ssh://example.com:1234/repository/path")" &&
+	test example.com = "$(git url-parse -c host "ssh://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c host -- git syntax' '
+	test example.com = "$(git url-parse -c host "git://example.com:1234/repository/path")" &&
+	test example.com = "$(git url-parse -c host "git://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c host -- http syntax' '
+	test example.com = "$(git url-parse -c host "https://example.com:1234/repository/path")" &&
+	test example.com = "$(git url-parse -c host "https://example.com/repository/path")" &&
+	test example.com = "$(git url-parse -c host "http://example.com:1234/repository/path")" &&
+	test example.com = "$(git url-parse -c host "http://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c host -- scp syntax' '
+	test example.com = "$(git url-parse -c host "user@example.com:/repository/path")" &&
+	test example.com = "$(git url-parse -c host "example.com:/repository/path")"
+'
+
+test_expect_success 'git url-parse -c port -- ssh syntax' '
+	test 1234 = "$(git url-parse -c port "ssh://user@example.com:1234/repository/path")" &&
+	test "" = "$(git url-parse -c port "ssh://user@example.com/repository/path")" &&
+	test 1234 = "$(git url-parse -c port "ssh://example.com:1234/repository/path")" &&
+	test "" = "$(git url-parse -c port "ssh://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c port -- git syntax' '
+	test 1234 = "$(git url-parse -c port "git://example.com:1234/repository/path")" &&
+	test "" = "$(git url-parse -c port "git://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c port -- http syntax' '
+	test 1234 = "$(git url-parse -c port "https://example.com:1234/repository/path")" &&
+	test "" = "$(git url-parse -c port "https://example.com/repository/path")" &&
+	test 1234 = "$(git url-parse -c port "http://example.com:1234/repository/path")" &&
+	test "" = "$(git url-parse -c port "http://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c port -- scp syntax' '
+	test "" = "$(git url-parse -c port "user@example.com:/repository/path")" &&
+	test "" = "$(git url-parse -c port "example.com:/repository/path")"
+'
+
+test_expect_success 'git url-parse -c path -- ssh syntax' '
+	test "/repository/path" = "$(git url-parse -c path "ssh://user@example.com:1234/repository/path")" &&
+	test "/repository/path" = "$(git url-parse -c path "ssh://user@example.com/repository/path")" &&
+	test "/repository/path" = "$(git url-parse -c path "ssh://example.com:1234/repository/path")" &&
+	test "/repository/path" = "$(git url-parse -c path "ssh://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c path -- git syntax' '
+	test "/repository/path" = "$(git url-parse -c path "git://example.com:1234/repository/path")" &&
+	test "/repository/path" = "$(git url-parse -c path "git://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c path -- http syntax' '
+	test "/repository/path" = "$(git url-parse -c path "https://example.com:1234/repository/path")" &&
+	test "/repository/path" = "$(git url-parse -c path "https://example.com/repository/path")" &&
+	test "/repository/path" = "$(git url-parse -c path "http://example.com:1234/repository/path")" &&
+	test "/repository/path" = "$(git url-parse -c path "http://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c path -- scp syntax' '
+	test "/repository/path" = "$(git url-parse -c path "user@example.com:/repository/path")" &&
+	test "/repository/path" = "$(git url-parse -c path "example.com:/repository/path")"
+'
+
+test_expect_success 'git url-parse -c path -- username expansion - ssh syntax' '
+	test "~user/repository" = "$(git url-parse -c path "ssh://user@example.com:1234/~user/repository")" &&
+	test "~user/repository" = "$(git url-parse -c path "ssh://user@example.com/~user/repository")" &&
+	test "~user/repository" = "$(git url-parse -c path "ssh://example.com:1234/~user/repository")" &&
+	test "~user/repository" = "$(git url-parse -c path "ssh://example.com/~user/repository")"
+'
+
+test_expect_success 'git url-parse -c path -- username expansion - git syntax' '
+	test "~user/repository" = "$(git url-parse -c path "git://example.com:1234/~user/repository")" &&
+	test "~user/repository" = "$(git url-parse -c path "git://example.com/~user/repository")"
+'
+
+test_expect_success 'git url-parse -c path -- username expansion - scp syntax' '
+	test "~user/repository" = "$(git url-parse -c path "user@example.com:~user/repository")" &&
+	test "~user/repository" = "$(git url-parse -c path "example.com:~user/repository")"
+'
+
+test_done
-- 
gitgitgadget
