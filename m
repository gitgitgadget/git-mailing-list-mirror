Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42412345745
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 19:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775332206; cv=none; b=Q4Fbxp9Gz0CrXLjKDD4WxsyOM7AazhOgi7qoJI2USZQB3cVuRIUyMzbL9IJUjSf2wXoM8v4hxP+cPxWJci9R26qzr8Ygy2FVgs8P5QHo4mpVZRlGpQjpMurqjvqIHJeYa4zm/xUISEPQQrb75CG6HPFJsYt+iWJEUWHVt7yM6Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775332206; c=relaxed/simple;
	bh=2j8mcnSXMQi4KX4rP+JWp9PsLvyd57VyobipgDASfkE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eGCYEO1v48ndVkd4lZFFVp4ldGHdgoUU70KaJAlJbmO+TvqeQnvceC7IKIOauHDA661buiVBXTwtAfnGXMlGuOi/JLuPfX6IJA+csuWlKU0w0TkCGHrFPEAP8Q3sXMmuhESPvbiMHCyXGomGZPO7P9bKSCXcHhZy+8mWoKTAQjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kz2W/7Lk; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kz2W/7Lk"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-505a1789a27so15278441cf.3
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 12:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775332203; x=1775937003; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXuJanUDNBqYJGeXEY7Lhz8kXeLpNSOe9kdYkBqgAEI=;
        b=kz2W/7Lkg14zTXXPD4IrlUAFEcI+rSQcTmKhdfuE4Xy4Ivi3VI/O5wrGp4HVdZ0DiB
         J2JC1zGE9Jxnt0BGjO5POysfY0VuztOLRwiW/lCAK0QMYWVTvEFTg9ZkWLLJOpMENnx7
         AO4DOgiYm1XLCYOTSBJpH50RGnTHJxndAGzA9Hs+Jon/ikmrDj4k8rqHu6/F8eHbq6O9
         NLhdevH2xase1Zo3LL0tvy3h5QTJSC/MtJG739gaxco1e0e1OOUMR/aCdFGtm+qg3SSy
         ZTU72jjMHIb9Tth0QPfHl+8/HAVNCJ9qd4z5eSIaMAe7icA0BrugUIXXhD+rg8xauZaA
         fd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775332203; x=1775937003;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WXuJanUDNBqYJGeXEY7Lhz8kXeLpNSOe9kdYkBqgAEI=;
        b=Zn65CGqBLAy6keR00JVFyATUmGrLAttMbP8pxheuUKLV/8CCGCZ3dHd8wz7ruAS6m8
         iTQlOpJ0wEneGDmQ6XDBBOJXYwVhdxLfhsFcuc37if6fRMD8I0NubVEgQr2IigXUEDrr
         Z8XPbr7Xb+yAbV5mDkgZn49hjhqTiLlsfPfPgPjt7q4j0eLRyxIhpUzOvL4NrXrgpUaf
         3VtD8x+kovjSjmaTu09AXDajGqOZPatzngtHijlUitnsaVQUZx2yMrpQ3ebD4f07926c
         uyi9CFvy30VmeFf8VFvGaROOo5rfAl+cgmsKMmWMlrog3Tl1hjwbm9LZgJFt6szHIFzg
         NTlw==
X-Gm-Message-State: AOJu0YyyZvrZmcjENQ2uO/EsE2TkXB178kaLcZXalTCjYV+iW4/C0ZFt
	SyBYuyMXjg3x0CHOJalun1OFrQEV+PybwDdH+1lsp5YqH7/csWVohyQZG8bw7xNt
X-Gm-Gg: AeBDievx+cqGIjfCa76arEBgfRsL13KxtVDNWYA/xq+fdvn7Kl9ho/YENw4f9XA3hkx
	xaUx7gEMh4hHlOUTju6bF5MoALPLf8Menf7idlMx32BmJ9j+4vLtdlOMzinIn6z9ToHnpDYs2xn
	GhpCpEJVrjApVsQlhws+/cWK1g/bf1aaznbXi/UHsr9lINmm3orsf0YHRm3DIT0PUqATk7x3YlN
	MTC31bI0N+bopVcs8yurvKvwn6Z+omn8No+0QqT0R+ouWrXV2V2Ei+4QiM0+n7babzqUFpXBvUf
	YVojFB9x5weWb1XNui+C/2mHEZqPVESWc9IzuCD/eMd5Zq/4pWMO727SKhPtu6BmFwp5BsBLePc
	Du/Jplx0QP+v42dcpIyg0GqddskVtm6GNx3JgBg3lx2czgqw/aXp+lZrk5B6RksGH9K9A2gV80C
	57JeM7AmJ+jaY5pAQPWftt2HrVgdY=
X-Received: by 2002:a05:622a:5a0f:b0:50d:85b6:d4d1 with SMTP id d75a77b69052e-50d85b6d84dmr11526041cf.46.1775332203375;
        Sat, 04 Apr 2026 12:50:03 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.121.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d502df89dsm64200511cf.12.2026.04.04.12.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 12:50:02 -0700 (PDT)
Message-Id: <5b6bb1863227cf95700fab4934ec2e1dac9570aa.1775332197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
References: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
	<pull.2076.v2.git.1775332197.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 04 Apr 2026 19:49:44 +0000
Subject: [PATCH v2 04/17] t0056: allow implicit bare repo discovery for `-C`
 work-tree tests
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

The `git -C c/a.git --work-tree=../a` invocations in t0056-git-C.sh
enter what is technically the `.git` directory of a repository to
test `-C` combined with `--work-tree`. In doing so, the code relies on
implicit discovery of bare repositories, which 8d1a7448206e (setup.c:
create `safe.bareRepository`, 2022-07-14) prepared to be prevented by
default.

These tests verify the interaction between those flags, so changing them
to use `--git-dir` would defeat their purpose. So let's just temporarily
force-enable implicit discovery of bare repositories, no matter what
`safe.bareRepository` defaults to.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0056-git-C.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t0056-git-C.sh b/t/t0056-git-C.sh
index 2630e756da..6b7122add5 100755
--- a/t/t0056-git-C.sh
+++ b/t/t0056-git-C.sh
@@ -57,11 +57,13 @@ test_expect_success 'Order should not matter: "--git-dir=a.git -C c" is equivale
 test_expect_success 'Effect on --work-tree option: "-C c/a.git --work-tree=../a"  is equivalent to "--work-tree=c/a --git-dir=c/a.git"' '
 	rm c/a/a.txt &&
 	git --git-dir=c/a.git --work-tree=c/a status >expected &&
+	test_config_global safe.bareRepository all &&
 	git -C c/a.git --work-tree=../a status >actual &&
 	test_cmp expected actual
 '
 
 test_expect_success 'Order should not matter: "--work-tree=../a -C c/a.git" is equivalent to "-C c/a.git --work-tree=../a"' '
+	test_config_global safe.bareRepository all &&
 	git -C c/a.git --work-tree=../a status >expected &&
 	git --work-tree=../a -C c/a.git status >actual &&
 	test_cmp expected actual
-- 
gitgitgadget

