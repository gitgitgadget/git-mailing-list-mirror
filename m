Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6018A24A09
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 19:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521161; cv=none; b=VbKuqRGcAgj9xNIFhUddJxeoEULYvCxKpBDGLNLbDUsOamkoPTwHwPMbw8obYRm5o8or907nyJeXn9JyLUKSzujwMqiCdJmLzfh9okr89JxgXiYe6t4fwhxVhHuEEPxEKeL7uZmgUS2RHQCcLqp83vbqTxeKGcQqw9eHkfX0CiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521161; c=relaxed/simple;
	bh=qqeW7FfDVUj0Y3gcEWk/8RFiUXNet/jy8hCdyPo5DHM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:In-Reply-To:References:From:Date:Subject:Fcc:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:To:Cc; b=rG0JZSkSDsmjoA/q8ABuFCczgYJ3N/IalahvdFaeSp2JAyZMLDZxGZppwvbBBhZ0MndND7msasRlWrqzWaTDW/2v/LqeteAFhREmeZ9a0Kyq1xy4/RDsnV04Q0mvXwGM5WFKhPiDne7IevUflLUc8a4wSwfNko/wooMP0LovjIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3gSjz4D; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3gSjz4D"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-337ae00f39dso2749839f8f.2
        for <git@vger.kernel.org>; Wed, 17 Jan 2024 11:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705521158; x=1706125958; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4M4p1N9Ou2dX7NzeOr283F7e11ubLppf5hvcSTlVWY=;
        b=Z3gSjz4DDbTaVp0tZPNSC3Hw9TB5JDWeckzkQ97esUpnS7/D94utOe383g5dbCDt9I
         fjaKd/a1442VuTNXR1qE04z+3yiVGFsqlCjNO0zVW3mPl+JqzO2PoU1rT03qoPO/rabN
         jToljY/95Dz2ecNPmMZrbHpii8NNviIQmAi/jiLUB7JDEv+BR52bHOiG1suKsg+dJZbR
         3WMvH8KLQBs8UFD17ANG6iZOk93UXPaLx3KPQiWCx+M0sBm6KOmGhyzfFhwtFftJN2X0
         2EHDxWTQmJ3SZwyWs3wx9lmjqnfCVgSohc/GY9P+90zO+ulyV0uvI7QDXui1cV/7iG9Z
         r8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705521158; x=1706125958;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4M4p1N9Ou2dX7NzeOr283F7e11ubLppf5hvcSTlVWY=;
        b=icJuU4b/cMQuzNkuYmGo8qAWFwsatnv9pAGFlMqvBb2rEfiZtk5zoJR3hpDMMzN5bJ
         75oEcglE0jA+8xldGDSpN+4ZjdAnOVy5O6jIAOZYEMoIViRRjA//7AcGegSQ1dVBczvn
         ycn3GKQlXZyL6ud6m/yUTwRuRNpFlRLSQlOXwledxn72lng7s43/x4CAQbZMqZt7aDBU
         Jaz2okgcqSKH8XOOyrSPIY3MPPiNB5p4aS0CFaqqESv7VWW4GT3KhHPcGOtpRGNbMBrw
         V/B9MQ7Pw3EYm6FarhmDAn/vhnSpHLmd/RS59iWhr1m6gYjoMu502maoaWUxPNVMnAZV
         2KWQ==
X-Gm-Message-State: AOJu0YzVntjWVycnoo7uw0PrDL/r4pg2vgYK9Osp9hsedEga2R569WpO
	3sll0H4lTtoTu98aJ/uOUKAqNRr64KA=
X-Google-Smtp-Source: AGHT+IFS8gL4ksSdNsKnYym+CQixkUGT4wFViT2Q13E6oQePzeFww1wPpkBSrcfCg21c8Mh9ILQGsA==
X-Received: by 2002:adf:f745:0:b0:337:b636:8e3 with SMTP id z5-20020adff745000000b00337b63608e3mr1735777wrp.47.1705521158138;
        Wed, 17 Jan 2024 11:52:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id dw15-20020a0560000dcf00b00337beb77c86sm2329172wrb.67.2024.01.17.11.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 11:52:37 -0800 (PST)
Message-ID: <624ad202305138c312e9db7d9cc590baf4e576ab.1705521155.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Jan 2024 19:52:25 +0000
Subject: [PATCH 02/12] remove REFFILES prerequisite
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
Cc: John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

These tests are compatible with the reftable backend and thus do not
need the REFFILES prerequisite.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t1405-main-ref-store.sh  | 2 +-
 t/t2017-checkout-orphan.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index e4627cf1b61..62c1eadb190 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -112,7 +112,7 @@ test_expect_success 'delete_reflog(HEAD)' '
 	test_must_fail git reflog exists HEAD
 '
 
-test_expect_success REFFILES 'create-reflog(HEAD)' '
+test_expect_success 'create-reflog(HEAD)' '
 	$RUN create-reflog HEAD &&
 	git reflog exists HEAD
 '
diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
index 947d1587ac8..a5c7358eeab 100755
--- a/t/t2017-checkout-orphan.sh
+++ b/t/t2017-checkout-orphan.sh
@@ -86,7 +86,7 @@ test_expect_success '--orphan makes reflog by default' '
 	git rev-parse --verify delta@{0}
 '
 
-test_expect_success REFFILES '--orphan does not make reflog when core.logAllRefUpdates = false' '
+test_expect_success '--orphan does not make reflog when core.logAllRefUpdates = false' '
 	git checkout main &&
 	git config core.logAllRefUpdates false &&
 	git checkout --orphan epsilon &&
-- 
gitgitgadget

