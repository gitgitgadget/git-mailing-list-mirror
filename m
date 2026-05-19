Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B781DF248
	for <git@vger.kernel.org>; Tue, 19 May 2026 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205110; cv=none; b=mimocrWYAuMJ704elRdJHQi5B0Kf+uJHJKD4UVD/8D5HnkqCfQpOdBHHNXu925gl3jcdd9mqi+hWe9Y6DK0ojzBsIlQ6gXrIT7fsT0zAaStNtbPYGEbgLZtg0dvfFALel/xJivGIWqBar1k3WikrQml7g93LwTW/b/t4+/Fnsw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205110; c=relaxed/simple;
	bh=1mcHlSn3YbRmFQlubHFHTqIsxIeaIqUspCxlS2O/+3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ildvKKrgcEBFky2FLFf2Rtpr2Lq2OVkaFjVHnKiEOMkSHz8b4oUnmPGBkWLHsdoXyGIkEZPP7uBnD6/DXPpynFIKRUFcwuPhWXhPxc8UjBTlXI2c1bXoPT2vvnFMxBy4HOT4CaDYw7rvfl+Hk+wN+sAQP4BVn/C3/85qkqBNAVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UL2DoAHE; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UL2DoAHE"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9358bc9c50so599068966b.1
        for <git@vger.kernel.org>; Tue, 19 May 2026 08:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779205107; x=1779809907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEsG5iBhBfx0BO1l+1c9cG/dvluMZR2xGeRGKj38kuM=;
        b=UL2DoAHE5OttiK9u7ZhppoSKqBqvQhU5lr1rRarHjQw4Z3FDSUgdki1xenGIUhNVdW
         fGxOSHUwvtBliOw/6VQ7KG4fJT/HQR0QSq/8y8opC6H+22A12YZd264JXcdrsmNSmFEJ
         3vlyK1f8NIWhX3pDEM2430r2sxBPO+AtPEFWt3S5FfRuqG99OuQJw3nQnvvkVQW/gV03
         1hGrdc9WQDRAq/ufaJ05Ivw9A+X9Hk8yx7/70XaR27iV95ArxCdZvbKZDif67TuzYEbK
         t47hCPZ6UlOjAsPINEjKTxeCoPBakDxGmW8lS92mT1NN/avxSXrvmpdQKUd2O8//S5d1
         HXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779205107; x=1779809907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XEsG5iBhBfx0BO1l+1c9cG/dvluMZR2xGeRGKj38kuM=;
        b=iqb7MjWHbKUYBi8ISt0xygwRBD68RMKhehRKbwLrphWw+RJ2hnDEwYLexNHdUPx1HF
         7DDtgG0oJYNjOcH2q/gd4FzNrHd8s7pAwemEGQEKQGsNcZ8y1Vx2iQAieINAlKkdSu4k
         RAIR9XJqdqjXyfU0ttAlX6cV0VxaTO+GQMjg3uX9g2/UqhmkspToNgGzU9o4qJ5D966K
         /iqpZAconmoBeV3XT4W7TMYb4u+klwdnKc9w4yART/Yw8AZa7k/HfU5Ldopx/sShNF6a
         OYzawD8ZeY4VRJ5skLfhWZpH+1w29ICzDSI1ijMI04TzeBa/Pe/lvmHQ0kIIY9H3hQyr
         u+6w==
X-Gm-Message-State: AOJu0Yw7PUI574JBtZ6OlinRIAK9uPES3zitw2nJXQruac/BwhwHi2M4
	M4qi3XRDeVkBWsApvYPl+hZ9trAcN54N/pb33+3E49FDAN00qGOLVCAHEi6DKw==
X-Gm-Gg: Acq92OG3n1vSF2K+1ih3zdYXCt1NFj7Cvxo78VIQk/7PPXb6GnYl6KfCcwPgw22+SIV
	6PwNTVT1RqmuxpKr2saQN4IQ8I85ltZ1ur6ypGrh4p5TySSuW6ZReAAi8p2iZnzzfycHWc7yAIo
	flWPHkRXkRy3CmNzIR0zU+m/QW19MJSMqHGWr9j42Ldmav6WypOoGly+AiAMNc1DnD6qs7ogbk9
	WU/WSemb+K8rNhU/x5jh0LBQcITFumi/gAJhoLK8UPy3f+1KZHITFS8IBhjMg9iUi8blmO40sYX
	fZUSI/Ic4/5OvbdgVw8P9yM3m5VZFxXJG0f2I9S+ld+UQwGIZ1IeaILBSyjvH8xvFsrBDD89Mt7
	4Onfa4dutnhS8OJQknyril7EDqc0tnTo4rzlUAoe83Uv68XI6EKdE108vi+x/kbNQjfDCAm/ox3
	b5Fp7SUL4VOYesbnzxnU9rbtvTF4RS99eGV9CeIBLVyp40ov9VMmPnMizSak5FlVxwDIxR3kPZE
	q3TG4eQnky23UutB/MTIJVJSL0gghxm9SKdEp8=
X-Received: by 2002:a17:907:8691:b0:bd2:626d:68cf with SMTP id a640c23a62f3a-bd517929a8cmr1200727066b.29.1779205107090;
        Tue, 19 May 2026 08:38:27 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd7bbae7a93sm281403766b.22.2026.05.19.08.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:38:25 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Toon Claes <toon@iotcl.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 1/8] t5710: simplify 'mkdir X' followed by 'git -C X init'
Date: Tue, 19 May 2026 17:38:01 +0200
Message-ID: <20260519153808.494105-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.136.g92075d88d8
In-Reply-To: <20260519153808.494105-1-christian.couder@gmail.com>
References: <20260427124108.3524129-1-christian.couder@gmail.com>
 <20260519153808.494105-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's simpler and more efficient to just use `git init client` instead
of `mkdir client && git -C client init`.

So let's replace the latter with the former.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t5710-promisor-remote-capability.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index b404ad9f0a..bf1cc54605 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -177,8 +177,7 @@ test_expect_success "init + fetch with promisor.advertise set to 'true'" '
 	git -C server config promisor.advertise true &&
 	test_when_finished "rm -rf client" &&
 
-	mkdir client &&
-	git -C client init &&
+	git init client &&
 	git -C client config remote.lop.promisor true &&
 	git -C client config remote.lop.fetch "+refs/heads/*:refs/remotes/lop/*" &&
 	git -C client config remote.lop.url "$TRASH_DIRECTORY_URL/lop" &&
@@ -231,8 +230,7 @@ test_expect_success "init + fetch two promisors but only one advertised" '
 	# Create a promisor that will be configured but not be used
 	git init --bare unused_lop &&
 
-	mkdir client &&
-	git -C client init &&
+	git init client &&
 	git -C client config remote.unused_lop.promisor true &&
 	git -C client config remote.unused_lop.fetch "+refs/heads/*:refs/remotes/unused_lop/*" &&
 	git -C client config remote.unused_lop.url "$TRASH_DIRECTORY_URL/unused_lop" &&
-- 
2.54.0.134.gbbe8e27878.dirty

