Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB348BE9
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 05:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776749642; cv=none; b=krgU5sMwlMfIDKZobmPPxghUXxRd5OstT63cn4o15aACnfyDuBvXydJsuhqOrLOlBhjw/BQbI14EZfFsN1CwBFsykO1dF04qvQ/hIcuj5kRu3PuRppFeH4wQlCOVlIXQyrIA4C2q5otBXe885drenyxG0vBR/PIBImrSOQZiJM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776749642; c=relaxed/simple;
	bh=5Qggh7i+RjbP/cAv6lIX2yb1OgctP4JZAfXnDp5BGL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XjOz0JUQ6l8fu0269N5ntuZDvRF+uUm00uPH/19vqj+FvFkb2r+vORgA/Kbuq9q2D+CaZF68bV3Aod2vDFRvHA3VCOm5Zw0J+wAi+tw9H4zb3j23dS4oO7j2s1MOXdTKxVXreWlLDolgw8AgnJJG2fKSjLqGGHBb7aUm4FkW7vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjI3KY0S; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjI3KY0S"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so2539033a91.0
        for <git@vger.kernel.org>; Mon, 20 Apr 2026 22:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776749640; x=1777354440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmjeU4zZ3fPhzQqJgAMGgbIB8aWkV1SALj4vepPq8cc=;
        b=WjI3KY0Sov0QMGfhY6mB3ezo04WtzsaY945K//Wj0pY3G1+Dddzg6+1GVxdRFm0Ezz
         ts0wtoHjaZwd4q1CWGIM8JmCC0ffYHDDYykd4WPwRJHHHnsVGipCull2xBSPk9MNHvtQ
         +uL3ShHH85Ja+qoFq9l6O0ZRBCAiIoXABBIQflv1nBJ3hJ2O1Ogtu2yGgLU6zG16eSOZ
         Cqtjb07uPm0qlG4XY7qwhArn/0YndHIAm6GH3qeF2bclqubS/OJq+xxFOVWSxkYryBP2
         O6CPKiab1+8+gMJwWCohQGSRBPe91fgEq5q/fI/wqZnZuGrZs+Wy8uF5liy5zNbv4XnF
         Exdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776749640; x=1777354440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fmjeU4zZ3fPhzQqJgAMGgbIB8aWkV1SALj4vepPq8cc=;
        b=LJI82/KQ8vRxqcvn7NSm7P7kB9Aaf2qWiTxJxtWvCd3oNMdLVgU8Kcil5taOkWloex
         RMD2OWuOXZDuAkARA8sgiKJ44hSNVZWW+GaluW8/u+UFqnSRTsJsng2l0J8U0A36scYc
         8Zfz1FBWa1+haFcC71e+FgXy5m76le/tG+iZMmeIWyzQft21kQmGSDTcVzN4yXBVgIsp
         SnibgUlerh7C0isqjGKAeEM1dw3SrLMNFgNhkMsawrGjLKp5W3NxXlKXQA7U2K8gBsmr
         pl8X4pxjAcvKJb/0/D4Cy07utVEVSayQttrD86+TaBtIH490lpLh72XSmesBkXn21X/q
         +Ipg==
X-Gm-Message-State: AOJu0YwagjKWt7k68Axl6J/g0Xcl61jO3P3L94F/SGUoYQU4idkRCjWS
	gzacMthq6Qf9xOX7qyGCKFSctnb6WUZATNCdxqd24mhJFHl7iGFvITq+SrJ4RA==
X-Gm-Gg: AeBDievaLs7dN2EuLDSsOdU7c9Uhdos5izGIUoepuiMNBozxJEQ6NdnUCqZGX7j25Hi
	zT79oZ0nmz8tbjM7G9QbePiIZ/8rNPP/JCd2lIhqee37CNgcVzC0wlgBfIs08RWV19ZQRMS0xd6
	NkBCp1czc/ODgxt5/8fIrRtq5GhRKpyAcvTnSz47R+KH9eom2NMG2VYw+li3vLvfadZF2eabN9W
	nSYgQsqGSuS9S/vRiIvC13yJUShEJqpVF89FKpBRxKEmEiIeJU96lF4oz3kPNkLAQ2ZI6oDTlim
	qDBfNYz+F2DUbZcXQR3AykLFO4JHEGhmL4TTvLr2xCOq3I208187avI9zi5REIog+qIfBwanm+G
	6ElJpbiTTAN+QQ7BELYLeTnLC8qcFr8EJsC0Dqvu2JyhZB4YE1NnoyX8HIsgDKs6/sI9B2eGN0V
	nH+adRlNs188oGNSZUM8gF0N0ssojE1MPP1I1ZyGe/pKg8Nh6dxyjZEaJFW1LnSXShSt1Gzub5t
	+YZQ8zInaUaEXEjQ61+oZAdOifF/pR9bU/poD429mGGwX3vpLOCm2vx12rJA0C2IjLsXEWiPRQq
	29Q=
X-Received: by 2002:a17:90a:e7d0:b0:35f:b3fe:18dc with SMTP id 98e67ed59e1d1-36140493786mr16495976a91.19.1776749640318;
        Mon, 20 Apr 2026 22:34:00 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:c0a5:e9e6:3079:1553:266:991])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fa91d31sm6454484a91.2.2026.04.20.22.33.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Apr 2026 22:34:00 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	abdobngad@gmail.com,
	bence@ferdinandy.com,
	john.a.passaro@gmail.com,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH v2 2/3] t7004: dynamically grab expected state in tests
Date: Tue, 21 Apr 2026 11:03:33 +0530
Message-ID: <20260421053334.5414-3-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260421053334.5414-1-r.siddharth.shrimali@gmail.com>
References: <20260414141828.27576-1-r.siddharth.shrimali@gmail.com>
 <20260421053334.5414-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tests for 'Multiple -l or --list options' and 'trying to delete
tags without params', hardcodes that exactly one or two specific tags
('myhead', 'mytag') exist in the repository.

If other tests are added, modified, or removed earlier in the script,
this expected global state will change, resulting in these tests to fail
for completely unrelated reasons.

Instead of hardcoding the expected tags, dynamically grab the state
of the repository before running the commands under test ('git tag -l'
and 'git tag -d'), and verify that the output matches or remains
unchanged afterward. This keeps the tests independent from the script's
overall state.

Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 t/t7004-tag.sh | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 77a7a9777d..bef7618da2 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -145,9 +145,7 @@ test_expect_success 'listing all tags if one exists should succeed' '
 '
 
 test_expect_success 'Multiple -l or --list options are equivalent to one -l option' '
-	cat >expect <<-\EOF &&
-	mytag
-	EOF
+	git tag -l >expect &&
 	git tag -l -l >actual &&
 	test_cmp expect actual &&
 	git tag --list --list >actual &&
@@ -226,12 +224,7 @@ test_expect_success 'trying to delete an unknown tag should fail' '
 '
 
 test_expect_success 'trying to delete tags without params should succeed and do nothing' '
-	cat >expect <<-\EOF &&
-	myhead
-	mytag
-	EOF
-	git tag -l >actual &&
-	test_cmp expect actual &&
+	git tag -l >expect &&
 	git tag -d &&
 	git tag -l >actual &&
 	test_cmp expect actual
-- 
2.51.2

