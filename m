Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7019917BA6
	for <git@vger.kernel.org>; Sat,  2 May 2026 14:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777731365; cv=none; b=RqjlEJGhUbP4TGObz6cGcH+7bqTWNg6IbGO+l9pvG6sjhCfQsIlFiQmhQeFZogAmzAszqC6Z8bGYUkL3Feqb8rvYjoJrPK1c3KF2ffxAdosPdoLRLWl4mwsdqQnWb3gxW9+a0R4eeL8nvn7PLPNErmGK2ldbCBTF6eveB9M0raM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777731365; c=relaxed/simple;
	bh=zAJtWSKiO/d3CjR+w1avx8QM9b6dTfQLvIDMi7us0aY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dnkaAke2E23qIBNZ01EUEFpK+IUuw+y9wuCo9ZVouVGAWzOihTsoc6wJDeYVO4muDJvXgZJXjK3cXQ3aI83v9sqQm4yu56f0CK5ZBbZVaOenNP6RjbaM6JTeJZ0hBcxULMO4BZNg6yjDVFp+X8IwFWEyVeLzZm8Y1WGeORhmOSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XE8TK6hc; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XE8TK6hc"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so3420178eec.1
        for <git@vger.kernel.org>; Sat, 02 May 2026 07:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777731363; x=1778336163; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DzjIgNubr7zk6bLMgz4jv5wQ+Yd/5MUzwm0eCbrfhk=;
        b=XE8TK6hcMGTG4T4Vxe9Rsy9POTBVo049FdFUoe1DxzqzFRx9Kp+oy7YkF+xS5NbGxf
         0XMuZ9m9q+B/6mYfHPssJ6gZ2ZWcJ3lRGVv/PEGI5KUuX0edh010AI5u+Iq/JZd/dz+K
         dc1eit25Qxtv4HmjwZu8levvAFY1tix03ouGOyWSV2ZoAiI4x5VnDcm3Xyx5M1srwx22
         u+y5LP2piiBL5y5H9JRfYCR8c0G0R8AbRxhOIeXo+UGSX7kqKBGOSQxx6w3hbcmGGSue
         03nKFQi7Aq94WN0iCeTjCRBptOa/lT/fKOuTW2xXVz8Hraop0cZn1XX5O1t1Iy/rq+kz
         dG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777731363; x=1778336163;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9DzjIgNubr7zk6bLMgz4jv5wQ+Yd/5MUzwm0eCbrfhk=;
        b=m3rn4i+AR+bYPWkvA2guk4ONV1SkYMKgKcIxjYLVj+AENVLdxPE2FpgAchUHevaO0h
         QaUEPAosmzShsWzZ0exYvxeD06HbaLqdV+DSLiED9iTlaGbo2Ap04nPQTO+9pdBrvmCs
         hwGLGkELUtMoLExGCyNTttuLaJl7jFQY/IgahvrbxY+6Qg/U8+0+sKwpPOFgvI3G3VX6
         sbmSPnWwdYkvLygqAkenc5mXZutdo3Xbry6NhE/5eJwfCV25QvNUsmbfNjJtXakqSSLx
         xBliuwAtZg2LLsWRMjwdEaXEJbj41g4L9vGHJUzYxGMAJjuV3V5pbWgfWv+6uBlTInkJ
         eGvg==
X-Gm-Message-State: AOJu0YyBO2/rdRsJJxZA5wBHvwghDnwuA7icSqJkm96H5iyyDeZsTsps
	mB2Bs0UfnskrNHsg5iIh0J21MjQXGdIdFZyNC68BOTWkM6sBOq1FZTYgHq8bXG7N
X-Gm-Gg: AeBDieuSs22SM0IPCgpWLfWau+R5drEbivZnsC49ySt5ya7UbaFfnKrRFEnVBAhuBae
	HvFZVBhoil66Cxnbkust6bn0GfY9luNk/nzZvVOzrdAFsd+yGr2t/z45uVYy4UX3PLrKiOrD57S
	9kzXno6K3LD8EsAF6o0So4U2JpaLeb7mzctPsUATnJJ/ryxqzuFMEJzSplzaUo9qhwhYkEkpwN+
	Rw+BGFWLa8r9W6aic9QePrtxPACdTpvUbudUb3R4DTAXxDafoaxvnoR4GcHkig3kQwgaIy6+wWq
	njh+G5E9bFBDZ85XBjvFZOhLSqK4xEMK9F9dWrQ5W8A3PRwhGG1r9nCJ2/Poyrymi76iVKsw9NC
	4DhdZBbMlI8vkqhivPcPeRr3hcpen+SC0r+lBgHpmrJ+/x+gJhIYhprvGLlRL6t+2UwPlRlav4z
	XKS+tbfw5tXoWRi7eF16Z8f2lzv7zcOCLdscfX
X-Received: by 2002:a05:7300:2322:b0:2c0:bfe3:b95c with SMTP id 5a478bee46e88-2efb8aa1f8bmr1501825eec.4.1777731363055;
        Sat, 02 May 2026 07:16:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.87.216.119])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3c24e738sm8310429eec.31.2026.05.02.07.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 07:16:02 -0700 (PDT)
Message-Id: <22db528d0c5e6db71664f071dca97ab218f4ba45.1777731354.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
References: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 02 May 2026 14:15:51 +0000
Subject: [PATCH 4/7] backfill: die on incompatible filter options
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The 'git backfill' command uses the path-walk API in a critical way: it
uses the objects output from the command to find the batches of missing
objects that should be requested from the server. Unlike 'git
pack-objects', we cannot fall back to another mechanism.

The previous change added the path_walk_filter_compatible() method that
we can reuse here. Use it during argument validation in cmd_backfill().

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/backfill.c  | 2 ++
 t/t5620-backfill.sh | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/builtin/backfill.c b/builtin/backfill.c
index d794dd842f..51eaa42169 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -144,6 +144,8 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 
 	if (argc > 1)
 		die(_("unrecognized argument: %s"), argv[1]);
+	if (!path_walk_filter_compatible(&ctx.revs.filter))
+		die(_("cannot backfill with these filter options"));
 
 	repo_config(repo, git_default_config, NULL);
 
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index f3b5e39493..3580e10b9c 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -15,6 +15,14 @@ test_expect_success 'backfill rejects unexpected arguments' '
 	test_grep "unrecognized argument: --unexpected-arg" err
 '
 
+test_expect_success 'backfill rejects incompatible filter options' '
+	test_must_fail git backfill --objects --filter=tree:1 2>err &&
+	test_grep "cannot backfill with these filter options" err &&
+
+	test_must_fail git backfill --objects --filter=blob:limit=10m 2>err &&
+	test_grep "cannot backfill with these filter options" err
+'
+
 # We create objects in the 'src' repo.
 test_expect_success 'setup repo for object creation' '
 	echo "{print \$1}" >print_1.awk &&
-- 
gitgitgadget

