Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F231938F92D
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 07:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783668146; cv=none; b=AfTArjeFPMXELhexFh9+bRym25k75cl0ozOYBn6vCY7Ef1kXAQW8aQCLpkqt+bmLMPIxLtPOjJ881xLDTiYZHKqSii/Mp7abxLAY7KKUesX929zaYo3uluiaNE8agPYdQKnd1rVTYY5zLZo1Trg9M9JrAZtLFWaKMPmxqGYrO88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783668146; c=relaxed/simple;
	bh=mZs9++8NZI44wRKxDsBDqfVOEI9vv90srf5/tDuO72k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jycFb2ad8/DKLBRZkYT6oRriR4YFqTD29o3+tUU5AHxmNEThr5Uykl8/1Jj4YKUW4zyH9uYaf775DwCB7NXv8x4KLG+Oz+eckqEBJvvKLxn1ISNfZVX6ldKJdhuphKU1PDfWR4oSE0yo/3H4Si4Hj4KS9daetOW0gf7x6C4hTpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P075iswn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P075iswn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 950B2C2BCB8;
	Fri, 10 Jul 2026 07:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783668145;
	bh=mZs9++8NZI44wRKxDsBDqfVOEI9vv90srf5/tDuO72k=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=P075iswnFgt7C36osYh0xWXDtTzgzUuzZXLzr4TdpYbLmxbpyLVSgAD8rwHv9wHDR
	 jE7I5L7B0W7PPXyD2LMwkNupEsCB2kHp6kzpiqtUajNIUgj2WS1lhBsbv5mj+ty7Mm
	 +21e+uI/U6zTivXkZSos6udefKAvkXTvEg6WkRXNw60YWpDzUjYHM8BYyrojO700oE
	 uJ6ghbt7qJqLCohJgHvdVR5ptiE8pE2cwV1qKD3Y7cx5fBdw9N3pjzoDtVeQI5bZtP
	 VpFcrpyKCnLV+6tLenohGqVttLQ8dlJ7Z1/0p/4WgS4cQEdVHuOw5nhFnAX29iSfbL
	 isdpJLoIPaocA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713D7C44501;
	Fri, 10 Jul 2026 07:22:25 +0000 (UTC)
From: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>
Date: Fri, 10 Jul 2026 15:22:13 +0800
Subject: [PATCH] b4: include change-id in cover template
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-add-change-id-to-b4-template-v1-1-1bd37a25064e@black-desk.cn>
X-B4-Tracking: v=1; b=H4sIAKSdUGoC/z3MTQqDMBBA4avIrDswRmmwVyldRDPRKfWHJIog3
 t2o0OXHg7dBYC8c4JVt4HmRIOOQkD8yaDoztIxik0GRepLOCY21+C8YR6xLjNxPPxMZXeWsoqr
 QpDSkxeTZyXrt35/bYa6/3MTzCft+ALVVBJ+AAAAA
X-Change-ID: 20260710-add-change-id-to-b4-template-f9fd20937027
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
 Chen Linxuan <me@black-desk.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1265; i=me@black-desk.cn;
 h=from:subject:message-id;
 bh=HuviA3htWPIWMaE9A8vkJhpFqEe5gi8rdGO5ZW4cI1o=;
 b=owEBbQKS/ZANAwAKAXYe5hQ5ma6LAcsmYgBqUJ2lUMR26aObJXj05ciU5Hw4Y8fKpE7espKtp
 srPryG7qvaJAjMEAAEKAB0WIQTO1VElAk6xdvy0ZVp2HuYUOZmuiwUCalCdpQAKCRB2HuYUOZmu
 iz6gD/sHBmhNlHOvipXHFAXMpfmx71IcfCGZ2TzE9XTQQrX0sGy53+4zbijpRbwUxLyw/fKLi+e
 TuKBPHkXWuvqXhwgM3ycMjGrckAavYuWq5d51gb6mpy/GhJYyOX8V3IjJFkj5Yt50Q1yOpd5SZY
 38/hkt9P/maNAWcNv/VT7Sfut3/XPkx+Cw9LeAyJOP6PyrLSPWR9Pg4Ktm8l0Ql+D0P4+rUijFu
 irIu00S0wIDQ5R+HD6GRFh74ZCn1JcfNED7VLdHybJMNZNdxzei93P0regAzndJvYKQjvE412+y
 V/PR0K5vfz+D8iI4Xrgei8MLlAjrfoO+qsWvqb/CQGukfGR6pU9mpgVH+YeCX3RRSOLmC7Nm2iQ
 0Dqvx1z5qjzABkzcODwHWzTWh8OskM2DNNgSt/w3P/GOPc45Rh4Dnh0Xa/SLF516awpxMKV6Nm3
 0Jkmi/CvDMFdHrkOVJhE9OMlOsthxSJS+geMYCKkbznSHsAX0BjssJRqeRIZB5A/bhJIh1ckGNv
 IPmAA7Pi4LOqP6MiGeMZ2JGRlL8pOGDKFRpScbIipBoJ5X5R4kKn/KbEtoB3wjdVzqSXrWGqQOp
 ZSNtzV6MwgR99pqVJ3XVayeXaNlh6hgIfKBXxR2i5YbBjoBIauhTbXazQT+ui5dvxhlFvW4xPiT
 pGHaZANG6kSnz6A==
X-Developer-Key: i=me@black-desk.cn; a=openpgp;
 fpr=D818ACDD385CAE92D4BAC01A6269794D24791D21
X-Endpoint-Received: by B4 Relay for me@black-desk.cn/default with
 auth_id=573
X-Original-From: Chen Linxuan <me@black-desk.cn>
Reply-To: me@black-desk.cn

From: Chen Linxuan <me@black-desk.cn>

With b4 0.15.2, I hit a local failure after sending a series with the
in-tree cover template.  The generated sent/<change-id>-vN tag contained
base-commit, but did not contain change-id, and later b4 commands failed
when trying to read it:

  CRITICAL: Tag sent/... does not contain change-id info

Looking at b4's source, the sent tag message is derived from the rendered
cover letter.  The same code later parses that tag and expects both
base-commit and change-id to be present.  The default b4 cover template
has both trailers, but our in-tree template only has base-commit.

Add the missing change-id trailer next to base-commit so sent tags
produced from the project template remain readable by b4's reroll and
comparison logic.

Signed-off-by: Chen Linxuan <me@black-desk.cn>
---
 .b4-cover-template | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.b4-cover-template b/.b4-cover-template
index ab864933b5c8..8168d8a10b3a 100644
--- a/.b4-cover-template
+++ b/.b4-cover-template
@@ -8,4 +8,5 @@ ${diffstat}
 ${range_diff}
 ---
 base-commit: ${base_commit}
+change-id: ${change_id}
 ${prerequisites}

---
base-commit: f60db8d575adb79761d363e026fb49bddf330c73
change-id: 20260710-add-change-id-to-b4-template-f9fd20937027


