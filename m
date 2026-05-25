Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448E53559DF
	for <git@vger.kernel.org>; Mon, 25 May 2026 10:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779704914; cv=none; b=cuYODF7HkN4OaeVegPcYSJeeZCS69jpfTdD3Pm75kMBoV0qDkkBuvJEmTV2EpD7mcErhx/5FKnMRYEO8T3XQTy9Mm9GO6geQ4WsiNaKgl4Y9RNL1fTXafgPUA5GBG/5Q1qxb2dH4jep315GIqv1CaLTRU8Ue2lMcWmmM/XF4g6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779704914; c=relaxed/simple;
	bh=Nl3nLsEf54lhK5ujPpbZ8aHvOCtHqndLQQwfvq5OGm4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=SoCOmQV8t1FQoGzdvxkqeKU1sJzHXeoWDdxsoFO8YBqYdwMEp0Bs4NSAxzbzvlA1FSYcKWo4aZjeaALNXfHRdJbX1gtX1vyo9VbuIhO0QEX0x4dPIfVgOXXfp+JYokuH2YAxNCTbs6B+nZf3KkBcy1FXWq/aRYzMn0PyZoDv8Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6Z9tZ+5; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6Z9tZ+5"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8c921396e37so97674816d6.2
        for <git@vger.kernel.org>; Mon, 25 May 2026 03:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779704912; x=1780309712; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gh8fQPcrZz6tu5vyJLMa/v7ou+QKZcdubE9ixTVuCLc=;
        b=L6Z9tZ+5MGMiYE9jebFwNwTEz1IalsvCY9SF/5r2yo+ldslwi+UCYnG+LIx+ABUb6b
         w8Ah9Q14g3jLmBIWYwxgLEmJQBwvfo/rW3i0tTIo24BzT3PLBugNgqq3hJcmM+mDL5ly
         boQPsoN8CNpdT/WvJvOjH599dJKFg9lIlZQB/yTdp0tbS5ergrWtDJjlJf+qzaExwZ0H
         G25IQFQkELo7uoxzqcUfJEcoPp7dvWkwbtxYTQkDRQcwhzS3CIEQ1G3UZpzYHUR7fXzu
         +AUaMTQsBK/adxIzmNZ4RHtYYWCPB/+pjGGzJXm+ykx994vqVnODipsQUzlESYaaNAln
         7sFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779704912; x=1780309712;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gh8fQPcrZz6tu5vyJLMa/v7ou+QKZcdubE9ixTVuCLc=;
        b=BsGwtKa73XnZqGP5K+aLBH/S19dcVCkOrlMObue/5mJBTzJfi2PgVAsUcUhaVWH1Np
         6xil8F7Y/eF3RR74ld8SVXWzWhSNLry7PfJg3bIZXpSIUo3xBiAL+hwsgbwmxyf7nP3h
         mo1FppocNSoaMGqPA9tF3g7m1yzEYvfZu0joazBKmEYwGsB1cj54ORgrSkooDqpjGm+6
         hMP0OhW00vwB1z6MfvTIC0gd40xDDUju6yb5x+XG1YQtgXR0IfjFaTdPWlhtyrGV+xIR
         sY8coJs2+0rAOStNP2LtTE/kl0lru3fhBaMO1LSvO1aYFIlVCMS/waHsqRou5zeAis1V
         AH1Q==
X-Gm-Message-State: AOJu0YzYBSd3u+FgPZtA2LGaFDC2SFM6ZKTh/QDw8SspsIGZhGwDCmAl
	LrMn/eFWeqi0XFpUtMT1FhEs0RsnES+XR7qgnQ1d2B9wDp1fofDqbTbJ0a3D3ftx
