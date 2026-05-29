Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42616351C3D
	for <git@vger.kernel.org>; Fri, 29 May 2026 01:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019730; cv=none; b=lpz0+pynbnfCEAOBTQ9bkY0pZadicqK1E3WvilQ0DcdBFwxpUL+NnVKMHVE4I4EOoTyOTeAKSnP35bBNQzFGBn2gS4KcRQmc6XD7S2Pet49nVmwZw3sy0m9wpCBwiroZXTmUjVhowaE7GtccTHsNZ0MLBdy0T5vVnXm49PSgzCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019730; c=relaxed/simple;
	bh=d419zB4+5bB3icqFmGcffSn0K8Kw3ZeCNFsVM2uCaxE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=fYwKD0IWqrGA05uqNoR43Ea5pQe8xMpautprrj4wn9s/HAoV28rphV3aOeIL+ZEQAP83Lnhh9i3KPzM25szumjijEKgtj3SPJi+9fhbkw0JrKcnGUeCjpaT1qxutJ+rKZTL9hCquY7twRoMKHPzNYG36Tr9iTZjyFty7K08kgAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YI/e7xN6; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YI/e7xN6"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-914bf8abeaeso557582585a.0
        for <git@vger.kernel.org>; Thu, 28 May 2026 18:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019728; x=1780624528; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W6KO+YS7iDJSFK+xLVU45EWMo8Dliph6j8ncV6BJk2Y=;
        b=YI/e7xN6hRrJGstbYL6tDppHmTNYpz7dvRmOugYFfAIO2u9pka4+tWHFIEJc1lCCIb
         WO343lqLohJ21BA5zz9KCTR+qO3Kp+cGv/Q7cPazNuoT+GzqWDDoj/rlvrbvWSPy8/t8
         Rlmo1kaEDv7cY6w2wT6xjKMtpmrAFxTzv0XeO18U6r6iMFqNcsRAdQSkVy5tVWATkXUP
         2NnjE1+cnHs5M1Dzs4JK3nyfDN1pjeA6MU1pE9KcFsM4n+9bsY8zwIWcKnOHpcAfAmA+
         NvReZmfhSd7L3ZB8uEP7KuJ9VeBumQzRVmFr2VLLg3gkRfPyvMJjMGac4iLxvF1VBVvS
         Koiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019728; x=1780624528;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6KO+YS7iDJSFK+xLVU45EWMo8Dliph6j8ncV6BJk2Y=;
        b=SevFTWqZMhpWWeJqgbcLnei8R04+o1HxzpcV4gLGjwCWDeXTDs6hB0lX8GMKOYJocP
         7LPa6+PX+sgqEc3GRKkKLLuKXf7brfFo9dseGpbHh6HqURQpwPOSTyIql5RxsK7B/cce
         ThU62Y4q6RJ+IZyZbjXkQWjWGuSXMtYMEM+AROM/xwNoBb27s5xTas1k8ngTY+draOsz
         vGVFPjYOIG1cRERYAwZnBbLLf3bzc8zb7TbMlvNo7NWAhgSf93wo/nR8e/TCm0TFKPVX
         sMPLPSc2tWpNoFw+cv6veodvWQCOPjNtCZmwvSj2LeEm/MbCVPA4hqMe55z2pRM433bg
         LpPg==
X-Gm-Message-State: AOJu0YxlVAZ62IgY2lOykHs3WC4iY9pAnVLbLuE4JbzpVATlxmgg4rZ1
	cErlHuDobRARFeQ+RZacug231FOjEHUdZ1A8k/er+Rhqxfs1VHKtJ3QEr3fLyg==
X-Gm-Gg: Acq92OHsLKJj/pBgoHg3g64yOPBzWqGiDvQOvjT3egxJQ3fzaHoI0rdrrqiwX0jH0yw
	tdqo82ZrSchQhmz3mDXePAEhP6JcyTVXXXVc0M4eDsVUrl1lR5MTxQ2AzRFfEEprO+ighM8riiX
	mstUtpiQmCfxLYDa3rUIfj5UL3QMh4GtC42EzYlB4op4lkWBqZr4TuUvKJl+fDz3U8xDg+Z0CUa
	7mwooUVfcNzTlXS04lan9OLiraDSDbmWIBemzKijEeEbwtSv/v+LxrBnYbOJ2u2X0gkHwgP5bc7
	awZ0Vu0RxQWN8qNk3tBVyKXv57vBtc0iQUctEeGZui/Nvb1BdRDUeAPZS873WKw3UlDEAu1mEbT
	6C8O/hwRwPfd1xoQk21paKEgiT0XL7hluL7z73UlpQqd+KHVfDKq/5/FxSqYAjpfdYFcEFfg3cL
	UTVgpeEsm0XZPP4QumPb2xXUiToHpWHcQLWM8=
X-Received: by 2002:a05:620a:2815:b0:914:e691:60ce with SMTP id af79cd13be357-9152fd6250emr124519185a.17.1780019728150;
        Thu, 28 May 2026 18:55:28 -0700 (PDT)
Received: from [127.0.0.1] ([48.214.54.48])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153262b95esm10627785a.37.2026.05.28.18.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:55:26 -0700 (PDT)
Message-Id: <pull.2315.git.git.1780019726297.gitgitgadget@gmail.com>
From: "Brandon Dong via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 May 2026 01:55:26 +0000
Subject: [PATCH] doc: add missing --message long option to merge docs
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
Cc: Brandon Dong <brandondong96@gmail.com>,
    Brandon <brandondong96@gmail.com>

From: Brandon <brandondong96@gmail.com>

Include mention of --message flag in merge docs to match what is
accepted (builtin/merge.c) and to make it consistent with the git
commit docs.

Signed-off-by: Brandon Dong <brandondong96@gmail.com>
---
    doc: add missing --message long option to merge docs

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2315%2Fbrandondong%2Fmerge_message_docs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2315/brandondong/merge_message_docs-v1
Pull-Request: https://github.com/git/git/pull/2315

 Documentation/git-merge.adoc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/git-merge.adoc b/Documentation/git-merge.adoc
index a055384ad6..6581f4c69c 100644
--- a/Documentation/git-merge.adoc
+++ b/Documentation/git-merge.adoc
@@ -68,6 +68,7 @@ OPTIONS
 include::merge-options.adoc[]
 
 `-m <msg>`::
+`--message=<msg>`::
 	Set the commit message to be used for the merge commit (in
 	case one is created).
 +

base-commit: c69baaf57ba26cf117c2b6793802877f19738b0d
-- 
gitgitgadget
