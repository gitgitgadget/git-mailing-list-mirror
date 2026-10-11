Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B272244C670
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791724414; cv=none; b=UFkeAW0PBPIB1GVHEyC39ruOnW48bvFEPfF0bXmbFddFOKgZj2//NKDxz+Be/LMa2cN2KD5TGEkIWBn7Yglv5+4h1OWlAzvhrujS/bpogKB+qlc0DMblHHmVs+oL/q1EMlgfsJ2goPTrW7AMotDS6u9XBC4vBlMtV0lrYUoZVBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791724414; c=relaxed/simple;
	bh=+4tEPoXMScONEyJNYOZYRnlNlPl/fosvUxCX3mp6Dvg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WcyuXYZsG3onxQ7k4Osk9M0WxzWQZSoz42VoMDAAxAriPuCfton/tpamjOqGVpS2vOsRTr/2yARaKlEzOlURoXKH4fhtjCSb+mzGQs8YIL4jaB4mueE+P6orVs8CdWotn0v8llzvap29xuUWXZIq19UJkoWtnsqyrYJlKNz+XBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OU9xyOXT; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OU9xyOXT"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35115b52125so1484108eec.1
        for <git@vger.kernel.org>; Sun, 11 Oct 2026 06:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791724410; x=1792329210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+4tEPoXMScONEyJNYOZYRnlNlPl/fosvUxCX3mp6Dvg=;
        b=OU9xyOXTK3Z1iuEhzv1lJhzAD1v0PNzc892rT+PHEpFOQn9XTQFegYNhBHPcxulypo
         ItyM6WZbrm4c9eksxhnfnZX41QKa/BUv96+ikpHrk/b6WAe92PeBbVhRZVeg2SYp+Pf/
         iqXYEt1w4fHgZGfRSHBda1BRf5NVP/zSFhdSWTZjLerqT0gPm6uBzGmyKjW9zKHIMGrW
         3LWSNRmVe/uPeduM0+3eVWFcS+ZlOWl1OwpFcTb19I6ZwSviuJhygjTZ2l5hd/AX/f2g
         8iYDfi2H1ycz9LWm+4U0wDDGdDy0GF2yJIDaDH5qlnsZBIGUcrTXr5EefxSrenJIPy9K
         ylHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791724410; x=1792329210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+4tEPoXMScONEyJNYOZYRnlNlPl/fosvUxCX3mp6Dvg=;
        b=CgIYN80m35IOp40z4WK4jaZteMOunHcGNZh6gJVDEydU8SlzGz9mIcBT57i80v8gGK
         6iBmKtbK3roIKtq5JIgAlQKo+9rM5FcMqAllZkE54oXUHCHKm5/fNAy7t7zMejZsetqn
         oZe3ppUI0E4hCmHbTAXn/4letmgOAo1Y/wnk2GSurmnZA4tS3j3ZysP8/rimAeo2R2PK
         Er4OlfK0p0pkKDtMFFaeEjVC9pWTmjOPAsW/LAAconRYMu5dmbHGdjIYa8sIxhtjJD5O
         XNUwfLoTpkFZlL0BbHllMepTU2GYdFc3+8sqsttP40U3POPAvUv/tprLuwH6G8L58dur
         kRjQ==
X-Gm-Message-State: AFq9FYIYngnEJcGuPu5VsQ7ruDAzoVMianrQlBGAMFnINHSjMa9wCsCk
	b+zA1Gfks+K8PhL0f27kpIXGOk6Ehbi7cSa1VOSUL2nF2A8VKGamA5L+uzkpgJuT
X-Gm-Gg: AYBFou1z06v0+42C2TcXIy92jJUO6y3sPsc7zrFj0Kh4sU9Vo1dgFIY9oXF3CV8SUm8
	VZ0y2+Jv5LpR6rW2XcjhWhiBrWIf2uBQvJpJdNmsUA4V2QbnHJ0AV5maqEgDwbjM6gOW6Y2vIEw
	byf2lUfZLVV0GUxESzKl+2Zk+7uPeboEPY0zs5BIAE85CWSZY9jysgzN+i7VjsjcEzAn9qqHBUk
	v0MX00P0X7Dmeee48FM3P6aJZVDkjuTDT7+WBxATFjFtAmLJPEcbbni98C4Q0EQ0/vy7hwyBGfU
	Fa5Advgjg1te+YZzV2UTM8F8MTbZbMa8c4PU1SL3Yj25BZMl1skMZsGy9ClpONJIlmDQzkWMR66
	6+9H693eRYt9rMv5XYGSPJTlBXU7eqkWZDqNLOHTkrACdT+QKL470q7jKjdscp5KD16cbpE/YnC
	rGeSnQHu/x368OUWvPNLmFtL/M7FcLM+XZ6UowsjCQSZiP3OeUTvAe7mNcvsRx4RrZ+1SP2fWEV
	sCF2H7Sp1leY38H7/WLWk5w3UEFe+/B95lOol/8aQ==
X-Received: by 2002:a05:7301:7306:b0:353:5ac5:d4f1 with SMTP id 5a478bee46e88-3537e01c686mr9590057eec.15.1791724410179;
        Sun, 11 Oct 2026 06:13:30 -0700 (PDT)
Received: from LAPTOP-PVRSMPQK ([223.190.83.55])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c843079sm23635231eec.1.2026.10.11.06.13.29
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 06:13:29 -0700 (PDT)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Subject: [GSoC] Introduction - Aniket Gupta, microproject idea in fsck
Date: Sun, 11 Oct 2026 13:13:25 +0000
Message-ID: <20261011131325.23285-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.116.g6de20f609.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello, I am Aniket, a CS student graduating in Jan 2027. I am interested
in GSoC with Git. For a microproject I wanted to change the "Checking
connectivity (%d objects)" message in builtin/fsck.c to use Q_() for
proper plural handling. I found it in Junio's plural-messages thread
from March 2026:
https://ratatoskr.run/git/2026/03/8031937/t

I have already built Git and run t1450-fsck.sh. Is it still free to take?
If it is a suitable microproject, can I go ahead?

Thanks and regards,
Aniket Gupta
