Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF81925B0B5
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 09:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784538622; cv=none; b=dI7A5CV93XfX8yrZz4G8Msf/yjgLgQmFWk6pOhsXhgj/oXrXxg5jpx43uKrn9xh8WcVRnFurfOAYAwxJLzxqEG/9XwUutPWjvOZ2tY0s7rQ8uPLS9anK4aPfgrDHDxxtLgbT4oDNUNzyR6RYMoBDhe7iBDK4xZpvt2VvKeJIqNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784538622; c=relaxed/simple;
	bh=SmJvRr1Pv2iq+vK1r1NN9ODwz7XNwtGDgBo+vpJ/KRc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=O+yHsnj+46TPYRKeIlq4UMIHJp6EWm3hFUIf2iCQ5h2U50QLJqCfCzSzo+p7koLzuEfuuDpYylwocS3B3R818uBzWZ9DKhsbRf334SUALx0fWoM4x6/kYZ/axdsR/iJWGwtx3zJcjTKgzo5zAYre5YDIFInRFQfOpukOjgtrDFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkNGV0o1; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkNGV0o1"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e6c4a867cso417326185a.0
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 02:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784538620; x=1785143420; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HHYdXK1UjGW0b/QBygXJ1ACjiwWz3+ujl9anlZQrNY0=;
        b=hkNGV0o1fXUTBrERzb6pk/Bm0rW5AEzBcGWQZWQItyEwLdNe772gieeMNoQbWlgWIo
         uD956qQjrFvURa+w7jJV7jIheZ8xHOhU3b2VND6WZzb0gG+nc9t0js75I5Tpj8S34O0f
         qllhhvpNxh0GcMQPxsSVvoPH6WR/dbBWZf+w6ytIvBDGoCZcVYt8CY+pnoK0Zh0uLyst
         8fdu4PrSycjgukNm3+NnMynXUPxUycKpdWfKHkU519vtb7Q7yyFf/IKCXYZ5tMS7tgta
         CP277+236vgsOkot7uBCx+bcDNW1kMZWmtV4CQHrnfD2JrrGHLzCAc7iFM94JB+8CPAS
         IGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784538620; x=1785143420;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HHYdXK1UjGW0b/QBygXJ1ACjiwWz3+ujl9anlZQrNY0=;
        b=Yha4iUchGqpDiOnniV09QCNpgnCAYsKCeBsjyGV8fX7MBJflRWx8EO6EIsK4T3EQDW
         VT2a833RcM59k0ezkMVeSL8fzm0fD3eQoZM14gXha9CANMRfF564svqJCBuYKBYp3w54
         tZnGNCRXs7ulNNY8Y2ZLrERdjK6CmWBKNc1WLCx6DuXrIPY63H7fcHi/pPsxc9WmNzaQ
         UorJ1UGOicjjNfuBjPhZ4TfakkMWW6GxMVpkwOrwhQKzi2bAfdWXuE06aM/9cwYeObTh
         qpaATyjUokMM1kdkSovLhH4EIxgaRTwc8FH9ZYinfnCCT6hhPPorktgY/EFOmxpvVYdq
         7S+A==
X-Gm-Message-State: AOJu0Yxu0kGTBG0vJLhlrB3nxE3aYW9lORHSg4NP5osy8bNYYr0Te9aE
	avkRCGvZJF6bbXpOH5KOIzT7dN2Y7Gz6EowUWKa8GC3lg5y8QBJ4CDgBSz4a0w==
X-Gm-Gg: AfdE7cmGecw+VsS4zf0NReLKqp3GpQ2yHHq6JxNNDxZizC1YpXsrUGwrj/D/q7rcHKq
	JRnU81DvSFC8RGBm1UAjXRtoqONXy9Hu/kArREAvwXy7fbQJpZ2djrR83NvniFfYzjdi//6xKUn
	b1mlxEn8M37Oc5BF6wVhblH0Pyu9DElDAy2TCxTxKO8uXW2FvleHJHxR7Muc4vBSew6vzeRVzZj
	dlQhPdP2gzYG57gLBv/wO+ChWt4IVV5Ob50tXgaZ/we+xOTTDybJeyVgSQ/Zg09cd2744Rf/Gxc
	+7jdIiI10YtyRML5Oz8H8axXe1MDFEzGpJNesRCAvPBT+XhxU3wqEm3LwCpy4LnRdCRDj7wzGzL
	chwtqZoYDeeP0IbmXUSyM8W7JYEQpHQWQnrZ2yGJz5G7cq3WXn5Baq9Il539kRvpFy13fLRdCZm
	M9xeg=
X-Received: by 2002:a05:620a:31a9:b0:92e:717f:e0b0 with SMTP id af79cd13be357-930b3e4896bmr1222275785a.12.1784538619587;
        Mon, 20 Jul 2026 02:10:19 -0700 (PDT)
Received: from [127.0.0.1] ([68.154.37.68])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b52dff03sm831697685a.9.2026.07.20.02.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:10:18 -0700 (PDT)
Message-Id: <pull.2358.git.git.1784538618.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 20 Jul 2026 09:10:16 +0000
Subject: [PATCH 0/2] remote: resolve url push tracking
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>

After renaming remotes, git status may stop showing the push branch even
though Git still pushes to the right URL, use the remote with the same URL
to find it.

Harald Nordgren (2):
  remote: pass repository to push tracking helper
  remote: resolve URL-valued push tracking remotes

 Documentation/revisions.adoc |   3 +
 remote.c                     |  36 ++++++++++--
 remote.h                     |   2 +
 t/t5505-remote.sh            | 104 +++++++++++++++++++++++++++++++++++
 transport.c                  |   5 +-
 5 files changed, 144 insertions(+), 6 deletions(-)


base-commit: 41365c2a9ba347870b80881c0d67454edd22fd49
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2358%2FHaraldNordgren%2Fremote-resolve-url-push-tracking-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2358/HaraldNordgren/remote-resolve-url-push-tracking-v1
Pull-Request: https://github.com/git/git/pull/2358
-- 
gitgitgadget
