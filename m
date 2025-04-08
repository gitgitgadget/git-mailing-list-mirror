Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A965225F78A
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 08:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744099704; cv=none; b=LIvdLJGDSRqH/b1U1Gr4xtoJkeFMQ0Vh77JiNpM8RL2cW1iyZTkZTqNrMAiAQe5VFQLMFvZW4QjUCa3Hv1+E5dPyIsJZCnq81crQjnDWJSDG1bpCfgBR0FOhkkW/Pfyrn3aTU4qqbOi//6QiDwzI29ovTGEbojy+oa8kfTIWaPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744099704; c=relaxed/simple;
	bh=EFGWMfz0tTfY6erNEtbvNKvvdDWFKTJlOQKUWoODlag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CGgrtvKfLpXXAJUl16PRWG8V+dbKAhvlDQF9vQG2uoZ2Jew7DThYp8KlwcLYg+QETRaI6hWoRwZ9tGH5Y3t/O//7f5wVzsB6DP+5IPBGSZGj0J8F/X+92OW4Ceklh+jh7JHkchwIsFzCDF+HMB2W6WXnfntYKAcwIX7BYpu9Tnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8DlhCfD; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8DlhCfD"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso10396890a12.3
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 01:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744099701; x=1744704501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pwz8QSmJ1cW80om7g8PjPCu0zZ2mzmNL/Rw91zBzfNA=;
        b=B8DlhCfD7OAu0BVinXq/QkTBaA0aKHxA8SHBn7EqYHWI36m6kEqEGd+qIhQbUSQV6o
         GPoaz1wJgAHMRYvEh5ejuDR6St6SW9YkObv9pf25o8fn2XIOUn5h3cNs7XpZyHjaOOBK
         8oFEUckRMsZj1cJ+g5uFb5lGhbDcGSi/2kBO1MJrCuEJhTaW5O1HbXTAQvQ9A9EJg1c5
         IXw1hWwLtdXCrC3cilo+XsZEqC680Y76nhStrHAqY4o9+/CA96jhd6qF/0My+E9rw8xy
         LkQme37KnjMbCMcbgpmXrh/CjMJJa74YDJVxgS2tU/P+R+nxaiHzScmtpB49wfx1gTXn
         bA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744099701; x=1744704501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pwz8QSmJ1cW80om7g8PjPCu0zZ2mzmNL/Rw91zBzfNA=;
        b=XfQ4MqjnMyYrqMBCPia5nNHjx11AoMcFRSVrshIGSJhReQcelHgvSFpJZeILkt9XMQ
         0g/p5ZWmxwRzBfHiuIj6Uqxpx17tIB0bFUEH5N7obXxq14w7NWsDSwWb55RsRWqTNshZ
         PUcmia/pqCHyBTO6pK5+n/e0ShjEWJioMNFUhgs0RAEfBpMkH91Hp1u18s5Dy6cqEdjp
         erJGlmIvMB+j5oRe9uVbjuxECUFWKv9a5EhAJ7e5sGSTEAGUdx6wj/VkE04kXKSelw3L
         RswHRYqWhNErPOzKipmbofWb/PdFOXi5ypGCHRSK2i5xYM/XAFtjNzlsHpILYKMZO59S
         XkSQ==
X-Gm-Message-State: AOJu0YwZFf1IO4aFF8+NsVyKI+PGJrY/aU/mzmmHevXXViLq00tHQQNe
	BHPX0eJMYDMCRjMRIEPRfOezCinWJ+kHSTO2M0thKoa1ZtiUx8IIrdVJqRqB5g==
X-Gm-Gg: ASbGncvw4H9GKZ9JeVThoK862z36TByNVFsJYDPa9K5IngoYHrvS+lG3GxCE4IdUkVD
	AjXbsaF4Yh2O3nedqded7XTT+ey+QjcQE8mq1DwhjpKKiBZ40yJJHLBm4FmKsKOlLaJRx41R7G5
	0r5J90GDizgnkJOP2nqQaLRTfxDSpyVTlOHucBg1MYbjxLus5K0mK2KiTohEzXKYvTKNOtAmajX
	xJ/xTa/8e4r90e3wP1qbSEjlrjWyGhfth0Cjksraw/s2vdrcGfSi+K0GKTRAiAhpJ09qZe51lHD
	G53LCcDGdINB+FNPnDDWG9hJE86w6Ix1KdN6YhtLismFicdnTCWf3xVe+Rq77h8WWwd+yHP1HPy
	JPohRByl8xfTRN6KSB72q94370LEJjvICCPfn2eE4bleLZmANBQ==
X-Google-Smtp-Source: AGHT+IGzPd536ZE0aAVo6ppLxM8hDu4F0zyd4ODJKzoHF4LJwd6ZhvQexrz4rrk6J/dMqIAQxJ+1vQ==
X-Received: by 2002:a17:907:9409:b0:ac3:b44b:de24 with SMTP id a640c23a62f3a-ac7e7120335mr1105343166b.2.1744099700374;
        Tue, 08 Apr 2025 01:08:20 -0700 (PDT)
Received: from localhost.localdomain (host-95-230-249-134.business.telecomitalia.it. [95.230.249.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c013fd1dsm880882366b.95.2025.04.08.01.08.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 08 Apr 2025 01:08:19 -0700 (PDT)
From: Anthony Wang <anthonywang513@gmail.com>
X-Google-Original-From: Anthony Wang <anthonywang03@icloud.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	shejialuo@gmail.com,
	christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	sunshine@sunshineco.com,
	gitster@pobox.com,
	Anthony Wang <anthonywang03@icloud.com>
Subject: [GSoC] [PATCH v4 0/1] t9811: Improve test coverage and clarity
Date: Tue,  8 Apr 2025 10:08:01 +0200
Message-Id: <20250408080802.56341-1-anthonywang03@icloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250405103718.25160-1-anthonywang03@icloud.com>
References: <20250405103718.25160-1-anthonywang03@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to expose more testing outputs, we remove the piping of `git tag` 
outputs in order to expose the exit codes. In addition, we change the 
usage of `grep` to `git show-ref --verify` to check for the existence of
expected tags in a cleaner manner, preventing false positives. We also
check to make sure TAG_F1_ONLY does not exist, as it is not expected to be 
created in this test.

--------------
changes in v4:
- changed `grep` to `git show-ref --verify` to check for the existence of 
  tags, and added a test_must_fail check for the unexpected tag.
- consolidated the three commits into one, as the changes were not 
  significant enough to warrant three separate commits.
- added a new commit message to clarify the changes made.

changes in v3:
- patch #1 and #2 were missing my sign-off, which has now been added.
- patch #2 referenced a line number, which was not informative. A new 
  discription has been added referencing the context of the code.

changes in v2:
- patch #2 and #3 have been added to reduce confusion caused by the 
  implications of `grep` followed by `grep -q`, and increase debug 
  output.


 t/t9811-git-p4-label-import.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.39.5 (Apple Git-154)

