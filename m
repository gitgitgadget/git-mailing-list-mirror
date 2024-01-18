Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2723173E
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 20:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705610620; cv=none; b=M6Rzwm8t1Jx0eiM5uK5RCDyvzxv+WDfNJ/pb3oJ++CQjh6RPtVDsilLAEyBM/hnL3SlUJbIb4UfrSym4rNse9nPjdms767teqUHNokdI44cEWllMUo1ZO+HdU3D5or2pSWcBhZhIDZxVc1GWg+qWkNe9KXqsQ3nlSkJIbmNhJ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705610620; c=relaxed/simple;
	bh=BocqwoumdwyeKQkvIRRzGEy8YZRxfZEdOco9Z+UfBqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ee1kel/5G8eHgRGmtKxU32fLuT4xo1g7j/5abIF9jSkIx6vwQOvx2BvFKZDqAIPJF4zA3OCOcmerS6uSRfeC9Pa2e0nPB8l5PP36rTLg9cVJBWrn40CB3LF+sgQVyH4Lq8VC1Vf4XxnBNf46vSDr6U05TfIYzsHzI5mduArw8Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwifQEAB; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwifQEAB"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6d9b267007fso111269b3a.3
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 12:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705610619; x=1706215419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKB8kMLbJRUVzIIG/52sECuQUrlKokgcV/DxC4b/MZU=;
        b=CwifQEABerJJnCsCUfHyaxQwKNLH7h7uTfqoNyny7ZTKwNI/TYFg5sk4A2PMkr4p42
         UjdwWDxNmk77OkgUP6/LS7dNgcROYZPfVNPwnTOTj/lTbOT9QDTx1SKiM/Jf0IkDikeq
         a6eBp65DwLjMnC/Vnc+5Sx2wHysLSpyfyFk6UFnsTvSS23Ks0kwjMWaRd2S+FoyRlCsJ
         CmaXWvevQ063V19S4syJ3egnWLnQ5WaLHD397U682xRZbbRU6Q/unDyNzwRTDtgl2SHy
         +CTX5AFtykdy84ajQgVu+HEybkEfSQqUld5A+rHWwxytEt+tCkGaUsws7e9rvc5fNxTh
         g0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705610619; x=1706215419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKB8kMLbJRUVzIIG/52sECuQUrlKokgcV/DxC4b/MZU=;
        b=eHi+ga9DxQ7E0ofIe+sF6rALAATkXvk4TIPO11lqrVvXjhZdSOLoghyTdZ5h2osXep
         07ZCJ1uClqzaSX3NmBhCCuu/41p8DsjahNweMeSvUT4zJpxQZDOy0yb6DSVMU23Qsev5
         YylpC4UhakzqaB0hSCkF/z+rbJ2xV5ZvNgQeEwlIiN+KPz/ggprPTQTaN9nE+oA9gDxC
         Y8zEYreaDou2UU4dXrAXG8N0iE25WsobJKAj6caecw7OXDUXFFiWdGfWo5uP3ySP71Xr
         gwgPw5voObosyy/bcMFguKRqtEpY8YgebiFifeiWKvX1gVkNCj5rZ0g9CVvOKLnXAsvN
         102w==
X-Gm-Message-State: AOJu0Yzf6/wocb/HP56yfd+Hmm1x1FYy0mjLLKRTz7gZDyHK3lWowNZz
	GwNDfujIXOMkrAiMKlsUWIanGoWyYNn+WM8nSngwIes5FUeLazZO
X-Google-Smtp-Source: AGHT+IGFF76f01wPlqiP93OA4dwXqc+q8PjwycdbkkJB5rKo7qGYNn24TfJ+8QxCtHWFYyQBt9+HWw==
X-Received: by 2002:a05:6a00:92a0:b0:6d9:b417:e49 with SMTP id jw32-20020a056a0092a000b006d9b4170e49mr1422925pfb.49.1705610618907;
        Thu, 18 Jan 2024 12:43:38 -0800 (PST)
Received: from brittons-large-Vivobook (mobile-166-176-186-78.mycingular.net. [166.176.186.78])
        by smtp.gmail.com with ESMTPSA id lo11-20020a056a003d0b00b006d9bb753d2esm3703561pfb.166.2024.01.18.12.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 12:43:35 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 1F6C5520277; Thu, 18 Jan 2024 11:43:33 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v3 4/5] completion: custom git-bisect terms
Date: Thu, 18 Jan 2024 11:43:22 -0900
Message-ID: <20240118204323.1113859-5-britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118204323.1113859-1-britton.kerin@gmail.com>
References: <03fe3371-2b0f-4590-90ad-166b8fa4cbbb@smtp-relay.sendinblue.com>
 <20240118204323.1113859-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 63ca8082a4..ad80df6630 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1583,10 +1583,19 @@ _git_bisect ()
 {
 	__git_has_doubledash && return
 
-	local subcommands="start bad new good old terms skip reset visualize replay log run help"
+	__git_find_repo_path
+
+	local term_bad term_good
+	if [ -f "$__git_repo_path"/BISECT_START ]; then
+		term_bad=`__git bisect terms --term-bad`
+		term_good=`__git bisect terms --term-good`
+	fi
+
+	local subcommands="start bad new $term_bad good old $term_good terms skip reset visualize replay log run help"
+
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
+
 	if [ -z "$subcommand" ]; then
-		__git_find_repo_path
 		if [ -f "$__git_repo_path"/BISECT_START ]; then
 			__gitcomp "$subcommands"
 		else
@@ -1619,7 +1628,7 @@ _git_bisect ()
 	esac
 
 	case "$subcommand" in
-	bad|new|good|old|reset|skip|start)
+	bad|new|"$term_bad"|good|old|"$term_good"|reset|skip|start)
 		__git_complete_refs
 		;;
 	*)
-- 
2.43.0

