Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FD731960D
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 12:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771418810; cv=none; b=iuFyIzgpjqsvHSbHkdyOqp8KkSo8pwlvRluUQfyitOGm6jxtqMWOn+oMZAGqE9nwvytd7n1KS4ZyRsr1o/P+2EGcFJYCV7fAbN6dX3QSnnYmj98iCSoogcb4px+UhRLmeXMn2xQ6d/Gl7AGDg5ytGeeLrgq1DmFXExEY+Mm5bbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771418810; c=relaxed/simple;
	bh=i8GidXIzTz83HqZGBfT9DARJutyaRtKGGncBJ7QRvq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OyV836JgeR7DNf30tzGeUaOpjpXrIof5fiQms800ipCJzTfMi7qNkVP+XjtWRBxg2Q86z7Pehp1tdn2VW7BBMYQaMnq8WCF4EWUke/ItYX9TJi9bGNYJUo0LHfIarPZYun5y9yv6TIYV6huTmeT8jEFMI4HL2GsZn17UdHqv4WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuuiAjHz; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuuiAjHz"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-824bcb2011bso183339b3a.3
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 04:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771418808; x=1772023608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bEiH78K6WPoYFPdXvLLdeOX6l7SPFpR99o69e7rrQlU=;
        b=TuuiAjHzCEnbLBvjELKYBXLoa66Sn4kb4BQ1jUg6vTo8tadepWTLa+j/xzYP4bfvpw
         UfpjYVBwuGzG0rN1J0ryF0b0v4YzTfrzl31bGTpnEtqT8zA9UVKUhUU7MF4izrAesWI9
         o2CO7AqtVSlqD4e0Tx1G/5KsyMF/zCYFs7lugdHMXUsstMMxkOBcN6SrhLVZRS++9BM1
         hd3N4OPVqLGmyyybe2w3Y26kYx4T7oD61G7fVDpcuM4mm1WAdeP6nNdFni/aJ52dIksX
         0G0hJ5WFXoCBm9uwmQLF+m/jo389+941LT4TePGgkHLN1MskQ6u7vorgnJBBs3aiX3O4
         4ccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771418808; x=1772023608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEiH78K6WPoYFPdXvLLdeOX6l7SPFpR99o69e7rrQlU=;
        b=Mnlc46Z3GjYlArNol3yHCkWfHkEbENe541yUzzO6T4IGL1dGmvToj0UPookcAYzRLA
         EUXjDWwkD4WB2FomPZni0XinOmXuiXLy5gTtCa0RUMffFQSb8nmYSWVRj3h19wjcWby+
         q7TN2GvAHJ90TJaUXcFp8y7tpKJunMs3YuqkvD04XQiKXZWe5TwFWjmJlwaoxekEDMfM
         SwYE2n1B+tUCzF7mQeuQwhieNA699AxIRd3EMJpudui/lS7EH0foGVu3LGh5SXFqI5G1
         V67TUFt4NHZmaB1fS9f/Zj+eVffj0PaJr4cSMYxqBXy+siAbDC4TFI1nN4TRgw/xAYdE
         TtOQ==
X-Gm-Message-State: AOJu0YxbzfIWFcwG9RkiKNrIl6cHqPNyNuKMpRiMVItY+ZJEpYR1exQj
	c5VX+ujZ7ihWdUQriJPHI+Bn6tNFdmAFx34JCMe0SZEOjUNYmYOQyYnE
X-Gm-Gg: AZuq6aI14v/VwZPWk3P8fAXt8PNO7NRwGMiSn6COPN+Tgo/DjqLWjbeD0dpm5DmS5Or
	Nl2NLtIWnVaxVu1FjZBt9Ovw7nDCQXqhnnjgMH5RXzFevz3+5IcJRtTvlRDRFO+ztqEGarolF5c
	eadSjjtfpL8z3PltkI3G7nB+NCET1LZfXke1M3nVy3YuTF+6jhqEA6zdJ4Gwn29wZZEO6NuzJpN
	p/+Fs/2pCy3lghe/JB+EbQkEk8ibIrKUtqL9S03Z3OhsA73709e8nU6MTCsu3pUuPYmBA9UI39x
	I7LcZxJc20ki/FMNr9mu3XBWEcMfmOjzZJzv4YpMKWaQYHY199N+aJADtnLSQmK9SK51SX4CKeA
	DZtTouxLw3Xd6DoaEl8PbhUAgmF8U4hUaUiDpHvN20u8DrOjUSBBwFgaCjSDstdPUgLxRHOgJ7/
	awFdETSYCLQx7LjpJoJnFhp7bczzlGuIUPPc0IEVI=
X-Received: by 2002:a05:6a00:3e05:b0:808:434f:ba80 with SMTP id d2e1a72fcca58-824c60e99demr12990275b3a.3.1771418808166;
        Wed, 18 Feb 2026 04:46:48 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b69ee6sm16639485b3a.32.2026.02.18.04.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 04:46:47 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	karthik.188@gmail.com
Subject: [PATCH v6 0/2] setup: allow cwd/.git to be a symlink to a directory
Date: Wed, 18 Feb 2026 20:46:36 +0800
Message-ID: <20260218124638.176936-1-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Junio, Karthik,

Here is the v6 reroll.

Changes since v5 (and previous discussions):

1. Fixed potential regression in gentle setup:
   In Patch 2/2, I fixed a logic bug where `setup_git_directory_gently()`
   could crash on generic errors (like `INVALID_FORMAT`) when `die_on_error`
   was false.
   The new logic only delegates to the die-handler for:
   - Benign cases we want to ignore (`ENOENT`, `IS_A_DIR`).
   - Security risks we MUST reject (`NOT_A_FILE`).
   - When `die_on_error` is explicitly true.

2. Refinements:
   - Used `break` instead of `return` in `read_gitfile_error_die()` (Patch 1/2).
   - Updated the error message for `NOT_A_FILE` to be more precise.

Thanks for the guidance! 


Tian Yuchen (2):
  setup: distinguish ENOENT from other stat errors
  setup: allow cwd/.git to be a symlink to a directory

 setup.c                       | 38 ++++++++++++------
 setup.h                       |  2 +
 t/meson.build                 |  1 +
 t/t0009-git-dir-validation.sh | 72 +++++++++++++++++++++++++++++++++++
 4 files changed, 101 insertions(+), 12 deletions(-)
 create mode 100755 t/t0009-git-dir-validation.sh

-- 
2.43.0

