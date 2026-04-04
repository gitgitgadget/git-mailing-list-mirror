Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2066D346795
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775332212; cv=none; b=YTyg3w93vWlQStieyo0ow42ulo3sME3cZM1/FaRNkQDEUfnK9s2BciMazVwznMZpfHvOdzhvI1+i0+8rZqOClYNXMNiMGCr6obwBm8lkheuPAZZVjAKs7dZoe6KmPbUx7k6dASFgthyO9Oaj6HnDbuIS008ksEJJGWFiX2sxDzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775332212; c=relaxed/simple;
	bh=Orc2S0ItYNSKhH5pp10W9DSA5R4jneam/rLxMGJgGVY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hpd20RIPZ2H1k3Srl8q93n+vQiFuPMzR91bEe7MkuTUQ7dR7XJ8QAoVphPkab0e92DDeearv0DJAWCH/btUk6WAte1GamZEOSnUP/H1xNhq86/qhePUoqmekKvYY57XT1Ma6HdH+4UD4Q5Rb8+oaueVcd0V25P9h7/YRA31MoR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzKKZqmh; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzKKZqmh"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cb4136d865so386551385a.1
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 12:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775332209; x=1775937009; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DATvBDVBaQX6OvN4m/JJFe9i+U/IqHHUZdwVvw6Znu0=;
        b=JzKKZqmhZGUg712vQjJDCx6mdkCdVCLfjZdW1svavU05tM1hqYMmH+/ju2JvsHVVio
         ZocEVWqo0RhIQ3MnYbwKKw/MmYq9d9omzOoHNWzdN9Bmfp38nPIKjDyXm6486Lj+Ztun
         uKO1+dhCDe0oaPVFzJ7vdwuhx54NJZq6VVTEPAj8PigPZbio1OfkDE4frQXQasUxWnB5
         8N1j3zzUJhlN75P1A05xoKFwiYs22PS04aBsoPffDVi0o0YuRdxriaGl6rmrzlmeXSSW
         JJP14Te8Gdm4emvcvvv6zkGwHSaujqNm3c15+cXeZMfmXrNyzlFGDtoXLfkX05ZyuzDU
         RBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775332209; x=1775937009;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DATvBDVBaQX6OvN4m/JJFe9i+U/IqHHUZdwVvw6Znu0=;
        b=YlEIS3ATYd0j4LPw0PPzcslpRLn+LtPVvQJ2qP99dOD9fQXdcge9LAgAvpBRwAgabH
         ckK9L4npuorJvHmwz06rW27OX12EZ5eiYMZs55/HZbV93g4xIlFHayETsO1ohwD1+0lf
         s+yuS80qvpTJqsYAf/4cHhLA1kQ04G1VuPVtdBG7LvzOthUAAfvJ3CgOzx/TJ0DnlCGz
         gIqUmcJR6KxVSW3+CCMZ4apiplhEtE0sWea6xLNYnzMZ6hUrFFcmx1K+rIMGeM2Z79YX
         rN5yYpF/JCudm8doJkI1RVpS3m+OmZa9rf26MNqJzFTbyJPAyn6iFpcLoJAQ7GWBhhwu
         HM4A==
X-Gm-Message-State: AOJu0Yz7uMT1I0LL9iu8fwgGyEGXnjOiBP5ItbImrfOMPwlUs7KWNz3l
	d+V/rZJ1Ubz9fU6vkfSmrkJxtcSDk0AUQbwU9IY+ogLQXY/OvdXsVAzBDxE7Je40
X-Gm-Gg: AeBDiesvnFJV+CMe0flMngTYoJ2VRGd1s3OExHh1OjnQEm8tE3zlWNzxbpFDIO4dCL8
	p17iHZXdoPlo2xZqPEazYw/RVQmCF23PWvEAMnXCXBDCeNKdMDzCYfwxUFU8U2vExlvT4pKlpXS
	An0jnYq9kIq4LCBXmphOF9UUrOMQ5kFUfdhI/4dSmq0hHR6N1vT17zWO5TUnkMkCgIj4G8IAyop
	vQm1KUk/LK6tfnbdBYhd0/ENL3cKryQrCK+O7WLx+J+mdRiKbR65zSP27rUwbzS/9c2ozVEqxbD
	ey/MgsfmBVWWbcSm/R4W9HSyBf3zebjtnuetDi3+mNqD2Im0xVNrtOsFXD+2VKmGs0aPAQF4WxC
	ls2s8Wu8ZhRAou9sjAU2HhvHj7F3iL8Qt70Dxyg9ofZmGZkEusaRdu/wvHC9TZ93bWxcpIv9HaU
	uaiJfPMSTHJSSQAFLLUtjwD/pcv6U=
X-Received: by 2002:a05:620a:44c3:b0:8cd:98c1:763f with SMTP id af79cd13be357-8d41b8e2f47mr1053125185a.11.1775332209447;
        Sat, 04 Apr 2026 12:50:09 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.121.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a8c2a453sm728256585a.47.2026.04.04.12.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 12:50:08 -0700 (PDT)
Message-Id: <9001883e152407464c83227f1e09664d0d8826b5.1775332197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
	<pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Apr 2026 19:49:49 +0000
Subject: [PATCH v2 09/17] t5503: avoid discovering a bare repository
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The test case "fetch specific OID with tag following" creates a bare
repository and wants to operate on it by changing the working directory
and relying on Git's implicit discovery of the bare repository.

Once the `safe.bareRepository` default is changed, this is no longer
an option.

So let's adjust the commands to specify the bare repository explicitly,
via `--git-dir`, and avoid changing the working directory. As a bonus,
the result is arguably more readable than the original code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5503-tagfollow.sh | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index febe441041..6d178d84dd 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -168,16 +168,13 @@ test_expect_success 'new clone fetch main and tags' '
 
 test_expect_success 'fetch specific OID with tag following' '
 	git init --bare clone3.git &&
-	(
-		cd clone3.git &&
-		git remote add origin .. &&
-		git fetch origin $B:refs/heads/main &&
+	git --git-dir=clone3.git remote add origin "$PWD" &&
+	git --git-dir=clone3.git fetch origin $B:refs/heads/main &&
 
-		git -C .. for-each-ref >expect &&
-		git for-each-ref >actual &&
+	git for-each-ref >expect &&
+	git --git-dir=clone3.git for-each-ref >actual &&
 
-		test_cmp expect actual
-	)
+	test_cmp expect actual
 '
 
 test_done
-- 
gitgitgadget

