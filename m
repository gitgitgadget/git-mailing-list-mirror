Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2F01D416C
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 03:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767928848; cv=none; b=Qld0TT+VPBlP2yIBlko6lqAxgHP/42YjzLXMNAe59bHki6SRzrqFjMF5ADaBv0G2spASR8J5q91OMXXVKPRdkojDm2QyweBXYEo45JdJMsIexJQiQ+TgXcaDbq1XmAnGRphIXJCuxoPGokRzaYccBNvqMA1aANDZL0s7xGM2rfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767928848; c=relaxed/simple;
	bh=TdKShECIjoNsuOafrMmBIsGUu4/9EjGeeOYEVCKR5NE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m309UH+ylKV9s0UHLnAfidLMiyFvj4tHNEwJg3J+8ZlpBBZ+TkYreESB2Y6/VRy/FbQH5WJuXIpgAbf1GBnNKylEKjflxX3vDK2c65jSd1RP+Xl7anyJSYHiAHWc0oeeklGobMJwZLryGKzuJNGv9Nw9iMCeMKQiYj4Jx6ZqbUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIuuhjzf; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIuuhjzf"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0bae9aca3so27140805ad.3
        for <git@vger.kernel.org>; Thu, 08 Jan 2026 19:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767928846; x=1768533646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qyd30m8tmbB/fbBp5EIalBUYj5NgADiSUASjbD6aqfY=;
        b=kIuuhjzfY9Hj80VqT8cbqIa83VuTJTM1U5qBaxQZ9lQ7DzcukvYHY7wHoO7iohPhSQ
         r3QXaBIo0JO3YK3vKWt1hzsj4b9I6ID4+EieWQ4+41oENBWlLhZxSjW9D9ED4gVvdf0z
         a0Up4AnjSTflu9RWbWUlMIQd3GKHDkmIZlDxvKZv2xrjsR70PALSeaGV//RvBnHYFkLL
         OduGp2y4zA2qPI+QPdC997OwtxRdX/ew5Jkp8uCII7UiPfcu4B2FMb4BO8eQrQtHcRQT
         UbThlx67sFKZdcNLWMD28w2o40ua0cB7oqMc9Sza+cWpX7hLoqf17zUMTVWjB/7+ZNGw
         GdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767928846; x=1768533646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyd30m8tmbB/fbBp5EIalBUYj5NgADiSUASjbD6aqfY=;
        b=kIdPJafqxIr7E2471l7VOoVhpuqv8yZqNSF8mwe61AA3v4AfMsInGZYwqE7cZZoazy
         mE/Ak/s0AWUr0Xa4dZycp2qSkhFvxb+SlpMY4xJCqO6+GiK2DSmNS9ZXePOsqLqCVngO
         LASUhdRTIb3YfycLGZsXHWXOHp21pgFkaW7+eVk3/6EdoT3sApPl+9xi0Ge+51F6s4qz
         H6X3iMx/V6neEi0KAdhGJr+7LzToyDXSBvsacGPQk9dWUptkNwfpmWnfM/MVauATER6t
         weewFKhfwaOIWW9G8xwwak0lC9DjBCvEsLO+mJ6FMmSrYT/xMG194IUkS9sp3ubzI6Q+
         /C5g==
X-Gm-Message-State: AOJu0YyOhFee0jw2eaEuEZYe/kufm4vTwPKXvXQh09PG6ocCSOUHXGBD
	qteEeHkGrHvHnuOLB9dAqk/fWupRipAJxCxXTPu5TckmAIdngYiEy/5gVNDzD5D8
X-Gm-Gg: AY/fxX7K7Du8Xfl9iMnrxcLqKKCmuy1eOY8oHNJKn5R1AaA4l9wkskTtbOSgf1Ikvi+
	/PggEjCmO/XoCT0TfDTM6fP4sD9qpYtxiJO8ydHt24KQtleDxzABo3RwGqWWykNDO0ykxJ69N2j
	2/PaZsMKX5UnsnDJa4SHogHNqmxLmyPknCFhZSb25HV/CUZAFML98ye8xswEjkPyD1yTAUpfHEr
	9Q5iMuUrhHCwrQvWE1Zr8bNQzFyfzZMXDDo1a+AeyY2AYpsgvKIoaBZicVFu8lNUtD74h8WiVX5
	bVoGZdjj2x2YxB7MUAeKK4THmCOmhkNgcjLkFYiCz37YeC5GmG6aRC/fyKhhhbUXvNAJ1PS49rK
	VoagJR4j5V2OyvqipU59sHft+HUcoiQd+lHTJsrKk10VFufksW6swt1B6yzLufGYAFKhXxzCiRw
	jWn5XoSe482fbkO7d5UCECPXxz3CkJzX/Y2hrWhZ/eKNU=
X-Google-Smtp-Source: AGHT+IEQ5pa5O85zlVCTrxEfYjE7an61L+HrFqIvlZQ1bi6YubKMdFowdQQPA7BWnQRqvhB6OrTN5A==
X-Received: by 2002:a17:902:ce0b:b0:2a0:f488:253 with SMTP id d9443c01a7336-2a3ee4f37fbmr86488765ad.52.1767928846210;
        Thu, 08 Jan 2026 19:20:46 -0800 (PST)
Received: from Fedora-Gink ([2409:40f0:1042:a68e:c3ca:42a2:7857:468d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a2f7sm92481215ad.16.2026.01.08.19.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 19:20:45 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jayatheerthkulkarni2005@gmail.com
Subject: [GSoC] t7101: modernize test path checks
Date: Fri,  9 Jan 2026 08:50:27 +0530
Message-ID: <20260109032027.68680-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace old-style `test -[df]` and `! test -[df]` assertions with
the modern `test_path_is_file`, `test_path_is_dir`, and
`test_path_is_missing` helpers.

These helpers provide more informative error messages in case of
failure (e.g., "File 'foo' is missing" instead of just exit code 1).

While at it, fix a typo and an incorrect path
reference in one of the test descriptions.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 t/t7101-reset-empty-subdirs.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t7101-reset-empty-subdirs.sh b/t/t7101-reset-empty-subdirs.sh
index 33d5d5b76e..d1d3e231fc 100755
--- a/t/t7101-reset-empty-subdirs.sh
+++ b/t/t7101-reset-empty-subdirs.sh
@@ -34,32 +34,32 @@ test_expect_success 'resetting tree HEAD^' '
 '
 
 test_expect_success 'checking initial files exist after rewind' '
-	test -d path0 &&
-	test -f path0/COPYING
+	test_path_is_dir path0 &&
+	test_path_is_file path0/COPYING
 '
 
 test_expect_success 'checking lack of path1/path2/COPYING' '
-	! test -f path1/path2/COPYING
+	test_path_is_missing path1/path2/COPYING
 '
 
 test_expect_success 'checking lack of path1/COPYING' '
-	! test -f path1/COPYING
+	test_path_is_missing path1/COPYING
 '
 
 test_expect_success 'checking lack of COPYING' '
-	! test -f COPYING
+	test_path_is_missing COPYING
 '
 
-test_expect_success 'checking checking lack of path1/COPYING-TOO' '
-	! test -f path0/COPYING-TOO
+test_expect_success 'checking lack of path0/COPYING-TOO' '
+	test_path_is_missing path0/COPYING-TOO
 '
 
 test_expect_success 'checking lack of path1/path2' '
-	! test -d path1/path2
+	test_path_is_missing path1/path2
 '
 
 test_expect_success 'checking lack of path1' '
-	! test -d path1
+	test_path_is_missing path1
 '
 
 test_done
-- 
2.52.0

