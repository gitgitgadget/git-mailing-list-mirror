Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83B62D595D
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781978160; cv=none; b=T1bhtA9a1ujEvDFYkGujUlL46gnLPlFwLJQKXYPqDV6so5uR/xS4cC35o3MBSvoILd3ht/p+tO9+BQ0pk1uaQCYnkthMLXabdpV5PW077i+wuLc1rCE82ONqRwmr7gjCnSFudg7N/PooY+dFuDBe2m8SPCZ2+BzfElhlHnCBplM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781978160; c=relaxed/simple;
	bh=qC6MwfRqRCMK+/VywNa+bE0JFUHZ8Cz+TP+ZAEKo3yw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IX5jCEi6m+FrZeqw1+G9sWQwPA+Mh3KF+V5riwYnUjj0EQtMQO+yyGDDwt2iZhoHAvu6n5qJQiHX5lMxAZzSh6e9bycDDkATGPauwGmm9tq0ZWpjTHMm4nbnQBcInDnHARxSEdNZgbU1Y+cBj79khKs7+xZDuZKHP20xGEoG6mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbZqbM/l; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbZqbM/l"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-91588056619so224978185a.2
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 10:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781978158; x=1782582958; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkC9k20eyEKuWKnot9mm+fBe31ERoTTwQ6opznIgFLM=;
        b=TbZqbM/lP0VUuxgpiISKvgqkW38+/uVy+4snrH2tzXQcJl88C9tBIjKYpcw7t5XZ+i
         Zr6fpBiLCiNHK0car1hMZh04SVNSMCDxWZbPC59MAB/GK1M7wWskgyJ4eQVqRE/3E1QS
         nU71+PdgVqgamFCcitUVr0r6R3dy1NdAoBiL7Z3QiMKIByJ6p6VcG+UYDJcs3FskNncm
         nkCRRihGxxrQePlSNwwLOscbiFlqyv4zLv9vBYm70h+X1TkIw9kzLK8MtBlwRK6iTmRA
         jS5Rlg5/kyzBwIJvY4H9+qLxmyHMNYn2J1O+gvCBwFoBTAXEbLeYjmEiU+PtYAPVlna8
         3FGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781978158; x=1782582958;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LkC9k20eyEKuWKnot9mm+fBe31ERoTTwQ6opznIgFLM=;
        b=FgzSL7hMLZw/oIrt+Lk6vWGkp049/DTFvyQx9SQ9CJCLSsLcZQMVwyGw7sjWhQxRBI
         B0pWNBMdFO6UdPaHTZib/c2EEVpdCAAyFoDKBJjrfpOdkuzab8pUa3v1bel8DoLWlv8Y
         a2/xNGbfj1f2dx9xkIsEn2xbRiMt2ovDjtLMcfo9JPdwvNWuEwHj3hJNG4NGvI4AaZXv
         bI3NwOOgCCwuKTeNwxLtLRND3vNw6pXFj4KHTtlYqqNGIOvXCvD5n35xbzGfoubtkxuX
         BwCZ0CMbgPX9IvVjzHaAHAqYkASr+0HF2UMqsX5ce6TlnHN7TNsTzt1pOb1gaBrIt7Me
         xy6Q==
X-Gm-Message-State: AOJu0Ywv1zzpImipTvZGP9UJXfuDkUWYwib4R2AEtfQv+J+n8BibCXG2
	RzNdhebIaM8PgJl/7hzKhgxcMUjEjt2uqrpYZQH7P9vOqLsPF4IDBXgpqVns2w==
X-Gm-Gg: AfdE7cnzSa9WeTJA2fhkWuZHVMVVI47wa5wlCyhKw77JtPzVLGQiN3o2T0xfXSmfMxb
	75SjozgOdHOpsBR25/O7J+bumzwqEcswBfdfcoIKsaSz4Q1HR8NXiEU37Sa8sujIcELWF+pAoHX
	geqYLOeDZazchJPcOTu+HUwtscrhyBasyKRyTH+0M/h3ETmtlvD+m66cnIkABPA+S9d+R91lUky
	vxDlzBohi7+vosQFCz2oRXLI57SB9Ihg1jfQWwWKOWEKwn3o+9X5/P7wp52Xjuho0z2NiIxJBnS
	onXV8KBT/YFlUNdzRUBpDpAQVgkIOpbUAyLjlnPsyEGTaq3Y3E5M69nWH3h9FWbrk719g9gHGfo
	X3/gOEqN3OHny6XhEH/SMI+lHLCqqFchjMT1FA66wIj8csDEQSU3KT1+gYf13kbqwpL3Z5e/5TY
	p46C4Ktlly6JZ5Gj5Z
X-Received: by 2002:a05:620a:4620:b0:916:191f:5052 with SMTP id af79cd13be357-9208dbcf874mr1394275485a.53.1781978157718;
        Sat, 20 Jun 2026 10:55:57 -0700 (PDT)
Received: from [127.0.0.1] ([20.102.134.103])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-921d7e4ea1csm343409585a.11.2026.06.20.10.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 10:55:57 -0700 (PDT)
Message-Id: <pull.2311.v3.git.git.1781978156.gitgitgadget@gmail.com>
In-Reply-To: <pull.2311.v2.git.git.1779808987825.gitgitgadget@gmail.com>
References: <pull.2311.v2.git.git.1779808987825.gitgitgadget@gmail.com>
From: "Zakariyah Ali via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 20 Jun 2026 17:55:54 +0000
Subject: [PATCH v3 0/2] completion: hide dotfiles for selected path completion
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
Cc: Zakariyah Ali <zakariyahali100@gmail.com>,
    Zakariyah Ali <zakariyahali100@gmail.com>

The completion helper for index paths uses git ls-files rather than shell
filename completion. As a result, leading-dot paths such as a tracked
.gitignore were offered even when the user had not started the path with ..

Hide leading-dot path components for git rm, git mv, and git ls-files when
completing an empty path component. Explicit dot completion is still
preserved, so git rm . can still complete .gitignore.

This removes the existing TODO expectations in t/t9902-completion.sh and
adds coverage for explicit dot completion.

Validation:

 * git diff --check -- contrib/completion/git-completion.bash
   t/t9902-completion.sh
 * bash -n contrib/completion/git-completion.bash
 * ./t9902-completion.sh

Zakariyah Ali (2):
  completion: hide dotfiles for selected path completion
  completion: hide dotfiles by default for path completion

 contrib/completion/git-completion.bash | 53 +++++++++++++++-----------
 t/t9902-completion.sh                  | 19 ++++-----
 2 files changed, 40 insertions(+), 32 deletions(-)


base-commit: 9b7fa37559a1b95ee32e32858b0d038b4cf583e5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2311%2Falibaba0010%2Fcompletion-hide-dotfiles-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2311/alibaba0010/completion-hide-dotfiles-v3
Pull-Request: https://github.com/git/git/pull/2311

Range-diff vs v2:

 1:  056e239e06 = 1:  056e239e06 completion: hide dotfiles for selected path completion
 -:  ---------- > 2:  7482ee4645 completion: hide dotfiles by default for path completion

-- 
gitgitgadget
