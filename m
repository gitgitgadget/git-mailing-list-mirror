Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A28424EAA3
	for <git@vger.kernel.org>; Tue, 20 May 2025 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747753484; cv=none; b=mWYxpr1DMJigXmFL9ocQK33bAn6PK1+RNkuyCagpa27FSPcLFy761mZm2BpvnW94lLFPmPEmf4R9ulrs251IuReHv4aLEETXp83jXKwJDVIAIbJXHIhPSgS2cFxxm93ri+kjXrscrEb+jkvtgEWFlpuefGKonMc1540T9CsZ17g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747753484; c=relaxed/simple;
	bh=cmvgNiBaJh7Xl9jeKiKeDVp7+0Ft+/BWxwVwHJY5Ji0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gRvMUhFNYr5MuKDNNmIHLyE84hvkocPFFHLHII296Kei6Exiuab1JqBh+I8Zp/6nNahu/ROgbaYaqIwyJcEK9KYc9AdV6fPTsBPJSU2zHWbYhF61nnINupz1aP8JKjb2YuOVlyXq7IzNGl/R9nC7TniQzRULrJVIeQItGb5Kijo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADM0lPXa; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADM0lPXa"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf257158fso42697565e9.2
        for <git@vger.kernel.org>; Tue, 20 May 2025 08:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747753480; x=1748358280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IgIObNQ2W9BIdT8D9sXlqK3/Nam71p8fRI3JRLYQ5CE=;
        b=ADM0lPXabHVNlVbJBLKtraMczuWr3f+V7sL6sYMZRfmMn/vrroz9wbfMsJbKBPieBr
         FmjfB00hsC+Q73I8mi6owMzHp1T0yM/uo0eE2k4Tf1p3JQxoVAfVsLDuFYBqK53CIc93
         Qo3aNbTMOv1dqXR9vhnHQJxapmWCz0X4UpjSsH8KhxKAIZk4oRx926GkaR3sJDFpOZ7L
         CjVZCx9jem/Km1DXZaB5uelannq7Vxjq/5GkzUyNDNRL6lk6QJreGJK8+ofMczXVQyZM
         +8FT4abuQgtoEAUPS8QK6aEPPr+8oJKxd+GCOvOJBibwmSEhg/nyO9wvJLyRttb6XR4r
         SSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747753480; x=1748358280;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgIObNQ2W9BIdT8D9sXlqK3/Nam71p8fRI3JRLYQ5CE=;
        b=eABY1qX7JXsipwUgvzU8Mbg9tDxLFc6xh8hq7KzglC0gYZj0g1yr6GGzge3sNu3VRH
         2mQMHlVvcw8Nc4kbUuqs+QPZVJvqj/LFbgheHhuk1Gysh0wp4QtoOhox1BJRnmR3DAJl
         dqpxN8XglxRvbT3c9bFFyp4jjEvyFpju645v2NnS8/e9/xZDlXBatMS4SzTPhXwitpqt
         56eyNm9PZJkJsk7fc9mcaH0KipAxL67y6QhSlAKmQUINDv5hNjLq5igvWGlhB1LZTrW5
         YOpcdRX/O+VygRESx9FhEDayjAB8+fh3pB9WzD+8EaJu/CeqNYuQDFfb7S7groCqqDuR
         ovRg==
X-Gm-Message-State: AOJu0YzLL0VqnSq7gWAXx0UhTJRjCvlncPebWwLsS/0tvD2TJhiQpnsx
	JRO3B4kPMtK8vlopYdCJdwbG8sBjSSu/nGhQwRuv8F3BRNDXgnIoxAq/+8VkhA==
X-Gm-Gg: ASbGncstvrlYIeD6hAHKbgd4hssBQ+dZI+eVl2hsaP58F88N+hWk3+yiIHv3q4a8Ulq
	uiOVsHqw+wmPwvdt+dGUflkCevwNonkZuWd8x2tEhCZc6DrKWZCKO/9klK3Xz8bZ/V2XqENOzon
	KAEt/Nix+IQAIqtHu1AkEUXJohHIOIfl3jXXlM5byzMv1SQ9qpoifwnN6fss8S+nSKa5IpcZj2b
	FULUOqMr56QgZY01Bu0Q2ek1bZmaY1dn2wFEm0wi+vNIglUjxy13Y6+w4yPFE5EHpHrIxJV0a8b
	ZkFv6k00b+rc+btnB00vHFbfQEhzI6TcCdGkPPeXTbVSohKZ7cdn5kkFV8HxCc1y8nhEsPmmhNZ
	L2Q==
X-Google-Smtp-Source: AGHT+IHPH2PinbYhQ00EKIlvs+92Wes3qmH7ffz7x91/DxeHmbkteAhJrnLbruB/OPEg4taNs8LdjA==
X-Received: by 2002:a05:6000:2908:b0:3a3:6c9e:1691 with SMTP id ffacd0b85a97d-3a36c9e17ffmr8012418f8f.53.1747753479808;
        Tue, 20 May 2025 08:04:39 -0700 (PDT)
Received: from berwick.broadband ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d105sm17014029f8f.11.2025.05.20.08.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 08:04:39 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 0/4] midx repack: fix overflow on 32 bit systems
Date: Tue, 20 May 2025 16:04:23 +0100
Message-ID: <cover.1747753388.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This series fixes an overflow when running "git multi-pack-index
repack" on an old raspberry pi and a couple of other small issues I
noticed while reading the code. I'm unsure how realistic the example
of integer overflow on 64 bit systems in patch 2 is. I'm happy to drop
it if people who work with large repositories think its not worth
worrying about.

Base-Commit: cb96e1697ad6e54d11fc920c95f82977f8e438f8
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fmidx-repack-overflow%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/cb96e1697...29769df1c
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/midx-repack-overflow/v1


Phillip Wood (4):
  midx repack: avoid integer overflow on 32 bit systems
  midx repack: avoid potential integer overflow on 64 bit systems
  midx: avoid negative array index
  midx docs: clarify tie breaking

 Documentation/git-multi-pack-index.adoc |  6 ++++--
 git-compat-util.h                       | 16 ++++++++++++++++
 midx-write.c                            | 22 ++++++++++++++++------
 3 files changed, 36 insertions(+), 8 deletions(-)

-- 
2.49.0.897.gfad3eb7d210

