Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCFC25B2FA
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 13:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560576; cv=none; b=obLJVT5Mfqo2dhiLrNhSbt9fPRejf64RWcHmBZyJX8rWj1K97XfAtww7NF3SJxAdvqw1FUBksHRcGaBy+/iy4qvve/jbi8VniloJrnadbmKHzJWVww9JTolh4tYe8AL9Y9V2SzIyY+XfTvxP1B94Ppm1ZNP83sPjG6mvoY/RhCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560576; c=relaxed/simple;
	bh=vyjR55meVPXzXRVwh2v6oEAepI3/SR9uKXYnPnqnDpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ifhKMT9yhVm9FQAtuFP39Oi+aj2FBVsBghLQ3VypQRqzhaE3Effylp7EHwwSK82xBvBE5+ZSfYJpnosFcFHIMFdoZHxCiVadr3mm8Q0qnAhMLTGdc34mQD7suqEsFdannwnh5FttT1K0EQW04smWRaUAQ0rDLRQMtj+Qq+h+TP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTgfhlDp; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTgfhlDp"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-235ea292956so52576145ad.1
        for <git@vger.kernel.org>; Tue, 10 Jun 2025 06:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749560574; x=1750165374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N/IyR8uNt+fEsYl2WgQZALLj0KmgMm6oqo1gz+IKBzg=;
        b=fTgfhlDpc75jy0LYRHvSxdrE15WPGQKrvjwupZkpUt0/TkLTGWvvQOrBmprzcVdztW
         9xbMfNWQfZgc4+eC7q/yyZjYzwwE/ko4SoBGRF6x09XMmclnWxplIFgF0sgnQDVRZcng
         kUEZVnMv2dT0PsZrMkFK78Fscj9NgL6tHlKtIvnzjzmhz3X2ntohuyiDqmPXgElZnFZg
         OPJ2aJcqccehYBqgJVhOIR6c7wnLp57im+zf5FTtHT4fD61bBx8MuUNPTSVhDq8k/cUt
         59fdSvprReY1KXuPMTQiaXI2tclUBmjJQlYegypL0JuJBimchffUU45nh5bpch3e5+k9
         Di/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749560574; x=1750165374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/IyR8uNt+fEsYl2WgQZALLj0KmgMm6oqo1gz+IKBzg=;
        b=quYygZiHyxsTYimIIRmjK4FvbzqqeR62H3JwXk/9KuI6x36MTJLYm1puPUSP/z8FYM
         H6P3UCOrZNKM5zFdeHsO2OiwMSqFW+U1udEW9zjUXgo+qJ3l0ZJ5ivL+dLMbfBxkg0OY
         HaNPRIeQRD7fH7McIGjSt1ZAxwe4pG72A+22whtytk5a32cd9cbwwWvZNPVOKIe8FRpj
         AAhkFzLOINqJ3Ja2kx/1GvGYaHhUavlYp5bDcOkkXPcIEYinYE8QHuvKhX+yrVYB50RQ
         I+ZD9ZgFwEYdBH6SjhC7j4ZxM8MnypQxfHoEgkf1b1wwob9tyshGCEyjdvCBtWGWbRGT
         qlsQ==
X-Gm-Message-State: AOJu0YxMintWQLY38ngfOROYN8ZRADjaZxD9BITBb67aTxUH7D0tzrev
	HAbXcdT1wdNxZOR4Hx5DJ2gkJ9VE9YLdYN4vrj5ivN4Hur3r55tDxKY88w+vhg==
X-Gm-Gg: ASbGncukAatmLDbdhoN51tzxgOEYvyGe0Zj4M4RdO8/DLCZJndKGMTWlmdddfeKiLFH
	LcrUGLjiLMppnzfiWPEmAnktJNHu3Kv/UFNz1XyGzF+2LdgFVGZrOdpNZGerEdTklY6FOCNTt5F
	9iVfRtpjnkxEIcp7PRcrgJs6walTAG/74p0dkVSqOp3BCi20hbr2hhI9eF/0u5Z1w98G0woMYDy
	WQaS+AhSN6th7tPVRpKXFS9FVdXT0vyn/5JOLohQBjH5u6F802vqwTPY8Dinl4QnqszGkuae0WB
	DHiLOAhxwjr2A9yTe7fqr1N1wouNbkA5DeB/zXokju23+tIqQE8ylAqca5MfCznm9CBaueOtRDm
	n6rJpnh8AjMEnYw==
X-Google-Smtp-Source: AGHT+IHsoIAQa7yLMrR2XS/83LrH3naO8QMXjPWGQRe89O2D9TQ3d3vXDOaPGyOqz9tRjOvHuO0Xpw==
X-Received: by 2002:a17:902:ec92:b0:235:f298:cbb3 with SMTP id d9443c01a7336-23601d05c8bmr199214365ad.18.1749560573907;
        Tue, 10 Jun 2025 06:02:53 -0700 (PDT)
Received: from thinku.domain.name ([2401:4900:1c17:909b:153b:8cf8:294b:5a5a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603506d58sm70338175ad.227.2025.06.10.06.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 06:02:53 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	Ayush Chandekar <ayu.chandekar@gmail.com>
Subject: [GSOC PATCH 0/2] preload-index: remove dependency on global variables and 'the_repository'
Date: Tue, 10 Jun 2025 18:32:19 +0530
Message-ID: <cover.1749557133.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The aim of this patch series is to remove the definition '#define USE_THE_REPOSITORY_VARIABLE' 
from "preload-index.c" by removing global variables and the global 'the_repository'.

This patch series contains two patches:

1 - Remove the global variable 'core_preload_index' and localize it in the function which calls it.

2 - Remove the dependency of 'the_repository' in "preload-index.c", allowing the removal of 
the definition.

Removing these global variables is part of my GSoC project.

Ayush Chandekar (2):
  environment: remove the global variable 'core_preload_index'
  preload-index: stop depending on 'the_repository'

 config.c        | 5 -----
 environment.c   | 3 ---
 environment.h   | 1 -
 preload-index.c | 7 +++++--
 4 files changed, 5 insertions(+), 11 deletions(-)

-- 
2.49.0

