Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E255675D
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705695548; cv=none; b=QF1GnhwnwdUXH1ERld2thuBrViw77fEdGtIbZdCy7/chXCl0vcLRhc2X6SnT4TLW6JnChT4Fp8Slqa2s2U5x2V8qdwP897SyyhHO7nkSkzTb8KaBcW4unOin3CmPjp2ON8ooV9NeiA1jzB2yjRn0qRg/TUif5LJi/ulPd832vls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705695548; c=relaxed/simple;
	bh=+fAmqXeyTI0TgooGuGV5VjcyJfLYQKyJJJYBXwmeKT8=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DN0QvCKpio7oU5cRB6NK6pygLXaha4KVNMOQtPMoXYWb79ZnWEoaaZrslmHb9GWhmXrIkxJw1w7phEiPonJ2MF5eDI1pj1g2dxS43JFzaaoyIJI1SONX36pIKUUOI6IvCzor2aqI3S+mvPxNHLieqXiFvEhs7S+9O+AqEDV90zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5UaH+j0; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5UaH+j0"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e9d288f45so12277225e9.2
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 12:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705695544; x=1706300344; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sqab6Uhq1OPsAJMlNnyFACdeKriyuW8E+82dC3/oI8=;
        b=X5UaH+j0FJjm5rY3C6PQnqR5UXc38MHb+RePco0O5fujTWSAoN3YjVQA7iDKGCYHgT
         0jkWe2X2yj3ekQDTc9GUkv8MSFMUpIF7VwMeI5pxj1e3E7TdkCj6JwxARjdtRacfoQ42
         Z9UDr0/BL6e1q2fz9sc4aILJHz63s49+1QTI33shImrPjSslQkm38KWTesbdKY+yTpdU
         c7eFjSrtKQZaMV/Zib6k1h7MVLT5KOqGdBlhJ5d5j9jkqSexAdlKI6Vpxx8ulsqLzCxn
         jIre7Yh7dPypWA/cBhgUmXbw/+TRBfCVOYQwowzZSWVGmAJsIPCRy9jws8OGtj2FView
         QbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705695544; x=1706300344;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sqab6Uhq1OPsAJMlNnyFACdeKriyuW8E+82dC3/oI8=;
        b=mjrpzT39kiMkudhURD0vonx49dMNtWXi6X7xIgjwglOaqLP6LJicj96/6yz0LU0BtJ
         JLzgqAlz3XdzROmDnHLfjXfEg0lRh30SMru96j8LyiQPviYOJ7nTcVcMnX2oOlUAkTvL
         XgnIMXOV7QHUTxm6hILmIIeQSRyTy+6++3yuq1QtKuLKcDJcl6vW9HiQ4B0l6DMjtUgp
         1fgu2bHybiAyBS/ANVqrbt5hx0MfB7vaV0Kd4TSZQjUCuC9ld1EBzVueQO83qF4P/L9+
         uWWb0i2ns1L8SdYdokmryTO8lht35vQRrlMotyw1UHpZhAhL7lPsC5KcQIFxTTGFsK4b
         iX/g==
X-Gm-Message-State: AOJu0Yxgg60MKwHVSduri+bv/LvnnyT04c+0OCrSCMnyix8oaWdOXuYc
	bB9LGOzgtelQz88FULFTKyJ4Yi8wonURb4EmcsINLe1YZp6R/L98W7PFmJk2
X-Google-Smtp-Source: AGHT+IHf5VUfDu5vhx5pgOzsOYbFvKH4RuWOmBPh4/COxp7WApdNmXbUO4Zj2l3dtOb8dZnXPcdfVQ==
X-Received: by 2002:a05:600c:22c3:b0:40e:4abf:61c3 with SMTP id 3-20020a05600c22c300b0040e4abf61c3mr118061wmg.85.1705695544365;
        Fri, 19 Jan 2024 12:19:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600c46ce00b0040e7306f655sm19813570wmo.22.2024.01.19.12.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 12:19:03 -0800 (PST)
Message-ID: <122d19a909536b570d4e1fd28228279616604ece.1705695540.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
	<pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Jan 2024 20:18:51 +0000
Subject: [PATCH v2 03/12] t1414: convert test to use Git commands instead of
 writing refs manually
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
Cc: Patrick Steinhardt <ps@pks.im>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

This test can be re-written to use Git commands rather than writing a
manual ref in the reflog. This way this test no longer needs the
REFFILES prerequisite.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t1414-reflog-walk.sh | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/t/t1414-reflog-walk.sh b/t/t1414-reflog-walk.sh
index ea64cecf47b..be6c3f472c1 100755
--- a/t/t1414-reflog-walk.sh
+++ b/t/t1414-reflog-walk.sh
@@ -121,13 +121,12 @@ test_expect_success 'min/max age uses entry date to limit' '
 
 # Create a situation where the reflog and ref database disagree about the latest
 # state of HEAD.
-test_expect_success REFFILES 'walk prefers reflog to ref tip' '
+test_expect_success 'walk prefers reflog to ref tip' '
+	test_commit A &&
+	test_commit B &&
+	git reflog delete HEAD@{0} &&
 	head=$(git rev-parse HEAD) &&
-	one=$(git rev-parse one) &&
-	ident="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE" &&
-	echo "$head $one $ident	broken reflog entry" >>.git/logs/HEAD &&
-
-	echo $one >expect &&
+	git rev-parse A >expect &&
 	git log -g --format=%H -1 >actual &&
 	test_cmp expect actual
 '
-- 
gitgitgadget

