Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E454BA45
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774183596; cv=none; b=EsdbQvCdi0xhMM8+rybEvypunv5lJb9KeJz+hhkFhpK8/4LUaJBL0TI/EIDBeJWBpRYkRAfZbqoK8hwo0+/JGTK+Tg2uUh6QUmdBWl2gDgvELlLvKVP/PIU42Kz/Kw6AS2OMkZy0SNDePTgF2QiuCgTJmbT43QRzRCc7sX7djeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774183596; c=relaxed/simple;
	bh=WJL10xkwQHXRAhfTNTzFd5gHN1WFi0xc17CTl7QqpvQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WVPI+NQufriLYr6gcgd7eoZ3+6vv/GvPAPDK4qprfhMGdy4YMhky04FLwRzt+KT9mWZ7qLCjmR/htpNtOzZ1rSK0l5CUsTGtpSQVxQDCgQPR9noF5vOtgVMZ+hpTENUOCkMjWtim9ogIjG+GRE6OfiOyxhIIN3htheajScnIQ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUM3Dk2k; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUM3Dk2k"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2c10a2e2cd1so546531eec.0
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 05:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774183593; x=1774788393; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wW50A7J1hYoG2SHR9tJGIoDA3JM3yroUmxUdQnw5s0s=;
        b=PUM3Dk2ke2qLWgG8BGV4GsKt4nwcymtKZdXplIw8Qmy2JpKJgN2DscvKkXjrbrwjU4
         DLdc/H/DEMSvxwFfFH3d4wEtOWIiOftBp9FdxEb7QLUwMgEaafwqLa1SFlKJjV3VqJII
         HQyMT5O7rvOMdiIb4etE4keUzIaVrTTjj2z4tsmwAH0rQJ8NGca2GuP8xwymnbkxeELf
         L49RiCUNg9umaVstcp8c8ZWcNg2pxvwUb+vmKZNZuyzICog5I6X9TS63lFoXnn6PV1Sb
         yAbDnJDfYBlIbPSh4q3eaxCub6CP2JO0wQYeq1c9fHHIpCq6lgFbnyZzP4GOScWJ/A/K
         /t2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774183593; x=1774788393;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wW50A7J1hYoG2SHR9tJGIoDA3JM3yroUmxUdQnw5s0s=;
        b=UD/bFjyeZQxzLwWK5dbFaL5ejDVQSWSvpFECiG002YW+Y0jG8R7QNaOpFHkRocm8dE
         VPaypaRIZKeC/6Fqn4SXldvl0rBcxKQBL5tH40qCOMEaxl+793nQ1rMKtks1+5kbzwYZ
         zBJPLpKfHMgVuzb2BxtnaAANw5HTDGCXlzXpwdl3+8N2J1QFvUioipYAW3lxLdKhTdru
         +Uzi769FfNipS5ZemJBoHIWDSgn2XJNt36NkOlrBy+iuCaW2M1VpJ+m5cEnV06g7Q9Yl
         54MjhpvL6QqDIAHtHIW+A+LNSot6BUTiy2znvr1k9fHXVYFWIJxSQuwu61mIo58j1+nO
         5MHQ==
X-Gm-Message-State: AOJu0Yx/u7uuFYKKON7LWzCZ5lWxYmE2C949+ZuijMSM7D6YcWuoKTA8
	LeOZ2Hv376pToTefdfSmWa4W9q5uaaGwiM9fXLKR2BJVxPVYJT7IbOgTCrGw0w==
X-Gm-Gg: ATEYQzwRDXIYlg2MNoJieEEtKd/iAG/Sp1OP2qmvdX2TOaRTJab6M51T73M/3Ocxuxe
	VDe3MV8UiuDWiq8NhCjRp8PPaJmqk8VnVhRzVohiHWdq/KsMGD7kSOZ0piUp/sxTKITvWDS0Xyh
	ms9RD6JyACCuJfZZph2s4k98I5Ry2t+WSXXXHd2r5HTRtIZPhMrkCvWwSuqNyak1bA+GLsOLt5c
	XgNLyn0BY0AoFb8jPnpnVw5zpcHFHKf8KwQgln1FifKR1QuAOkLDXzUBoCuBV+bdnK75OCw6Pgu
	DvpEqYOkh4RAQh8cnr7R2iaZlGWdv8c431RhuwWSjJoeO+lFNnEjSs5sTtaYyGssjxijdliOSgl
	NgYbc6cPDDMEL+YXOxEUd52JJK+Xem4xhnoV2n7P0oln4jXoP5u72Jbu79Hf4DKn6SpOZKEqnDQ
	VjXFUcEfNdnJ1dTGuKW2s7qCnczG8=
X-Received: by 2002:a05:7301:4198:b0:2b8:26b8:3444 with SMTP id 5a478bee46e88-2c109712d6fmr4200524eec.19.1774183591801;
        Sun, 22 Mar 2026 05:46:31 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.160])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cde3bsm9824662eec.20.2026.03.22.05.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 05:46:31 -0700 (PDT)
Message-Id: <d9fff1ad4effb57fc0c814bee7b33c84ee40f7ca.1774183586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2247.git.git.1774183586.gitgitgadget@gmail.com>
References: <pull.2247.git.git.1774183586.gitgitgadget@gmail.com>
From: "jayesh0104 via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 22 Mar 2026 12:46:25 +0000
Subject: [PATCH 1/2] t/pack-refs-tests: drop '-f' from test_path_is_missing
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
Cc: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>,
    Jayesh Daga <jayeshdaga99@gmail.com>,
    jayesh0104 <jayeshdaga99@gmail.com>

From: jayesh0104 <jayeshdaga99@gmail.com>

test_path_is_missing expects exactly one argument: the path to
check for absence. Passing '-f' is incorrect and results in
"bug in the test script: 1 param" during test execution.

The '-f' flag appears to have been carried over from the
equivalent 'test -f' usage, but test_path_is_missing does not
accept such flags.

Remove the extraneous '-f' to use the helper correctly and
restore proper test behavior.

Signed-off-by: Jayesh Daga <jayeshdaga99@gmail.com>
---
 t/pack-refs-tests.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)
 mode change 100644 => 100755 t/pack-refs-tests.sh

diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
old mode 100644
new mode 100755
index 2fdaccb6c7..8a0c955647
--- a/t/pack-refs-tests.sh
+++ b/t/pack-refs-tests.sh
@@ -1,3 +1,9 @@
+#!/bin/sh
+
+test_description='test pack-refs'
+
+. ./test-lib.sh
+
 pack_refs=${pack_refs:-pack-refs}
 
 test_expect_success 'enable reflogs' '
@@ -61,7 +67,7 @@ test_expect_success 'see if a branch still exists after git ${pack_refs} --prune
 test_expect_success 'see if git ${pack_refs} --prune remove ref files' '
 	git branch f &&
 	git ${pack_refs} --all --prune &&
-	! test -f .git/refs/heads/f
+	test_path_is_missing .git/refs/heads/f
 '
 
 test_expect_success 'see if git ${pack_refs} --prune removes empty dirs' '
-- 
gitgitgadget

