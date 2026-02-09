Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592F2388855
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770657894; cv=none; b=KamKlRr0cdG+NZ89rPoxD1LNIhjm9VXOSgFlDznyVWyZbxcY9/4L8dDrVqI5pw5tQLl/Vh2eEuBWjsprpimM89Ui4+d6/1N8/PY4q65mbyS3TonQYPazNiGZ1PAr+vA/4h+I0zQVrxwqdV7eI5jt2f/VE0TGcRgytJjzr8yWbsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770657894; c=relaxed/simple;
	bh=a82yWIt8po3vAqjPWQYnNPogA9xLLS5JoE+fjFOkZvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sb2didsdEk7NSZ8tR7ixi81oLDHgylGjspi4dVr9UQu7Rrk8hhSw8T3fZgiVd4pgtKk02dQ5eDVwhvOpSm/j/kAjLjkviiHZuVo7WN02dfFSqzpJ+i3pK2QYUn1nflmePnR8zSY/BQhCf0wM11xvzjnOan4iJibYbjnaZxfnEnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdGwYR6t; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdGwYR6t"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a871daa98fso22630775ad.1
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 09:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770657893; x=1771262693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DHNi36UmceoskJ8WBGj2rhB+wqnK7lXtlsh3u5liYQQ=;
        b=FdGwYR6tqT8Ow4lbQ60hFaHh3SH3LOUvAaXcP9iavCL/wDQUWjn06QI9+DCjjT2GDs
         ZzRbosopUM9FyWphUbHo5pvGc8yZWuDddbE+SWnKCTbPPtyFlBzhH1kZ5ULR6VklADnE
         M3aEgUAVKJ9Puqad8+NmDAjU9aozGRx9UO7ufA8U6A6XkV+GuaLCTOEAmA3pqc+4P/zp
         NYN70VaEr5TVXdK3xkdHNkaSdGi+iLUzXXivYZwpxPGcHKVuJ+2Qzcnxqh7J4fHIniPC
         GuK0RJevpcY75pU8LNU0L36pgVZhAliFBKihZrvwQR2iEVHXM1KEe2DIpzkkoUJzAq1H
         BbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770657893; x=1771262693;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHNi36UmceoskJ8WBGj2rhB+wqnK7lXtlsh3u5liYQQ=;
        b=qYjooK83d6iYNZdmVQoSuJp9ht+58rIV2k4ojetug6t02SGjPz3ewEF4Zw/pxwV+Pw
         M2EikE/CYIy8WJ1w2F3ljZxrZ279kyWfO3DxwWtpEYH+YfwGtem3XhYjoAxPYJaIfJIi
         Ic0u4B5GRsB3ekjsJ8cDDyTYEFjwZ1iWB300yiOCsw9vv4NhP9xnYoYXRcdfvL5ZcZon
         tFyeC5i6y0hprngHoOOxoYGvMOYxI80pHwO+TjEfUzjnYID7T7B6/Xf+0Rx79jjZE2g2
         sU61+zjz1SR84nA/zVUiuG90kyAqVbo85g57ov7BrKC6MKylQmxFPxkHW8jHLxSeWjHR
         T8XQ==
X-Gm-Message-State: AOJu0YyngXPwJoa9aJRU4IrzTlisQQwlpUSz9nM9FbDbrk3cp1MsQ+8x
	T8WODLJ9h3CRaL2oiaI64TCmyY2TEMS2PjwFeYuTO3eHlHjQNxrlcx8DrQMbbQ==
X-Gm-Gg: AZuq6aIP/VZGzIlx5lsF7RRCXOMJ7JxcAjF/ynDcFnAraMlQ4T6Wrz50TpJaTbUMlpt
	/yo7Pmx+cDrI3fXQKzcgTfQV2MXwj2srO9vE85nc+pQcDxtPUK0z1KGBj25HstbeCCO0uJPiZu4
	Ap8eokFlWjYjjwCFRQOB02+WA7a9M++ZPsM5uU8w+MOFk42prgEGeeJEv/t8iiIgOZROjx/ICql
	tixKDxnvzvhEw/bkYs8BpHy6Ug/Km2pMMpai9yYsQxuf2ps7DOXxjj96geSbAp+8R3DLCGhRAkp
	DzpuU7O/cyvx5C177yu4CX7t1p27wGqiCjNXNlHeMzupdeJyQ7pESQe1Y3fvLG/VpDMgcG6JdNq
	ixFKHjWw3L0DweJiFOXugyetYZGNCARYqyDEFTmJJTP/s1SdRU5oULbhqIFmZHWwCd9P16MOP3o
	OG1gPLS44OXqOQ15AQoeFw7NjXuutJTSKYBkisFesaSEHOWxD13XogpGoxCxed2C5aZSeO3k025
	Gmr6Imn21S1JVuMUCepkZUL8lGnZ7LctPV5qz5wMDr+1fUmeV5T9vpjQQbwCjE=
X-Received: by 2002:a17:902:cecc:b0:2a0:e5cd:80a1 with SMTP id d9443c01a7336-2a951948e5fmr122953555ad.41.1770657893224;
        Mon, 09 Feb 2026 09:24:53 -0800 (PST)
Received: from localhost.localdomain ([2409:40e2:8:69a7:859:b7cb:71f6:672a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9522128a5sm107267645ad.86.2026.02.09.09.24.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Feb 2026 09:24:52 -0800 (PST)
From: SoutrikDas <valusoutrik@gmail.com>
To: git@vger.kernel.org
Cc: SoutrikDas <valusoutrik@gmail.com>
Subject: [GSOC PATCH] t7003: modernize path existence checks using test helpers
Date: Mon,  9 Feb 2026 22:54:45 +0530
Message-ID: <20260209172445.39536-1-valusoutrik@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace direct uses of 'test -f' and 'test -d' with
git's helper functions 'test_path_is_file' ,
'test_path_is_missing' and 'test_path_is_dir'

Signed-off-by: SoutrikDas <valusoutrik@gmail.com>
---
 t/t7003-filter-branch.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 5ab4d41ee7..c475769858 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -92,8 +92,8 @@ test_expect_success 'rewrite, renaming a specific file' '
 
 test_expect_success 'test that the file was renamed' '
 	test D = "$(git show HEAD:doh --)" &&
-	! test -f D.t &&
-	test -f doh &&
+	test_path_is_missing D.t &&
+	test_path_is_file doh &&
 	test D = "$(cat doh)"
 '
 
@@ -103,10 +103,10 @@ test_expect_success 'rewrite, renaming a specific directory' '
 
 test_expect_success 'test that the directory was renamed' '
 	test dir/D = "$(git show HEAD:diroh/D.t --)" &&
-	! test -d dir &&
-	test -d diroh &&
-	! test -d diroh/dir &&
-	test -f diroh/D.t &&
+	test_path_is_missing dir &&
+	test_path_is_dir diroh &&
+	test_path_is_missing diroh/dir &&
+	test_path_is_file diroh/D.t &&
 	test dir/D = "$(cat diroh/D.t)"
 '
 
-- 
2.52.0

