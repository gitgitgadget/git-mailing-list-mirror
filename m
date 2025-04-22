Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E5610A3E
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745306356; cv=none; b=WOoNN1Pe4dPDMSu8RihNv9/8sxvUYi3TkK4gc8svx8gOmC19hfSOmbCsfnIV3yzbkz/zB39hsBLsB86Nv2w8D605jSa0yI4j/m1TFoja353bAGnz6S2SubHnPUQXDTEPajG4K2sL/eDckpCRMt282A91Mta9zz9Ddn0iM1GEpyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745306356; c=relaxed/simple;
	bh=nD5OM/C9tp1rKleCCCYkyo2/OPz381qP/FIXULZcNx4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Rm1ncI/ifb42lW4nQL1Jcea1wbNra3PuBPs/7Ect/0j3M+bRi7MKT8xSxjWgGHRS0GoeIIByj0AH0ogV4fYsRWslTrmFTpzRwdwZi9OrnHE1CoF8BWMoBwQ5IOAucEFMxgvcx3PQ8Ffc0HaBkd/1d+EUCo/hz9clQgUcsCONscU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNflPgmz; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNflPgmz"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so48125765e9.3
        for <git@vger.kernel.org>; Tue, 22 Apr 2025 00:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745306352; x=1745911152; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pJ54l6nv9LFmsuMlgRdfOlRp7wA+6ej85ckUuIwJrIk=;
        b=LNflPgmzyXvZ0owzGB/S9u9AbZXHbKWUUcZoGDqOSTuMsfucxXuE4wRDPpzaPHaSP5
         uOYHxwA4xd1/x1kF4MB8Z2i4hTNLkxf1xs3N3CTjcaUOFRchirbR9MaRERFL56hp12lY
         VvS0ckJbWpHKHr/7bHiDYbPoGcILF+fzmShauM5gQWUsrrrsiwPhVfeZCPtcfGlTlg71
         FiZ9X4AKaegh7uwiKaXpTV8V4E4N/viPXbVL/UlxfVdxU5QpIPN2FJ3DhKN0ICE93tCn
         1U70Fl8VwnhPfP73+HGVS0V1TNtD5Mfw1Rs80JbRF41nWniWoAcIYnUYYrHu85FANj5h
         8V7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745306352; x=1745911152;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJ54l6nv9LFmsuMlgRdfOlRp7wA+6ej85ckUuIwJrIk=;
        b=kzv7cadKY12DBKnwQNtpoX6kjzVk+oSo2lBH3ijaYaLLOLeRnMb7skGHBJiGXOq3WK
         vXzhNW0z15fBWVdNOSDqGutIn6cm9n4Ao0pxGExTthp7X87grS4vCsA4R8TrlYnb6Siy
         D5w5vx3sc3w199CRzK3ReV8s8Vk2HQ6nTxXhaVUJTjOHQaW6K8vPHeCXhaMzCzwBCorr
         HIbEpwF59eXKNKLVONc5Y9K3pKcAzcEcnPjSw2iktZzv8521TGuw4gq8rSvBmLEknLDg
         HxlG85nsIADZ6UvvjBL18RSo7P9TRNZxWiFiGYzmLw2g4lxD5uQTkf7Xk+LEk1M8TGb8
         7Bwg==
X-Gm-Message-State: AOJu0YwB63NZ+OzUamurviLQpN/d+MmNSKcURAzbrei3yVKv7ej2m4+P
	jmP1DUK7bzU3pVTBy8OWV6lfnNB0m6aviD3Eorqo8OG6pCOmXhmCQ85R2Q==
X-Gm-Gg: ASbGnctFLtG5ZsAxktr+nrQx88BQftbjTyCvN9CMAPL6KtAm+Wxc4mgga6RFrRnkTGn
	lh88Lx5nTmjF5QO3In1Z5dyE9I2ZkBcKMNCLYHLHwWvBo2NL+oW3jy/ps92OPc6DR0EagMPClMo
	FJ1g6IhBmKHcVIF49hVMxNqByiRy1oC2L/Pvbeku5kmZelqfENpSd1+MjmH8qqr4bhuI7yjVsXC
	QclbQHVmJW0WN6qV0mSababs+oJEmOpWpd9epDvvrK1Dco1HtdLs2pu0d+QHfJV/DpGRVE1r23z
	Co/McUWRIzeEc6ohzA58xO8TPmU3HZcEh4pFqZmMmw==
X-Google-Smtp-Source: AGHT+IHFchoxe/HpzZSFWVnkySokP9zS/1q4zaaTpqxZbArT98s1dO4NSPCWqKo9qR9m0P++6fYBNQ==
X-Received: by 2002:a5d:598c:0:b0:39c:13fd:e2fa with SMTP id ffacd0b85a97d-39efba685a7mr10272328f8f.28.1745306352060;
        Tue, 22 Apr 2025 00:19:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa493145sm14093080f8f.71.2025.04.22.00.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 00:19:11 -0700 (PDT)
Message-Id: <pull.1949.git.git.1745306351.gitgitgadget@gmail.com>
From: "Aditya Garg via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 22 Apr 2025 07:19:08 +0000
Subject: [PATCH 0/2] Ad support for Oauth2 and fix message-id bug in outlook
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
Cc: M Hickford <mirth.hickford@gmail.com>,
    Julian Swagemakers <julian@swagemakers.org>,
    sandals@crustytoothpaste.net,
    Shengyu Qu <wiagn233@outlook.com>,
    Aditya Garg <gargaditya08@live.com>

This pull request introduces 2 changes:

 1. It adds support for Oauth2 authentication, which is now compulsory my
    Microsoft. This patch has been rebased to the latest version from the
    original version at
    https://lore.kernel.org/git/20250125190131.48717-1-julian@swagemakers.org/

 2. The second patch makes the script reply to the message id set by the
    outlook, since outlook has its own proprietary way to handle message
    ids, and does not allow user to set their own. As a result, threads were
    breaking.

Aditya Garg (1):
  send-email: retrieve Message-ID from outlook SMTP server

Julian Swagemakers (1):
  send-email: implement SMTP bearer authentication

 Documentation/git-send-email.adoc |  5 ++-
 git-send-email.perl               | 75 ++++++++++++++++++++++++++++++-
 2 files changed, 78 insertions(+), 2 deletions(-)


base-commit: 4bbb303af69990ccd05fe3a2eb58a1ce036f8220
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1949%2FAdityaGarg8%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1949/AdityaGarg8/master-v1
Pull-Request: https://github.com/git/git/pull/1949
-- 
gitgitgadget
