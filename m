Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E86422545
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 13:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948666; cv=none; b=ILBcyw5o8CGgZPTxxvryi7NznFqLq2kGYrt3zCNXoyK5gnZbFgGVeTmKWQYxaIDNSZUINiaTr6PSzmE9ogTV2n1KoojtfjyAoWkVSVBT7fnysrj6U3AhVPQhSMVCovCUR9yPODUiNaVagHg/fQxWrgQZv5uqgNAK/7okIzFRuaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948666; c=relaxed/simple;
	bh=Ap/70vZ4VhrqyQ7qKjM5SwTNZo6utSbnDpwXL1AzbhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPEf3YNnK5HhQugklOgKQOc949/0FU3ECrBfp0lw7L28MfHB5uEkwO5ebbipbXK/IG+w9/ugZgQaB6octaLVGpgwYx7TSLebtQp1QeK0juHg0Z0oN09Zum6wm6ZLdBc6hGmWyIgHdrUyEQUqr0jNxiXIBolnMW6el205lrvMxlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/B2hNEO; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/B2hNEO"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493b77b150aso26271485e9.2
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 06:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783948664; x=1784553464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UECmQ66lIfAdz24Xg9lYa9hdniw5b3GC0vh+hhJdAy8=;
        b=B/B2hNEOuZLlW2ySLPvm83b5r0ihtVMH5nkOO8mvJkiXB9SjyA1hlL6stAwuxpcVab
         vHXYkPKqLwi+I1PV5SqKwLYvIsSx6rr+pifb1O2o8crUUFzQoxPg19PcW2Sa/lXGUHU9
         HpcWEgbWvc/vSJdShCZ0NLH/A1MwhgqYZfgex7MNn70j6xeehCAV/6K5ScKcVJZp8Nxz
         A4X2Oj3CiCZ0mPuPGZMSHKoleZWStwoJl9OR/Z/pLNV7zpOKJQbP+0S9VlfeUQRuKdTC
         zi9v66OZWp7T+z+GkZExLYz21MmVK5jOnyKKapbjxqEZ7MHg3+gm5FSVLeOeKyb7xIqF
         ZmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783948664; x=1784553464;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UECmQ66lIfAdz24Xg9lYa9hdniw5b3GC0vh+hhJdAy8=;
        b=Ww5P/yGfKkjhiswWoJaQFV7aZvUOc9RReYJfJwigDFfOTmX0wdbQLlLsohd7Cx+KuA
         l3DUSxRYplQsYvk0rriqQr4rzCHKdgIY+dDrfTfFBo0WJRDauf0DTb0rR2KQP1NjHwzy
         hqG6zCxLd4mE4sljFKvLpUDUq1uxv5Zu7k7BiFKtJeIdsIcnDGeWzBWCi0YxPgflY9uF
         ZKqs05C6iRNX+TsLXYuxEOIliUNa0SlQYtfIqeL3aopwJv/Y7VYhhlDxmWJmiq8FWD/K
         ezej4jT8ugR7nn8Mu5+LDQv6fBFmdn3Fwzd8n7yKS37dW/3C7Le03DjYuSndTFNjQWMe
         IUzg==
X-Gm-Message-State: AOJu0YwzEHMG6svunVT+ltbF1HEYD36SAm5Vc8njw9dDtwnGDglmoEzs
	sxOWtUe+UBWk4xjGB/atcs0TC+aZRS3LHb8M3S+XVIplQPFY2sPWXdlhC+ICyw==
X-Gm-Gg: AfdE7ckvW1NNpcYFkUlbduy2aoTXK35b+im0msD9X04e0medtIyAOjIYUFYFtyMXamS
	4J2uJ8fOXWBmwVRADG9BVzBqEI2A8mCkCgaIgJ+UBtlSYh1SakgnGzc1lDh8U6AcFJibg15pXi1
	lJhMarp+SQtXvLp4u9Nkb1btLSzZ3dHwmBhPBp6HzEvovs4BeuFPbvkUMfNrUURf6Jzty41b4qu
	027epRrTFIpXHZkWxT92LGrpZDirvdjx0DNE7ybziOqqIvn5hpBNJMVDCnLD9boXPmtB9Wj+PoS
	LSGJisuaCwZ8OtgcrycVUrxCKjPJHWFrVwKPiFFTt/9GOvXDx4ZlPCTGg2AFTDx76SN5y+d9vBa
	8leqTowpVMix7C2hKUwnI1UHlcr4E6p1MVFVCa2VEw+d/La1LZmNxEPPppuIR3Drz3KaONvbz+U
	+gDHjeP2RIZWFzwHca
X-Received: by 2002:a05:600c:c172:b0:490:b7e6:bd1d with SMTP id 5b1f17b1804b1-493f87ecb62mr108117615e9.16.1783948663641;
        Mon, 13 Jul 2026 06:17:43 -0700 (PDT)
Received: from berwick ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f4cbc620sm251653145e9.13.2026.07.13.06.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:17:43 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Farid Zakaria <farid.m.zakaria@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 01/10] t3400: restore coverage for note copying with apply backend
Date: Mon, 13 Jul 2026 14:17:18 +0100
Message-ID: <65af2ac07a2bf85336245a7d9b9f0a8a0e8affdb.1783948637.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.54.0.200.gfd8d68259e3
In-Reply-To: <cover.1783948637.git.phillip.wood@dunelm.org.uk>
References: <cover.1782833268.git.phillip.wood@dunelm.org.uk> <cover.1783948637.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Now that the merge backend is the default we have lost coverage for
"git rebase --apply" copying notes. Fix this by replacing "-m" with
"--apply" as the previous test which uses the default backend now
checks the merge backend.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3400-rebase.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index c0c00fbb7b1..f0e7fcf649a 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -270,9 +270,9 @@ test_expect_success 'rebase can copy notes' '
 	test "a note" = "$(git notes show HEAD)"
 '
 
-test_expect_success 'rebase -m can copy notes' '
+test_expect_success 'rebase --apply can copy notes' '
 	git reset --hard n3 &&
-	git rebase -m --onto n1 n2 &&
+	git rebase --apply --onto n1 n2 &&
 	test "a note" = "$(git notes show HEAD)"
 '
 
-- 
2.54.0.200.gfd8d68259e3

