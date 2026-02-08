Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359E83451CF
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 06:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770532203; cv=none; b=jrWRpWZAEc6l36/RvuMdxMlYxFrDnmI+P/q7c5KqfO4LL9bb/A1DMT2D52LhTyh99kAaWQLXCeHG7MZCCFvyTcqfowWO1urNVEOIkblbGDVRqAWraJukuSSSnZVBt7QJeUKok5MN8ID4dZqzP0ZNx84AvFyDIrg5R8FAs3mq+rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770532203; c=relaxed/simple;
	bh=ORIIAYXUPFn15UtPN26Ub4OllA6uw2dWnyDTdsXHwmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TdV9KS0GIvJR5mcBkUKlcralXUuJKBiljcmJIBK/6c4bKiJMl2rxkGuqmGAaz2RGNsA6jFI5bCZpPVwZznMBDcXFt6d5Yg9aPA3+1F9k9ihcYTV8aWA02jpZo15ObXcuBjPeFSQiY2YgiGzx+TjFielseySRB8MZ8xo05MvGPww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Odsdze+I; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Odsdze+I"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-81ed3e6b8e3so935769b3a.2
        for <git@vger.kernel.org>; Sat, 07 Feb 2026 22:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770532202; x=1771137002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dbciaGPInrlfJ3xwL9BqnYbcxinjrbUV/37JyTEGnc0=;
        b=Odsdze+Ic/INnFGzqmQzxFtq/yldWx8g7Timcm1MXYAm3HI52L49eSa9ny5+qpeJ4A
         kLheYvf4+rDU4HgL2oFEbB8nqBPdfKdgTSDbkfYeILJyyY6Uw+Fzlzt43F4aYS8JoDld
         qNnp3kGksKxZ1HlHk/Da7ZZSHTpyu7p8HpxOwprbA1nS48lwgBcnQlTthkbpi5BWjqTH
         m/P+nLkwYnI4SQ+3OqqYQzSXtwHUVtAfOhl7/x/EWfl74NQOuKefHO2H29vT9HcOWQih
         YplblOhpKvVle0ZEEfyFmHWIWrw5P7exahRftnlR/J19LVlEsef5i+v4rLQNqnCnM5GD
         AJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770532202; x=1771137002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbciaGPInrlfJ3xwL9BqnYbcxinjrbUV/37JyTEGnc0=;
        b=qTBEb2RTt9MlWk9zdKcoE1mdCcYxmFZC8CXDS3mnm4xPXzZwFu351X+7YynoF6s+ZO
         JNcX2+QgKudN5UROymIam7QiV9xsyZpe3ytWvfX6RDsWWsw2HqllJRQxLI5p9hH94Eyt
         YF88T6TOS/Hglo4l7dQPAoTyH4rqsl5d1uhAKg0Hc/ozeveGLjoG0xvx72Iw8oqL4Dtt
         FKHi4CUltp4QGr0xaiVYAbHoXDnYS3wfd3QLhBF9Oayt0Hp5lxba2HS2XvR4G/qccLET
         YcRNRovELMICXtwd1GPqCJrL78HPOS+k+gvfm3vIf6fyls3CSbBfsnLTE/p655w0ewG0
         mQOQ==
X-Gm-Message-State: AOJu0YxNVOOkPjpXHKdf8XevispoyaEWR1WoMgQFu4v02CQ+i79vr27T
	pQRqSa6JphYf8VyOvSej4I0fMJjS6ioKdSfUVNpaXF+hejqm/YwhhD3aKnOynGMg
X-Gm-Gg: AZuq6aJLGcFg658vdmFdwfzgnJlXBmxZo/nj9Nq3osEuZegVHyFgNZbJwu8NeyUJZ95
	h/3SfklJJ6t60VP9o1LWnBppqYTrfXbXc5QLfk3Xm1ldAB/yzzCbfwnDd2WWVev6RoDiobolgit
	JxwCEje1PNf+a84WgxUUkH/c+At8DQX80g/e/bZ2v17uXaulgQfK5bSWi0dy74DveF20QVcRhrk
	qIPPQgpneMf6Y/FYuGyx5KkdxZWwPZxgx7SjM4fWHzYVkLbQangJJxiMWhEbgeYYCmoIQgNjljO
	q1OID2LQzeEWAgwJXsOOLsWs//0UA9XP21czwasVTIGsyQQaiCAt4ZDgPnz3SaDIw+MkNkdlctC
	+BO/es/xR9IWjwayCUdZZEOPMcMre/OWqvenwppkWGuQESIqXeE47KSFc5uDbGlW0VwQRFDau0U
	ia+Qxdp+5SfMCPho6Z2l7AR2c=
X-Received: by 2002:a05:6a20:4393:b0:38d:ebdc:3546 with SMTP id adf61e73a8af0-393acf58334mr7428231637.6.1770532201755;
        Sat, 07 Feb 2026 22:30:01 -0800 (PST)
Received: from AyushJha ([2409:40e5:17:59e2:f829:c37f:f39b:93ee])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c9746esm70489905ad.39.2026.02.07.22.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 22:30:01 -0800 (PST)
From: Ayush Jha <kumarayushjha123@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
	Ayush Jha <kumarayushjha123@gmail.com>
Subject: [RFC GSoC PATCH v3 0/2] Make read_attr() repository-aware by introducing a lazy bare state
Date: Sun,  8 Feb 2026 11:59:47 +0530
Message-ID: <20260208062949.596-1-kumarayushjha123@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series is v3 of an earlier RFC that aimed to remove the
dependency on the global `the_repository` from read_attr().

Based on feedback from Lucas Seiki Oshiro and Junio C Hamano, this
iteration introduces a repository-scoped, lazily initialized "bare"
state in struct repo_settings, exposed via repo_settings_get_is_bare().
The read_attr() function is then updated to use this helper instead of
is_bare_repository().

The series is split as follows:
  1/2 repo-settings: add repo_settings_get_is_bare
  2/2 attr: use local repository state in read_attr

Comments and suggestions are welcome.

Ayush Jha (2):
  repo-settings: add repo_settings_get_is_bare
  attr: use local repository state in read_attr

 attr.c          |  3 ++-
 repo-settings.c | 12 ++++++++++++
 repo-settings.h |  5 +++++
 3 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.53.0.windows.1