X-Gm-Gg: Acq92OG7aHsiBedUbALM8OzldZG69PqrsnksasjqR3bwAz/apz2siHr2VhtioHe8mt0
	NmLaxBwbTLoB/BwHtrC3CBGH+iUpo9ysa9fTUm73f4hoeWAtxowpiFDMjPY4WebtlQofxB1G2Z8
	wleO0RlMA3+rUhtWh4eUXty2vCrtfuBlWU/RhH3Sx6LymT6xlmHRLd2TPexOPfZ4BWlMiIPoean
	o1znogtLyS5I/LaWqg8G64dkRGOmkTHJmWqIQtwomXxZr/KdNkXopo0sgghkLJlWWgHUlgPIhr4
	m4Jqqj6QGXGa6vZ6L/r63trG1pdfrsU3lMmGbD7YbKH+KzkeJWjmb3gV7MpNsjVDzT7hXUiU+LN
	AwO6/rNFZxtuNk1xGHYS0Egeo9LbK1jHFD8wjE9FRwnCBoaYUnIUjC5ciCJB7qpkrQzd6DmjWkj
	4uAAipeawuzAmFGqm7Qx4QMGwWdQ==
X-Received: by 2002:a05:6214:43c2:b0:8ca:b44:ec0f with SMTP id 6a1803df08f44-8cc7b5de943mr217997656d6.36.1779704912277;
        Mon, 25 May 2026 03:28:32 -0700 (PDT)
Received: from [127.0.0.1] ([130.131.15.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8130d540sm105746446d6.38.2026.05.25.03.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 03:28:31 -0700 (PDT)
Message-Id: <4fb33dd4407a51c5ece6fb467e98c4da1ffa6f0e.1779704908.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2117.v2.git.1779704908.gitgitgadget@gmail.com>
References: <pull.2117.git.1779049615.gitgitgadget@gmail.com>
	<pull.2117.v2.git.1779704908.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 May 2026 10:28:23 +0000
Subject: [PATCH v2 2/6] doc: git bisect: clarify the usage of the synopsis vs
 actual command
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

The difference between a synopsis and an actual command is that the synopsis
is a more abstract representation of the command, which may include
placeholders for arguments and options. The actual command is the specific
instance of the command with all the arguments and options filled in.

The formatting of an actual command is a code block, with the command
prefixed by a dollar sign ($) to indicate that it is a command to be run in
the terminal. It can also include comments with a hash sign (#) to explain
the command or provide additional information, just like in a regular
terminal session.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-bisect.adoc | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-bisect.adoc b/Documentation/git-bisect.adoc
index 4765d3b969..d2115b2990 100644
--- a/Documentation/git-bisect.adoc
+++ b/Documentation/git-bisect.adoc
@@ -96,9 +96,8 @@ Bisect reset
 After a bisect session, to clean up the bisection state and return to
 the original `HEAD`, issue the following command:
 
-------------------------------------------------
-$ git bisect reset
-------------------------------------------------
+[synopsis]
+git bisect reset
 
 By default, this will return your tree to the commit that was checked
 out before `git bisect start`.  (A new `git bisect start` will also do
@@ -108,7 +107,8 @@ With an optional argument, you can return to a different commit
 instead:
 
 [synopsis]
-$ git bisect reset <commit>
+git bisect reset <commit>
+
 
 For example, `git bisect reset bisect/bad` will check out the first
 bad revision, while `git bisect reset HEAD` will leave you on the
@@ -174,13 +174,13 @@ For example, if you are looking for a commit that introduced a
 performance regression, you might use
 
 ------------------------------------------------
-git bisect start --term-old fast --term-new slow
+$ git bisect start --term-old fast --term-new slow
 ------------------------------------------------
 
 Or if you are looking for the commit that fixed a bug, you might use
 
 ------------------------------------------------
-git bisect start --term-new fixed --term-old broken
+$ git bisect start --term-new fixed --term-old broken
 ------------------------------------------------
 
 Then, use `git bisect <term-old>` and `git bisect <term-new>` instead
@@ -328,11 +328,10 @@ Bisect run
 If you have a script that can tell if the current source code is good
 or bad, you can bisect by issuing the command:
 
-------------
-$ git bisect run my_script arguments
-------------
+[synopsis]
+git bisect run <cmd> [<arg>...]
 
-Note that the script (`my_script` in the above example) should exit
+Note that _<cmd>_ run with _<arg>_  should exit
 with code 0 if the current source code is good/old, and exit with a
 code between 1 and 127 (inclusive), except 125, if the current source
 code is bad/new.
-- 
gitgitgadget

