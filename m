Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A21028F948
	for <git@vger.kernel.org>; Fri, 22 May 2026 06:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779433097; cv=none; b=fkR7Z+ZuUEImDvJkZzMfudLK0xF/wwxaEIFMuXvbRT1OCNkTxu815EE0isdT7KHgFTf0deyz67LH4RR2bqCZcPsWQeMhvjaPi3NHUOh8vt8TmFniMq21L9y7nYec87s77TWbaISmPtvNuJyTPUe2ckEZ0huB/VavfULvJ5FQhvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779433097; c=relaxed/simple;
	bh=6y4s52KgNetMjMMpvngMJFQxRX1robiExCWmdYFhqIg=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Gx4SLDMf66WmqAdeM2zgTqZH2znNwtCYy2CAHDtmCFNuFX9KH9Qlt5gqHurgHRWyn9lQbVxcVWYssX6bKkPhrendAv00Fd4hchl02rD2PqyJNQzqqIuTxpbtDWSh9upDmzN/5LEvyWsXYjUINtJXWKq6gEeqVAqOZgKsitSexYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pRsSuLOa; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRsSuLOa"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2f00a567cfaso4189648eec.0
        for <git@vger.kernel.org>; Thu, 21 May 2026 23:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779433095; x=1780037895; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZM4qQUN7nsZx7hD3+7+bGAaebbS13IRrnL+Uiy4Tsm4=;
        b=pRsSuLOaq1lJFoKwixzzOwek3/zpDg5on/6vlZe/pmwSFKQYZzsjwTsrryP8A4TpVZ
         7NTTVqDRinj5Q+1opHnIuMjAJZiMprYsZ/di88MfIfMJgOfEx7y57UPyxxzGEV0QhC/B
         Si/7imGYjIT62tCtSkOiYNkdwNfd4ugIQy6gdC492LpJyDgv36Faw4wmgv6kIYZSJ2gD
         DQgW6gksqbE7BoksZW7u45uAJpcFEYUYfsRXeMQQF+hluy3GNvhLPxWbKSUdHn/XUePa
         AtFO1n4xpoaH6WKStOd1E/WadPeLVh+DZtpcQNOf0m7lN9E0C3NrrIyWXS1wPEolhKvL
         BHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779433095; x=1780037895;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZM4qQUN7nsZx7hD3+7+bGAaebbS13IRrnL+Uiy4Tsm4=;
        b=pdxmbyi5n6HnlQY4OjKWPSBNxYDG6j7AaT4TY/crfOIqcnylCX1UbKzaxV0VMJLpMY
         7QsnPV6/tIhWW4+6AkGofih73w9HMfK1ip5oFFYnlaEIDuIB08W7iZwvbDkj9+x5+6Zf
         TgWXAgyMeXY2Y7+QIU/csinioDzPWM/kAn+dfVX5ihV3CvTwsiY/Nbab9Qo881GSlyzK
         OZz7OdEVPuiUYKlo23mBH1vjeM/smQ0TotyQGdFQ9WW9amY/P/IZveqOjK87XQYOQc0I
         0OwOsr+VU3poq9BpY0MiTUDPe6dTLXVh8DA7J9e9EUg2r/+weB0q9mZl5OtYxt8kFljO
         vheQ==
X-Gm-Message-State: AOJu0Yz7yDKM2zVLRfk1d75Ax0r8zz1Ib/KXxX+FlLOToyhFYvB5M465
	5aWyl4/U6pofZlsP3lNmwQd+8Qh/L6HVBTNJBoezKwnnBSISSGTLEUGypU1iDg==
X-Gm-Gg: Acq92OEdQdOzNt+WFFnZk7JSRWzepkfVbxWNwG10qSHM1ffeaS0yC3cn0x5cjLtTQyN
	aQ0bJCx/XlX+BlQ8glGBS5SUmcK/jCwS9hNtFVvcuaTQywdBHPQPul4uKDl5BuBDZldtFEq9I2k
	Qz84HgtI+CYsbu07iSLpYHPpYsOC1eLNQ2PFngvRjLVbl3TcC9AIP17zzzooTwPSNTNX5Eip6m8
	MFyQq1y2Tw/zDfwR+xZASgQM2ez6dZixvOfY2s9hUSWPj5mh+FUjcqCjLCvQRY8AfXvJiXTrdzs
	YfZb4S6zruAuxSpF9arqXT1UkdG+du6YVmTgmVU9ka1aGIjJqhhz1yVHcfFJUG9rwbJDco9d1k/
	eSsm0YUjjOie/s63KAVNT34Nr4jO04vTMq1iwdx4+upMfcZNm5o7jB07XQ6x4Mwl4X+nG/ELTN4
	8dL3cbrrsByr177U6JPLvSNIsM8KeW
X-Received: by 2002:a05:693c:3945:b0:2ef:1d11:18b0 with SMTP id 5a478bee46e88-30431053f3fmr2711167eec.17.1779433095394;
        Thu, 21 May 2026 23:58:15 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.231.116])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30452230dddsm423004eec.17.2026.05.21.23.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 23:58:14 -0700 (PDT)
Message-Id: <pull.2115.git.1779433093971.gitgitgadget@gmail.com>
From: "Ivan Baluta via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 May 2026 06:58:13 +0000
Subject: [PATCH] doc: clarify push.default=simple in triangular workflows
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
Cc: Ivan Baluta <ivanbaluta.dev@gmail.com>,
    ivanbaluta <ivanbaluta.dev@gmail.com>

From: ivanbaluta <ivanbaluta.dev@gmail.com>

The documentation for 'simple' push mode currently focuses on the
centralized workflow. However, the implementation in builtin/push.c
falls back to 'current' behavior when pushing to a remote different
from the upstream (a triangular workflow).

Clarify this in the manual to align the documentation with the
long-standing implementation and prevent user confusion.

Signed-off-by: ivanbaluta <ivanbaluta.dev@gmail.com>
---
    doc: clarify push.default=simple in triangular workflows

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2115%2Fivanbaluta%2Fdoc-push-simple-triangular-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2115/ivanbaluta/doc-push-simple-triangular-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2115

 Documentation/config/push.adoc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/config/push.adoc b/Documentation/config/push.adoc
index d9112b2260..979e40c3a4 100644
--- a/Documentation/config/push.adoc
+++ b/Documentation/config/push.adoc
@@ -45,6 +45,9 @@ If you are working on a centralized workflow (pushing to the same repository you
 pull from, which is typically `origin`), then you need to configure an upstream
 branch with the same name.
 +
+In a triangular workflow (pushing to a remote different from the upstream),
+`simple` behaves like `current`.
++
 This mode is the default since Git 2.0, and is the safest option suited for
 beginners.
 

base-commit: 59ff4886a579f4bc91e976fe18590b9ae02c7a08
-- 
gitgitgadget
