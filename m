Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAC2198A24
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727718038; cv=none; b=mOhfJDuX+Ecd8Lg4QQiSkXTo6Ds4R8XywHiCY8c9un+THXmLWrNRTQxZPkEgN0+dfs5CuBP+PRfA9BzDYF3glJd7F8mQMOggGBIYBPEF40xf4lLwZNhlhfrtvmO08TGcvhisxQug9IN4Y6iAOJsUpb5/KHnDCgSsCQMP6aPW/NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727718038; c=relaxed/simple;
	bh=4ufd+lnF/x/gbVvxt6igaQdaCfeXszeiZxur2NDEL3w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IcqlxJIz7grzt32N4DHC9ovuy5y1HX9qhcpoHScM5AC6kA4PxqnnAn+qHyu91LseeO/gsMnXzpSJ04+XkKx82a8I/uD5XkHLiszB5ymdhPkASSqFDntpeUM6XwoDOzkCA37f1Rme9i2kcTAyaMOw+Ev79jrPFbZqUFGhleO77jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jp9fJAK9; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jp9fJAK9"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8d24f98215so724889666b.1
        for <git@vger.kernel.org>; Mon, 30 Sep 2024 10:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727718035; x=1728322835; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e356y39zVXRBnY/Z3w2k2oq9FSHT+mnTZxHfqON7Uzk=;
        b=Jp9fJAK9/Vq8DnRu4AJ+Xza6mImAbgIhuTEhk0tRKZVabLFyiLhF6OVa8d4k24iY7i
         jMSC1Ok70OGXmDtYT9XWGE9mUeso14dVmF/GfcHKn+FPLAh4RqWWs4uqNgoS58Y1NcuL
         Jq9f5G2UM6kBI4AlIU6IoFUkj9/KNOGosflVXqUtNdtew3RSyVYTBSyHhNSkR0MsGGtO
         ZT/5Rt6BWPJSpJsJEE/Vimure0FP5C+wMtOFtgqP6RMDHOgVgRuamvoRm8Hno97fLZ66
         jnc6+eKDV9iyxHq6EK84Icr3cMaa0204UXTb30GD7/yPrXd3hevbwRdhf8wZau0nwbFV
         Seog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727718035; x=1728322835;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e356y39zVXRBnY/Z3w2k2oq9FSHT+mnTZxHfqON7Uzk=;
        b=sKJRaZtel+XC5rOPW43F6oFOuTrCfKUU8rsw+mrDZ5V1k0GI2QY9nNvkL+tZQYMkrP
         005jHRjUyBJ7lcHDMe01FqSoDPcLcll1fqXjw7sGI6pkzdjBjqzB4VNGJWB2rfBa3gsi
         7NmeGUjGyqmx5e7O2NL+87q9fvp3zsIB8tUDtQKxgZ+BR5TJYeJ6+UXRHEtUyz0D+BIE
         BZ7o70yK1PWZQ9PWAhmx0F3KLchc7Cjm1mPCMJqzgZgXAFPkZuELftD8yXOOzkQ/8xbl
         cFQ56g4G1+SfbQ0ikEQIHG5Sbmj5c4NcI3sTQTxgDLWjkKtLD5hblwo12RCXFQnmiO83
         BsTA==
X-Gm-Message-State: AOJu0YxKYi63oPZHXuMh/4YBr34bCoErIsIuQOixZAdXEcqK4qoECdY/
	aTZgYK1pYHUZdYE7koS6WcOvs50m9rJbHBU0U0TiB2V4buDBMlCXsF377Q==
X-Google-Smtp-Source: AGHT+IEQcB71P25Mkaswj/ySvuZxcOnoKSmOUzvWj+KbtAisQoUKo8WrGtHzlCAZy+kB+FpqLa3iEw==
X-Received: by 2002:a17:907:9488:b0:a90:b6e8:6919 with SMTP id a640c23a62f3a-a93c4a6700bmr1322032366b.48.1727718034741;
        Mon, 30 Sep 2024 10:40:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c299aca5sm565266766b.224.2024.09.30.10.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:40:34 -0700 (PDT)
Message-Id: <857291d7f7dffdd1a63ce9268c8ac91a82f2bdb5.1727718031.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
	<pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 30 Sep 2024 17:40:30 +0000
Subject: [PATCH v2 4/4] archive: remove the_repository global variable
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
Cc: shejialuo <shejialuo@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

Replace the_repository with the repository argument that gets passed
down through the builtin function.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/archive.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index dc926d1a3df..13ea7308c8b 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -2,7 +2,6 @@
  * Copyright (c) 2006 Franck Bui-Huu
  * Copyright (c) 2006 Rene Scharfe
  */
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "archive.h"
 #include "gettext.h"
@@ -79,7 +78,7 @@ static int run_remote_archiver(int argc, const char **argv,
 int cmd_archive(int argc,
 		const char **argv,
 		const char *prefix,
-		struct repository *repo UNUSED)
+		struct repository *repo)
 {
 	const char *exec = "git-upload-archive";
 	char *output = NULL;
@@ -110,7 +109,7 @@ int cmd_archive(int argc,
 
 	setvbuf(stderr, NULL, _IOLBF, BUFSIZ);
 
-	ret = write_archive(argc, argv, prefix, the_repository, output, 0);
+	ret = write_archive(argc, argv, prefix, repo, output, 0);
 
 out:
 	free(output);
-- 
gitgitgadget
