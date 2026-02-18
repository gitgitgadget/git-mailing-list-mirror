Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DB133A71C
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 09:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771406121; cv=none; b=EbLjvXOViXK3FFTsBH2V3WUK1gr16AEjiF0cz2QwyUu3IbrbCKCB95LUnNROg5z88KnAgnmXOe1XizzNfPyD8FSNoA2cuFBWZUTrKPtva1/j5Q+3IxPMLpLjuYtf2slR4vtekNTCWWIJsZcqd4U4kCOEzUFTL1X3N3QPZA9iSPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771406121; c=relaxed/simple;
	bh=j34UvHCttk9GdWTe0iO9GudX8omNwaVDpfIxD/TIElE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=VypSOj28hWXnCHg5LtTXLTjCvZ3H/yUORcwoH5oGZ+Z6DNYtKLn1AU3tgnqhPWSg1DG1GwUgtfPVU2VipG0siAwUWFvF2AdheF+d+Z5wK1XKx5wQQjRtWWG2Cb4OHGUCoPy35EDqV+xxl8jlPNTxeoD9auOaOIfzHr88zTBGE0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j71Z1r6l; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j71Z1r6l"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ba94dbf739so5251466eec.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 01:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771406117; x=1772010917; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=83tzxLONWUThPoAO7e8BTBjUBURzJ1oRAKHq1VjmL9I=;
        b=j71Z1r6lmftJRGdK2mK61rlj/gTjLFXvP1n5pSVTTffD6W2wRLK+Va4EKlSFmM5nnR
         rxQ4GN6UuPqDP7WIe+jCb19Zhh4TCwgy3WL2vO9bk2t9Yxeb1YOZEgvOkVxulV9VQ+JR
         o+UC18flrn96nAwuUN2jvVXNE/8DWxCjNcZh7YhTBt94cF32eOh4vPximz5fYbm+nd5D
         CoNOipTfr95m4mOfvLBQDgrnPs0abnaJ1OVBDO3wiFzFD+y1ml6jhJ8fTrGXTPdEgYp6
         MQnoBIxMH13XlwEIOjQRpxyRa3o3bacTJZdHXERTRpD61vdP4xClymS5c//tM3OobfIb
         7wOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771406117; x=1772010917;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83tzxLONWUThPoAO7e8BTBjUBURzJ1oRAKHq1VjmL9I=;
        b=nOhR+2CJkCSbLoFDDGJ59ngTOPupIDxv/pUNXgPsBs3NDFOgm8StGr1pSJvmhETiF9
         hhKyhNLKXBsPAkxRA3naw+tzstvPr4J3xfIemLGjtA3Waepxwj7GQdC/cZ9tspkomUtA
         5bdpNsq7L+y+jO4PUUQRvb2MV30tcirgrG3ta/vu4rsAjeaOlegYBzZ2VGd46C96rjo5
         VI14iwB8WzuvKMfiNn1B8jeBvsgPRTlsWlG1FoJtikQoUwyE26C3JHiE+L45GkExFMSm
         gxsdEN+IcnOe5AC4E/DxrXe23IFj7JrQyZ7wrjvyFn5lwGlZYkI2HgEsKiLcevvmta1H
         9FMw==
X-Gm-Message-State: AOJu0YwoNirnnNlPyW830wYY69cIJJ+SYKp4eBhsszgedosqSVHiMWG9
	+ml3sFyW61V42vQW7XgHay9nopPS3NaziTXHSLaHDW8gU0C0M+bSIfXYs4V85w==
X-Gm-Gg: AZuq6aJlTLWmQ3nLWZGsEtXwT9g4aZmv/RzM/UoclqRSXF5ie3UXtvxG9G1f6z25uTX
	4SSdNMwKiKzWICiXg3rumGVVR6WS4KKpVaqU0fjvXtzDa3mUq5oj6IQcNws7GZaGF5Ru5bvAld+
	OI3MBjNkR1qT4ABBlHt24Ru/wQkjNlwHvzXsQLQBU/i7r58BHlsKF/vMz2vOBH3KH0WnlwpcH8X
	XHSGuF74qKMEmivllX0H8BTkQOnMffYhWAQnz3N6L0hk6KXNVQDsunOkpybKMUey6gXXqT8Kd41
	1laCtVHSOnVDuyH4q1V0jYMdpjzykIJ+W1UJ30Mapnb0+/i7HKdk4cHUoNOr14y5A/x7nADVvih
	fwcCk5p/YJ+Y+8tC/3aG1Ei+NEIk+Cy6k7nG5SGu6ZWCYhf0v3JOFqkI79cqWmDr0SrWlCeHBOp
	9iJrRgDP7Cz74tmVXUngox5033cw==
X-Received: by 2002:a05:7022:b85:b0:11b:9386:a387 with SMTP id a92af1059eb24-12759a8164cmr495127c88.42.1771406117417;
        Wed, 18 Feb 2026 01:15:17 -0800 (PST)
Received: from [127.0.0.1] ([172.182.212.48])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742c6ce01sm17706702c88.7.2026.02.18.01.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 01:15:16 -0800 (PST)
Message-Id: <pull.2048.git.1771406115.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Feb 2026 09:15:10 +0000
Subject: [PATCH 0/5] Avoid the_repository in merge-ort and replay
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
Cc: Elijah Newren <newren@gmail.com>

Remove explicit uses of the_repository and the_hash_algo from merge-ort, and
since this has now been done multiple times for both merge-ort and replay,
implement a small measure to prevent them from returning to either merge-ort
or replay.

See
https://lore.kernel.org/git/CABPp-BH7E1Bh2g0vR3T4NEsv34DvFQPzMuJSsqtOAaWY-fFCxg@mail.gmail.com/
and
https://lore.kernel.org/git/CABPp-BFuwvqiCTCCpoyT6em9_1-qrgPWHWhrufQ3UuZ+Kfkb6A@mail.gmail.com/
for recent discussions on these.

Series overview: Patches 1-3: Mostly mechanical removal of existing uses
Patches 4-5: Simple hammer to prevent the problem from returning

Elijah Newren (5):
  merge-ort: pass repository to write_tree()
  merge-ort: replace the_repository with opt->repo
  merge-ort: replace the_hash_algo with opt->repo->hash_algo
  merge-ort: prevent the_repository from coming back
  replay: prevent the_repository from coming back

 merge-ort.c | 92 ++++++++++++++++++++++++++++-------------------------
 replay.c    |  2 ++
 2 files changed, 51 insertions(+), 43 deletions(-)


base-commit: 73fd77805fc6406f31c36212846d9e2541d19321
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2048%2Fnewren%2Favoid_the_repository-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2048/newren/avoid_the_repository-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2048
-- 
gitgitgadget
