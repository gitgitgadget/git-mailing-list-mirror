Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9385634CF5
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 04:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728360530; cv=none; b=M0IHN1/ZIGEA7BCqOp69wLruzweiv7/9E1UV2NDDlKAad1ThwPmTe8rJqhT3mK+XmvFlwLh7bHX6yLjB/R7FhZaoQhU/nSp+zB9syaoT8grTnF+NNt1CHwFvkKlz/p8jku6M50vgxU+rMwpH6p+/UNXmPIv5XGeGqmxY7U89588=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728360530; c=relaxed/simple;
	bh=8RYp0vwuX7xY0xZn8/W4/+vSq0AjmEdYdGLey2svEfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DZcexoalJTG+7FWT2ekAkUlFrp1Ndai7eeak+vjFB2ZBrMWnt8NP7p59ml9T8Wcyj8j18dSlQaEtrSgxPZqcYOm2Gux71hsRk62/arH0wsgvonO5RHC9M7Xfnt2EQXZZLvY+0H1hRckDhDQzoL9+WTAZqSxn6lrbtGZVqQRhz+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJ2h1W1h; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJ2h1W1h"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ea163001c7so185441a12.1
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 21:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728360529; x=1728965329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxBvvl1+c1NNOvwsXwUfDLRmNxkJunp+KTH6AQr/BbE=;
        b=KJ2h1W1hHAvL+lnOpmKihcUE7Xm33pQz2WY1X31EDw6km7DD53y3oREzx7ttOrg2PV
         A5zO2JgecCFs2HG/+YHFAW+DYhgHcnZVYI2gChx+OR6wKOBU3nGkcxVrjLolEUQWk/4W
         br8eAZ1eogK5JwyyAq5SYTZGJHmraHBg8fwPgLOv6hCGHDKUdf6ZT5IsgmQyH8QdMTHG
         sV0rYzrgP2Ugl5h0X1nCqwOAaJs+EfwWLvsZ5W6O/bfb/+63ZQUEqvdkF5yN6Q42dItC
         k3O/kPLMFtSw0xU85QDwZV5fZXXPF3q9BEZCBz/sNDxvn29WZ27VynNnZYytSlmu0FHR
         YQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728360529; x=1728965329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxBvvl1+c1NNOvwsXwUfDLRmNxkJunp+KTH6AQr/BbE=;
        b=DGNzcvInlZLe0W4VBMVY4J4bqUJyMzD/FvPpoXt4bJniUgwa40vB5mUW8HFtzO0Xm0
         LHy3/ANxCswXPMMqK8G+r45VesHUoLDbItwvrGwxdwbu6jSYikkIyyQMeVjpJwcJwtOS
         InMSSo3oSweA/nGYHEEeFk8LpCATtZ3aa8i8zsW7wGVEfrJNp0fGBp5Hiv8BbdnGEzar
         fFXJtY9NvM2PYhUpMlGOAiylcUGqdRgYyV0piIWvd5vEVcG5fuRJDjG4X0gZ7BeYElev
         Q6YAfK3EUd/ApZ8Mg2aZpQp2AyUFYt5SsSF1dY1ZhDFwdKSLLZj/R23x5qKy76m3bAtO
         NHig==
X-Gm-Message-State: AOJu0YyR1pnQbERqqfLKOGMdSolT6cMNu9XIz0bC/PPgIalhpOH9Je/u
	yDDVvo7vnsO/ZSP/hbu2DCsHSM+FOR/Gmh5yTJFebVpyYGRNZ5qUfbgfvg==
X-Google-Smtp-Source: AGHT+IHEPQ+8LKAzBkZ2uZ2hvNh+YDWpEPDqlj4XUHEum0aFrU35AfI/9AwS5harrSvCq6UDHLj2+g==
X-Received: by 2002:a17:90a:de92:b0:2da:a6d4:fd5d with SMTP id 98e67ed59e1d1-2e1e620cdf2mr6964751a91.1.1728360528710;
        Mon, 07 Oct 2024 21:08:48 -0700 (PDT)
Received: from localhost.localdomain ([2604:3d09:e083:d900:fddc:a13c:16ae:b340])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1395a533sm47056035ad.204.2024.10.07.21.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 21:08:48 -0700 (PDT)
From: Josh Heinrichs <joshiheinrichs@gmail.com>
To: git@vger.kernel.org
Cc: Josh Heinrichs <joshiheinrichs@gmail.com>
Subject: [PATCH 1/1] git-config.1: remove value from positional args in unset usage
Date: Mon,  7 Oct 2024 22:07:49 -0600
Message-Id: <20241008040749.69801-2-joshiheinrichs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241008040749.69801-1-joshiheinrichs@gmail.com>
References: <20241008040749.69801-1-joshiheinrichs@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A single positional argument appears to be enforcecd at
builtin/config.c:993. Values need to be provided via --value.
---
 Documentation/git-config.txt | 2 +-
 builtin/config.c             | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 7f81fbbea8..3e420177c1 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git config list' [<file-option>] [<display-option>] [--includes]
 'git config get' [<file-option>] [<display-option>] [--includes] [--all] [--regexp] [--value=<value>] [--fixed-value] [--default=<default>] <name>
 'git config set' [<file-option>] [--type=<type>] [--all] [--value=<value>] [--fixed-value] <name> <value>
-'git config unset' [<file-option>] [--all] [--value=<value>] [--fixed-value] <name> <value>
+'git config unset' [<file-option>] [--all] [--value=<value>] [--fixed-value] <name>
 'git config rename-section' [<file-option>] <old-name> <new-name>
 'git config remove-section' [<file-option>] <name>
 'git config edit' [<file-option>]
diff --git a/builtin/config.c b/builtin/config.c
index 97e4d5f57c..d60e106bd6 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -19,7 +19,7 @@ static const char *const builtin_config_usage[] = {
 	N_("git config list [<file-option>] [<display-option>] [--includes]"),
 	N_("git config get [<file-option>] [<display-option>] [--includes] [--all] [--regexp] [--value=<value>] [--fixed-value] [--default=<default>] <name>"),
 	N_("git config set [<file-option>] [--type=<type>] [--all] [--value=<value>] [--fixed-value] <name> <value>"),
-	N_("git config unset [<file-option>] [--all] [--value=<value>] [--fixed-value] <name> <value>"),
+	N_("git config unset [<file-option>] [--all] [--value=<value>] [--fixed-value] <name>"),
 	N_("git config rename-section [<file-option>] <old-name> <new-name>"),
 	N_("git config remove-section [<file-option>] <name>"),
 	N_("git config edit [<file-option>]"),
@@ -43,7 +43,7 @@ static const char *const builtin_config_set_usage[] = {
 };
 
 static const char *const builtin_config_unset_usage[] = {
-	N_("git config unset [<file-option>] [--all] [--value=<value>] [--fixed-value] <name> <value>"),
+	N_("git config unset [<file-option>] [--all] [--value=<value>] [--fixed-value] <name>"),
 	NULL
 };
 
-- 
2.25.1

