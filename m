Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822DB31A60
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 21:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705614875; cv=none; b=A2zVnYxe6CNURNL7rQA5gp3V7grKcMJqJqdh237zl1tV9VLwClutF3ehJrutalkYIX0YCIibC0KwcpeXjk8FRf0icVzEuomXlON9q8yptsropTiU4IC8/Qb4ptlG6shnvDvxbVMBIe9b8tFq6+q1JizYZ7aF6vyCQpskrd/nS7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705614875; c=relaxed/simple;
	bh=+Mm6m/QDujw3UFenl/J1XXqqwXu6AZYO3mMoyV1rSok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhnaU23cJMc/ysS1gYn+8SN75Fg9IxAEkY0htfvN2jkNsEUAwWvoT2C57cdO27mI6MHOGcVdfdfVRrfA/g7oyrl6a5V8mlhEH+N6uPGA0QXSvuwpqIoNWdkyaMF9nsD6p6h/aaMewz2AzMA+TpVel8q2wcSu2C6IcpYJb2dlU+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6DRsIwk; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6DRsIwk"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d542701796so802675ad.1
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 13:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705614873; x=1706219673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8Vme/6xRiBTWjC95wVEI7O4W4wxV+RqRgvULU6HnPI=;
        b=H6DRsIwkDGXwLmXa0AAQKtEl3CcfaPs8w55rwWTcoc+9D8fzAgj1rmqM0S3WOxeKk6
         wemBioQzGF+8QkIwqrZUOGVLp4i44wttCqBb/+ltzWewJ0FliP4qgOZ6C9vydHy771Du
         62QxO9LwQEMXlS00kkZkl1O1+5mbvSMTlePsj1KCucNyKGpNKJkUxpha78xJO6i021e3
         E7YY1V+8iEtJMarhhFojSypv9J+8gJSRxtoUM5Blqrz9Z1yI3PtlB6zSnwnaxDqbfeWi
         vkoRm4FoinzI/1mgGSXxuBn5zfRra2BJrQgdoYeHp9e5ejnsaunuKA/5HEmK6AQcehx9
         MOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705614873; x=1706219673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8Vme/6xRiBTWjC95wVEI7O4W4wxV+RqRgvULU6HnPI=;
        b=L3Bh0/9r0Bl/k0poOr5wDDjW+5tyVfOCpk8wKUu1UeBoaZeE/0zbkhmu/VQwXjyOOQ
         4DUFsTRThlpWNPGu7CwEFMDWzd6ItEcu2Cd1dzTjTwwDIEEGWFhhZhauidAezxUguWjP
         KQUIx38QFvMELj1Cx+9jp+sPhlUGFowNQ6Zz9/Mq0DjTDI5FGFFn8MHdxb13s5js8TDK
         1de7MHCcrT3DUmJ0x+MV2Fl3PD/tZTvdBT65cuT37HfCPyDwHvtn8a7fQ/mgaJtfMiJv
         KDEZqdqAftH50mfu/DjNb+BqEhLBUu5DDjtClgy/fN7T9EVgh9iKqTZ22vwnO6QqrXvN
         5LHQ==
X-Gm-Message-State: AOJu0YxXzqEpnI8xxHH27w4ndH/Q03BUmR6WPTq5bqilibmurhZ41OyN
	ihDhL8VH6CXl3S5W2Dz4XTjECqo+LlhMNaXwiAuEYhzlyBGBD1JlEI5/UHq8V/E=
X-Google-Smtp-Source: AGHT+IGIol/m9pphk0Xaubhk1CqWEEMU3mm3KMinarqj4b9qNzAoFdO+7S5Pscy8OamFBv6s3JwGpw==
X-Received: by 2002:a17:902:ea01:b0:1d6:f8d5:25fe with SMTP id s1-20020a170902ea0100b001d6f8d525femr1782437plg.12.1705614873333;
        Thu, 18 Jan 2024 13:54:33 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id mp14-20020a170902fd0e00b001d5e6f008bdsm1827767plb.132.2024.01.18.13.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 13:54:33 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH 2/2] t0024: refactor to have single command per line
Date: Fri, 19 Jan 2024 03:23:40 +0530
Message-ID: <20240118215407.8609-2-shyamthakkar001@gmail.com>
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

Refactor t0024 to avoid having multiple chaining commands on a single
line, according to current styling norms.

e.g turn
    ( mkdir testdir && cd testdir && echo "in testdir" )
into:
    mkdir testdir &&
    (
        cd testdir &&
        echo "in testdir"
    )

This is also described in the Documentation/CodingGuidelines file.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 t/t0024-crlf-archive.sh | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
index fa4da7c2b3..ff4efeaaee 100755
--- a/t/t0024-crlf-archive.sh
+++ b/t/t0024-crlf-archive.sh
@@ -20,7 +20,11 @@ test_expect_success setup '
 test_expect_success 'tar archive' '
 
 	git archive --format=tar HEAD >test.tar &&
-	( mkdir untarred && cd untarred && "$TAR" -xf ../test.tar ) &&
+	mkdir untarred &&
+	(
+		cd untarred &&
+		"$TAR" -xf ../test.tar
+	) &&
 
 	test_cmp sample untarred/sample
 
@@ -30,7 +34,11 @@ test_expect_success UNZIP 'zip archive' '
 
 	git archive --format=zip HEAD >test.zip &&
 
-	( mkdir unzipped && cd unzipped && "$GIT_UNZIP" ../test.zip ) &&
+	mkdir unzipped &&
+	(
+		cd unzipped &&
+		"$GIT_UNZIP" ../test.zip
+	) &&
 
 	test_cmp sample unzipped/sample
 
-- 
2.43.0

