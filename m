Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC8613B584
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 12:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783946537; cv=none; b=rdH8+FUIVtN5bOwC/qVqY79qiVkVAD5I3RSZQm9QI1wAw6mYOuMIhPPaJ4kxpGf4iRFxKDq9W9IFLRmeaWtRVF4s73C5uT0GZhJKy6ydAuDUenb6uyWZWhGbqXDi/PqsPwm6yDrr/APz6+amjPPo9cdQ3geet7Az8a8gYWL0vOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783946537; c=relaxed/simple;
	bh=FsVvHAjRjxhnnZscrZEmupz2PxWo5JPeVfz+avvxxDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BauCwYx/YIvX7ObCm6uLVe49TQ/qhuQ8kw6iZZNWVKMC0yTGefp6DWMeGDCuwu2fqWOf1HawiQ7hOaNdEfK8D0c6KeEDwBmw4t5G1oFVi0TTJXfDbiI6PSHK67r+wfbz4EIMJZrpSGxx06Ro/Ln1ZQiZGNbvJ+0um5bWhRmZlLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3UqGWwQ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3UqGWwQ"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15f020a223so405438366b.1
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 05:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783946534; x=1784551334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gVKcuYCrloEio+4ZuD2FzkbvqtelWGPKDg6bcKWDwP4=;
        b=W3UqGWwQIU+d6oiw3t0gUvV+WQGI9qSuStTjkiPuM8Bmvqad/CshpXa3wXAj02ArmF
         7Bci7ivl6KNoDpiEteHHy87LXHvOC6vcra+0pNRBCU5XaH0mlSj0Kk1wJ0kVpbGUvZCP
         qOtXes2jopxG9wi49tb5dHrjxxCIDnB6lWU4LUarKtRikUP5h6rHd1WPYhwqn/Dinwtb
         91owaQROEn3vbA1ID17mKW4icynl9u1uaRG3C0o20FoQDI5IPKvT3LeE3F5CjOQf8spR
         yFQ8ay/K2nBpiLeDUpMFiwMRJVqw5f8dLGyWBLFYNCA6PvZaICYjM05mrpeohf/p6IIm
         Qh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783946534; x=1784551334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gVKcuYCrloEio+4ZuD2FzkbvqtelWGPKDg6bcKWDwP4=;
        b=l0VjwvD3l/tXNkIcXxI3XvWQZBsq2trHwHpQOXOkkPIL1x5l/c5gusE0N1R0VzgAKm
         gFgSrM3Ub0QBpa5TiWc2VMZTRHk6KAh8eX8Tz/HTqTEvkr+VS+9ULe8zGpC5i4tc6FcO
         V5qDxcY+PindNM58RvscTpjeRngYLuJw7BwcKYWElovsrt4t8Y6SmigLSVzwx/lcRxs7
         TVXMEbuqr1CbMStMoqKjcLgY7qV9vISY+KnNMqhkopm0w0evXc1o4WQrifG/+u3liM/E
         kQZdPwPwvzVtlcChcZ1RozkQMU4RTaE7GL4JSznojPiMy0Z60IOuCR5kg+wHr9nsLE9E
         zICw==
X-Gm-Message-State: AOJu0Yz7tsuYHaDsHJ7buNy58q4ZyJl3PCf5A/ALl3TkRAq/sq0H7KJt
	SdkGIoP2A53sCjcgjco54wOuNp/B5xkfrfKYNb/21IPNzUoARKMDio8X+HVhI5Z0
