Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6C82BE7C2
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 18:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762192929; cv=none; b=sNXDh+T6GoJpqnPysZRdstlm6LK4PBDjCTKGQgRtkbhle5xS5Yv/lk1oCwJuCySxNUsZfQwYRl8fdhFpEym8YNPEQJGjfdyEPY7J4mPzTYSXb6bQ4y6x0PDyDebCeXt0C9KQZQm57IJpjke9LicfE8Nzf4xZLJhB8xrxYDRpESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762192929; c=relaxed/simple;
	bh=rBrH8Cn8hJs28gG/wE30+c+tvfwwNyEAQxA7uMg+jCw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bkMmFf88E5qe26/t05wKPkEOkwMcF2F15Siff2gak4e3lHqp4eRb+zNHDz7i61qShk3EIr+K0ckZ10pdYHYMMzfFPToNUXdNDOtUuEqTSsOdZO1TzSbx+mPB5cQdVe0Ulcof4k/gINoDxKPznAhfmOnZO/rz2MauMblwlkv5w9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kw/CYdiL; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kw/CYdiL"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-54aa4b86b09so1457973e0c.0
        for <git@vger.kernel.org>; Mon, 03 Nov 2025 10:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762192926; x=1762797726; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iwh8X28bwbs3OGf327wrB/dZ/lKzTLBIGFzYu7H0O8s=;
        b=Kw/CYdiLn+1DQYwTjnkg8AQ8UPoV7eWKFOEMQBkqeTuIX9mmr880Az4Kua/oXpc+ik
         MisSvx/C5gvJFn/9kp4DkvkgEH9NbkRLRVwzUx5frh/moMezK+RZln+EPixv+rssmtzg
         Q8TDD8Gw4yYvO70flsY+hhS+ibsD/MATqWpVcAlFqTuMpyN+Vbin95X8gii0T1r/gUNV
         Xn95TXVVJkp7ch+8OxmkOJjd/7yIWhVBJh+ubOOCiNVen4R+2+s9oPQkLg4ExvSqH27j
         Rbsx1VMFl6B9rDASkktfCfqBokPcHec04SFgpjqFHMMKPokMIXCWz6rZK/TtRw0SEJh/
         emxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762192926; x=1762797726;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iwh8X28bwbs3OGf327wrB/dZ/lKzTLBIGFzYu7H0O8s=;
        b=UILylxvTgXNi0X96QhRPazT/TPA3tabnZZ/M0hBI7+Y30NmVwaFQuDvrgpNf5wg29v
         k/IzW6UXR5d7s16SFI0qSFA8pDpfIjYKk1dgvEEgDSqjPfIJjtSDZYFpKbdlLznfKh44
         49ooortJlFet6/tau6UKhXUGxf/8T3OfeMC95cLm4sFVw3mtT8aecGtBglgaNCreAsH0
         qLr0ISDRWlvkpUz2uFR8KplYQwBpVr+56xzVzHQ1ehnE0uwwa4mt0q8fhkLEOTaXvNTb
         T+9co/gDv0FJH+6X7kJvk8Tvxp+Hbzs8DOitdusoqQFRiSLE53Xfz+Wg9pWnFgAXLz22
         nHRw==
X-Gm-Message-State: AOJu0Yx/Gfp4yZ/h6sG+WSB5X6sUyzQihUnFmuPDTq/okB9/NLoL7tqt
	pnfjOlYwd8dvgfsf2bs4OGVeQCsrwUpQiBTyV3GAZQ/EB0PsCHEbnuACXc0c1xed
X-Gm-Gg: ASbGnctmQZ7bUY9IxZZ9b0xhMwXMY+zTTos8YZ/y/PCd+Xy4rqfJWVUSWSdTDUmDSih
	I4jE5LoOX+cXEwDMIDaWoBKJBvXkRyQVcDlK+I+JwSQBWRVtwFHcBElfEmj+D7IEHIuVme9ADRw
	/FkCVTJ+FDKHm7qoPaHJpe19rxOYu/gdltI+9pkhkMJcq8A+POmUoGVPPb+yyxzYMrQnVFuX/nd
	xOviH9IGj7IVp1qz48ir+W9Fs8VU3GMW8XjyOX8Y6FK3U+MQjIs9PsJ9LsKx6aMH0zjy6P0Kwds
	kD/eulpkdTCzhwKDaIFpuhC9Z5rk2NC+zVbbVoqXWaNUL0bTek40rjopgLRSOBcKkaGAJ2AICL+
	Xr8g2b9xsKPaF59l5elw9P9TnQRm5skqxyo3n43iHkoRlkQSvh3S161AudAMpkCvxOSkBMeBKPb
	a4A6w=
X-Google-Smtp-Source: AGHT+IH+kUNKhvSTe+XT9XVjI2z+Hip7RLchM+kR/fG6yKGibZwbdY3oT5wgqHkuSFq4LELrvXoq/Q==
X-Received: by 2002:a05:6122:4695:b0:54a:9e02:f9c2 with SMTP id 71dfb90a1353d-5593e458613mr4072902e0c.6.1762192911765;
        Mon, 03 Nov 2025 10:01:51 -0800 (PST)
Received: from [127.0.0.1] ([145.132.100.68])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b0f808df99sm27596585a.47.2025.11.03.10.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 10:01:51 -0800 (PST)
Message-Id: <950236f0f812197e260159a688fc6f6fa61046c7.1762192908.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1992.git.1762192908.gitgitgadget@gmail.com>
References: <pull.1992.git.1762192908.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 03 Nov 2025 18:01:46 +0000
Subject: [PATCH 1/3] t6429: update comment to mention correct tool
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

A comment at the top of t6429 mentions why the test doesn't exercise git
rebase or git cherry-pick.  However, it claims that it uses `test-tool
fast-rebase`.  That was true when the comment was written, but commit
f920b0289ba3 (replay: introduce new builtin, 2023-11-24) changed it to
use git replay without updating this comment.

We could potentially just strike this second comment, since git replay
is a bonified built-in, but perhaps the explanation about why it focuses
on git replay is still useful.  Update the comment to make it accurate
again.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6429-merge-sequence-rename-caching.sh | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/t/t6429-merge-sequence-rename-caching.sh b/t/t6429-merge-sequence-rename-caching.sh
index 0f39ed0d08..dcb734b10b 100755
--- a/t/t6429-merge-sequence-rename-caching.sh
+++ b/t/t6429-merge-sequence-rename-caching.sh
@@ -11,14 +11,13 @@ test_description="remember regular & dir renames in sequence of merges"
 #         sure that we are triggering rename caching rather than rename
 #         bypassing.
 #
-# NOTE 2: this testfile uses 'test-tool fast-rebase' instead of either
-#         cherry-pick or rebase.  sequencer.c is only superficially
-#         integrated with merge-ort; it calls merge_switch_to_result()
-#         after EACH merge, which updates the index and working copy AND
-#         throws away the cached results (because merge_switch_to_result()
-#         is only supposed to be called at the end of the sequence).
-#         Integrating them more deeply is a big task, so for now the tests
-#         use 'test-tool fast-rebase'.
+# NOTE 2: this testfile uses replay instead of either cherry-pick or rebase.
+#         sequencer.c is only superficially integrated with merge-ort; it
+#         calls merge_switch_to_result() after EACH merge, which updates the
+#         index and working copy AND throws away the cached results (because
+#         merge_switch_to_result() is only supposed to be called at the end
+#         of the sequence).  Integrating them more deeply is a big task, so
+#         for now the tests use 'git replay'.
 #
 
 
-- 
gitgitgadget

