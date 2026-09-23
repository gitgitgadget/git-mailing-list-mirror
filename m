Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDA84ACC8F
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790183429; cv=none; b=qsSR6DS86rqzDPsuu3+4vk3Rzk5j90rCD8hub20wJXCF/tymNJ0jk/5EWxGb5qom4g7Aj7WmsD7gpTedW7hsIKZ77NGTK5PItzyLOjOAX7gAhZbHCwDF+TozAVeq0bV7p2TalvF4V7Cs0zfWzCA6E+qpxuNFA13bywZQUeovs8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790183429; c=relaxed/simple;
	bh=bunPtcoPQMtCJzCIR626OrBI3YfJFTYGa1B6hvAuXUE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y1rk8dbCm6GP7mSeYzqesm06V8QiwoDzCXyiIxADTNJMXYuOsNvbj9dObJ5W945qVfivYuHApQDsNDL+igfhAQBnwCOTDtMkw/en87xD2xVDV4fos3i2fIbNwrXvZTY5nA95Y996/G+cyLz60QCsvZiIwm1ewhR4OgwfTGzrH08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSBSxVra; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSBSxVra"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7f4df360cc9so80840a34.1
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 10:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790183426; x=1790788226; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=82+NEvmukOOLWIVmWYhEn83CfWVj7pNX4c6aKWzPLHg=;
        b=KSBSxVraq1hI0z6ZDD3ZtUEHWI603F6xQ3uejhnf8LWvzuEKtjAqfbtSnSUMnCSiu6
         qZQ89KANAzete3+QYvSrb+hpXWSX4xlBXyGJc8bV+AshO1WkWGGY/TmOQ5Z9Q1uZEDTk
         5Ir7umCPb9Ja8dekL8lkTjHLaRo2UB/NgiBF4baufrIuOWklQpizU/tod6w8uTvpHMrX
         2F6bM0W1C/v/K1C3V27wB2ZVnUX6oNtlO6ApQZuDcyYVX+hmqFc7iR7c8/ed9A9O3Xwe
         Zhd4m0OKdQPXHZyoxsE51nPIb5md229l+QGw5Nz5anVSiVz0weRULiVItXfbsQdefJoM
         YJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790183426; x=1790788226;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=82+NEvmukOOLWIVmWYhEn83CfWVj7pNX4c6aKWzPLHg=;
        b=aAN8CZ9fM6pImLVUuF4JGTj9/V7OzBKgtllho4550Q8SmQB0v27hLoMCgwrrpmiwtH
         FU6d+xyxKxqYqy7s5bXoTP5j4QLBgN1e7D1QARoEwWVi2olTdqdP5O0OBzDkt+WcWcEH
         wi+5EkjdZlYVh8G0+SaS5yeTyiCvpSw4cbx5LwXaw2wfMA4VOtj4H8DJoJPX5iYcbapp
         02RpX+Ixh5ca1HQTjC/edqP8csUhfqf7ALBZeC0G738PVZBgTBw6tzdAo5FaJnXxcG5x
         Mw+6mSsfTnOAy7iRJ4o+RWIryUWC+k7GVssizN0gfsP1V1Ti/wD20BbN9Fg4QH6oYrYA
         tPAg==
X-Gm-Message-State: AFuF++m5EKNrlJI3F9oT/gDxphesgprXD9YhuuDc817+r5HiddO7ElmM
	igbo66U0DqQpRdziP9NTTKuGVApnJW2GSZZL5nzzqL7RrLzZVM4hieHs
