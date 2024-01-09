Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF3F8F69
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 06:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wf9aRnRt"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d3ea5cc137so22946255ad.0
        for <git@vger.kernel.org>; Mon, 08 Jan 2024 22:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704780603; x=1705385403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eETwQf+ok/3MYSY+fSF8wd0AjBlqwk182XnHB+9IZ6o=;
        b=Wf9aRnRtDK1etucGd6HVCp9n0X6ck3f3I/uSA85xi1akHd4YwVmqVw3Ykgqc7eq77Q
         3oC2llC0bXt2BVarpISmDve+wSdS20il6iM9xOyXbrgv6tUUUksOxIf3dzqzB/BPfQj1
         h7qu1jC/BJI5/XwhGwb0ZlgBM0VtVa4VRZufdxNe5pZBtA/p3M3HM9dr5dDy3UvkAz+T
         nfLKsHD6tDrFven18n9yG0G0z6NTk4fashQ1O3K9MyQw/AOUyGvjlI2H81LxLfGf/1oZ
         VEVRR9mSMuRIt5C0eAv19T8GtlPtMn7H6H8OQKj9hDtKKX3TNLrA1HgctHO3Ui27krin
         oD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704780603; x=1705385403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eETwQf+ok/3MYSY+fSF8wd0AjBlqwk182XnHB+9IZ6o=;
        b=WvmS7svCGMWgQbUgbr+nKhnQ+P+kE1Dog+ZoHSrxU32zx05h+WSReJC5AL3P2cQxDX
         xAM/dFh+M0LKYmmB0st51aIaL8Q3SwQ1czFMZMain4Kg/0szdq/Bxnc6zHRLaPmtbhWr
         cysMkjKY5n61B5emwWLx2BV3haT0POOrpaMo3qnYHM4jAlubkhzzj1+F82+mIlMVbktV
         Dhehfefnunym0QgGoKdakj9/tsskGJck6BKcD/bLb8nmB8gmlEGjyivUxW5PbKiwPsYi
         r5/BKRFRuvRRVaY9vaSQhSPM/E6X0cfTNOgURPNJ7hBKT64hiDaAgkZvbDXTT51RQy+n
         jKmg==
X-Gm-Message-State: AOJu0Yyn5dilMZTQRzfWFiDKvZrhQ8DoKkjH7YIi2/Y7vBSK0pfkHDHr
	Ap7fscLqnAm3N7L2gQhssyacgEMUA0HXHNt7x6k=
X-Google-Smtp-Source: AGHT+IG0YLtSlJqhKXhVNR7O8BAc4IC1g/MrJ/WnFo++/7OGDFGn0dAStdszBpG5OBjCpLbrCXW4Zg==
X-Received: by 2002:a17:902:9005:b0:1d4:97a:7f5a with SMTP id a5-20020a170902900500b001d4097a7f5amr4546522plp.95.1704780602741;
        Mon, 08 Jan 2024 22:10:02 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id v20-20020a1709028d9400b001d05456394csm896020plo.28.2024.01.08.22.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 22:10:02 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH 2/2] t7501: Add test for amending commit to add signoff.
Date: Tue,  9 Jan 2024 11:34:14 +0530
Message-ID: <20240109060417.1144647-4-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109060417.1144647-2-shyamthakkar001@gmail.com>
References: <20240109060417.1144647-2-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds test for amending the latest commit to add
Signed-off-by trailer at the end of commit message.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 t/t7501-commit-basic-functionality.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index 71dc52ce3a..35c69c3ddd 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -464,6 +464,24 @@ test_expect_success 'amend commit to fix author' '
 
 '
 
+test_expect_success 'amend commit to add signoff' '
+
+	test_when_finished "rm -rf testdir" &&
+	git init testdir &&
+	echo content >testdir/file &&
+	git -C testdir add file &&
+	git -C testdir commit -m "file" &&
+	git -C testdir commit --amend --signoff &&
+	git -C testdir log -1 --pretty=format:%B >actual &&
+	(
+		echo file &&
+		echo &&
+		git -C testdir var GIT_COMMITTER_IDENT >ident &&
+		sed -e "s/>.*/>/" -e "s/^/Signed-off-by: /" ident
+	) >expected &&
+	test_cmp expected actual
+'
+
 test_expect_success 'amend commit to fix date' '
 
 	test_tick &&
-- 
2.43.0

