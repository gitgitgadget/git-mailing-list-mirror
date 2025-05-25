Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7E015530C
	for <git@vger.kernel.org>; Sun, 25 May 2025 20:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748204834; cv=none; b=t/t4XvfP2ASQXCreIJTruJ/EcGXPMeM7lTUTfQzDZ6oYeenL84wheTAAO8gCnjl6T8vVWiNi0PvnpbW03TyhkU2Sq2yJ4pMX4dA0B5+hCigEO0XLs4lN1c5Ur+z8YOrz3ggEXrXasnQOpmshwqzOXKcCi7DoauP4AOj0GdeEXz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748204834; c=relaxed/simple;
	bh=6P1MpdKNvoxI8u4sR4PU7POevgAxoUr0KzV32XI9248=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=UVQ+Wf391ZTKb38FBwXx8l/R3ZHJZNPfeoDlhvvD3GU0Wh/BrumUKg/AospXehd/lLULfUB2UE56Xq1XfxzWpztht6yaqanP8pdz2Ms7y/UN50JUPrGQOcC40rpNPN00TkHq0zXZhJRTwvNYBrYlBQGsqHnbxwe2VoiEInMqiZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7/7LIAf; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7/7LIAf"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a36f26584bso954535f8f.0
        for <git@vger.kernel.org>; Sun, 25 May 2025 13:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748204831; x=1748809631; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yqO3ktV/xnnQPXDyCcHfFQoSICPH9BcgmXxqO63gG80=;
        b=i7/7LIAf7hEcf2PJzFoDZA2y8eu34S8DMsxYu8GXmaDXIBgUecYvaeVVGt1exc0BrT
         R3KfJK0Aw8xyyFYOfQkfiirHXuXxJvjKLhwWG6vXqzvwM4GHML0oP5UXcoTJgbUcQ3NY
         vM1n6OwyGl/IeAki2dqLdUvjFg+sWYUDXDFXKKSP/PAwQ8bRKcGB+qYYI7c3Wq7Qh46h
         URdFykK0DbLxpcilNNbY1hFM4iPkFnS8pK8Q4RIFcRvePPwo6PPpkm8Z9hFVYt7AEDVe
         l+B1J6DB+i/BHg/Xo91BpZc/AY5Sal2wCaiEC61yNtzkOz3Fa6MrOyACs2CAAfSiZO4+
         Q3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748204831; x=1748809631;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yqO3ktV/xnnQPXDyCcHfFQoSICPH9BcgmXxqO63gG80=;
        b=k/vnXgkQGuVx6w14aliddUQWk8GR6cYhDTq6rbSHmrPxbTCTCNZ6JWSnUTWorvkpGT
         WkCQAL+lHqqZer6SAfQK1kto6OhXEPGyIniOqIMZ/+EBdh7V5lyDroJbcv4j2GT9vx7Q
         GfqNBy/ZB0oMl7UQ4+8P0leQ67zdjl9MHGBrN67SaGjPsg4c53TjP1AUsnliEu+63m/l
         UYsBM9B5xd4hK0b7sfrsEoyLN0zIqWiB8639XWDCaG9YXSgh5DOHo2vjsYBXr2nKi3s6
         02/OqSEShA8s4T8/X7nY8P2Z58yiC516ehp4Q1zReAXBNXH59MEU+stuaXw2HYYQZQp7
         9q0g==
X-Gm-Message-State: AOJu0Yy0dkDsSt1kHeYP7Z0kytntUvdQd9LzEBnk5pBEl5XwYQRoP6eq
	pku8q0DaDepT0VAvClNqjmKSaTTFgNdsMFQbzx5ZZ1L4ZiGHybrBO1qHnmw1sw==
X-Gm-Gg: ASbGncu+P8e+gZypyGMAAU3N4itHdcs8uY9OBqPrcDkEoF5iMPF/ELedkUgQhXbC8ix
	2wXl8E/tJcWwHpLFxsRlkazAmn4/T08IV6fEn43gbyYPH9U5S3RPadtnOckYT47KZtZnXZ4zfwY
	05ANcbIDEQSotPKhvASaqC6hKumYGk0RP34CtZ07cvysK9yrresKNeZHr5itbHKELfX1Q+fOQQZ
	EU+G6GmxFk//L+mGFocCjkuCX6zzjzi0iJR4Psr8bg9pnfME6uD3d0/qraWrrZ1XoGbPh3r0vRp
	kiTtXbqemfP181xK7LPzlCjUkyexuxylBNR/WnGCHqbjR9lVSBko
X-Google-Smtp-Source: AGHT+IHF8+RGtxixx/W4bvwClraiJi+cflkmwrFsTHPUZsHmA5y5p/0nu3cKauuqYmP4/RnBLId/0Q==
X-Received: by 2002:a05:6000:2309:b0:3a3:6991:dcbb with SMTP id ffacd0b85a97d-3a4cb46149amr5391522f8f.12.1748204830388;
        Sun, 25 May 2025 13:27:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca88957sm33142470f8f.75.2025.05.25.13.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 13:27:09 -0700 (PDT)
Message-Id: <pull.1927.git.1748204829.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 25 May 2025 20:27:00 +0000
Subject: [PATCH 0/9] doc: convert checkout, switch and merge to new format
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

This is the follow-up in the conversion of the manpages to the synopsis
style.

This time, we address git checkout, git switch, git merge and git mergetool.

I added a small grammatical fixup in merge options.

Jean-Noël Avila (9):
  doc: convert git-checkout manpage to new style
  doc: convert git-merge manpage to new style
  doc: convert merge options to new synopsis format
  doc: merge-options.adoc remove a misleading double negation
  doc: convert merge strategies to synopsis format
  doc: switch merge config description to new synopsis format
  doc: convert git-mergetool manpage to new synopsis style
  doc: convert git-mergetool options to new synopsis style
  doc: convert git-switch manpage to new synopsis style

 Documentation/config/checkout.adoc      |  14 +-
 Documentation/config/fmt-merge-msg.adoc |   8 +-
 Documentation/config/merge.adoc         |  84 ++++-----
 Documentation/config/mergetool.adoc     |  54 +++---
 Documentation/git-checkout.adoc         | 228 ++++++++++++------------
 Documentation/git-merge.adoc            |  51 +++---
 Documentation/git-mergetool.adoc        |  62 +++----
 Documentation/git-switch.adoc           | 114 ++++++------
 Documentation/merge-options.adoc        | 110 ++++++------
 Documentation/merge-strategies.adoc     |  58 +++---
 Documentation/mergetools/vimdiff.adoc   |  16 +-
 Documentation/rerere-options.adoc       |   4 +-
 12 files changed, 403 insertions(+), 400 deletions(-)


base-commit: 845c48a16a7f7b2c44d8cb137b16a4a1f0140229
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1927%2Fjnavila%2Fcheckout_merge-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1927/jnavila/checkout_merge-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1927
-- 
gitgitgadget
