Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F9E547055
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 03:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431448; cv=pass; b=WL9FLN4nZ2KRfVGiKIR7PEZouddn3gizD6X8f4tgYx8AKsBEM7wZR0n+bS5qjbMLkW2SBWnL7bRewTjtAx2nEKjQ3f/hawcpOB3SWbuoLPahzHUKDfVeVM+s5VFGWefcCw95YjAnfmfWm79/vae/xmh9Yp5bPg9vl1NMRHVCTfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431448; c=relaxed/simple;
	bh=HqTeKGrdatTFu5fxB09DUHhoqsyIAGSfR4W3M0fVp2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sELAuPYwkB1+sENyD717RcUU40ufyjEjXdhrilsd53mIzG9jEyj9QXkuli7cdnvTTzxjhWp4lDN8mb96zQZ3YlRjxC59rZaGpsUFDj63m0hoZa1sY4vk4wB128TQbK1vKt8OBR4akdcMYbo71M9ZxrZwbI/S7saknOyb6OF+dGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kq+B+6T8; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kq+B+6T8"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-9178510f3bdso31960006d6.2
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 20:50:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791431446; cv=none;
        d=google.com; s=arc-20260327;
        b=rNBlXnFUkaBDXva1LWO3HsyfwJxZiQ3twwWzaqUiQr47GjEGWjkhr1eQZeXCer9/62
         65bAtRL106wry9xI12ldVc4dxCySPVrhBt2lYlxqsori8WSYz15j/f2JLnk4pXxNpD/H
         /K5oXrDFrln/I28R94YjYtc3BEASzKpPjqEg+ugkjW14lrPwRwe3ZRW3e7B2SJQM5Z7t
         XUI2JVTKtayLnfadDe6y7/aRmxgezDDhrEv2ZPkqXJOvGewPe5fAkPCJs5qM1QyIUqTp
         C+Xha0VO+cDPEAAtSQiRSstWGgywHRcZlQ+vsGcxROhGCr+RVDvs7uB+a58PPH6HH51O
         aqug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HqTeKGrdatTFu5fxB09DUHhoqsyIAGSfR4W3M0fVp2c=;
        fh=Spqmvdc56pB8VkiCA9oUcAgCwYamfkbinT/B64Rgp9I=;
        b=qs9jxcQpCwgF4DC3N/ViZuOLbmZQ9fzK+u/WpqXSCKfelJxxK+LiP1pFqHeIuPL8X4
         h2J1qOVkkehEyVGgywCUEuY0HQHb+6O1nHR2bZDD40MYNlldv6ZJYMBvdwwRlFtr7Thl
         kWTAg+pY8iFV9jKqcYLShoBus5tgKwwFNFkaQt3WX3IULssMUgsK+tGzQR8rh9mNXQwU
         6/vfTgCELX87g0sjUpe3IOcyJ7nQ0i34Pej9BpQoQvLRG6bYYsZatBqd02lKHrrdFBQd
         40q4Kh6jSTz/IAbKKUipPr5TA/TbWqwS0pK0yv/PS4V44CsvKziYIS4CpO0tdE/lk9g/
         DzJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791431446; x=1792036246; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HqTeKGrdatTFu5fxB09DUHhoqsyIAGSfR4W3M0fVp2c=;
        b=Kq+B+6T8oMNoebyiiYTcFH85lQiPJpTCf3D/iN6u4jwV9p2CzrHowSu2jelPJkCdTa
         t+GfcNgR9q6dKbqiYaHVhzhRrzuPJYTdwbc9g3gnUZfJQdb6PxHhOwyh08DBAHiGj58y
         YmiVimRqbArQ5i8M4yjqTHaYsJwCu8J3qGyGJXXI/tu8I6+3+txIky8urpX+gPPRfEG9
         Hd/rN63Ur/h+oejCuXS+rEbchP1q78OSDyAU4PwXi3RQA9I8wC/uAuPiVXrLIJWhF6kf
         CZyEmApsBYUg2eayIs0Hdjks3SlSYunernZ7Fx83qQc+ma80ZC81rybdRJ/wUsZoD9my
         gS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791431446; x=1792036246;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HqTeKGrdatTFu5fxB09DUHhoqsyIAGSfR4W3M0fVp2c=;
        b=tr2riOeSqfoGfzpwe/EHS/8f+E/SV4aAIIeW0O0/Odj34KJ58U4514B9A2/uo3rdF5
         Qykb6prdRMQiUCItFxPRsfzIFZ2z9l8UIddUGFioHKdAsfvdeAUX0ENLStjciqg6uIik
         6EfGVPy5CNEmO3FRgezK0vF73ozt8kp3QK7NrslcMog8tXoGONb/uNure6l8RpHR65Vb
         KvjdpLHWNuwnl1RGmq054VGmeSr4In4xMuEMv9s/4Plpxz4eZI+CGapClb7w6YNy3rdd
         wk1WYTb6pOZsLF3QPMdTLiGK6TgPKoCObAO/EAar3PB0MIUgAOQ5wqIVj4S6GlRw8NzM
         IYtg==
X-Gm-Message-State: AFq9FYIflU0+tXeTQ2EaziCzHwCCBBemB107e0Q4M+J65gpWHbQ6PDQh
	fsbiZr96v41oSdqF15gmhy/AVPXO1xArM3rEIGFvswgDR6bjv4xUKX7DW3heq8d4/rK6pa9OLqf
	D3/djgcX1h0K9iNrUfjPlLHbpLdXqGjdfAfBj
X-Gm-Gg: AYBFou0ERETQc1JEnQl9+t9Qvj6ROUI9UJfThbwYa6hu5BSDxjSlHYHr27auKklw3Ch
	Jvqum0975q8eTHsB6bx8VqKSnInr+/3m0bm5cFiFlny9jBZ7mUrnyjxot+L/esljaj9JGQeMV2s
	OqPEEbG3aCVHrn02d+ndjLegFw8vrVDcYBPsCPFUmAUB1qUXtajGu0S6sxkvin3TQWl6yjyDba4
	5768nv5IRYvrUqqsLcLu9DKSSRSb1iBrVFM6j/eiwWRayRLO9xcZgyl5MFj3fqbhcFFj8YtgE1B
	QTHu98ol6/0mbkTwWK/ou6XZ++3AK39PanZzrAj4UTlPzXNk+Y69fGYlxSXcfXye469q6VHaSg7
	Y3VCf46r9WHG4
X-Received: by 2002:a05:6214:2408:b0:90f:5154:6a93 with SMTP id
 6a1803df08f44-919977eb9a4mr81262666d6.11.1791431445976; Wed, 07 Oct 2026
 20:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2225.git.1789269613.gitgitgadget@gmail.com>
In-Reply-To: <pull.2225.git.1789269613.gitgitgadget@gmail.com>
From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Date: Thu, 8 Oct 2026 12:50:35 +0900
X-Gm-Features: AclHuK8fpKYrWBGke2m1DgV6niAw1J0JPWcu77h8MGJj135aIomlzkc6uyOiRs8
Message-ID: <CAF5D8-u60aRV5rKoLQYRghh1YUFK=p1QqTe02WtsxSdyBL_e4Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] worktree repair: avoid breaking unrelated .git file
 and gitdir
To: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"

Friendly ping on this :)