X-Gm-Gg: AYBFou1vPXr9Xd3Xu01g3LgmJsBNAIlLsvhmkq0c28zXW6po0dn0McyJBXpMHk8+aMm
	3UovLKicyYVi2Cg+lcTyfHUNNJp8sHiGNFZFIqU0PrYx9dWGCgXOs9uJiNvVcLzFiU2FzhBtcbT
	bveYeE4oKYgJU7Ta6q9/zYB7OoOD+VcdeQByOYK2moGd24+qRNujvI0+07MgdReLh1pcMyXJmEJ
	PpHUT1k5D25edoN8tdaYi6D+x0lDRgngxhvogqU7ML/+hriDLxx2R+gspR9Rlxv3ZA3VmYcQ7p+
	az3KVKvpe/k9BtnExva9ouOApL3LBqWIOU59N54kCFEh1PWONoZQZ2TghNOQ35walSof4tiJ2WB
	kDpDCWDvAI+mvGrClQjeWTHrtQE0NZtdkiirQgquEWb7ADqDUEtgyJ2pMQKdfDk6Yxi2AxV5I2g
	qHDwKdQ4YnGJ5PyUd6Vk+Y166eu9Z14ZSP40d8td1R3YuJhIx9bnP4/NNXONqJWIt+Mir2+P+yf
	gUZKDfHSGF/4o8fQ261mPWf0oNuRnDyOi7hJnqWqtcEmL1nqlv8oBkgfZFgcg8F/Iad2wPYAYpO
	YrdxE4NpIQJVwbvUd/rz/aPpUf+6+nolZIXpZyW2bp78S5J1jDbvnJugT99nOAzv8u93NJBqcdZ
	caSa69bn5Awh3JbETjnrZAezrnXXvTZiazlJLSJkUemaQSSv5iPIVNKBq4S4=
X-Received: by 2002:a9d:7342:0:b0:816:3195:be1e with SMTP id 46e09a7af769-8163195cd09mr1823493a34.23.1790183425909;
        Wed, 23 Sep 2026 10:10:25 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-816049b7b15sm3470670a34.24.2026.09.23.10.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 10:10:24 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH 0/2] ls-files: reuse the untracked cache
Date: Wed, 23 Sep 2026 13:10:07 -0400
Message-Id: <20260923-ls-files-untracked-cache-v1-0-08db4cc1efdb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBG4auUWTuQJlSoVxEX6eSvHS1RMq0Ip
 Xc36vJbvLeRoSiMTs1GBS81feSK9tCQTDFfwZqqyTt/dL0PPBuPOsN4zUuJckdiiTKBQ9f1A5J
 rYwDV/Fkw6vu3Pl/+tnW4QZbvj/b9A86sbKh8AAAA
X-Change-ID: 20260923-ls-files-untracked-cache-3559bed01a3e
To: git@vger.kernel.org
Cc: Tao Klerks <tao@klerks.biz>, Junio C Hamano <gitster@pobox.com>, 
 Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.17-dev

Repeated queries such as

  git ls-files --cached --others --exclude-standard -z -- "**/pyproject.toml"

walk the working tree even when status has already populated an untracked
cache. This series lets ls-files reuse those directory listings. It
expands partial scans and collapsed untracked directories as needed,
without writing the converted cache back to the index.

The first patch fixes inconsistent ignore-file hashes that invalidate an
unchanged cache. The second enables reuse for ls-files and filters complete
listings after the walk. Fixed-prefix queries retain directory pruning;
attribute and exclude pathspecs retain their existing traversal because
matching a directory can differ from matching its children.

On macOS, a synthetic tree with 100,000 tracked files in 5,000 directories
and a few untracked files averaged 361 ms before and 50 ms after in five
hyperfine runs after one warmup. Directory opens fell from 5,058 to seven.
With half the files untracked, five alternating runs averaged 659 ms
before and 339 ms after; that case still expands 2,533 partially cached
directories. A cache populated with status.showUntrackedFiles=all avoids
directory opens in both cases. These measurements disable fsmonitor and
use a populated cache with a warm filesystem.

Uncached controls were noisy; the apparent slowdown in the first batch
did not recur. Literal-query results varied in both directions, with a
separate five-run hyperfine check measuring 17 ms before and 20 ms after.

Prepared with Codex, including code review and benchmark work by separate
Codex agents.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Tamir Duberstein (2):
      dir: hash ignore files before adding parser LF
      ls-files: reuse cached untracked listings

 builtin/ls-files.c                | 11 +++++--
 dir.c                             | 64 +++++++++++++++++++++++++++++++++---
 dir.h                             |  2 ++
 t/perf/p3010-ls-files.sh          | 15 +++++++++
 t/t7063-status-untracked-cache.sh | 68 ++++++++++++++++++++++++++++++++++++---
 5 files changed, 149 insertions(+), 11 deletions(-)


---
base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
change-id: 20260923-ls-files-untracked-cache-3559bed01a3e

