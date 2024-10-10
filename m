Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED11F1D0481
	for <git@vger.kernel.org>; Thu, 10 Oct 2024 21:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594834; cv=none; b=u1niz3tGsbPwaqz9cDoH27X+JmTAmej3ZZGT5bOYi0SNDoG71JVIqNZHY9Z0V0+Dz5JOsB5+UUSy5unDOOqfK6FNQ9ui8L7Oi7ktpIJuAWL2pqXaizWH9fdaQ/V7siyS/WsrmUD6INS/KwiK0wKzufkPXe5+hrUTiLi75Fl8EHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594834; c=relaxed/simple;
	bh=2kb1vsm+R+++B/q6UnLA9rEbnoDN9TQlf0q22rqwDqs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SuJ2N+JTtNf4LW4va6Xj/uBXNyMYwH9edBt1wrVjx6T8iOmepbXSAAN1FUq4TcEBdUa4hmxjajLoGrHA0feMtWALnNT8Xx0deuz6UnZ69KoGKHIE2L3CMSl2qhrK6jfxFgtvSKV1fUXpPxTqZQS5cibZJAnD5QZDtKhptVBJTAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpFcvmK8; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpFcvmK8"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a993f6916daso238502266b.1
        for <git@vger.kernel.org>; Thu, 10 Oct 2024 14:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728594831; x=1729199631; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWXY86I7ez8lQdjI7XiobjMqZstrrZZ+RegZvkK3Jco=;
        b=jpFcvmK8AF816ROyPgly2w1rvJsMKZ0AHtGbJIfIoj2/ISMl5N98PNWFH9DBHHJzxE
         tYPj3ePaq538ktiLElBxiEPGy/Dv71NjOJMrL1nBopWLuhJwXaQoksDikhlqtE/vn1fN
         yrTgxgMXnAlChwkKcoM4qnpsoL1LMTon/BdQ0jmZ3PHpOJuQ5fNf/+37Ka7yiOp96P+2
         gR9BQwFgvQmT3AA2jarH4DRZllRl3elAJWgVQLQviMM4wRVNzCW8aq1zyhW/PAFQL1gr
         DALVXjabUGuY2FYm7U545CvtBoW4dNViiJa5WujfHwMFuuYKaAMgoUUEbaOSzCgded88
         e93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728594831; x=1729199631;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWXY86I7ez8lQdjI7XiobjMqZstrrZZ+RegZvkK3Jco=;
        b=aaxcmnWVl4nQoZF9BimbnVFJ9OgYEHk4UDwIwh2hlBVPofYZ0iJQhw9Y1QPH0LaShI
         /n7Wyjs0DbLin8SS4XMMiVwi2Y3USpe9zuU6HFlNy40porXtZcX6nUkie7ONAIzPgcKX
         rgbd9avYuiffdRNqUe+ShKb3MZP06K1w4JEO1xolv7JkWL8ghV576VDeqShuHC5jQgzj
         ctMzZHJvnvf50d9mXv50aD5UjEdMQIBlYODqyuw2gk4s2psgqEKoetjs4jCpbOD+tYGD
         r4gKgo/mIrtVPOgg/fpvIz7dXDNhA67W7kwChtJ5aI5pjrDwsBUDEAbqSJCyX/JjZHwY
         yV5g==
X-Gm-Message-State: AOJu0YzO01pSTLK116cUsQl3DqEgo+BGHUpLJM3N+/FzUIOKu2qt3cl7
	7vOClnCAJyNCcttFtqUU220LLKPTTeMVgihBicvLEbW/n6HxgAIfv8Jc6A==
X-Google-Smtp-Source: AGHT+IGGq2JQCinkdJ63jNm/QOwDG9cEEaYpg/zTLY8+kiMVUdWj2dNQD006dXzHAFqJ3dbegbrEdA==
X-Received: by 2002:a17:906:c10d:b0:a99:4879:ec2d with SMTP id a640c23a62f3a-a99b9307195mr24225066b.5.1728594830915;
        Thu, 10 Oct 2024 14:13:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80f2928sm136479766b.214.2024.10.10.14.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 14:13:50 -0700 (PDT)
Message-Id: <f26d09215c3f40b07fa53ca638a058053dfdbffe.1728594828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1788.v4.git.git.1728594828.gitgitgadget@gmail.com>
References: <pull.1788.v3.git.git.1728099043.gitgitgadget@gmail.com>
	<pull.1788.v4.git.git.1728594828.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 10 Oct 2024 21:13:47 +0000
Subject: [PATCH v4 2/3] annotate: remove usage of the_repository global
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

As part of the effort to get rid of global state due to the_repository
variable, remove the the_repository with the repository argument that
gets passed down through the builtin function.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 builtin/annotate.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/annotate.c b/builtin/annotate.c
index a99179fe4dd..ce3dfaafb28 100644
--- a/builtin/annotate.c
+++ b/builtin/annotate.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2006 Ryan Anderson
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
 #include "git-compat-util.h"
 #include "builtin.h"
 #include "strvec.h"
@@ -12,7 +11,7 @@
 int cmd_annotate(int argc,
 		 const char **argv,
 		 const char *prefix,
-		 struct repository *repo UNUSED)
+		 struct repository *repo)
 {
 	struct strvec args = STRVEC_INIT;
 	int i;
@@ -23,5 +22,5 @@ int cmd_annotate(int argc,
 		strvec_push(&args, argv[i]);
 	}
 
-	return cmd_blame(args.nr, args.v, prefix, the_repository);
+	return cmd_blame(args.nr, args.v, prefix, repo);
 }
-- 
gitgitgadget

