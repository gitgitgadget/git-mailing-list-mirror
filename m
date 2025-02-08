Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C756241134
	for <git@vger.kernel.org>; Sat,  8 Feb 2025 18:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739039359; cv=none; b=hYbESedRrn2dIG7/BrMAB46T9d/h3IQ+5lir5PeZ5DdrPHY4tShTZqpuih6M9XTINWvmUj7Rh3ucE5jvY4tglvQK4pXNKDr6XqSvTWGe/kmL+NShDOxhaNMNYZsAMf4jm1RXBT2zpPmAwc1ZE3TXJCM6M5TTR039MrCDaoJ72rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739039359; c=relaxed/simple;
	bh=g5OsEtF/820rHcaywsW8arQL04qU3uPWGbQ8bjTB8nA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d5lB7HFx5yK2iqWbGsw7uZmSk9hDGKKXMqDFm/G1oO6l+7enjR44/1BUdjK3edMlg6GpWkF8JEBGDc29h998iWY1WtwB62KobJ9yn+1tJJYdlF/G9hkCmX6hUXcyKkz/OxUb/Ngg2LEvje+oO7TCFNp6puaf6UFMGH88sk+qon8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FspZM5wJ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FspZM5wJ"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f42992f608so4748069a91.0
        for <git@vger.kernel.org>; Sat, 08 Feb 2025 10:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739039356; x=1739644156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KVizF+ZG39dRRI6fg3WOW2+KuDjPvuAGT8gB5f0dzcw=;
        b=FspZM5wJEWa7uhPo7WU2A3hx1PbY5loH4qI/AijnShtFDQpc8BY7PVSlcP2HYYe9w2
         o3cVvwU7ExxcnJuAYA7nz1/snZfdRwTG5WICOiXFqEb7JFtEqirHjSGjVxobjfhtXYPr
         y6vR+jeyUUYAzRJIKNZPLudFUGfaOE7x3NzdZWiezKDS0gs1xnDwrV44v/AbPxa8S49g
         xmNb9/fJvR44fV7Avs7kM3Zb6Kj4E8l1Wmketglp4vLzNl0t9QtKLIuru3RRB8HGTDsT
         6hmFNI6Q6r/D09ZDKtQE4OcLkjx2FNF2b4JDRYmIavwHmJnA27OODsuD+/m8j1jajg93
         Q1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739039356; x=1739644156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KVizF+ZG39dRRI6fg3WOW2+KuDjPvuAGT8gB5f0dzcw=;
        b=BB5ljqZYPoJTzc178+yxpBGMcyxknrgFzdXlJni8zMBInsDBtp153+dLIWkG9NqHSY
         BZtymCnobDV0mwm/Rrea2U1KH1BdqL32NTN+Ba6ezgKdTzqvuuIzGACjHdTedjBYeANJ
         ApXi+Vw8iFyqytjAhV2B1BphSeznRQGEIMZs8hqNnhdw4/WVuxB1299GtN5ePAzxn7ta
         MdC+JG10vW4Nz7l5nWOFyVTKvja8zXYezdJt4bjd9hzqRNcC8CBGumeFtSSXs6BxdEu4
         bzuvgCHSPaqSFQVf5KNJ1var5FSgkqOAdRBvS+6oRdgyK5A1eboWfrJhZXndOCt+Vo6b
         KxeQ==
X-Gm-Message-State: AOJu0YxbHhRGA0nLCFSWrGUHYueIufMNEv03APynAZP0nijbP/y1KJoh
	gwX3LjuKpyt7recx6Gxk+4AZaUFleapXAWVZetax+vngXXvSYgdHKHH3rw==
X-Gm-Gg: ASbGncvcjbcl5c3elCwmcRqnYHkEiMlstFIo/9Va9kjjBZKg8vEzGNZBANFHd+h8epe
	TzajcsePDDcz+yXkDYJzD2uyobCy4Xmz12P58MFXY+J41doLcPz2PZvewAI59LhUoie/+4rA/bu
	PXwxeKQaLXfVcrLV14gy7uyEF3n4a/cDi5KVcGbj3b8S19Old+yEVk8GH/WqATnyyLNE6Fwre5w
	onywL8tCIoB4sRBCMiqB2wnh6fN609QKq18YIIy62ZUrL+6eZ2sDESuLiu2wzXIlb4+OmUvMhUr
	7PJJpVv6dOIDykrefwAr5rpw/nUK
X-Google-Smtp-Source: AGHT+IF+h5yNK8DBTRvNE5ryKEEVWeXsF5Vnc8GQJU8xbIvG4lRA8DwEJn7PJnUf8K8kRwUbakGo2g==
X-Received: by 2002:a05:6a21:a342:b0:1e0:d8c1:cfe2 with SMTP id adf61e73a8af0-1ee03b5a903mr17159830637.34.1739039356147;
        Sat, 08 Feb 2025 10:29:16 -0800 (PST)
Received: from localhost.localdomain ([171.60.229.127])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad53af80cc0sm1333731a12.73.2025.02.08.10.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 10:29:15 -0800 (PST)
From: Moumita <dhar61595@gmail.com>
To: git@vger.kernel.org
Cc: Moumita <dhar61595@gmail.com>
Subject: [PATCH 0/1] [GSoC] [Newbie] Fix -Wsign-compare warnings in refs.c
Date: Sat,  8 Feb 2025 23:57:34 +0530
Message-ID: <20250208182736.18133-1-dhar61595@gmail.com>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Git community,

I am a newcomer interested in contributing to Git as part of GSoC. This patch
removes `DISABLE_SIGN_COMPARE_WARNINGS` from `refs.c` and fixes integer
comparison issues that caused `-Wsign-compare` warnings.

Moumita (1):
  refs.c: fix -Wsign-compare warnings

 refs.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

-- 
2.48.0

