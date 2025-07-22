Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295E6289E29
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 08:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753171959; cv=none; b=e4NZinkJkwzLzl18P+48N4+HEid1nEZ5WKbP/0jgYdyycjbFaPM2eyRn7aKR3gT8ikQnS5nACrgqprqw5YUQRUufW9xFZvSfX1hzxuRo4ybLMDGh/fDMIV3p8FK09Zrbcuwe6dktJxWegGL95ZGResG0TBvSD4HPAcCYej4+QKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753171959; c=relaxed/simple;
	bh=Bf5yamtEi4YTT/KbShhzjJDJlzckkbh/ukQljBBfN2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DAn5YbtFYPJSKJFcwgdEco4KEy9xMIid0k8y62ho3FNYRipBewMNSaM2yJzh6yp15WPWITOcij0sRuwgabry9S+crxJyqdxHfaRA1Md3rVC5koxZtmftdATJTBgZHm8NwrC9syM0EhwDuUOv3WcPZ1BCLbwxESbeuZSOlhtK7eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q02GfByM; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q02GfByM"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74b54cead6cso3310261b3a.1
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 01:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753171957; x=1753776757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6ePdGpQ4Bx6Mpm60/XAAnSgaRCEHAo5M2F7tN1MHsxw=;
        b=Q02GfByMtgA2Vs+lF+ceX9ARR8pniMbEyguDKTqITmqnQ0sSmjtQH4p7hexcjiKPy+
         c9nq2kJvuUZOMW0GZ8Z2tMPZQCnR6IIZ6ouViF2+n7GsU+T6wpP42nWEZwS3h5f8sF/k
         Dosly/vfHOG01W3QG/vgZ0CPpIo1IqjfjN7XRl5kF/++nuhFnIlRCEpH2bWq1b76Qjbu
         glEVbY18OI6S5+X1g61sY15NjH/G4ngVPmtcyMgNduXBRKRIwnrPzdVTy2LjoFDRCypm
         LZ6WgI2FjU0FtoLButhhXD+Yej+DeUB9Iuz38w99njVjJo/SoEHnWXEZpK0p153gmtQu
         1etA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753171957; x=1753776757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ePdGpQ4Bx6Mpm60/XAAnSgaRCEHAo5M2F7tN1MHsxw=;
        b=Cyt1rzOo7xobs+TKI+kWGT5NEWslBKruSUIeMKmjyeNZ/YDM1mPuDTWyPLcU5hknQp
         vWASqXDs3qQrpWyQerG8vciPlAYtumiO999Yhs+W82xvjw/b/GD0Elc7CzWabv45Zxh8
         /D5dnMmvc4NJ8VjFYn8swyHZXiWuBU16ja0FWLjZBAbnDuUo4YesFjb/jlGgBhEAYaEt
         4wh0ZKTDEyBo7S0oklxWVTPKsESmqUNCTzOqj4c2vnKI8QqHlBNg4QHdSKyuzbqDromP
         3g9oOOdMs0wQrpntm2Ps5+QoDOwyJFyIoj6dJh2fvRLVgJVuGb0woBRaCOKP8HXSH4cg
         heuw==
X-Gm-Message-State: AOJu0Yy7Ew+bSu76KaAnRPQD9xOkYeCBC2x4S/T9R7QEETBaY4TEaImj
	sIpNjc9a+o7fhII6PsuM4ChV276HyosX5IiA5LeJBNfGvdV7QLqaCblKpSffV5Qr
X-Gm-Gg: ASbGncu0Nqh+LjI1njPWkIy65hORCDFY5+RQZ07ykgn0+QrqqLgUSr9GG/gU2oXgB14
	J/DIAjq6cpcPNs4chHxEiwJ9LYE7hKvFT2dbZgonScQQX1AtgZrxxT+P2Xff2dpfNqGyjWyOt7m
	s6/Uf+43ysMGacnLT8VE05TIauv2pU8Lbs/U7t2swo8E/E8xqfUGVA7IA0H/JJzTRitauBG6BBZ
	cmJFZc4l2yyVDgZ5CidGNxuTkM/JIkqsf42EXnELibYNAhGN7/UiuvwwW+xQY20gLC2rqTMg+qe
	bvQENrCIcpm7XtEQ1oI0iUGRM0/uk3JU46f5W5J4r4qtVADMXXH9UaJYxHdoaMia7eg2l7TvX3l
	TkwmAkzq5rgDV+tUmVBHQf0H4UPfHv040bg==
X-Google-Smtp-Source: AGHT+IHXoBg40eQLKMXztbO3cePPwkTkKgG0uDW8z+IERskO2fyFx00rFXc9dTu82axP4vecmPZPvw==
X-Received: by 2002:a17:90b:1652:b0:313:15fe:4c13 with SMTP id 98e67ed59e1d1-31c9f44782bmr32834717a91.27.1753171957072;
        Tue, 22 Jul 2025 01:12:37 -0700 (PDT)
Received: from localhost.localdomain ([211.37.148.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1b8f89sm11584538a91.9.2025.07.22.01.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 01:12:36 -0700 (PDT)
From: Hoyoung Lee <lhywkd22@gmail.com>
To: git@vger.kernel.org
Cc: Hoyoung Lee <lhywkd22@gmail.com>
Subject: [PATCH 0/4] Fix resource leaks in various helpers and builtin commands
Date: Tue, 22 Jul 2025 08:12:15 +0000
Message-Id: <20250722081219.1086866-1-lhywkd22@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes several cases where file descriptors were not
properly closed on error paths. The changes affect helper programs and
a builtin command, and ensure that system resources are correctly
released before returning from the function.

Each fix is minimal and follows the existing style of the surrounding
code. These changes help improve the robustness of the code by avoiding
potential file descriptor leaks.

Hoyoung Lee (4):
  t/helper/test-truncate: close file descriptor after truncation
  builtin/archive: close file descriptor on dup2() failure
  t/helper/test-delta: close fd if fstat() fails after open()
  t/helper/test-delta: close fd if fstat() fails after second open()

 builtin/archive.c        | 4 +++-
 t/helper/test-delta.c    | 3 +++
 t/helper/test-truncate.c | 3 +++
 3 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.34.1

