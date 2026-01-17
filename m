Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610BD76025
	for <git@vger.kernel.org>; Sat, 17 Jan 2026 06:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768631212; cv=none; b=udsLARXTBRznoRPcYSEDcXxZ+HL1BIwTaWDDU8TpZkWkX0W7nqtXvqu6pVrnXhWisTeWYOND7HbQJ/Uf8TYbUZvgc8VEKcP6Qo5GkDLFNEKrAlqK+Mlo/WjW5KG70yv1dg8OUHUBOFrcxXO9rdWBcY4a/eT9hbBUrGEw68zb8LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768631212; c=relaxed/simple;
	bh=KFPLBJXArsaqWqzB6/dWAdXRrrz2o1Mmjynv6Qj6CVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fkzvfu2rjq5qu7ZugxRh1qwhBKRE/sffw70EeGlS0TZhx8ihAQCsL8rU+FgJG3ShRcseUaQvQtu6vddl3S9cIj5u3yZTtUyUrSSQdNJbkHy/HFZD34oX5sOX+QaJ8fZBm6Pb/M0qF8Pat2rZ9BvqKG2afw2mvXsdXyCubURn6Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFfE6YvK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFfE6YvK"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a07fb1527cso7419265ad.3
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 22:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768631210; x=1769236010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=33PnAlAA8HVXVacPcIR9tnPVERpapEjzgbdzhJwYIWo=;
        b=JFfE6YvKXQLbqrfNL1QBnlp0wQRcQBX4FNlxJQQJlJoTJm7QtWa8Ebx/RW60cQWYK8
         QEbjh7bhvwHjOkjcaM+Ox6P4Pk5kTeVE1bNiWhFCD7s8nPfIGa0rTa0DspEWXAhMJydc
         5D1v26Krqy+ywzAmxBQreJikWoA1ahZydt1plVX2ICL1dIkOQcIr03OxxQbR6hvDrV/X
         UCvQsZ/xyUE7C8FLs0XhDgglbM97+wb2hyLTlj2SJJaT7jV/oIgzzkNqXGj2sankWWO6
         5jNRb2Rvge798ISzgLWUUJv+P5Ru+D1BQXr2tcMEx4CRKV1+PlNz9tBk+aywWFxD0sxm
         WCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768631210; x=1769236010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33PnAlAA8HVXVacPcIR9tnPVERpapEjzgbdzhJwYIWo=;
        b=BsHblESWFx90pyBQe9K/GO0A3nbcRqgZrwX0N4TtbBN/1gh3GljXcIC4arCaJvOqfX
         ypdscljat8oQ0Zm9TVemgKKsG+H/JqWMzphLHQ7mGPcSAMWca4MV6gsCLcupfUijdnLX
         /acXIQWwB6PJf32VEuY9a6ADIxKPATD0cDEf/kxaSrq68Y9zKk9jcSY6HrgRhpRZOduC
         CfbpKxStBEpaX+2gqvbTD8X5zxhL/ifSV3ATLJ2wtr7JX9eN5HulquNPgD0VJFRGn4Fm
         bJq48oGTJkzL7Z+V7puHhayBNUMqOPALpfQBJQX/y6zo5RconaqVmKy07wUSdztnETJJ
         27eA==
X-Gm-Message-State: AOJu0Yygo+oUFQIVtzxV7/ihNsc3NyxPlrAgCLNBXX4SgrMn+zqzQ9fe
	fygeCdfWcmAD6d1nv5azvBqZOGtSvjYNd3gkoWFFuPEbxqlMKv9eEcUfbCs5gnPa
X-Gm-Gg: AY/fxX5wH4DGDwIqgx+zCgOeMRjwtrY0kAaPv+k90V96pXVr6wMxqMRDi2TjEJe1ci3
	6VId4BfKV06U1Rg4rBYTFRcXtgVjQZn2jM0FMfRNCLUecB06N5CymobyItFEvZb+L9x784NvMZX
	Ydg+O446hZoHcMKISHAVjNqCGe4vs6NxvtvvVE+Xi1B/cCSlT22t1a/j+Bciatsdg0OHVm0S5Si
	IJ+i3sHIn7F9pRCrL4gtCObp83FtUMDGpeNoV74WvzbgH8OduHI6uMCrF/WyBGSZRc4dh2l/ZM1
	oyQpAlPuvBU+qYxZi/kRTcFoLMoqmo/lA+Lrufg61W60P4l14ZoXgSPLFAwp2tBGvg2XVIfm8R3
	6rF7XUauGo/u+1ydLP5aniASno0kgmuPTDKbyqg6EHnGR1GTIy8na/fyQWX7krc46TNh7ZFhKrG
	vfz7VMs0xo/HrWhGZOhsEh5gCx4J0=
X-Received: by 2002:a05:6a00:2da3:b0:81e:3f36:3dee with SMTP id d2e1a72fcca58-81fa0395feemr3492350b3a.5.1768631210291;
        Fri, 16 Jan 2026 22:26:50 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa10c5502sm3624900b3a.24.2026.01.16.22.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 22:26:49 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitser@pobox.com
Subject: [PATCH v1] t1005: modernize "! test -f" to "test_path_is_missing"
Date: Sat, 17 Jan 2026 14:25:15 +0800
Message-ID: <20260117062515.319664-1-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace instances of "! test -f <file>" with "test_path_is_missing <file>".
This macro provides better diagnostics when the test fails (it prints
"Path exists:" instead of silently failing).

Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
---
 t/t1005-read-tree-reset.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t1005-read-tree-reset.sh b/t/t1005-read-tree-reset.sh
index 6b5033d0ce..1bf384dd0f 100755
--- a/t/t1005-read-tree-reset.sh
+++ b/t/t1005-read-tree-reset.sh
@@ -40,7 +40,7 @@ test_expect_success 'reset should remove remnants from a failed merge' '
 	git ls-files -s &&
 	read_tree_u_must_succeed --reset -u HEAD &&
 	git ls-files -s >actual &&
-	! test -f old &&
+	test_path_is_missing old &&
 	test_cmp expect actual
 '
 
@@ -56,7 +56,7 @@ test_expect_success 'two-way reset should remove remnants too' '
 	git ls-files -s &&
 	read_tree_u_must_succeed --reset -u HEAD HEAD &&
 	git ls-files -s >actual &&
-	! test -f old &&
+	test_path_is_missing old &&
 	test_cmp expect actual
 '
 
@@ -72,7 +72,7 @@ test_expect_success 'Porcelain reset should remove remnants too' '
 	git ls-files -s &&
 	git reset --hard &&
 	git ls-files -s >actual &&
-	! test -f old &&
+	test_path_is_missing old &&
 	test_cmp expect actual
 '
 
@@ -88,7 +88,7 @@ test_expect_success 'Porcelain checkout -f should remove remnants too' '
 	git ls-files -s &&
 	git checkout -f &&
 	git ls-files -s >actual &&
-	! test -f old &&
+	test_path_is_missing old &&
 	test_cmp expect actual
 '
 
@@ -104,7 +104,7 @@ test_expect_success 'Porcelain checkout -f HEAD should remove remnants too' '
 	git ls-files -s &&
 	git checkout -f HEAD &&
 	git ls-files -s >actual &&
-	! test -f old &&
+	test_path_is_missing old &&
 	test_cmp expect actual
 '
 

base-commit: 7264e61d87e58b9d0f5e6424c47c11e9657dfb75
-- 
2.43.0

