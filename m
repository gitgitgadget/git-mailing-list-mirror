Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F3D226CF6
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 15:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771514659; cv=none; b=Oi9/tJ2fkFGmCvdSuQYE3kkJq0iwAha2Gs0XyUIUc2BUJGu0XR9ml3GkbE9hUOgUErZXrmtP2zpNI/3cd7dZkTm2i2m9nZEfTVmGLsSWQJQVBCzT0/aek2GXAlLSvkm6n7eOzI7nEQALs61TF+O5DzuXDL/HCEP1MSveEnPeR/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771514659; c=relaxed/simple;
	bh=X1dpDMpZDBni3BeuWs0BTQyK/sp+AcQm7l/u2LuYxO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VqOtH0BmqNTEf0Oy3EyN8V0GyynhUpho1elpycHEnKZ2xE0jDoRkMEngjDmO6S/9STlJV+oFeAD6iCeoGMq+8bxBGrbmEIfevIaA68R1s8mc6xDR8TjXenKgO0oFOypQBw2s7J1EwDwPS7+Fl+IxWtPFtO7GZhslrKEYoXvSQoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qc9exbk4; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qc9exbk4"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c636487ccaeso396673a12.1
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 07:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771514657; x=1772119457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F9UDpz9jeLbN/ITkvag3/OjSgtI7frapHtc+8m5nVWg=;
        b=Qc9exbk4d1mJZ4QKcCn4QgcYbaV+7qylgEp/uEwUSaKrgel+yHWigo0nZvOcnk67dj
         CT5q/Io0JViHFP3KhSHvD6bE6DyvnjlATlIipzYNzYFp+5FadH88BzlLLtc19gqkN5qM
         9JWOQHHqu8gMglRXTMVG7TRo4/tMK0YR9RVOW35JRynZLzqDAq0MX+CSLcfwRc/OiNwR
         nzce59/0kGAjWhQNBqHy8A9OxNmDI+p69Otmk6lH64WE6d93SVc+eYYbSMyHFMppQ84S
         zxsNcrMZJzAijsDPT3anbdFKvxRF04vGmYB6OJtchUNv/mjckskYs1pWj4FcOaTQgcxf
         54oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771514657; x=1772119457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9UDpz9jeLbN/ITkvag3/OjSgtI7frapHtc+8m5nVWg=;
        b=dGG1CyLspItbtOXir2fzU8g4H4UzmUv2Sj8P130dUjHrBcuvXCu9taGc6Mg0o3qXxi
         gzJQzEQEoeeTbZ9sJDjlG0NcQMvI4jqRfUHMCPWeMDwJHqhTeGvD10teqgrO8kYe20Fa
         MjBOQqIHQ6ldBtNVU482vuOmGTNcZoX3WEUPkN8oLwN/Sd2ik4zyaiCiAmQqFaPuCz9k
         i/jL5y3gvM4zYfHOEdDNBJkw23wNrhsUI+zRmdoovg4OID2xeK+UbEpRX0nbBl5OGpbm
         Bj+H9Niuux9cCaRk2edDpad6f9mfU4PzJH7jGrLddlTdDkj81KKi9Ytu1rdUayeS0fga
         OSpQ==
X-Gm-Message-State: AOJu0YxksPuUdv4zNuYarZGz2w6GShP0DdFqWIzZEJ4AqXLXquhB7xMN
	vpgZE7iLpJhadssDDCKDhemQH+Pd5u0QL8VP4dBzcnTWAt15Mk98PWKKQDbmfQ==
X-Gm-Gg: AZuq6aJpgfdK8Zs3JxjzI11/FS5tusTWL2dX1mZ7PHEU3HiYTWb6Pr18kPFoiFYlvCW
	3Mr30vFHlGFjHxyoCIlDOCsrlckRo/Iemp1J7aOINdHSSzk4SGR13cRf3PYk0B4RZ6+AyCzOGT4
	dE33EHR1l8PfEZrQD43caglEDx6JWKe+YNgQVU8h3l7kid4pO0RbbfGURxNHCp78k9pyizASp/d
	CWaHklaUQEu76w9DtrM7P8gZwpEVdbbO7cbjSCjMuDArR3giF2cd+slKqlrsRTY9yYIFI5zSqto
	YS3ydzYeIgLdPPR+bh/XRRfd/J/mQBeRTQ4jRcd3i2OlNRENahACupk0d8o08Is/T1+wx1h6Ump
	hv0u3HJo3vYnWqrmHGsNIVVkJkYsufcZJY50xKaMs2sR0A2OAmz74AMuvHcxYuYp3JFou/f7/q8
	b6Ckga3xTzsjFST1WmFUPiIBFyMCPcEz9lLyfiqbFO0WW6Kq8vNx3ocmSR+RYCYHkm3Q==
X-Received: by 2002:a17:90b:3a86:b0:356:2fee:92c8 with SMTP id 98e67ed59e1d1-358937a4c23mr3179054a91.17.1771514657244;
        Thu, 19 Feb 2026 07:24:17 -0800 (PST)
Received: from d.iiitdmj.ac.in ([14.139.241.214])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3589d7f1b9dsm694377a91.4.2026.02.19.07.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 07:24:16 -0800 (PST)
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
To: git@vger.kernel.org
Cc: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Subject: [PATCH] t1006: fix %(rest) test for object names with whitespace
Date: Thu, 19 Feb 2026 15:24:07 +0000
Message-ID: <20260219152407.12160-1-deveshigurgaon@gmail.com>
X-Mailer: git-send-email 2.52.0.230.gd8af7cadaa
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The '--batch-check with %(rest)' test in run_tests() used
$object_name directly as input to git cat-file. When the
object name contained whitespace (e.g., "HEAD:path with spaces"),
this led to ambiguity between the object name and the %(rest)
placeholder.

As a result, git cat-file could not reliably determine where
the object name ended and %(rest) began.

Fix this by using the resolved object ID (OID) instead of the
raw object name as input. OIDs are hexadecimal strings and
never contain whitespace, making the split unambiguous. This
also removes the need for the existing FIXME comment and the
test_expect_failure workaround.

Signed-off-by: Deveshi Dwivedi <deveshigurgaon@gmail.com>
---
 t/t1006-cat-file.sh | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 0eee3bb878..cac88acf65 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -194,18 +194,11 @@ $content"
 	test_cmp expect actual
     '
 
-    # FIXME: %(rest) is incompatible with object names that include whitespace,
-    # e.g. HEAD:path/to/a/file with spaces. Use the resolved OID as input to
-    # test this instead of the raw object name.
-    if echo "$object_name" | grep -q " "; then
-	test_rest=test_expect_failure
-    else
-	test_rest=test_expect_success
-    fi
-
-    $test_rest '--batch-check with %(rest)' '
+    # Use the resolved OID so %(rest) parsing is independent of whitespace
+    # in object names (e.g. HEAD:path with spaces).
+    test_expect_success '--batch-check with %(rest)' '
 	echo "$type this is some extra content" >expect &&
-	echo "$object_name    this is some extra content" |
+	echo "$oid    this is some extra content" |
 		git cat-file --batch-check="%(objecttype) %(rest)" >actual &&
 	test_cmp expect actual
     '
-- 
2.52.0.230.gd8af7cadaa

