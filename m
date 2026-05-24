Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6AB30C637
	for <git@vger.kernel.org>; Sun, 24 May 2026 21:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779657845; cv=none; b=pT7qSA1WkpNGcY+TTA9EQpTSOgtB0B4wf7cpjz0eJ1xr8A8PZm1GCVAW+MXAZvP82ojjzLLxZTd9maMKL8w35Nu32nb1WXn4YOy4SoVNnl4WKQA2/7vMn4hEeVNM69iQHvENNC5nN1luiyHtCfaUI16zmcJOxpZ4XcyIYuhPIdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779657845; c=relaxed/simple;
	bh=7fp/tC8CwzqaRl+y2e8VzAa8pneaHlv5bEFd6p+41Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c2o6thtX1YfvAMLMecg2iTItWM8E6AY8x2Cjw2ZnUbtiBOn7XZZZudCnDcluJuX/kljqsEhMsA51aQIyAQVsbA4tRw6rEkp1mele5VHHaiv9jjcOvL9Po7gzdo6kVgWrhMYz2kVWwSZYyodhmWqf+tqGN5K9Cn/paR5ESALJswQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+1nRbNg; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+1nRbNg"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8acb3daf2aaso163152696d6.0
        for <git@vger.kernel.org>; Sun, 24 May 2026 14:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779657843; x=1780262643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uD71lsaO3ec0W1qfoG+glM4kHV31QXV6uWz9LptJzdw=;
        b=a+1nRbNg3NfwHgrZ3HwXwOO2I8vgINAZjhBS/ZsU9/IDUgRUduZXULyevJu0XpPRFW
         TfPsKCDJQzumn/YWiC/BNSey60S+zrbUoD61OWqXcx+GMCmzrGyz1WnaDvEuROs75CaJ
         7X0zyR/TQaOcuXklyEws+UwaS7Xn1ImVw3bs+PhdCVqhVqG/AsHA/LoEkumT8MuVbTGv
         ZWR+x0Z/zlPoHFUuA56DU+KazuZa/k5r7I5EcEDUH5Eiun9rs0aQbAKpn78fxCaAZ2Ro
         A8YGI3YoELXJDiD75MiMUz2qososw0TWeD4Q3sRELo6ByP5R6iuS5Dmw+1Vmqv+ZEKAf
         uPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779657843; x=1780262643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uD71lsaO3ec0W1qfoG+glM4kHV31QXV6uWz9LptJzdw=;
        b=oZSDPcC1vHfAKVn8tOr1txGVmD5RcSOmneTXEA0SgkWtjsPZ/rTUOGbPONTTRcchqP
         +5DCGE/9By8cn7qsgB+s67X5GKyUe7p7QCttbz3dPjNT8wqdKkiQ8c50EEBfGN0+jurJ
         jpEqCyWtSRnuzTph3N5NoBYXYOqXYX1wZHe+nVSTtjsysfV4bN51VY1BVEB3hLiTCkdT
         ijnLauvOirgh1rlalDaQMb9zDvA2EOLC+NI4ImVcbuuQg6goqQn5TDrK1kmnzyagQYWZ
         QKDJ7zYENaUaTH6RFoI+cliKv5vNEsQNK6r+Vd21gcd84qWB1k4R5vt0pz24mF3KANQB
         /X5g==
X-Gm-Message-State: AOJu0YyagO7HlxtydOa/zlbfhACAZRxWDoR+Uj9NZz6GEuKgT2gqx0UV
	8vFPqGaIxszS+JGWVGNdn2x58CH9pvJ9ieQ6MQx1cO06rIngPa3sSy2ykQ6dBg==
X-Gm-Gg: Acq92OFmuVMY66NkIIh87nyorLhV+YGtpJZX0F7MpVa3vIWUHVcX45koQf8DbzMU/KJ
	0ZSwsbxKp2BqAjyKC3xLcw5RlbRJ5MQ4KXC/aA05C9/vzQR0Ny9nsJDFK52+6xppzNNZ72ZJudk
	/BHPeglx1F0j/Kg6VzndUVOG/fds55V5FcsxjtGKTLlUnudCXAidGT3MT0Oau3zzf0Oxzmzwoum
	Ro7NlN1H30ltu8KXmAUg4L2R2EGojt+EoM8epv9wUcCdEX66RGFDYOIUL4cWmyxp2cF6/GV3w0k
	58H18UZtK1ZH/sKgFAawk0Lejh5WC8qM9hjAmyeRI69cjOHVbCwHdbmsPajrmAigUXKx0Sl3XPL
	dZrKv2voVgNLRvZ0m1BLzfeufYgiPyn+qaDVlazsmC1qJj8BxFhXVc2ADllBqmRAUa0ukhHnO4U
	8f9E07Bk7Ewo+YqGVZUvhSVzGia1qD7vjPTlwZEyFdZkut8yJud5xfzuRPvvASx+ctorpKwrEWw
	uYh7BaJkml0qv8HKw==
X-Received: by 2002:a05:6214:1d06:b0:8c2:bbef:cccc with SMTP id 6a1803df08f44-8cc7b674298mr208018956d6.31.1779657843437;
        Sun, 24 May 2026 14:24:03 -0700 (PDT)
Received: from roly-chicago-24.localdomain (pool-72-68-140-49.nycmny.fios.verizon.net. [72.68.140.49])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80dcd813sm93270946d6.10.2026.05.24.14.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 14:24:02 -0700 (PDT)
From: Roland Conybeare <rconybeare@gmail.com>
To: git@vger.kernel.org
Cc: Roland Conybeare <rconybeare@gmail.com>
Subject: [PATCH 0/1] bugfix git subtree split
Date: Sun, 24 May 2026 17:23:38 -0400
Message-ID: <20260524212339.1493145-1-rconybeare@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I have a project that combines multiple independent repos
into an unmbrella repo, relying on git subtree.
Encountered a unrecoverable fatal error
from 'git subtree split' with error

    fatal: cache for <hash> already exists!

Problem arises because history to be split contains merge commits
that cause DAG traversal to consider the same umbrella commit on
multiple paths. The fatal triggers when 'git subtree split' tries
to cache the same commit twice; enclosed patch prunes these duplicate
paths.

Roland Conybeare (1):
  subtree: fix cache_set failure on commit reachable by multiple paths

 contrib/subtree/git-subtree.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)


base-commit: 6a4418c36d6bad69a599044b3cf49dcbd049cb45
--
2.50.1
