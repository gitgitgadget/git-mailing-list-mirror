Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7251A7ADE
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 13:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727185372; cv=none; b=rFddymsEPCnBqUlzVDRASWEFPdQiFZ1eElZ4MjICS7zlcO+lTNzXJWx0bMS4uT7ygknGvCmq7WUijng627YJRx9G9K20oWpGBVQpA0c4SSCy3VmXphFo/JnCUVgK79VSEl5+v+4520+wF5nGF7By40PiGFX73alr+zX+nFDJkI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727185372; c=relaxed/simple;
	bh=TkH0Jy/C2wq7XC9ZiU8UMdsetPfOA8Hy8vKnd6emoX0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Z+luepD352BG91bctG9asBGxish93T6lEKtU/H3Ydsj2V2itngeHfJTr/i01PMP9Nb+69Y52aXWT4Bf5tIZvr7wg730zJ9jfGBbnuRT8teczqo9FSzPa8e14xfR5rpV8tXUya43iBhbpjm5WpT0A3KojdHxf6NxTjooa4BFA54A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XA9Suv7r; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XA9Suv7r"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d0d0aea3cso746880066b.3
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 06:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727185369; x=1727790169; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1lMFnQXIkx6Fd9qYyPeN7DpuZ/qTyN07CquJF0snKg=;
        b=XA9Suv7r5Ta+3WMsQfr3BOKmNeeXF8IWncik+NZ/ByWhXZGCvOxw6FkARt7yH1Iit2
         xjV8sBlADqdg7k/dEDOzlMmKgWh+fzBpGCufGxUJcVVfzqbksS1U6O3QSceLAqObkvRP
         FIvfwsVo1wYvCnHnqH/u3q84rUKfDtZf/1/wu5mVU5JowbpoRTRAKCqs943MXn7XTPeM
         2r1kHDdOuOgWXFZWhRWff5/onGZxKWAr2rSwnI8ml/4V3qo1xyWioSU6aY+TMhNCn6uC
         njWyqupY1mbAVNgSiCObJLsS0L6zmCn4ad4wNt9GeeS4Km6URxRQQVdSe9+NNwXg4aEs
         jMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727185369; x=1727790169;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1lMFnQXIkx6Fd9qYyPeN7DpuZ/qTyN07CquJF0snKg=;
        b=RedYuEeyVj/4pqbUeB7R5T5lkVsHgvnxjf8CjQt/+Oy01vCVL68n5pbRpQW0N/Gity
         8joipKZ4ZFMj9JHZKo0t26iK8HFPBoQiHxBlEI5Nhv/rxXiTFcbMqhH3+GYwr3N3qfco
         P6LOHNrSZdwAm1wrMRVr9oRAeUvqCZAdi6K2l/PQ5sR8wz7o6v63si3pCTVyRKOXFlL/
         4o08oqtOsNF6jblbZTMNkgCOwak76O70zULI/NL7EC6w4T4RYUImuFyoLlEbRLOzhpq1
         MA3RgOm7n0XvFji3tvnrO+YUeewbkKBOwfmkJHAnV9A6hRSSQd1Sk9xJR9g9PVfI8IwW
         gwFQ==
X-Gm-Message-State: AOJu0Yy/WN6+lVdreNUT1T1rUKg6Uz/vUzwvnG2ZkmfnjofqvTPcSkfa
	FZIZlF3A5LPiBWvvWbMANFUFDVXn6TK4gcJyiipCTkPbyYAjx9Iv8F1FCg==
X-Google-Smtp-Source: AGHT+IGs0HWu7ZVBdxBN6KLc5Db6S/Je44s7VyT+g1+Fz8neeY6i/WE1DdJLovAWHfCGxeP72ZDZNQ==
X-Received: by 2002:a17:906:730a:b0:a86:82e2:8c6d with SMTP id a640c23a62f3a-a90d5169d3fmr1652269166b.62.1727185368648;
        Tue, 24 Sep 2024 06:42:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9393133a8fsm85376766b.191.2024.09.24.06.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 06:42:48 -0700 (PDT)
Message-Id: <4ce463defa807fb99eef6ce7abcd758fc2065c13.1727185364.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Sep 2024 13:42:43 +0000
Subject: [PATCH 3/4] apply: remove the_repository global variable
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
Cc: John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

Remove the_repository global variable in favor of the repository
argument that gets passed in through the builtin function.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/apply.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 84f1863d3ac..d0bafbec7e4 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "gettext.h"
 #include "hash.h"
@@ -12,14 +11,14 @@ static const char * const apply_usage[] = {
 int cmd_apply(int argc,
 	      const char **argv,
 	      const char *prefix,
-	      struct repository *repo UNUSED)
+	      struct repository *repo)
 {
 	int force_apply = 0;
 	int options = 0;
 	int ret;
 	struct apply_state state;
 
-	if (init_apply_state(&state, the_repository, prefix))
+	if (init_apply_state(&state, repo, prefix))
 		exit(128);
 
 	/*
@@ -28,8 +27,8 @@ int cmd_apply(int argc,
 	 * is worth the effort.
 	 * cf. https://lore.kernel.org/git/xmqqcypfcmn4.fsf@gitster.g/
 	 */
-	if (!the_hash_algo)
-		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+	if (!repo->hash_algo)
+		repo_set_hash_algo(repo, GIT_HASH_SHA1);
 
 	argc = apply_parse_options(argc, argv,
 				   &state, &force_apply, &options,
-- 
gitgitgadget

