Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE14186F
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 03:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705635294; cv=none; b=T2Y2z+mOLB8D7NrYW2jotBXIoidF27aKjKivvhSBxvDcCXmqPi8Ccgx9ONBagEvBq3MuD/KQzcOTo3cUrSMeczDYt0KI2KcWbcxXAN/SqDLmDqKpI8bWFEr1ocWYtg2OkEFuXcdcnUFUMo5PQQJaRpCDVItGHE68OT2MB2xW0DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705635294; c=relaxed/simple;
	bh=vSu1L7Pnfx8DW2zVLu2TMwCWmQ/sq5KFZnV4WYH+ftQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdzAs5mQITOGnfHq/5jTw7HUkQXZgf1rbGSk+jMqLzf0ZpV622jze3n62tqK5RKasAdVL08RW4tE7UEw68CIu/AhtNJiHOQO/IORAWsF1zHGEixzVNGuK+iYows1BrdCqqpeYWacqvf+mtCF8Zqmjr+NirNpzF2kuG4j0UN/Kk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDsUshWY; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDsUshWY"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bd9ba8286bso298701b6e.1
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 19:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705635292; x=1706240092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4sToo2hvx0+lPxDQmDpxqoMu0gx4pY5EozVQG4d8oM=;
        b=JDsUshWYVeRMFpG0WIy+oBvp9KJV6hrlePhM+dmsEE/YJ2wIYYT/hDTyF03Z1WYmbP
         XGwck84dkuGPoUOQx5/cYHDwEtWxxeMwsKve9LUgU5auiI0UQadrUMLBq41U6ixdxV5U
         5IKBqnPeS5Y8p2qZhOq08/IOhO/Av2EAnAI67+Gwaq0lG8Hcixiw32YL9yN5GQ0HaeTo
         4BKzDioIfCbF5vuFf5pyYzJ4slQJOb/PjQg3VKvWcnrO51vxpvnXXYu1Skgu6dYEvN4u
         yEtVlNG3qreXcZSUYJ/ns4TcyLgj1jYcSNntg8+YMLAcRg6Pf92oqtgDWXO7AFY7fSsf
         xbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705635292; x=1706240092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t4sToo2hvx0+lPxDQmDpxqoMu0gx4pY5EozVQG4d8oM=;
        b=K4/VO9DwBOKhTHjzOjdb0xKmzQphVOreVIpufNROD0o5xH5VEG2oR2Z6wifqlNjXCQ
         Mkh+Ors4dHGI+IFXcur+3b2TPeuJoADdiJIIutiVQBnpFrbbAWqNU35diQASIs0XEUpf
         7HXnN+8U7TB0OGuqn1WIsZ/MX3sjK5uFjxpN8SmvoFtKXNcsSUaUKWYEPAhPS6NAK1DW
         3NN+YoXWMyXQnkVIoTbT2lz22JbXpC1NAPdt/QcIYWylCkmvHSH3GQNPCmreO9cKjCi4
         OspysOzfA3xLOpV7jPW/FuDNAsKBDlikLzy1s7dEwKYO9m8K6FHbwT/+Xz2TViHMM1Qo
         jRqg==
X-Gm-Message-State: AOJu0YxPoBIoZBeFPWJa7RFKU46YW5lV0eAh9eaVUd3U/eZNjyJuimcS
	j2EDnu0te/4USDuzG11LIwXGpe9Mmt34DOy8EtKuPZTN+dxLZlpJ1yJPfWpIVBQ=
X-Google-Smtp-Source: AGHT+IGBPmgoQLopJsgDfMnU6C4YhBjlP67y+V3KImPo3/nJ2lLvCUIn3RBwhNUqPFCre4qo4nnVdg==
X-Received: by 2002:a05:6808:208e:b0:3bd:9f6b:b712 with SMTP id s14-20020a056808208e00b003bd9f6bb712mr1828336oiw.16.1705635292037;
        Thu, 18 Jan 2024 19:34:52 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id d23-20020aa78697000000b006dae5243740sm4002797pfo.60.2024.01.18.19.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 19:34:51 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH v3 1/2] t0024: avoid losing exit status to pipes
Date: Fri, 19 Jan 2024 09:03:34 +0530
Message-ID: <20240119033410.12688-2-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118215407.8609-1-shyamthakkar001@gmail.com>
References: <20240118215407.8609-1-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace pipe with redirection operator '>' to store the output
to a temporary file after 'git archive' command since the pipe
will swallow the command's exit code and a crash won't
necessarily be noticed.

Also fix an unwanted space after redirection '>' to match the
style described in CodingGuidelines.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 t/t0024-crlf-archive.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
index a34de56420..fa4da7c2b3 100755
--- a/t/t0024-crlf-archive.sh
+++ b/t/t0024-crlf-archive.sh
@@ -9,7 +9,7 @@ test_expect_success setup '
 
 	git config core.autocrlf true &&
 
-	printf "CRLF line ending\r\nAnd another\r\n" > sample &&
+	printf "CRLF line ending\r\nAnd another\r\n" >sample &&
 	git add sample &&
 
 	test_tick &&
@@ -19,8 +19,8 @@ test_expect_success setup '
 
 test_expect_success 'tar archive' '
 
-	git archive --format=tar HEAD |
-	( mkdir untarred && cd untarred && "$TAR" -xf - ) &&
+	git archive --format=tar HEAD >test.tar &&
+	( mkdir untarred && cd untarred && "$TAR" -xf ../test.tar ) &&
 
 	test_cmp sample untarred/sample
 
-- 
2.43.0

