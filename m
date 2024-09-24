Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9250D14F124
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727185370; cv=none; b=NdzDa3PeisVwJMOrS/aN9h3y952oOOVvGGOf/ZsoEe6bKpo9S/nF7jnpgoD82qUpucTEIc5WBbOEKZOGgsJTXm9G5tDCVxlnhnMc9zZ+8jTXqTkKxympxxo+n+xhkvFr1YAniVovcXK0yMr9X3oVXgVRhwzOYvTwEP3btuPaCiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727185370; c=relaxed/simple;
	bh=gRH18GiEluDN0dsCEMc6xmdzR7cll7mz9VYxS8r8Bto=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=D3hsV04VDjBPOttUoch0u2t9KBPEPo2EpWsmfXkJlZw88eV8OVEEcbpJ9JaVI7brTIgQ69xJQaJLgnQAUwy9sb2kwgXLZnZyjJaz97/ww38wN0RNFDOonvAbMiqORmSPI393S9sJUKLe+VuwAaGRpOLuDvrZsagrmUjqedJvx5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVGIlwxK; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVGIlwxK"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53568ffc525so6425810e87.0
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 06:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727185366; x=1727790166; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=btBmp9g/paGSHYe+dAJ5rtCOUnQI3zK30Un29cPOYl0=;
        b=FVGIlwxK6hc+1RZTNZrCoyFF3NOI03gfLe3ZNQIZ7TXygbqRIIGhyIK4hTGXuIK7ra
         YtGTrMgz37Rec/1UAq+J7PQPCOTrM/3ZFom1/qE0kQOaTi6lnt2h0ZRHFyxuGpcMv56m
         thCqLiWwkV+DM5qKgkVtdN1ns1pVytworZ4wHGGlplUjnpckZ51K9g+Z9TZ+6OwTpA1t
         n/kqe/1DvXcvlU3koeEXkXFb0woGFT0XesCXJQ0oqj3z4PKepnALbkgSYBib4T5zPSTY
         qqqqw68cLs/LzapJLin1Mv94NlRQ1sFrx2bSOTgNxPEEZCc4KS31klLSNohHkGu0lqv8
         n2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727185366; x=1727790166;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=btBmp9g/paGSHYe+dAJ5rtCOUnQI3zK30Un29cPOYl0=;
        b=e9qMM6A1NjdozI/zBfQPFEfFvlk6CXjMy624ljoQ3mpuRSdxcDovOkkAxpCyBQy1rn
         ScsFGVLiYAMEg+uBbAh21Z0sRz4iVis9EYlOyK/GpabgOHOckfa1JvNwymteLJK6W0Yl
         ec3iwQYHcspLsSBmFNcXLV3ZdO3J/GgSq57rtCIjsYsDJ0xYb7mMpKvlk39Ahd4hbKe6
         TBkSNa39cAu9tJ//w6UqhdMHua7RW9AyjnPvjHpVhyNVBZscba5ROXmrE6yjLH3+sAf8
         EDE1orMUEVI/U1/SX0tpMQeENlp9/gQPmNJE+JEMNfa8BvqEebsut/VBf5l+8VAtQx0x
         06rg==
X-Gm-Message-State: AOJu0YwCv/uBby19a4ccFCWpUbVi62w2D64yHT9T66p4GPjvVNTl6J26
	0FEN5et9VNG3BaUCcO/BHCikcwlSrrRSu1yQGJatWTu9laKkpJYGEhWPLA==
X-Google-Smtp-Source: AGHT+IFpofsYghegM29m/zG7MiInabdczWXQfAb7H0D+ZYC6VpqOz4ZTzUTyzWWyBrs/9DO9tQcjGg==
X-Received: by 2002:a05:6512:12d1:b0:52c:c032:538d with SMTP id 2adb3069b0e04-536ac2f466amr8291744e87.27.1727185365891;
        Tue, 24 Sep 2024 06:42:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4c4fd8sm759604a12.69.2024.09.24.06.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 06:42:45 -0700 (PDT)
Message-Id: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Sep 2024 13:42:40 +0000
Subject: [PATCH 0/4] Remove the_repository global for am, annotate, apply, archive builtins
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
Cc: John Cai <johncai86@gmail.com>

Remove the_repository global variable for the annotate, apply, and archive
bulitins.

John Cai (4):
  git: pass in repo for RUN_SETUP_GENTLY
  annotate: remove usage of the_repository global
  apply: remove the_repository global variable
  archive: remove the_repository global variable

 builtin/annotate.c | 5 ++---
 builtin/apply.c    | 9 ++++-----
 builtin/archive.c  | 5 ++---
 git.c              | 5 ++++-
 4 files changed, 12 insertions(+), 12 deletions(-)


base-commit: 6258f68c3c1092c901337895c864073dcdea9213
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1788%2Fjohn-cai%2Fjc%2Fremove-global-repo-a-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1788/john-cai/jc/remove-global-repo-a-v1
Pull-Request: https://github.com/git/git/pull/1788
-- 
gitgitgadget
