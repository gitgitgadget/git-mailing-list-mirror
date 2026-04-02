Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18683DD510
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140421; cv=none; b=ti66wVVLIuMByVF3orksxJ2hBJ1p9fjRgWfnOoAl6RGa+3BBC/7WdtBVzPz8mV3t3ay1hreJguPjySQUagvJF/dUZRKXA+q7AnbS5pm/NKvIRRtfFsrK9w1kE5e3F6u/Epq/gouaWJYJJi3t61Vx/jXf474xGrGqsubvoKGqQ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140421; c=relaxed/simple;
	bh=kQ9Avs4yY2K1gcMg4XJfpdio13fVqPse/J+5ReUjnwE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VMlkP1lqFOGIbPHI7to91fWewmLq8cviUTkY1MBkajG/vnBjIplfvCjSeXunz+3WSg/DiZoxuogfPQiGu7UO5xQ7GIFdtrgfPWujDWSJVqUxl1gk1Ncw0rmNKCSo6X556j71UXh+6UKtz5UV9o27PoY50Vg+fhYcs9KRCaCNwGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s6SFA0WT; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6SFA0WT"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cd80f56b27so88336385a.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 07:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775140418; x=1775745218; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OACAOTDQZSPNNnO+8JALVeaBLvs5HbU36kTdS4r622M=;
        b=s6SFA0WTst41EIcQpLGe1Y9LW9rBo8/gzEDDDFBp7U+qXaI2D22GuAkrEd7NrOAAqO
         NRWZ5bhfbu1YbE7aJE3b1gNkXeDy+hvpei9fWmrPe/WG5FcbIhEi+md8VfcLEOwN5ai9
         8v6tWzXvClG4nq9SAIOdQDm+oAXBrkIeYV1mPAq2Tig+Elz4Xo+WBLOiXC8A94CMv1PN
         tNDQQwHuXa2NU/RavZPtyBAmBWFXG2mQaiUdMnouFTTYSAMIuIFtYURwQ67KaXXC62x4
         SOuLHCg/8D24CJKcG1LcfFtbCxMxKpDCB/0cXkUdvUxwub4Oc8YIrpcLmmukK0SObyeO
         lxvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775140418; x=1775745218;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OACAOTDQZSPNNnO+8JALVeaBLvs5HbU36kTdS4r622M=;
        b=pkQLVa8BNAxJ1R89A3VI7klA84w2fbc1oSVt18TnOMoz9LV6zU91kW890uGeY7x7Xe
         kSJb4fLrdlH2uXn++z5OYk2zJL/Qfo0JdzcHhgviTejxq3e7KdzlHicpxLOnld8vzgYE
         t9xGIEgvb4el2VxRDegGD45RupgjzRQYUaHxrRW4q5uYeV1HiK2KOuBQYNWPW6ytN+WK
         +20WOZJiEoVL++PRjzUwe8CExhQ/Dq9TScjV4W3LrxkhzTUrXRaTzLKK6RYsoyh7ugUW
         U/WCgJ2Mlr9D9qzGHBH4druaQyIn1S+vBYBorJhpav6xWy70mbeQMoZzKT6EGKG1oRek
         aszA==
X-Gm-Message-State: AOJu0YwGs/Y9OmN9cXcQRzE4zAEyoZ1cRcYTR3MSkDg552tWuc/k2ZS/
	MVuSkpUSZfT6AKwg/WL1WIPjj49PZXPCC/ulwtTsnLfLgi6vk1tyzno/4TNMFQ==
X-Gm-Gg: ATEYQzxPt7H3Yjo2xqNOjfNMBa5ub4/sg7gMiFPB/rVdAXriAXBmZ4vpapr5TMFTsfS
	G0302wWyasTDJFgHtd8Ez9dYT+gAu9Ktz0tNjuq8dHZcaMEkBfxN/KcRrmNGQrQLN62xLInvR4z
	/YvHy0hYbquIF8FNAZf8UNSioT/02GzD64XoQI8JQKyVnhTW5iKsuPgnkHpcuQkP/nKQZgxOMNV
	GBg4Ohyz2csIPH3LQZOvdNr2DQyPfTzH6nSvCfJ7gBlOPrC0Scj1SH9/aV/Ks7/oNacd6YJ8dtN
	ntuJuBL7cVjScdxy90JlHeFKW4Peb28ORihliEj4ynR+JcaPi2LqlgajOXm/gRWUghgfY0yxrC7
	yUi4IXBSSKLRrHS388VZrojTGh2nJwP7ttM7gtdYYXcOmJtYDNjBW53siWx5LPgazp2Ltc0xeGs
	8TmjfrYh8nxBEW0OGSrN0eYuD/QVjkPRsxW4sW2w==
X-Received: by 2002:a05:620a:2686:b0:8cf:c106:faca with SMTP id af79cd13be357-8d1b5bc75d1mr1142967985a.36.1775140418416;
        Thu, 02 Apr 2026 07:33:38 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a806e54bsm257157285a.30.2026.04.02.07.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:33:37 -0700 (PDT)
Message-Id: <6932658411309228d2d670d9b6c2e4be4f17f985.1775140403.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 Apr 2026 14:33:16 +0000
Subject: [PATCH 10/17] t5505: export `GIT_DIR` after `git init --bare`
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To prepare for `safe.bareRepository` defaulting to `explicit` (see
8d1a7448206e), export `GIT_DIR=.` right after `git init --bare &&` so
subsequent commands access the bare repo explicitly.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5505-remote.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index e592c0bcde..6d3d8510ca 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -561,7 +561,7 @@ test_expect_success 'add --mirror && prune' '
 	mkdir mirror &&
 	(
 		cd mirror &&
-		git init --bare &&
+		git init --bare && GIT_DIR=. && export GIT_DIR &&
 		git remote add --mirror -f origin ../one
 	) &&
 	(
@@ -583,7 +583,7 @@ test_expect_success 'add --mirror setting HEAD' '
 	mkdir headmirror &&
 	(
 		cd headmirror &&
-		git init --bare -b notmain &&
+		git init --bare -b notmain && GIT_DIR=. && export GIT_DIR &&
 		git remote add --mirror -f origin ../one &&
 		test "$(git symbolic-ref HEAD)" = "refs/heads/main"
 	)
-- 
gitgitgadget

