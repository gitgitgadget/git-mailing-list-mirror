Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE2019644B
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753806014; cv=none; b=DmKo8MJbbMwezIPVK7I2wYzQo96fddUWhY8LrPR9g0JjfKTh9YB4Z1c+jKXlzm9GjDs1Cbkc9ZdBiudmQax4CG71qI9eBporLWiu8Uqtv2kDtbYCfMA3H6wH17SwA3FyDr3N+jAES6JWAr+G14eNU/aU68x2mQaCPCT/1TbbqFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753806014; c=relaxed/simple;
	bh=z2s7IEWC6lWLlMQ7Ttgu336A+w6yNXd20MKCDSn423g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FMlXKgqOcO+up++78aHLw+kz7/Epa1QX8mQlY3HNbBd6JjuwG71J3UQPgmGHWAglRVbV/i8bymuwG0KzgLwY1iqZocsUNdVEJcg1fLiVaXW4TRvxSgASHHVve+AF9ElesotXN3IpaxSuLv3KELT0Xi2R4GddSGHaovZRfyitf3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyLvwTEw; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyLvwTEw"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b3bad2f99f5so43069a12.1
        for <git@vger.kernel.org>; Tue, 29 Jul 2025 09:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753806013; x=1754410813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e1ocBmgZbBARpkSqcCccoaUptB5r0zaNDZZws0Lz0Pc=;
        b=dyLvwTEwtfRxQ+DrVWmwi8V892G1jaULIFPpLod9vWy8xYVXB1pQj769OGNqAPgoSO
         EHKxcsFiT3uODUmT0I5HdLAs4d+8EtfrhGePynDr2DDwA3WGSTkhbPc1frHZu3kQdunn
         2+oK3zOOE2k3venMLXmM6HN+e3GvgA3sgLJIlv22bpsf51OvYH42VqbeeGQuMr/ZzzaC
         9UaYCflJfhv13NCIZDJOPup4U7C+mWr/PlzEDrmAX40DU2+YuHtAW2hcffICHM3EfLow
         +AJXWvd7y5gFQi0IGQljD6bR0U1D68HCe3qANz28PCXQPlq1gf/fqfAI4DLkPOG8DrRp
         oiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753806013; x=1754410813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1ocBmgZbBARpkSqcCccoaUptB5r0zaNDZZws0Lz0Pc=;
        b=Cg8wAQR21+xXKLpY95FJkT+VKYxsj9s2xDHzEsqEaIWfF2mInvXaXw4qRMVC5CWPa+
         Qxa5fOyUxzjn/iSb65jdbbtmuKvGBtPEmi/piZjz+wvBRnjb1mApG/ta+9su4VLQzocx
         nUJH5QQHUC//wYtHMX2PAAgrxvz72vWR/gfb121x3VZkBxgE7CihNjVpoxE4yjEZCd4R
         2/oPoL86MAstVGdnHtB2kx4RlaZIZLuVbsoAsaU3+n6fjNDPGCCa7SeH7hRUPjQHI3AR
         I7xg1TwNw+2xzZSJBSHAGW5eQ9yOD7GYqSsX1/755NKhdIgjXKuiQ7HSd8ieDAi5DM0n
         Ro1g==
X-Gm-Message-State: AOJu0YwTjkxs2HB/Am8ObMcevtNM6b4rImPJwBYMZZpRdSWbgxJzAASl
	RoZvtx6ZVRQ4LGN17djHUCYt9/lYXrQCnMmMc69mq6+fxK8SNkr6zgKGomY8DYuN
X-Gm-Gg: ASbGncv4jU6w/lyQ0kvmnpiNHYhSUd5dAL7cMjcb0BTNyK1Vx6MGBxBp9rO80XtkwrZ
	O2c2VYQv0EaEas5RgsMgitBgfJINTWWsMZDjFwV7kezJGVQ/WlnvX8o1MiXT0+hOV7Tj8J9sZKO
	C2SywavxccJW6LKcoUm6xirVNb1b65DwfU5IIRg9n7AzuD2vYQaX/zy3Xc+0GDzZtkFx4HCdNLe
	v1vxcYsnStP407nIGaEXvlBilJFPsC6LgXGQ1pTXGXjS1tLoRszSYwcpH9tk+bGD8OIAdIs2lhv
	Io9WxMQpG0D8goIZlqiCpkCfufvbtjEdDWHcvIy7E8HdyTUjPs/XGHQNLgrTTwS333tsAEe97JM
	NA822JSjKIKfAzmyK6KZ4d4DxRtblwTo8RaspslRYKGXr
X-Google-Smtp-Source: AGHT+IFBWbdDb3ygDpAt07yASc3LcnICYW717dIRvidk8IE1BoqKhSuwSbQxb5NRF++MrmX6fuGVoA==
X-Received: by 2002:a17:90b:1d07:b0:31e:f36a:3532 with SMTP id 98e67ed59e1d1-31f28ceb577mr6477426a91.13.1753806012337;
        Tue, 29 Jul 2025 09:20:12 -0700 (PDT)
Received: from thinku.tailbd49c4.ts.net ([103.37.201.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f2efd8b36sm1400032a91.1.2025.07.29.09.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 09:20:12 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	Ayush Chandekar <ayu.chandekar@gmail.com>
Subject: [GSOC PATCH 0/2] builtin/fmt-merge-msg: remove dependency on global variables and 'the_repository'
Date: Tue, 29 Jul 2025 21:49:33 +0530
Message-ID: <cover.1753804956.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The aim of this patch series is to remove the definition '#define USE_THE_REPOSITORY_VARIABLE'
from "builtin/fmt-merge-msg.c" by removing global variable 'merge_log_config' and the global 
'the_repository'

This patch series contains two patches:

1 - Remove the global varaible 'merge_log_config' and add a function 'adjust_shortlog_len()'
    in fmt-merge-msg.{c,h} to replicate the variable's usage.

2 - Remove the dependency of 'the_repository' in "builtin/fmt-merge-msg.c", allowing the removal
    of the definition '#define USE_THE_REPOSITORY_VARIABLE'. Also add a test to make sure that
    "git fmt-merge-msg -h" can be called with repository being NULL.

Ayush Chandekar (2):
  environment: remove the global variable 'merge_log_config'
  builtin/fmt-merge-msg: stop depending on 'the_repository'

 builtin/fmt-merge-msg.c |  9 ++++-----
 builtin/merge.c         |  4 ++--
 environment.c           |  2 --
 fmt-merge-msg.c         | 30 ++++++++++++++++++++++--------
 fmt-merge-msg.h         |  3 ++-
 t/t1517-outside-repo.sh |  7 +++++++
 6 files changed, 37 insertions(+), 18 deletions(-)

-- 
2.49.0

