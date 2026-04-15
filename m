Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B908246BCD
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 02:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776220071; cv=none; b=GIPJQL6Nc/mFFbZpqu9lwmn82mymqI4Gfwx/h/y08s2yWLp6GGfbQwXU3dqF0505p0x16VfN6bcWLoVsr0hWoOXTpft167HY3snedd7g/K+xRIyX2FwHrvnq5RJG43YeumKDxMnChJrNBNO79eQY81hU5X5UAHmrz3yXaQgK9zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776220071; c=relaxed/simple;
	bh=NlaHTLt5aFv2KaC7Lrv2oKkUy22T1rrmHaU3BZA/1Lg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hgoFLPWG9NxqTJPCyS3r7Fe/uMtuz4ms8kQrnQozH2gzWnYNDNXzCxFMlS/5wjEKYECelmWkLummuhgOoDwXhoq8W79lB8haP1IGfPlDDrY+hWz4Vm10tP7lEo2U22mSQvqvrfyaA0LAUtioX0q0dy9SroEKtWg6sIQFgjRkbvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2h6UyoA; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2h6UyoA"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50d6b9bca48so81916601cf.2
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 19:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776220068; x=1776824868; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MJ4xXcqZpD3fobelMtSgMsQnMHQ3H4YfSN81/sQArM=;
        b=g2h6UyoAMJjwwWxUAmpFowPswquR2Ch9Quv+zm8Ab+pqLzFqpVSrQfHE+hzFeTmkBU
         c+EtfUgLQkdhwl4u3fL5GtyBJbnLtpVHiO3SOEgwO0vaZibNOOlB5Tr4jH/2zQYAUPra
         QipmU7sAQu7LkTcFGIlfdSiYxYktecN3vbTRHC6Pgm5twGLRTsl5tNs+1TNdfIXrev00
         NbMEakdA9nDtBnf+6nfH+X0QrhjAZYwV36hmFqOPkEHwbOWKgwIKqBgSlNB9a8tfmeYI
         6SPSPaVtMsnbiwJ3FvTvRmC1jLibUz74ESDKUlVZrYFHc99jm04lcBYel9m8xlhScML7
         YH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776220068; x=1776824868;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2MJ4xXcqZpD3fobelMtSgMsQnMHQ3H4YfSN81/sQArM=;
        b=dvw42+q0tHoMORV42fFduBsDCc6/5H0qc61cuB6OhrrI+QdO58Wuocj1g2NH/PeDdS
         qzSPdJpX3NhwrJI0gPyyJRx1KtYHi/b6xZrGlxdn37cE+LAKBbnXLBAzzLrtWhb/jKC2
         9/WGQodvxhwSbWM3q2NhwqAx6qKgcq9ZI/b48k2+djVo/BfcRK0UGcA0zEzNl0aJYcUe
         dKXJpHYgeyD6E2OGmQSjVfQRZcMIz6CVa/ea5WEOCpOHKZFfMV1L/kk6Ze1UiDF5U5b7
         F9bhlbl/7ZkmG+atVQ8h/7mRx5Jhm5FDuXeAHl47Zh/GotLZQhmJrGx0ln5IE7w4CYhl
         fZNg==
X-Gm-Message-State: AOJu0Yw81O8JHSY7ezlKEpQHXg9US8eIdGZ9iyoVJ+lxJs8BEJDhkdY7
	Jf4G6LDDmlxwRAUOCcs8xBRbq0418RHl4LrhyrI0nL9KU/Hq8XA0MRQuiihBlw==
X-Gm-Gg: AeBDieu3kpWDtoXDi4KIq6PtZ1CFrispucs57au3Dmig1hhk82fArnnCbNtFHMY0TXd
	avy/Qvn2ViYTHwJWbwr9q2ukZK7fXUAGj3FwUdteET2FCkqUD5RSRbeu7oP4Gr3Hn5fxHfOeFPx
	57qRKdRdtNXd/SN01RaDAQdXapL77Li2Op+ndv/mBp92E0ZIK9DyDYo6asRRC6hlUQfusx/xU+E
	J8mF+0GPYjzYjRe/o6Evgt2XtckcTpiirIm+cWj3EeSKrbCqX+AZWp/JqbuvfAMDLxyoKzfK7HY
	KRXqQUFhFYIVKCrTqSEnIF/fl2ynR1ifDR8MNYkhwdQJPG/t+kx/TORADo1ZiZBW++lTPzw84e4
	1SeUswmtWJeZZYN8loBGn4ZpjGCyF3a801WHBgv+Y5aGwUfFmpyseDP5ii/SYJLnSa2g2prQ7Ye
	prCN+mTiYniQqo4aCCay56pCaSvZvehRDLJyMB1A==
