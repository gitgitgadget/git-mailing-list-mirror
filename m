Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C22647
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 09:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736241597; cv=none; b=Lg0feaNvFhSNOtggMiJ4XEOAVdS6KtFvtvoRTO8J1uwst9shGxbeD6LCW94dixWeGZ3t83SZzOeiSlOtRjU/O0IyKurwe9oGxBJMgahw+ri3nExaqcgRGxj4eBX6la5PU2gRr5nY6P05rmLowjMOhETOZ51x16vZG92PcouEagk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736241597; c=relaxed/simple;
	bh=qNNt/QljJcXdWXNBPTFQHeE0a++iiUD3AVO9x/NdcqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O3ZAOQjHS9BKVY6tm3U39HAkMqnKBYOEXr6tCAp8ZWJ0HS+TwSYrrE//voMuT1LRX+gZUsawu3pQXUNZcAYdJ+s/wOVU6aP3Lkk52eKZmN6zMM5STVKqVpDxwSF2ZiLz7KxW92iuDe5Mes1j2i2807whVuqZOdVk7kpoMwbkcdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qt0iTE+n; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qt0iTE+n"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaf57c2e0beso1217277466b.3
        for <git@vger.kernel.org>; Tue, 07 Jan 2025 01:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736241582; x=1736846382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V+pqTVSqL1EOkB/jiXMiqxikEQJff6Qw79fjXUbEyC4=;
        b=Qt0iTE+njS1hFhdcqZv5n1OLmJrJ0s3TK2kl7Ri50uFsXJWJ8boLoCiL5vImrACZis
         9OPdC1garaK+pI4mbUraITi3LMkCDtdI2IVQJq7Eb6z0g7nbwWpJfMXP8vXxPVuPKXyR
         qFBXxhmGlmE3B7d85evQhrQXs2CNMSiBDPWm97gfVrt/CUSBX/M2UONDJDGANzmbeOHG
         zDM5i/QSbdI/I7R+2X+NKJMBcKd+DfNImD126U9YMPvoJLc8B8wZ9ld2FMl6bkL5Wro0
         RtoJXLDRi0MWhuL80UsEE/RoLLMoHy04DDxCu2qvs41QDWRNzREg0HiWRf6UVAkZZ20F
         Jaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736241582; x=1736846382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+pqTVSqL1EOkB/jiXMiqxikEQJff6Qw79fjXUbEyC4=;
        b=XQr0xLHAcsLEYMu09D6a0/D+FLPe/+cbYiCKuH+hiPJQ35H+YmLP+1aeib3RgyWJ5X
         NW72BibgN/Yed4E628E6R4OSODgPUTVLMEDcSwms8EhxHbY1YRrS1gXSGrxlGfTINST/
         0JPHAm6LyNVvb57QpnAXPoYcwQwHd3FVMe3EnOI56gV8NBkwFCfdttunzWwDo8fvoqGD
         lv4kECwW6lDHUff7JebPoe8ndSyrD66hzL0Yx+q5zrfk6koj/N7vstTQqyKX3jkbPcv/
         01Hd576m2n/Zn8CSTvl/nOvjI1opxqmLGDfE1iFeJuOdr3z0hYRZMlMGRXT7r8Zl/rUo
         anoQ==
X-Gm-Message-State: AOJu0YxyPl2VbL9RFdWp2PpV2PDP4ASdM6unFZ/mYhl7x51DDsWJR+WV
	o3kWhtA2Z0Z4ImJ0R4W7v3kkWiiNQd7KAT2rwGsvhk739CYgtnB3wsINK5aQA7S2LQ==
X-Gm-Gg: ASbGncswprlHKgzjzPByYo2XjzA6TjikVrZ71w04jYRgRSk/6Hc9To8KL2PjYMjR2Eg
	i8K6Ub1jT4VBBqhBXOJwlp8AT+n3+wfpPWO6+GDaOcboHBoxIKip3xvWUDZZxBWj0SSOHXBoYbn
	moyMtzaRtdhViYzEUH5cKW5c5wFwHzkGurL2eO3Qlh3KJN+AIWXykFP7k883vRRpDVqk1Xi7PX4
	Lf9tDHKnHWG3zMrFwT3jjT3EbAstl55VwNUKWJRqafFQsI/6dBTw6V9GhAjWC6hbBBpipA=
X-Google-Smtp-Source: AGHT+IHVGd3qIBxov375hh8oMKav+BPfIvQQfp6w6/sI/vgvpyYipxR7IPhYYLeBnV90Vp0lXSKvhA==
X-Received: by 2002:a17:907:980d:b0:aac:439:fc0 with SMTP id a640c23a62f3a-aac33e42730mr6182024666b.51.1736241580398;
        Tue, 07 Jan 2025 01:19:40 -0800 (PST)
Received: from localhost.localdomain ([154.118.62.160])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0f06deb8sm2337222566b.190.2025.01.07.01.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 01:19:39 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH 0/2] t/unit-tests: convert hash tests to use clar
Date: Tue,  7 Jan 2025 10:19:30 +0100
Message-ID: <20250107091932.126673-1-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This small patch series transitions the existing unit test file t-hash.c
to the Clar testing framework. This change is part of our ongoing effort
to standardize our testing approach and enhance maintainability.

Thanks
Seyi

Mentored-by: Patrick Steinhardt ps@pks.im
Signed-off-by: Seyi Kuforiji kuforiji98@gmail.com

Seyi Kuforiji (2):
  t/unit-tests: match functions signature with trailing code
  t/unit-tests: convert hash to use clar test framework

 Makefile                            |  2 +-
 t/meson.build                       |  2 +-
 t/unit-tests/generate-clar-decls.sh |  2 +-
 t/unit-tests/t-hash.c               | 84 ----------------------------
 t/unit-tests/u-hash.c               | 85 +++++++++++++++++++++++++++++
 5 files changed, 88 insertions(+), 87 deletions(-)
 delete mode 100644 t/unit-tests/t-hash.c
 create mode 100644 t/unit-tests/u-hash.c

-- 
2.34.1

