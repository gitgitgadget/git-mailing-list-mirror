Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DD92135D7
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 20:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769546000; cv=none; b=BJQqWAaHAI0CR96UoQioW/PyhJVBNzSJj3MDuUrXARGNZiERXIORuqkzpNEkX0BgLJJbGIVr3Dz3wYAdz1rRHZwPZoULOOiwZ1GOakMw12qbWw3wBJqdn+8D9t+7WrbpMRTsBfM2IBchKx3QsWyxzhEalqUlTr8j51IKG4Wpo5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769546000; c=relaxed/simple;
	bh=l9MkheN1Egkwm7MThufY+5CDrriqOy/KGg+y6N4sC+E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Lwr4zGtcO/doZ/TfSKmwUdi//V1vAyy7HoGrtfwrzIT6J8nS2OcZTi07qHQuzdHjRR6Sz+HGqO7bI9bxIcVayAK2lCPgEyIniWmZp0kNPMYbWgp05Dm/MenFiJSlOzv83U/z7Co6Wj1ZHHPUZhnTw14xFbPFursKDk4igZhe2SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+ZDbX6a; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+ZDbX6a"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-88a288811a4so86929816d6.3
        for <git@vger.kernel.org>; Tue, 27 Jan 2026 12:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769545997; x=1770150797; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H/QlC/RmCe76LTrcPqL5/aAOIVhzvfUw8/1gix8+yn8=;
        b=H+ZDbX6aZwjVwImoRlNQz9DxvW/JrNSAVHgXmLnEpTxUTeIqzzTYhUkK3NISY7iI8l
         wCMS2PvXq5qRs3hq490OKQ4h+I1dY0q6FmTpvoBbYbKCn5Cz0KWRta2mgH1giiJJkdnF
         EsiCN+n4SrllGhQn5pp6Br3ig7hbnTp+TvXizie8xJG5k9cThbN74OVjV+VKQsPxDbsX
         xbFUrbnAsqNMPdBjKuwgi6munDV1e3PFBJl/COiAu49+WiEniJuY/I5fbcIUM9bxNDO9
         G5cg77w2KxupvCEbjbFm1PAN3a3nNFQoDRzEnYPueBSIPISkcEz/qQMoB2ExslPpugHi
         eJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769545997; x=1770150797;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H/QlC/RmCe76LTrcPqL5/aAOIVhzvfUw8/1gix8+yn8=;
        b=k1lOHDm4rVRjaxZpUZp1++bgxujX66EclxtfSgUXED9SKsM+2K9tIuWeOKWYNj3/X2
         kIuPpOQn4GZZa5bNG3vCAHbtSHqjbdoekT2IIrwIbSBvQ+QmJAmhejBaohePK5eE2rLw
         H8u+77MpBFM8FU/U5ocPmdCQBEm3UO8lH/lXaz19W3HXiq9xD455VHx/cuOrExMQ0+Nq
         8tU5fTRGagxuLUrQ8FfHaZJryxgx/XY2SZ92km654xmY8E63Z7I7vcGvwDj3dB2XIbKs
         gav3cORD6bTLapOs2R7vbtIaruVXHx+pi0rmyLTx6GTTCKDIzbyPAcSDctJV6nP9uGGD
         3rVQ==
X-Gm-Message-State: AOJu0Yw4cOc7lGntbE1UIWokzHxJm3054zsyMlQzIZlnC1ZlacM+7nSE
	ftmDwk4mLfLKy7OIpnc6yJCLKXMCOsSN8w6LCJQp3KzPW8QP9/lk6S2evdHQOoiP
X-Gm-Gg: AZuq6aI8Y1mgtXic4HI0RUG8Ud6dBnPCCmh+Xe+RcGFY5Rfh/B1zskmICB9PrV7n16C
	861hGjIfZGvAr94brPABbWlTrHQZbCqdJBfmo+8L6NJIyaMwu3Vo86TTwSOihg7JQG7Zfo5inWZ
	8pcqmldCYKg5qNYVvYErDAt2FYjHn1jgNunhp1gyVWFUqe2WBVcgTtODv5BWqobY3SY6rPv4rzv
	rkYws1SwRjvcxNapu/kZq6XcYX/a9Wp2aiCnB7y60AtaM5Filh0KEQ6kQ4tHko1s95qVSY3CZX+
	6f6aWHtMokdGiChNjYRc136AvAphGVqSR9o1HZrvRqiBJ/dkE3ZTGrvXJYQLqPVzntsn4rgzas/
	1v4WaTXwqC4vOetSs5M4wZX4ffpkAz3cmcJrTlvXi3Xtq7Ysf8d5QVk4SeDGKc0qG7/uy+iz4AD
	h+d/eJfIVBbOk=
X-Received: by 2002:ad4:5cc3:0:b0:87d:e2b:cdf7 with SMTP id 6a1803df08f44-894cc94c1c3mr39321436d6.66.1769545997428;
        Tue, 27 Jan 2026 12:33:17 -0800 (PST)
Received: from [127.0.0.1] ([51.8.121.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d376e4a0sm3803596d6.51.2026.01.27.12.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 12:33:16 -0800 (PST)
Message-Id: <pull.2179.v2.git.git.1769545996.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.git.git.1769424301394.gitgitgadget@gmail.com>
References: <pull.2179.git.git.1769424301394.gitgitgadget@gmail.com>
From: "Chris Idema via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Jan 2026 20:33:14 +0000
Subject: [PATCH/RFC v2 0/2] diff.tcl: Fixed alignment of tabs in git-gui diff by using spaces.
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
Cc: Chris Idema <github_chris_idema@proton.me>

cc: Johannes Sixt j6t@kdbg.org

Chris Idema (2):
  diff.tcl: fixed alignment of tabs in git-gui diff by using spaces
  diff.tcl: call "apply_tab_size 1" to fix alignment instead of spaces.

 git-gui/lib/diff.tcl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


base-commit: 1faf5b085a171f9ba9a6d7a446e0de16acccb1dc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2179%2FChrisIdema%2Ffix-gitgui-diff-tab-alignment-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2179/ChrisIdema/fix-gitgui-diff-tab-alignment-v2
Pull-Request: https://github.com/git/git/pull/2179

Range-diff vs v1:

 1:  f2a09c15eb = 1:  f2a09c15eb diff.tcl: fixed alignment of tabs in git-gui diff by using spaces
 -:  ---------- > 2:  e11aa6d811 diff.tcl: call "apply_tab_size 1" to fix alignment instead of spaces.

-- 
gitgitgadget
