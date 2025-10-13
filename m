Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A751E5B95
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 11:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760356685; cv=none; b=l7kD8MaMjUJRM/0Kyn9KCqsg0rEAMiO7VGe21Y39eeXAoJNFVepeVdbDjAEMCqKyQz0R+bZw6Grn+MaZaE6aEpiZB1+/r1/VIS8E8BC9Dz/tYV3Eyy9Cn1pUg8CG72YsTzrUYrb/Bo7dGYZMBnTiv/zqfhIyIvNAP6o7jB6KwHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760356685; c=relaxed/simple;
	bh=ldB47h19ze7zUzRD1dbESTNwka+mcJyqk5hhhg5XIag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g0xzsVLeL/5i3q9QWDpQmW0JHdsUga9og0pA6j+UtLlWqmemUjEbRVa+uz6VJlMo/L4Sth1X5R76X7737O7S8Yjzje3nqpF7WvYfFd36wa3wLmXU6KLSwqHh/ihTi0Z/pEeL2kjJahwEHRAwLjhCzDkVnv0JSYXc+MXzDtfCamU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yen31ESd; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yen31ESd"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-279e2554c8fso40233095ad.2
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 04:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760356683; x=1760961483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9wJYMbK+eHkc95g1hKVbtW3Lp10AoxsKbcLZFyh00gY=;
        b=Yen31ESdrxgJIMLpivZfHnEOQBkii3odcEIdpZ28bYSGXhQLAET10zaR+oHQ5ZJ15B
         lrvoQGqeh0O7glArDArM2a4XfKItmNyxcTqYPYYPe1pqROhPJ8eAbIcpiYsdKa0uLKFj
         dp9ixiwSguOs5kJab4aiR3f4aUN0V06J0HVm9EVb+5LKQUsHHWXFXcHFe3cXD8NJ/KQy
         Qq2y8xRbmo9kPaQZBOcnPKZ9V34pe2mk8TbolxwS38VlPa9bWJVLoR8MN/QgeF1yexDR
         9c9lqkUGrEq/Zj1OjVtxk4Hj42NRfPD+P5DPhHCXpz+GXG6pJNndZEWUexLGoKgcwWvY
         Sg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760356683; x=1760961483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9wJYMbK+eHkc95g1hKVbtW3Lp10AoxsKbcLZFyh00gY=;
        b=vtPyRx8TeD8yFDJ41Zx2yWxZqCac/3GU1JclxIDjOqSpU6v8sYYBoAbGuprSm2oznk
         vgci/sxvfVEJf2numyuex+J5HfjYVvIvABSu1QKZI5mbzR1pbTGee5fQGBOxCrqAP3PC
         snujRhu6ZuSsPokoEkJajaW8tGnS7XZbyrHidsjduNBdYnfSEBzJ4dHaWGlhbBTRBTG+
         Q2CFrlPL+zo31HNJiKl3r7/KEmH9Pw8q+LeT2cqHaKa87CiSePpYI44D/4OBoQAzTgCC
         iRNWmMRHBDwJh2hH1MoVlZYc0U/R9WxhVxChxatF5Wxsk8Yom4jyriMFNQnc8/N3o+41
         rQXQ==
X-Gm-Message-State: AOJu0YyzHx54YUfBa9Iqu6GTe9nHSLp0ydJD9M0Bftxi2kWNx3eNzXqi
	JN2B1BWvIV6tcPjVNjpeu///sK9J5gAcM8mpQvF7tNqQb7Wb8XOtWwjDUqoWhufp
X-Gm-Gg: ASbGncuLIDKDFOKKqccRldR8hWlppDQVgnjnypFkqcxQ6InjI27i/x05hb7Z6qfJCK9
	vJ6O8xKeEaLYBXd8oooq5VU7D0KuffV3wEX4BUBXP0d+/muV/XackoGYKpIN4gZEVx4B+XYki+U
	YvpRqx9754y4XORwbTq3ePAMmSIGyi5P7/ZCsPVohRykYc0dLESQKHku8O8pO4sIeD0RE/nFE/W
	JbV1Zr3MfYvx3DSrNBYfRiB8VOmHKzsJAu3rV0GP4+3rZC6uYrmZN7tzlFYnKveiwZOnYVeHjXl
	ohOGPs4t1UHlZvArg2zRvTNCwzcABt39wafdXwjAQ6VObC03wBtoj5mBENSbypkBU/ZcBfLNrwk
	FJfAoC+4G+oZzoc7STRMj79VokU+xltgeZOwHZ2LeyQU=
X-Google-Smtp-Source: AGHT+IGZ9HfwiVuuoZScJh0xABHS5SndfidnLINhgnC+T1v3P6DOpP/O9r0dmlUwwGe5UPtyORm4Lg==
X-Received: by 2002:a17:902:fc4c:b0:28e:7841:d437 with SMTP id d9443c01a7336-290272c0474mr292108935ad.38.1760356683338;
        Mon, 13 Oct 2025 04:58:03 -0700 (PDT)
Received: from localhost.localdomain ([122.164.83.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f8f9bbsm131787315ad.121.2025.10.13.04.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 04:58:02 -0700 (PDT)
From: Yukesh0409 <asyukesh@gmail.com>
X-Google-Original-From: Yukesh0409 <Yukesh0409>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] The seventeenth batch
Date: Mon, 13 Oct 2025 17:27:36 +0530
Message-ID: <20251013115736.1793-1-user@Batcomputer>
X-Mailer: git-send-email 2.41.0.windows.3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/RelNotes/2.52.0.adoc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/RelNotes/2.52.0.adoc b/Documentation/RelNotes/2.52.0.adoc
index 7fb1a3ce18..d7ed65f627 100644
--- a/Documentation/RelNotes/2.52.0.adoc
+++ b/Documentation/RelNotes/2.52.0.adoc
@@ -325,3 +325,4 @@ including security updates, are included in this release.
    (merge a66fc22bf9 rs/get-oid-with-flags-cleanup later to maint).
    (merge e1d062e8ba ps/odb-clean-stale-wrappers later to maint).
    (merge fdd21ba116 mh/doc-credential-url-prefix later to maint).
+   (merge 1c573a3451 en/doc-merge-tree-describe-merge-base later to maint).
-- 
2.41.0.windows.3

