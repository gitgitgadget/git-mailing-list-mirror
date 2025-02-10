Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC48D12A177
	for <git@vger.kernel.org>; Mon, 10 Feb 2025 07:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739173618; cv=none; b=KNsZ/qeMsaDyaFNGq7IfU5sZay5X2peuG+7/7oRTl724m2+Y90mxhAXx6nIQpOeVGumatNWQWMH+67SN3210uU0RDb1/sbU2Y0ZsooCmjgS2aFQQlStY+7ASjw3McXbewjdLZ3vPZpuO0ZDs0lp0nUIQnh6o68Qh7ON6lRYvWVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739173618; c=relaxed/simple;
	bh=2gLwA+ufTVtgDzQtGj85P1iCkRFTkiGpSeuYi/1YeHk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=prP7mZUOlF2gknhP58t63d7xol4FWlG1xJBqsqh8sPwGmCoLFs9xRa3DcS8ZViaL+kl6w7Aeytf9vTk53nO8ad7t+MkiYg974UbBb7KR074GMopCWv6/nFRcZqdQoWHotzwWtR2kTTqMiESTwTHIJrjAma4Ozu+YZeQXhcAGEnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GavaaBFB; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GavaaBFB"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fa0f222530so7433509a91.0
        for <git@vger.kernel.org>; Sun, 09 Feb 2025 23:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739173616; x=1739778416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Crs5uGC2AO+xQQ8lIBWM8i2bAG9d15zFsr8lqeAUQyU=;
        b=GavaaBFBGDmTFmZ8Ia4ue0HSOoTpr0bzL/Fx6NVCsqkSLonFeeMQTzi/6yvVJf5XfK
         VaLqmPZzbs1Njv6gdXKcQ2pAFOwOeymwnQaBOywf+HJgmo0bYyYJANU4f1e1XiIKWAaE
         sSjT7o6NKWoa2VKoAOw7pHLYAObK+t8ufwxEro1I5A6gF3MJN0PZrxHxe5nVPdPXes3A
         FmvRRxnquKV1d0+UnwH3jFWozawaVEgk8ga/kX0toYtL0H2MOJnNx2f3k7rHKp5dtpH/
         1Uv01EOPxfqDNjHDreAZYK00aJq9bTdmY3Be/2HBBwdqZE/6kjAkU5zY/k1B2T78s5vZ
         prYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739173616; x=1739778416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Crs5uGC2AO+xQQ8lIBWM8i2bAG9d15zFsr8lqeAUQyU=;
        b=OvvUzMjXHc5+7fiekI3ky/n+yP36mQnlKwAovXjzmRRC9rDjdcvOZeYEIqbONHglF3
         85dloGouLurCpN5K+INjGKspA+ddQg7jsBDXXKRvMC1qfBC+MKLAURbzSbiCAlEVYdCq
         vVDYjo1apcB+eozLrJn9xXPxnbzP45crdoJT4wcj84IEPI2mBqSf5ZKhmc2tPxn2Drtv
         xiNs8lxzlxu0UQ6tMTGLc4zp4GTF5I56/plobpKSMkg1fG07Vyk+gzJwV6QmD9nFeKxz
         V1dcyO6C68LIAX0Leiw30ZzSHWCP+anmcw5Vg7JdPN8irOKA2hDj99wcAx7FUZw57+FH
         uFeg==
X-Gm-Message-State: AOJu0YyFDRsRjbR/uZqpSjofNE91eukexjxr8iX467ckoaamKDbfEPzd
	wO5FeEAYlZvKv7xdOt9rNkvEMetEEgAdzmxz7oEQj7T3zZkDkNc1rkjFnkACnfs=
X-Gm-Gg: ASbGncvQ2Y7yDW4gf7pKcd2BUL6VIOosVF9ZpHPhq1oNMYGHVTM83JHrgIAtvAbHPul
	+zdL1jWMFHBBALmEUTz2eHyN2+InfRrn13ELpXPro2rQ42y79cn2bBWiPsAVmDD75Qo1iZ6k7Z0
	2XUKJIk0e6SUxyIlpbrNj6EOWL42GNfPilx4eFsaKxfu7fhvo1S6jGTMInPMCWEv2rqoV0918R2
	U2kH2wEP3gA3fn81ObG4YQDeWMTQYd+p4mNZIZbaWnxhCDE9s7ANlweWFg+m+w63ld37hvreMdl
	ID20q+meELdna5LLHerGynOZtz6oTuLA
X-Google-Smtp-Source: AGHT+IEW2DVgvHVqwB6/nz6HtVvYz9yIORIsRkod8h649bgSWeRXAu4MyOb2MHJHN+3Y3a4GfPi0Ww==
X-Received: by 2002:a17:90b:4cd1:b0:2fa:b84:b304 with SMTP id 98e67ed59e1d1-2fa243db921mr16896491a91.22.1739173615661;
        Sun, 09 Feb 2025 23:46:55 -0800 (PST)
Received: from bl4ze-rig.iitr.ac.in ([103.37.201.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f9e1e239eesm10187721a91.30.2025.02.09.23.46.54
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 23:46:55 -0800 (PST)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: git@vger.kernel.org
Subject: [GSOC][RFC PATCH 0/2] midx: implement progress reporting for QSORT operation
Date: Mon, 10 Feb 2025 13:16:21 +0530
Message-ID: <20250210074623.136599-1-ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.48.GIT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
This small patch series adds progress reporting during the QSORT operation in
multi-pack-index verification. This was a TODO in the code which I decided to pickup
because I found it interesting.

Feedback is appreciated!

Thanks,
Ayush

Ayush Chandekar (2):
  midx: show progress during QSORT operation
  t5319: add test for MIDX QSORT progress reporting

 midx.c                      | 43 +++++++++++++++++++++++++------------
 t/t5319-multi-pack-index.sh | 14 ++++++++++++
 2 files changed, 43 insertions(+), 14 deletions(-)

-- 
2.48.GIT

