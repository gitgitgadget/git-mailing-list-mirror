Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D445695
	for <git@vger.kernel.org>; Sat,  5 Apr 2025 10:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743849446; cv=none; b=dysLzQS5O1cLzgGTY1xTVu4zN25F7cFKWDlZTKAjVmDqIYVTESGOz5LLRVEplymzI8KKf282x2FPEUrtH3J17YbAfb8+aUFbj5IHrg1LQmiiEtPub97+ob1V7Ee0LIkjzwHFpNlBa7ix/dbGS/ukDa87LUvSHMZ9ml7DlcFVtSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743849446; c=relaxed/simple;
	bh=5ynju4y8VYAAKXhHIpNRh80PyhmgKOICLu4rzNngMjw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oFJmt4I9XulHsQEgtDkFdAXnIpR7RdbSpZcsTMcCZEn6/qMfFH67iiWh3Nm/SLn4mMkwpAWwdyo2QAGn+5ueSFiUsoflHupe3f5hdBMSM7FkM4Fl4hHmibIHGSoLQjk/Xd6RDlHeIzNcXtc0zFkVLOnMSD0xLTpItCyWe20VoBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQgixGjs; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQgixGjs"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac73723b2d5so585451966b.3
        for <git@vger.kernel.org>; Sat, 05 Apr 2025 03:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743849443; x=1744454243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CIB7OFd1/rxld7vEF+9zWASzovS5lqu4I/p+IZ5AK5w=;
        b=gQgixGjs60kAWA+eNgEqL5GUxBFPhiZzKOUUGSdVXwQVtDep1ndd2FX8FR6vBsy/uz
         Aktu45tq64Zzut68WstQ/Mh6e4/ZMG5Rd6hdmiNnUXkTOOci03Vt2P2L1ZIBJZOtdpXz
         KeeAq6Tb7rsKBSFJ9LMwNBSg7w4bAwucQSIv+0XqyYjCxphI68WYpXvzHirGIU5B76iv
         bUuzFtZIzXrlaSTc6O9PvkTfy/EYyp+LMdjCW657Bt1cCmZsKYSnQGQ65vuNzwk4VDGn
         MKfnG45D4jKgsr72/FQXxj4BmDyKFXKXuDVY92dyMn9E7uHB70qZtIKnM5Nmn91R+2nv
         sOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743849443; x=1744454243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CIB7OFd1/rxld7vEF+9zWASzovS5lqu4I/p+IZ5AK5w=;
        b=Zh2gxnLj1sL4PgKsQ4h9+PdBtXJ1gE8TRqGtii1qWW6mcS7BQWJPirZPmvIJ1IBE31
         plBtjujYpOAHdkwMkPxlwwsWLIDODot+K+8qjKAOetQd1FTNMhF1HqrGOkb/fhAVmApE
         KzkAbOMcTrcf0gNdlqWjSlr8SlJIYXhybPuxIuMkSu8f8tZucfsp/BHhALKy4iOdKc8n
         6HRe3hn9oqyd4wAbHZ1vczkR9x+vWL3GeeCwDn35+uVWE0nIzbVpvNkLuaOicRciWp4W
         9h3EczjVvSrnvxUIlbqQOMEm8m3zEkc1VUNbRbwgwa0ICG90stVRUgGwxvHP3+8bDxDX
         pJwQ==
X-Gm-Message-State: AOJu0YyeSmshCFobH6EirMCGVmicSvDHf2jljcpIuTh6m0T6PAGlla4p
	a8u2t+HHIxIb7L1aF1tov09W8OqmKqLl2inkDclCMO+VEdSxFbYjQjXCvB1Vlw==
X-Gm-Gg: ASbGncta7hTXL0tzI3uzDepW2ePh1IJFw4L2LDdJye6LNimJhZy/im9Ht+bLzp95/HP
	MNn1pICUSnN0HevEXirq5qXcsXY7u4SCauoEc2rRwMtPMRLu1vdhdBbNWjiwaAwjRAQ2kxo7nI1
	xZQnIvxC9BN2UeiwOFH5UQCCkEdjiVLJX3/GLNpCl8Xe2XtDx27Djr3obLddF/2PODGj7kf/bYn
	q/c9IW6xCdW1U5u6ygvbuii7R9yw6DX9JerxtRfiLH7GjvYRcTuGXxMOymhoJfZM//uy2zZOcV2
	+csewQjnGZHq7sDcqfRLwW7yJJcH8EEC/SxPRrncIetLG251plzoPseJxdgGmzeVcl6rxWBWlCz
	vl+FvVzy6ZPsw4KNteduM5M9fTL6oNUiYC2PLctppuW0YysyyIhadbx3dwloZjW5H5oQ1DWaCDq
	0YeICpyfIvo5WovKDnH+z5gFU=
X-Google-Smtp-Source: AGHT+IED0F0siZ115q/DusbAJ8lL4iAcbZqhZSlCF/tJlL/joQl76EAdveVb0BGqpG2yXezWBVTWvg==
X-Received: by 2002:a17:907:1c09:b0:ac1:f003:be08 with SMTP id a640c23a62f3a-ac7e7116ae8mr216236766b.12.1743849442808;
        Sat, 05 Apr 2025 03:37:22 -0700 (PDT)
Received: from Anthonys-MBP.homenet.telecomitalia.it.homenet.telecomitalia.it (host-79-1-195-126.business.telecomitalia.it. [79.1.195.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c01c219fsm393187866b.169.2025.04.05.03.37.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Apr 2025 03:37:22 -0700 (PDT)
From: Anthony Wang <anthonywang513@gmail.com>
X-Google-Original-From: Anthony Wang <anthonywang03@icloud.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	shejialuo@gmail.com,
	christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	Anthony Wang <anthonywang03@icloud.com>,
	Anthony Wang <anthonywang513@gmail.com>
Subject: [GSoC] [PATCH 1/1] t9811: avoid using pipes
Date: Sat,  5 Apr 2025 12:37:18 +0200
Message-Id: <20250405103718.25160-1-anthonywang03@icloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The exit code of the upstream in a pipe is suppressed thus we lose any
exit codes of git commands that are piped. In order to ensure we
pick up the exit code, we can write the output of the git command to
a file, testing the exit codes of both the commands.

Signed-off-by: Anthony Wang <anthonywang513@gmail.com>
---
 t/t9811-git-p4-label-import.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index 5ac5383fb7..5abac938d0 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -95,9 +95,10 @@ test_expect_success 'two labels on the same changelist' '
 		cd "$git" &&
 		git p4 sync --import-labels &&
 
-		git tag | grep TAG_F1 &&
-		git tag | grep -q TAG_F1_1 &&
-		git tag | grep -q TAG_F1_2 &&
+		git tag >output &&
+		grep TAG_F1 output &&
+		grep -q TAG_F1_1 output &&
+		grep -q TAG_F1_2 output &&
 
 		cd main &&
 
@@ -208,7 +209,8 @@ test_expect_success 'use git config to enable import/export of tags' '
 		git p4 rebase --verbose &&
 		git p4 submit --verbose &&
 		git tag &&
-		git tag | grep TAG_F1_1
+		git tag >output &&
+		grep TAG_F1_1 output
 	) &&
 	(
 		cd "$cli" &&
-- 
2.39.5 (Apple Git-154)

