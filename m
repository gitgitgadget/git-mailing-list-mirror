Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D07C204F7D
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 19:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055725; cv=none; b=Cs8XcGZKppqBvpOERdOT4otQyFVSbmzLQnU7c+ZHti1CP02WqNfQC3wdq32+i/J3dEaSoxNpF+HxLaSwJBk5s4A7icu0MVI8fmISeooB7UVHBJrRsKKFzKqcEXl8mHqFv9Wi9cyjpNyEECtOXTCaFQbHgTI/cVQKXqYp3rHFbiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055725; c=relaxed/simple;
	bh=h7OMoJGvJz3L5YyeSq1xgl38ftNM7jMjxGMaPr5VQFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hn7uv+7NiZ/4sF4tU02TKn/7w8su+iZsmWq7vdKEozHDPz4OilL1lAow681c4+/y2HQ1XFdVkV3IWf2Lmm48yD1aEIY8LRK0eamXzoTLVa5eHnVy4hC/7rR8OqKVaTL0vcfSDqIlr4i54W4nuckwK5svPscoUt3EXewY9oj4CFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBWtzCn8; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBWtzCn8"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22403cbb47fso51301455ad.0
        for <git@vger.kernel.org>; Mon, 07 Apr 2025 12:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744055723; x=1744660523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oz6cq2/tNRCn7wLAqDykjW+JxrGF5HGyLKko/E+vS1Q=;
        b=IBWtzCn82WGqYYRalhzdvIlEOeP9PKuwIqfvEZGRJXryE2UDPbaN/Tuz2HvzJIR4AX
         TXNKSj2hv4EP/g0riTSWsPPHc3MLIlKCQIvMg9nDqEQFPFXl1vainfIbGwsxHnWye0jr
         IdH2O7djxDjaFtOD/Sj4taVrpH1hQgowhhW2FCMc+2E73beGRCvGwsXrl8XYAHuftBXn
         0I7sVz0Gcl7xwAUz7Io7+cZzp8WNAN5F0P/SCfy+E9UbcrTskh/aMOuSxad9ZEFNBpVJ
         pmrqQRJuQQhF/9lPrt4SFmL3D5KQqQIoM0KhkEdqqWuVTfeo07j7Yqx4FkRMtOP5qzfT
         lEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744055723; x=1744660523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oz6cq2/tNRCn7wLAqDykjW+JxrGF5HGyLKko/E+vS1Q=;
        b=JJ+l5xyd3uAO4XlksS22dlqor05zvtc/nZWh1ZVJpI4bd/QqOswEuKlTYS/eBAJweB
         DRk8oBCxO2++QB06uR0ct43h2YYlmYAOVXjVFbJuu+pF+KbHQZ7Kr9Xoyx07GByW12lt
         ejVkzV+K5B1a4B6zzsLrHCBEtd8r5QL5aA4olG0t+a3MteAjvI8XO01rZ7N42WFXUyOy
         t1zuOD+dnlUF33ywbRCbZb1BjYy+faoKUBuQfIoBW7tq7eI9VFGzfYKxG+BkM6ITQwj+
         3U7mHKS+BinhzNY7iHUU4NsZ8XjiQOsZLbgVh9Zd5dp2msJfWtm3UliKivPeEpuCiqbW
         IFAQ==
X-Gm-Message-State: AOJu0YydIo1+WfmXqmKOHnbXOSaZZeN++VWzMxpskG3uiozzTx3IysgA
	J6qhs7d1atMM86P8yRcis+fLNKfWhmChiDR5ip6DslqF1RGMtJaCawG85C5l
X-Gm-Gg: ASbGncuV+VZrArRirI+TrRF8tijEUtAqoFajmsIWFrC4uROn77XThPS8Vi84W6U8QKA
	TQAYzUDYF8B2SvOjkk4rfNoBBR/Ki7QdAQ+VdcQeBjvljSsuaDwS4e3SeaabmHbJ1IfmaBTZMtr
	6/had8etxPu3X1RrcrUbDbQlCZeZM34PKbjDiurFdYFYoLa5v+3dN8G0xx+31rwB05+XYZy4qy5
	bh429rJCSwW5Ns2RZDtoYokICnxjDH+3qRP7VSHDGdcaXxxonr7g0gvKqNPSfG4lDLrGIDdS7a/
	vgOrPliISVsJpUTtU1GdPU7R6dEkThVFGkGba674Pdka6dMNXoGL/QXSGNedCb57BAyjecKiVu8
	uluo=
X-Google-Smtp-Source: AGHT+IE8jcb53/Wn2c8TmRlI0FPTx/7cnnxWitc+NkpBGCCsUf0ET+d+Lze3y2kmXSMxl2LCfAYdMw==
X-Received: by 2002:a17:903:3bc8:b0:226:30f6:1639 with SMTP id d9443c01a7336-22a8a8e43f8mr192011505ad.51.1744055722751;
        Mon, 07 Apr 2025 12:55:22 -0700 (PDT)
Received: from localhost.localdomain ([152.57.194.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229787763a6sm85351255ad.241.2025.04.07.12.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 12:55:22 -0700 (PDT)
From: ayushjaiswal12123@gmail.com
To: git@vger.kernel.org
Cc: ayushjaiswal12123@gmail.com
Subject: [PATCH 0/1] t5601: modernize test by using test_path_is_file
Date: Tue,  8 Apr 2025 01:25:03 +0530
Message-ID: <20250407195505.86-1-ayushjaiswal12123@gmail.com>
X-Mailer: git-send-email 2.49.0-rc0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ayush Jaiswal <ayushjaiswal12123@gmail.com>

This patch updates a test in `t5601-clone.sh` to use `test_path_is_file` 
instead of manually comparing file output using `test_cmp`. 

This aligns the test with Git’s modern test practices and improves readability.

The updated test was verified to pass using Git's test suite.


Ayush Jaiswal (1):
  t5601: modernize test by using test_path_is_file

 t/t5601-clone.sh | 948 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 948 insertions(+)
 create mode 100644 t/t5601-clone.sh

-- 
2.49.0-rc0