X-Gm-Gg: AfdE7cktXOvNsOGAqRnPqs0BJbzZKz4b8scZK15uPl0nZ/KnwwThqLVECqlkWPTKclD
	V89gBf0AAQjZ/0VvTljRbwQcno+87JLxY3st6JH/XZL0hB+H+8AeG7N389rStLIoP0wBthe2Qte
	AKSA4lkXpWYu/nQMwQC0vG/vaxSnTo1j8PJFUr7Zn4KL5S3dbNW7jMdhJzhuxFQtquJGgjNNVj/
	209X4GMHTKNhshpkiYY7O27G//68IMk4MCzRBHGI2xvM/GXow05wsrCE3SzvR3nbDQTqJgmWkhe
	KHktq8xqHzZWa1hsZ+QDpzPRd7QWFOuo/L1BmtzmzXSCuWdSv4fL79GeUbOQ8pLHFJTkDORgZPK
	7KlsTJ8HsOO/lafjwW68GM5gcQZEMFJnS1oLyIeHCLMuw12Xxo7JxPQ3MHHokynZRrb3C1GXy1e
	23QNNVId3aGSFRwtjwCIxMAZTuFpE9wo+8jcBIeOHPClVTSq4RP14FEBZFwuVI+p2G7Dtbx9Hwi
	yyWOXaDRIgreVUyMNOqawcJN/9z
X-Received: by 2002:a17:907:cf87:b0:c12:51d9:bb78 with SMTP id a640c23a62f3a-c161e9b313cmr420017966b.28.1783946533620;
        Mon, 13 Jul 2026 05:42:13 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ad844cacsm1017096466b.19.2026.07.13.05.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 05:42:12 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] fast-export: standardize usage string and SYNOPSIS
Date: Mon, 13 Jul 2026 14:41:53 +0200
Message-ID: <20260713124153.245268-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.124.gac3b7a3d2d
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The output of `git fast-export -h` currently starts with:

  usage: git fast-export [<rev-list-opts>]

while the SYNOPSIS section in this command's documentation shows:

  'git fast-export' [<options>] | 'git fast-import'

Let's make both of these consistent with each other and with other Git
commands by describing the arguments with:

  [<options>] [<revision-range>] [[--] <path>...]

This takes into account the following:

  - `git fast-export` accepts both rev-list arguments and a number of
    genuine options of its own (--[no-]progress, --[no-]signed-tags,
    --[no-]signed-commits, etc).

  - `git fast-export` was the only command using `[<rev-list-opts>]`
    while many other commands describe their revision arguments as
    `[<revision-range>] [[--] <path>...]`.

  - In the DESCRIPTION section of the documentation, it's already
    mentioned several times that the output should eventually be fed to
    `git fast-import`.

This also enables us to remove fast-export from
"t/t0450/adoc-help-mismatches".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---

CI tests passed:

https://github.com/chriscool/git/actions/runs/29245342050

 Documentation/git-fast-export.adoc | 2 +-
 builtin/fast-export.c              | 2 +-
 t/t0450/adoc-help-mismatches       | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fast-export.adoc b/Documentation/git-fast-export.adoc
index 297b57bb2e..719aeca244 100644
--- a/Documentation/git-fast-export.adoc
+++ b/Documentation/git-fast-export.adoc
@@ -9,7 +9,7 @@ git-fast-export - Git data exporter
 SYNOPSIS
 --------
 [verse]
-'git fast-export' [<options>] | 'git fast-import'
+'git fast-export' [<options>] [<revision-range>] [[--] <path>...]
 
 DESCRIPTION
 -----------
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 0be43104dc..629d7c591a 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -33,7 +33,7 @@
 #include "gpg-interface.h"
 
 static const char *const fast_export_usage[] = {
-	N_("git fast-export [<rev-list-opts>]"),
+	N_("git fast-export [<options>] [<revision-range>] [[--] <path>...]"),
 	NULL
 };
 
diff --git a/t/t0450/adoc-help-mismatches b/t/t0450/adoc-help-mismatches
index e8d6c13ccd..c4a55ff4e3 100644
--- a/t/t0450/adoc-help-mismatches
+++ b/t/t0450/adoc-help-mismatches
@@ -12,7 +12,6 @@ column
 credential
 credential-cache
 credential-store
-fast-export
 fast-import
 fetch-pack
 fmt-merge-msg
-- 
2.55.0.124.gac3b7a3d2d