X-Received: by 2002:a05:622a:2295:b0:50b:47ae:8abd with SMTP id d75a77b69052e-50dd5b96015mr298929041cf.2.1776220067587;
        Tue, 14 Apr 2026 19:27:47 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.201.35])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1ad9663bsm3704221cf.4.2026.04.14.19.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 19:27:46 -0700 (PDT)
Message-Id: <8e0b1e3d013ee379335bc89801525a861047929d.1776220063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2000.v4.git.1776220063.gitgitgadget@gmail.com>
References: <pull.2000.v3.git.1768519120.gitgitgadget@gmail.com>
	<pull.2000.v4.git.1776220063.gitgitgadget@gmail.com>
From: "Johannes Sixt via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 02:27:42 +0000
Subject: [PATCH v4 1/2] userdiff: tighten word-diff test case of the scheme
 driver
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Sixt <j6t@kdbg.org>,
    =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Jaydeep P Das <jaydeepjd.8914@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    "Scott L. Burson" <Scott@sympoiesis.com>,
    Johannes Sixt <j6t@kdbg.org>

From: Johannes Sixt <j6t@kdbg.org>

The scheme driver separates identifiers only at parentheses of all
sorts and whitespace, except that vertical bars act as brackets that
enclose an identifier.

The test case attempts to demonstrate the vertical bars with a change
from 'some-text' to '|a greeting|'. However, this misses the goal
because the same word coloring would be applied if '|a greeting|'
were parsed as two words.

Have an identifier between vertical bars with a space in both the pre-
and the post-image and change only one side of the space to show that
the single word exists between the vertical bars.

Also add cases that change parentheses of all kinds in a sequence of
parentheses to show that they are their own word each.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Scott L. Burson <Scott@sympoiesis.com>
---
 t/t4034/scheme/expect | 5 +++--
 t/t4034/scheme/post   | 1 +
 t/t4034/scheme/pre    | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t4034/scheme/expect b/t/t4034/scheme/expect
index 496cd5de8c..138abe9f56 100644
--- a/t/t4034/scheme/expect
+++ b/t/t4034/scheme/expect
@@ -2,10 +2,11 @@
 <BOLD>index 74b6605..63b6ac4 100644<RESET>
 <BOLD>--- a/pre<RESET>
 <BOLD>+++ b/post<RESET>
-<CYAN>@@ -1,6 +1,6 @@<RESET>
+<CYAN>@@ -1,7 +1,7 @@<RESET>
 (define (<RED>myfunc a b<RESET><GREEN>my-func first second<RESET>)
   ; This is a <RED>really<RESET><GREEN>(moderately)<RESET> cool function.
   (<RED>this\place<RESET><GREEN>that\place<RESET> (+ 3 4))
-  (define <RED>some-text<RESET><GREEN>|a greeting|<RESET> "hello")
+  (define <RED>|the greeting|<RESET><GREEN>|a greeting|<RESET> "hello")
+  ({<RED>}<RESET>(([<RED>]<RESET>(func-n)<RED>[<RESET>]))<RED>{<RESET>})
   (let ((c (<RED>+ a b<RESET><GREEN>add1 first<RESET>)))
     (format "one more than the total is %d" (<RED>add1<RESET><GREEN>+<RESET> c <GREEN>second<RESET>))))
diff --git a/t/t4034/scheme/post b/t/t4034/scheme/post
index 63b6ac4f87..0e3bab101d 100644
--- a/t/t4034/scheme/post
+++ b/t/t4034/scheme/post
@@ -2,5 +2,6 @@
   ; This is a (moderately) cool function.
   (that\place (+ 3 4))
   (define |a greeting| "hello")
+  ({(([(func-n)]))})
   (let ((c (add1 first)))
     (format "one more than the total is %d" (+ c second))))
diff --git a/t/t4034/scheme/pre b/t/t4034/scheme/pre
index 74b6605357..03d77c7c43 100644
--- a/t/t4034/scheme/pre
+++ b/t/t4034/scheme/pre
@@ -1,6 +1,7 @@
 (define (myfunc a b)
   ; This is a really cool function.
   (this\place (+ 3 4))
-  (define some-text "hello")
+  (define |the greeting| "hello")
+  ({}(([](func-n)[])){})
   (let ((c (+ a b)))
     (format "one more than the total is %d" (add1 c))))
-- 
gitgitgadget

