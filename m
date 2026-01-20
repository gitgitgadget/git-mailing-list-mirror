Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D2DB665
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 01:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768873681; cv=none; b=psU7gOIaSchGieyKEIhESk5UOYvyJSc4bdu6cmVOHv0jJz004SosYnR0K3GcvWY/B1VPH4RQ+khLGE1BNV3LeFcmUtb1jAbGI2xPRVwVHo3UX8t493CaKzPdc/g6YxaDP3jIRbv3xHn8BLmxvvAXXInl1PW2Y4ozrigJqbcarFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768873681; c=relaxed/simple;
	bh=n1g9r6hJBg8YrobRWs50UkmJ+ai6RmaoneKa7g2hZiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DKybKTVQwuhKTLnyDQtPfbva34ve8cobPOIK0azXGgJGxJGvZe0KYU0VSLhz2efD3q78EpojJquvfvLjaMiVZu9jO6yOhasgbape6LMAGDa/nDf5FxKeaIZPLUndJJ1Rrchi9ZQ/bPifq+3lbCwjt0oDV5Tz7yh7xF3axsDPvKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSxTtXFr; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSxTtXFr"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79274e0e56bso45476437b3.0
        for <git@vger.kernel.org>; Mon, 19 Jan 2026 17:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768873679; x=1769478479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=mMUl2WR4R/Zj8nxUH2/Lqcml2L6JzEE08oXWCtJ8IGg=;
        b=iSxTtXFrNJiPwIQN7jvz1UxdsoJgG3RpahCvew7aR9ZQiNO4lCBCPwihyTVnEPrDX6
         fPnqBYSFIH8QY7wMm7ffKu7XAWnOlB7uAa07VM0ESu08WSglv9JaTz/3938/DziRhnz0
         lEspgGnob38OMpgHA9MdMLleNGAWmTjDxfATk8mtK3xjDgAnwZdi1j4F+192jB7xr7gb
         EVbe+9uHuX1LjFO1x0kVpKSYm0S54uKqua/8cidUJt26JT6KJWkEX4tuO/2RBZ8VAOP6
         3vdUwtjLLA6wPbplMgBSaxpRzsmvtS+3HHvcGNxJDjSZOp0x0SJyuSVrJx1GS1Ehbhxo
         r61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768873679; x=1769478479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMUl2WR4R/Zj8nxUH2/Lqcml2L6JzEE08oXWCtJ8IGg=;
        b=JLfFAm32PuhDam0aXdL8v17FnLlN0EQuiZCmloQQrhVRIiDiAGAw4m1cPqt/KdRj8f
         YjVIiRnP2zU8d+jSEVrU6QPjfydJEKg1BLHIQVF9SO698ZXmRhIZAQk2JW0exUok6Hth
         YNcPtu6C0ShvQUe1+ueZHOTDPU3DT1cpCQ7JRYk2nGk/p40YpJAMy+4V/ZUREymKootU
         p6xWcgLp4j/2eW5HdN1CO5++IZyrukv3hHqzsXLeWqW2JoH+pBMYF9tOp1hfmNZ7c/uC
         +6/4zS3BkQuHS2gxHKeQdqXmQ/rUNE8DoVZIartQpVRzCspzAVZrhrj9QPyLwFkHsRVe
         5AQg==
X-Gm-Message-State: AOJu0YyX2IuaX5+rZdKrar2OO9+ucXE7RhidG1SrWkHCjLuOP2ck5xog
	YoC+EZ2VZNgnVWN3wY0kwOc9/kN3NFraNz97jmWhvz572RX1DREfwPdkSBNsaQ==
X-Gm-Gg: AZuq6aLOOuqaVgQv2QxOkiUo5KzgANafAyPizsKUnstPwofun7ny/DXTrY+3yodFs5Q
	8Eb8SbpI2u0p1++3+D6aYHH516tLXPqgOu0h7FQ/853EmYUGuxdbF3H927J8ovHZA/QIEr+gyCJ
	/DOpJKBxSE6NbkOW3Do9aoGOaCqVNErJmTP46NQPQ98Tcc+UeshH0suF/Wkl4edrqjHxvqLtnSb
	6hs+CMz+bnTMyBI3q4ForT/+UcIz6Rm7sEocxQ90yGJsAUYjpYQMtmdp7gS02RBFPXEbdc8muRj
	Up+DQEJiEk/PnSLZ4Yr5mW+Nl0fKNZQesTjYczFqwxj2Iw37kcxDRCP2nutZxkU7MGgXUq8M4VQ
	nrAb0cUM4LlgdgcoaLzdWno0D9iGxmjDOpvMAa3fz7SJUH7DnLVMfGfVsSO8T7DW470MFYX8wHJ
	ZH5Zl1jScFS9eP7kufWqJemWqsz+JcXEgF6nwJUN9c7iSKnJwV0sjzq1wzoUTGWZcrcQhzc4qwK
	5JtvFYCi8CiZRA=
X-Received: by 2002:a05:690c:fcc:b0:793:995f:25f9 with SMTP id 00721157ae682-7940a156b01mr4299687b3.28.1768873678873;
        Mon, 19 Jan 2026 17:47:58 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:90a8:8b00::a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66c726dsm47504387b3.8.2026.01.19.17.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 17:47:58 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Sergey Organov <sorganov@gmail.com>
Subject: [PATCH] replay: drop rev-list formatting options from manual
Date: Mon, 19 Jan 2026 20:47:29 -0500
Message-ID: <01a7acfaf87494419b3766da57d4c05cf99c79bb.1768873599.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.52.0.rc0.569.g0e1cb519e9.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rev-list options in our manuals are quite long; git-replay's manual
is no exception. Since replay doesn't use the formatting options at all
(it has its own output format), drop them.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---

Notes (benknoble/commits):
    I noticed this while reading. It took me a minute to find the
    Asciidoc reference on multiple attributes [1] since it's not used
    elsewhere in the rev-list include :) I'm not sure it needs to be
    included in the commit message, though normally I would, personally.
    
    [1]: https://docs.asciidoctor.org/asciidoc/latest/directives/ifdef-ifndef/

 Documentation/git-replay.adoc       | 1 +
 Documentation/rev-list-options.adoc | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index 4c61f3aa1f..c3b214ec69 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -64,6 +64,7 @@ The default mode can be configured via the `replay.refAction` configuration vari
 	range should have a single tip, so that it's clear to which tip the
 	advanced <branch> should point.
 
+:git-replay: 1
 include::rev-list-options.adoc[]
 
 [[output]]
diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 453ec59057..c4d7a6b989 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -1096,7 +1096,7 @@ endif::git-rev-list[]
 	Overrides a previous `--no-walk`.
 endif::git-shortlog[]
 
-ifndef::git-shortlog[]
+ifndef::git-shortlog,git-replay[]
 Commit Formatting
 ~~~~~~~~~~~~~~~~~
 
@@ -1265,4 +1265,4 @@ ifdef::git-rev-list[]
 	counts and print the count for equivalent commits separated
 	by a tab.
 endif::git-rev-list[]
-endif::git-shortlog[]
+endif::git-shortlog,git-replay[]

base-commit: b5c409c40f1595e3e590760c6f14a16b6683e22c
-- 
2.52.0.rc0.569.g0e1cb519e9.dirty

