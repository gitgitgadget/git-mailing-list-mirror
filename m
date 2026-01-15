Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE86C293B75
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 23:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768519126; cv=none; b=UkXqakfjOtIfQamC5X2GpiLiFWjO7m1mBsojAc6pQ9j3nwyd9LADlDYilO9fhLHWZi5qrJfN+LAeP+5GH9f+OeKnwXCk7ZE9ytIb8ahXXtf+uGDh3HodC3/Khbddjzx2NRWkZmrhjoH1743pg5qYDgvI8A5j8vC+f6y/Rfnz0dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768519126; c=relaxed/simple;
	bh=NlaHTLt5aFv2KaC7Lrv2oKkUy22T1rrmHaU3BZA/1Lg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ehvvCLldEIQ1nqDtTmtv+SH3vbyXve4FKA/vN6dI1O/Ci8L+0Q3C7Vc9u/Q+BADYFofL9L3YsKxUeOMnsBqz/yPUQrJnuXQzWmYq6E0C9rlqwx2+KgJeuRf9qJlKWGQSSCjNdMPagmO4I5JbNe7JQ80FVjaQtwG3VvIBl9aIocM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgTrbExl; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgTrbExl"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-457c1148a5bso577401b6e.1
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 15:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768519123; x=1769123923; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MJ4xXcqZpD3fobelMtSgMsQnMHQ3H4YfSN81/sQArM=;
        b=cgTrbExlsPex8atNtxU2jQnEisIKvU4qLhhy5lyx0XXvGs2eW4kgQPhNv1pjtxxsyL
         VAREACTjSbhw2yM2A3kDU35obfD7HOIrtOWKDJyag09Gf3IfGp1tAhDgnEL+bjbIzFoI
         EHwqEANdOXWuBLrvVSc78zl/gIo6WImwg5Z0UuLWFadz/9YI5bisYYF3HVcRikR7SPtZ
         guJR2iGxHz5DyzFMplq9R2XC+enKVmNvPmvA20jGiyhozsJlPTLf99hYPsMpvfTpPcL5
         ++MclP/BbpadHc2AQE0W4nMJeRw0TLLY9l+9SJsGQFntypMoXPp74Vbz2wKDZlTgoOc2
         6wHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768519123; x=1769123923;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2MJ4xXcqZpD3fobelMtSgMsQnMHQ3H4YfSN81/sQArM=;
        b=uyoqmXWgB4Uc0Ld+2CSs4wnDqEI3gAade67A6TyvrOUt/A+i3gJ/oVMYPVh0K/4GMV
         Ew03Ouek69VWT6P3X1MD3o+ek7kcqqrtSiSDDGmtuj9wjITtBXOA7Ght1PjAtADo7WEB
         GEe+AjK8Ahpq+rXE+gpPq6eCf+eeUe+cOJBpk0673Zkji+yQ1ab9rztECR3lSRmhYT4o
         9oPHoAKLDJ5jxRpPrI5kAbr4Pn6/qEd9HYkuwmzdrgeWN0L+I0di4HltPx5HZpCOHH4O
         AFnGZfDWq+Xe7ByA1BIzZIbeduvqJrkZyh+cmlDkzHEKnkMuxzy86zvF4AorhzZL0DNm
         ha/A==
X-Gm-Message-State: AOJu0Yxf3QKKaOngVR0/yB+M1vPM0s6DlFbFlX6iOTJCyy7vnL/K9V3L
	AntBEu3EjOdithQJf+f42ivCRnYW+CGjN5e+ldOy4Z8s1/hXj/GrjX1qY1vRYw==
X-Gm-Gg: AY/fxX7U76wDT5WIUoMReRLSBq+0ct4JTJ+iTOTlO9wW9Qt39SaSvM2uKEzH5iIBcPN
	i+LuulrdaPJjj8JVCybYzBwqWfpawoP6vF56ShWdeQg35MdZuxfvfyHajqGvukMLZYKCuEaZ6Fg
	FjGKjpS5i8pAUGXIwbqqqok0UIcIVtfzn8YdUmjn5UlHktd/qK/AtULl1gRY9eVZp+YlkQuRF/F
	70qyxC60Jsy5V43AlusA1h9aI58y9XIFbL/G4mB8kZMMKXnafU6leEdKKzZ34MC5O6OtxAj6d6b
	mQ1IhFnIiApwfWEzDXxe2+r36GnpinqTEjSXt5aV5/8nKT/LoPTl/unZci1luAVTT6dm59ECprD
	358FGUuto0A70hobHhq5vdAAxDkiiPCANqxSbQRZJQyJFNWczxTWol7lItb/IPtvAK6mnxPnl0X
	sPaRAgsjPIpKRB
X-Received: by 2002:a05:6808:221e:b0:45a:6ef9:79 with SMTP id 5614622812f47-45c9d86c3acmr390852b6e.52.1768519123313;
        Thu, 15 Jan 2026 15:18:43 -0800 (PST)
Received: from [127.0.0.1] ([132.196.32.74])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45c9decac58sm436247b6e.5.2026.01.15.15.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 15:18:42 -0800 (PST)
Message-Id: <e20ac5b6a6257e909fc676f6472230540268146b.1768519120.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2000.v3.git.1768519120.gitgitgadget@gmail.com>
References: <pull.2000.v2.git.1764211096.gitgitgadget@gmail.com>
	<pull.2000.v3.git.1768519120.gitgitgadget@gmail.com>
From: "Johannes Sixt via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Jan 2026 23:18:39 +0000
Subject: [PATCH v3 1/2] userdiff: tighten word-diff test case of the scheme
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

