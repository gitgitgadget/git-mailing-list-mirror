Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B2020C030
	for <git@vger.kernel.org>; Fri,  9 May 2025 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746807752; cv=none; b=kyOgrbSCw3uzUubuwRnyhrhQyTNoQsuLdG2lDJY9OmfXbEfhsaXT/FQvoGq9br9pip7Q4fF1WyeFRBkY4EgloHZg/++RHTTNPWV3CzGKpLWdrdjuJbvDl05UMGuBswSf2rKRjvGteZrPwLbDPcs0PkVvB6AVerH8bLgg5nzk3bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746807752; c=relaxed/simple;
	bh=MEtY+W2BPHUe/7MpW3KSpxjkGas6pvFr4pLFj49u1d4=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=pMLgGjmWFi4NbNdIOSG1ey0YUFR4lbtBagbHIrYwyvFCW6VdXbFITI6PWgc0MXeKyxLd/MAsyqTV52DdAt0O5EQJcuZMKiIdqADH7Bgkvhs0WOXk8V6sHtjPicDiE7B9V+0YlpUarUlEimkEmlHF4dAF+Q1Mfs0aJm2wq/W8WW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDv1jllt; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDv1jllt"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso22741975e9.1
        for <git@vger.kernel.org>; Fri, 09 May 2025 09:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746807749; x=1747412549; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f3xqhSzjbZuGAcrY7NUOs05cah/Mfwl/ds4Iw8SrvSo=;
        b=MDv1jllt/5eVkGbhC6qN1sneAKqKOMBE6tYALs181W6V8JZRhDCh5oEe3k6Hvt2nzj
         2sdZZQvfciictXkpPLmgSC17MX7qAYstQ1/3dE19Brv14N1+EJhgKLHwxhBjZKtUiXIF
         s7p7orekLyysbHnjl1QoijAXyf5hlpNrFplzQSMEjuKzoywAAbr/Qadf2UwR2nev1Vf2
         OROTO/25NJaMwpFdQV9ICAnH8x/N3qb6UnsQjzyVzY16QWjIUh6ugDNPzfcfr4RZ6tiz
         3GsR/ZsqWCvjTXngWex+PjNMh52jd30IDQ5Qs1ybpVzCFb2w9JnWDRdKDQIQz76fEduY
         fyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746807749; x=1747412549;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f3xqhSzjbZuGAcrY7NUOs05cah/Mfwl/ds4Iw8SrvSo=;
        b=ITxvfheOm5rvMfKYtB09Acazmb408fNB6ijquxvVd75mH77nmSa0K5YvVuMMixKCRo
         rOPI2eFReFIMXE/kXtAZHoHYWZmY4YhYpgBYnWPJaqgg/pIzlpL9HTtZNELD4M5kkQ8Q
         eZ1091GaDI+bE6gb3cJDM2BqhFuEc8c5xmMlAta306EcF8cixQm7eH2si5VmWkBjbkT7
         DSRHLsLECBdfMskHrfls3sdBE4EOwMLrku5PC+90nksqHCyZbLETmzFl+9rZyrIOQboB
         3W9zV2zGfoJPCNcs5YQs3VW1t0EFMbtlIVszGKyUvviS+vm2Bd1CM+2DlkXiV7T07GPP
         fQjw==
X-Gm-Message-State: AOJu0YwwQeCYZPFSRApJwb6yT0rSUx/GUEHdM5hWBiKs7OW4yvqSPM42
	ZxR44iCKZU+H/0r7qKITQa74dTx5cYnNu+Ed9QjdVJ+y0dZ/DEQbfhDg9w==
X-Gm-Gg: ASbGnctABfWBR3B44/28pTzmo0OD78IRvCW41XGDeUVhTYXtuMcTO/GJamKhCCPrxS+
	THaYX7jhTDAmYcu5538nTC8jh0GUz8LO26ExqWtByUSS1vHGM2iYX6U1vgIsxcpfWfhmWnjUVGU
	kKJwhAVuhdfjfVg7ksWr5HJYRW15TqmciCN+fNUkOSSwLNZ3MpV+01OYSlth8IifP4/XSu4gfgK
	OT4qtL6aLbwb+EklBR2+dPljxqgoaPgDl6/XOszU50OJs41A6lk4Mku5yPjTPMnnb4Hze5J6TBk
	2DTNPOe8CKcKVuigcFK0xTqcadK2A4D0xBOw7FdzTw==
X-Google-Smtp-Source: AGHT+IGZlShjRdD/CZssTPvOiS0jd/uRZnMb2LdkWaPRb6aOqn9aSn9gO5qkxilZ8R98m1NWaZ3q6A==
X-Received: by 2002:a05:6000:40e1:b0:3a1:1c39:37c with SMTP id ffacd0b85a97d-3a1f64ae6f8mr3695833f8f.58.1746807748891;
        Fri, 09 May 2025 09:22:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57ddd5esm3667799f8f.6.2025.05.09.09.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 09:22:28 -0700 (PDT)
Message-Id: <pull.1919.git.1746807747.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 May 2025 16:22:25 +0000
Subject: [PATCH 0/2] Sequencer: avoid use-after-free when creating merges
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
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Jeff King <peff@peff.net>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

This series fixes a use-after-free bug reported in [1]. The bug is caused by
storing a pointer to the buffer in a static strbuf that gets reallocated.
There was some discussion about removing the buffer and making the caller
responsible for freeing the returned string. In the end I decided to keep
the buffer as it avoids having to remember to free the return value and
instead stop storing the pointer to it in a long-lived variable.

Many thanks to Kristoffer for the detailed bug report and backtrace.

[1] https://lore.kernel.org/git/20250428194048.149348-1-code@khaugsbakk.name

Phillip Wood (2):
  sequencer: move reflog message functions
  sequencer: rework reflog message handling

 sequencer.c              | 116 +++++++++++++++++++--------------------
 t/t3430-rebase-merges.sh |  11 +++-
 2 files changed, 67 insertions(+), 60 deletions(-)


base-commit: 4bbb303af69990ccd05fe3a2eb58a1ce036f8220
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1919%2Fphillipwood%2Fsequencer-explicit-reflog-message-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1919/phillipwood/sequencer-explicit-reflog-message-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1919
-- 
gitgitgadget
