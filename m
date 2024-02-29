Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847741EB46
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219108; cv=none; b=A8LJOINm3vkqt2433Z8tjMBNVwlUBNRKEUNTN1UfUNJJiGSmFHzZa64Q12RENAP7N72KSWaVPtjpRsfcx+V87RT6gu0BYZVBue524pfwa3msYJqKwxaqIeYJ9KvrjKnN4O4sSwpSOoZqWqPaGOC/bPnEUv4PcXj2kQt+hdmIfA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219108; c=relaxed/simple;
	bh=pGyXkkzr03UaFdh/PhpErBHg9wKRIYZ9I1yM9qHHItE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=md4xuFsV5UrXhfSY5Fk98y3C/8UiRFY8wVEZT3xN6G4W0cP6+XWR9GdVXhR6c21dzk01IgEIaseo4p+v2gHr/f7+TCdc1QOmo5Mvj94Kdd9QzEJEMZJr/OOdmj6g88VGCmXxXk/RjpLaestF1HtCYRaWMFEuWwWO5pmnID6c29c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpdQfk0o; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpdQfk0o"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc5d0162bcso9738785ad.0
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 07:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709219106; x=1709823906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tVLKtJnFDQYZwttuuASipGVqH0xxJRN49O+1nhQroec=;
        b=RpdQfk0oBGAyfFL4IfC5Fy1Kx/4zlDCHcQAg85gaAg5wKpjoEZTsH3nITg2SQJAAqF
         vxZDQw/cU5bwLY+JGTpQjwJjf2/fzw1T5am5XDz0ACzTya7QqMS0iOnDF4fizKZRjyrF
         QNZYfBP3xqPTLAnhxOeG1lYSgW0w5fT+OLfwgIl1/BejiN0AQu5kZYRURedQmnMJb5NU
         dPDC0LibtiIRWLqLH0aVHhzYE30IC4cwLmJgf9aZG80O6guBpXBwQo3XW8YoG3PEk/h6
         EBbmZMWSXDU/s3ysBzWKdfJbwk8hcJ3rjXae99lLP+56iSKRB/TMZSvnb4QDFShh+0kR
         LvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709219106; x=1709823906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tVLKtJnFDQYZwttuuASipGVqH0xxJRN49O+1nhQroec=;
        b=k+stccKdSF4rZNIv14i74jzE66dHFd5of52kjNqPcL6Za7eoGzVfCH1PsLpN/4NfVw
         df0ZELTCRWwiU+/3EyWpJectuYpUNwGMw0PvFZXBYzXsooZ3SBfV5JECZj9R4pYySXCU
         c/k1CMcwebSnJwoSLZ5vxtQWJ/hjJNz0yafFVDrP7Pigt5p9bz+9W5W/NMPV1xFmQcEr
         4FoSjpl30O3Mu6yK+KCwBCEGf5cYqZPaEJPk4500e0hEyCMtJLVDgBfCmejm2hcVfdK/
         IZYX4BDLBHiXOHtFkb+7g8LrK9+nFpObRRaCR3YLntssHwt6fU0C5p13RBbcXFWsJrzZ
         u0mA==
X-Gm-Message-State: AOJu0Yw0AVet5G63h8Yzx2hJlqHxadW46PH9eg0DAHl29O+TEMuN+Co7
	toHhoYI8uuNjxfNtRY+Cl2O1RjezsK76KboYAsVWPcF3tbpbPh4sFAohz34xcq1Sbw==
X-Google-Smtp-Source: AGHT+IH+bLOuYd81TSECPVnsCfTzeYYjdZS3VRdIWe2khjKt7ny1LKv00Hwr3IHHJsOzoSoxuPby3w==
X-Received: by 2002:a17:902:f811:b0:1dc:2f30:e0dc with SMTP id ix17-20020a170902f81100b001dc2f30e0dcmr1924531plb.36.1709219106051;
        Thu, 29 Feb 2024 07:05:06 -0800 (PST)
Received: from ArchLinux.localdomain ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b001db337d53ddsm1603014pln.56.2024.02.29.07.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 07:05:05 -0800 (PST)
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>
Subject: [GSoC][PATCH 0/1] microproject: Use test_path_is_* functions in test scripts
Date: Thu, 29 Feb 2024 23:04:41 +0800
Message-ID: <20240229150442.490649-1-shejialuo@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello everyone,

My name is Jialuo She, mastering in the software engineering. This is my
last semester. And I will graduate this summer and works as a full time
employee. So I wanna make good use of my time by contributing to open
source software, and take this opportunity to continue contributing to
Git after I start working in the future.

My reason for choosing to participate in Git is actually quite simple.
It's because I once wrote a toy version of Git myself.Throught this
project, https://github.com/shejialuo/ugit-cpp. I came to understand
the magic of Git. I also want to do my part and contribute to something
meaningful.

For myself, the most attractive GSoC idea for me is "Implement
consistency checks for refs". I will dive into this idea soon.

At last, Wish everyone good health and happiness every day.

shejialuo (1):
  [GSoC][PATCH] t3070: refactor test -e command

 t/t3070-wildmatch.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)


base-commit: 0f9d4d28b7e6021b7e6db192b7bf47bd3a0d0d1d
-- 
2.44.0

