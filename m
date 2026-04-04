Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90E2345CBF
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775332209; cv=none; b=JUtyFz3bbx5uH0a+QIc3uDqIzfB/DM7xOany5zYWNvl0LMaSJbtoGxGH6KA2f6y7uaIrbDSppZdYfR2Keh/HlRuV2+6p//zJxN3tvDown5mFPe1IOjUK08JiIktIF++zH95bA1vVC1l7wVtj8vA0IVAOdHotNBEfJMc3oUQ1snw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775332209; c=relaxed/simple;
	bh=z9QR+dxHKisY6SoYg+tNmPyx07WiRTNffuy+zHueBwI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=suUixivyPWeoyFJn7kE1ZGwVtAexjiZfy4zc0s2FYTHzEKgJ0M5ypQb//VAjRegwVDuAXKWUcUTcYyFpaWdw0ygTcbNteUf+RCq0rMyMLSATN1xuiqheDR/XuE6IHsGsd69Iw7s28KdifxQBX8pWHdsPk3oFtF8gqcRrG+yI7hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F18AjgCb; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F18AjgCb"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cfc2d1fdbfso232307885a.3
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 12:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775332206; x=1775937006; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHajVuVeIAYlSYoJnP2waQUXlSsDs20NLhykM2WZ9PA=;
        b=F18AjgCbu/P7et+IL4q9/iPn63QpPzUS3WAh1HAAsngmJ4yBo5Wom3fL01U29Kpl9N
         bdZReNeSmhQZ26dFsrH0aHJn5QfVrcQM8eHwcrXQZydDxjxSL8WjPR3qXYA7tKiGJ3hR
         oYWDwQ3qeLWrBK02T+dy02x3XDPjB+eju9OZkAzXVNLWwrhradFLZC2xGRUYUn+c8uuF
         blxnFxbW9+2pA5WoXq111upKoO07fTjmOi67fBGOYzaukEz2Z+dJEMEUY8xA+b7nk5bf
         m8LItExJbnh30RQFYPab3xNHO8qdcaEZelK0TCGrvQbn3OnJ/57yxhJfrWlj4RcDOz40
         z1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775332206; x=1775937006;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pHajVuVeIAYlSYoJnP2waQUXlSsDs20NLhykM2WZ9PA=;
        b=Lldr0gPYPsUjujOyyoA5CUY/qtBJgYuIC2Fw5khLUr1tqptiultN2y1tx9RW3iKpWw
         x7bnNK6DB1duF4tV1vkT88FXaPhrDKLqAcV6Mx2ro/l0tNb1rHoOKwJbq/pZWP4lK6BR
         dmE95ZnMq3MYO3lUC3TVauzEkvfKeGN/e2dXZ7aKrrAutaocsMm49HuzrISCoDZBe7/W
         a5lnNpUjV5ZTVFI3bxIqKeVaJroOMRBEp0JOjeWbaAY90+quljiq2/v4ky+C+kCgmjYx
         40PmWBOZDQbZh2ZLlGlFgBCNw+CgcviCqpMYDnXTIETF6FGdoLet2eYdBD5POkjkc+UR
         ag1g==
X-Gm-Message-State: AOJu0YwfzeYYRGJxy57QhUUtEwDHZYVDsICY4068f4OywE5DmUE0yuyY
	547zv1+EHdVeLi1TljMc0YsrFrn+AqAOChMDNJEKRjpJlY+YDft9a3RI5C575MWJ
X-Gm-Gg: AeBDietRCMkaqhIOY8x8KeJftcKqHJLVHyvuyvIIM8/PvuTwSLSQ0oVAeCXoey5o6hE
	UarWHwZbv+vlpPVWTGpWq5sU1Xu8wOKyoa6OhcAd+oGIYa/izPWFCU/EFObRtxQlTX+ZUfSYHZK
	amJ5WF+kqNye4uZVgNKwrcA5KOlko00FSP5x9A8UFDrpPU0kLewpNSdcariipZ87i5RtwrN3fzk
	tM9wNRaaJfAYAMdyAWJDDWiJmHTHbqCZDXI3HH4qeI0F9yL00dOdTT2RgeIey7hOxEFjFWoObB2
	ipCoZLIVHp05uUm5dYVvfn2ByaCWZfG0o3F6ek2FmfuCrFHAaSRv0oyGHtcOp6QA63+zHZqMesT
	+GyS+LudUupSn7HtiWpO+1VzAID8DhMYMuEGhC5bJ+PII3PN9o0WuMm1ORNblCALVcNdHxaZFu7
	T4c9nkWR4KyYfCK3lfiObu4zV22Z0=
X-Received: by 2002:a05:6214:448b:b0:89f:2fa:a9b6 with SMTP id 6a1803df08f44-8a704abb902mr130980826d6.37.1775332206146;
        Sat, 04 Apr 2026 12:50:06 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.121.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a593908b47sm92318396d6.11.2026.04.04.12.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 12:50:05 -0700 (PDT)
Message-Id: <a084c39273ec9e613fe1c6c982700292f5ddb705.1775332197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
	<pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Apr 2026 19:49:46 +0000
Subject: [PATCH v2 06/17] t1900: avoid using `-C <dir>` for a bare repository
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
8d1a7448206e), add an optional 6th parameter `repo_flag` (defaulting
to `-C`) to the `test_repo_info` helper, and use it in the caller that
wants to operate on a bare repository.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1900-repo-info.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 39bb77dda0..6280da1efb 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -20,6 +20,7 @@ test_repo_info () {
 	repo_name=$3
 	key=$4
 	expected_value=$5
+	repo_flag=${6:--C}
 
 	test_expect_success "setup: $label" '
 		eval "$init_command $repo_name"
@@ -27,13 +28,13 @@ test_repo_info () {
 
 	test_expect_success "lines: $label" '
 		echo "$key=$expected_value" > expect &&
-		git -C "$repo_name" repo info "$key" >actual &&
+		git $repo_flag "$repo_name" repo info "$key" >actual &&
 		test_cmp expect actual
 	'
 
 	test_expect_success "nul: $label" '
 		printf "%s\n%s\0" "$key" "$expected_value" >expect &&
-		git -C "$repo_name" repo info --format=nul "$key" >actual &&
+		git $repo_flag "$repo_name" repo info --format=nul "$key" >actual &&
 		test_cmp_bin expect actual
 	'
 }
@@ -48,7 +49,7 @@ test_repo_info 'bare repository = false is retrieved correctly' \
 	'git init' 'nonbare' 'layout.bare' 'false'
 
 test_repo_info 'bare repository = true is retrieved correctly' \
-	'git init --bare' 'bare' 'layout.bare' 'true'
+	'git init --bare' 'bare' 'layout.bare' 'true' '--git-dir'
 
 test_repo_info 'shallow repository = false is retrieved correctly' \
 	'git init' 'nonshallow' 'layout.shallow' 'false'
-- 
gitgitgadget

